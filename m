Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42363754BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjGOTn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGOTn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:43:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF24F3AA6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 12:42:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKl9v-0003Gj-Oh; Sat, 15 Jul 2023 21:42:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKl9u-00Edfz-9S; Sat, 15 Jul 2023 21:42:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKl9t-0058Sm-EM; Sat, 15 Jul 2023 21:42:25 +0200
Date:   Sat, 15 Jul 2023 21:42:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.dooks@codethink.co.uk,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v8 4/5] pwm: dwc: use clock rate in hz to avoid rounding
 issues
Message-ID: <20230715194223.446ku3zfdnwhlp2z@pengutronix.de>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
 <20230614171457.69191-5-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqt3jhjugimjywv2"
Content-Disposition: inline
In-Reply-To: <20230614171457.69191-5-ben.dooks@sifive.com>
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


--lqt3jhjugimjywv2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 06:14:56PM +0100, Ben Dooks wrote:
> As noted, the clock-rate when not a nice multiple of ns is probably
> going to end up with inacurate caculations, as well as on a non pci

s/caculation/calculations/

> system the rate may change (although we've not put a clock rate
> change notifier in this code yet) so we also add some quick checks
> of the rate when we do any calculations with it.

An externally triggered clock rate change is bad. If you drive a motor
you probably want to prevent an uncontrolled change here. I already
considered to add a call to clk_rate_exclusive_get() in various pwm
drivers for that reason, but didn't come around yet.

> Signed-off-by; Ben Dooks <ben.dooks@sifive.com>
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> v8:
>  - fixup post rename
>  - move to earlier in series
> ---
>  drivers/pwm/pwm-dwc-core.c | 24 +++++++++++++++---------
>  drivers/pwm/pwm-dwc.h      |  2 +-
>  2 files changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
> index 38cd2163fe01..0f07e26e6c30 100644
> --- a/drivers/pwm/pwm-dwc-core.c
> +++ b/drivers/pwm/pwm-dwc-core.c
> @@ -49,13 +49,14 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *=
dwc,
>  	 * periods and check are the result within HW limits between 1 and
>  	 * 2^32 periods.
>  	 */
> -	tmp =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
> +	tmp =3D state->duty_cycle * dwc->clk_rate;
> +	tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);

New drivers should implement round-down behaviour (i.e. pick the biggest
period (and duty_cycle) that is not bigger than the requested value.
With clk_ns =3D 10 (which it is the hardcoded value up to now) it doesn't
matter much how you round the division. I suggest to use the opportunity
to align to how new drivers should round. (That would be a separate
patch.)

>  	if (tmp < 1 || tmp > (1ULL << 32))
>  		return -ERANGE;
>  	low =3D tmp - 1;
> =20
> -	tmp =3D DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
> -				    dwc->clk_ns);
> +	tmp =3D (state->period - state->duty_cycle) * dwc->clk_rate;
> +	tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
>  	if (tmp < 1 || tmp > (1ULL << 32))
>  		return -ERANGE;
>  	high =3D tmp - 1;
> @@ -121,11 +122,14 @@ static int dwc_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  			     struct pwm_state *state)
>  {
>  	struct dwc_pwm *dwc =3D to_dwc_pwm(chip);
> +	unsigned long clk_rate;
>  	u64 duty, period;
>  	u32 ctrl, ld, ld2;
> =20
>  	pm_runtime_get_sync(chip->dev);
> =20
> +	clk_rate =3D dwc->clk_rate;
> +
>  	ctrl =3D dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
>  	ld =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
>  	ld2 =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
> @@ -136,17 +140,19 @@ static int dwc_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	 * based on the timer load-count only.
>  	 */
>  	if (ctrl & DWC_TIM_CTRL_PWM) {
> -		duty =3D (ld + 1) * dwc->clk_ns;
> -		period =3D (ld2 + 1)  * dwc->clk_ns;
> +		duty =3D ld + 1;
> +		period =3D ld2 + 1;
>  		period +=3D duty;
>  	} else {
> -		duty =3D (ld + 1) * dwc->clk_ns;
> +		duty =3D ld + 1;
>  		period =3D duty * 2;
>  	}
> =20
> +	duty *=3D NSEC_PER_SEC;
> +	period *=3D NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_CLOSEST_ULL(period, clk_rate);
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(duty, clk_rate);
>  	state->polarity =3D PWM_POLARITY_INVERSED;
> -	state->period =3D period;
> -	state->duty_cycle =3D duty;
> =20
>  	pm_runtime_put_sync(chip->dev);
> =20
> @@ -167,7 +173,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
>  	if (!dwc)
>  		return NULL;
> =20
> -	dwc->clk_ns =3D 10;
> +	dwc->clk_rate =3D NSEC_PER_SEC / 10;
>  	dwc->chip.dev =3D dev;
>  	dwc->chip.ops =3D &dwc_pwm_ops;
>  	dwc->chip.npwm =3D DWC_TIMERS_TOTAL;
> diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
> index 64795247c54c..e0a940fd6e87 100644
> --- a/drivers/pwm/pwm-dwc.h
> +++ b/drivers/pwm/pwm-dwc.h
> @@ -42,7 +42,7 @@ struct dwc_pwm_ctx {
>  struct dwc_pwm {
>  	struct pwm_chip chip;
>  	void __iomem *base;
> -	unsigned int clk_ns;
> +	unsigned long clk_rate;
>  	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
>  };
>  #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lqt3jhjugimjywv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSy9p4ACgkQj4D7WH0S
/k6l1gf/dXcqdMGB1lyyUwf3IWOrB3QWTlCjX5ugWajQS26IU3PemDONSM8h9UYc
R250eYBt47QtbSSOkVTK8U9OkfDCwnJvtJCgmfAp51b9NUaxrZeoHyVAIT5LpxE5
tNz1Ei9ClbkX5vce1u5PgkMK+pASBtDS8FP4LQt9qWCXkCHYJ4d5vJVtsCpPP3ub
Ll5Up4nbg5hkJ+Po7geeztoXfXw1bLM1nWyuZsElhsaceX8DZ/25mBMvKUXDWINv
v5bbg5LN1Qs0WxkyFb6mAMzNu63282M45InMtL50wql5sBEeuW7RLpgV+u/g/KeZ
zsTVTs7DuoHBM6c8gJWvEINl+TKQow==
=4LDd
-----END PGP SIGNATURE-----

--lqt3jhjugimjywv2--
