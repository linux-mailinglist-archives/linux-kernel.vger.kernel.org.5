Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21A2809983
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572993AbjLHCvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLHCve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:51:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05C1715;
        Thu,  7 Dec 2023 18:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702003895;
        bh=gtfU+2QTWZOU23jlezqw2A+wGCuTv6O7PKwuxidIA3I=;
        h=Date:From:To:Cc:Subject:From;
        b=CxHo/BQLhQX5uV8wVXkKZBDVtU7QfsMx2wKZ1FpqLtsPjwmIRgVKxd4D1jmgetC6h
         del/gm8yTJNPNAZ263GiDLxJLj3Zr0yTv4zf1IhA7ID78kVzMmOENaMyFxUBTAX9Vj
         OELvVAqrOOa6AMELYqaMD1LIXyyRJEPrkqjvF75Re4EtLCoY5lagJY+pEC6hXc0Ag8
         4ixjV5k6EyaX0QcJrG/Eg28jcEbcTVeDOaBEWKQk036wlOF1jSpKxklD6IIOC9XFaZ
         la4bWQUBIRgETQGd9qgKMLAQ4G+YIvGXVdaWqp3ASifIYpWiQXhxFT3VqCKWBfJQ/D
         yFsjdAHZZRH1g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmbJ65N2Dz4xG8;
        Fri,  8 Dec 2023 13:51:34 +1100 (AEDT)
Date:   Fri, 8 Dec 2023 13:51:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kris Chaplin <kris.chaplin@amd.com>,
        Thomas Delev <thomas.delev@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the devicetree tree
Message-ID: <20231208135133.42704925@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/alGm_CHpwalqpl0Fccs6VSE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/alGm_CHpwalqpl0Fccs6VSE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devicetree tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/w1/masters/amd_axi_w1.c: In function 'amd_axi_w1_probe':
drivers/w1/masters/amd_axi_w1.c:296:35: error: invalid use of undefined typ=
e 'struct platform_device'
  296 |         struct device *dev =3D &pdev->dev;
      |                                   ^~
drivers/w1/masters/amd_axi_w1.c:307:25: error: implicit declaration of func=
tion 'devm_platform_ioremap_resource'; did you mean 'devm_ioremap_resource'=
? [-Werror=3Dimplicit-function-declaration]
  307 |         lp->base_addr =3D devm_platform_ioremap_resource(pdev, 0);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                         devm_ioremap_resource
drivers/w1/masters/amd_axi_w1.c:307:23: warning: assignment to 'void *' fro=
m 'int' makes pointer from integer without a cast [-Wint-conversion]
  307 |         lp->base_addr =3D devm_platform_ioremap_resource(pdev, 0);
      |                       ^
drivers/w1/masters/amd_axi_w1.c:311:19: error: implicit declaration of func=
tion 'platform_get_irq'; did you mean 'platform_notify'? [-Werror=3Dimplici=
t-function-declaration]
  311 |         lp->irq =3D platform_get_irq(pdev, 0);
      |                   ^~~~~~~~~~~~~~~~
      |                   platform_notify
drivers/w1/masters/amd_axi_w1.c:360:9: error: implicit declaration of funct=
ion 'platform_set_drvdata' [-Werror=3Dimplicit-function-declaration]
  360 |         platform_set_drvdata(pdev, lp);
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/w1/masters/amd_axi_w1.c: In function 'amd_axi_w1_remove':
drivers/w1/masters/amd_axi_w1.c:372:39: error: implicit declaration of func=
tion 'platform_get_drvdata' [-Werror=3Dimplicit-function-declaration]
  372 |         struct amd_axi_w1_local *lp =3D platform_get_drvdata(pdev);
      |                                       ^~~~~~~~~~~~~~~~~~~~
drivers/w1/masters/amd_axi_w1.c:372:39: warning: initialization of 'struct =
amd_axi_w1_local *' from 'int' makes pointer from integer without a cast [-=
Wint-conversion]
drivers/w1/masters/amd_axi_w1.c: At top level:
drivers/w1/masters/amd_axi_w1.c:383:15: error: variable 'amd_axi_w1_driver'=
 has initializer but incomplete type
  383 | static struct platform_driver amd_axi_w1_driver =3D {
      |               ^~~~~~~~~~~~~~~
drivers/w1/masters/amd_axi_w1.c:384:10: error: 'struct platform_driver' has=
 no member named 'probe'
  384 |         .probe =3D amd_axi_w1_probe,
      |          ^~~~~
drivers/w1/masters/amd_axi_w1.c:384:18: warning: excess elements in struct =
initializer
  384 |         .probe =3D amd_axi_w1_probe,
      |                  ^~~~~~~~~~~~~~~~
drivers/w1/masters/amd_axi_w1.c:384:18: note: (near initialization for 'amd=
_axi_w1_driver')
drivers/w1/masters/amd_axi_w1.c:385:10: error: 'struct platform_driver' has=
 no member named 'remove_new'
  385 |         .remove_new =3D amd_axi_w1_remove,
      |          ^~~~~~~~~~
drivers/w1/masters/amd_axi_w1.c:385:23: warning: excess elements in struct =
initializer
  385 |         .remove_new =3D amd_axi_w1_remove,
      |                       ^~~~~~~~~~~~~~~~~
drivers/w1/masters/amd_axi_w1.c:385:23: note: (near initialization for 'amd=
_axi_w1_driver')
drivers/w1/masters/amd_axi_w1.c:386:10: error: 'struct platform_driver' has=
 no member named 'driver'
  386 |         .driver =3D {
      |          ^~~~~~
drivers/w1/masters/amd_axi_w1.c:386:19: error: extra brace group at end of =
initializer
  386 |         .driver =3D {
      |                   ^
drivers/w1/masters/amd_axi_w1.c:386:19: note: (near initialization for 'amd=
_axi_w1_driver')
drivers/w1/masters/amd_axi_w1.c:386:19: warning: excess elements in struct =
initializer
drivers/w1/masters/amd_axi_w1.c:386:19: note: (near initialization for 'amd=
_axi_w1_driver')
drivers/w1/masters/amd_axi_w1.c:391:1: warning: data definition has no type=
 or storage class
  391 | module_platform_driver(amd_axi_w1_driver);
      | ^~~~~~~~~~~~~~~~~~~~~~
drivers/w1/masters/amd_axi_w1.c:391:1: error: type defaults to 'int' in dec=
laration of 'module_platform_driver' [-Werror=3Dimplicit-int]
drivers/w1/masters/amd_axi_w1.c:391:1: warning: parameter names (without ty=
pes) in function declaration
drivers/w1/masters/amd_axi_w1.c:383:31: error: storage size of 'amd_axi_w1_=
driver' isn't known
  383 | static struct platform_driver amd_axi_w1_driver =3D {
      |                               ^~~~~~~~~~~~~~~~~
drivers/w1/masters/amd_axi_w1.c:383:31: warning: 'amd_axi_w1_driver' define=
d but not used [-Wunused-variable]

Caused by commit

  0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platform.=
h")

interacting with commit

  271c81935801 ("w1: Add AXI 1-wire host driver for AMD programmable logic =
IP core")

from the w1 tree.

I have applied the following merge fix patch for today (that could just
be applied to the w1 tree).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 8 Dec 2023 13:37:03 +1100
Subject: [PATCH] amd_axi_w1: include the correct files

This is to cope with "of: Stop circularly including of_device.h and
of_platform.h"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/w1/masters/amd_axi_w1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/masters/amd_axi_w1.c b/drivers/w1/masters/amd_axi_w=
1.c
index 24a05c2de5f1..f8b31cae450d 100644
--- a/drivers/w1/masters/amd_axi_w1.c
+++ b/drivers/w1/masters/amd_axi_w1.c
@@ -13,7 +13,8 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/wait.h>
=20
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/alGm_CHpwalqpl0Fccs6VSE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVyhLUACgkQAVBC80lX
0GyvpAgAmIAizw31WRu3TgclLRg1U93IyL2VoS9oP8tDqAPrAN1/xaBSwLLjQg1W
NqgHpp5mu273LixmXZXO16eqFlGuWmsDbkgRtPztfH/hLR/GxqzXMtXd5MqIDln2
Y4I5hm+yBEJQvFdi8Skc8WZpouPQVvqEkHONVoTQKI21BmJnbPsW65pM3EVulAPn
Kkqgf1+hmbBdyfGXV7vkhCUgsfO+cEbWbFy/eyhp8E/5VplL/cnfyKBFi2t4l6jD
MrgBiHetmCj3DH5Ly7aqRQNDDAH1ilnlAorgrOUXIi+aAv8Ray+YKT/Ld+fnadck
U7avoL1IAox8v4ktBIQWfr6tPGERnw==
=MOyT
-----END PGP SIGNATURE-----

--Sig_/alGm_CHpwalqpl0Fccs6VSE--
