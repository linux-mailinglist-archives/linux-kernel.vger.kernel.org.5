Return-Path: <linux-kernel+bounces-119681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D408788CBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8980C1F2136D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BFC86653;
	Tue, 26 Mar 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJJW8r4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20E84D0D;
	Tue, 26 Mar 2024 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477521; cv=none; b=gAnSuS/EkpwgRXUDnw0ikBHkt2N8QlfhTm0od/A5wBGlm6l3xTz5ydWtBvdWJMs3kT0J9TMr8QmHSpFrHFxTYu+AYsyo/3rVOhIAy+WwZLsjhybQE+cLZYtyaMUShwsHu791QKilFG905UvXmWwURE13sC9sB1NEmW/IOHnhZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477521; c=relaxed/simple;
	bh=4/3THOttPz5Qu15zCS8JH6C3FepA7gKJ932fmlPVR6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y20wrv27RYU4yHpi8J+rwX3jTs9biFKoXFrFas64VHAaDl5HHMT1nKBfHL9acfHLlP1QC4C6aAFyGVCYOodEK1n8GVFKWT3gbD7mxs0XR+bqVjj2IUqE8WfW03DmILlmbQOZ0vyz6IzegKW3+6/tURxTY8nsfOSW3+p+HjCy5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJJW8r4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D06C43394;
	Tue, 26 Mar 2024 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711477520;
	bh=4/3THOttPz5Qu15zCS8JH6C3FepA7gKJ932fmlPVR6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJJW8r4kq0lcIzSV4pRjRnaLPxKaJAVW42p2Xeo3aicdQ0ZBN3CHv3z9anoUR2bvU
	 rtOwgQMCOwz4wUltg5VLsXmZ2Sy7obp5QG3Y2wSGlKpK6Iy/HMbXNMFA8p/bH21KsP
	 +KxsvKVqxReobgkE7azM+cyRQzH3Inhgr88yeRRoVpmWNocjZfxNW5bt6mSy96Je20
	 +eooyUqEYqompXa7ePKHPJfp2T+RGbpCNW3cxBkWm4Vc1B7zc5RnIT/RZNoPOwmq+b
	 xf364TMT3lvUNrUnvul7Ria0fSVtGHXxW6EA5itqlNhN//Fnmm9yP3uhA2rtTDeMpL
	 qpi7Sysyumx9A==
Date: Tue, 26 Mar 2024 18:25:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqMNDPxQ7Z44ALAp"
Content-Disposition: inline
In-Reply-To: <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
X-Cookie: Equal bytes for women.


--nqMNDPxQ7Z44ALAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 08:22:59PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 06:16:28PM +0000, Mark Brown wrote:
> > On Tue, Mar 26, 2024 at 08:07:51PM +0200, Andy Shevchenko wrote:

> > > Drop rather useless use of ACPI_PTR() and of_match_ptr().
> > > It also removes the necessity to be dependent on ACPI and
> > > of.h inclusion.

> > I think the ACPI dependency there is as much about hiding the device on
> > irrelevant platforms as anything else, might be better replaced with an
> > x86 dependency though.

> The whole idea behind ACPI_PTR() (which seems following the of_match_ptr()
> implementation) looks premature. Now we have a lot of patches from DT people to
> remove of_match_ptr(), i.o.w. make the ID visible even on non-OF platforms.

> Having the list of supported IDs is not bad thing anyway as it might help
> to google for a device elsewhere, for example.

That's nice but I'm not sure what that has to do with the dependency on
ACPI?

--nqMNDPxQ7Z44ALAp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDEwsACgkQJNaLcl1U
h9CabQf/fdfIpQGLMs/xXGW2wYEI/t85fzOrQZTL/XAOJ9YW3G+4IZnU2d+/75Hw
HshUkIAUlJNueW8tQ+U86tHg9HKeAsoxmAQzLADbrQqHv/GmJD25jQKhQjhpxB9c
NzMRqseXT75kAO12GfmTQwvzbqf3DH++D+9QcpQa4r2/VoBDe55nm/cTMAlA9Nev
7V2CmGDiaffHAIOiJS/kjD3LFv3JTDdCa1MRF5BfyMdMUAH6o+rI2sqsNa1CF17C
q/dRfL/uQina4tZ63sKlMOfGbPd3KFuksPJhk7XiyQmS0DQUbp2awApM9veNN4nr
FXM29tRT8LGWCNkH53Uk0wXaxG4/Bg==
=YGXS
-----END PGP SIGNATURE-----

--nqMNDPxQ7Z44ALAp--

