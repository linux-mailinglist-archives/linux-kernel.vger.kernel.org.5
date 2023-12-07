Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8A807E25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjLGB5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjLGB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:57:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F5B9;
        Wed,  6 Dec 2023 17:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701914259;
        bh=O2bd38ZS6sUo+MnAkS9tKJm8ZvI5G9mB+gEY01EyXe4=;
        h=Date:From:To:Cc:Subject:From;
        b=tqzZRr593eK6JkYt7f7z8QubrYFmVBVX8Rhhk0TBJ3vtZOupEt97nOPFfQoLPn2lz
         EF6aGYB1InSUPTR7fg7OeZgSmBaq/W8Jjl2dXB8+bhh9aEmzRQLYc+sZ0oSYyXMJ0p
         QTeT7xtk5oKmyUbi18NkAhMh29wzfzG6hBAaGTtTtBelRJlBIaZlfc/u6gWI9FnVNM
         HXHnWn9kTgooAH9NeFgm18JOqVXwbFYP0IAee3qu20w/ono1CLccjGZrSD2qs6UOGL
         uVI54HC1oUnuWX9vOzz613I3DA/v7QAgOJgWcy4lH9ntUrsQLjUhY4DcSqgrGllcO2
         TuFt/yffOzWMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sly8M2Hlhz4wb2;
        Thu,  7 Dec 2023 12:57:39 +1100 (AEDT)
Date:   Thu, 7 Dec 2023 12:57:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the devicetree tree
Message-ID: <20231207125737.5e7553e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KBt8BQmPN__+AbfEYtqUh4z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KBt8BQmPN__+AbfEYtqUh4z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devicetree tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/auxdisplay/img-ascii-lcd.c: In function 'img_ascii_lcd_probe':
drivers/auxdisplay/img-ascii-lcd.c:234:17: error: implicit declaration of f=
unction 'of_match_device'; did you mean 'of_match_node'? [-Werror=3Dimplici=
t-function-declaration]
  234 |         match =3D of_match_device(img_ascii_lcd_matches, dev);
      |                 ^~~~~~~~~~~~~~~
      |                 of_match_node
drivers/auxdisplay/img-ascii-lcd.c:234:15: warning: assignment to 'const st=
ruct of_device_id *' from 'int' makes pointer from integer without a cast [=
-Wint-conversion]
  234 |         match =3D of_match_device(img_ascii_lcd_matches, dev);
      |               ^
drivers/firmware/microchip/mpfs-auto-update.c:439:42: warning: 'struct plat=
form_device' declared inside parameter list will not be visible outside of =
this definition or declaration
  439 | static int mpfs_auto_update_probe(struct platform_device *pdev)
      |                                          ^~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c: In function 'mpfs_auto_updat=
e_probe':
drivers/firmware/microchip/mpfs-auto-update.c:441:35: error: invalid use of=
 undefined type 'struct platform_device'
  441 |         struct device *dev =3D &pdev->dev;
      |                                   ^~
drivers/firmware/microchip/mpfs-auto-update.c:456:9: error: implicit declar=
ation of function 'platform_set_drvdata' [-Werror=3Dimplicit-function-decla=
ration]
  456 |         platform_set_drvdata(pdev, priv);
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c: At top level:
drivers/firmware/microchip/mpfs-auto-update.c:476:44: warning: 'struct plat=
form_device' declared inside parameter list will not be visible outside of =
this definition or declaration
  476 | static void mpfs_auto_update_remove(struct platform_device *pdev)
      |                                            ^~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c: In function 'mpfs_auto_updat=
e_remove':
drivers/firmware/microchip/mpfs-auto-update.c:478:46: error: implicit decla=
ration of function 'platform_get_drvdata' [-Werror=3Dimplicit-function-decl=
aration]
  478 |         struct mpfs_auto_update_priv *priv =3D platform_get_drvdata=
(pdev);
      |                                              ^~~~~~~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c:478:46: warning: initializati=
on of 'struct mpfs_auto_update_priv *' from 'int' makes pointer from intege=
r without a cast [-Wint-conversion]
drivers/firmware/microchip/mpfs-auto-update.c: At top level:
drivers/firmware/microchip/mpfs-auto-update.c:483:15: error: variable 'mpfs=
_auto_update_driver' has initializer but incomplete type
  483 | static struct platform_driver mpfs_auto_update_driver =3D {
      |               ^~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c:484:10: error: 'struct platfo=
rm_driver' has no member named 'driver'
  484 |         .driver =3D {
      |          ^~~~~~
drivers/firmware/microchip/mpfs-auto-update.c:484:19: error: extra brace gr=
oup at end of initializer
  484 |         .driver =3D {
      |                   ^
drivers/firmware/microchip/mpfs-auto-update.c:484:19: note: (near initializ=
ation for 'mpfs_auto_update_driver')
drivers/firmware/microchip/mpfs-auto-update.c:484:19: warning: excess eleme=
nts in struct initializer
drivers/firmware/microchip/mpfs-auto-update.c:484:19: note: (near initializ=
ation for 'mpfs_auto_update_driver')
drivers/firmware/microchip/mpfs-auto-update.c:487:10: error: 'struct platfo=
rm_driver' has no member named 'probe'
  487 |         .probe =3D mpfs_auto_update_probe,
      |          ^~~~~
drivers/firmware/microchip/mpfs-auto-update.c:487:18: warning: excess eleme=
nts in struct initializer
  487 |         .probe =3D mpfs_auto_update_probe,
      |                  ^~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c:487:18: note: (near initializ=
ation for 'mpfs_auto_update_driver')
drivers/firmware/microchip/mpfs-auto-update.c:488:10: error: 'struct platfo=
rm_driver' has no member named 'remove_new'
  488 |         .remove_new =3D mpfs_auto_update_remove,
      |          ^~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c:488:23: warning: excess eleme=
nts in struct initializer
  488 |         .remove_new =3D mpfs_auto_update_remove,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c:488:23: note: (near initializ=
ation for 'mpfs_auto_update_driver')
drivers/firmware/microchip/mpfs-auto-update.c:490:1: warning: data definiti=
on has no type or storage class
  490 | module_platform_driver(mpfs_auto_update_driver);
      | ^~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c:490:1: error: type defaults t=
o 'int' in declaration of 'module_platform_driver' [-Werror=3Dimplicit-int]
drivers/firmware/microchip/mpfs-auto-update.c:490:1: warning: parameter nam=
es (without types) in function declaration
drivers/firmware/microchip/mpfs-auto-update.c:483:31: error: storage size o=
f 'mpfs_auto_update_driver' isn't known
  483 | static struct platform_driver mpfs_auto_update_driver =3D {
      |                               ^~~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/microchip/mpfs-auto-update.c:483:31: warning: 'mpfs_auto_u=
pdate_driver' defined but not used [-Wunused-variable]
drivers/gpu/drm/bridge/aux-hpd-bridge.c: In function 'drm_aux_hpd_bridge_re=
lease':
drivers/gpu/drm/bridge/aux-hpd-bridge.c:27:9: error: implicit declaration o=
f function 'of_node_put' [-Werror=3Dimplicit-function-declaration]
   27 |         of_node_put(adev->dev.platform_data);
      |         ^~~~~~~~~~~
drivers/tty/serial/esp32_acm.c:367:37: warning: 'struct platform_device' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
  367 | static int esp32s3_acm_probe(struct platform_device *pdev)
      |                                     ^~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c: In function 'esp32s3_acm_probe':
drivers/tty/serial/esp32_acm.c:369:38: error: invalid use of undefined type=
 'struct platform_device'
  369 |         struct device_node *np =3D pdev->dev.of_node;
      |                                      ^~
drivers/tty/serial/esp32_acm.c:374:34: error: invalid use of undefined type=
 'struct platform_device'
  374 |         port =3D devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL=
);
      |                                  ^~
In file included from include/linux/device.h:15,
                 from include/linux/cdev.h:8,
                 from include/linux/tty_driver.h:9,
                 from include/linux/tty.h:10,
                 from include/linux/serial_core.h:17,
                 from drivers/tty/serial/esp32_acm.c:12:
drivers/tty/serial/esp32_acm.c:380:30: error: invalid use of undefined type=
 'struct platform_device'
  380 |                 dev_err(&pdev->dev, "failed to get alias id, errno =
%d\n", ret);
      |                              ^~
include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                         ^~~
drivers/tty/serial/esp32_acm.c:380:17: note: in expansion of macro 'dev_err'
  380 |                 dev_err(&pdev->dev, "failed to get alias id, errno =
%d\n", ret);
      |                 ^~~~~~~
drivers/tty/serial/esp32_acm.c:384:30: error: invalid use of undefined type=
 'struct platform_device'
  384 |                 dev_err(&pdev->dev, "driver limited to %d serial po=
rts\n",
      |                              ^~
include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                         ^~~
drivers/tty/serial/esp32_acm.c:384:17: note: in expansion of macro 'dev_err'
  384 |                 dev_err(&pdev->dev, "driver limited to %d serial po=
rts\n",
      |                 ^~~~~~~
drivers/tty/serial/esp32_acm.c:391:15: error: implicit declaration of funct=
ion 'platform_get_resource' [-Werror=3Dimplicit-function-declaration]
  391 |         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
      |               ^~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c:391:13: warning: assignment to 'struct resou=
rce *' from 'int' makes pointer from integer without a cast [-Wint-conversi=
on]
  391 |         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
      |             ^
drivers/tty/serial/esp32_acm.c:396:52: error: invalid use of undefined type=
 'struct platform_device'
  396 |         port->membase =3D devm_ioremap_resource(&pdev->dev, res);
      |                                                    ^~
drivers/tty/serial/esp32_acm.c:400:26: error: invalid use of undefined type=
 'struct platform_device'
  400 |         port->dev =3D &pdev->dev;
      |                          ^~
drivers/tty/serial/esp32_acm.c:403:21: error: implicit declaration of funct=
ion 'platform_get_irq'; did you mean 'platform_notify'? [-Werror=3Dimplicit=
-function-declaration]
  403 |         port->irq =3D platform_get_irq(pdev, 0);
      |                     ^~~~~~~~~~~~~~~~
      |                     platform_notify
drivers/tty/serial/esp32_acm.c:411:9: error: implicit declaration of functi=
on 'platform_set_drvdata' [-Werror=3Dimplicit-function-declaration]
  411 |         platform_set_drvdata(pdev, port);
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c: At top level:
drivers/tty/serial/esp32_acm.c:416:38: warning: 'struct platform_device' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
  416 | static int esp32s3_acm_remove(struct platform_device *pdev)
      |                                      ^~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c: In function 'esp32s3_acm_remove':
drivers/tty/serial/esp32_acm.c:418:34: error: implicit declaration of funct=
ion 'platform_get_drvdata' [-Werror=3Dimplicit-function-declaration]
  418 |         struct uart_port *port =3D platform_get_drvdata(pdev);
      |                                  ^~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c:418:34: warning: initialization of 'struct u=
art_port *' from 'int' makes pointer from integer without a cast [-Wint-con=
version]
drivers/tty/serial/esp32_acm.c: At top level:
drivers/tty/serial/esp32_acm.c:425:15: error: variable 'esp32s3_acm_driver'=
 has initializer but incomplete type
  425 | static struct platform_driver esp32s3_acm_driver =3D {
      |               ^~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c:426:10: error: 'struct platform_driver' has =
no member named 'probe'
  426 |         .probe          =3D esp32s3_acm_probe,
      |          ^~~~~
drivers/tty/serial/esp32_acm.c:426:27: warning: excess elements in struct i=
nitializer
  426 |         .probe          =3D esp32s3_acm_probe,
      |                           ^~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c:426:27: note: (near initialization for 'esp3=
2s3_acm_driver')
drivers/tty/serial/esp32_acm.c:427:10: error: 'struct platform_driver' has =
no member named 'remove'
  427 |         .remove         =3D esp32s3_acm_remove,
      |          ^~~~~~
drivers/tty/serial/esp32_acm.c:427:27: warning: excess elements in struct i=
nitializer
  427 |         .remove         =3D esp32s3_acm_remove,
      |                           ^~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c:427:27: note: (near initialization for 'esp3=
2s3_acm_driver')
drivers/tty/serial/esp32_acm.c:428:10: error: 'struct platform_driver' has =
no member named 'driver'
  428 |         .driver         =3D {
      |          ^~~~~~
drivers/tty/serial/esp32_acm.c:428:27: error: extra brace group at end of i=
nitializer
  428 |         .driver         =3D {
      |                           ^
drivers/tty/serial/esp32_acm.c:428:27: note: (near initialization for 'esp3=
2s3_acm_driver')
drivers/tty/serial/esp32_acm.c:428:27: warning: excess elements in struct i=
nitializer
drivers/tty/serial/esp32_acm.c:428:27: note: (near initialization for 'esp3=
2s3_acm_driver')
drivers/tty/serial/esp32_acm.c: In function 'esp32s3_acm_init':
drivers/tty/serial/esp32_acm.c:442:15: error: implicit declaration of funct=
ion 'platform_driver_register' [-Werror=3Dimplicit-function-declaration]
  442 |         ret =3D platform_driver_register(&esp32s3_acm_driver);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_acm.c: In function 'esp32s3_acm_exit':
drivers/tty/serial/esp32_acm.c:451:9: error: implicit declaration of functi=
on 'platform_driver_unregister'; did you mean 'driver_unregister'? [-Werror=
=3Dimplicit-function-declaration]
  451 |         platform_driver_unregister(&esp32s3_acm_driver);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |         driver_unregister
drivers/tty/serial/esp32_acm.c: At top level:
drivers/tty/serial/esp32_acm.c:425:31: error: storage size of 'esp32s3_acm_=
driver' isn't known
  425 | static struct platform_driver esp32s3_acm_driver =3D {
      |                               ^~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c:678:36: warning: 'struct platform_device' d=
eclared inside parameter list will not be visible outside of this definitio=
n or declaration
  678 | static int esp32_uart_probe(struct platform_device *pdev)
      |                                    ^~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c: In function 'esp32_uart_probe':
drivers/tty/serial/esp32_uart.c:680:38: error: invalid use of undefined typ=
e 'struct platform_device'
  680 |         struct device_node *np =3D pdev->dev.of_node;
      |                                      ^~
drivers/tty/serial/esp32_uart.c:687:57: error: invalid use of undefined typ=
e 'struct platform_device'
  687 |         match =3D of_match_device(esp32_uart_dt_ids, &pdev->dev);
      |                                                         ^~
drivers/tty/serial/esp32_uart.c:691:35: error: invalid use of undefined typ=
e 'struct platform_device'
  691 |         sport =3D devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERN=
EL);
      |                                   ^~
In file included from include/linux/device.h:15,
                 from include/linux/cdev.h:8,
                 from include/linux/tty_driver.h:9,
                 from include/linux/tty.h:10,
                 from include/linux/serial_core.h:17,
                 from drivers/tty/serial/esp32_uart.c:13:
drivers/tty/serial/esp32_uart.c:699:30: error: invalid use of undefined typ=
e 'struct platform_device'
  699 |                 dev_err(&pdev->dev, "failed to get alias id, errno =
%d\n", ret);
      |                              ^~
include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                         ^~~
drivers/tty/serial/esp32_uart.c:699:17: note: in expansion of macro 'dev_er=
r'
  699 |                 dev_err(&pdev->dev, "failed to get alias id, errno =
%d\n", ret);
      |                 ^~~~~~~
drivers/tty/serial/esp32_uart.c:703:30: error: invalid use of undefined typ=
e 'struct platform_device'
  703 |                 dev_err(&pdev->dev, "driver limited to %d serial po=
rts\n", UART_NR);
      |                              ^~
include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                         ^~~
drivers/tty/serial/esp32_uart.c:703:17: note: in expansion of macro 'dev_er=
r'
  703 |                 dev_err(&pdev->dev, "driver limited to %d serial po=
rts\n", UART_NR);
      |                 ^~~~~~~
drivers/tty/serial/esp32_uart.c:709:15: error: implicit declaration of func=
tion 'platform_get_resource' [-Werror=3Dimplicit-function-declaration]
  709 |         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
      |               ^~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c:709:13: warning: assignment to 'struct reso=
urce *' from 'int' makes pointer from integer without a cast [-Wint-convers=
ion]
  709 |         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
      |             ^
drivers/tty/serial/esp32_uart.c:714:52: error: invalid use of undefined typ=
e 'struct platform_device'
  714 |         port->membase =3D devm_ioremap_resource(&pdev->dev, res);
      |                                                    ^~
drivers/tty/serial/esp32_uart.c:718:40: error: invalid use of undefined typ=
e 'struct platform_device'
  718 |         sport->clk =3D devm_clk_get(&pdev->dev, NULL);
      |                                        ^~
drivers/tty/serial/esp32_uart.c:723:26: error: invalid use of undefined typ=
e 'struct platform_device'
  723 |         port->dev =3D &pdev->dev;
      |                          ^~
drivers/tty/serial/esp32_uart.c:726:21: error: implicit declaration of func=
tion 'platform_get_irq'; did you mean 'platform_notify'? [-Werror=3Dimplici=
t-function-declaration]
  726 |         port->irq =3D platform_get_irq(pdev, 0);
      |                     ^~~~~~~~~~~~~~~~
      |                     platform_notify
drivers/tty/serial/esp32_uart.c:735:9: error: implicit declaration of funct=
ion 'platform_set_drvdata' [-Werror=3Dimplicit-function-declaration]
  735 |         platform_set_drvdata(pdev, port);
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c: At top level:
drivers/tty/serial/esp32_uart.c:740:37: warning: 'struct platform_device' d=
eclared inside parameter list will not be visible outside of this definitio=
n or declaration
  740 | static int esp32_uart_remove(struct platform_device *pdev)
      |                                     ^~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c: In function 'esp32_uart_remove':
drivers/tty/serial/esp32_uart.c:742:34: error: implicit declaration of func=
tion 'platform_get_drvdata' [-Werror=3Dimplicit-function-declaration]
  742 |         struct uart_port *port =3D platform_get_drvdata(pdev);
      |                                  ^~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c:742:34: warning: initialization of 'struct =
uart_port *' from 'int' makes pointer from integer without a cast [-Wint-co=
nversion]
drivers/tty/serial/esp32_uart.c: At top level:
drivers/tty/serial/esp32_uart.c:750:15: error: variable 'esp32_uart_driver'=
 has initializer but incomplete type
  750 | static struct platform_driver esp32_uart_driver =3D {
      |               ^~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c:751:10: error: 'struct platform_driver' has=
 no member named 'probe'
  751 |         .probe          =3D esp32_uart_probe,
      |          ^~~~~
drivers/tty/serial/esp32_uart.c:751:27: warning: excess elements in struct =
initializer
  751 |         .probe          =3D esp32_uart_probe,
      |                           ^~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c:751:27: note: (near initialization for 'esp=
32_uart_driver')
drivers/tty/serial/esp32_uart.c:752:10: error: 'struct platform_driver' has=
 no member named 'remove'
  752 |         .remove         =3D esp32_uart_remove,
      |          ^~~~~~
drivers/tty/serial/esp32_uart.c:752:27: warning: excess elements in struct =
initializer
  752 |         .remove         =3D esp32_uart_remove,
      |                           ^~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c:752:27: note: (near initialization for 'esp=
32_uart_driver')
drivers/tty/serial/esp32_uart.c:753:10: error: 'struct platform_driver' has=
 no member named 'driver'
  753 |         .driver         =3D {
      |          ^~~~~~
drivers/tty/serial/esp32_uart.c:753:27: error: extra brace group at end of =
initializer
  753 |         .driver         =3D {
      |                           ^
drivers/tty/serial/esp32_uart.c:753:27: note: (near initialization for 'esp=
32_uart_driver')
drivers/tty/serial/esp32_uart.c:753:27: warning: excess elements in struct =
initializer
drivers/tty/serial/esp32_uart.c:753:27: note: (near initialization for 'esp=
32_uart_driver')
drivers/tty/serial/esp32_uart.c: In function 'esp32_uart_init':
drivers/tty/serial/esp32_uart.c:767:15: error: implicit declaration of func=
tion 'platform_driver_register' [-Werror=3Dimplicit-function-declaration]
  767 |         ret =3D platform_driver_register(&esp32_uart_driver);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/esp32_uart.c: In function 'esp32_uart_exit':
drivers/tty/serial/esp32_uart.c:776:9: error: implicit declaration of funct=
ion 'platform_driver_unregister'; did you mean 'driver_unregister'? [-Werro=
r=3Dimplicit-function-declaration]
  776 |         platform_driver_unregister(&esp32_uart_driver);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |         driver_unregister
drivers/tty/serial/esp32_uart.c: At top level:
drivers/tty/serial/esp32_uart.c:750:31: error: storage size of 'esp32_uart_=
driver' isn't known
  750 | static struct platform_driver esp32_uart_driver =3D {
      |                               ^~~~~~~~~~~~~~~~~

Presumably caused by commit

  f793fea7761d ("of: Stop circularly including of_device.h and of_platform.=
h")

I have used the devicetree tree from next-20231206 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/KBt8BQmPN__+AbfEYtqUh4z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVxJpEACgkQAVBC80lX
0GxuNgf/Qy6Mf04UbFV42eqCFQ+Bl6ZU1o6UfPxgxvtKy1KSk2c/eYtHPG5GLp//
jwlVN/PRaDw5RIOo/HfFqXXrzYYlOYUdG80hLf4KRLP6w1uru6+JUbXcVk2PR+Il
67v+ENqts0/IjmULOfUgKRy6ouHfihB5YRZT3ElLWEJWg6faKs8uzCKejUjIwaq8
jii6PnCRPLMSt8sGF/lq1n10S0w1dsn5rk0REnKqT1DvW/KeBlLR55MqkcTgDKnp
4juqcKlmIcWOm0a9Yrw2aDeG6sUbC/ZPTBGV+SJ/nFgrWog3h/d+p8+E4wtN4LWU
WON5lDuMTHjPNDzUlWIURB+20of/dQ==
=t4IM
-----END PGP SIGNATURE-----

--Sig_/KBt8BQmPN__+AbfEYtqUh4z--
