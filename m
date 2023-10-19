Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956C17CEEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjJSFG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJSFGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:06:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265BA114;
        Wed, 18 Oct 2023 22:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697691978;
        bh=N8IuZt5BMmOQpNcf4OCrWamIx0I7KgYeX3TNRQ2Tf5s=;
        h=Date:From:To:Cc:Subject:From;
        b=RbAs9QtCtLGs9RG252YUq2KVlXSlhBRRxIcankrKD9QWCfSJnO4dyNX/oWnFeokwh
         xt8o3sxeS2+jr334wPhYPOb6pmJh6ksFfJ3SEAlDKXjGN+/FpYXjP+lP1u4exx3Ebu
         YW9I5uIR/tSm++v9XK8ZaDjcfDocADjKK5aETJX9YCQmBMXeCPr44oCbrWEYHuzV3O
         z6/QqwMQMl2imOlkPgB1da2Oe6hGc7HeCmL3lvY5G/swcLpD2yOhkEb5Yi5bErUA73
         4UCpPBJ2iSw7Hwq/IFyc6Cd03sitgeK2qdEwKXx2ltc2iIN5MsnXJTOJVQxbs4p0DW
         MRT3QomfyRRAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9wff3xNrz4xMC;
        Thu, 19 Oct 2023 16:06:18 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 16:06:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: linux-next: manual merge of the gpio-brgl tree with the
 gpio-brgl-fixes tree
Message-ID: <20231019160616.55eac2b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gKMLqWJsE9g7n6NH+h6h7wc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gKMLqWJsE9g7n6NH+h6h7wc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gpio-brgl tree got a conflict in:

  drivers/gpio/gpio-vf610.c

between commit:

  fc363413ef8e ("gpio: vf610: set value before the direction to avoid a gli=
tch")

from the gpio-brgl-fixes tree and commit:

  b57587f11f81 ("gpio: vf610: simplify code by dropping data check")

from the gpio-brgl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpio/gpio-vf610.c
index 656d6b1dddb5,a89ae84a1fa0..000000000000
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@@ -126,9 -140,7 +140,9 @@@ static int vf610_gpio_direction_output(
  	unsigned long mask =3D BIT(gpio);
  	u32 val;
 =20
 +	vf610_gpio_set(chip, gpio, value);
 +
- 	if (port->sdata && port->sdata->have_paddr) {
+ 	if (port->sdata->have_paddr) {
  		val =3D vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
  		val |=3D mask;
  		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);

--Sig_/gKMLqWJsE9g7n6NH+h6h7wc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwuUgACgkQAVBC80lX
0Gyd2gf/dQ6zSSR8z670iJGYg4EzgEZingaVqUsYF2m2hKyCUw2N2KC6sq4mZz9C
/GAOtcpgBQ6jcImdeJBzvz1AQnSq9ciXJBNTnZEvKXNLIgJX0V+2cE/i5J4ByaJw
pORWOAUfkZdFYll3wMo//wgo7MRbFjyGF/r3oTEzvG8sjwrKLhhANUiFuGPpetdo
WxJR6mVXACFSDqRJAI9YYb1RQ92HRXSdd3Ah/IrnL9Lg//8gHDdsOtkuxEzRm8pL
4ofuI42wicK27IR7w+Bm6abWBuzWrJnWUk8LmZ9kf9QX5PGmTgV9hZqsgdcSXMdx
NtuDpqqMzcBhlt9tJJxA3bhnlq1mQw==
=Z+a7
-----END PGP SIGNATURE-----

--Sig_/gKMLqWJsE9g7n6NH+h6h7wc--
