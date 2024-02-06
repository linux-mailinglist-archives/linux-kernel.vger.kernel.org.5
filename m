Return-Path: <linux-kernel+bounces-55335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0338A84BB51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888C2B27F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078344A3C;
	Tue,  6 Feb 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKVyRXD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED98F6F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238029; cv=none; b=fVaI/TSLM9ma0cosx2UhJY+gXSa9f0KTE5UlFFYmRSEpTxUCwkdZeC+zmY9RkD2kFGHK1HLZCZu8YeLxvVmlapWDuQxTRugUETsxWyqoxRf3AXQcg2OcGQjj/LZJc+9ti+8ndNliobQUwp3WV41o3qqU9orTm6kk3SEKuSPdqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238029; c=relaxed/simple;
	bh=YY34Y6wgpENE4TaILccoGmH3liK7lOtSpCjb9nzrbEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbq/UtG36Haq3tisNHGQ9++IqUmmOmJTQal17bwXDp+RFQ/pxNiiSJ/rXMRvmnfk7JYu8vIiZzv7xsG4JAHz+Ul51zIiVg9PMZ6RV5rN0i6HPJKp4ob/IrL7VSpTE/p0hBLRBlZORCgrLSbOIGim7jPC35zrl2F2n+0hYh4U9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKVyRXD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1114BC433C7;
	Tue,  6 Feb 2024 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707238028;
	bh=YY34Y6wgpENE4TaILccoGmH3liK7lOtSpCjb9nzrbEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKVyRXD8ObPECnv5H+yr9MPfAOCJkdGsOJF8H+fyikmdmJNTYJKsru999kZiNVC49
	 LaJ0XzDtojHIr6pb+7eJ5C7Ir9CvCtqRzfqcZc8ZUP0Us1Im5+T5DhujVBZsFQMPHR
	 BF1FAEVnkm8tlZzZRbltYAxUiHWRAgirIHCwt+s2OS2pbUCon0PPpGDPl39sW0RIy/
	 tAHya2fGiJP+aEX228dkdv+FzHdpHt+wRlAjQd8IpTX4/NKSgHN4JaS/bmkfp8xfsh
	 EBs9L0Ozyid+aEAtR+d8OiFX87ttXV4BCIRTr2icGLKggJ9Nh6nthkPT2il3+VG7Po
	 wD1fKKmChNJuA==
Date: Tue, 6 Feb 2024 16:47:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: kunit: fix raw noinc write test wrapping
Message-ID: <ZcJihCjkCL3/kt5a@finisterre.sirena.org.uk>
References: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
 <ZcJSc595GcjDC4QK@finisterre.sirena.org.uk>
 <1bf36657-0169-4d10-960f-ba01dba0411b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8w32ETbaRiJwrKDk"
Content-Disposition: inline
In-Reply-To: <1bf36657-0169-4d10-960f-ba01dba0411b@roeck-us.net>
X-Cookie: You might have mail.


--8w32ETbaRiJwrKDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 08:43:31AM -0800, Guenter Roeck wrote:
> On 2/6/24 07:38, Mark Brown wrote:

> > Ah, that'd do it!  I wonder why Guenter is seeing this with much greater
> > frequency than I am, I have managed to reproduce a few times this
> > afternoon but very rarely.  Guenter, does this fix the issues you're
> > seeing?

> Give me a bit. It takes ~2 hours for a complete test run.

No problem.

> I am not surprised that you didn't see the problem easily. I am running
> more than 500 boot tests on each release, and only saw it in four of them
> when testing v6.8-rc3. So I'd expect a "hit" rate of about 1%.

Ah, that does sound like about the rate I was seeing issues at.  I
hadn't realised how many of these tests you run.

--8w32ETbaRiJwrKDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCYncACgkQJNaLcl1U
h9BhvggAhvDpUZfiz0WWREymgb+FYmkXCJDGUdAhZgy5Slhb6pv6Xq39ihLNs73V
ok2zn/DOBb2T32Ggck4WWIfJFktna07/DHrEW9kfAZ0VtRxSZWJcUmFL0DbdG1Qm
BYKQ2V/YvR7Lezc0pn7AuU47otIHWspNAoIuh/aXJMJ2A9UkhfIvzQs+qwfQeKpc
pLyJI7TdEgeiftmcTUvrMm4cD0lVg6i2RSGmGBEA+16zfmc5IZImtsvhifbUMMw5
s7jdVB3w+pn+sbFzbRAvOfJUMzuJnaijqO0qIeRb1nd7JLb3y0y84LZrX9y72x4E
EmnbBZRHzDR0KkEA4lN1SiX2nKmfaw==
=PUA0
-----END PGP SIGNATURE-----

--8w32ETbaRiJwrKDk--

