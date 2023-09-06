Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB3794093
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbjIFPm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjIFPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:42:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750C2172C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:42:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdufa-0000GX-7L; Wed, 06 Sep 2023 17:42:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdufZ-004SQC-3x; Wed, 06 Sep 2023 17:42:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdufY-00GuOl-36; Wed, 06 Sep 2023 17:42:16 +0200
Date:   Wed, 6 Sep 2023 17:42:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] pwm: imx27: fix race condition .apply,.get_state
Message-ID: <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
References: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
 <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hl2w5zzvfrzbn5au"
Content-Disposition: inline
In-Reply-To: <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hl2w5zzvfrzbn5au
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 12:43:29PM +0200, Leif Middelschulte wrote:
> From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
>=20
> With CONFIG_PWM_DEBUG=3Dy after writing a value to the PWMSAR
> register in .apply(), the register is read in .get_state().
> Unless a period completed in the meantime, this read yields the
> previously used duty cycle configuration. As the PWM_DEBUG code
> applies the read out configuration for testing purposes this
> effectively undoes the intended effect by rewriting the previous
> hardware state.
>=20
> Note that this change merely implements a sensible heuristic.
> The i.MX has a 4 slot FIFO to configure the duty cycle. This FIFO
> cannot be read back in its entirety. The "write x then read back
> x from hw" semantics are therefore not easily applicable.
> With this change, the .get_state() function tries to wait for some
> stabilization in the FIFO (empty state). In this state it keeps
> applying the last value written to the sample register.
>=20
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
> ---
>  drivers/pwm/pwm-imx27.c | 50 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 29a3089c534c..32389ca2da3e 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -75,6 +75,7 @@
>  						   (x)) + 1)
> =20
>  #define MX3_PWM_SWR_LOOP		5
> +#define MX3_PWM_FIFOAV_EMPTY_LOOP	4
> =20
>  /* PWMPR register value of 0xffff has the same effect as 0xfffe */
>  #define MX3_PWMPR_MAX			0xfffe
> @@ -118,8 +119,28 @@ static void pwm_imx27_clk_disable_unprepare(struct p=
wm_imx27_chip *imx)
>  	clk_disable_unprepare(imx->clk_ipg);
>  }
> =20
> +static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
> +				     struct pwm_device *pwm)
> +{
> +	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> +	struct device *dev =3D chip->dev;
> +	unsigned int period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm), NSEC_P=
ER_MSEC);
> +	int tries =3D MX3_PWM_FIFOAV_EMPTY_LOOP;
> +	int fifoav;
> +	u32 sr;
> +
> +	while (tries--) {
> +		sr =3D readl(imx->mmio_base + MX3_PWMSR);
> +		fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
> +		if (fifoav =3D=3D MX3_PWMSR_FIFOAV_EMPTY)
> +			return;
> +		msleep(period_ms);
> +	}
> +	dev_warn(dev, "FIFO has been refilled concurrently\n");
> +}
> +
>  static int pwm_imx27_get_state(struct pwm_chip *chip,
> -			       struct pwm_device *pwm, struct pwm_state *state)
> +				struct pwm_device *pwm, struct pwm_state *state)

This looks wrong. Aligning at the opening ( was right.

>  {
>  	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
>  	u32 period, prescaler, pwm_clk, val;
> @@ -161,10 +182,33 @@ static int pwm_imx27_get_state(struct pwm_chip *chi=
p,
>  	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
>  	 * use the cached value.
>  	 */
> -	if (state->enabled)
> +	if (state->enabled) {
> +		/*
> +		 * From the i.MX PWM reference manual:
> +		 * "A read on the sample register yields the current FIFO value that
> +		 *  is being used, or will be used, by the PWM for generation on the
> +		 *  output signal. Therefore, a write and a subsequent read on the
> +		 *  sample register may result in different values being obtained."
> +		 * Furthermore:
> +		 * "When a new value is written, the duty cycle changes after the
> +		 *  current period is over."
> +		 * Note "changes" vs. "changes to the given value"!
> +		 * Finally:
> +		 * "The PWM will run at the last set duty-cycle setting if all the
> +		 *  values of the FIFO has been utilized, until the FIFO is reloaded
> +		 *  or the PWM is disabled."
> +		 * Try to be at least a bit more deterministic about which value is
> +		 * read by waiting until the FIFO is empty. In this state the last/most
> +		 * recently pushed sample (duty cycle) value is continuously applied.
> +		 * Beware that this approach is still racy, as a new value could have
> +		 * been supplied and a period expired between the call of the wait
> +		 * function and the subsequent readl.

this would only happen if there are concurrent calls into the driver,
wouldn't it? I think it's safe to assume this doesn't happen.

Patch 3 of this series improves the function that is only introduced
here. I suggest to squash these together.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hl2w5zzvfrzbn5au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT4ndcACgkQj4D7WH0S
/k5AewgAneAr+gtglxSR8kLRkr3TEstpVP7ZpAmE5J+11sF3/DRDeY/8XxxGCGbh
5Vx395M9bZ6GdoZ9SKcW+iwCm4VFepI3p8jpp19wHzqOCvTGPVOcS9CStQcDlUWF
VhyHT13ZQlojOxoxs3bboiO9fcEJPUJLcSzSpMt9VJTGO/08KEa5QfnmIGyD6Dm+
cNUIcGNkeyWddvJ+JaxowcfgeQ4YcWCh9NGfOJuUEjjwLDSAMGgwJD9zADSmooge
Oauz7Mo294sM9XQoCXBTgTz/Br612bVl0MZpqjokZFPAm63D80OtR463K9GLHz7l
EBRwDJbX+T5mewhA06XWvTd32YgkeQ==
=RsEN
-----END PGP SIGNATURE-----

--hl2w5zzvfrzbn5au--
