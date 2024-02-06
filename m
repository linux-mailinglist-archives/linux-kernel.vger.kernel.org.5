Return-Path: <linux-kernel+bounces-54959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5A584B568
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D89A1F2229F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417C12B14E;
	Tue,  6 Feb 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg44X9Mu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E411DA2E;
	Tue,  6 Feb 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223134; cv=none; b=Y5ZdcZGjCt/iM/ngQsHGTjceYOqKotRfqmQZsW4FkTPLxdrYQKKcRWlWgoB8icOmWeuOwM9+MjIqtgpidr7KHiNq4pKFsQSJAc36hiw2lIqAguMTTgEFbNzZnUCNTm7oV69lfXrliYPnAg6B1ic94qwXVK5KEaXgQ3LtnjsPzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223134; c=relaxed/simple;
	bh=rAaXwG/hql/Td11pAFuRE/oGUvtdCYuh+e5Wb3L0Hbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMCs++MB4yRuE3/RlmTQcS4XDKX0h2ieHxNKQvtZzqTBNlWEnAeLOGVWc8jlLkPcfsi99SCSyabX0WnwmzlkV6090FAogNBFLgrM+VOIQqlpsh3gbnZ3GakEP674pFFvx8S73zauHEy6scpaQXGyToKq90UjIKOuO1ohMIy/vmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg44X9Mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D35C43390;
	Tue,  6 Feb 2024 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707223134;
	bh=rAaXwG/hql/Td11pAFuRE/oGUvtdCYuh+e5Wb3L0Hbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eg44X9Muw9xBoFXyBn6EpHbUYN9znrikVglh7VK/emp0p87aEYf8G2qyF5UIBB7yt
	 EXOW/ExUkJXMjmGaSteF/7J/6bBcmjwv2ybk9H80Njqu00VMfC/FzbJIzVLQAcK7SC
	 fLn5uArLGhsFwmKiqi9ObRgWEzUEzvawOyo/NwbReLAhE1Jq5CDXHPkA1e26r+5eCD
	 GELw/4Zpxb3FYKfSvN48PG7z9jRH6uq8epv2oHE7NMGJsqaobGKG+kQ6RQE6wC2PVD
	 oF6l9xaLYihDLbEypzikXxs/EkohLtgjlaudetm6qQKvtL0nnTNaOHPk0ZabiVhUHv
	 eF3hygcH2nHDg==
Date: Tue, 6 Feb 2024 12:38:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, kumaravel.thiagarajan@microchip.com,
	tharunkumar.pasumarthi@microchip.com
Subject: Re: [PATCH v2 SPI for-next 2/3] spi: mchp-pci1xxxx: DMA Read support
 for copying data into SPI Buf
Message-ID: <ZcIoWplpBp5A5yjr@finisterre.sirena.org.uk>
References: <20240206034118.748801-1-thangaraj.s@microchip.com>
 <20240206034118.748801-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LW+MsQIIcEXwJQui"
Content-Disposition: inline
In-Reply-To: <20240206034118.748801-3-thangaraj.s@microchip.com>
X-Cookie: You might have mail.


--LW+MsQIIcEXwJQui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 09:11:17AM +0530, Thangaraj Samynathan wrote:

> pci1xxxx_spi_transfer_with_dma is registered as transfer_one callback
> when DMA can be supported. This function adds DMA read operation which
> copies the data from host cpu buffer to SPI Tx Buffer.
> On DMA Read Completion interrupt, SPI transaction is initiated in isr.
> Helper functions pci1xxxx_spi_setup, pci1xxxx_spi_setup_dma_read and
> pci1xxxx_start_spi_xfer are added for starting spi transfer, setting up
> spi and dma read operation. In the existing implementation, codes are
> replaced with helper wherever applicable.

This description is kind of hard to follow and it seems like the
hardware is quite weirdly designed which doesn't help.  What you appear
to be saying here is that the DMA here is transmit only as far as SPI is
concerned (it's a bit confusing that you say it's read DMA but AFAICT
it's reading from CPU memory and writing to the SPI controller).  This
is a bit off in terms of the core DMA support, the core is assuming that
DMA will be bidirectional and mapping both the TX and RX buffers for DMA
which isn't great if the RX path is PIO.  If that's the case then you
might be better off open coding the mapping of the buffers.

> +static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
> +{

> +	if (regval & SPI_INTR) {
> +		rx_buf = p->rx_buf;
> +		memcpy_fromio(rx_buf + p->bytes_recvd, p->parent->reg_base +
> +				      SPI_MST_RSP_BUF_OFFSET(p->hw_inst), p->tx_sgl_len);
> +		p->bytes_recvd += p->tx_sgl_len;
> +
> +		p->tx_sgl = sg_next(p->tx_sgl);

If we're doing DMA why do we need to have a memcpy() here?  That would
tie in with the DMA being transmit only.

--LW+MsQIIcEXwJQui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCKFkACgkQJNaLcl1U
h9CO8gf/Q9/ofpTTfX8yzMbs0GE18AmhcBSt51lFfhMaHSsLvdCNSTciImJS7027
BCGjP9vqD7iT5iZMDBSTeycenTSzyc5wx51iruEePuMc7YNQzLOdU94uOibQog/i
RaeblDnsnb/mz1koYE86r7HFJbWulNXZr5ax6a4aXO8VLbDoLydud94stYJGv1TV
t5oJdlqVKl7SknP+/856O/Pmj6lIgqAH8+AFtTYiOjt+SQ7Q1L6JF1b546hP031g
JzaV3NzrAOGqB3tEfuqZM91FxaEwjM/J20GaTRgApqjX3MfoWUcPaxfx1ldBDavh
rHmGeS+2B+vIOKQ/UyEvL6Rki7qKgw==
=/J8H
-----END PGP SIGNATURE-----

--LW+MsQIIcEXwJQui--

