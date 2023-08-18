Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C327805D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358024AbjHRGIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358020AbjHRGIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:08:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFC1359D;
        Thu, 17 Aug 2023 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692338919;
        bh=zJG6tKi7yDS9WwHdliEZHk4zx0+GKEMFv2GaIVp8pV4=;
        h=Date:From:To:Cc:Subject:From;
        b=QllZGQMpKEpdxbFALLO2lUjCoNY5V5BiQ0wSctt42qu7pwTH1XPTn5+lIjZKUxOAj
         eWy+g8kHm5z9eSGpO0bgdh+Fi91Sy4w1j1dRqUtpXm8ooLome8BNdF4/J5XtDj1Q6M
         ISCUInGpkWfGguMJ46MjuZGQzA1htb1NZtA5HbYXMP6K+Vi3AH4lD+FwI0vCafZWCx
         oD8Z+ozNQdd2yTyrF9PmFK4o1lrw91hiLA16i53I8u6hYjNsOnaGZHWPBrZ2IxaPHR
         HFQutJcKzhsbtASn703EhOoUALmmK5vW+WH1GmJncBUrXpZvlkTeAm87m2YN9X4RlZ
         hRAzrxyms0UqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRrz96wnyz4wxm;
        Fri, 18 Aug 2023 16:08:37 +1000 (AEST)
Date:   Fri, 18 Aug 2023 16:08:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the pinctrl-renesas tree with the
 pinctrl tree
Message-ID: <20230818160837.147b1e2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vM.PpzNqUdSKHc6IynA9DXD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vM.PpzNqUdSKHc6IynA9DXD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl-renesas tree got conflicts in:

  drivers/pinctrl/renesas/pinctrl-rza2.c
  drivers/pinctrl/renesas/pinctrl-rzg2l.c
  drivers/pinctrl/renesas/pinctrl-rzv2m.c

between commit:

  060f03e95454 ("pinctrl: Explicitly include correct DT includes")

from the pinctrl tree and commits:

  848f700dabda ("pinctrl: renesas: rzg2l: Fix NULL pointer dereference in r=
zg2l_dt_subnode_to_map()")
  ca63f2ef6a16 ("pinctrl: renesas: rzv2m: Fix NULL pointer dereference in r=
zv2m_dt_subnode_to_map()")
  1eb1e00e5d99 ("pinctrl: renesas: rza2: Add lock around pinctrl_generic{{a=
dd,remove}_group,{add,remove}_function}")

from the pinctrl-renesas tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pinctrl/renesas/pinctrl-rza2.c
index 0b454a31c4bd,5591ddf16fdf..000000000000
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@@ -14,9 -14,9 +14,10 @@@
  #include <linux/gpio/driver.h>
  #include <linux/io.h>
  #include <linux/module.h>
+ #include <linux/mutex.h>
 -#include <linux/of_device.h>
 +#include <linux/of.h>
  #include <linux/pinctrl/pinmux.h>
 +#include <linux/platform_device.h>
 =20
  #include "../core.h"
  #include "../pinmux.h"
diff --cc drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4f34f8f24bde,cdf183250c1e..000000000000
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@@ -11,9 -11,9 +11,10 @@@
  #include <linux/interrupt.h>
  #include <linux/io.h>
  #include <linux/module.h>
+ #include <linux/mutex.h>
 -#include <linux/of_device.h>
 +#include <linux/of.h>
  #include <linux/of_irq.h>
 +#include <linux/platform_device.h>
  #include <linux/seq_file.h>
  #include <linux/spinlock.h>
 =20
diff --cc drivers/pinctrl/renesas/pinctrl-rzv2m.c
index c73784b8b4ba,aa9dbbddff21..000000000000
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@@ -14,8 -14,8 +14,9 @@@
  #include <linux/gpio/driver.h>
  #include <linux/io.h>
  #include <linux/module.h>
+ #include <linux/mutex.h>
 -#include <linux/of_device.h>
 +#include <linux/of.h>
 +#include <linux/platform_device.h>
  #include <linux/spinlock.h>
 =20
  #include <linux/pinctrl/consumer.h>

--Sig_/vM.PpzNqUdSKHc6IynA9DXD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTfCuUACgkQAVBC80lX
0GxdiAgAjuCwcYWx5oEZSD1DED1nN3FIZD5k4nrQv4pnFjA7+RWrbrB96/V1dI7K
WPeyQEW97aeJitLhofijnbXcGaQEwbEwV3ieoTwh+qzAcEuKdL3yGpkEruAiCNuk
CIvnK18a4kf3X64U7k3YA64FhZ9ERmndka+6bcczBx/sDyZf6ENyBI2bZmFawadh
WQ7cFYaqL9g+l2QhaW6HnBj3PCbM/QaKVSeo1tLqHb0WJllfhjCj6j93GIlSyx3j
yhKgvb5pyIvXVlPWjVQEPL/qOK4982FqM2TaAMsTdkxxUqmbJ1vvfwduNXxcaB1R
XUYJ/aLxPq/fJES+l1UlrqfTEO2d2A==
=JGek
-----END PGP SIGNATURE-----

--Sig_/vM.PpzNqUdSKHc6IynA9DXD--
