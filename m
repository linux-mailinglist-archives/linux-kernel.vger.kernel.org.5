Return-Path: <linux-kernel+bounces-105199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000487DA6E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E701F21398
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1CF18EB0;
	Sat, 16 Mar 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLVZ/VE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE71B95B;
	Sat, 16 Mar 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710598287; cv=none; b=QVBZmJv8Bncq2RfbknTRy+igX3sWBjyiyk91BhX3mO+1b2dUx9qzm/3K4bj1nnxAXlNJCM7wrZnFXpaGByiZujTa8U4fwX8R1j2ebkYqkOvZrn0LBGcJo1ydUBe7shbRF8S1pQwdtvefgtX4SFxQUV+PwdYTQQuTObPXjO+duTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710598287; c=relaxed/simple;
	bh=+5ENZD7r6w05wvwG9BkuxwChT/g6U2GZ59uq76qSZyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqMaSiYkx/Gj3x51VJfwO4xrtVlO9tAIyvseDPfHZRYHvRUfo3DiiNlDA5pcRz4CRk401J8nvDTpWvCxfpiaNe/zfIoYe0B2LAQENAJAOeBtEXwHYr00l0Bd/mOXbGRym9LwiRh3ejh94LvrofXsi2gY4TkuBvK6N+q0MACsYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLVZ/VE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86700C43390;
	Sat, 16 Mar 2024 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710598287;
	bh=+5ENZD7r6w05wvwG9BkuxwChT/g6U2GZ59uq76qSZyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qLVZ/VE+HubmhlAiE+uKYDOoFwYbnaicIRqOHXOA/TbY1Nhx2WBJbQliF9QQOpSDD
	 IbOc3l0tha+Kkn/2jWkYzmTtGkIDJuy8DeT7m4+M6l3vXUW2X90JYo+1Q6Xprtf3JB
	 3RK4v+MEHmgSAzufRNmvu7meFDgkMRPAP9bTl0rODwUhyquLrqzKZV9KV2pzW6w9e/
	 w/dj76EkESeYF/idPlRm9RsSAfTJAhl/WpQ/q9otev5UgKGHVKyASGnor0pZ9Y1H6O
	 PZ70Q0TrdDsbV8JKnEfVWPe+iykv1heWbWGCIIUL+/E6+mVS+f+hKDZkD5zaAezqPh
	 818kSK07NarVA==
Date: Sat, 16 Mar 2024 14:11:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
Message-ID: <20240316141114.1a1eea6b@jic23-huawei>
In-Reply-To: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 12:43:38 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for AD7944 ADCs wired in "3-wire mode". (NOTE: 3-wire
> is the datasheet name for this wiring configuration and has nothing to
> do with SPI_3WIRE.)
> 
> In the 3-wire mode, the SPI controller CS line can be wired to the CNV
> line on the ADC and used to trigger conversions rather that using a
> separate GPIO line.
> 
> The turbo/chain mode compatibility check at the end of the probe
> function is technically can't be triggered right now but adding it now
> anyway so that we don't forget to add it later when support for
> daisy-chaining is added.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the togreg-normal branch of iio.git.
I'll rebase that on rc1 once available before exposing it to linux-next.

Thanks

Jonathan

> ---
> Changes in v2:
> - Use default: in case statements.
> - Remove redundant else.
> - Explain turbo/chain mode check in commit message.
> - Link to v1: https://lore.kernel.org/r/20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com
> ---
>  drivers/iio/adc/ad7944.c | 157 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 139 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index adb007cdd287..d5ec6b5a41c7 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -32,8 +32,25 @@ struct ad7944_timing_spec {
>  	unsigned int turbo_conv_ns;
>  };
>  
> +enum ad7944_spi_mode {
> +	/* datasheet calls this "4-wire mode" */
> +	AD7944_SPI_MODE_DEFAULT,
> +	/* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!) */
> +	AD7944_SPI_MODE_SINGLE,
> +	/* datasheet calls this "chain mode" */
> +	AD7944_SPI_MODE_CHAIN,
> +};
> +
> +/* maps adi,spi-mode property value to enum */
> +static const char * const ad7944_spi_modes[] = {
> +	[AD7944_SPI_MODE_DEFAULT] = "",
> +	[AD7944_SPI_MODE_SINGLE] = "single",
> +	[AD7944_SPI_MODE_CHAIN] = "chain",
> +};
> +
>  struct ad7944_adc {
>  	struct spi_device *spi;
> +	enum ad7944_spi_mode spi_mode;
>  	/* Chip-specific timing specifications. */
>  	const struct ad7944_timing_spec *timing_spec;
>  	/* GPIO connected to CNV pin. */
> @@ -58,6 +75,9 @@ struct ad7944_adc {
>  	 } sample __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +/* quite time before CNV rising edge */
> +#define T_QUIET_NS	20
> +
>  static const struct ad7944_timing_spec ad7944_timing_spec = {
>  	.conv_ns = 420,
>  	.turbo_conv_ns = 320,
> @@ -110,6 +130,65 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
>  /* fully differential */
>  AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
>  
> +/*
> + * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion and
> + *                                   acquisition
> + * @adc: The ADC device structure
> + * @chan: The channel specification
> + * Return: 0 on success, a negative error code on failure
> + *
> + * This performs a conversion and reads data when the chip is wired in 3-wire
> + * mode with the CNV line on the ADC tied to the CS line on the SPI controller.
> + *
> + * Upon successful return adc->sample.raw will contain the conversion result.
> + */
> +static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
> +					   const struct iio_chan_spec *chan)
> +{
> +	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
> +						   : adc->timing_spec->conv_ns;
> +	struct spi_transfer xfers[] = {
> +		{
> +			/*
> +			 * NB: can get better performance from some SPI
> +			 * controllers if we use the same bits_per_word
> +			 * in every transfer.
> +			 */
> +			.bits_per_word = chan->scan_type.realbits,
> +			/*
> +			 * CS is tied to CNV and we need a low to high
> +			 * transition to start the conversion, so place CNV
> +			 * low for t_QUIET to prepare for this.
> +			 */
> +			.delay = {
> +				.value = T_QUIET_NS,
> +				.unit = SPI_DELAY_UNIT_NSECS,
> +			},
> +
> +		},
> +		{
> +			.bits_per_word = chan->scan_type.realbits,
> +			/*
> +			 * CS has to be high for full conversion time to avoid
> +			 * triggering the busy indication.
> +			 */
> +			.cs_off = 1,
> +			.delay = {
> +				.value = t_conv_ns,
> +				.unit = SPI_DELAY_UNIT_NSECS,
> +			},
> +		},
> +		{
> +			/* Then we can read the data during the acquisition phase */
> +			.rx_buf = &adc->sample.raw,
> +			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
> +			.bits_per_word = chan->scan_type.realbits,
> +		},
> +	};
> +
> +	return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
> +}
> +
>  /*
>   * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion and acquisition
>   * @adc: The ADC device structure
> @@ -167,9 +246,22 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
>  {
>  	int ret;
>  
> -	ret = ad7944_4wire_mode_conversion(adc, chan);
> -	if (ret)
> -		return ret;
> +	switch (adc->spi_mode) {
> +	case AD7944_SPI_MODE_DEFAULT:
> +		ret = ad7944_4wire_mode_conversion(adc, chan);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case AD7944_SPI_MODE_SINGLE:
> +		ret = ad7944_3wire_cs_mode_conversion(adc, chan);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  
>  	if (chan->scan_type.storagebits > 16)
>  		*val = adc->sample.raw.u32;
> @@ -230,9 +322,23 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
>  	struct ad7944_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
> -	if (ret)
> +	switch (adc->spi_mode) {
> +	case AD7944_SPI_MODE_DEFAULT:
> +		ret = ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
> +		if (ret)
> +			goto out;
> +
> +		break;
> +	case AD7944_SPI_MODE_SINGLE:
> +		ret = ad7944_3wire_cs_mode_conversion(adc, &indio_dev->channels[0]);
> +		if (ret)
> +			goto out;
> +
> +		break;
> +	default:
> +		/* not supported */
>  		goto out;
> +	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
>  					   pf->timestamp);
> @@ -260,16 +366,9 @@ static int ad7944_probe(struct spi_device *spi)
>  	struct ad7944_adc *adc;
>  	bool have_refin = false;
>  	struct regulator *ref;
> +	const char *str_val;
>  	int ret;
>  
> -	/*
> -	 * driver currently only supports the conventional "4-wire" mode and
> -	 * not other special wiring configurations.
> -	 */
> -	if (device_property_present(dev, "adi,spi-mode"))
> -		return dev_err_probe(dev, -EINVAL,
> -				     "adi,spi-mode is not currently supported\n");
> -
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -283,6 +382,22 @@ static int ad7944_probe(struct spi_device *spi)
>  
>  	adc->timing_spec = chip_info->timing_spec;
>  
> +	if (device_property_read_string(dev, "adi,spi-mode", &str_val) == 0) {
> +		ret = sysfs_match_string(ad7944_spi_modes, str_val);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "unsupported adi,spi-mode\n");
> +
> +		adc->spi_mode = ret;
> +	} else {
> +		/* absence of adi,spi-mode property means default mode */
> +		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> +	}
> +
> +	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "chain mode is not implemented\n");
> +
>  	/*
>  	 * Some chips use unusual word sizes, so check now instead of waiting
>  	 * for the first xfer.
> @@ -349,15 +464,17 @@ static int ad7944_probe(struct spi_device *spi)
>  		adc->ref_mv = AD7944_INTERNAL_REF_MV;
>  	}
>  
> -	/*
> -	 * CNV gpio is required in 4-wire mode which is the only currently
> -	 * supported mode.
> -	 */
> -	adc->cnv = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
> +	adc->cnv = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
>  	if (IS_ERR(adc->cnv))
>  		return dev_err_probe(dev, PTR_ERR(adc->cnv),
>  				     "failed to get CNV GPIO\n");
>  
> +	if (!adc->cnv && adc->spi_mode == AD7944_SPI_MODE_DEFAULT)
> +		return dev_err_probe(&spi->dev, -EINVAL, "CNV GPIO is required\n");
> +	if (adc->cnv && adc->spi_mode != AD7944_SPI_MODE_DEFAULT)
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				     "CNV GPIO in single and chain mode is not currently supported\n");
> +
>  	adc->turbo = devm_gpiod_get_optional(dev, "turbo", GPIOD_OUT_LOW);
>  	if (IS_ERR(adc->turbo))
>  		return dev_err_probe(dev, PTR_ERR(adc->turbo),
> @@ -369,6 +486,10 @@ static int ad7944_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, -EINVAL,
>  			"cannot have both turbo-gpios and adi,always-turbo\n");
>  
> +	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN && adc->always_turbo)
> +		return dev_err_probe(dev, -EINVAL,
> +			"cannot have both chain mode and always turbo\n");
> +
>  	indio_dev->name = chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad7944_iio_info;
> 
> ---
> base-commit: bbafdb305d6b00934cc09a90ec1bb659d43e5171
> change-id: 20240311-mainline-ad7944-3-wire-mode-c240fe8af979


