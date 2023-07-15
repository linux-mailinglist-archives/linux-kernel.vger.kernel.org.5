Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68526754881
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGOMNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 08:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGOMNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 08:13:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100235A9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 05:13:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKe91-0003DU-2e; Sat, 15 Jul 2023 14:13:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKe8x-00EZIu-9o; Sat, 15 Jul 2023 14:12:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKe8w-0053fu-6V; Sat, 15 Jul 2023 14:12:58 +0200
Date:   Sat, 15 Jul 2023 14:12:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Message-ID: <20230715121253.gvhcszjoqxwh4gjz@pengutronix.de>
References: <20230715023653.56872-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qyte6fnzbfe3tcpo"
Content-Disposition: inline
In-Reply-To: <20230715023653.56872-1-aarongt.shen@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qyte6fnzbfe3tcpo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2023 at 10:36:53AM +0800, Guiting Shen wrote:
> The driver would never call clk_enable() if the PWM channel was already
> enabled in bootloader which lead to dump the warning message "the PWM
> clock already disabled" when turning off the PWM channel.
>=20
> Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
> the PWM channel was already enabled in bootloader.
>=20
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c | 50 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index cdbc23649032..4dd6e1319343 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -36,7 +36,7 @@
>  #define PWM_SR			0x0C
>  #define PWM_ISR			0x1C
>  /* Bit field in SR */
> -#define PWM_SR_ALL_CH_ON	0x0F
> +#define PWM_SR_ALL_CH_MASK	0x0F
> =20
>  /* The following register is PWM channel related registers */
>  #define PWM_CH_REG_OFFSET	0x200
> @@ -464,6 +464,45 @@ static const struct of_device_id atmel_pwm_dt_ids[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
> =20
> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, =
bool on)
> +{
> +	unsigned int i, cnt =3D 0;
> +	int ret =3D 0;
> +	u32 sr;
> +
> +	sr =3D atmel_pwm_readl(atmel_pwm, PWM_SR) & PWM_SR_ALL_CH_MASK;
> +	if (!sr)
> +		return 0;
> +
> +	for (i =3D 0; i < atmel_pwm->chip.npwm; i++) {
> +		if (sr & (1 << i))
> +			cnt++;
> +	}

If it's just about counting the set bits, there is the function
bitmap_weight().

> +	if (!on)
> +		goto disable_clk;
> +
> +	for (i =3D 0; i < cnt; i++) {
> +		ret =3D clk_enable(atmel_pwm->clk);
> +		if (ret) {
> +			dev_err(atmel_pwm->chip.dev,
> +				"failed to enable clock for pwm #%d: %pe\n",
> +							i, ERR_PTR(ret));

The output is bogus here. If SR is say 0xc, and the second enable
fails, it's about pwm #3, but then i is 1.

> +			cnt =3D i;
> +			goto disable_clk;
> +		}
> +	}
> +
> +	return 0;
> +
> +disable_clk:
> +	while (cnt--)
> +		clk_disable(atmel_pwm->clk);
> +
> +	return ret;
> +}
> +
>  static int atmel_pwm_probe(struct platform_device *pdev)
>  {
>  	struct atmel_pwm_chip *atmel_pwm;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qyte6fnzbfe3tcpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSyjUUACgkQj4D7WH0S
/k40lAf/TetcyCjfKtZR6x71B/fcDlAupMaT9uk53KRdVAYxj8JsWJbSyDywmLOI
5LIwDVk+rbqGsSZO1Dwn8nrDPQBiCj6bo0OZwSVTRp/HiNiOEkN3nkXxDvEJr6Up
YwmsxAhZZTUWqYKcSILhTufWTWVvTQ5Ma2tTshwFf3CUGGYBQnYze1ikokrAfIJO
hPji7P+aiSjyfwMjg+l0I4FQV2br8zqAqPdBtPePrObErBQLAjS3NFqdDGgHhAwG
CNb8HpYCBsZ18o+CPtp9fo8YA7+x99dYIu0S2gm1fD8iaU2v5A4dtBxoTREc4P9l
EjEB9exdmwFUfi2bZ5J4i4+KI4yOpw==
=wsAe
-----END PGP SIGNATURE-----

--qyte6fnzbfe3tcpo--
