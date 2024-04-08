Return-Path: <linux-kernel+bounces-135698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2622D89C9E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192EEB26D51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DB6143871;
	Mon,  8 Apr 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP6xPkUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77255142E89;
	Mon,  8 Apr 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594438; cv=none; b=iDa/CCykDQkHlcG38KSImDcajC1gELrGnEVNM5FWCk1EZOJVYx2q9C0AEukIvEqTCtL5W565K3bEdatIvWWsz2ZtmoetOyv4S0e8Z7FVojSgUyJS5VpqCnpr0croUed1vSVbVSmrg5eCq/hEOYvlk/RHr+7jM4H7iaN2E991DHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594438; c=relaxed/simple;
	bh=zVJ8/8JF/gNZWXlENelkKttfECw64CDIpT9zFq/bhs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5a0fL73kwxsDJ980HTP5pHjtqBrcoXxahbopa6bIYZwgVj9dyKJqvNty8MQEumG26hYV7ipZJnX3j0Idf9Y0OB/ApHyWLl2LawEo6e15cFbOOQ3udaHh8vCcdxLuuqnMngfC27fvUEQWrwiJOt0LoTwy7B/nDHa/r6EduMz7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP6xPkUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA102C43394;
	Mon,  8 Apr 2024 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712594438;
	bh=zVJ8/8JF/gNZWXlENelkKttfECw64CDIpT9zFq/bhs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JP6xPkUwBtjv6T+eAipVp5ljfUCrfuPItz9Wptzf1fFqDwjwiWvAZ8SC0e6jir7uz
	 XpmTI8mSro0C73h2Z9F5kk9ZG+FJkqWQEfsdxPi5epkx7dng6wzlrRplAHVB9BqZ21
	 FERX6QitVmn3Q4uY4zxf1WSZeikKnNXZ504UHd9jDrjt2DE8U0xB5EwHVnS2Hv99e7
	 raYoHX9X65Ga/A5OZqsUw0ZbI9+5Cl57MnN01+qoaj8bhoZ2MJg+XbUs1KjjMGDm64
	 GkShWhq0tsaQK0w+J2mc/Vca12LyhqVOLWejtEYkkBiKrhl0HBr8kyBoH+Yle1GV8k
	 Ttz2D+r36fkgQ==
Date: Mon, 8 Apr 2024 17:40:32 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 08/11] spi: cadence-qspi: add early busywait to
 cqspi_wait_for_bit()
Message-ID: <9cb48440-c71e-4a73-8104-4780f0e98e72@sirena.org.uk>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-8-956679866d6d@bootlin.com>
 <1f7087ad-824e-47fe-9953-ed5152c8f18f@sirena.org.uk>
 <D0ETJXNHOUKQ.C368FEZVM9DD@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XV9SnMR4fo1ciYdI"
Content-Disposition: inline
In-Reply-To: <D0ETJXNHOUKQ.C368FEZVM9DD@bootlin.com>
X-Cookie: Drive defensively.  Buy a tank.


--XV9SnMR4fo1ciYdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 04:42:43PM +0200, Th=E9o Lebrun wrote:
> On Mon Apr 8, 2024 at 4:16 PM CEST, Mark Brown wrote:
> > On Fri, Apr 05, 2024 at 05:02:18PM +0200, Th=E9o Lebrun wrote:

> > > The reason is to avoid hrtimer interrupts on the system. All read
> > > operations take less than 100=B5s.

> > Why would this be platform specific, this seems like a very standard
> > optimisation technique?

> It does not make sense if you know that all read operations take more
> than 100=B5s. I preferred being conservative. If you confirm it makes
> sense I'll remove the quirk.

It does seem plausible at least, and the time could be made a tuneable
with quirks or otherwise if that's needed.  I think I'd expect the MIPS
platform you're working with to be towards the lower end of performance
for systems that are new enough to have this hardware.

--XV9SnMR4fo1ciYdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYUHf8ACgkQJNaLcl1U
h9D8hQf/dyR3L/vGJrr9ULKPcOdslJpST3OzjYPpEwGbLVohTyQDYK+D5/rh9TYt
pOS8YnUr8YjkaanYNAmYO7wqHO5GPDJPm+tzIJYdn0fHYO0R4maXcSA2DytEbt5W
re5OHsqLX8xH1T7qqgXEwlCONUQhncFIRkxaMYpcXasAqWOP4tOKsO57TH2xh3kx
KRqpRTVMS9qSkGt5a0YtULVEbERcxOLn2XVthGc5OnKnwvOUU77xHJ5ucCQ86+1z
z0qEm9RSSUIgSlPEq5BXd7wkDlBzkojoywBBltNCSg9R2NlLkHRmYtaSrL6MLE24
q8by3s66tiuvwmZSNttQEwdrovLgOA==
=rNjJ
-----END PGP SIGNATURE-----

--XV9SnMR4fo1ciYdI--

