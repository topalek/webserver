#!/bin/sh

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
SIGNATURE=$(php -r "echo hash_file('sha384', 'composer-setup.php');")
EXPEXTED_SIGNATURE=$(wget -q -O - https://getcomposer.github.io/installer.sig)
if ["$EXPEXTED_SIGNATURE" != "$SIGNATURE"]
then
    echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi
php composer-setup.php --quiet --install-dir=/usr/local/bin/ --filename=composer
RESULT=$?
rm composer-setup.php
exit $RESULT