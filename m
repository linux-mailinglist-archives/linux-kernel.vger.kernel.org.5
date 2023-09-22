Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6897AB7C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjIVRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:36:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43C9C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:36:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjk4U-00070h-DW; Fri, 22 Sep 2023 19:36:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjk4S-008DaU-I5; Fri, 22 Sep 2023 19:36:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjk4S-003xW5-7s; Fri, 22 Sep 2023 19:36:04 +0200
Date:   Fri, 22 Sep 2023 19:35:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v9 3/6] pwm: dwc: add PWM bit unset in get_state call
Message-ID: <20230922173556.qnn5hj5wkxnfckxm@pengutronix.de>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
 <20230907161242.67190-4-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fpcebxxfb6nwe2en"
Content-Disposition: inline
In-Reply-To: <20230907161242.67190-4-ben.dooks@codethink.co.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpcebxxfb6nwe2en
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropping William Salmon and Jude Onyenegecha from Cc: as in the other
mails before]

I'd change the Subject to:

	pwm: dwc: Support DWC_TIM_CTRL_PWM unset in .get_state()

On Thu, Sep 07, 2023 at 05:12:39PM +0100, Ben Dooks wrote:
> If we are not in PWM mode, then the output is technically a 50%
> output based on a single timer instead of the high-low based on
> the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
> and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.
>=20
> This may only be an issue on initialisation, as the rest of the
> code currently assumes we're always going to have the extended
> PWM mode using two counters.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v9:
>  - fixed multi-line comment
>  - put authour back to codethink email from sifive
> v8:
>  - fixed rename issues
> v4:
>  - fixed review comment on mulit-line calculations
> ---
>  drivers/pwm/pwm-dwc-core.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
> index 4b4b7b9e1d82..3fc281a78c9a 100644
> --- a/drivers/pwm/pwm-dwc-core.c
> +++ b/drivers/pwm/pwm-dwc-core.c
> @@ -122,24 +122,32 @@ static int dwc_pwm_get_state(struct pwm_chip *chip,=
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
> +	/*
> +	 * If we're not in PWM, technically the output is a 50-50
> +	 * based on the timer load-count only.
> +	 */
> +	if (ctrl & DWC_TIM_CTRL_PWM) {
> +		duty =3D (ld + 1) * dwc->clk_ns;
> +		period =3D (ld2 + 1)  * dwc->clk_ns;
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

The change looks right,=20

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Do you intend to address the review feedback for the other patches in
this series? It would be sad if you efforts didn't result in these
improvements getting in.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fpcebxxfb6nwe2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUN0HYACgkQj4D7WH0S
/k5dOgf/X6q96/fI3FL5Ezo70VF2IVoJaJX5gDkp0zMSkIuLe1RhSdyPY9GZZbv9
aUUoAEJAtNkJoXUjq1fE9Qf6tzmBvKU9Z/LynKfRilCPw0PE18mEbDV2N0+adfwx
TX8nlSdKb7q7VizW7fB+b480gdbp1WjhrPANiCUqe1bVr4Sp1YRzi3SN/3iAKPcZ
WCvzUUv+ttRd/1Q0qRgwv4/7EOFQoh2rMNh0tujlUCF/uo8rMGwYTmc+9lrkgWRg
FWH59XAYIMrodUKXDulIYq0W9ZAeEtsihsbF73Xdzz8I7sDOG7OK0MOt21CXhgGg
sfUuF61ZtHpbgWNo4vOXzMs8Em5nkw==
=z/3Y
-----END PGP SIGNATURE-----

--fpcebxxfb6nwe2en--
