Return-Path: <linux-kernel+bounces-9098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FCD81C06C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6897F1F25E36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C17764D;
	Thu, 21 Dec 2023 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADBE342C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024F7763F;
	Thu, 21 Dec 2023 21:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B07CC433C7;
	Thu, 21 Dec 2023 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703195154;
	bh=83bBQ6XdYV+b245TrPV5X70W705tvEUmPr+27VTkDWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADBE342CEuehovJUfEtzqzj2OyhTetXi14tPpYxDO7AM4igyIOHb/nWI1Awj8kXnf
	 RbRsHBS0HBFrXWBG4KSmId++/nhUkEecE0B/2iGFVCvHr/bThsC0LVmX9F2Rq2Lo0A
	 R8qYWqdHH/a0raPrMw5Z/G4W2SS9zOGuYzbvbxpBa/wgLh9lyR6ZelCDgb5SAKnfNP
	 riEaGwoEoQbXleP/NdapGbXap4qjV0BV7UfDepGKXxsgKmRpYOesBTS43SF99Ll/JC
	 5wmoXCnfaTab4MPo44Gd3OJjvZv838G4WZE9/7c9GsNKoZjfIWtO3fZ22gPppV72z3
	 mQDuCUQqRlPTQ==
Date: Thu, 21 Dec 2023 21:45:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: lgirdwood@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
Message-ID: <0c99b575-5cf2-4bd6-8cfd-af19f5fd58da@sirena.org.uk>
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vE+9f8hy4pxOJqe"
Content-Disposition: inline
In-Reply-To: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
X-Cookie: Results are not typical.


--3vE+9f8hy4pxOJqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 21, 2023 at 10:12:22PM +0100, Martin Blumenstingl wrote:

> It turns out that at least some bootloader versions are keeping the PWM
> output disabled. This is not a problem due to the specific design of the
> regulator: when the PWM output is disabled the output pin is pulled LOW,
> effectively achieving a 0% duty cycle (which in return means that VDDEE
> voltage is at 1140mV).

Hrm.  Perhaps the regulator should figure out that it's on with a
minimum voltage of 1.14V in this case - AIUI that broadly corresponds to
your change except for the fact that it doesn't recognise that there's
actually an output in this case since it assumes that disabling the PWM
disables the output which isn't the case with this hardware.  We'd need
to know more about the PWM in that case though I think.

> The problem comes when the pwm-regulator driver tries to initialize the
> PWM output. To do so it reads the current state from the hardware, which
> is:
>   period: 3666ns
>   duty cycle: 3333ns (= ~91%)
>   enabled: false
> Then those values are translated using the continuous voltage range to
> 860mV.

> Later, when the regulator is being enabled (either by the regulator core
> due to the always-on flag or first consumer - in this case the lima
> driver for the Mali-450 GPU) the pwm-regulator driver tries to keep the
> voltage (at 860mV) and just enable the PWM output. This is when things
> start to go wrong as the typical voltage used for VDDEE is 1100mV.

So, the constraints say that the 860mV voltage is within range.  Where
does the requirement for 1.1V come from in this situation?  Is it just
that lima hasn't started yet and requires the 1.1V for hardware init
(and presumably power on) even if it can use a lower voltage at runtime?

> @@ -157,7 +157,12 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)

> -       voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
> +       if (pstate.enabled)
> +               voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
> +       else if (max_uV_duty < min_uV_duty)
> +               voltage = max_uV_duty;
> +       else
> +               voltage = min_uV_duty;

AFAICT this means that enabling the PWM changes the voltage read back
which isn't what we expect (other than a change from 0 to target) and is
likely to cause issues.  get_voltage() should not change after an
enable(), and indeed I'm unclear how this change works?  I'd expect a
change in the init_state() function, possibly one that programs the PWM
to reflect the actual hardware state but I'm not 100% confident on that
without digging into the PWM API more.

--3vE+9f8hy4pxOJqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWEsgwACgkQJNaLcl1U
h9Azcwf/YiAYc+dIL60gpDG2EdW6ZdJE1MooApraQXp3hekHxQgjfTpijmrwPwz0
u9iWtTxs3pyDB8AwLsQkblCCyGIc667VsSltlM1HJPyRqnWJpJU3ntfkyKrElHAO
zZwIFxr3etFy5hpwsgGr387RY5XivXOPI8bXE4WBboQYjHw76XOfGIwZdcQOtVil
+67CxcqImFxvbu8qwwJIHvwt+Dzgn0xdwg6Gl5hazuzO7ponnuQKXfTvfcSzpfLy
C1jIjwa1j1piPynPTyCAueOP+1zPe2+7UeV8y0m9mqc1y8mejMLFNbvU5+hLDj8V
axE2b+894gMAtr7oHYyIb6urVYKk3w==
=yfVG
-----END PGP SIGNATURE-----

--3vE+9f8hy4pxOJqe--

