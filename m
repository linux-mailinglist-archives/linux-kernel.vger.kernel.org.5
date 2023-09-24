Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E97ACB1E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjIXRoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:44:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED1FA;
        Sun, 24 Sep 2023 10:44:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55C6C433C7;
        Sun, 24 Sep 2023 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695577441;
        bh=8H+PkF7KD25MSP7tTAzYlYBGEtMb3KxwOnralLbv0JM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=arDrOUwG1Ger2aTdse+W2vYUe9Yyvr+Hh5FCdWkNKtr3yBwBw68MVrA9/3F5a4btn
         eBC8lyixRgXKVuXQ57vgoG25/oWaovwdfKqpV8XndblmG5Au4FO1Pol71mq0nW3MUM
         4whTgepPNmvJEmX1Ygtu3RVjR5PL+1p2x3Pp2Y5p8HQVM8RfVBLFvOVA2r+OgATF5W
         L1rW6OM83tNjkGdpxRrdgqQ9CvBlK4J9xkJjku2xiEXhmUGfu5OK/rrqnvVy4qmRYo
         +hmV2IGWg9QcpEwO/ViaU3/U5Zxb/aSxazLp/WJP6JjcXqaGsD0A9MDgVon7QQdjUX
         REcfxGuaK6+GA==
Date:   Sun, 24 Sep 2023 18:43:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH v2 08/19] staging: iio: resolver: ad2s1210: use
 devicetree to get fclkin
Message-ID: <20230924184353.3f4aee27@jic23-huawei>
In-Reply-To: <20230921144400.62380-9-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-9-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:49 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This removes the fclkin sysfs attribute and replaces it with getting
> the fclkin clock rate using the clk subsystem (i.e. from the
> devicetree).
> 
> The fclkin clock comes from an external oscillator that is connected
> directly to the AD2S1210 chip, so users of the sysfs attributes should
> not need to be concerned with this.
> 
> Also sort includes while we are touching this.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/staging/iio/resolver/Kconfig    |  1 +
>  drivers/staging/iio/resolver/ad2s1210.c | 76 +++++++++----------------
>  2 files changed, 28 insertions(+), 49 deletions(-)
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
> index 95d43b241a75..153ac7704ad7 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -5,16 +5,17 @@
>   * Copyright (c) 2010-2010 Analog Devices Inc.
>   * Copyright (C) 2023 BayLibre, SAS
>   */
> -#include <linux/types.h>
> -#include <linux/mutex.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
> -#include <linux/spi/spi.h>
>  #include <linux/slab.h>
> +#include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
> -#include <linux/delay.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/module.h>
> +#include <linux/types.h>

No objection to cleaning up the includes, but not in same patch that does
anything more significant.

>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -91,7 +92,8 @@ struct ad2s1210_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;
>  	struct gpio_desc *gpios[5];
> -	unsigned int fclkin;
> +	/** The external oscillator frequency in Hz. */
> +	unsigned long fclkin;
rename it so we know the units. fclkin_hz

However, I'd stash the clk instead and then get the frequency where it's needed.
Also avoids need for a wrapper function as can just call 
devm_get_clk_enabled() in probe()

Obviously give that clk a meaningful name though.

>  	unsigned int fexcit;
>  	bool hysteresis;
>  	u8 resolution;
> @@ -198,45 +200,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
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
> @@ -546,8 +509,6 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static IIO_DEVICE_ATTR(fclkin, 0644,
> -		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
>  static IIO_DEVICE_ATTR(fexcit, 0644,
>  		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
>  static IIO_DEVICE_ATTR(control, 0644,
> @@ -596,7 +557,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  };
>  
>  static struct attribute *ad2s1210_attributes[] = {
> -	&iio_dev_attr_fclkin.dev_attr.attr,
>  	&iio_dev_attr_fexcit.dev_attr.attr,
>  	&iio_dev_attr_control.dev_attr.attr,
>  	&iio_dev_attr_bits.dev_attr.attr,
> @@ -654,6 +614,24 @@ static const struct iio_info ad2s1210_info = {
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
> +	st->fclkin = clk_get_rate(clk);
> +	if (st->fclkin < AD2S1210_MIN_CLKIN || st->fclkin > AD2S1210_MAX_CLKIN)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "clock frequency out of range: %lu\n",
> +				     st->fclkin);
> +
> +	return 0;
> +}
> +
>  static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  {
>  	struct spi_device *spi = st->sdev;

