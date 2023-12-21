Return-Path: <linux-kernel+bounces-8813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF781BC97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31105B219FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052259910;
	Thu, 21 Dec 2023 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca18baTt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987345822F;
	Thu, 21 Dec 2023 17:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FD1C433C8;
	Thu, 21 Dec 2023 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178441;
	bh=k/8l5DHSfbM3vfaM1rwiWHs/+L3KkjdbSkrP2E7Jf+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ca18baTteU2VMteMCkZWdhQX/ahKca1npKQW+egXWHA2vAkl6/J5jdVUfa7cn6yxh
	 t9NNhzDD1XWKzoMVrfw6HhW8bTeaFvwUs4wMqUil9rBGzWsCpPXySMmNPBpuwQt0Ha
	 H+S3kC77E9R2pYDZby/YhnSU5SyiHIRzxIh+OWaZixEVXTD5F4RvLbPxgEzrdvV9WE
	 /eyJhK/paZaSJcDYwX8fwgw77yij92tlrnYiWByEtrTJrzRHMPXmr5IhBqTRTTbj0/
	 GFo90cDvsxuaCkHKGCyYcWPBRlhZeS9aMM867kP3VN/4twapsCfgn9BN50orzGX5p4
	 zcrqHfvdVX1AQ==
Date: Thu, 21 Dec 2023 17:07:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 2/2] iio: dac: driver for MCP4821
Message-ID: <20231221170706.27f5b76f@jic23-huawei>
In-Reply-To: <20231220151954.154595-2-anshulusr@gmail.com>
References: <20231220151954.154595-1-anshulusr@gmail.com>
	<20231220151954.154595-2-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 20:49:53 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Adds driver for the MCP48xx series of DACs.
> 
> Device uses a simplex SPI channel. To set the value of an output channel,
> a 16-bit data of following format must be written:
> 
> Bit field | Description
> 15 [MSB]  | Channel selection bit
>             0 -> Channel A
>             1 -> Channel B
> 13        | Output Gain Selection bit
>             0 -> 2x Gain (Vref = 4.096V)
>             1 -> 1x Gain (Vref = 2.048V)
> 12        | Output Shutdown Control bit
>             0 -> Shutdown the selected channel
>             1 -> Active mode operation
> 11-0 [LSB]| DAC Input Data bits
>             Value's big endian representation is taken as input for the
>             selected DAC channel. For devices with a resolution of less
>             than 12-bits, only the x most significant bits are considered
>             where x is the resolution of the device.
> Reference: Page#22 [MCP48x2 Datasheet]
> 
> Supported devices:
>   +---------+--------------+-------------+
>   | Device  |  Resolution  |   Channels  |
>   |---------|--------------|-------------|
>   | MCP4801 |     8-bit    |      1      |
>   | MCP4802 |     8-bit    |      2      |
>   | MCP4811 |    10-bit    |      1      |
>   | MCP4812 |    10-bit    |      2      |
>   | MCP4821 |    12-bit    |      1      |
>   | MCP4822 |    12-bit    |      2      |
>   +---------+--------------+-------------+
> 
> Devices tested:
>   MCP4821 [12-bit single channel]
>   MCP4802 [8-bit dual channel]
> 
> Tested on Raspberry Pi Zero 2W
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf #MCP48x1
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf #MCP48x2
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

I've applied this to my tree with a few formatting tweaks. However, timing is such
that, unless 6.7 release is delayed, the merge window will open too soon for me
to get another pull request in.  A such this is now almost certainly queued up
for the 6.9 cycle in a few months time.  That's probably a good thing anyway as
some people will already be on vacation and may want to take another look at this
when then get back.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look at it.

Thanks,

Jonathan

> 
> ---
> 
> Changes for v5:
> - Removed unnecessary mutex
> - Removed unused channel fields initializations
> - Use saperate checks for validity of val and val2 in write_raw
> - Use cpu_to_be16 instead of put_unaligned_be16
> 
> Changes for v3,4:
> - no updates
> 
> Changes for v2:
> - Changed device ordering to numerical
> - Fixed ordering of headers
> - Added struct mcp4821_chip_info instead of relying on driver_data from
>   spi device ids
> - Use scoped_guards for all mutex locks
> - Changed write_val from __be16 to u16 in mcp4821_write_raw
>   Fixes sparse warning: incorrect type in assignment
> 
> Previous versions:
> v4: https://lore.kernel.org/lkml/20231219090252.818754-2-anshulusr@gmail.com/
> v3: https://lore.kernel.org/lkml/20231218164735.787199-2-anshulusr@gmail.com/
> v2: https://lore.kernel.org/lkml/20231217180836.584828-2-anshulusr@gmail.com/
> v1: https://lore.kernel.org/lkml/20231117073040.685860-2-anshulusr@gmail.com/
> ---
>  MAINTAINERS               |   7 ++
>  drivers/iio/dac/Kconfig   |  10 ++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/mcp4821.c | 219 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 237 insertions(+)
>  create mode 100644 drivers/iio/dac/mcp4821.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81d5fc0bba68..8d9274c33c6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13029,6 +13029,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
>  F:	drivers/iio/potentiometer/mcp4018.c
>  F:	drivers/iio/potentiometer/mcp4531.c
>  
> +MCP4821 DAC DRIVER
> +M:	Anshul Dalal <anshulusr@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> +F:	drivers/iio/dac/mcp4821.c
> +
>  MCR20A IEEE-802.15.4 RADIO DRIVER
>  M:	Stefan Schmidt <stefan@datenfreihafen.org>
>  L:	linux-wpan@vger.kernel.org
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 93b8be183de6..34eb40bb9529 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -400,6 +400,16 @@ config MCP4728
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mcp4728.
>  
> +config MCP4821
> +	tristate "MCP4801/02/11/12/21/22 DAC driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build the driver for the Microchip MCP4801
> +	  MCP4802, MCP4811, MCP4812, MCP4821 and MCP4822 DAC devices.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcp4821.
> +
>  config MCP4922
>  	tristate "MCP4902, MCP4912, MCP4922 DAC driver"
>  	depends on SPI
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 5b2bac900d5a..55bf89739d14 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_MAX5522) += max5522.o
>  obj-$(CONFIG_MAX5821) += max5821.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
>  obj-$(CONFIG_MCP4728) += mcp4728.o
> +obj-$(CONFIG_MCP4821) += mcp4821.o
>  obj-$(CONFIG_MCP4922) += mcp4922.o
>  obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
>  obj-$(CONFIG_STM32_DAC) += stm32-dac.o
> diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
> new file mode 100644
> index 000000000000..028983f59cda
> --- /dev/null
> +++ b/drivers/iio/dac/mcp4821.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
> + *
> + * Driver for Microchip MCP4801, MCP4802, MCP4811, MCP4812, MCP4821 and MCP4822
> + *
> + * Based on the work of:
> + *	Michael Welling (MCP4922 Driver)
> + *
> + * Datasheet:
> + *	MCP48x1: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
> + *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
> + *
> + * TODO:
> + *	- Configurable gain
> + *	- Regulator control
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define MCP4821_ACTIVE_MODE BIT(12)
> +#define MCP4802_SECOND_CHAN BIT(15)
> +
> +/* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
> +#define MCP4821_2X_GAIN_VREF_MV 4096
> +
> +enum mcp4821_supported_drvice_ids {
> +	ID_MCP4801,
> +	ID_MCP4802,
> +	ID_MCP4811,
> +	ID_MCP4812,
> +	ID_MCP4821,
> +	ID_MCP4822,
> +};
> +
> +struct mcp4821_state {
> +	struct spi_device *spi;
> +	u16 dac_value[2];
> +};
> +
> +struct mcp4821_chip_info {
> +	const char *name;
> +	int num_channels;
> +	const struct iio_chan_spec channels[2];
> +};
> +
> +#define MCP4821_CHAN(channel_id, resolution)                          \
> +	{                                                             \
> +		.type = IIO_VOLTAGE, .output = 1, .indexed = 1,       \
> +		.channel = (channel_id),                              \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.scan_type = {                                        \
> +			.realbits = (resolution),                     \
> +			.shift = 12 - (resolution),                   \
> +		},                                                    \
> +	}
> +
> +static const struct mcp4821_chip_info mcp4821_chip_info_table[6] = {
> +	[ID_MCP4801] = {
> +			.name = "mcp4801",
> +			.num_channels = 1,
> +			.channels = { MCP4821_CHAN(0, 8) }
> +			},
> +	[ID_MCP4802] = {
> +			.name = "mcp4802",
> +			.num_channels = 2,
> +			.channels = { MCP4821_CHAN(0, 8),
> +				       MCP4821_CHAN(1, 8) }
> +			},
> +	[ID_MCP4811] = {
> +			.name = "mcp4811",
> +			.num_channels = 1,
> +			.channels = { MCP4821_CHAN(0, 10) }
> +			},
> +	[ID_MCP4812] = {
> +			.name = "mcp4812",
> +			.num_channels = 2,
> +			.channels = { MCP4821_CHAN(0, 10),
> +				       MCP4821_CHAN(1, 10) }
> +			},
> +	[ID_MCP4821] = {
> +			.name = "mcp4821",
> +			.num_channels = 1,
> +			.channels = { MCP4821_CHAN(0, 12) }
> +			},
> +	[ID_MCP4822] = {
> +			.name = "mcp4822",
> +			.num_channels = 2,
> +			.channels = { MCP4821_CHAN(0, 12),
> +				       MCP4821_CHAN(1, 12) }
> +			},
> +};
> +
> +static int mcp4821_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mcp4821_state *state;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		state = iio_priv(indio_dev);
> +		*val = state->dac_value[chan->channel];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = MCP4821_2X_GAIN_VREF_MV;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp4821_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct mcp4821_state *state = iio_priv(indio_dev);
> +	u16 write_val;
> +	__be16 write_buffer;
> +	int ret;
> +
> +	if (val2 != 0)
> +		return -EINVAL;
> +	if (val < 0 || val >= BIT(chan->scan_type.realbits))
> +		return -EINVAL;
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> +	if (chan->channel)
> +		write_val |= MCP4802_SECOND_CHAN;
> +	write_buffer = cpu_to_be16(write_val);
> +	ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
> +	if (ret) {
> +		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
> +		return ret;
> +	}
> +
> +	state->dac_value[chan->channel] = val;
> +	return 0;
> +}
> +
> +static const struct iio_info mcp4821_info = {
> +	.read_raw = &mcp4821_read_raw,
> +	.write_raw = &mcp4821_write_raw,
> +};
> +
> +static int mcp4821_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mcp4821_state *state;
> +	const struct mcp4821_chip_info *info;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	state->spi = spi;
> +
> +	info = spi_get_device_match_data(spi);
> +	indio_dev->name = info->name;
> +	indio_dev->info = &mcp4821_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = info->channels;
> +	indio_dev->num_channels = info->num_channels;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +#define MCP4821_COMPATIBLE(of_compatible, id)        \
> +	{                                            \
> +		.compatible = of_compatible,         \
> +		.data = &mcp4821_chip_info_table[id] \
> +	}
> +
> +static const struct of_device_id mcp4821_of_table[] = {
> +	MCP4821_COMPATIBLE("microchip,mcp4801", ID_MCP4801),
> +	MCP4821_COMPATIBLE("microchip,mcp4802", ID_MCP4802),
> +	MCP4821_COMPATIBLE("microchip,mcp4811", ID_MCP4811),
> +	MCP4821_COMPATIBLE("microchip,mcp4812", ID_MCP4812),
> +	MCP4821_COMPATIBLE("microchip,mcp4821", ID_MCP4821),
> +	MCP4821_COMPATIBLE("microchip,mcp4822", ID_MCP4822),
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp4821_of_table);
> +
> +static const struct spi_device_id mcp4821_id_table[] = {
> +	{ "mcp4801", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4801]},
> +	{ "mcp4802", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4802]},
> +	{ "mcp4811", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4811]},
> +	{ "mcp4812", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4812]},
> +	{ "mcp4821", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4821]},
> +	{ "mcp4822", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4822]},
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(spi, mcp4821_id_table);
> +
> +static struct spi_driver mcp4821_driver = {
> +	.driver = {
> +		.name = "mcp4821",
> +		.of_match_table = mcp4821_of_table,
> +	},
> +	.probe = mcp4821_probe,
> +	.id_table = mcp4821_id_table,
> +};
> +module_spi_driver(mcp4821_driver);
> +
> +MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
> +MODULE_DESCRIPTION("Microchip MCP4821 DAC Driver");
> +MODULE_LICENSE("GPL");


