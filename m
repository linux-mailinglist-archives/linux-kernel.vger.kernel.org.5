Return-Path: <linux-kernel+bounces-142106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7848A279C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869F02858F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755115337A;
	Fri, 12 Apr 2024 07:05:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0452F99
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905540; cv=none; b=qqnDQlq9tc1IujvZ8H3RJTzKC9ifn5x8PQwq84FcmcLEYAfj5n1YGwyLr1vu8roP30BTkGDb2LMU2CE5FlYGHSqast6oN2VwMeTsgPxwc/hONiRjW1XyHFJoFxXK3TCbc8MmfrG0OWWA2uPpVaTbfi/iSVv3pZucjKb4/ccrwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905540; c=relaxed/simple;
	bh=xibTtOM7xMiZd16Ap7dAaQ4ltDSATcoqeP9GxusGiIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLUeN0y3s0aTG9TvmRXo/Zl5W35WdHVH0WbHORj3uRATAyMUJgga7bQKR4Onra6Zh/iPAmauGvrtNnHCOhOH8DMJzMRTFowF6rautsvQKkKKJ4pscEIPC4XSWz1H5cnk0TBUgnZUyzjlB4A9f8K+gDVOvqH2ztETpOFzgoUsj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvAyb-0002TQ-3q; Fri, 12 Apr 2024 09:05:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvAya-00Bpko-Dt; Fri, 12 Apr 2024 09:05:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvAya-0011ip-14;
	Fri, 12 Apr 2024 09:05:32 +0200
Date: Fri, 12 Apr 2024 09:05:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, conor@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, thierry.reding@gmail.com, vincent.chen@sifive.com, 
	zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v9 3/3] pwm: sifive: Fix the error in the idempotent test
 within the pwm_apply_state_debug function
Message-ID: <xf6ympnaljfjztptb5w5qdpuluckptozdz5a7gtuycsev32ngr@x2ovibqv6evr>
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-4-nylon.chen@sifive.com>
 <jvwgsszvs4jtcytcphsdjulzgqfqzdp4sisu236ddwsqgmvriw@ngi4ljgh5b74>
 <CAHh=Yk92=hp+kaTJWL13_jwJ5gzAAi8gbRF=Ns9=yq2trRUQEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q2q3dixgumi352xf"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk92=hp+kaTJWL13_jwJ5gzAAi8gbRF=Ns9=yq2trRUQEg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--q2q3dixgumi352xf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 10:01:39AM +0800, Nylon Chen wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=E5=
=B9=B43=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:17=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > Hello,
> >
> > On Thu, Feb 22, 2024 at 04:12:31PM +0800, Nylon Chen wrote:
> > > Round the result to the nearest whole number. This ensures that
> > > real_period is always a reasonable integer that is not lower than the
> > > actual value.
> > >
> > > e.g.
> > > $ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/brightne=
ss
> > > $ .apply is not idempotent (ena=3D1 pol=3D0 1739692/4032985) -> (ena=
=3D1 pol=3D0 1739630/4032985)
> > >
> > > Co-developed-by: Zong Li <zong.li@sifive.com>
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > ---
> > >  drivers/pwm/pwm-sifive.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index a586cfe4191b..bebcbebacccd 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_si=
five_ddata *ddata,
> > >
> > >       /* As scale <=3D 15 the shift operation cannot overflow. */
> > >       num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDT=
H + scale);
> > > -     ddata->real_period =3D div64_ul(num, rate);
> > > +     ddata->real_period =3D DIV_ROUND_UP_ULL(num, rate);
> > >       dev_dbg(ddata->chip.dev,
> > >               "New real_period =3D %u ns\n", ddata->real_period);
> > >  }
> Hi Uwe
> >
> > pwm_sifive_apply has a DIV64_U64_ROUND_CLOSEST(). I wonder if that needs
> > adaption, too?!
> According to my experiments, no adjustment is necessary.

Did you enable PWM_DEBUG and tested with something like:

	seq 5000 100000 | while read p; do echo p > /sys/class/pwm/pwmchipX/pwmY/p=
eriod; done

and then verified that this test didn't result in kernel messages about
wrong settings?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q2q3dixgumi352xf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYY3TsACgkQj4D7WH0S
/k5FmwgAhyTeX2Ko0mzYcNZo9k+LH+bFP8d3VU9un+janzbRfN4UG64QH80Ls1jD
1lWgqzrf5b9lxnjZqX58GN92ZEbi7F78BS5FyTZT+cQieFtdunkHI1SPXBa2ujhX
NaLiKPSuxY6HTwDvNhkFLo0hJ9SEVXhWKfZBRdKI2pKDYbkMuqSQYOkL5UQcia9V
3LJCyqVdJemdb1AfTHMCM0wJxx7MJlDE/WIZVISQFI05FQ8ttx/61zQ5ehIaVvAZ
0+YhpDDxiGpiy6RVDTfaF48m0y49BUQ6vU4C+H2awBayeFgjeM6SIxq0aQLgyLC9
vtD3qVxYIgKze58pKVRfmGyQ4BINxg==
=jwk9
-----END PGP SIGNATURE-----

--q2q3dixgumi352xf--

