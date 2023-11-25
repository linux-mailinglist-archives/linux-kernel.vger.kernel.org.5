Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E237F8A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjKYMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjKYMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:07:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644119A8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:07:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DF2C433C7;
        Sat, 25 Nov 2023 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700914072;
        bh=D4kxke8I3u5kGrzOOHNBlvZ51Ki1vGdPFs5hwb4dDbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ijLyFy/ZtJRy6r9c6iO9ei8RPEudxWqyIYBBykt5rjPo695Qm5s3h7oxloOtucRfm
         o+OTQ+rzXrZXtoMhhHDpx9vqjJ6DHz7SuVMCykhGi+/7MmbKrSoNJuEz4vDumxSZel
         doOZXOpIAwfsVQiXRIls58IY5bDqHAYceYGRP/MpEsBdytonerHnulaTJlwVKVvvbh
         kEspLTFEdtI4FMSnFZ1T9rblRjDO9NR6Oqu6cDiV92/n0isG65dGb6u3ohAKb/XU3B
         GxLVvya9b1PFCoM+XyibJ0VyS06XmBEGE57RxysWUgA+1muRcwOntPlD+QCqB1qFlP
         wBGsWfadxVY0A==
Date:   Sat, 25 Nov 2023 12:07:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 2/2] iio: dac: driver for MCP4821
Message-ID: <20231125120744.23b0893d@jic23-huawei>
In-Reply-To: <20231117073040.685860-2-anshulusr@gmail.com>
References: <20231117073040.685860-1-anshulusr@gmail.com>
        <20231117073040.685860-2-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 13:00:38 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

Hi Anshul,

Comments inline.

> Adds driver for the MCP48xx series of DACs.
> 
> Device uses a simplex SPI channel.
> To set the value of an output channel, a 16-bit
> data of following format must be written:

Wrap anything that isn't specifically formatted at 75 chars not this short.  
I could fix that whilst applying but you are going to be doing a v2 anyway
so you can tidy it up :)

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
>             Value's big endian representation is
>             taken as input for the selected DAC
>             channel.
>             For devices with a resolution of less
>             than 12-bits, only the x most
>             significant bits are considered where
>             x is the resolution of the device.
> Reference: Page#22 [MCP48x2 Datasheet]
> 
> Supported devices:
>   +---------+--------------+-------------+
>   | Device  |  Resolution  |   Channels  |
>   |---------|--------------|-------------|
>   | MCP4801 |     8-bit    |      1      |
>   | MCP4811 |    10-bit    |      1      |
>   | MCP4821 |    12-bit    |      1      |
>   | MCP4802 |     8-bit    |      2      |
>   | MCP4812 |    10-bit    |      2      |
>   | MCP4822 |    12-bit    |      2      |
>   +---------+--------------+-------------+
> 
> Devices tested:
>   MCP4821 [12-bit single channel]
>   MCP4802 [8-bit dual channel]
> 
> Tested on Raspberry Pi Zero 2W
> 
> Datasheet:
>   [MCP48x1] https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
>   [MCP48x2] https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
So Datasheet is part of the tag block so no line break between this
and sign off.  The way to format this is to add two entries and apply comments
after them.  Don't worry about long lines for this.

> 

Datasheet: https//.... #MCP48x1
Datasheet: https//.... #MCP48x2
Signed-off-by: ...

> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
...

> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 93b8be183de6..f5adc364de30 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -400,6 +400,16 @@ config MCP4728
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mcp4728.
>  
> +config MCP4821
> +	tristate "MCP4801/11/21/02/12/22 DAC driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build the driver for the Microchip MCP4801
> +	  MCP4811, MCP4821, MCP4802, MCP4812 and MCP4822 DAC devices.

Numeric order her as well please.

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcp4821.
> +
>  config MCP4922
>  	tristate "MCP4902, MCP4912, MCP4922 DAC driver"
>  	depends on SPI

...

> diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
> new file mode 100644
> index 000000000000..d08acf6b8993
> --- /dev/null
> +++ b/drivers/iio/dac/mcp4821.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
> + *
> + * Driver for Microchip MCP4801, MCP4811, MCP4821, MCP4802, MCP4812 and MCP4822
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
> +#include <asm/unaligned.h>
So in IIO at least header ordering is normally (each block alphabetical)

linux/*.h

linux/iio/*.h (it's an IIO driver so sometimes good to separate these out)

asm/*.h (these are effectively even more specific so we put them in their own block.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/spi/spi.h>
> +
> +#define MCP4821_ACTIVE_MODE BIT(12)
> +#define MCP4802_SECOND_CHAN BIT(15)
> +#define MCP4821_CHAN_NUM    1
Not used so drop this.

> +
> +/* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
> +#define MCP4821_2X_GAIN_VREF_MV 4096
> +
> +enum mcp4821_supported_drvice_ids {
> +	ID_MCP4801,
> +	ID_MCP4811,
> +	ID_MCP4821,
> +	ID_MCP4802,

Numeric order preferred throughout if we have long lists like this.

> +	ID_MCP4812,
> +	ID_MCP4822,
> +};
> +
> +static int mcp4821_chan_count(enum mcp4821_supported_drvice_ids device_id)
> +{
> +	switch (device_id) {
> +	case ID_MCP4801:
> +	case ID_MCP4811:
> +	case ID_MCP4821:
> +		return 1;
> +	default:

I'd rather see this explicit for each device even though it's a few more lines
of code.

> +		return 2;
> +	}
> +}
> +
> +struct mcp4821_state {
> +	struct spi_device *spi;
> +	struct mutex lock;

All locks need to have a comment describing the scope of data they are protecting.

> +	u16 dac_value[2];
> +};
> +
> +#define MCP4821_CHAN(channel_id, resolution)				\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.output = 1,						\
> +		.indexed = 1,						\
> +		.channel = (channel_id),				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = (resolution),			\
> +			.storagebits = 16,				\
> +			.shift = 12 - (resolution),			\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec mcp4821_channels[6][2] = {
> +	[ID_MCP4801] = { MCP4821_CHAN(0, 8), {} },

C will fill in the second entry with zeros without needing a {} and
as we don't care about it anyway, just don't bother adding the {} placeholder,
making it a bit neater.

> +	[ID_MCP4811] = { MCP4821_CHAN(0, 10), {} },
> +	[ID_MCP4821] = { MCP4821_CHAN(0, 12), {} },
> +	[ID_MCP4802] = { MCP4821_CHAN(0, 8), MCP4821_CHAN(1, 8) },
> +	[ID_MCP4812] = { MCP4821_CHAN(0, 10), MCP4821_CHAN(1, 10) },
> +	[ID_MCP4822] = { MCP4821_CHAN(0, 12), MCP4821_CHAN(1, 12) },
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
> +		mutex_lock(&state->lock);

Can use the new auto cleanup stuff for this to shorten things a tiny bit.

		scoped_guard(mutex, &state->lock)
			*val = state->dac_channel[chan->channel];

Obviously very minor advantage here so I don't mind either way.

> +		*val = state->dac_value[chan->channel];
> +		mutex_unlock(&state->lock);
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
> +	struct mcp4821_state *state;
> +	__be16 write_val;
> +	u8 write_buffer[2];

type of these two is backwards.  you are build the value in write_val, so that should
just be a u16, then converting it to be16 so write_buffer should be __be16

> +	int ret;
> +	bool is_value_valid = val >= 0 && val < BIT(chan->scan_type.realbits) &&
> +			      val2 == 0;
> +	if (mask == IIO_CHAN_INFO_RAW && is_value_valid) {
> +		state = iio_priv(indio_dev);
> +
> +		write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> +		if (chan->channel)
> +			write_val |= MCP4802_SECOND_CHAN;
> +		put_unaligned_be16(write_val, write_buffer);



> +		ret = spi_write(state->spi, write_buffer, sizeof(write_buffer));
> +		if (ret) {
> +			dev_err(&state->spi->dev,
> +				"Failed to write to device: %d", ret);
> +			return ret;
> +		}
> +
> +		mutex_lock(&state->lock);

As above if you want to.


> +		state->dac_value[chan->channel] = val;
> +		mutex_unlock(&state->lock);
> +		return 0;
> +	} else {
> +		return -EINVAL;
Flip this and separate the unrelated conditions.
	if (mask != IIO_CHAN_INFO_RAW)
		return -EINVAL;

	if (!is_value_valid)
		return -EINVAL;

	...

reduces unnecessary indent and generally puts the errors 'out of line' which
is common kernel approach and generally 'what we expect to see' when reviewing.


> +	}
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
> +	const struct spi_device_id *id;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (indio_dev == NULL) {
> +		dev_err(&spi->dev, "Failed to allocate iio device\n");
> +		return -ENOMEM;
		return dev_err_probe(&spi->dev, -ENOMEM,
				     "failed to allocate IIO device\n");

However that's very unlikely to ever happen, so you could just not bother
with the message.

> +	}
> +
> +	state = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);

Why?

> +	id = spi_get_device_id(spi);
For dt bindings this relies on the fallback of breaking up the compatible.
That's fragile, so add the data to the of_table as well + use pointers
not enum values so that you can then use spi_get_device_match_data()
which handles other firmware types as well and falls back to what you
have here.

> +
> +	state->spi = spi;
> +	mutex_init(&state->lock);
> +
> +	indio_dev->name = id->name;

Also fragile (very weird things happen if you end up with fallback DT compatibles
in the future).  So embed a string in a device specific structure as described
below.

> +	indio_dev->info = &mcp4821_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mcp4821_channels[id->driver_data];
> +	indio_dev->num_channels = mcp4821_chan_count(id->driver_data);
Combine channels and chan_count as static data in a
struct mcp4821_info {
	struct iio_chan_spec channels];
	int num_channels;
	const char *name;
}
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id mcp4821_id_table[] = {
> +	{ "mcp4801", ID_MCP4801},
use &mcp4821_data[ID_MCP4801] etc in here.. (with cast as needed, lots of
examples in tree...
> +	{ "mcp4811", ID_MCP4811},
> +	{ "mcp4821", ID_MCP4821},
> +	{ "mcp4802", ID_MCP4802},
> +	{ "mcp4812", ID_MCP4812},
> +	{ "mcp4822", ID_MCP4822},
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(spi, mcp4821_id_table);
> +
> +static const struct of_device_id mcp4821_of_table[] = {
> +	{ .compatible = "microchip,mcp4801"},
and provide the data here as well. 
> +	{ .compatible = "microchip,mcp4811"},
> +	{ .compatible = "microchip,mcp4821"},
...

Thanks,

Jonathan


