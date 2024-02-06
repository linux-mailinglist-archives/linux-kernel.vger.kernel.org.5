Return-Path: <linux-kernel+bounces-55257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4870D84B9E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F0B2C42F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27313342F;
	Tue,  6 Feb 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzMvsMe5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AD132C2F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233912; cv=none; b=gZivmNxC+F6rJRXq1BSljn+UQY2FgKi8sL8/ue6eernWO42Na4LA85fgE/e71oeXIP7lEuRgArdynXeh0drQwGZId9Y8Jg/UWLORCzyDwmE2iVNPYHh5LwAbtr5EM1gBipj5FIRje2W1f5gMromGOQ2Bxqr2hNYy33KxWxyyQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233912; c=relaxed/simple;
	bh=GKRLYZd/7IQYKznm7Jnww3evgUDcBZe1KFvN0Wken08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy7hJcM2b2GOZESLeFG2NOzAvtqvTMdEIut4IYRWiRC5rZsVheiF1Q2uD9TMzBOBRia/AF4VrfyY4OHyQ/8WjWACbQ+FIrzwciYOyS+DUcU+7C400ip/dYCvWeWfPfaFxGKnHZDAiPcHvNVad33gRJt4ASz/mHFi8TEVYm9yoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzMvsMe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8405C433C7;
	Tue,  6 Feb 2024 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233910;
	bh=GKRLYZd/7IQYKznm7Jnww3evgUDcBZe1KFvN0Wken08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzMvsMe5MW7d2v6N3S+PjNj3O9mUfTiQcTBXqDee0+fQ1xUXcT6cyOoBxB86/aFOt
	 n74DygFnW+smzqbgCg3v1VEE3G1vBLQTy2CcB8MeHeGsX9TvCbt+jud2HcCAO+RdKX
	 cy0+laD8x3o1oQNKIIIbD/iHWjhczTYfLmTtb51FWzs+A1NSZZ5sE43s3MzWV6NRN1
	 Gwfjebro8V6fV59cXsu7J58LKoNf8voOpWmxTUPtlLT3Qq0dST7GSzk79nZjydkoqD
	 dwKfqmMyFR++v5BBHTy6hbQqZFjOT0oLCu027G8lie77EvkDe7D858+8j52qwkvXCt
	 XF/Jl1B0C3EVA==
Date: Tue, 6 Feb 2024 15:38:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] regmap: kunit: fix raw noinc write test wrapping
Message-ID: <ZcJSc595GcjDC4QK@finisterre.sirena.org.uk>
References: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jHHK+EATDPu8E58e"
Content-Disposition: inline
In-Reply-To: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
X-Cookie: You might have mail.


--jHHK+EATDPu8E58e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 10:10:05AM -0500, Ben Wolsieffer wrote:
> The raw noinc write test places a known value in the register following
> the noinc register to verify that it is not disturbed by the noinc
> write. This test ensures this value is distinct by adding 100 to the
> second element of the noinc write data.
>=20
> The regmap registers are 16-bit, while the test value is stored in an
> unsigned int. Therefore, adding 100 may cause the register to wrap while
> the test value does not, causing the test to fail. This patch fixes this
> by changing val_test and val_last from unsigned int to u16.

Ah, that'd do it!  I wonder why Guenter is seeing this with much greater
frequency than I am, I have managed to reproduce a few times this
afternoon but very rarely.  Guenter, does this fix the issues you're
seeing?

--jHHK+EATDPu8E58e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCUnIACgkQJNaLcl1U
h9CTxQf/YT4KA+aNABF2G6ruOak5GUf4nEuEbNNv67/qs33IE3vwQa1cIfDxFVpo
MHOgLg7EY4wwJ8uiLVX/Lx+uYFkfIe5E5MKaRjngVCWKqBQwJpERrZy4KCBJRxMF
x5ttaad9lD9/jiaCJ/M+SxItC1TQa3F9SJIHwmO1bYPfOQ3f+90MUh4a2kl+eG0E
zcBPzweAp6FsWy2CVM43gFL+fyW/HG7y4MZYWOx6Hh4yMjaH0eYljxKdPG85yPj5
yrVYipy9liDbdceOB/ls/FfFlzynphPaCBQWC+P9J1D7xyO16f82oDpHKtVYGXYt
vzwz+GMfhUfuXdAGsNAc0eB5mes4RQ==
=n1ae
-----END PGP SIGNATURE-----

--jHHK+EATDPu8E58e--

