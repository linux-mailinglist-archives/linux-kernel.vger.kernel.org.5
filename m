Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE17B40B2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjI3OFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3OFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:05:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BF3B3;
        Sat, 30 Sep 2023 07:05:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8588DC433C7;
        Sat, 30 Sep 2023 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696082735;
        bh=jlIYetThseKxhkaFFI5z59gfr53ycTDHTMga/zoUD+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kKNtNIXXqM+cktPIWig3JMXnh/o+5ZEaScFZPw7qcO0G3oqg9GHgKHMVwP9KK3D05
         UmPmiaL8aKfgBOiE2sfS+9sc6iUFbf4U5WqoSZcP+abYjlfyfgTFLtJw10kIMZMCP/
         mq6eN+JEQ7wyLIryxBsA60vMWn8lOFG8BKxHzqpFRUXklJfoLrjMgQ2HmYKQPmmaZe
         92jxP9DYg9h/xqeWT9pEYXw2/bCYPYOTWwY4LLZG/IuRGhRT9fHaitlgWWA9I1Q7H3
         zPsBf7lV5r06K8iYIp99PQEfHOh9j5r8IMEROtBsZfr4hZEXF9fBnO7IfJg7xp0ETv
         bqCpuheV/iWxQ==
Date:   Sat, 30 Sep 2023 15:05:31 +0100
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
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20230930150531.083c51d4@jic23-huawei>
In-Reply-To: <20230928125443.615006-2-mitrutzceclan@gmail.com>
References: <20230928125443.615006-1-mitrutzceclan@gmail.com>
        <20230928125443.615006-2-mitrutzceclan@gmail.com>
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

On Thu, 28 Sep 2023 15:54:43 +0300
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
Hi Dumitru,

A few more things came up on a fresh look. All small stuff so fingers
crossed for v3.

Jonathan


> ---
>  drivers/iio/adc/Kconfig  |  13 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7173.c | 850 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 864 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7173.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 517b3db114b8..fe14a8b24e41 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -54,6 +54,19 @@ config AD7124
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7124.
>  
> +config AD7173
> +	tristate "Analog Devices AD7173 driver"
> +	depends on SPI_MASTER
> +	select AD_SIGMA_DELTA
> +	select GPIO_REGMAP
If you are selecting it, why does it have if guards in the driver.
I prefer the select here, so drop this if guards.

> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD7173 and similar ADC
> +	  (currently supported: AD7172-2, AD7173-8, AD7175-2, AD7176-2).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7173.
> +
>  config AD7192
>  	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
>  	depends on SPI

...

> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> new file mode 100644
> index 000000000000..648bcec836a5
> --- /dev/null
> +++ b/drivers/iio/adc/ad7173.c
> @@ -0,0 +1,850 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
> + * Copyright (C) 2023 Analog Devices, Inc.

As you list Lars as an author and he's not be at ADI for 'a while'
I'm guessing this should probably include a date range going back
a few years.  Always good to reflect that history even if it's
been out of tree.

> + */
> +
> +#include <linux/bitfield.h>
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
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

sysfs.h is only needed if you are defining IIO attrs without
doing it via the IIO core channel descriptions. I don't see you doing
that so shouldn't be needed.

> +#include <linux/iio/trigger.h>
Whilst the driver provides a trigger, it's via the ad_sigma_delta
library so I don't think this driver needs to include trigger.h
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +
> +#define AD7173_REG_COMMS		0x00
> +#define AD7173_REG_ADC_MODE		0x01
> +#define AD7173_REG_INTERFACE_MODE	0x02
> +#define AD7173_REG_CRC			0x03
> +#define AD7173_REG_DATA			0x04
> +#define AD7173_REG_GPIO			0x06
> +#define AD7173_REG_ID			0x07
> +#define AD7173_REG_CH(x)		(0x10 + (x))
> +#define AD7173_REG_SETUP(x)		(0x20 + (x))
> +#define AD7173_REG_FILTER(x)		(0x28 + (x))
> +#define AD7173_REG_OFFSET(x)		(0x30 + (x))
> +#define AD7173_REG_GAIN(x)		(0x38 + (x))
> +
> +#define AD7173_RESET_LENGTH		BITS_TO_BYTES(64)
> +
> +#define AD7173_CH_ENABLE		BIT(15)
> +#define AD7173_CH_SETUP_SEL_MASK	GENMASK(14, 12)
> +#define AD7173_CH_SETUP_SEL(x)		FIELD_PREP(AD7173_CH_SETUP_SEL_MASK, x)
> +#define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
> +#define AD7173_CH_SETUP_AINPOS(x)	FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, x)
> +#define AD7173_CH_SETUP_AINNEG(x)	(x)
> +
> +#define AD7173_CH_ADDRESS(pos, neg) \
> +	(AD7173_CH_SETUP_AINPOS(pos) | AD7173_CH_SETUP_AINNEG(neg))
> +#define AD7173_AIN_TEMP_POS	17
> +#define AD7173_AIN_TEMP_NEG	18
> +
> +#define AD7172_ID			0x00d0
> +#define AD7173_ID			0x30d0
> +#define AD7175_ID			0x0cd0
> +#define AD7176_ID			0x0c90
> +#define AD7173_ID_MASK			GENMASK(15, 4)
> +
> +#define AD7173_ADC_MODE_REF_EN		BIT(15)
> +#define AD7173_ADC_MODE_SING_CYC	BIT(13)
> +#define AD7173_ADC_MODE_MODE_MASK	GENMASK(6, 4)
> +#define AD7173_ADC_MODE_MODE(x)		FIELD_PREP(AD7173_ADC_MODE_MODE_MASK, x)
> +#define AD7173_ADC_MODE_CLOCKSEL_MASK	GENMASK(3, 2)
> +#define AD7173_ADC_MODE_CLOCKSEL(x)	FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK, x)
> +
> +#define AD7173_GPIO_PDSW	BIT(14)
> +#define AD7173_GPIO_OP_EN2_3	BIT(13)
> +#define AD7173_GPIO_MUX_IO	BIT(12)
> +#define AD7173_GPIO_SYNC_EN	BIT(11)
> +#define AD7173_GPIO_ERR_EN	BIT(10)
> +#define AD7173_GPIO_ERR_DAT	BIT(9)
> +#define AD7173_GPIO_GP_DATA3	BIT(7)
> +#define AD7173_GPIO_GP_DATA2	BIT(6)
> +#define AD7173_GPIO_IP_EN1	BIT(5)
> +#define AD7173_GPIO_IP_EN0	BIT(4)
> +#define AD7173_GPIO_OP_EN1	BIT(3)
> +#define AD7173_GPIO_OP_EN0	BIT(2)
> +#define AD7173_GPIO_GP_DATA1	BIT(1)
> +#define AD7173_GPIO_GP_DATA0	BIT(0)
> +
> +#define AD7173_GPO12_DATA(x)	BIT(x)
> +#define AD7173_GPO23_DATA(x)	BIT(x + 4)
> +#define AD7173_GPO_DATA(x)	(x < 2 ? AD7173_GPO12_DATA(x) : AD7173_GPO23_DATA(x))
> +
> +#define AD7173_INTERFACE_DATA_STAT	BIT(6)
> +#define AD7173_INTERFACE_DATA_STAT_EN(x)\
> +	FIELD_PREP(AD7173_INTERFACE_DATA_STAT, x)
> +
> +#define AD7173_SETUP_BIPOLAR		BIT(12)
> +#define AD7173_SETUP_AREF_BUF_MASK	GENMASK(11, 10)
> +#define AD7173_SETUP_AIN_BUF_MASK	GENMASK(9, 8)
> +
> +#define AD7173_SETUP_REF_SEL_MASK	GENMASK(5, 4)
> +#define AD7173_SETUP_REF_SEL(x)		FIELD_PREP(AD7173_SETUP_REF_SEL_MASK, x)
> +#define AD7173_SETUP_REF_SEL_AVDD1_AVSS	0x3
> +#define AD7173_SETUP_REF_SEL_INT_REF	0x2
> +#define AD7173_SETUP_REF_SEL_EXT_REF2	0x1
> +#define AD7173_SETUP_REF_SEL_EXT_REF	0x0
> +
> +#define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
> +#define AD7173_FILTER_ODR0(x)		FIELD_PREP(AD7173_FILTER_ODR0_MASK, x)
> +#define AD7173_FILTER_ODR0(x)		FIELD_PREP(AD7173_FILTER_ODR0_MASK, x)

Firstly why is it duplicated?

Secondly why not just use the FIELD_PREP() inline as it's obvious
what it's doing and the extra macro, if anything makes it less clear.
Same is true for all the similar macros.

> +
> +enum ad7173_ids {
> +	ID_AD7172_2,
> +	ID_AD7173_8,
> +	ID_AD7175_2,
> +	ID_AD7176_2,
> +};
> +
> +struct ad7173_device_info {
> +	unsigned int id;
> +	unsigned int num_inputs;
> +	unsigned int num_configs;
> +	unsigned int num_channels;
> +	unsigned char num_gpios;
> +	bool has_temp;
> +	unsigned int clock;
> +
> +	const unsigned int *sinc5_data_rates;
> +	unsigned int num_sinc5_data_rates;
> +};
> +
> +struct ad7173_channel_config {
> +	bool live;
> +	unsigned char cfg_slot;
> +	/* Following fields are used to compare equality. Bipolar must be first */
> +	bool bipolar;
> +	bool input_buf;
> +	unsigned char odr;
> +};
> +
> +struct ad7173_channel {
> +	unsigned int chan_reg;
> +	struct ad7173_channel_config cfg;
> +	unsigned int ain;
> +};
> +
> +struct ad7173_state {
> +	const struct ad7173_device_info *info;
> +	struct ad_sigma_delta sd;
> +	struct ad7173_channel *channels;
> +	struct regulator *reg;
> +	unsigned int adc_mode;
> +	unsigned int interface_mode;
> +	unsigned int num_channels;
> +	unsigned long cfg_slots_status; /* slots usage status bitmap*/

Whilst you might not need to as it fits in one, DECLARE_BITMAP()
is a good way of making it clear something is a bitmap.

I wondered if you used this a bitmap, and you do.  Though another
question there is why assign_bit() when value is known.
Just use set_bit() or clear_bit() directly


> +	unsigned long long config_usage_counter;
> +	unsigned long long *config_cnts;
> +#if IS_ENABLED(CONFIG_GPIOLIB)
> +	struct regmap *regmap;
> +	struct gpio_regmap *gpio_regmap;
> +#endif
> +};

> +#if IS_ENABLED(CONFIG_GPIOLIB)

Seems odd to have these guards.  I don't think we mind obliging
people to build with GPIOLIB support as very unlikely they won't
have it anyway for other reasons.  Looking at the Kconfig I see
you select this anyway, so just drop the if guards.


> +
> +static const struct regmap_range ad7173_range_gpio[] = {
> +	regmap_reg_range(AD7173_REG_GPIO, AD7173_REG_GPIO),
> +};
> +
> +static const struct regmap_access_table ad7173_access_table = {
> +	.yes_ranges = ad7173_range_gpio,
> +	.n_yes_ranges = ARRAY_SIZE(ad7173_range_gpio),
> +};
> +
> +static const struct regmap_config ad7173_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.rd_table = &ad7173_access_table,
> +	.wr_table = &ad7173_access_table,
> +	.read_flag_mask = BIT(6),
> +};
> +
> +static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
> +			     unsigned int offset, unsigned int *reg,
> +			     unsigned int *mask)
> +{
> +	*mask = AD7173_GPO_DATA(offset);
> +	*reg = AD7173_REG_GPIO;
> +	return 0;
> +}
> +
> +static int ad7173_gpio_init(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct gpio_regmap_config gpio_regmap = {};
> +	struct device *dev = &st->sd.spi->dev;
> +	unsigned int mask;
> +
> +	st->regmap = devm_regmap_init_spi(st->sd.spi, &ad7173_regmap_config);

If the regmap config is only used for the gpio parts, good to name
it to make that clear.


> +	if (IS_ERR(st->regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Unable to init regmap\n");
> +	}
> +
> +	mask = AD7173_GPIO_OP_EN0 | AD7173_GPIO_OP_EN1 | AD7173_GPIO_OP_EN2_3;
> +	regmap_update_bits(st->regmap, AD7173_REG_GPIO, mask, mask);
> +
> +	gpio_regmap.parent = dev;
> +	gpio_regmap.regmap = st->regmap;
> +	gpio_regmap.ngpio = st->info->num_gpios;
> +	gpio_regmap.reg_set_base = GPIO_REGMAP_ADDR_ZERO;
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
> +
> +static struct ad7173_state *ad_sigma_delta_to_ad7173(struct ad_sigma_delta *sd)
> +{
> +	return container_of(sd, struct ad7173_state, sd);

At least one more place you can use this... ( I deleted it whilst reviewing but
remembered the pattern). It's in ad7173_append_status()

> +}
> +
> +static void ad7173_reset_usage_cnts(struct ad7173_state *st)
> +{
> +	memset64(st->config_cnts, 0, st->info->num_configs);
> +	st->config_usage_counter = 0;
> +}
> +
> +static struct ad7173_channel_config *ad7173_find_live_config
> +	(struct ad7173_state *st, struct ad7173_channel_config *cfg)
> +{
> +	struct ad7173_channel_config *cfg_aux;
> +	ptrdiff_t cmp_size, offset;
> +	int i;
> +
> +	offset = offsetof(struct ad7173_channel_config, cfg_slot) +
> +		 sizeof(cfg->cfg_slot);
> +	cmp_size = sizeof(*cfg) - offset;
> +
> +	for (i = 0; i < st->num_channels; i++) {
> +		cfg_aux = &st->channels[i].cfg;
> +
> +		if (cfg_aux->live && !memcmp(&cfg->bipolar, &cfg_aux->bipolar,
> +					     cmp_size))
> +			return cfg_aux;
> +	}
> +	return NULL;
> +}

> +
> +static int ad7173_set_mode(struct ad_sigma_delta *sd,
> +			   enum ad_sigma_delta_mode mode)
> +{
> +	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
> +
> +	st->adc_mode &= ~AD7173_ADC_MODE_MODE_MASK;
> +	st->adc_mode |= AD7173_ADC_MODE_MODE(mode);
Another one I'd find easier to read if it were just
FIELD_PREP(AD71...)
as then it would be obvious we masked the field out then replaced it.
It's fairly obvious anyway, but the macro doesn't make it more than
just calling FIELD_PREP directly.

> +
> +	return ad_sd_write_reg(&st->sd, AD7173_REG_ADC_MODE, 2, st->adc_mode);
> +}


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
> +				*val = (chan->scan_type.realbits < 32) ?
> +					-(1 << (chan->scan_type.realbits - 1)) :
> +					INT_MIN;

when is realbits >= 32?  I'm not seeing such a case, so perhaps a comment here
if there is one.


> +			else
> +				*val = 0;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		reg = st->channels[chan->address].cfg.odr;
> +
> +		*val = st->info->sinc5_data_rates[reg] / MILLI;
> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * MILLI;
* MICRO/MILLI 

probably better expresses what is going on here as first bit ends up in
milli and you want it in micro.  Maths the same though - just a slight
boost in readability I think.

> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int ad7173_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel_config *cfg;
> +	unsigned int freq, i, reg;
> +	int ret = 0;
> +
> +	iio_device_claim_direct_mode(indio_dev);
> +	if (iio_buffer_enabled(indio_dev)) {
Take a closer look at what iio_device_claim_direct_mode does and
check it's return value.   For reference if the buffer is enabled
this is a double unlock of the mutex and a nice big error splat.

> +		iio_device_release_direct_mode(indio_dev);
> +		return -EBUSY;
> +	}
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		freq = val * MILLI + val2 / MILLI;
> +
> +		for (i = 0; i < st->info->num_sinc5_data_rates - 1; i++) {
> +			if (freq >= st->info->sinc5_data_rates[i])
> +				break;
> +		}
> +
> +		cfg = &st->channels[chan->address].cfg;
> +		cfg->odr = i;
> +
> +		if (cfg->live) {
> +			ret = ad_sd_read_reg(&st->sd, AD7173_REG_FILTER(cfg->cfg_slot), 2, &reg);
> +			if (ret)
> +				break;
> +			reg &= ~AD7173_FILTER_ODR0_MASK;
> +			reg |= AD7173_FILTER_ODR0(i);
As mentioned above, I think this is less clear than
			reg &= ~AD7173_FILTER_ODR0_MASK;
			reg |= FIELD_PREP(AD7173_FILTER_ODR0_MASK, i);

as you can then see it's all about the same file specified as a mask.

> +			ret = ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(cfg->cfg_slot), 2, reg);

Line is very long. If you can keep closer to 80 chars and below that's alway
preferred.  Maybe flip the logic to exit early if nothing to do..

		if(!cfg->live) /* Nothing to do yet */
			break; 

		ret = ...


> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}


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
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
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
> +		return ad7173_gpio_init(indio_dev);

As nothing to do with IIO part of driver, I'd just pass in st instead
so there is no implication that this is IIO related.

> +	else
Either drop the else (one of the bots will moan about this otherwise)
or I'd go for as style more consistent with earlier code.
	if (IS_ENABLED(COHNFIG_GPIOLIB)) {
		ret = ad7173_gpio_init(st); 
		if (ret)
			return ret;
	}
	
	return 0;

	}
> +		return 0;
> +}
> +
> +static const struct of_device_id ad7173_of_match[] = {
> +	{ .compatible = "adi,ad7172-2",
> +	  .data = &ad7173_device_info[ID_AD7172_2], },
> +	{ .compatible = "adi,ad7173-8",
> +	  .data = &ad7173_device_info[ID_AD7173_8], },
> +	{ .compatible = "adi,ad7175-2",
> +	  .data = &ad7173_device_info[ID_AD7175_2], },
> +	{ .compatible = "adi,ad7176-2",
> +	  .data = &ad7173_device_info[ID_AD7176_2], },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ad7173_of_match);
> +
> +static const struct spi_device_id ad7173_id_table[] = {
> +	{ "ad7172-2", &ad7173_device_info[ID_AD7172_2], },
> +	{ "ad7173-8", &ad7173_device_info[ID_AD7173_8], },
> +	{ "ad7175-2", &ad7173_device_info[ID_AD7175_2], },
> +	{ "ad7176-2", &ad7173_device_info[ID_AD7176_2], },
Cast to kernel_ulong_t as per the build bot warning you got.

> +	{ },
trivial, but little point in a comma after an element acting as
a list terminator.

> +};


