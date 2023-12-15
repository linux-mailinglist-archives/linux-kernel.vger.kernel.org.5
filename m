Return-Path: <linux-kernel+bounces-1013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCE814939
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06E41C23BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30FE2DB78;
	Fri, 15 Dec 2023 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glqzC2cg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD42DB66;
	Fri, 15 Dec 2023 13:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BCAC433C8;
	Fri, 15 Dec 2023 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646966;
	bh=70f6tQF0J1igTU1Bt6VBmvGx8DE41PL8adjrB1J4clQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glqzC2cg+nbRf/E9dwYYGIq+LqP+Jct0V8pYjJaRUX/ODtYc3g4G9Ww9cXs/rTMwE
	 OrFmCuFHfwj1zgM8phBIraQ+MZuIqfqd+gKo5tMVkLwzF7vMD/0ASapKSh/1TkXm22
	 xQgdtrZpgksGsFIhouxYCaUKghD5WzVZ1AA/Mtf+DKM78wbmuoYGgM/Su3nlGorL8T
	 tHz3a+eIbT9c+O2ciNstdDRRU/JTmfghykCpCr1rpPOlAkBg3tBJV5bYVA2EaYm+W2
	 XpFHqBiLYqvbYcINNcdQeD0xvabkvQrOXqDxeJeDM+Qt1/ZohU1a0YRL4N/ycRBshd
	 NY4oKQh2yJ6NQ==
Date: Fri, 15 Dec 2023 13:29:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tharunkumar.Pasumarthi@microchip.com,
	Kumaravel.Thiagarajan@microchip.com, Arun.Ramadoss@microchip.com,
	Ronnie.Kunin@microchip.com,
	jegadheesan.gopalmanoharan@microchip.com
Subject: Re: [PATCH SPI for-next 2/3] spi: mchp-pci1xxxx: DMA Read support
 for copying data into SPI Buf
Message-ID: <677a17b6-39a6-4b1e-87f5-2c01b19bbe3f@sirena.org.uk>
References: <20231215114748.152319-1-thangaraj.s@microchip.com>
 <20231215114748.152319-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n0OeUrTOIes8jnxm"
Content-Disposition: inline
In-Reply-To: <20231215114748.152319-3-thangaraj.s@microchip.com>
X-Cookie: PARDON me, am I speaking ENGLISH?


--n0OeUrTOIes8jnxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 05:17:47PM +0530, Thangaraj Samynathan wrote:

> +	tx_dma_addr = dma_map_single(dev, (void *)xfer->tx_buf, xfer->len, DMA_TO_DEVICE);
> +	if (dma_mapping_error(NULL, tx_dma_addr)) {
> +		tx_dma_addr = 0;
> +		ret = -ENOMEM;
> +		goto error;
> +	}

The core can do all the DMA mapping for you if you provide a can_dma()
operation, this supports switching between DMA and non-DMA modes per
transfer - often you'll get better performance from PIO for smaller
lengths due to the overhead of setting up DMA and taking the interrupt
on completion.

--n0OeUrTOIes8jnxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV8VLAACgkQJNaLcl1U
h9BWMAf9H1LHCGzDRvVwox5ckKl92TN0NqELP0jLKlvE2hPdMCJOR+cUbtxpUMRw
hoemsMMllhLscZeqhlYuJXArUAYsw7Cszl0Q2zy/LypcubZtgvBCZwWLhPMx+iKC
1cPTtFzG+DsGcWyIB7EcWsjoUUbvYdrnuQFwR+Rg7AF6Sk+T7lzrfYAe96XuvLvn
maJUlcRDYZcnrdoNJIUK5RSPV2pyMS23rFILoKVpV58AcbIHraoxTkiuZkL0F4zJ
y4YJH+llb83W7AdrHZw7AMMYLbZg6mbsiCTCKVYPGC1dmNF40FET2zKLGO0s5RNt
bYKzuYzx82rEjDRyHCG/KxjCBwzlbQ==
=Ir3m
-----END PGP SIGNATURE-----

--n0OeUrTOIes8jnxm--

