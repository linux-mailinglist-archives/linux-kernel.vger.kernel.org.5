Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE47B7CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjJDJ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjJDJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:59:41 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3B3AC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:59:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyf5-0002vN-0q; Wed, 04 Oct 2023 11:59:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyf3-00Azxr-7z; Wed, 04 Oct 2023 11:59:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyf2-008uPw-UB; Wed, 04 Oct 2023 11:59:20 +0200
Date:   Wed, 4 Oct 2023 11:59:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: make it possible to apply pwm changes in atomic
 context
Message-ID: <20231004095920.ne7yrrthow6tnuvg@pengutronix.de>
References: <cover.1696156485.git.sean@mess.org>
 <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hz3c3li5tw4muaqt"
Content-Disposition: inline
In-Reply-To: <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
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


--hz3c3li5tw4muaqt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Sun, Oct 01, 2023 at 11:40:29AM +0100, Sean Young wrote:
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index dc66e3405bf5..d9679ae5b2be 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -505,7 +505,7 @@ int pwm_apply_state(struct pwm_device *pwm, const str=
uct pwm_state *state)
>  	 * is a bad idea. So make it explicit that calling this function might
>  	 * sleep.
>  	 */
> -	might_sleep();
> +	might_sleep_if(pwm_can_sleep(pwm));
> =20
>  	if (!pwm || !state || !state->period ||
>  	    state->duty_cycle > state->period)

I'd like to have a mechanism to catch drivers that missed to set
=2Ecan_sleep. The best idea I currently have for that is to disable
preemption if IS_ENABLED(CONFIG_PWM_DEBUG) && !pwm_can_sleep(pwm) while
=2Eapply() is running.

> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> index b7c6045c5d08..b8b9392844e9 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -405,6 +405,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
> =20
>  	fpc->soc =3D of_device_get_match_data(&pdev->dev);
>  	fpc->chip.dev =3D &pdev->dev;
> +	fpc->chip.can_sleep =3D true;

As .apply() being callable in non-sleepable context only depends on
=2Eapply() I think a better place for this property is in struct pwm_ops.

Also I wonder if the distinction between atomic and sleeping
pwm_state_apply() should be more explicit. For GPIOs you have a sleeping
variant gpiod_set_value_cansleep() that allows to immediately determine
the intended context in the caller. This would allow that programming
a PWM stays a preemption point (if possible/desired) even if the
underlying hardware/driver is atomic. To not have to touch all consumer
drivers, maybe the pair for pwm should better be

	pwm_apply_state()
	pwm_apply_state_atomic()

instead of a "cansleep" suffix for the sleeping variant? Or maybe it's
better to accept touching all consumer drivers to get semantics similar
to gpio? I couldn't decide quickly what I really like better here, so
that's your chance to comment and influence the outcome :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hz3c3li5tw4muaqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUdN3gACgkQj4D7WH0S
/k7Vgwf+OSTM/5a3jTbEn+zj18WbWk6jQQdj6kqyM47GR36RweXbkLMfbl++5ogJ
z6xjVfn/ov9rQsnn2Em53Zkv7yV/AQb+Hu1tLnuVAsdyxVC/CrCRjWAcrkpoZf6o
Ru7Nf7hs/mJ57jeLgBfPp+k2kwntn470QPIpzLiruZge1YeEwuYKzeHuO7WI4KCb
777XYS5j+tntQRSrlm2dzE8H+5lEqc7mEzG22MAd+yIt4dAsuSAdno2hKLMJx960
4k6Y+UmLJB3cC+BPcAjEllupp1c4turpZ+3P/7D0Fo8P5BgH937nm/wktXJJlPBs
aJ8B/mMpia+WhQcYdq+TjejxlzAf3Q==
=THVI
-----END PGP SIGNATURE-----

--hz3c3li5tw4muaqt--
