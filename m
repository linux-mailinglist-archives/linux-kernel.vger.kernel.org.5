Return-Path: <linux-kernel+bounces-61703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B33851597
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D8AB28B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090703D55D;
	Mon, 12 Feb 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhnWrfMp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B633B785;
	Mon, 12 Feb 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744918; cv=none; b=tR28Nrc9mUfAtCePdG4rFQDnn6nnPycehXPWoAJHSjUO4hBVQiyu246E5+NJ3dqiq1avKaZ/tORXN79mfCNCEl1NAkY6GyKywl0ZEEU0o15vYWVLYL5+cKKvtB7xXzNPLX9+/DZ9OLVGJWeMGtthpOnSGW02LfRNJjxJBR+XHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744918; c=relaxed/simple;
	bh=V4lbPJZ3qP0qBipIkWFbBDXjWwgPyX2OPgDSAvz12/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwL85kQYDg6t50VMTlvv2tI0zZAbpu8HqRxASgc8/Ny2JkpQqBNoBmUiW8nsFRpgz2wU8wAk0D1GE0ehou7EzzXlMTfbfEz6Fn/e6znCRSRVFHC2yn5bLUVRmYFBMCvvMUCOfAvsWW0kgomu3fQPB7/ACqRMXiEpNOU3dxgSrJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhnWrfMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E22C433C7;
	Mon, 12 Feb 2024 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707744917;
	bh=V4lbPJZ3qP0qBipIkWFbBDXjWwgPyX2OPgDSAvz12/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhnWrfMpMCmDrMWf2D4F9lCiaqP6X+Wd2c7l2eHXy/MNx5wfjHWyiIBwYJkuhv/rw
	 1rVEwfiWcv7wKvtTpPgr0RRPnqD8dPQ/3kiySaVEXpE9ZE6zD36zFebZqIrwC+g58Z
	 kpzSif0ra2iOHVyEfoO0JC5E8abFcHENAIuFYyyU2iEmhyrCyb7yPss1LFOTmIumUV
	 NeN8X4eGzfjU6fZK1jwaj53kCpUFRYTxkkDtSC64S0BWjHvrY6jHTpukBirFzgE5Nd
	 C/GOdPI95ahA/+aVDK8ILPXauFmeVWYU9SCVqy/Ep2bpkxEJMnTLcoBEwPorB4sk6y
	 YQ2n5RQwPqwCw==
Date: Mon, 12 Feb 2024 13:35:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Message-ID: <5c1a5edd-adfd-44f2-a993-bc3f43222a3a@sirena.org.uk>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <20240212111355.gle4titwolqtzwpi@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qfEan8YTTsWnxYla"
Content-Disposition: inline
In-Reply-To: <20240212111355.gle4titwolqtzwpi@dhruva>
X-Cookie: Will stain.


--qfEan8YTTsWnxYla
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 04:43:55PM +0530, Dhruva Gole wrote:
> On Feb 09, 2024 at 14:51:23 +0100, Th=E9o Lebrun wrote:

> > +	/*
> > +	 * We do not have the concept of messages or transfers. Let's consider
> > +	 * that one operation is equivalent to one message and one transfer.

> Why 1 message _and_ 1 xfer and not simply 1 xfer?
> Even in the example of testing that you showed above the values for
> message and xfer are anyway going to be same, then why have these 2
> members in the first place? Can we not do away with one of these?

If the device supports regular SPI operations as well as spi-mem
operations then this will ensure that the spi-mem stats fit in with the
other operations.  If it only supports spi-mem operations it would not
matter so much.

--qfEan8YTTsWnxYla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXKHpAACgkQJNaLcl1U
h9ApIAf8CFpmSqm+vuO7RrlK573k/K80dAGpyOYDvb4SkGCshATMJ3VLM50ZvVR5
BXdev13tBegdvN5gg+i9FeFLYGyBVJDpCsNedg/1aXvSrofa4n97zB4p3E/s+ndv
egC/u9kawfrOJ5k7PEr7pVmlP2ZaajCvuSTq/huoD8zePvEWUOgaqTehpmxqhNVa
g/oxTEBTv0biZHC6z8PMrffb6ugnVf2ppSlfYL8GF8ceoONUMHvmL+yPq0H83u+a
3bXyC65cZOs+Xa5GextzRqeTHt0uk1V0tXisJSNkIxU+gRsZDvI1e6ZfBlTTWE5+
5hFP8z4lVCFXvdaNAjcryp1E7xKOgw==
=nLML
-----END PGP SIGNATURE-----

--qfEan8YTTsWnxYla--

