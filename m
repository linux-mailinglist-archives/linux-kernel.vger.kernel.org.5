Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317747821B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjHUC5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHUC5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:57:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B952D9C;
        Sun, 20 Aug 2023 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692586663;
        bh=Is75wYt5QzY2hAeJvc/3rRdKASy9fYylAGmehUp4C+k=;
        h=Date:From:To:Cc:Subject:From;
        b=D4X8O4a4ZcGiCOsoiONe3ftRNhRdQtLlvxZqhnR3JAv1VQoQYHFRyDskRfpM9mziC
         RXoBSsROJPiaJF+qljk6GPa2MXWBDs5x2J1gwNZ6O45KU/TnHCXJjtAbilDUl38HHQ
         /9X3i5mvBqD+lBHIcooGj/XgSJwTQ4bfFf4fz63t5KHwdcnywi7w3XWOBa3mT0uPU6
         uHtsCm+tEx/uh6m6ilkrpk7yJse6iDgkbcEGlhVZN4F3hXZBUe170ZVYwkYBHceaNw
         NTu0w8TMbRIoCU7u/lhl4rzCMzOwHm3SrfndI6W8/VRYdPd6T+onVEx6NDDcyL0rVD
         A48tu5XSHgHZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTcbW05Pzz4wxy;
        Mon, 21 Aug 2023 12:57:42 +1000 (AEST)
Date:   Mon, 21 Aug 2023 12:57:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Jakob Hauser <jahau@rocketmail.com>, Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the battery tree
Message-ID: <20230821125741.3a2474d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tt1ua=Rn96Hi2_2wveJVrCP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tt1ua=Rn96Hi2_2wveJVrCP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the battery tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/power/supply/rt5033_charger.c: In function 'rt5033_charger_probe':
drivers/power/supply/rt5033_charger.c:694:19: error: implicit declaration o=
f function 'of_parse_phandle' [-Werror=3Dimplicit-function-declaration]
  694 |         np_conn =3D of_parse_phandle(pdev->dev.of_node, "richtek,us=
b-connector", 0);
      |                   ^~~~~~~~~~~~~~~~
drivers/power/supply/rt5033_charger.c:694:17: error: assignment to 'struct =
device_node *' from 'int' makes pointer from integer without a cast [-Werro=
r=3Dint-conversion]
  694 |         np_conn =3D of_parse_phandle(pdev->dev.of_node, "richtek,us=
b-connector", 0);
      |                 ^
drivers/power/supply/rt5033_charger.c:695:19: error: implicit declaration o=
f function 'of_get_parent'; did you mean 'kernfs_get_parent'? [-Werror=3Dim=
plicit-function-declaration]
  695 |         np_edev =3D of_get_parent(np_conn);
      |                   ^~~~~~~~~~~~~
      |                   kernfs_get_parent
drivers/power/supply/rt5033_charger.c:695:17: error: assignment to 'struct =
device_node *' from 'int' makes pointer from integer without a cast [-Werro=
r=3Dint-conversion]
  695 |         np_edev =3D of_get_parent(np_conn);
      |                 ^

Caused by commit

  2ce8284c3115 ("power: Explicitly include correct DT includes")

interacting with commit

  12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB=
 OTG supply")

from the mfd tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 21 Aug 2023 12:50:12 +1000
Subject: [PATCH] fixup for "power: Explicitly include correct DT includes"

interacting with commit

  12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB=
 OTG supply")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/power/supply/rt5033_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/r=
t5033_charger.c
index 4d1198d752b7..4ea769775fa5 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -11,6 +11,7 @@
 #include <linux/extcon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/tt1ua=Rn96Hi2_2wveJVrCP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTi0qUACgkQAVBC80lX
0Gzl7gf+N44HkOh1P7sKck4HIUphYggGFchB2U+Uvck2mRIm5E+amwHlPRPBtdY0
rLpMQaxxstEeaXSPa77dy6NxwZ93CGInhFpbKJkvfZlZHyIdJlvvnQr6R3AHit32
Bt1vV/TNjx9uMaUsV6xQmfQBZaf+XBzqjrxNfsGB9lmVeoSGzesbkvUTsb8rxPZc
dKoinY7BlzyQHrBb3Vc+Qzvi5zj3T3Y+k+lj/hfjcbLlwCkexYUtNgv+tpS7V0q7
F6aVehgeRHeQuqacOAmu3XL+O6i6omFMLPHFkBa6yNe38frICRD1uiXMMsFvZE3x
4Rb+U7GfpE+MyudgblXvD4x9Wn2MPQ==
=yKKf
-----END PGP SIGNATURE-----

--Sig_/tt1ua=Rn96Hi2_2wveJVrCP--
