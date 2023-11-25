Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC707F8C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjKYQlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:41:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9343FB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:41:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCCEC433CB;
        Sat, 25 Nov 2023 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700930501;
        bh=8kWUnZjbm7K9No0nEtzhH2uxGfoeUsvF3kQYCuYFmfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j7wLdSlMkpDwJhUWP62XwB52Nijss1jGRl8dt4mqCH0kIByDgjCORVoFkGeZe0j/0
         pUF1V9+iI7CsGfiaZAfzNn0pqu1br9Ns/MQA/+187qRhkUBEhIf1l0xE70QM2IW+lT
         3yzwP08eC7qrumYxt3ZOH5EFTZHtKPXw7pJ3R26DOllewg4ZknRsS8klWAjMLu9WpL
         OGyPc7/9IIhxfsXtJD7QxU0GNRX82dg4SdsMIOpBQfXdCxEzlWuJoezHlV+MHObXlX
         ff+bEfYE+/bWq4urrnys7O1uadvMI8Qxx8mA9OEP/FhmM0UGEkHykHV2AEqtEDDF3V
         fRWi9v60jFqWg==
Date:   Sat, 25 Nov 2023 16:41:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] iio: adc: Add support for AD7091R-8
Message-ID: <20231125164131.564b79e7@jic23-huawei>
In-Reply-To: <3513e59ec45663d6ac330adf4523d56335a70801.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
        <3513e59ec45663d6ac330adf4523d56335a70801.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 13:42:45 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for Analog Devices AD7091R-2, AD7091R-4, and AD7091R-8
> low power 12-Bit SAR ADCs.
> Extend ad7091r-base driver so it can be used by AD7091R-8 drivers.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

Mostly looks fine, but I'd rather see all the chip specific information
dragged into one place rather than indexing using a type enum.
That includes code that does different things based on that enum value.

Doing so will provide a cleaner interface between the different modules.
The enum thing has gone wrong far too many times as drivers become
more complex.

Jonathan

> ---
>  MAINTAINERS                    |   1 +
>  drivers/iio/adc/Kconfig        |  16 ++
>  drivers/iio/adc/Makefile       |   4 +-
>  drivers/iio/adc/ad7091r-base.c |  24 ++-
>  drivers/iio/adc/ad7091r-base.h |  15 ++
>  drivers/iio/adc/ad7091r5.c     |   2 +
>  drivers/iio/adc/ad7091r8.c     | 270 +++++++++++++++++++++++++++++++++
>  7 files changed, 324 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/iio/adc/ad7091r8.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e7c6c866396..54eff6f0c358 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1136,6 +1136,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
>  F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
>  F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
>  F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r8.c
>  
>  ANALOG DEVICES INC AD7192 DRIVER
>  M:	Alexandru Tachici <alexandru.tachici@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1e2b7a2c67c6..284d898790a2 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -36,13 +36,29 @@ config AD4130
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4130.
>  
> +config AD7091R
> +	tristate

It's fairly trivial but ideal patch split would have had the build changes for
a core module and users of it done in an initial patch and only new stuff in the
patch adding a driver.

...

> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index c752cd2283e6..dbc60ea1bafc 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
> @@ -16,7 +17,8 @@
>  #include "ad7091r-base.h"
>  
>  /* AD7091R_REG_RESULT */
> -#define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
> +#define AD7091R5_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
> +#define AD7091R8_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x7)
Hmm. Generally I'd not expect to see registers that only apply on a
particular device in a generic library.

Normal trick for this is a define or callback as appropriate.

>  #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
>  
>  /* AD7091R_REG_CONF */
> @@ -66,10 +68,13 @@ static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
>  		return -EINVAL;
>  	}
>  
> -	ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> -				 AD7091R_REG_CONF_MODE_MASK, conf);
> -	if (ret)
> -		return ret;
> +	/* AD7091R-2/4/8 don't set normal, command, autocycle modes in conf reg */
> +	if (st->chip_info->type == AD7091R5) {
A type in a chip_info structure often means we are exposing as code something that
should really be data.

> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +					 AD7091R_REG_CONF_MODE_MASK, conf);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	st->mode = mode;
>  
> @@ -109,8 +114,13 @@ static int ad7091r_read_one(struct iio_dev *iio_dev,
>  	if (ret)
>  		return ret;
>  
> -	if (AD7091R_REG_RESULT_CH_ID(val) != channel)
> -		return -EIO;
> +	if (st->chip_info->type == AD7091R5) {

Here as well. I'd like to see this done either with data or a callback in the
chip_info structure.

> +		if (AD7091R5_REG_RESULT_CH_ID(val) != channel)
> +			return -EIO;
> +	} else {
> +		if (AD7091R8_REG_RESULT_CH_ID(val) != channel)
> +			return -EIO;
> +	}
>  
>  	*read_val = AD7091R_REG_RESULT_CONV_RESULT(val);
>  
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 6997ea11998b..a42ea79a2893 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -29,6 +29,8 @@

...

> +enum ad7091r_device_type {
> +	AD7091R2,
> +	AD7091R4,
> +	AD7091R5,
> +	AD7091R8,
>  };
>  
>  struct ad7091r_chip_info {
> +	const char *name;
> +	enum ad7091r_device_type type;

This is almost always a design mistake. If we can possibly abstract
the differences into either some data, or some callbacks (from the appropriate
child module) that is much preferred to having a type enum and doing that
in code.

I think it is fairly easy to do, but we need a wrapper structure around irq
and non irq versions of this structure.  Probably move the name and add
a regmap_config to that wrapper structure.

>  	unsigned int num_channels;
>  	const struct iio_chan_spec *channels;
>  	unsigned int vref_mV;

...

> diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
> new file mode 100644
> index 000000000000..f062240873c6
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r8.c
> @@ -0,0 +1,270 @@
...


> +static const struct regmap_config ad7091r_spi_regmap_config[] = {

As mentioned below, I'd like to see this in the info structure rather
than a separate array that needs to be indexed.

> +	[AD7091R2] = {
> +		.reg_bits = 5,
> +		.pad_bits = 3,
> +		.val_bits = 16,
> +		.volatile_reg = ad7091r_volatile_reg,
> +		.writeable_reg = ad7091r_writeable_reg,
> +		.max_register = AD7091R_REG_CH_HYSTERESIS(2),
> +	},
> +	[AD7091R4] = {
> +		.reg_bits = 5,
> +		.pad_bits = 3,
> +		.val_bits = 16,
> +		.volatile_reg = ad7091r_volatile_reg,
> +		.writeable_reg = ad7091r_writeable_reg,
> +		.max_register = AD7091R_REG_CH_HYSTERESIS(4),
> +	},
> +	[AD7091R8] = {
> +		.reg_bits = 5,
> +		.pad_bits = 3,
> +		.write_flag_mask = BIT(2),
> +		.val_bits = 16,
> +		.volatile_reg = ad7091r_volatile_reg,
> +		.writeable_reg = ad7091r_writeable_reg,
> +		.max_register = AD7091R_REG_CH_HYSTERESIS(8),
> +	},
> +};
> +
> +static int ad7091r_regmap_bus_reg_read(void *context, unsigned int reg,
> +				       unsigned int *val)
> +{
> +	struct ad7091r_state *st = context;
> +	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
> +	const struct regmap_config *conf = &ad7091r_spi_regmap_config[st->chip_info->type];
> +	int ret;
> +
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->tx_buf,
> +			.len = 2,
> +			.cs_change = 1,
> +		}, {
> +			.rx_buf = &st->rx_buf,
> +			.len = 2,
> +		}
> +	};
> +
> +	if (reg == AD7091R_REG_RESULT)
> +		ad7091r_pulse_convst(st);
> +
> +	reg <<= conf->pad_bits;
> +	st->tx_buf = cpu_to_be16(reg << 8);

That's a bit unusual as a way to write the first of two bytes.
Perhaps the data type of tx_buf is inappropriate here and it should
just be u8 x[2]?  I guess maybe it's easier to just keep it this way
given the very different tx_buf format for writes.

> +
> +	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = be16_to_cpu(st->rx_buf);
> +	return 0;
> +}

> +
> +static int ad7091r8_spi_probe(struct spi_device *spi)
> +{
> +	const struct ad7091r_chip_info *chip_info;
> +	struct ad7091r_state *st;
> +	struct iio_dev *iio_dev;
> +	struct regmap *map;
> +	int ret;
> +
> +	chip_info = spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -EINVAL;
> +
> +	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(iio_dev);
> +	st->dev = &spi->dev;
> +
> +	map = devm_regmap_init(&spi->dev, &ad7091r8_regmap_bus, st,
> +			       &ad7091r_spi_regmap_config[chip_info->type]);
regmap config should be accessed via a pointer in the chip_info structure
not a separate array.

> +
Trivial : No blank line generally between function call an it's error handler.

> +	if (IS_ERR(map))
> +		return dev_err_probe(&spi->dev, PTR_ERR(map),
> +				     "Error initializing spi regmap\n");
> +
> +	ret = ad7091r8_gpio_setup(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (spi->irq)
> +		chip_info = &ad7091r_spi_chip_info_irq[chip_info->type];

This is a little ugly and explains your indirection via a type. I'd put a wrapper
structure round both chip_info (irq and non irq) and add that to the .data in
the look up tables that follow.  Thus having a simple tree structure for now we
get to the appropriate data

struct ad7091r_chip_info_container {
	struct ad7091r_chip_info irq_info;
	struct ad7091r_chip_info no_irq_info;
	struct regmap_config *regmap_config;
};
Pointers fine as well if that ends up cleaner.

Then spi_get_device_match_data() provides a pointer to this container struct
providing all the info for the device, and the stuff we need at runtime is then
done by picking between the two info structures under it.
 
> +
> +	return ad7091r_probe(iio_dev, chip_info->name, chip_info, map, spi->irq);
> +}
> +
> +static const struct of_device_id ad7091r8_of_match[] = {
> +	{ .compatible = "adi,ad7091r2", .data = &ad7091r_spi_chip_info[AD7091R2] },
> +	{ .compatible = "adi,ad7091r4", .data = &ad7091r_spi_chip_info[AD7091R4] },
> +	{ .compatible = "adi,ad7091r8", .data = &ad7091r_spi_chip_info[AD7091R8] },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ad7091r8_of_match);
> +
> +static const struct spi_device_id ad7091r8_spi_id[] = {
> +	{ "ad7091r2", (kernel_ulong_t)&ad7091r_spi_chip_info[AD7091R2] },
> +	{ "ad7091r4", (kernel_ulong_t)&ad7091r_spi_chip_info[AD7091R4] },
> +	{ "ad7091r8", (kernel_ulong_t)&ad7091r_spi_chip_info[AD7091R8] },
> +	{ },
'Null terminators' like these shouldn't be followed by a ,
We can't add anything after them in future.

> +};
> +MODULE_DEVICE_TABLE(spi, ad7091r8_spi_id);


