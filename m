Return-Path: <linux-kernel+bounces-32190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381538357E6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38D41F216B4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687338DE9;
	Sun, 21 Jan 2024 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhR+7g+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749238DDA;
	Sun, 21 Jan 2024 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705871880; cv=none; b=VQANal34uNIK2WxlNrdM4kxd0RJgX2wGLk7jLyRDP9MVwCZMp8Phe1gcx1XE5H/grizqAUHr6JuVmSgtvQWe06qu1yezscWligjX8S+UN0diabUzlEHppj45hwsSPpzA3CxBi8E2ao0iM3rh2Q9IFO1tA4MDA5y6GFCF9zTDeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705871880; c=relaxed/simple;
	bh=h45STSfPy1P3Y2GbWo89YV/iBga1C9nJ+uPwiQ9NLLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrhXkxUzUXFrJVmf9c48ju/BQ+O8hjIqasNVgIh3AkOIwWzl5YBuBbFScPQYu3UOL8kiVlaNwtpib3DzKMc+6CUbEXIxurX4ETESvf9wZG+wcKjTTNE2+YhVMnKsXFilxZvY3oZsFw7Y51GwWCjSKAUJq5J6Ob5MUaMm9PMmhtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhR+7g+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A64EC433C7;
	Sun, 21 Jan 2024 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705871880;
	bh=h45STSfPy1P3Y2GbWo89YV/iBga1C9nJ+uPwiQ9NLLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhR+7g+N26Oh8TUBBWHDR4e4Ao5+BO0iPfaqNrwoueieSZ2Y25fB5bmyNN4lALQOf
	 ZB6sWAyqtXi9S7gnUaSWKIA+mfRTZi4gUMswHz6vygxOk7mXg6jXDe1Ej8VqgW/2OP
	 XczGEJz/GK9DaABwFFQjEjhalev7oivpob93FI3hG8uWQ8Ww9CPrBSTxrfmkExenw9
	 QuSg0PpALT1HsFD/F1KRAM6hmWymcCaP8a+Virr5n8Hl+dneFGBqiIAV52bLtD6ChV
	 UuCldWKDA1SJ+lcg+QlLfmz2LOt1sFIR0gXw+LNycpe3MIiM5ryukpuPUxN5a3PvqB
	 bmy4uWMX+nlOg==
Date: Sun, 21 Jan 2024 21:17:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Walle <michael@walle.cc>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	tudor.ambarus@linaro.org, pratyush@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sbinding@opensource.cirrus.com, lee@kernel.org,
	james.schulman@cirrus.com, david.rhodes@cirrus.com,
	rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Message-ID: <Za2KBNsUmE6xRqD6@finisterre.sirena.org.uk>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
 <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
 <d3c93c4c-3754-480c-84c2-9455ec8af702@roeck-us.net>
 <Zaxtm0JlQYU0/K/v@finisterre.sirena.org.uk>
 <ec7e7972-d48d-4a47-bd03-eec0c4334471@roeck-us.net>
 <9806d99fab46c928f337b30b21057b3e@walle.cc>
 <ed1de0d4-9a88-47b1-a280-b872f6fdecb6@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcmSRZRy9C5FJXV1"
Content-Disposition: inline
In-Reply-To: <ed1de0d4-9a88-47b1-a280-b872f6fdecb6@roeck-us.net>
X-Cookie: You might have mail.


--tcmSRZRy9C5FJXV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 21, 2024 at 11:29:48AM -0800, Guenter Roeck wrote:

> So I guess 8 would be the absolute minimum to re-enable support for
> affected systems.

That's actually the number I went for, just waiting for CI to go
through before I send it out.

--tcmSRZRy9C5FJXV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWtigMACgkQJNaLcl1U
h9Bupwf9ElV4f82yrrRTlzrth8zQZIj8vOQ1sXS02CQRaCYayGxIcjYRGvRCtLvO
Rw0SV2fD+C7t+UMikK/3GPIstF42bYF7hpXWhIyvKXKS3jZiBE3Y21VQtvaDGVSO
oNkyDqph/hbwQ09ps9TUi6AC5LOQWHdm3QLM9pOrZ2jMr6z56Vge/RlkK4VoLHYg
PUIgguXVtDEK31eqYfmji9p8xByXg0B+88MH90buxC6H11PG2JIRnIMMTY95C8r4
VDiaT2HCw+nf36cpv6LbkMr68qARlHcdOA1H3bvy9ofNDbkkLcvV3q8cj0IDeDRV
xtlgLlOsbzrWoh7pcG6QTXtih3SIWg==
=X0HL
-----END PGP SIGNATURE-----

--tcmSRZRy9C5FJXV1--

