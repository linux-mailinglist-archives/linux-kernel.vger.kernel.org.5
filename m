Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9D797DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbjIGVef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjIGVee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:34:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E39B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:34:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMdr-0005EZ-G6; Thu, 07 Sep 2023 23:34:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMdp-004jog-A9; Thu, 07 Sep 2023 23:34:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMdo-00HHky-6P; Thu, 07 Sep 2023 23:34:20 +0200
Date:   Thu, 7 Sep 2023 23:34:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v9 4/6] pwm: dwc: use clock rate in hz to avoid rounding
 issues
Message-ID: <20230907213419.aqzwoppznj5tx7w6@pengutronix.de>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
 <20230907161242.67190-5-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fylg3yqaihsqt5zo"
Content-Disposition: inline
In-Reply-To: <20230907161242.67190-5-ben.dooks@codethink.co.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fylg3yqaihsqt5zo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Dropped William Salmon and Jude Onyenegecha from the list of recipents,
their email addresses don't seem to work any more.]

On Thu, Sep 07, 2023 at 05:12:40PM +0100, Ben Dooks wrote:
> As noted, the clock-rate when not a nice multiple of ns is probably
> going to end up with inacurate calculations, as well as on a non pci
> system the rate may change (although we've not put a clock rate
> change notifier in this code yet) so we also add some quick checks
> of the rate when we do any calculations with it.
>=20
> Signed-off-by; Ben Dooks <ben.dooks@codethink.co.uk>
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> v9:
>  - fixed commit spelling
>  - changed to use codethink email instead of sifive
> v8:
>  - fixup post rename
>  - move to earlier in series
> ---
>  drivers/pwm/pwm-dwc-core.c | 24 +++++++++++++++---------
>  drivers/pwm/pwm-dwc.h      |  2 +-
>  2 files changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
> index 3fc281a78c9a..3b856685029d 100644
> --- a/drivers/pwm/pwm-dwc-core.c
> +++ b/drivers/pwm/pwm-dwc-core.c
> @@ -49,13 +49,14 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *=
dwc,
>  	 * periods and check are the result within HW limits between 1 and
>  	 * 2^32 periods.
>  	 */
> -	tmp =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
> +	tmp =3D state->duty_cycle * dwc->clk_rate;

This might overflow. You can prevent this by asserting that clk_rate is
<=3D NSEC_PER_SEC and using mul_u64_u64_div_u64.

> +	tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
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
> @@ -137,17 +141,19 @@ static int dwc_pwm_get_state(struct pwm_chip *chip,=
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

A comment that/why this cannot overflow would be nice. (I didn't check,
maybe it can?)

> +	state->period =3D DIV_ROUND_CLOSEST_ULL(period, clk_rate);
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(duty, clk_rate);

Without having thought deeply about this, I think you need to round up
here. Hmm, but given that .apply() uses round-closest, too, this needs
to be addressed separately.

(The ugly thing about round-closest is that .apply(mypwm,
=2Eget_state(mypwm)) isn't idempotent in general. Consider a PWM that can
implement period =3D 41.7ns and period =3D 42.4 ns. If it's configured with
42.4, .get_state will return period =3D 42. Reapplying this will configure
for 41.7ns. This won't happen with the PCI clkrate, but it might in the
of case. Another reason to use rounding-down in .apply is that
mul_u64_u64_div_u64 doesn't have a round-nearest variant.)

>  	state->polarity =3D PWM_POLARITY_INVERSED;
> -	state->period =3D period;
> -	state->duty_cycle =3D duty;
> =20
>  	pm_runtime_put_sync(chip->dev);
> =20
> @@ -168,7 +174,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
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

Given that clk_ns was only introduced in patch #2 I think it would be
cleaner to squash these two patches together.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fylg3yqaihsqt5zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT6QdsACgkQj4D7WH0S
/k4AIQf+JZmJsb6OqTEes8nOE/gzUhjTk0OENM36x/+mWqYs6cIfm7nLt60+6SJO
rnMBydxdOINrMlczgT/gx9CuyL/WNPp+qUvGDSv4KGPkUX7jH6Y7QUcfm7VOh7/N
E1MhQXzREeKMgNVZ3INTZsCL/0JEArNodNTKLoe8IyYSU3a3Okp+AuIyceO7TSC4
nfsGeaOr5TZgTIqvqDKlOkbBaWTGdUH2q7lijWnymx0V2op97kbSSRYxfcsWdTMw
csKu0nYdjaAGGCqhTeHZH175iK2X2e2tpyrCwttpacdp0prMBaq6BJVJEAhps00W
RCdJiJBuaM2+3eIERYLXh5fA/Dc4sQ==
=crh7
-----END PGP SIGNATURE-----

--fylg3yqaihsqt5zo--
