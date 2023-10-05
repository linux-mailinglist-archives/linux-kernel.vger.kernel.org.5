Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1045A7BA766
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjJERNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjJERMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:12:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2901BC;
        Thu,  5 Oct 2023 10:01:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3ECC433C8;
        Thu,  5 Oct 2023 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696525291;
        bh=/yWYHiHjPRMphg2rFhP1rzHAhfL881K0RkUaaFEJJpw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WhAcT0gKqgdGjvVMqP1HqFuLUxHmpeR75lFrzRBzryHeMQYDte5RKo9Zr8y2om/An
         NUQDOGHaWkEnBmQI0dQ9RPyUN0aP47zpCP2nCJQN+Hp8T9cBxbpQdX1ISWe+pfJOXZ
         INcKTELK+yrzWLNavITSOGhjI5LmnzIETTpEoReV5TogipYwCK5O+TV2LhWHCQGQ+d
         /pNwR+NP8oDQK9PJGoq/gOvs9gWYAVLcKusHBKdOgqE2flh1jMJ6r73AB8qMErKB6N
         JxA0jUVuSO364yLcUryTNsgVF0Eb14OwZC8yGF10wJsWOye1uUsolXDKrq/WhhPrQC
         51bZ3us5UVWAA==
Date:   Thu, 5 Oct 2023 18:01:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231005180131.0518f46c@jic23-huawei>
In-Reply-To: <20231005105921.460657-2-mitrutzceclan@gmail.com>
References: <20231005105921.460657-1-mitrutzceclan@gmail.com>
        <20231005105921.460657-2-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Oct 2023 13:59:22 +0300
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

Hi Dumitru,

Getting close, but a few more comments on things I noticed this time
around.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> new file mode 100644
> index 000000000000..5f9ab6023b09
> --- /dev/null
> +++ b/drivers/iio/adc/ad7173.c
> @@ -0,0 +1,843 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
> + * Copyright (C) 2015-2023 Analog Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Needed?  It's pretty rare that it is these days as the IIO core handles
most attrs.

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include <linux/iio/adc/ad_sigma_delta.h>


...

> +
> +struct ad7173_state {
> +	const struct ad7173_device_info *info;
> +	struct ad_sigma_delta sd;
> +	struct ad7173_channel *channels;
> +	struct regulator *reg;

Here but not used.. (it should be!)

> +	unsigned int adc_mode;
> +	unsigned int interface_mode;
> +	unsigned int num_channels;
> +	DECLARE_BITMAP(cfg_slots_status, AD7173_MAX_CONFIGS); /* slots usage status */
> +	unsigned long long config_usage_counter;
> +	unsigned long long *config_cnts;
> +#if IS_ENABLED(CONFIG_GPIOLIB)
> +	struct regmap *reg_gpiocon_regmap;
> +	struct gpio_regmap *gpio_regmap;
> +#endif
> +};

> +#if IS_ENABLED(CONFIG_GPIOLIB)

...

> +
> +static int ad7173_gpio_init(struct ad7173_state *st)
> +{
> +	struct gpio_regmap_config gpio_regmap = {};
> +	struct device *dev = &st->sd.spi->dev;
> +	unsigned int mask;
> +
> +	st->reg_gpiocon_regmap = devm_regmap_init_spi(st->sd.spi, &ad7173_regmap_config);
> +	if (IS_ERR(st->reg_gpiocon_regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(st->reg_gpiocon_regmap),
> +				     "Unable to init regmap\n");
> +	}
> +
> +	mask = AD7173_GPIO_OP_EN0 | AD7173_GPIO_OP_EN1 | AD7173_GPIO_OP_EN2_3;
> +	regmap_update_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, mask, mask);

Does this get 'undone' anywhere? I'd imagine there is power cost to setting these
bits that we want to stop in remove.
Perhaps a devm_add_action_or_reset() needed here.

> +
> +	gpio_regmap.parent = dev;
> +	gpio_regmap.regmap = st->reg_gpiocon_regmap;
> +	gpio_regmap.ngpio = st->info->num_gpios;
> +	gpio_regmap.reg_set_base = AD7173_REG_GPIO;
> +	gpio_regmap.reg_mask_xlate = ad7173_mask_xlate;
> +
> +	st->gpio_regmap = devm_gpio_regmap_register(dev, &gpio_regmap);
> +	if (IS_ERR(st->gpio_regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_regmap),
> +				     "Unable to init gpio-regmap\n");
> +	}
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_GPIOLIB */

...


> +static int ad7173_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad_sigma_delta_single_conversion(indio_dev, chan, val);

It's fairly usual for it to be safe to grab a single conversion when the
buffered mode might be enabled.  Do you need an iio_device_claim_direct_mode()
here?

> +		if (ret < 0)
> +			return ret;
> +
> +		/* disable channel after single conversion */
> +		ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(chan->address), 2, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 250000000;
> +			*val2 = 800273203; /* (2^24 * 477) / 10 */
> +			return IIO_VAL_FRACTIONAL;
> +		} else {
> +			*val = 2500;
> +			if (chan->differential)
> +				*val2 = 23;
> +			else
> +				*val2 = 24;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type == IIO_TEMP) {
> +			*val = -874379;
> +		} else {
> +			if (chan->differential)
> +				/* (1<<31) is UB for a 32bit channel*/
> +				*val = (chan->scan_type.realbits == 32) ?
> +					-(1 << (chan->scan_type.realbits - 1)) :
> +					INT_MIN;
> +			else
> +				*val = 0;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		reg = st->channels[chan->address].cfg.odr;
> +
> +		*val = st->info->sinc5_data_rates[reg] / (MICRO/MILLI);
> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO/MILLI);
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
> +}
> +

> +
> +static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	int i, ret = 0;
> +
> +	iio_device_claim_direct_mode(indio_dev);

This looks wrong.
Firstly iio_device_claim_direct_mode() can fail so you always have
to check the return value. If it does fail and you then call
iio_release_direct_mode() it is unbalanced release of a mutex.

Secondly update_scan_mode is only called as part of buffer setup
and there should be no races around that (and the mutex this
tries to grab is already held.
https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-buffer.c#L1265
)

If you are protecting something device specific (rather than
the mode) then a device specific lock should be taken.


> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		if (test_bit(i, scan_mask))
> +			ret = ad7173_set_channel(&st->sd, i);
> +		else
> +			ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(i), 2, 0);
> +
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +out:
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}

> +
> +static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *channels_st_priv;
> +	struct fwnode_handle *child;
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *chan;
> +	unsigned int num_channels;
> +	unsigned int ain[2], chan_index = 0;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +
> +	if (st->info->has_temp)
> +		num_channels++;
> +
> +	if (num_channels == 0)
> +		return 0;
> +	st->num_channels = num_channels;
> +
> +	chan = devm_kcalloc(dev, sizeof(*chan), num_channels,
> +			    GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	channels_st_priv = devm_kcalloc(dev, num_channels,
> +					sizeof(*channels_st_priv), GFP_KERNEL);
> +	if (!channels_st_priv)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +	indio_dev->num_channels = num_channels;
> +	st->channels = channels_st_priv;
> +
> +	if (st->info->has_temp) {
> +		chan[chan_index] = ad7173_temp_iio_channel_template;
> +		channels_st_priv[chan_index].ain =
> +			AD7173_CH_ADDRESS(chan[chan_index].channel, chan[chan_index].channel2);
> +		channels_st_priv[chan_index].cfg.bipolar = false;
> +		channels_st_priv[chan_index].cfg.input_buf = true;
> +		chan_index++;
> +	}
> +
> +	device_for_each_child_node(dev, child) {
> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     ain, ARRAY_SIZE(ain));
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		if (ain[0] >= st->info->num_inputs ||
> +		    ain[1] >= st->info->num_inputs) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +				"Input pin number out of range for pair (%d %d).", ain[0], ain[1]);
> +		}
> +
> +		chan[chan_index] = ad7173_channel_template;
> +		chan[chan_index].address = chan_index;
> +		chan[chan_index].scan_index = chan_index;
> +		chan[chan_index].channel = ain[0];
> +		chan[chan_index].channel2 = ain[1];
> +
> +		channels_st_priv[chan_index].ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
> +		channels_st_priv[chan_index].chan_reg = chan_index;
> +		channels_st_priv[chan_index].cfg.input_buf = true;
> +		channels_st_priv[chan_index].cfg.odr = 0;
> +
> +		chan[chan_index].differential = fwnode_property_read_bool(child, "bipolar");

bipolar doesn't normally == differential. 
You can have unipolar differential (just that you can't get a negative answer)
Perhaps just a terminology thing?

> +		if (chan[chan_index].differential) {
> +			chan[chan_index].info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
> +			channels_st_priv[chan_index].cfg.bipolar = true;
> +		}
> +
> +		chan_index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7173_probe(struct spi_device *spi)
> +{
> +	struct ad7173_state *st;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->info = device_get_match_data(dev);
> +	if (!st->info)
> +		return -ENODEV;
This works for the cases of DT and ACPI but not for anyone just
using the spi_device_id table. 
There is spi_device_get_match_data() to cover all options.

> +
> +	indio_dev->name = spi_get_device_id(spi)->name;

I'd avoid mixing and matching across different access methods for
firmware type info.  Just embed the name in the st->info structure.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad7173_info;
> +
> +	spi->mode = SPI_MODE_3;
> +
> +	ad7173_sigma_delta_info.num_slots = st->info->num_configs;
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
> +	if (ret)
> +		return ret;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	ret = ad7173_fw_parse_channel_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7173_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (IS_ENABLED(CONFIG_GPIOLIB))
> +		return ad7173_gpio_init(st);
> +
> +	return 0;
> +}

