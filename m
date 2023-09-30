Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9467B414B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjI3Ozm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjI3Ozl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:55:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2CFBD;
        Sat, 30 Sep 2023 07:55:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FA7C433C8;
        Sat, 30 Sep 2023 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696085738;
        bh=mxWRNV/8sFvjZtQJIyZAh5p17e8bnWxNsgYTe1A8Cco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qgNE+OYEwI8FPW3dJqyt5h0m2BgzeZ0ctY8apaTk2+HoO1UZfh/Q5ZeuW49sE0vOJ
         0GWDtymVfB/CTRr8CoCOQc6MykyBuG25dA2njjNptS/pghmfNdZtJdnPdWh5OHqAUQ
         PjwNWNhcGx3uBsX26WsHmH4pTLDrnpacFHuoDRFxu37XiekcFPfxGQZll0HY9A8qRA
         0oz5FDAVxqdIeU8usw5i+oY2OmrpbBwQ+8NVz2JtZ3TSOLDrPI9ye4cZb8RT+Fun62
         fRUNfj+oZ+HwAhsyArDftHlCzkl4+eTppRL+K4R3sVeWdcPq8sQWiNRzAmy722az5j
         ZAFVqPivqkNXA==
Date:   Sat, 30 Sep 2023 15:55:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/27] staging: iio: resolver: ad2s1210: rework gpios
Message-ID: <20230930155536.5a5e982e@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-13-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-13-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> - Remove "adi," prefix from gpio names.
> - Sample gpio is now expected to be active low.
> - Convert A0 and A1 gpios to "mode-gpios" gpio array.
> - Convert RES0 and RES1 gpios to "resolution-gpios" gpio array.
> - Remove extraneous lookup tables.
> - Remove unused mode field from state struct.
> - Swap argument order of ad2s1210_set_mode() while we are touching this.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied,

Thanks,
Jonathan

> ---
> 
> v3 changes:
> * Fixed multiline comment style.
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 164 +++++++++++++++++---------------
>  1 file changed, 85 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 2b9377447f6a..0ec3598b600a 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -58,39 +58,21 @@
>  #define AD2S1210_DEF_EXCIT	10000
>  
>  enum ad2s1210_mode {
> -	MOD_POS = 0,
> -	MOD_VEL,
> -	MOD_CONFIG,
> -	MOD_RESERVED,
> +	MOD_POS = 0b00,
> +	MOD_VEL = 0b01,
> +	MOD_RESERVED = 0b10,
> +	MOD_CONFIG = 0b11,
>  };
>  
> -enum ad2s1210_gpios {
> -	AD2S1210_SAMPLE,
> -	AD2S1210_A0,
> -	AD2S1210_A1,
> -	AD2S1210_RES0,
> -	AD2S1210_RES1,
> -};
> -
> -struct ad2s1210_gpio {
> -	const char *name;
> -	unsigned long flags;
> -};
> -
> -static const struct ad2s1210_gpio gpios[] = {
> -	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_OUT_LOW },
> -	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_OUT_LOW },
> -	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_OUT_LOW },
> -	[AD2S1210_RES0] = { .name = "adi,res0", .flags = GPIOD_OUT_LOW },
> -	[AD2S1210_RES1] = { .name = "adi,res1", .flags = GPIOD_OUT_LOW },
> -};
> -
> -static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
> -
>  struct ad2s1210_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;
> -	struct gpio_desc *gpios[5];
> +	/** GPIO pin connected to SAMPLE line. */
> +	struct gpio_desc *sample_gpio;
> +	/** GPIO pins connected to A0 and A1 lines. */
> +	struct gpio_descs *mode_gpios;
> +	/** GPIO pins connected to RES0 and RES1 lines. */
> +	struct gpio_descs *resolution_gpios;
>  	/** Used to access config registers. */
>  	struct regmap *regmap;
>  	/** The external oscillator frequency in Hz. */
> @@ -98,7 +80,6 @@ struct ad2s1210_state {
>  	unsigned int fexcit;
>  	bool hysteresis;
>  	u8 resolution;
> -	enum ad2s1210_mode mode;
>  	/** For reading raw sample value via SPI. */
>  	__be16 sample __aligned(IIO_DMA_MINALIGN);
>  	/** SPI transmit buffer. */
> @@ -107,18 +88,15 @@ struct ad2s1210_state {
>  	u8 tx[2];
>  };
>  
> -static const int ad2s1210_mode_vals[4][2] = {
> -	[MOD_POS] = { 0, 0 },
> -	[MOD_VEL] = { 0, 1 },
> -	[MOD_CONFIG] = { 1, 1 },
> -};
> -
> -static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
> -				     struct ad2s1210_state *st)
> +static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
>  {
> -	gpiod_set_value(st->gpios[AD2S1210_A0], ad2s1210_mode_vals[mode][0]);
> -	gpiod_set_value(st->gpios[AD2S1210_A1], ad2s1210_mode_vals[mode][1]);
> -	st->mode = mode;
> +	struct gpio_descs *gpios = st->mode_gpios;
> +	DECLARE_BITMAP(bitmap, 2);
> +
> +	bitmap[0] = mode;
> +
> +	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
> +				     bitmap);
>  }
>  
>  /*
> @@ -143,6 +121,7 @@ static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
>  			.tx_buf = &st->tx[1],
>  		},
>  	};
> +	int ret;
>  
>  	/* values can only be 7 bits, the MSB indicates an address */
>  	if (val & ~0x7F)
> @@ -151,7 +130,9 @@ static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
>  	st->tx[0] = reg;
>  	st->tx[1] = val;
>  
> -	ad2s1210_set_mode(MOD_CONFIG, st);
> +	ret = ad2s1210_set_mode(st, MOD_CONFIG);
> +	if (ret < 0)
> +		return ret;
>  
>  	return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
>  }
> @@ -180,7 +161,10 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
>  	};
>  	int ret;
>  
> -	ad2s1210_set_mode(MOD_CONFIG, st);
> +	ret = ad2s1210_set_mode(st, MOD_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +
>  	st->tx[0] = reg;
>  	/*
>  	 * Must be valid register address here otherwise this could write data.
> @@ -219,16 +203,16 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
>  	return regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
>  }
>  
> -static const int ad2s1210_res_pins[4][2] = {
> -	{ 0, 0 }, {0, 1}, {1, 0}, {1, 1}
> -};
> -
> -static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
> +static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
> +					 u8 resolution)
>  {
> -	gpiod_set_value(st->gpios[AD2S1210_RES0],
> -			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> -	gpiod_set_value(st->gpios[AD2S1210_RES1],
> -			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
> +	struct gpio_descs *gpios = st->resolution_gpios;
> +	DECLARE_BITMAP(bitmap, 2);
> +
> +	bitmap[0] = (resolution - 10) >> 1;
> +
> +	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
> +				     bitmap);
>  }
>  
>  static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
> @@ -305,10 +289,13 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	st->resolution =
> -		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
> -	ad2s1210_set_resolution_pin(st);
> +	ret = ad2s1210_set_resolution_gpios(st, udata);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	st->resolution = udata;
>  	ret = len;
> +
>  error_ret:
>  	mutex_unlock(&st->lock);
>  	return ret;
> @@ -339,15 +326,19 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
> +
> +	gpiod_set_value(st->sample_gpio, 1);
>  	/* delay (2 * tck + 20) nano seconds */
>  	udelay(1);
> -	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
> +	gpiod_set_value(st->sample_gpio, 0);
> +
>  	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
>  	if (ret < 0)
>  		goto error_ret;
> -	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
> -	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
> +
> +	gpiod_set_value(st->sample_gpio, 1);
> +	gpiod_set_value(st->sample_gpio, 0);
> +
>  error_ret:
>  	mutex_unlock(&st->lock);
>  
> @@ -393,19 +384,19 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
>  				      struct iio_chan_spec const *chan,
>  				      int *val)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	mutex_lock(&st->lock);
> -	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
> +	gpiod_set_value(st->sample_gpio, 1);
>  	/* delay (6 * tck + 20) nano seconds */
>  	udelay(1);
>  
>  	switch (chan->type) {
>  	case IIO_ANGL:
> -		ad2s1210_set_mode(MOD_POS, st);
> +		ret = ad2s1210_set_mode(st, MOD_POS);
>  		break;
>  	case IIO_ANGL_VEL:
> -		ad2s1210_set_mode(MOD_VEL, st);
> +		ret = ad2s1210_set_mode(st, MOD_VEL);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -432,7 +423,7 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
>  	}
>  
>  error_ret:
> -	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
> +	gpiod_set_value(st->sample_gpio, 0);
>  	/* delay (2 * tck + 20) nano seconds */
>  	udelay(1);
>  	mutex_unlock(&st->lock);
> @@ -546,7 +537,9 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	ad2s1210_set_resolution_pin(st);
> +	ret = ad2s1210_set_resolution_gpios(st, st->resolution);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Use default config register value plus resolution from devicetree. */
>  	data = FIELD_PREP(AD2S1210_PHASE_LOCK_RANGE_44, 1);
> @@ -612,20 +605,34 @@ static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
>  
>  static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  {
> -	struct spi_device *spi = st->sdev;
> -	int i, ret;
> -
> -	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> -		st->gpios[i] = devm_gpiod_get(&spi->dev, gpios[i].name,
> -					      gpios[i].flags);
> -		if (IS_ERR(st->gpios[i])) {
> -			ret = PTR_ERR(st->gpios[i]);
> -			dev_err(&spi->dev,
> -				"ad2s1210: failed to request %s GPIO: %d\n",
> -				gpios[i].name, ret);
> -			return ret;
> -		}
> -	}
> +	struct device *dev = &st->sdev->dev;
> +
> +	/* should not be sampling on startup */
> +	st->sample_gpio = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->sample_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->sample_gpio),
> +				     "failed to request sample GPIO\n");
> +
> +	/* both pins high means that we start in config mode */
> +	st->mode_gpios = devm_gpiod_get_array(dev, "mode", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->mode_gpios))
> +		return dev_err_probe(dev, PTR_ERR(st->mode_gpios),
> +				     "failed to request mode GPIOs\n");
> +
> +	if (st->mode_gpios->ndescs != 2)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "requires exactly 2 mode-gpios\n");
> +
> +	/* both pins high means that we start with 16-bit resolution */
> +	st->resolution_gpios = devm_gpiod_get_array(dev, "resolution",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->resolution_gpios))
> +		return dev_err_probe(dev, PTR_ERR(st->resolution_gpios),
> +				     "failed to request resolution GPIOs\n");
> +
> +	if (st->resolution_gpios->ndescs != 2)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "requires exactly 2 resolution-gpios\n");
>  
>  	return 0;
>  }
> @@ -690,7 +697,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
>  	st->hysteresis = true;
> -	st->mode = MOD_CONFIG;
>  	st->resolution = 12;
>  	st->fexcit = AD2S1210_DEF_EXCIT;
>  
> 

