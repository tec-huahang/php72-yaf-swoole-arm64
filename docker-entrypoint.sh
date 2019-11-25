#!/bin/sh
set -e

if [ ! -z $YAF_ENVIRON ]; then
	sed -i "s#^yaf\.environ=.*#yaf\.environ=${YAF_ENVIRON}#g" /usr/local/etc/php/conf.d/yaf.ini
fi
if [ ! -z $YAF_LIBRARY ]; then
	sed -i "s#^yaf\.library=.*#yaf\.library=${YAF_LIBRARY}#g" /usr/local/etc/php/conf.d/yaf.ini
fi
if [ ! -z $YAF_CACHE_CONFIG ]; then
	sed -i "s#^yaf\.cache_config=.*#yaf\.cache_config=${YAF_CACHE_CONFIG}#g" /usr/local/etc/php/conf.d/yaf.ini
fi
if [ ! -z $YAF_NAME_SUFFIX ]; then
	sed -i "s#^yaf\.name_suffix=.*#yaf\.name_suffix=${YAF_NAME_SUFFIX}#g" /usr/local/etc/php/conf.d/yaf.ini
fi
if [ ! -z $YAF_NAME_SEPARATOR ]; then
	sed -i "s#^yaf\.name_separator=.*#yaf\.name_separator=${YAF_NAME_SEPARATOR}#g" /usr/local/etc/php/conf.d/yaf.ini
fi
if [ ! -z $YAF_FORWARD_LIMIT ]; then
	sed -i "s#^yaf\.forward_limit=.*#yaf\.forward_limit=${YAF_FORWARD_LIMIT}#g" /usr/local/etc/php/conf.d/yaf.ini
fi
if [ ! -z $YAF_USE_NAMESPACE ]; then
	sed -i "s#^yaf\.use_namespace=.*#yaf\.use_namespace=${YAF_USE_NAMESPACE}#g" /usr/local/etc/php/conf.d/yaf.ini
fi
if [ ! -z $YAF_USE_SPL_AUTOLOAD ]; then
	sed -i "s#^yaf\.use_spl_autoload=.*#yaf\.use_spl_autoload=${YAF_USE_SPL_AUTOLOAD}#g" /usr/local/etc/php/conf.d/yaf.ini
fi

if [ ! -f /xdebug_configured ]; then
	if [ -z $XDEBUG_ENABLE ]; then
		XDEBUG_ENABLE="On" 
	fi
	if [ -z $DOCKER_HOST_IP ]; then
		DOCKER_HOST_IP="10.240.41.3"
	fi
	if [ -z $XDEBUG_PORT ]; then
		XDEBUG_PORT=9001
	fi
	if [ -z $IDEKEY ]; then
		IDEKEY="PHPSTORM"
	fi
    echo "=> Xdebug is not configured yet, configuring Xdebug ..."
	echo "zend_extension=xdebug.so" >> /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.remote_enable=$XDEBUG_ENABLE" >> /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.remote_host=$DOCKER_HOST_IP" >> /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.remote_port=$XDEBUG_PORT" >> /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.remote_connect_back=On" >> /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini
	echo "xdebug.remote_autostart=On" >> /usr/local/etc/php/conf.d/xdebug.ini
	echo "xdebug.profiler_enable=On" >> /usr/local/etc/php/conf.d/xdebug.ini
	echo "xdebug.idekey=$IDEKEY" >> /usr/local/etc/php/conf.d/xdebug.ini
	
    touch /xdebug_configured
else
    echo "=> Xdebug is already configured"
fi

php-fpm
