Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306F80CE55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343736AbjLKO1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345041AbjLKO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:26:35 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865710C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:26:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rChEH-000818-Md; Mon, 11 Dec 2023 15:25:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rChEG-00F7by-2i; Mon, 11 Dec 2023 15:25:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rChEF-000yvL-Pk; Mon, 11 Dec 2023 15:25:51 +0100
Date:   Mon, 11 Dec 2023 15:25:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] pwm: Make it possible to apply PWM changes in
 atomic context
Message-ID: <20231211142549.llrwt2oy3mabiutd@pengutronix.de>
References: <cover.1702282806.git.sean@mess.org>
 <aacf0081cbc36d6b21cbc207e40b6df54953214d.1702282807.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6fsr2tk6mbr2hus"
Content-Disposition: inline
In-Reply-To: <aacf0081cbc36d6b21cbc207e40b6df54953214d.1702282807.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6fsr2tk6mbr2hus
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 08:24:53AM +0000, Sean Young wrote:
> Some PWM devices require sleeping, for example if the pwm device is
> connected over I2C. However, many PWM devices could be used from atomic
> context, e.g. memory mapped PWM. This is useful for, for example, the
> pwm-ir-tx driver which requires precise timing. Sleeping causes havoc
> with the generated IR signal.
>=20
> Since not all PWM devices can support atomic context, we also add a
> pwm_might_sleep() function to check if is not supported.
>=20
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  Documentation/driver-api/pwm.rst |  9 +++++
>  MAINTAINERS                      |  2 +-
>  drivers/pwm/core.c               | 64 ++++++++++++++++++++++++++------
>  drivers/pwm/pwm-renesas-tpu.c    |  1 -
>  include/linux/pwm.h              | 29 ++++++++++++++-
>  5 files changed, 89 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/=
pwm.rst
> index f1d8197c8c430..3c28ccc4b6113 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -46,6 +46,15 @@ After being requested, a PWM has to be configured usin=
g::
>  This API controls both the PWM period/duty_cycle config and the
>  enable/disable state.
> =20
> +PWM devices can be used from atomic context, if the PWM does not sleep. =
You
> +can check if this the case with::
> +
> +        bool pwm_might_sleep(struct pwm_device *pwm);
> +
> +If false, the PWM can also be configured from atomic context with::
> +
> +	int pwm_apply_atomic(struct pwm_device *pwm, struct pwm_state *state);
> +
>  As a consumer, don't rely on the output's state for a disabled PWM. If i=
t's
>  easily possible, drivers are supposed to emit the inactive state, but so=
me
>  drivers cannot. If you rely on getting the inactive state, use .duty_cyc=
le=3D0,
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2a9e0b5594e7..b55ac220b923d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17585,7 +17585,7 @@ F:	drivers/video/backlight/pwm_bl.c
>  F:	include/dt-bindings/pwm/
>  F:	include/linux/pwm.h
>  F:	include/linux/pwm_backlight.h
> -K:	pwm_(config|apply_might_sleep|ops)
> +K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
> =20
>  PXA GPIO DRIVER
>  M:	Robert Jarzmik <robert.jarzmik@free.fr>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index c2d78136625d5..5fd35cda5786b 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -433,24 +433,15 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>  }
> =20
>  /**
> - * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
> + * pwm_apply_unchecked() - atomically apply a new state to a PWM device
>   * @pwm: PWM device
>   * @state: new state to apply
>   */
> -int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state)
> +static int pwm_apply_unchecked(struct pwm_device *pwm, const struct pwm_=
state *state)
>  {
>  	struct pwm_chip *chip;
>  	int err;
> =20
> -	/*
> -	 * Some lowlevel driver's implementations of .apply() make use of
> -	 * mutexes, also with some drivers only returning when the new
> -	 * configuration is active calling pwm_apply_might_sleep() from atomic =
context
> -	 * is a bad idea. So make it explicit that calling this function might
> -	 * sleep.
> -	 */
> -	might_sleep();
> -
>  	if (!pwm || !state || !state->period ||
>  	    state->duty_cycle > state->period)
>  		return -EINVAL;
> @@ -471,16 +462,65 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, c=
onst struct pwm_state *state)
> =20
>  	pwm->state =3D *state;
> =20
> +	return 0;
> +}
> +
> +/**
> + * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @state: new state to apply
> + */
> +int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state)
> +{
> +	int err;
> +
> +	/*
> +	 * Some lowlevel driver's implementations of .apply() make use of
> +	 * mutexes, also with some drivers only returning when the new
> +	 * configuration is active calling pwm_apply_might_sleep() from atomic =
context
> +	 * is a bad idea. So make it explicit that calling this function might
> +	 * sleep.
> +	 */
> +	might_sleep();
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
> +		/*
> +		 * Catch any drivers that have been marked as atomic but
> +		 * that will sleep anyway.
> +		 */
> +		non_block_start();
> +		err =3D pwm_apply_unchecked(pwm, state);
> +		non_block_end();
> +	} else {
> +		err =3D pwm_apply_unchecked(pwm, state);
> +	}
> +
>  	/*
>  	 * only do this after pwm->state was applied as some
>  	 * implementations of .get_state depend on this
>  	 */
>  	pwm_apply_debug(pwm, state);

I think this is broken. Currently pwm_apply_state_debug() is only called
if chip->ops->apply() succeeds.

> -	return 0;
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
> =20
> +/**
> + * pwm_apply_atomic() - apply a new state to a PWM device from atomic co=
ntext
> + * Not all PWM devices support this function, check with pwm_might_sleep=
().
> + * @pwm: PWM device
> + * @state: new state to apply
> + */
> +int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *sta=
te)
> +{
> +	WARN_ONCE(!pwm->chip->atomic,
> +		  "sleeping PWM driver used in atomic context");
> +
> +	return pwm_apply_unchecked(pwm, state);
> +}
> +EXPORT_SYMBOL_GPL(pwm_apply_atomic);
> +
>  /**
>   * pwm_capture() - capture and report a PWM signal
>   * @pwm: PWM device
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index ce92db1f85113..28265fdfc92a9 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -11,7 +11,6 @@
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>

Unrelated change

> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b64b8a82415c4..495af3627939c 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -285,6 +285,7 @@ struct pwm_ops {
>   * @npwm: number of PWMs controlled by this chip
>   * @of_xlate: request a PWM device given a device tree PWM specifier
>   * @of_pwm_n_cells: number of cells expected in the device tree PWM spec=
ifier
> + * @atomic: can the driver's ->apply() be called in atomic context
>   * @pwms: array of PWM devices allocated by the framework
>   */
>  struct pwm_chip {
> @@ -297,6 +298,7 @@ struct pwm_chip {
>  	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
>  					const struct of_phandle_args *args);
>  	unsigned int of_pwm_n_cells;
> +	bool atomic;
> =20
>  	/* only used internally by the PWM framework */
>  	struct pwm_device *pwms;
> @@ -305,6 +307,7 @@ struct pwm_chip {
>  #if IS_ENABLED(CONFIG_PWM)
>  /* PWM user APIs */
>  int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state);
> +int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *sta=
te);
>  int pwm_adjust_config(struct pwm_device *pwm);
> =20
>  /**
> @@ -375,6 +378,17 @@ static inline void pwm_disable(struct pwm_device *pw=
m)
>  	pwm_apply_might_sleep(pwm, &state);
>  }
> =20
> +/**
> + * pwm_might_sleep() - is pwm_apply_atomic() supported?
> + * @pwm: PWM device
> + *
> + * Returns: false if pwm_apply_atomic() can be called from atomic contex=
t.
> + */
> +static inline bool pwm_might_sleep(struct pwm_device *pwm)
> +{
> +	return !pwm->chip->atomic;
> +}
> +
>  /* PWM provider APIs */
>  int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
>  		unsigned long timeout);
> @@ -403,16 +417,27 @@ struct pwm_device *devm_fwnode_pwm_get(struct devic=
e *dev,
>  				       struct fwnode_handle *fwnode,
>  				       const char *con_id);
>  #else
> +static inline bool pwm_might_sleep(struct pwm_device *pwm)
> +{
> +	return true;
> +}
> +
>  static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
>  					const struct pwm_state *state)
>  {
>  	might_sleep();
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int pwm_apply_atomic(struct pwm_device *pwm,
> +				   const struct pwm_state *state)
> +{
> +	return -EOPNOTSUPP;
>  }
> =20
>  static inline int pwm_adjust_config(struct pwm_device *pwm)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;

I'd do s/-ENOTSUPP/-EOPNOTSUPP/ in a separate change.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f6fsr2tk6mbr2hus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV3G+wACgkQj4D7WH0S
/k5Obwf9G3iG1hGqAAVyrqJcdbgJCxYcJU0oWp9jxrLtW4AvPSNwvWzDWszfNGcQ
EBB1dRwc2Qx3G/ueVN2LwN6Q0pZeTltJsqvGR+hH0BQNlkn8AhmnPjUdePGOCI2H
IkTOYmU0YhTw/6C0eS2i+8tJXsHoYp0keaJnUSmI81ir7XSEpkhvi6qXCVEslJad
TBmKf3YjVGgBrgcAk9rivC2Zd2KdNhVF1SHKj9CqB/WdGVoK3/UpNf5EQUtWmI8A
gN5UiybPUkTNChBxIogDbB6lv1KHq2YR9t5bsfnw+nQuUpMm+sJzs+qejMP0yhSZ
bn6F4jLIp86mRMCf/7F1Jox95uiTrA==
=T49B
-----END PGP SIGNATURE-----

--f6fsr2tk6mbr2hus--
