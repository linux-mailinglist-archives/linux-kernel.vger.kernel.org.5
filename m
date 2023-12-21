Return-Path: <linux-kernel+bounces-9114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA83C81C0CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B41286C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178177F18;
	Thu, 21 Dec 2023 22:07:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53F77657
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGRCi-0003Yy-Ba; Thu, 21 Dec 2023 23:07:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGRCe-000cWC-UQ; Thu, 21 Dec 2023 23:07:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGRCf-001VNL-Nv; Thu, 21 Dec 2023 23:07:41 +0100
Date: Thu, 21 Dec 2023 23:07:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	lgirdwood@gmail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
Message-ID: <jx2vspy4cfuidf3mwmje675igspxdpgrenw5jz35ud5bm65klc@s4ovjad4fusg>
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
 <0c99b575-5cf2-4bd6-8cfd-af19f5fd58da@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2cosdtqibfwxuus"
Content-Disposition: inline
In-Reply-To: <0c99b575-5cf2-4bd6-8cfd-af19f5fd58da@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--x2cosdtqibfwxuus
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 09:45:49PM +0000, Mark Brown wrote:
> On Thu, Dec 21, 2023 at 10:12:22PM +0100, Martin Blumenstingl wrote:
>=20
> > It turns out that at least some bootloader versions are keeping the PWM
> > output disabled. This is not a problem due to the specific design of the
> > regulator: when the PWM output is disabled the output pin is pulled LOW,
> > effectively achieving a 0% duty cycle (which in return means that VDDEE
> > voltage is at 1140mV).
>=20
> Hrm.  Perhaps the regulator should figure out that it's on with a
> minimum voltage of 1.14V in this case - AIUI that broadly corresponds to
> your change except for the fact that it doesn't recognise that there's
> actually an output in this case since it assumes that disabling the PWM
> disables the output which isn't the case with this hardware.  We'd need
> to know more about the PWM in that case though I think.
>=20
> > The problem comes when the pwm-regulator driver tries to initialize the
> > PWM output. To do so it reads the current state from the hardware, which
> > is:
> >   period: 3666ns
> >   duty cycle: 3333ns (=3D ~91%)
> >   enabled: false
> > Then those values are translated using the continuous voltage range to
> > 860mV.
>=20
> > Later, when the regulator is being enabled (either by the regulator core
> > due to the always-on flag or first consumer - in this case the lima
> > driver for the Mali-450 GPU) the pwm-regulator driver tries to keep the
> > voltage (at 860mV) and just enable the PWM output. This is when things
> > start to go wrong as the typical voltage used for VDDEE is 1100mV.
>=20
> So, the constraints say that the 860mV voltage is within range.  Where
> does the requirement for 1.1V come from in this situation?  Is it just
> that lima hasn't started yet and requires the 1.1V for hardware init
> (and presumably power on) even if it can use a lower voltage at runtime?
>=20
> > @@ -157,7 +157,12 @@ static int pwm_regulator_get_voltage(struct regula=
tor_dev *rdev)
>=20
> > -       voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_unit);
> > +       if (pstate.enabled)
> > +               voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_u=
nit);
> > +       else if (max_uV_duty < min_uV_duty)
> > +               voltage =3D max_uV_duty;
> > +       else
> > +               voltage =3D min_uV_duty;
>=20
> AFAICT this means that enabling the PWM changes the voltage read back
> which isn't what we expect (other than a change from 0 to target) and is
> likely to cause issues.  get_voltage() should not change after an
> enable(), and indeed I'm unclear how this change works?  I'd expect a
> change in the init_state() function, possibly one that programs the PWM
> to reflect the actual hardware state but I'm not 100% confident on that
> without digging into the PWM API more.

What is your question here? Looking at pwm_regulator_set_voltage() I
think this lacks a

	pstate.enabled =3D true;

which might also fix Martin's problem?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x2cosdtqibfwxuus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWEtywACgkQj4D7WH0S
/k6M0Af/TGEbrLK/Utzm3XspLvBB3NL5pnX/wq/TmPVKOsyLBI/H/xIkZ6WNGUhR
y9JW9ITr0jNqfIRnmUdElLET6zdTyxH2XS9d5gU3rE7tL3MVhq0VUUATX2pfq8e6
YyVu3682qQmis6EpKcVOH2GKGvhpIDJ0lRaz4iEGCVUPNSNvsJH/RYH1WZDlXoCb
x7hDT718iTVP2MYIqogH9RA9H4bMcwet+U4qEH2RTRUfl/u92S6wYW0AL5O8GCoV
05s8/E9D6AGovoumH/jfaYH3j9C19IUF7rZNjts73s18cyfaLezFdGtRE0UK1xVI
gzxdwPbrmzeYi5sELQopgiUlZN6HyA==
=25PZ
-----END PGP SIGNATURE-----

--x2cosdtqibfwxuus--

