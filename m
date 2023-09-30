Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE27B411A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjI3Ooj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbjI3Ooi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:44:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BEFB7;
        Sat, 30 Sep 2023 07:44:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB555C433C7;
        Sat, 30 Sep 2023 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696085075;
        bh=srsV9LLNZ68cAc90tjmpt0BBRZWzeQK3dFzkoTOgl30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t2eVsP6B3WYpPseUphhkbRc5B+bIhVJ7zs/kRWs92ngBnEKlx3Ixx72HsHEVvsKjk
         M1x7cf5ShKcVRD3C+euc0tagl2vV7cBXillb5lxMTZw/NgxrzHREX/XN9NcNP4BqaD
         DaozeNDfhzYWJn60cK+XReykeZacbe/lx+pLC2KpzZMZkpGS4Dki/QUjldt28hHij7
         eZF/WP3m/wvpIooNNbcclOdZGVrUYe014/Pazd5ZhGqym/ctVbjeBtm+AqO5cY/fOz
         kY6ZmsEwYV2s0Xtxm08uBSIJPnXs8wFTJ+jv6PQARfOF5YutYXwDpOLId2p1oi8bMi
         +mY+eotc5MxUg==
Date:   Sat, 30 Sep 2023 15:44:34 +0100
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
Subject: Re: [PATCH v3 09/27] staging: iio: resolver: ad2s1210: use
 devicetree to get CLKIN rate
Message-ID: <20230930154434.6a2b1cfa@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-9-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-9-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:14 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This removes the fclkin sysfs attribute and replaces it with getting
> the CLKIN clock rate using the clk subsystem (i.e. from the devicetree).
> 
> CLKIN comes from an external oscillator that is connected directly to
> the AD2S1210 chip, so users of the sysfs attributes should not need to
> be concerned with this.
> 
> The fclkin field (the datasheet name) is renamed to clkin_hz to be more
> obvious that it is a frequency in Hz.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM

Applied

J
> ---
> 
> v3 changes:
> * Don't sort imports in this patch.
> * Renamed fexcit to clkin_hz.
> * Fixed ad2s1210_setup_clocks() being called in an earlier patch.
> 
>  drivers/staging/iio/resolver/Kconfig    |  1 +
>  drivers/staging/iio/resolver/ad2s1210.c | 81 ++++++++++++---------------------
>  2 files changed, 30 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
> index 6d1e2622e0b0..bebb35822c9e 100644
> --- a/drivers/staging/iio/resolver/Kconfig
> +++ b/drivers/staging/iio/resolver/Kconfig
> @@ -7,6 +7,7 @@ menu "Resolver to digital converters"
>  config AD2S1210
>  	tristate "Analog Devices ad2s1210 driver"
>  	depends on SPI
> +	depends on COMMON_CLK
>  	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say yes here to build support for Analog Devices spi resolver
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index a710598a64f0..c8723b6f3a3b 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -3,7 +3,9 @@
>   * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
>   *
>   * Copyright (c) 2010-2010 Analog Devices Inc.
> + * Copyright (c) 2023 BayLibre, SAS
>   */
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
> @@ -90,7 +92,8 @@ struct ad2s1210_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;
>  	struct gpio_desc *gpios[5];
> -	unsigned int fclkin;
> +	/** The external oscillator frequency in Hz. */
> +	unsigned long clkin_hz;
>  	unsigned int fexcit;
>  	bool hysteresis;
>  	u8 resolution;
> @@ -165,7 +168,7 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
>  	int ret;
>  	unsigned char fcw;
>  
> -	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
> +	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->clkin_hz);
>  	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
>  		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
>  		return -ERANGE;
> @@ -201,45 +204,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
>  	return ad2s1210_config_write(st, 0x0);
>  }
>  
> -static ssize_t ad2s1210_show_fclkin(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -
> -	return sprintf(buf, "%u\n", st->fclkin);
> -}
> -
> -static ssize_t ad2s1210_store_fclkin(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t len)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned int fclkin;
> -	int ret;
> -
> -	ret = kstrtouint(buf, 10, &fclkin);
> -	if (ret)
> -		return ret;
> -	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
> -		dev_err(dev, "ad2s1210: fclkin out of range\n");
> -		return -EINVAL;
> -	}
> -
> -	mutex_lock(&st->lock);
> -	st->fclkin = fclkin;
> -
> -	ret = ad2s1210_update_frequency_control_word(st);
> -	if (ret < 0)
> -		goto error_ret;
> -	ret = ad2s1210_soft_reset(st);
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret < 0 ? ret : len;
> -}
> -
>  static ssize_t ad2s1210_show_fexcit(struct device *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
> @@ -537,7 +501,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  			*val2 = 95874;
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_ANGL_VEL:
> -			*val = st->fclkin;
> +			*val = st->clkin_hz;
>  			*val2 = ad2s1210_velocity_scale[st->resolution];
>  			return IIO_VAL_FRACTIONAL;
>  		default:
> @@ -549,8 +513,6 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static IIO_DEVICE_ATTR(fclkin, 0644,
> -		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
>  static IIO_DEVICE_ATTR(fexcit, 0644,
>  		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
>  static IIO_DEVICE_ATTR(control, 0644,
> @@ -599,7 +561,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  };
>  
>  static struct attribute *ad2s1210_attributes[] = {
> -	&iio_dev_attr_fclkin.dev_attr.attr,
>  	&iio_dev_attr_fexcit.dev_attr.attr,
>  	&iio_dev_attr_control.dev_attr.attr,
>  	&iio_dev_attr_bits.dev_attr.attr,
> @@ -657,6 +618,24 @@ static const struct iio_info ad2s1210_info = {
>  	.attrs = &ad2s1210_attribute_group,
>  };
>  
> +static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
> +{
> +	struct device *dev = &st->sdev->dev;
> +	struct clk *clk;
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +
> +	st->clkin_hz = clk_get_rate(clk);
> +	if (st->clkin_hz < AD2S1210_MIN_CLKIN || st->clkin_hz > AD2S1210_MAX_CLKIN)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "clock frequency out of range: %lu\n",
> +				     st->clkin_hz);
> +
> +	return 0;
> +}
> +
>  static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  {
>  	struct spi_device *spi = st->sdev;
> @@ -695,6 +674,10 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	st->resolution = 12;
>  	st->fexcit = AD2S1210_DEF_EXCIT;
>  
> +	ret = ad2s1210_setup_clocks(st);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = ad2s1210_setup_gpios(st);
>  	if (ret < 0)
>  		return ret;
> @@ -709,13 +692,7 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	ret = devm_iio_device_register(&spi->dev, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	st->fclkin = spi->max_speed_hz;
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id ad2s1210_of_match[] = {
> 

