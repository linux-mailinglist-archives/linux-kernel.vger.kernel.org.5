Return-Path: <linux-kernel+bounces-54963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C333584B585
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB6A289D89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2892512E1E4;
	Tue,  6 Feb 2024 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g23yHmp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668FA12B160;
	Tue,  6 Feb 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223595; cv=none; b=kCjJQffG7VtqSKjVIf/dS8vL2BKERB+164j+lQA5Tn6caeWfUOJbQOAee7UpjscbA5axv6QXZ64KebupOUKhWLvy0xnTWElA6KPerOcZsrAYowT2vrXsQ1Bn2Gf7rEC4WkJAAhodm9WBVD1r9y0v7ReuWmCjNGCk9alWR+3cUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223595; c=relaxed/simple;
	bh=EAP2Xsdr74DX7KL65054QdVOJdjYzareZlMz/uft6bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFU9BbaOgSujYOpJwxdMruVOcvNDTuH0wASCipyt0NHWYLgKAh+M2qWeRO7SHj9pKtNuWbiZhYZYNdTZVOTwnHxaEXmeT7Az9PbjdBydA5qYKtb1zBB8dQgEznzavSNUBFeQndXb1wme3W7X7yWTDaRgSRJBRguTBQRTHEHbQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g23yHmp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8B9C433F1;
	Tue,  6 Feb 2024 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707223594;
	bh=EAP2Xsdr74DX7KL65054QdVOJdjYzareZlMz/uft6bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g23yHmp4o+HW424TbFK477dFMw9bxpvAf1c+VeT2daJUY2mMD47Fxh1gvA1N0Kz5f
	 XEluZRuEP/pKVxoY8Cetrej6/Vk1Qz70lqVeyBKz1nc80Ufh0aee8l02w0v20bBXxG
	 XlFHAecwyF+LI/Ah1r+uTg9b1lIQdISn+A+zXtr3xxgCd+8w/aAfhgIu0wxTunsqQ3
	 vmlCqEwg+5fvTVfrL0U5z7aJSZdzFEdIB8Pw+nO8+8LqQim9B5SVWF/P1AYWqRCPUv
	 RPnTZSwFqisWnX/VcKZdpkBHGFmtg/ChzyMHd5VRjXFXntfPon004ETDVxtzuW1Dik
	 UzrtMjawmbpDQ==
Date: Tue, 6 Feb 2024 12:46:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, kumaravel.thiagarajan@microchip.com,
	tharunkumar.pasumarthi@microchip.com
Subject: Re: [PATCH v2 SPI for-next 3/3] spi: mchp-pci1xxxx: DMA Write
 Support for copying data from SPI Buf
Message-ID: <ZcIqKP6cu+KThPBg@finisterre.sirena.org.uk>
References: <20240206034118.748801-1-thangaraj.s@microchip.com>
 <20240206034118.748801-4-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsSmfTY+JicY0zWh"
Content-Disposition: inline
In-Reply-To: <20240206034118.748801-4-thangaraj.s@microchip.com>
X-Cookie: You might have mail.


--zsSmfTY+JicY0zWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 09:11:18AM +0530, Thangaraj Samynathan wrote:

>  	if (regval & SPI_INTR) {
> -		rx_buf = p->rx_buf;
> -		memcpy_fromio(rx_buf + p->bytes_recvd, p->parent->reg_base +
> -				      SPI_MST_RSP_BUF_OFFSET(p->hw_inst), p->tx_sgl_len);
> -		p->bytes_recvd += p->tx_sgl_len;

Oh, so this is actually bidirectional - please merge this into the
previous patch, as noted on the prior patch there are issues with doing
unidirectional DMA.

As a general thing since this is a driver for the SPI controller it
would be *much* easier to tie the terms "read" and "write" to the SPI
bus read and write.  It's pretty hard to follow what's going on as
things stand since it is not clear if a given bit of code is talking
about the SPI controller or the DMA controller, and if when talking
about DMA it's talking about DMA to/from the device or to/from memory.

--zsSmfTY+JicY0zWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCKicACgkQJNaLcl1U
h9A6SAf+OTRiJtnoI8PLs0ufX4f/gprDYiniDPESh26haCVX/ppOaeAR32FCl0eo
Wayy14hvcHIg9gu6pWGH8wOc97lR+fdNoOKLOK9tmgWYQE6J/F+utSTU6xhbz5hd
c59PO9b/mHKtEoQfwOpisj7FZLExLdtZj3sKmCuawgRUKhh0hEoMpgSK5rHmmeWa
312Bm25cclqTXsaOLREpFo8yP/jtnzJAFAhoIxAbgE/Jk6eTdUfKW6BHAD3c4g4g
fb6U+RuJ3gVyD5SdKWMMZjRIptn2E4GDGDtk5OgQT3268L3I858xugXJT8Ljph7V
7Y2BsoVclJj6lLWO/Jo2y1p4HrBlMg==
=na1e
-----END PGP SIGNATURE-----

--zsSmfTY+JicY0zWh--

