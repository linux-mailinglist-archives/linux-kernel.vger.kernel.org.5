Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4CC7C4D61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjJKIl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjJKIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:41:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F193
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:41:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqUmM-0003lH-CK; Wed, 11 Oct 2023 10:41:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqUmL-000rSv-MK; Wed, 11 Oct 2023 10:41:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqUmL-00Dvxv-Cu; Wed, 11 Oct 2023 10:41:17 +0200
Date:   Wed, 11 Oct 2023 10:41:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: pxa: Explicitly include correct DT includes
Message-ID: <20231011084117.jvfl7xmbcgsu7uyl@pengutronix.de>
References: <20231009172923.2457844-22-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qonxrk3tvlfhlcfv"
Content-Disposition: inline
In-Reply-To: <20231009172923.2457844-22-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qonxrk3tvlfhlcfv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 12:29:17PM -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pwm/pwm-pxa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 1e475ed10180..78b04e017c49 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -24,7 +24,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/pwm.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>

Even without both headers the driver compiles fine as linux/pwm.h
includes of.h.

I think we should do:

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d2f9f690a9c1..9e35970ca2ab 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -4,8 +4,8 @@
=20
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
=20
+struct of_phandle_args;
 struct pwm_chip;
=20
 /**

drivers/pmw/* compiles fine with this change.

Other than that:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qonxrk3tvlfhlcfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUmX6wACgkQj4D7WH0S
/k6WCAf/VTAkcHY/Xjw1z+3vSnWH9KPBEte2/wm5UF3Ee2iG19jUSsuspIajwQsk
5ZucpR2CBmXmZ/H4CTm6R0N+bsCq+zDJoSNJMkUwqK4eFosS+oBSbp+HiOq6WzL1
sg4Mu2DgiGH4hYAeQQ7/rz7d+uE/AYKGHOOMYvjXfUaMYMag7/WRonErwoOvz/Nu
sflvsEG1cN6WLM6FBB7CuUQ6epDGvJ5hlAB7q1zdpan6o6gDBvsu3knr1RB8nSTT
vBasw6ULDb5kHAZgPkaNZd7ST14IbhD9HYp6C/B0bmW7IjksdBS6NlsoiwufPloR
jPIc+17voM6pBq0JcklEcLRlwNWF+w==
=8SsM
-----END PGP SIGNATURE-----

--qonxrk3tvlfhlcfv--
