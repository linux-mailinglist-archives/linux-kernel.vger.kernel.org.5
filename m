Return-Path: <linux-kernel+bounces-81500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451E8676C4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5961F233DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDA1292C0;
	Mon, 26 Feb 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeKktXd4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661E1AACC;
	Mon, 26 Feb 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954806; cv=none; b=vFJaSLN9HaX215AgaQeDAZHh/ghEJS/akVBw9nqzu4rqgjBHcFkTPq1wc86jf86Hf/YZBlryYQiuTt51jr25l1oc+FnPs0WfiUFOmprf/4Bn5q5zGw/pBFhOwDq7HXWie36+kn5OJbq591sZYb65vebKTuqnIy83YWQoK82ePLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954806; c=relaxed/simple;
	bh=w0aH9LAZkqIcxgob9/XfgZeLdv3nrmwr76/CADHXqw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfvnOSOBkao93q9Ha70g6ZlpwgU85NojEqV1hN8Z/mLrd9dizHkQ8z5mp/4dn2kPWPM/X8CL/9mo+VEYRn6CvE32dsSxdrMpqaT/5drHfZjp0LuiWbt6jiBxaKuv2zHzoenAnt5o91cnpq4+7RDU1ZsJ1CPI5+Omfev8+IPMdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeKktXd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4339C433F1;
	Mon, 26 Feb 2024 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708954805;
	bh=w0aH9LAZkqIcxgob9/XfgZeLdv3nrmwr76/CADHXqw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeKktXd4eDPlis2egCcqOZNjF3hNccQgU+AjwapnjUckJfbKY3CqlXTmdf03L639H
	 CmhZbsPo1nsVoi7NHBcE/lXJyqEtGDLVq9bYpU372681mP/SMGvPQ6guKAkzf2VigO
	 1ViOA3hERzLVntzwpGuW5ss/Zr12kKbdqDvoaOIZ9NgVbth1Nkyt/QikrbQLCenhzi
	 EGb4MeDBMHndcN65KA4+RShqPsjue9w2ZOYGZIIhNGAgZYmEzzGgzaTU79Mrjg+mUc
	 qr7tl2Su35ilquLbD+j7zpSwHnOTm8O06aPktWvOT5ANy6bMxp6XLhSYxwSKvVX5ou
	 vxIPX8IS7dHzQ==
Date: Mon, 26 Feb 2024 13:40:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Nishanth <nm@ti.com>,
	Vignesh <vigneshr@ti.com>
Subject: Re: [PATCH v4 0/4] spi: cadence-qspi: Fix runtime PM and system-wide
 suspend
Message-ID: <cb74a9f9-abfa-4a94-b4a9-bf41ddc697eb@sirena.org.uk>
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
 <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
 <20240226121803.5a7r5wkpbbowcxgx@dhruva>
 <69f3dcd7-b79f-4b4f-aecb-dc559d74e6e4@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dT9DhkmsR3HA0bqQ"
Content-Disposition: inline
In-Reply-To: <69f3dcd7-b79f-4b4f-aecb-dc559d74e6e4@sirena.org.uk>
X-Cookie: Walk softly and carry a BFG-9000.


--dT9DhkmsR3HA0bqQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2024 at 01:27:57PM +0000, Mark Brown wrote:
> On Mon, Feb 26, 2024 at 05:48:03PM +0530, Dhruva Gole wrote:
> > On Feb 22, 2024 at 19:13:29 +0000, Mark Brown wrote:

> [    1.709414] Call trace:
> [    1.711852]  __mutex_lock.constprop.0+0x84/0x540
> [    1.716460]  __mutex_lock_slowpath+0x14/0x20
> [    1.720719]  mutex_lock+0x48/0x54
> [    1.724026]  spi_controller_suspend+0x30/0x7c
> [    1.728377]  cqspi_suspend+0x1c/0x6c
> [    1.731944]  pm_generic_runtime_suspend+0x2c/0x44
> [    1.736640]  genpd_runtime_suspend+0xa8/0x254

> (it's generally helpful to provide the most relevant section directly.)

> The issue here appears to be that we've registered for runtime suspend
> prior to registering the controller...

Actually, no - after this series cqspi_suspend() is the system not
runtime PM operation and should not be called from runtime suspend.  How
is that happening?

--dT9DhkmsR3HA0bqQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXclLAACgkQJNaLcl1U
h9BuqQf+MH9CDnVqVpElG8YMfnoXoUebQzNfXKDwkudLGGp0ExSf1+MjPcfmzGrB
mBXwd7A39yEX3v3CUFctuC2UovQA2eJDJXeGnpHuAJPSmbuWFrIlLUJEm2lv3CAl
dSvAWQl9O+26dtX6Tda0897TMuD/hIX8bf+NY6ejvSyb61gBMGJS23AbwA6rQbkx
E0/ulqCQ8lYL8WCYf/eoxEC3mSJefWAkjalulhvcWBfZgZrQe5uIddcmThn/Bn96
JtK+wi1iT9ZtCysv0dwa8+lD3iSCeO2JLBHfchCTFlUfFwRH5gZX8SS4dTZhzMmi
U0cVSxyElPcusXldph2Lw8ghLhM88A==
=uNwv
-----END PGP SIGNATURE-----

--dT9DhkmsR3HA0bqQ--

