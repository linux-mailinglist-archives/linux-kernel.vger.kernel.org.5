Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C97782177
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjHUCeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjHUCeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:34:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C2F9C;
        Sun, 20 Aug 2023 19:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692585237;
        bh=/oSBrquxZQcW7A+RvZq4mtocbjzgqdS40RYhUrN3v/o=;
        h=Date:From:To:Cc:Subject:From;
        b=CeS+wTYD9FFtSoChIIGrkiYW+suecVwJJk/JkipQOsXBP2HvNUf4P1Si/Hb2A46d5
         BQekMXji2CbYhViEWVklvjYKBvac22rJJElePagRrDyDTR3sm81sFOYlRUzq+8Pge7
         6E4dD9m3VYLWtU9cYiLmNMCXhtA1PNIYVQOBtE/EX0R/SKV5ZzTY+IAHCJ3TK9meX/
         A5VCVaxqnbXqW8gQfY5gtLhdFDDHf11k4OFoZdsw0qO6KdGAAdg1ajJnxrctNLPrt7
         V+wDxdDPhIq6h7SJAmmL03crBhzvUnHCBpwsDKBPAYC3oUZ68gfsxtfYAYl7stqXBA
         4t9AaRk9yxQkw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTc446Plwz4wxy;
        Mon, 21 Aug 2023 12:33:56 +1000 (AEST)
Date:   Mon, 21 Aug 2023 12:33:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: linux-next: manual merge of the battery tree with the mfd tree
Message-ID: <20230821123354.4d2684ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nkahc+Q4.5YAU6na9ej6+Tw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nkahc+Q4.5YAU6na9ej6+Tw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the battery tree got a conflict in:

  drivers/power/supply/rt5033_charger.c

between commit:

  12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB=
 OTG supply")

from the mfd tree and commit:

  2ce8284c3115 ("power: Explicitly include correct DT includes")

from the battery tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/power/supply/rt5033_charger.c
index e0303ca5a8db,c0c516f22c66..000000000000
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@@ -6,11 -6,8 +6,11 @@@
   * Author: Beomho Seo <beomho.seo@samsung.com>
   */
 =20
+ #include <linux/mod_devicetable.h>
 +#include <linux/devm-helpers.h>
 +#include <linux/extcon.h>
  #include <linux/module.h>
 +#include <linux/mutex.h>
- #include <linux/of_device.h>
  #include <linux/platform_device.h>
  #include <linux/power_supply.h>
  #include <linux/regmap.h>

--Sig_/Nkahc+Q4.5YAU6na9ej6+Tw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTizRIACgkQAVBC80lX
0Gz6YQf/YUUVV7LP+8uW16ElnzJufoSV7OfgThC55ZCxIajymp6hRSdfjmqZlOG1
ra2sutXWxIC+gx+HLVPb6eKTQriBaYCRRzy3cyNlyLWKvusrJKE2wqLNICjYtxrG
HGm4tsTO4sSKKTrFSwfUSlI+nfDYgTw48E8rnOGjjYTsdkwpoPm+pUlB6GvAoFys
JXB20Pn4vLgpyX20mktvCo6A0aUjFstPsLA4l5eGZDOW1bS40nE3RmUXsA+OsbIx
f3/RwA3djcA1doR8IAZofxEPbe9SF/eHJ14xgGwApOrV363ymJ9Pesn8SVw8lZza
tsIz631K4BflUMCqu2BJJfnhS6mxDA==
=sNfb
-----END PGP SIGNATURE-----

--Sig_/Nkahc+Q4.5YAU6na9ej6+Tw--
