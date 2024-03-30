Return-Path: <linux-kernel+bounces-125773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1A892BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA9282B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817173A8C0;
	Sat, 30 Mar 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du9Y9JyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961063BB35;
	Sat, 30 Mar 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711814847; cv=none; b=aq4tuCFfXNyPicJNhGpqVNM6PVMqAfdeUlQPRQrNDWYB7kQhyoPUerT72X4WU9R3FlpwsZVMx6Oay1cR9EQXS3TWWwW0NqzIPRdFNtT1zV17KpSG0rR3mNDhPkl+damsD4q5DIKxl/e/jIh73JZtzHA/6y0Prshv0XGxbs7qavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711814847; c=relaxed/simple;
	bh=l2mFFOVYDzVrP6zBdCCMZnoabUzTFe04bmPraTq3D0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1Gq+UMbok9KiiLk1WA3KJp7l+Z+4cQQGbBwOG0ZEVpDKO+Z/4GBnI70U+XelYYiHxR2snAuXEVZryAAK1y/0dcImpsU/N4mRcLA0FpT4pXrJp6dyAfZ/DvwdcN2ySeGtN02+64npAWty4uJNB5G1opNKh/XLiaEyOmE6llk2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du9Y9JyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30190C433F1;
	Sat, 30 Mar 2024 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711814847;
	bh=l2mFFOVYDzVrP6zBdCCMZnoabUzTFe04bmPraTq3D0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=du9Y9JyPcB2pxbPlwyRNjk6Rr62M0YIhb6zuNDlFz6+ZfceUYTidwVFOUL65CCNXU
	 nt2CSs+JIqu9Fr+ag5GTrlo6lUi8h+jd4TIWClUkWp5/IU2tvXLzg6fvg9z5kieFYw
	 dOwuncIX0VnbS0wo/5d02U1EjFOslwGMn1hZQIuFc1EEpQ40O1VFApuCZMEUItk9kW
	 VaYIr3j/WkUKkonLj/9RkpLgcDs3j+TMtvqVfo1rfIo7QWFsA97J3NvbiStpGFQMM1
	 xN9cXgCBllf3xDLS7mGTuBm1yQuODW8jRnpGVgq5GunJpLfIdIDpz/+JyP5U1zES09
	 4n8n4JRaZWMQw==
Date: Sat, 30 Mar 2024 16:07:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: use spi_optimize_message()
Message-ID: <20240330160713.7b31c201@jic23-huawei>
In-Reply-To: <20240328-ad7944-spi-optimize-message-v2-1-a142b2576379@baylibre.com>
References: <20240328-ad7944-spi-optimize-message-v2-1-a142b2576379@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 16:16:59 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This modifies the ad7944 driver to use spi_optimize_message() to reduce
> CPU usage and increase the max sample rate by avoiding repeating
> validation of the spi message on each transfer.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Fix wrong array index in ad7944_3wire_cs_mode_init_msg()
> - Fixed wrong number of xfers in ad7944_4wire_mode_init_msg()
> - Link to v1: https://lore.kernel.org/r/20240325-ad7944-spi-optimize-message-v1-1-cded69b9e27f@baylibre.com
> ---
>  drivers/iio/adc/ad7944.c | 177 +++++++++++++++++++++++++++--------------------
>  1 file changed, 103 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index 261a3f645fd8..e09ab0c842d3 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -51,6 +51,8 @@ static const char * const ad7944_spi_modes[] = {
>  struct ad7944_adc {
>  	struct spi_device *spi;
>  	enum ad7944_spi_mode spi_mode;
> +	struct spi_transfer xfers[3];
> +	struct spi_message msg;
>  	/* Chip-specific timing specifications. */
>  	const struct ad7944_timing_spec *timing_spec;
>  	/* GPIO connected to CNV pin. */
> @@ -130,6 +132,88 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
>  /* fully differential */
>  AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
>  
> +static void ad7944_unoptimize_msg(void *msg)
> +{
> +	spi_unoptimize_message(msg);
> +}
> +
> +static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
> +					 const struct iio_chan_spec *chan)
> +{
> +	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
> +						   : adc->timing_spec->conv_ns;
> +	struct spi_transfer *xfers = adc->xfers;
> +	int ret;
> +
> +	/*
> +	 * NB: can get better performance from some SPI controllers if we use
> +	 * the same bits_per_word in every transfer.
> +	 */
> +	xfers[0].bits_per_word = chan->scan_type.realbits;
> +	/*
> +	 * CS is tied to CNV and we need a low to high transition to start the
> +	 * conversion, so place CNV low for t_QUIET to prepare for this.
> +	 */
> +	xfers[0].delay.value = T_QUIET_NS;
> +	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +	/*
> +	 * CS has to be high for full conversion time to avoid triggering the
> +	 * busy indication.
> +	 */
> +	xfers[1].cs_off = 1;
> +	xfers[1].delay.value = t_conv_ns;
> +	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
> +	xfers[1].bits_per_word = chan->scan_type.realbits;
> +
> +	/* Then we can read the data during the acquisition phase */
> +	xfers[2].rx_buf = &adc->sample.raw;
> +	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> +	xfers[2].bits_per_word = chan->scan_type.realbits;
> +
> +	spi_message_init_with_transfers(&adc->msg, xfers, 3);
> +
> +	ret = spi_optimize_message(adc->spi, &adc->msg);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
> +}
> +
> +static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
> +				      const struct iio_chan_spec *chan)
> +{
> +	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
> +						   : adc->timing_spec->conv_ns;
> +	struct spi_transfer *xfers = adc->xfers;
> +	int ret;
> +
> +	/*
> +	 * NB: can get better performance from some SPI controllers if we use
> +	 * the same bits_per_word in every transfer.
> +	 */
> +	xfers[0].bits_per_word = chan->scan_type.realbits;
> +	/*
> +	 * CS has to be high for full conversion time to avoid triggering the
> +	 * busy indication.
> +	 */
> +	xfers[0].cs_off = 1;
> +	xfers[0].delay.value = t_conv_ns;
> +	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +	xfers[1].rx_buf = &adc->sample.raw;
> +	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> +	xfers[1].bits_per_word = chan->scan_type.realbits;
> +
> +	spi_message_init_with_transfers(&adc->msg, xfers, 2);
> +
> +	ret = spi_optimize_message(adc->spi, &adc->msg);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
> +}
> +
>  /*
>   * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion and
>   *                                   acquisition
> @@ -145,48 +229,7 @@ AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
>  static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
>  					   const struct iio_chan_spec *chan)
>  {
> -	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
> -						   : adc->timing_spec->conv_ns;
> -	struct spi_transfer xfers[] = {
> -		{
> -			/*
> -			 * NB: can get better performance from some SPI
> -			 * controllers if we use the same bits_per_word
> -			 * in every transfer.
> -			 */
> -			.bits_per_word = chan->scan_type.realbits,
> -			/*
> -			 * CS is tied to CNV and we need a low to high
> -			 * transition to start the conversion, so place CNV
> -			 * low for t_QUIET to prepare for this.
> -			 */
> -			.delay = {
> -				.value = T_QUIET_NS,
> -				.unit = SPI_DELAY_UNIT_NSECS,
> -			},
> -
> -		},
> -		{
> -			.bits_per_word = chan->scan_type.realbits,
> -			/*
> -			 * CS has to be high for full conversion time to avoid
> -			 * triggering the busy indication.
> -			 */
> -			.cs_off = 1,
> -			.delay = {
> -				.value = t_conv_ns,
> -				.unit = SPI_DELAY_UNIT_NSECS,
> -			},
> -		},
> -		{
> -			/* Then we can read the data during the acquisition phase */
> -			.rx_buf = &adc->sample.raw,
> -			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
> -			.bits_per_word = chan->scan_type.realbits,
> -		},
> -	};
> -
> -	return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
> +	return spi_sync(adc->spi, &adc->msg);
>  }
>  
>  /*
> @@ -200,33 +243,6 @@ static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
>  static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
>  					const struct iio_chan_spec *chan)
>  {
> -	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
> -						   : adc->timing_spec->conv_ns;
> -	struct spi_transfer xfers[] = {
> -		{
> -			/*
> -			 * NB: can get better performance from some SPI
> -			 * controllers if we use the same bits_per_word
> -			 * in every transfer.
> -			 */
> -			.bits_per_word = chan->scan_type.realbits,
> -			/*
> -			 * CS has to be high for full conversion time to avoid
> -			 * triggering the busy indication.
> -			 */
> -			.cs_off = 1,
> -			.delay = {
> -				.value = t_conv_ns,
> -				.unit = SPI_DELAY_UNIT_NSECS,
> -			},
> -
> -		},
> -		{
> -			.rx_buf = &adc->sample.raw,
> -			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
> -			.bits_per_word = chan->scan_type.realbits,
> -		},
> -	};
>  	int ret;
>  
>  	/*
> @@ -234,7 +250,7 @@ static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
>  	 * and acquisition process.
>  	 */
>  	gpiod_set_value_cansleep(adc->cnv, 1);
> -	ret = spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
> +	ret = spi_sync(adc->spi, &adc->msg);
>  	gpiod_set_value_cansleep(adc->cnv, 0);
>  
>  	return ret;
> @@ -395,10 +411,6 @@ static int ad7944_probe(struct spi_device *spi)
>  		adc->spi_mode = ret;
>  	}
>  
> -	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "chain mode is not implemented\n");
> -
>  	/*
>  	 * Some chips use unusual word sizes, so check now instead of waiting
>  	 * for the first xfer.
> @@ -491,6 +503,23 @@ static int ad7944_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, -EINVAL,
>  			"cannot have both chain mode and always turbo\n");
>  
> +	switch (adc->spi_mode) {
> +	case AD7944_SPI_MODE_DEFAULT:
> +		ret = ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case AD7944_SPI_MODE_SINGLE:
> +		ret = ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case AD7944_SPI_MODE_CHAIN:
> +		return dev_err_probe(dev, -EINVAL, "chain mode is not implemented\n");
> +	}
> +
>  	indio_dev->name = chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad7944_iio_info;
> 
> ---
> base-commit: 526f7f17b651c78ead26fea7cea20948c00e47a5
> change-id: 20240325-ad7944-spi-optimize-message-82debaa2a5a7
> 
> Best regards,


