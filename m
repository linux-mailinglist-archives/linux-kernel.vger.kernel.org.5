Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24912754BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGOTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGOTdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:33:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790B1E4A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 12:33:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKl1I-0002KP-6v; Sat, 15 Jul 2023 21:33:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKl1G-00Edct-I3; Sat, 15 Jul 2023 21:33:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKl1F-0058RE-Uo; Sat, 15 Jul 2023 21:33:29 +0200
Date:   Sat, 15 Jul 2023 21:33:28 +0200
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
Subject: Re: [PATCH v8 3/5] pwm: dwc: add PWM bit unset in get_state call
Message-ID: <20230715193328.xqvhjcwef3b3f5kj@pengutronix.de>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
 <20230614171457.69191-4-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iayk77fqwmmlajw6"
Content-Disposition: inline
In-Reply-To: <20230614171457.69191-4-ben.dooks@sifive.com>
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


--iayk77fqwmmlajw6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 06:14:55PM +0100, Ben Dooks wrote:
> If we are not in PWM mode, then the output is technically a 50%
> output based on a single timer instead of the high-low based on
> the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
> and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.
>=20
> This may only be an issue on initialisation, as the rest of the
> code currently assumes we're always going to have the extended
> PWM mode using two counters.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v8:
>  - fixed rename issues
> v4:
>  - fixed review comment on mulit-line calculations
> ---
>  drivers/pwm/pwm-dwc-core.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
> index 4b4b7b9e1d82..38cd2163fe01 100644
> --- a/drivers/pwm/pwm-dwc-core.c
> +++ b/drivers/pwm/pwm-dwc-core.c
> @@ -122,24 +122,31 @@ static int dwc_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  {
>  	struct dwc_pwm *dwc =3D to_dwc_pwm(chip);
>  	u64 duty, period;
> +	u32 ctrl, ld, ld2;
> =20
>  	pm_runtime_get_sync(chip->dev);
> =20
> -	state->enabled =3D !!(dwc_pwm_readl(dwc,
> -				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
> +	ctrl =3D dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
> +	ld =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
> +	ld2 =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
> =20
> -	duty =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
> -	duty +=3D 1;
> -	duty *=3D dwc->clk_ns;
> -	state->duty_cycle =3D duty;
> +	state->enabled =3D !!(ctrl & DWC_TIM_CTRL_EN);
> =20
> -	period =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
> -	period +=3D 1;
> -	period *=3D dwc->clk_ns;
> -	period +=3D duty;
> -	state->period =3D period;
> +	/* If we're not in PWM, technically the output is a 50-50

Multiline comments should have /* on a line for itself.

> +	 * based on the timer load-count only.
> +	 */
> +	if (ctrl & DWC_TIM_CTRL_PWM) {
> +		duty =3D (ld + 1) * dwc->clk_ns;
> +		period =3D (ld2 + 1)  * dwc->clk_ns;

s/  / /

> +		period +=3D duty;
> +	} else {
> +		duty =3D (ld + 1) * dwc->clk_ns;
> +		period =3D duty * 2;
> +	}
> =20
>  	state->polarity =3D PWM_POLARITY_INVERSED;
> +	state->period =3D period;
> +	state->duty_cycle =3D duty;
> =20
>  	pm_runtime_put_sync(chip->dev);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iayk77fqwmmlajw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSy9IcACgkQj4D7WH0S
/k5eNAgAnELobhBTeagSJQZz21ZcegsNWW47Mn9Fz+ZnCeRPJQxV8MOXaLQkEN/c
nt7cS6/sEf/hTqPQ0E4Txg6zzlBEcQrMczw3m9Coz8cPLyDfhqPjRBTlF8PdwdlJ
8fg86xcrdaAkF6z31MLOScaddshSX0Mh9ABdzX5VBWZLVkv5oY69YwT5F3RPB29l
oYk5sSyU7RuB2EiumJm9I0bmuHx6MvsYzZtl9gA2iKRJFmuXyxdAViRFMOFRHnKf
1WFQ/3BehN2IjMYaKS6g+4HLWMzklyQe4WGNWPr/p71Fsk4dkQzLqVblJSbtXr4L
cHg2k9ReFrZ66FzWELbb54RXgXfk/Q==
=5SmN
-----END PGP SIGNATURE-----

--iayk77fqwmmlajw6--
