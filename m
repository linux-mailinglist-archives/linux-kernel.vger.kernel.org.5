Return-Path: <linux-kernel+bounces-7054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B712281A10E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDBAB21919
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E738F92;
	Wed, 20 Dec 2023 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIcnAC2v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1B38F82;
	Wed, 20 Dec 2023 14:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75C7C433C7;
	Wed, 20 Dec 2023 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703082222;
	bh=b23XVGoTRCwlUJUHTcAJAYOiRsE9M2whf1frNvIcKcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rIcnAC2vCYXfrZTmM7pKqz84r6GVLJ+T0cDHNYXWpOIRfGHvwwpKwAtozbSRgl150
	 PRPn2F1UIx72z1u/N1pTm2D8Upjhs8yH+Y9t9LkgL9Idwp3ithTIIL9vyNizDUPj+1
	 yWKG3Y8aXNJ+dGgzg+/gCZ9kb94OvgKNXXCDtL8wKgn7itn+sZEgUyDnkUIqZ2xVn4
	 NEj20kv9t1EGyrnUwQUWtCaH/QIXsw8hZUOmeyLcSaFKJFsISt/pHXpVttKsUwwrTS
	 Z/UkBQBiyNXrwZtG7oXT18wicqK5a5b+SB2whoryPLdNnEQuDZ0OEw98+VtIPSy5as
	 2zcj3JZDLiCHg==
Date: Wed, 20 Dec 2023 14:23:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] iio: dac: driver for MCP4821
Message-ID: <20231220142326.138763a4@jic23-huawei>
In-Reply-To: <20231217180836.584828-2-anshulusr@gmail.com>
References: <20231217180836.584828-1-anshulusr@gmail.com>
	<20231217180836.584828-2-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 23:38:34 +0530
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
> 
>

Hi Anshul,

Various minor comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
> new file mode 100644
> index 000000000000..7384df71f702
> --- /dev/null
> +++ b/drivers/iio/dac/mcp4821.c
> @@ -0,0 +1,228 @@
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
> +#include <linux/mutex.h>
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
> +	// Protects dac_value
/* Protects dac_value */

However I'm not clear why a u16 array needs protecting?
Whilst in theory the compiler might be annoying and do torn writes
(write it as 2 1 byte values) that's pretty unlikely and
we don't normally bother to protect against that.

> +	struct mutex lock;
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
> +			.sign = 'u',                                  \

Not used so don't bother setting it until you add buffered support.

> +			.realbits = (resolution),                     \
> +			.storagebits = 16,                            \

Not used, so don't bother setting it.

> +			.shift = 12 - (resolution),                   \
> +		},                                                    \
> +	}

> +static int mcp4821_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mcp4821_state *state;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		state = iio_priv(indio_dev);
> +		scoped_guard(mutex, &state->lock)
> +			*val = state->dac_value[chan->channel];
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
> +	u16 write_val;
> +	__be16 write_buffer;
> +	int ret;
> +	bool is_value_valid = val >= 0 && val < BIT(chan->scan_type.realbits) &&
> +			      val2 == 0;
> +
> +	if (!is_value_valid)

Check the opposite and drop the local variable that adds nothing.

	if ((val < 0) || (val >= BIT(chan_type).realbits)) || (val2 != 0))
or split it up into checks on val2 in one check then on val in the other.
 
> +		return -EINVAL;
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	state = iio_priv(indio_dev);
I'd do this at point of local variable declaration above.

struct mcp4821_state *state = iio_priv(indio_dev);

> +	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> +	if (chan->channel)
> +		write_val |= MCP4802_SECOND_CHAN;
> +	put_unaligned_be16(write_val, &write_buffer);
It's aligned given it's a __be16

> +	ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
> +	if (ret) {
> +		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
> +		return ret;
> +	}
> +
> +	scoped_guard(mutex, &state->lock)
> +		state->dac_value[chan->channel] = val;

> +	return 0;
> +}
> +

Jonathan

