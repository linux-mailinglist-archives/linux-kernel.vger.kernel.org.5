Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BD17C008E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjJJPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjJJPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:43:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282CD99;
        Tue, 10 Oct 2023 08:43:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361D2C433C8;
        Tue, 10 Oct 2023 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952593;
        bh=GHnFVe/GxLsz7kw6wXnCJNA0sN+NdtqFX1tBlPjlQ/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T409EMEx+SKxab4cDSpb56Ui0GksDAVAQz5uncUUmQa8aeL6FmsQXlBwhJG0Xi/hP
         fVZqH2rDvMx613QCPybc/tYSEmqWujDMHfrt16KzuyZoQFMdX/bxySVh8OqGagW1WE
         jFnO2OSewU/1VxFazAmSPDxCB8mWT1RQQaWWBC13mhWTYcI7WsLUKw1ZYl6wxk5b/T
         //bY5M34IS/3Xs/OnKZnL00sWPDKl6DkZlbRPKee8n64vZkO1/8BMu1wwZCldMy1xo
         ibcGlk2wDAjbbdNam0jMC4WAnTTgogsAlGvJvab3JG0MapyVaD8r5/7OrYl3jWQpKR
         PwmUsG0tBR17A==
Date:   Tue, 10 Oct 2023 16:43:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/17] staging: iio: resolver: ad2s1210: convert
 resolution to devicetree property
Message-ID: <20231010164327.79d84ba3@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-4-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-4-ec00746840fc@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Oct 2023 19:50:21 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Selecting the resolution was implemented as the `bits` sysfs attribute.
> However, the selection of the resolution depends on how the hardware
> is wired and the specific application, so this is rather a job for
> devicetree to describe.
> 
> A new devicetree property `assigned-resolution-bits` to specify the
> resolution required for each chip is added and the `bits` sysfs
> attribute is removed.
> 
> Since the resolution is now supplied by a devicetree property, the
> resolution-gpios are now optional and we can allow for the case where
> the resolution pins on the AD2S1210 are hard-wired instead of requiring
> them to be connected to gpios.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied

> ---
> 
> v4 changes:
> * Fixed devicetree property name in commit message.
> * Reworked handling of hysteresis_available to handle
>   assigned-resolution-bits != 16.
> 
> v3 changes:
> * Fixed multiline comment style.
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 150 +++++++++++++++-----------------
>  1 file changed, 71 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 0c7772725330..66ef35fbb6fe 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -63,6 +63,13 @@ enum ad2s1210_mode {
>  	MOD_CONFIG = 0b11,
>  };
>  
> +enum ad2s1210_resolution {
> +	AD2S1210_RES_10 = 0b00,
> +	AD2S1210_RES_12 = 0b01,
> +	AD2S1210_RES_14 = 0b10,
> +	AD2S1210_RES_16 = 0b11,
> +};
> +
>  struct ad2s1210_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;
> @@ -70,15 +77,14 @@ struct ad2s1210_state {
>  	struct gpio_desc *sample_gpio;
>  	/** GPIO pins connected to A0 and A1 lines. */
>  	struct gpio_descs *mode_gpios;
> -	/** GPIO pins connected to RES0 and RES1 lines. */
> -	struct gpio_descs *resolution_gpios;
>  	/** Used to access config registers. */
>  	struct regmap *regmap;
>  	/** The external oscillator frequency in Hz. */
>  	unsigned long clkin_hz;
>  	/** Available raw hysteresis values based on resolution. */
>  	int hysteresis_available[2];
> -	u8 resolution;
> +	/** The selected resolution */
> +	enum ad2s1210_resolution resolution;
>  	/** For reading raw sample value via SPI. */
>  	__be16 sample __aligned(IIO_DMA_MINALIGN);
>  	/** SPI transmit buffer. */
> @@ -215,63 +221,6 @@ static int ad2s1210_reinit_excitation_frequency(struct ad2s1210_state *st,
>  	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
>  }
>  
> -static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
> -					 u8 resolution)
> -{
> -	struct gpio_descs *gpios = st->resolution_gpios;
> -	DECLARE_BITMAP(bitmap, 2);
> -
> -	bitmap[0] = (resolution - 10) >> 1;
> -
> -	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
> -				     bitmap);
> -}
> -
> -static ssize_t ad2s1210_show_resolution(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -
> -	return sprintf(buf, "%d\n", st->resolution);
> -}
> -
> -static ssize_t ad2s1210_store_resolution(struct device *dev,
> -					 struct device_attribute *attr,
> -					 const char *buf, size_t len)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned char data;
> -	unsigned char udata;
> -	int ret;
> -
> -	ret = kstrtou8(buf, 10, &udata);
> -	if (ret || udata < 10 || udata > 16) {
> -		dev_err(dev, "ad2s1210: resolution out of range\n");
> -		return -EINVAL;
> -	}
> -
> -	data = (udata - 10) >> 1;
> -
> -	mutex_lock(&st->lock);
> -	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> -				 AD2S1210_SET_RES, data);
> -	if (ret < 0)
> -		goto error_ret;
> -
> -	ret = ad2s1210_set_resolution_gpios(st, udata);
> -	if (ret < 0)
> -		goto error_ret;
> -
> -	st->resolution = udata;
> -	st->hysteresis_available[1] = 1 << (16 - st->resolution);
> -	ret = len;
> -
> -error_ret:
> -	mutex_unlock(&st->lock);
> -	return ret;
> -}
> -
>  /* read the fault register since last sample */
>  static ssize_t ad2s1210_show_fault(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
> @@ -413,7 +362,7 @@ static int ad2s1210_get_hysteresis(struct ad2s1210_state *st, int *val)
>  	if (ret < 0)
>  		return ret;
>  
> -	*val = ret << (16 - st->resolution);
> +	*val = ret << (2 * (AD2S1210_RES_16 - st->resolution));
>  	return IIO_VAL_INT;
>  }
>  
> @@ -577,8 +526,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static IIO_DEVICE_ATTR(bits, 0644,
> -		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
>  static IIO_DEVICE_ATTR(fault, 0644,
>  		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
>  
> @@ -633,7 +580,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  };
>  
>  static struct attribute *ad2s1210_attributes[] = {
> -	&iio_dev_attr_bits.dev_attr.attr,
>  	&iio_dev_attr_fault.dev_attr.attr,
>  	&iio_dev_attr_los_thrd.dev_attr.attr,
>  	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
> @@ -655,15 +601,12 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	ret = ad2s1210_set_resolution_gpios(st, st->resolution);
> -	if (ret < 0)
> -		goto error_ret;
>  
>  	/* Use default config register value plus resolution from devicetree. */
>  	data = FIELD_PREP(AD2S1210_PHASE_LOCK_RANGE_44, 1);
>  	data |= FIELD_PREP(AD2S1210_ENABLE_HYSTERESIS, 1);
>  	data |= FIELD_PREP(AD2S1210_SET_ENRES, 0x3);
> -	data |= FIELD_PREP(AD2S1210_SET_RES, (st->resolution - 10) >> 1);
> +	data |= FIELD_PREP(AD2S1210_SET_RES, st->resolution);
>  
>  	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
>  	if (ret < 0)
> @@ -703,6 +646,35 @@ static const struct iio_info ad2s1210_info = {
>  	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
>  };
>  
> +static int ad2s1210_setup_properties(struct ad2s1210_state *st)
> +{
> +	struct device *dev = &st->sdev->dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "assigned-resolution-bits", &val);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"failed to read assigned-resolution-bits property\n");
> +
> +	if (val < 10 || val > 16)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "resolution out of range: %u\n", val);
> +
> +	st->resolution = (val - 10) >> 1;
> +	/*
> +	 * These are values that correlate to the hysteresis bit in the Control
> +	 * register. 0 = disabled, 1 = enabled. When enabled, the actual
> +	 * hysteresis is +/- 1 LSB of the raw position value. Which bit is the
> +	 * LSB depends on the specified resolution.
> +	 */
> +	st->hysteresis_available[0] = 0;
> +	st->hysteresis_available[1] = 1 << (2 * (AD2S1210_RES_16 -
> +						 st->resolution));
> +
> +	return 0;
> +}
> +
>  static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
>  {
>  	struct device *dev = &st->sdev->dev;
> @@ -724,6 +696,9 @@ static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
>  static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  {
>  	struct device *dev = &st->sdev->dev;
> +	struct gpio_descs *resolution_gpios;
> +	DECLARE_BITMAP(bitmap, 2);
> +	int ret;
>  
>  	/* should not be sampling on startup */
>  	st->sample_gpio = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
> @@ -741,16 +716,32 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  		return dev_err_probe(dev, -EINVAL,
>  				     "requires exactly 2 mode-gpios\n");
>  
> -	/* both pins high means that we start with 16-bit resolution */
> -	st->resolution_gpios = devm_gpiod_get_array(dev, "resolution",
> -						    GPIOD_OUT_HIGH);
> -	if (IS_ERR(st->resolution_gpios))
> -		return dev_err_probe(dev, PTR_ERR(st->resolution_gpios),
> +	/*
> +	 * If resolution gpios are provided, they get set to the required
> +	 * resolution, otherwise it is assumed the RES0 and RES1 pins are
> +	 * hard-wired to match the resolution indicated in the devicetree.
> +	 */
> +	resolution_gpios = devm_gpiod_get_array_optional(dev, "resolution",
> +							 GPIOD_ASIS);
> +	if (IS_ERR(resolution_gpios))
> +		return dev_err_probe(dev, PTR_ERR(resolution_gpios),
>  				     "failed to request resolution GPIOs\n");
>  
> -	if (st->resolution_gpios->ndescs != 2)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "requires exactly 2 resolution-gpios\n");
> +	if (resolution_gpios) {
> +		if (resolution_gpios->ndescs != 2)
> +			return dev_err_probe(dev, -EINVAL,
> +				      "requires exactly 2 resolution-gpios\n");
> +
> +		bitmap[0] = st->resolution;
> +
> +		ret = gpiod_set_array_value(resolution_gpios->ndescs,
> +					    resolution_gpios->desc,
> +					    resolution_gpios->info,
> +					    bitmap);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to set resolution gpios\n");
> +	}
>  
>  	return 0;
>  }
> @@ -814,9 +805,10 @@ static int ad2s1210_probe(struct spi_device *spi)
>  
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
> -	st->resolution = 12;
> -	st->hysteresis_available[0] = 0;
> -	st->hysteresis_available[1] = 1 << (16 - st->resolution);
> +
> +	ret = ad2s1210_setup_properties(st);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = ad2s1210_setup_clocks(st);
>  	if (ret < 0)
> 

