Return-Path: <linux-kernel+bounces-94288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEB873C88
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87A0281CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59177137938;
	Wed,  6 Mar 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT1otnHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D5D534;
	Wed,  6 Mar 2024 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743581; cv=none; b=bizlp4nXLUaVSuzN0/jXrJ/TqdjhC683Gj5TpHkAEd5eFHK/hKS6+mPSf3+2IW/azi9kLD+KN1c6zI3C4BwrpKUzNKAmkttUaeMSGctijgM1+EN4wivhGYJ35Xe0Y8JUoSVGvD8/xsrNHKuvpI5uC6/3jvFJiQPVA9CSeioffIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743581; c=relaxed/simple;
	bh=oqownLCVQSkUoTKT5XoUEGTUrAy5b210q5G72rB5tWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVJ5N1K4MeBuRdkUswJGnn83B3tt14dlhN+S3cdPNHOb7/7XOhvefO4uoEwXy/oLRAB6r+PYSRIG2ve2FoMOe7IbsphMWpoo+mY6dO19l9+fb0x8RGdnQE/9yDBGZUtiJ4TS/AegS31cG+/B37aAQNNVEmVaChrUvW+66vNl8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT1otnHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8329FC433F1;
	Wed,  6 Mar 2024 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709743581;
	bh=oqownLCVQSkUoTKT5XoUEGTUrAy5b210q5G72rB5tWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VT1otnHnPHMfU1px85lS1GHKSvltK8wF1Gr1NN84kawjKasmSPxziz2MLNTf6vZrY
	 0bv+o2N85zcdczPMarK1iDAyWtSvzODi1G69k/t2pqGzeDhfg2LMk3OdWat/quiAyV
	 BHRxjMpe3IbM4DepV2TfWoFgHGdC5pLtu5/sinaoZgu3Z5CPqlAT/KAfK+IWe2DYBM
	 HDmJsZetCujNcqw/HMv4tnq9tNZjqEoHBSRcewfMr5USVVWGjEjMrOmpeX4c6Y2bF3
	 WAYRW5xfp7A0GX1Z0EyW2W5LaOma2FMdEIuTscfXrf4kj2pW52s4FqMn2URHbwha6h
	 Fvg2d8i8gvcrA==
Date: Wed, 6 Mar 2024 16:46:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Stuart Henderson <stuarth@opensource.cirrus.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 4/5] ASoC: wm8962: Fix wm8962_set_fll to use source
 instead of fll_id
Message-ID: <90fc91ae-0009-4cf1-8dd4-0f711e9c0c74@sirena.org.uk>
References: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
 <20240306161439.1385643-4-stuarth@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tZc99IaNMjFZtgq"
Content-Disposition: inline
In-Reply-To: <20240306161439.1385643-4-stuarth@opensource.cirrus.com>
X-Cookie: Have at you!


--4tZc99IaNMjFZtgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2024 at 04:14:38PM +0000, Stuart Henderson wrote:

> Previously wm8962_set_fll was using fll_id to configure the source.

Which was a problem because...?

> This change is problematic, but it looks like there's limited
> users of this driver, and luckily they all seem to be intending to
> use WM8962_FLL_MCLK as the source which happens to have the same
> value as WM8962_FLL.

If the change is problematic why make it at all?

--4tZc99IaNMjFZtgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXondcACgkQJNaLcl1U
h9CyCgf+PfnqyAIO4He9YKYcqZdFqmX1Y6LWOmcZizuzPlrBkbtVDMjLbJ2RrObb
gAOrMKGWOgJaZ7BwNS/L2pZ45G77p2OvmRhoT7BRQFt38QgkMhlfDNr1d+jpDzBO
Xz+t2FL8GVEkYVb7q6C2k1BDfDtguZaB/Ld2zX8PCamgBhnSYU81R91vkc+GHIRh
bZn6WrnAQ/bmq6Z42NLd9LSNNca4KvQhmOTh9QyGuC21lMpgnC8zdU3P25oMJU/Z
3sWh08Ws129OzmVpD9kPpazamzH2uBRkOx8LVMgoCUhCtShYgQ5DpsR+wAqPNjoB
seNWRk1Oev7kctFSAfwUNCrBBZIogg==
=HNjP
-----END PGP SIGNATURE-----

--4tZc99IaNMjFZtgq--

