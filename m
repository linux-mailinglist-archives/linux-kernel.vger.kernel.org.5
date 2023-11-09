Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A37E724C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbjKIT07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKIT05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:26:57 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1413A3C17
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:26:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Afx-0003aB-CM; Thu, 09 Nov 2023 20:26:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Aft-007qw5-Bc; Thu, 09 Nov 2023 20:26:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Aft-00GEJb-2I; Thu, 09 Nov 2023 20:26:45 +0100
Date:   Thu, 9 Nov 2023 20:26:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 1/2] pwm: samsung: Fix broken resume after putting
 per-channel data into driver data
Message-ID: <20231109192639.77yjq7o2bioyvf5j@pengutronix.de>
References: <CGME20231109104758eucas1p2e98e8cf22a42aae212a98228e46b4438@eucas1p2.samsung.com>
 <20231109104748.2746839-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xwwbagn4i2s3ypug"
Content-Disposition: inline
In-Reply-To: <20231109104748.2746839-1-m.szyprowski@samsung.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xwwbagn4i2s3ypug
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 09, 2023 at 11:47:47AM +0100, Marek Szyprowski wrote:
> PWMF_EXPORTED is misleadingly used as a bit numer in the pwm->flags, not
> as a flag value, so the proper test for it must use test_bit() helper.
> This fixes broken resume after putting per-channel data into driver data.
>=20
> Fixes: e3fe982b2e4e ("pwm: samsung: Put per-channel data into driver data=
")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index 568491ed6829..69d9f4577b34 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -631,7 +631,7 @@ static int pwm_samsung_resume(struct device *dev)
>  		struct pwm_device *pwm =3D &chip->pwms[i];
>  		struct samsung_pwm_channel *chan =3D &our_chip->channel[i];
> =20
> -		if (!(pwm->flags & PWMF_REQUESTED))
> +		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>  			continue;

This is prior art:
https://lore.kernel.org/linux-pwm/e031db45-add0-4da7-97fa-dee95ee936ad@moro=
to.mountain/

unfortunately this was missed to be included in Thierry's PR for
v6.7-rc1 :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xwwbagn4i2s3ypug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVNMmkACgkQj4D7WH0S
/k6lkggAgvWxcScWiJ4yvqD1A3/K64jwsuFsZk3qh2NAAny5CcCzS+afqgkPSlwm
oVV4DiGUlWfmOtYRrGiLamUeHBlQXHlvIf56VZry6o8pq3QoM3zUZ9hzZ1iEQfKj
PnU3Gr9KOuyanoMxZF/krWdyoaNQq2J72DGyP0XPDphvOOQeMKuD315Hb8pjr/NZ
ESoyk45ykSAvnuSj1Xn565ZhSeP2Y7Mkxo/NOrBiNj+nwG/sC7/5KnExDQEIYads
lM3N7jfVVV+vcGpaSIaGcKsMg0wbryJ32oBxtil+KAIScr4ojgeuSAjWjV0mteMY
SzeHTeNn6UKXzTdX6DX0nGx8BSd3Ow==
=XkgZ
-----END PGP SIGNATURE-----

--xwwbagn4i2s3ypug--
