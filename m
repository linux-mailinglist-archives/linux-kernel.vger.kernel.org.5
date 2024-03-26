Return-Path: <linux-kernel+bounces-119764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1588CCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F86B27417
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEF13CC41;
	Tue, 26 Mar 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO7FrWaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA04134438;
	Tue, 26 Mar 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480214; cv=none; b=QWWSJH5TdLTwtPnmJY0eDhuzK7hf7zSklwoxzlhTCsOckSypcCi3LK6qoVcIO1EyQJDBOJ4+n6C9TJlSbwQDW6Q1MPLBOrq2m3ajaLMc9V4zTsHPgokqHu+CglReR0Id0pAORubEGBfMNZ0E/6p6Kumev5djV4h7Xl8VIM3jRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480214; c=relaxed/simple;
	bh=3M1qAS0qaY6dU8YxYNpC5rsoSfKOWKbZYLeWWUwHtWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIsAI2w77S/N7ZeMbfOBy6odTaMibB6/+daXp/OXuPOcGOzjcuIFanbiaPquUsBvS05ZMdUUkl+74haq8unEDFWxN97wKol5M05ofOwIxueTDGSmvWkPjMBkZXy5fB9u5JhEKQMpJ+epDuII0hn+byvlseZWsNOF9bZm/pzT0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO7FrWaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A0CC433C7;
	Tue, 26 Mar 2024 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711480213;
	bh=3M1qAS0qaY6dU8YxYNpC5rsoSfKOWKbZYLeWWUwHtWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sO7FrWawog+hbJ46x66N8zHtvU6x7suvCHRWEYnAT9VKp+tzHZdFh1K56/vb5R54C
	 zF+ZY1VOfoTjGJQcGx7UyNi2GGEsCyaAN3WyTn+69uW6/KZETaAbb0AuCAW+82stTq
	 Z9Xe0x4eRaoY2JNmepUCNn/DjerJfEAmrROroEv6yDZH/W25gcnVK5fkUIF1qdGF8f
	 BIuTmwM5o8FIbUyZNQ2BjLNGbwNsJQsiuiOiLNjg2pAwGHwtea/ryjlpt6+XNAfILA
	 14zeW2uuBBd6V3pwzgGqoh2HQ7CNYKFfDWWIsd5uNppl6ioPNcSpdIycW7D3IoSTXQ
	 8ckc00zoli0Cw==
Date: Tue, 26 Mar 2024 19:10:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <4241ecb8-07e4-4613-a289-4699c39d0d08@sirena.org.uk>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
 <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
 <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
 <ZgMZhdsDc-bzWa6P@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xG2vf3c+qTeOSXNe"
Content-Disposition: inline
In-Reply-To: <ZgMZhdsDc-bzWa6P@smile.fi.intel.com>
X-Cookie: Equal bytes for women.


--xG2vf3c+qTeOSXNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 08:52:53PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 06:49:58PM +0000, Mark Brown wrote:

> > > > > > I think the ACPI dependency there is as much about hiding the device on
> > > > > > irrelevant platforms as anything else, might be better replaced with an
> > > > > > x86 dependency though.

> Oh, oh, my bad I missed acpi_dev_uid_to_integer() call.
> Okay, with that in mind it's functional dependency for the ACPI-based
> platforms. Do you want to keep it untouched?

That's not actually what I was thinking of (please read what I wrote
above, like I say I was thining about hiding things) but surely if that
was a reason to keep the dependency it'd need to be an actual ACPI
dependency rather than an ||?

--xG2vf3c+qTeOSXNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDHZAACgkQJNaLcl1U
h9BQlwf/eyGeF7yEey7crwLqh326W3HjcKYdvnBz7tljVCHx+GBYNfHailNvkJwX
41ee0V99e5RAIrNBVHFthihRh31OPhrd7rhRKRIT9Ws+D43lZkcK2lhVJNf8iPh9
9BH3fKNXo5/qWsl/BEuUYGRZSSmOhVCvW9WTCdmEX0QLs7owKFF6eNPKZcADcDTx
SCe02DpXSUpbgaku2aB26DyUwuZYGOLn3X5x9tWLKQFyO3gSFGM8mhB5jk13NsTY
9VwPv9wttzE7a52ny9qrZPgpAJIVCnhctEm4IRJ78sdqfAtuw9/p0agdYpUbuH+T
KYjdYWEBXigwwifazvOLGQ42pGFeEw==
=OskD
-----END PGP SIGNATURE-----

--xG2vf3c+qTeOSXNe--

