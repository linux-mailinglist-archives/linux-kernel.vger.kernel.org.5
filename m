Return-Path: <linux-kernel+bounces-30847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C41832511
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82E01C226C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20206D51C;
	Fri, 19 Jan 2024 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmprS5pw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A5944F;
	Fri, 19 Jan 2024 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649666; cv=none; b=qcdM4A9UVB+roVPEGhaTVZYja6OMlO4TniNehlpygZmKXbBNi9CAJ1H2FbAU4FTnMFQT7kL6xuQNZNEtfCQewi//pVv9ik4kkx2mFJjrZwKtdq86aEOfP471OSleCo1S6vV4lIyFY7SjhEK1lbfzLk8k6jEDfPljeWYxyjC9Qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649666; c=relaxed/simple;
	bh=QYE7yiCJxwlmebwjTQpebpKMDD+EhMMsKm31/uR2Rac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri1w6qRmLkRW6xW6z28WG6DfNk42uHu/JGAcwio7xUh39VMeu2GLIpo5cUAkHkDy6Eha50EjrQtpBCoZZM/R4kDvXaP/1XPMtjVGUydZxYKfeE+Yufe3a//ZXvIQcelxpdCEj1pGw5EYJj+4n9jnbDAKmakGcZNdNo6EA37M9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmprS5pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0121C433F1;
	Fri, 19 Jan 2024 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705649665;
	bh=QYE7yiCJxwlmebwjTQpebpKMDD+EhMMsKm31/uR2Rac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmprS5pw7FkNoy135BDsZfB1tBF5CbghTkRQb4LtU5jIy9Zc+zTH11SgDvqajQVVd
	 9Xb2kRHVgCKx2s+ojpnDl7B4sP1w4hxZnCmiJ4XEb+Wd+muQ5MDgxZYIvEIkXG5Coq
	 4nHeMI2H0m6OKGIVK7RkMjN9OJ9Kgay0AGGtEXyFw6pPl0vaZeubVnTPsEO1NeKtA6
	 ESxaZGl5UQ5sq6ci9bgDZ5SB5smWBj7iDZTIjv/ExT4wfK55UJvdqt18K3+b1GpYVI
	 JXgcv4GBD/VlkPWEyAa5rOR+zs4d3/7A/dc38G4pVuc5C7wlPesYY7nnxCdNr6bhxB
	 o81QuyyVxDrJQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQjOc-0004S4-03;
	Fri, 19 Jan 2024 08:34:34 +0100
Date: Fri, 19 Jan 2024 08:34:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ASoC: codecs: wsa883x: fix PA volume control
Message-ID: <ZaomCpQ2ged-zpQ6@hovoldconsulting.com>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-2-johan+linaro@kernel.org>
 <a9e1f3b8-9597-454e-b68d-4014e923ee61@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KGFq/OtHqyzEakW+"
Content-Disposition: inline
In-Reply-To: <a9e1f3b8-9597-454e-b68d-4014e923ee61@sirena.org.uk>


--KGFq/OtHqyzEakW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 05:24:16PM +0000, Mark Brown wrote:
> On Thu, Jan 18, 2024 at 05:58:07PM +0100, Johan Hovold wrote:
> > The PA gain can be set in steps of 1.5 dB from -3 dB to 18 dB, that is,
> > in fifteen levels.
> >=20
> > Fix the range of the PA volume control to avoid having the first
> > sixteen levels all map to -3 dB.
> >=20
> > Note that level 0 (-3 dB) does not mute the PA so the mute flag should
> > also not be set.
> >=20
> > Fixes: cdb09e623143 ("ASoC: codecs: wsa883x: add control, dapm widgets =
and map")
> > Cc: stable@vger.kernel.org      # 6.0
>=20
> This will mean that any configuration saved with alsactl store will
> change effect, it might be better to just fix the TLV description and
> live with the unfortunate UX...

Indeed, but the machine limit set by this series will make that less of
any issue. At least for mainline, all users of this codec use the same
machine driver so will also be limited to -3 dB.

Johan

--KGFq/OtHqyzEakW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZaomBgAKCRALxc3C7H1l
CGmdAPwK+i5ESpbb1IA/xZpXm46rdEOQaskthgednCfQz4yO4QD9HTPCQrWiYtnU
7vkKlcGYrNxBK2azazVxdjYLIYW5ZA8=
=b1Be
-----END PGP SIGNATURE-----

--KGFq/OtHqyzEakW+--

