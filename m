Return-Path: <linux-kernel+bounces-161489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3735D8B4CAF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090231C20A61
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0871727;
	Sun, 28 Apr 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6ivtPvR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B77200D3;
	Sun, 28 Apr 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714321772; cv=none; b=TVCKFQ1nvyr9x8E29QFXsWzHmKTEpCBUDQj9Wvfrr/T3+71mPmoDvVHcUP+yR7HHgMsEuqy7uWK5Wmsob3a36oanugqKGsyHrrX9vdDDUv28jYJza9J8A4Cg+5VqTcjj8SCHvnj0JBAFXKPJ7eWVcuHbUzgcp1pMDVTWh+SwTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714321772; c=relaxed/simple;
	bh=vSrMdYGVa1THJhE9VGHR3c71Wan1QAssbo5bxRU7fyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE8GZK1jwk+7lqQsSLDi126UKJUi3OpiSQNzTCUe2dapsddRUuLLv1mZCDLG+I3/0jlVmF1/dHt1xAiNCqi5sx113QIXL28HQUz2mVTrPpEH+rhpELeZ0p4dOuHE+bIUqeeMzeDgFDgtulDE7LoArzhv/RC7XW9j+db+ZSiYBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6ivtPvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E1DC113CC;
	Sun, 28 Apr 2024 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714321771;
	bh=vSrMdYGVa1THJhE9VGHR3c71Wan1QAssbo5bxRU7fyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e6ivtPvR1g/dJdwd2h2A6IrgImRP910wNr/OE0fTPtZ+6UCoicXkyLT/0iN+uq1DU
	 kB4wxp8DnZ/uMAlwH9+4zjgacZQ0NlJLk7XNsbRDxDh6HJYOU7B0Qlr/+2kjOFJcCO
	 JP+86oRoGjkcdo83+T1yf5UglcR/jZRIBkGDbXmI7s+tg6scrzM+u+M7V916W8fqyk
	 F16SUavqdp7hpNcpuucvMLL/uaX0Ave3MwAZMSFpH8ONC65oogurZwVD8nE7pcwN6R
	 cC9f7cd3jz83aBPsEVEyH7ayZGNYpL7w1kC0H4upFqkc/o7+EzRv1ibCSv+w1qK58q
	 kFRpaQnU3endA==
Date: Sun, 28 Apr 2024 17:29:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad7944: add support for chain mode
Message-ID: <20240428172923.7dfe00ff@jic23-huawei>
In-Reply-To: <20240425-iio-ad7944-chain-mode-v1-1-9d9220ff21e1@baylibre.com>
References: <20240425-iio-ad7944-chain-mode-v1-0-9d9220ff21e1@baylibre.com>
	<20240425-iio-ad7944-chain-mode-v1-1-9d9220ff21e1@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 09:09:59 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for the chain mode of the AD7944 ADC. This mode allows
> multiple ADCs to be daisy-chained together. Data from all of the ADCs in
> is read by reading multiple words from the first ADC in the chain.
> 
> Each chip in the chain adds an extra IIO input voltage channel to the
> IIO device.
> 
> Only the wiring configuration where the SPI controller CS line is
> connected to the CNV pin of all of the ADCs in the chain is supported
> in this patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Looks good except for one minor tweak needed to ensure the allocated buffer
is zeroed as we don't necessarily overwrite the the whole thing.

Given that's all I found, I've just switched that to devm_kzalloc and
applied the series.

Applied to the togreg branch of iio.git and pushed out initially as testing
for 0-day to look at it.

Thanks,

Jonathan



>  
> +/**
> + * ad7944_chain_mode_alloc - allocate and initialize channel specs and buffers
> + *                           for daisy-chained devices
> + * @dev: The device for devm_ functions
> + * @chan_template: The channel template for the devices (array of 2 channels
> + *                 voltage and timestamp)
> + * @n_chain_dev: The number of devices in the chain
> + * @chain_chan: Pointer to receive the allocated channel specs
> + * @chain_mode_buf: Pointer to receive the allocated rx buffer
> + * @chain_scan_masks: Pointer to receive the allocated scan masks
> + * Return: 0 on success, a negative error code on failure
> + */
> +static int ad7944_chain_mode_alloc(struct device *dev,
> +				   const struct iio_chan_spec *chan_template,
> +				   u32 n_chain_dev,
> +				   struct iio_chan_spec **chain_chan,
> +				   void **chain_mode_buf,
> +				   unsigned long **chain_scan_masks)
> +{
> +	struct iio_chan_spec *chan;
> +	size_t chain_mode_buf_size;
> +	unsigned long *scan_masks;
> +	void *buf;
> +	int i;
> +
> +	/* 1 channel for each device in chain plus 1 for soft timestamp */
> +
> +	chan = devm_kcalloc(dev, n_chain_dev + 1, sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < n_chain_dev; i++) {
> +		chan[i] = chan_template[0];
> +
> +		if (chan_template[0].differential) {
> +			chan[i].channel = 2 * i;
> +			chan[i].channel2 = 2 * i + 1;
> +		} else {
> +			chan[i].channel = i;
> +		}
> +
> +		chan[i].scan_index = i;
> +	}
> +
> +	/* soft timestamp */
> +	chan[i] = chan_template[1];
> +	chan[i].scan_index = i;
> +
> +	*chain_chan = chan;
> +
> +	/* 1 word for each voltage channel + aligned u64 for timestamp */
> +
> +	chain_mode_buf_size = ALIGN(n_chain_dev *
> +		BITS_TO_BYTES(chan[0].scan_type.storagebits), sizeof(u64))
> +		+ sizeof(u64);
> +	buf = devm_kmalloc(dev, chain_mode_buf_size, GFP_KERNEL);

Zero it - It's not a problem to leak stale ADC data or similar
into the gap between the data and the timestamp, but it is a problem
if it's general kernel data potentially leaking.

So play it safe and devm_kzalloc()
		
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	*chain_mode_buf = buf;
> +
> +	/*
> +	 * Have to limit n_chain_dev due to current implementation of
> +	 * available_scan_masks.
> +	 */
> +	if (n_chain_dev > BITS_PER_LONG)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "chain is limited to 32 devices\n");
> +
> +	scan_masks = devm_kcalloc(dev, 2, sizeof(*scan_masks), GFP_KERNEL);
> +	if (!scan_masks)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Scan mask is needed since we always have to read all devices in the
> +	 * chain in one SPI transfer.
> +	 */
> +	scan_masks[0] = GENMASK(n_chain_dev - 1, 0);
> +
> +	*chain_scan_masks = scan_masks;
> +
> +	return 0;
> +}


