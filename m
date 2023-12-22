Return-Path: <linux-kernel+bounces-9676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91E281C96C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9581F242A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316A18B15;
	Fri, 22 Dec 2023 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrqUVWwB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369618AE5;
	Fri, 22 Dec 2023 11:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF083C433C9;
	Fri, 22 Dec 2023 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703246029;
	bh=NB+xhNYLL2YOdGSpb6W2PV8TAmLE5kyfK0/CSF8eFIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrqUVWwBAexAmLH6SS89GdnnPZVenC6P6AoqYY0UThGRiUAno75Gh6cHuyckYQINa
	 1Jj+4RW1ipA/uzJyVng4YogC9NnCoVqqG87AO2yIjoi25EGrPE06YyXvpPZsycCT5w
	 v9tr41gtXiPbx7purKSLuw/zjsyao1Xxse05sA2kNtAi0Zux31V4aYOZd7LXWispLx
	 X2reeQDUco/vioRoNOs1JgYoRx7gozydCH3INKjBUBvDKW8s6z868oFgaM+SWyVhWb
	 rctVbS2HVc9lLYWRtgpR9MTJU4wdTtBiCNJOdpJt9DBVUNedKKmQTvwqqyzMAgcZzL
	 UK4pucHaUaDuA==
Date: Fri, 22 Dec 2023 11:53:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	lgirdwood@gmail.com, linux-pwm@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
Message-ID: <54905287-855d-47b4-880f-bfb1b8b1f49d@sirena.org.uk>
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
 <0c99b575-5cf2-4bd6-8cfd-af19f5fd58da@sirena.org.uk>
 <jx2vspy4cfuidf3mwmje675igspxdpgrenw5jz35ud5bm65klc@s4ovjad4fusg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KJDHjVYfXsFaJRDn"
Content-Disposition: inline
In-Reply-To: <jx2vspy4cfuidf3mwmje675igspxdpgrenw5jz35ud5bm65klc@s4ovjad4fusg>
X-Cookie: Familiarity breeds attempt.


--KJDHjVYfXsFaJRDn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:07:41PM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Dec 21, 2023 at 09:45:49PM +0000, Mark Brown wrote:

> > > -       voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_unit);
> > > +       if (pstate.enabled)
> > > +               voltage =3D pwm_get_relative_duty_cycle(&pstate, duty=
_unit);
> > > +       else if (max_uV_duty < min_uV_duty)
> > > +               voltage =3D max_uV_duty;
> > > +       else
> > > +               voltage =3D min_uV_duty;

> > AFAICT this means that enabling the PWM changes the voltage read back
> > which isn't what we expect (other than a change from 0 to target) and is
> > likely to cause issues.  get_voltage() should not change after an
> > enable(), and indeed I'm unclear how this change works?  I'd expect a
> > change in the init_state() function, possibly one that programs the PWM
> > to reflect the actual hardware state but I'm not 100% confident on that
> > without digging into the PWM API more.

> What is your question here? Looking at pwm_regulator_set_voltage() I
> think this lacks a

> 	pstate.enabled =3D true;

> which might also fix Martin's problem?

That's not really a question, it's a statement - I don't see how the
change works at all and as it stands it introduces a problem with the
behaviour when the regulator is enabled.

--KJDHjVYfXsFaJRDn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFeMcACgkQJNaLcl1U
h9DDmAf+MtgUxQLU77WJx9BvRbmHOIj3BusmZ5Vz4wKLhcxHaZ6kCJ6cqgwBBMv0
HLih1IgKLkKVBYuFGW3v3I2a8KjNglIqo9zDArCmFI16cB7zJ/XB7/oOQoBipnxd
ttQtIshQIlBeLbxFQcdK9iecfoyYw4uxVoDdmCwo4OKvTIGYz8DEY2ahHEZdDl20
BpfrAA9JeECG/IuFn3SbSlrKzJ5uNwnctynsPfTOMVqKh7bD6kK2OpVx7W2huR7G
Gsd8LXK2UGABOa5zc4dC5pe4pG2aqRbwRHoUbHOlC6N1ZF0NNP4cmDxQ8YnJZZG3
sQafS5nyBfCGJlWOmwecR7JkXeEFhg==
=Hl8j
-----END PGP SIGNATURE-----

--KJDHjVYfXsFaJRDn--

