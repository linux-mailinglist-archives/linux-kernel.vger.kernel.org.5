Return-Path: <linux-kernel+bounces-9677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA381C970
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520FEB23536
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894E17985;
	Fri, 22 Dec 2023 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGeuGLoB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094817735;
	Fri, 22 Dec 2023 11:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A5DC433C8;
	Fri, 22 Dec 2023 11:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703246099;
	bh=MniMhNCozgeNpLkvpDvRts/bFndN88of1ENcKV/hfR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGeuGLoBSuxU+iLQjNorjscPkD3nPNqumthsvoP3JjJc94TSLtt6IZY81T0QKwxww
	 80gEpDrawf6QijZgYmhEo/Md+SRl3kDWm+jU8o34rnCJrMa/UBoRYLfRdc7R5aP3Va
	 zDMbgUOS/09sPm8tfPGmJXAW47Rfv+8QoFmzIN+gapbJrEa/t1s3inRfyAfw4PzImW
	 wWkPlmmtbhucDYGjE5tuaLh8kwI9lyU33TsRwMQoWJfKuxnNce6O13Crfq6vGKe3J2
	 uaqaEUI9SCjeyKARlkesdwr3SICCkKOpCEEWNnkU6CLhEahWrg1KBVvG3cFY7uwinS
	 IPom6sp5voG8w==
Date: Fri, 22 Dec 2023 11:54:54 +0000
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
Message-ID: <e32e0ccd-0e7c-4d74-aa2c-0b8155d97698@sirena.org.uk>
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
 <0c99b575-5cf2-4bd6-8cfd-af19f5fd58da@sirena.org.uk>
 <CAFBinCDJnVzE2sMwu52MQGTKW7dtCuUoj63ZZHhJPJO0+dZDkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ege4RUChGIoDBWw+"
Content-Disposition: inline
In-Reply-To: <CAFBinCDJnVzE2sMwu52MQGTKW7dtCuUoj63ZZHhJPJO0+dZDkg@mail.gmail.com>
X-Cookie: Familiarity breeds attempt.


--ege4RUChGIoDBWw+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:42:29PM +0100, Martin Blumenstingl wrote:
> On Thu, Dec 21, 2023 at 10:45=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:

> > Hrm.  Perhaps the regulator should figure out that it's on with a
> > minimum voltage of 1.14V in this case - AIUI that broadly corresponds to
> > your change except for the fact that it doesn't recognise that there's
> > actually an output in this case since it assumes that disabling the PWM
> > disables the output which isn't the case with this hardware.  We'd need
> > to know more about the PWM in that case though I think.

> If you have any specific questions then feel free to ask.
> Generally it's a very simple PWM controller:
> - when disabled the output is LOW
> - when enabled the output matches the requested period and duty cycle
> as best as possible (depending on the available input clocks)

We would need to know more at runtime to do the correct thing I think.

--ege4RUChGIoDBWw+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFeQ0ACgkQJNaLcl1U
h9BNywgAgAfg176tAU+aqJ+Jp2hFmi4zZ/c3euJEMcr+4MM60eFhd6+i3b9uZsja
ZgEGxvrF4wFzku+4Kkv2Qip7VS5XaAIc/ewN+vzteFnL2ExWwx3FjIi8vgtTi/5Q
FfOHVvo2US7qt+pfwrCfEMMv4vgWfHfz557RYnnkiiY08sVaOprSFkMtFuxVLNWo
YrTHjUUzQv/ComapN/ZSVCjVY96cs4K/0ZiRqys6Xauh2sJBvlOtEvSPPlVxh30S
ErxN1OwlflViYeqHSoNYIR1lzOEpKanAGRx6FGDQaOsK4ES7JEShiaw0gUYL+8cE
TiL63LyYDuOhE2DJuWaetMBvLGo1qg==
=vyyB
-----END PGP SIGNATURE-----

--ege4RUChGIoDBWw+--

