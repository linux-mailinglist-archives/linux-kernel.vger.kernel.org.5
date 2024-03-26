Return-Path: <linux-kernel+bounces-119854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D479C88CDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F8A1C39E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE6D13D2B6;
	Tue, 26 Mar 2024 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIkA7gJJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C913D29F;
	Tue, 26 Mar 2024 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483382; cv=none; b=tP4QF8w46kE2tKMU1TmSkMJo2wiXZN+kQVfoFGDmSS5a8Ugfoq3urRu1XcgOPO+rVs79MgF1No/EL8Nu55FLtC/pjHx0JUq0aWqzDIDQ7L53xlSlzh5gd2HBkEt2yKabTX0Zd4dJiyMoVcJtIULU05WWP8QLQIgCU1aizWZ0lcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483382; c=relaxed/simple;
	bh=7tmqvpTRkD+o3/nmAgOgsi6solOtljWbVAAl3xIVKp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqRMNvGmYba6IfIaTJwfRumgEwa/E0PvSJyOBb7ZX3mP3ck3cefN7Y7FOrjTak7VlEWFHFE69kW4y8WTL5hRqmlF0HFeayR/HxxrDJhVnvqyiUyhqN/SwGpaa/M4NkmfjYmBSybwFaJ2Zj3YfIJKe1g+kTWZAFt/YPHp6Ps8LWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIkA7gJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6848EC43609;
	Tue, 26 Mar 2024 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711483382;
	bh=7tmqvpTRkD+o3/nmAgOgsi6solOtljWbVAAl3xIVKp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIkA7gJJnNbg2GwiZRAoyy7Qw7f1pSGZ45JRl75cvuyEK/0bmH/4nXDWNh5Uyr2YA
	 KfshXEFyMbXuiWmTklrQA0zitvOGt8/jSsB2g9UWzBbhUH/aUg8pL9qs1MN9fL5DQ2
	 VWzrnA2FfpUkYgjNeWeeQJErmSpiKZyA9FHC7cJ3ffxsYJsvS0ExF7YGPVODS4y/ql
	 8lHGsUviaFApeVQZ0zkknlysq2U0VvzXZJInq2Sj0QXO3aWiMyN5hKxThJo+cg+zxp
	 M9pUXS0GLjP33lKWnzGceLptHrfXRY1k+csOYBijz6XoxPOFNUQrfD6yf2Ae1/z9Eu
	 p5QmUBeerqPCg==
Date: Tue, 26 Mar 2024 20:02:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 07/10] spi: pxa2xx: Provide num-cs for Sharp PDAs via
 device properties
Message-ID: <c18186c0-63d8-4406-add0-980f723e3528@sirena.org.uk>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-8-andriy.shevchenko@linux.intel.com>
 <dcdf8c46-acdc-466d-afc6-caf0e0fa39e8@sirena.org.uk>
 <ZgMY3AeC1Jnh1Oru@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zZKm2I/fgVnGlPhH"
Content-Disposition: inline
In-Reply-To: <ZgMY3AeC1Jnh1Oru@smile.fi.intel.com>
X-Cookie: Equal bytes for women.


--zZKm2I/fgVnGlPhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 08:50:04PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 06:21:48PM +0000, Mark Brown wrote:
> > On Tue, Mar 26, 2024 at 08:07:57PM +0200, Andy Shevchenko wrote:

> > > Since driver can parse num-cs device property, replace platform data
> > > with this new approach.

> > But why?

> To be able to hide the header's contents from public.
> Should I update the commit message?

That would definitely help, but it's hard to see what the actual benefit
is here.  It's removing platform data without doing the more difficult
bit where the platform gets converted to DT.

> > > +static const struct property_entry spitz_spi_properties[] = {
> > > +	PROPERTY_ENTRY_U32("num-cs", 3),
> > > +	{ }
> > > +};

> > This is just platform data with less validation AFAICT.

> I'm not sure what validation you are expecting here. It should be done via

Well, the problem with swnode is that there's no validation to expect -
it's an inherent problem with swnode.

> DT schema ideally when the platform gets converted to DT. This change is
> an interim to that (at least it makes kernel side better). After the platform
> code may be gone completely or converted. If the latter happens, we got
> the validation back.

It is not clear to me that this makes the kernel side better, it just
seems to be rewriting the platform data for the sake of it.  If it was
converting to DT there'd be some stuff from it being DT but this keeps
everything as in kernel as board files, just in a more complex form.

> In any case it's not worse than plain DT property handling in the kernel.
> The validation in that case is done elsewhere. Since the property is defined
> in board files the assumed validation is done during development/review
> stages. But OTOH for the legacy code we need not to touch the property
> provider more than once. We are _not_ expecting this to be spread.

I'm guessing you're just checking this by inspection though...

--zZKm2I/fgVnGlPhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDKfAACgkQJNaLcl1U
h9APKgf/ZiCrhzWY5rHrjSsi4dsw9E0jIx7pjedEZIq54G4rjJ4DUK59LicC3wvh
7FdABUVRBE1zc7V+pYXweG6Beg0Bk2reKvCRCT3nd5PXMHXTcFiCgfmNLJAW2gcv
V1W4ozSnW2Yrz66nFlhKw6Qpp8VfhGx58NJPLB9iQ/2Utd3F529EhS2gGDmZb1Zf
obTvGyjpNaYk4Rr0ihVXI3+v8Gam5nMtTYsX4N+J2zCVM2sLjnztKOL5bYYSgdF4
dHnnY+5VdgzojBNWm9fxpDvI55IK5zKO98ti6TC+ETmNobjCVNRm8e0Hs7kfSRjy
eNkYIBV3LHLCiUGOecNba+VeuiTWSQ==
=uNc5
-----END PGP SIGNATURE-----

--zZKm2I/fgVnGlPhH--

