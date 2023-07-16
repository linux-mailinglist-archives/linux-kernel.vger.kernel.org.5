Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE1754F83
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjGPPyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGPPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB212B;
        Sun, 16 Jul 2023 08:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE16760DB6;
        Sun, 16 Jul 2023 15:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813FCC433C7;
        Sun, 16 Jul 2023 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689522880;
        bh=m9K8sHQtLdicUGJBsFYMTN/iiUPmjtgsNo7j0DisLEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KVjBuwPzplAsDhBpMaw1ROMeCwipiir16f/x0WI2MpzupQbTSgIVZEpr04JUwULju
         JC3RmhwyOfSPj/UiqGjycCh35aduG0YFW5QY0F7ZEEX/kQzBxO5UDannkiO3fBMNmX
         NxJsMkyt7Xb3x8uN60k/Is32B2YsG/XD57JdL7GY4VdqmEiFLftvD+yK+/YxndlrtQ
         iAItA+F9LYVDQ3Jv5KukGwZPP8RNA8QIg31zltLP2rwjQltfYo8n6dQjGLBFQK6wcY
         x+Ds6c2A+++6aqkd5/RYiQR18jiKrqUU7Ww8dXvz6vSLF0O1ePauBlal23FFQOSHZE
         zX8OBPnrzfn8w==
Date:   Sun, 16 Jul 2023 16:54:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230716165433.01226811@jic23-huawei>
In-Reply-To: <20230714150051.637952-3-marius.cristea@microchip.com>
References: <20230714150051.637952-1-marius.cristea@microchip.com>
        <20230714150051.637952-3-marius.cristea@microchip.com>
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

On Fri, 14 Jul 2023 18:00:51 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip family of 153.6 ksps,
> Low-Noise 16/24-Bit Delta-Sigma ADCs with an SPI interface
> (Microchip's  MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> MCP3562R and MCP3564R analog to digital converters).
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
Hi Marius,

Various comments inline to add to the open question on how to
deal with the addressing that will hopefully get discussed alongside
the binding reviews.


> ---
>  .../ABI/testing/sysfs-bus-iio-adc-mcp3564     |   53 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/mcp3564.c                     | 1485 +++++++++++++++++
>  5 files changed, 1559 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
>  create mode 100644 drivers/iio/adc/mcp3564.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
> new file mode 100644
> index 000000000000..50393258be70
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
> @@ -0,0 +1,53 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/boost_current
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to set the biasing circuit of the
> +		Delta-Sigma modulator. The different BOOST settings are applied
> +		to the entire modulator circuit, including the voltage reference
> +		buffers.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/boost_current_available
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible values for
> +		the current biasing circuit of the Delta-Sigma modulator.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/enable_auto_zeroing_mux
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to enable the analog input multiplexer
> +		auto-zeroing algorithm (the input multiplexer and the ADC
> +		include an offset cancellation algorithm that cancels the offset
> +		contribution of the ADC). When the offset cancellation algorithm
> +		is enabled, ADC takes two conversions, one with the differential
> +		input as VIN+/VIN-, one with VIN+/VIN- inverted. In this case the
> +		conversion time is multiplied by two compared to the default
> +		case where the algorithm is disabled. This technique allows the
> +		cancellation of the ADC offset error and the achievement of
> +		ultra-low offset without any digital calibration. The resulting
> +		offset is the residue of the difference between the two
> +		conversions, which is on the order of magnitude of the noise
> +		floor. This offset is effectively canceled at every conversion,
> +		so the residual offset error temperature drift is extremely low.
> +		Write '1' to enable it, write '0' to disable it.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/enable_auto_zeroing_ref
IIO has usually gone with naming that would make this
auto_zeroing_ref_enable 

Just for consistency I'd prefer to keep to that form.

> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to enable the chopping algorithm for the 
> +		internal voltage reference buffer. This setting has no effect
> +		when external voltage reference is selected.

Check below on whether to expose this seems to be based on whether the part
has an internal voltage reference, not whether it is used.  I think it should be
the is it used check.

> +		Internal voltage reference buffer injects a certain quantity of
> +		1/f noise into the system that can be modulated with the
> +		incoming input signals and can limit the SNR performance at
> +		higher Oversampling Ratio values (over 256). To overcome this
> +		limitation, the buffer includes an auto-zeroing algorithm that
> +		greatly reduces (cancels out) the 1/f noise and cancels the
> +		offset value of the reference buffer. As a result, the SNR of
> +		the system is not affected by this 1/f noise component of the
> +		reference buffer, even at maximum oversampling ratio values.
> +		Write '1' to enable it, write '0' to disable it.

..

> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> new file mode 100644
> index 000000000000..42828abb3db1
> --- /dev/null
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -0,0 +1,1485 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP356X/MCP356XR and MCP346X/MCP346XR series ADC chip family
> + *
> + * Copyright (C) 2022-2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Marius Cristea <marius.cristea@microchip.com>
> + *
> + * Datasheet for MCP3561, MCP3562, MCP3564 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP3561-2-4-Family-Data-Sheet-DS20006181C.pdf
> + * Datasheet for MCP3561R, MCP3562R, MCP3564R can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3561_2_4R-Data-Sheet-DS200006391C.pdf
> + * Datasheet for MCP3461, MCP3462, MCP3464 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3461-2-4-Two-Four-Eight-Channel-153.6-ksps-Low-Noise-16-Bit-Delta-Sigma-ADC-Data-Sheet-20006180D.pdf
> + * Datasheet for MCP3461R, MCP3462R, MCP3464R can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3461-2-4R-Family-Data-Sheet-DS20006404C.pdf
> + *
> + */
> +
> +#include <linux/acpi.h>
Why?

Check the others for anything else that isn't obviously used.

> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
> +#include <asm/unaligned.h>
> +

> +/**
> + * struct mcp3564_state - working data for a ADC device
> + * @chip_info:		chip specific data
> + * @spi:		SPI device structure
> + * @vref:		the regulator device used as a voltage reference in case
> + *			external voltage reference is used
> + * @vref_mv:		voltage reference value in miliVolts
> + * @lock:		Synchronize access to driver's state members
> + * @dev_addr:		hardware device address
> + * @oversampling:	the index inside oversampling list of the ADC
> + * @hwgain:		the index inside hardware gain list of the ADC
> + * @scale_tbls		table with precalculated scale
> + * @calib_bias:		calibration bias value
> + * @calib_scale:	calibration scale value
> + * @current_boost_mode:	the index inside current boost list of the ADC
> + * @burnout:		the index inside current bias list of the ADC

burnout_mode

Build with W=1 and you should get warnings about this sort of thing if the
kernel-docs scripts can find a problem.

> + * @auto_zeroing_mux:	set if ADC auto-zeroing algorithm is enabled
> + * @auto_zeroing_ref:	set if ADC auto-Zeroing Reference Buffer Setting is enabled
> + * @has_vref:		Does the ADC has an internal voltage reference?
> + */
> +struct mcp3564_state {
> +	const struct mcp3564_chip_info	*chip_info;
> +	struct spi_device		*spi;
> +	struct regulator		*vref;
> +	unsigned short			vref_mv;
> +	struct mutex			lock; /* Synchronize access to driver's state members */
> +	u8				dev_addr;
> +	enum mcp3564_oversampling	oversampling;
> +	unsigned int			hwgain;
> +	unsigned int			scale_tbls[MCP3564_MAX_PGA][2];
> +	int				calib_bias;
> +	int				calib_scale;
> +	unsigned int			current_boost_mode;
> +	enum mcp3564_burnout		burnout_mode;
> +	bool				auto_zeroing_mux;
> +	bool				auto_zeroing_ref;
> +	bool				has_vref;
> +};
> +

> +static int mcp3564_read_16bits(struct mcp3564_state *adc, u8 reg, u16 *val)
> +{
> +	int ret;
> +	u8 tx_buf;
> +	u8 rx_buf[2];

__be16 for this (and similar in other cases) would ensure you don't need
the unaligned accessors.  I don't think there is any problem passing a __be16
pointer to spi_write_then_read.


> +
> +	tx_buf = mcp3564_cmd_read(adc->dev_addr, reg);
> +
> +	ret = spi_write_then_read(adc->spi, &tx_buf, sizeof(tx_buf),
> +				  rx_buf, sizeof(rx_buf));
> +	*val = get_unaligned_be16(rx_buf);
> +
> +	return ret;
> +}
> +
>
> +
> +static const struct iio_chan_spec mcp3564_channel_template = {
> +	.type = IIO_VOLTAGE,
> +	.indexed = 1,
> +	.differential = 1,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_all  = BIT(IIO_CHAN_INFO_SCALE)		|
> +				BIT(IIO_CHAN_INFO_CALIBSCALE)		|
> +				BIT(IIO_CHAN_INFO_CALIBBIAS)		|
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SCALE)	|
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS)		|
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	.ext_info = mcp3564_ext_info,
> +	.scan_type = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.endianness = IIO_BE,

This stuff only matters if you provide a buffered interface. Normally we introduce
it along with that rather than in advance like this.

> +	},
> +};
> +

> +
> +static const struct iio_chan_spec mcp3564_burnout_channel_template = {
> +	.extend_name = "burnout",
We generally try to avoid extend_name in new drivers because of the difficulty
of handling resulting filenames from userspace (+ difficulty of documentation which
is missing here I think).
Can we make this a label instead as those are under a separate file rather than
embedded in every file name associated with the channel.  See the read_label()
callback.

> +	.type = IIO_CURRENT,
> +	.output = true,
> +	.channel = 0,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
> +};
> +
> +static const struct mcp3564_chip_info mcp3564_chip_infos_tbl[] = {
> +	[mcp3461] = {
> +		.name = "mcp3461",
> +		.num_channels = 6,
> +		.resolution = 16,
> +	},
> +	[mcp3462] = {
> +		.name = "mcp3462",
> +		.num_channels = 18,
> +		.resolution = 16,
> +	},
> +	[mcp3464] = {
> +		.name = "mcp3464",
> +		.num_channels = 66,

How do we end up with so many channels?  + If this can be expressed
as a calculation that makes it clear where they all come from that
would act as useful documentation.

> +		.resolution = 16,
> +	},
> +	[mcp3561] = {
> +		.name = "mcp3561",
> +		.num_channels = 6,
> +		.resolution = 24,
> +	},
> +	[mcp3562] = {
> +		.name = "mcp3562",
> +		.num_channels = 18,
> +		.resolution = 24,
> +	},
> +	[mcp3564] = {
> +		.name = "mcp3564",
> +		.num_channels = 66,
> +		.resolution = 24,
> +	},
> +	[mcp3461r] = {
> +		.name = "mcp3461r",
> +		.num_channels = 6,
> +		.resolution = 16,
> +	},
> +	[mcp3462r] = {
> +		.name = "mcp3462r",
> +		.num_channels = 18,
> +		.resolution = 16,
> +	},
> +	[mcp3464r] = {
> +		.name = "mcp3464r",
> +		.num_channels = 66,
> +		.resolution = 16,
> +	},
> +	[mcp3561r] = {
> +		.name = "mcp3561r",
> +		.num_channels = 6,
> +		.resolution = 24,
> +	},
> +	[mcp3562r] = {
> +		.name = "mcp3562r",
> +		.num_channels = 18,
> +		.resolution = 24,
> +	},
> +	[mcp3564r] = {
> +		.name = "mcp3564r",
> +		.num_channels = 66,
> +		.resolution = 24,
> +	},
> +};
> +
> +static int mcp3564_read_single_value(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *channel,
> +				     int *val)
> +{
> +	struct mcp3564_state *adc = iio_priv(indio_dev);
> +	int ret;
> +	u8 tmp;
> +	int ret_read = 0;
> +
> +	ret = mcp3564_write_8bits(adc, MCP3564_MUX, channel->address);
> +	if (ret)
> +		return ret;
> +
> +	/* Start ADC Conversion using fast command (overwrites ADC_MODE[1:0] = 11) */
> +	ret = mcp3564_fast_cmd(adc, MCP3564_FASTCMD_START);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Check if the conversion is ready. If not, wait a little bit, and
> +	 * in case of timeout exit with an error.
> +	 */
> +	ret = read_poll_timeout(mcp3564_read_8bits, ret_read,
> +				ret_read || !(tmp & MCP3564_DATA_READY_MASK),
> +				20000, MCP3564_DATA_READY_TIMEOUT_MS * 1000, true,
> +				adc, MCP3564_IRQ, &tmp);
> +
> +	/* failed to read status register */
> +	if (ret_read)
> +		return ret;
> +
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	if (tmp & MCP3564_DATA_READY_MASK)
> +		/* failing to finish conversion */
> +		return -EBUSY;
> +
> +	ret = mcp3564_read_32bits(adc, MCP3564_ADCDATA, val);
> +
> +	return ret;

	return mcp3..

> +}
> +

> +
> +static int mcp3564_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mcp3564_state *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (channel->output) {
> +			*val = mcp3564_burnout_avail[adc->burnout_mode][0];
> +			*val2 = mcp3564_burnout_avail[adc->burnout_mode][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +

I don't follow the locking logic currently. I expected to see protection
around this.

> +		ret = mcp3564_read_single_value(indio_dev, channel, val);
> +		if (ret)
> +			return -EINVAL;
> +		else
> +			return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		mutex_lock(&adc->lock);
> +		*val = adc->scale_tbls[adc->hwgain][0];
> +		*val2 = adc->scale_tbls[adc->hwgain][1];
> +		mutex_unlock(&adc->lock);
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = mcp3564_oversampling_avail[adc->oversampling];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val = adc->calib_bias;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val = adc->calib_scale;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

> +
> +static int mcp3564_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *channel, int val,
> +			     int val2, long mask)
> +{
> +	struct mcp3564_state *adc = iio_priv(indio_dev);
> +	int tmp;
> +	unsigned int hwgain;
> +	enum mcp3564_burnout burnout;
> +	int ret = 0;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (channel->output) {
> +			for (burnout = 0; burnout < MCP3564_MAX_BURNOUT_IDX; burnout++) {
> +				if (val == mcp3564_burnout_avail[burnout][0] &&
> +				    val2 == mcp3564_burnout_avail[burnout][1])
> +					break;
> +			}
> +
> +			if (burnout == MCP3564_MAX_BURNOUT_IDX)
> +				return -EINVAL;
> +
> +			if (burnout == adc->burnout_mode)
> +				return ret;
> +
> +			mutex_lock(&adc->lock);
> +			ret = mcp3564_update_8bits(adc, MCP3564_CONFIG0,
> +						   MCP3564_CS_SEL_MASK,
> +						   MCP3564_CS_SEL_SET(burnout));
> +
> +			if (ret)
> +				dev_err(&indio_dev->dev, "Failed to configure burnout current\n");
> +			else
> +				adc->burnout_mode = burnout;
> +			break;
> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
> +			return -EINVAL;
> +
> +		mutex_lock(&adc->lock);
> +		ret = mcp3564_write_24bits(adc, MCP3564_OFFSETCAL, val);
> +		if (!ret)
> +			adc->calib_bias = val;
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
> +			return -EINVAL;
> +
> +		if (adc->calib_scale == val)
> +			return ret;
> +
> +		mutex_lock(&adc->lock);
> +		ret = mcp3564_write_24bits(adc, MCP3564_GAINCAL, val);
> +		if (!ret)
> +			adc->calib_scale = val;
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		tmp = find_closest(val, mcp3564_oversampling_avail,
> +				   ARRAY_SIZE(mcp3564_oversampling_avail));
> +
> +		if (adc->oversampling == tmp)
> +			return ret;
> +
> +		mutex_lock(&adc->lock);
> +		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG1, MCP3564_OVERSPL_RATIO_MASK,
> +					   MCP3564_OVERSAMPLING_RATIO_SET(adc->oversampling));
> +		if (!ret)
> +			adc->oversampling = tmp;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		for (hwgain = 0; hwgain < MCP3564_MAX_PGA; hwgain++) {
> +			if (val == adc->scale_tbls[hwgain][0] &&
> +			    val2 == adc->scale_tbls[hwgain][1])
> +				break;
> +		}
> +
> +		if (hwgain == MCP3564_MAX_PGA)
> +			return -EINVAL;
> +
> +		if (hwgain == adc->hwgain)
> +			return ret;
> +
> +		mutex_lock(&adc->lock);
> +		/* Update GAIN in CONFIG2[5:3] -> GAIN[2:0]*/
> +		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2, MCP3564_HARDWARE_GAIN_MASK,
> +					   MCP3564_HARDWARE_GAIN_SET(hwgain));
> +		if (!ret)
> +			adc->hwgain = hwgain;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_unlock(&adc->lock);
Push the unlock up to the same level that you have the lock at.
You will get more code repetition but it will be easier to read.

> +
> +	return ret;
> +}

> +
> +static void mcp3564_disable_reg(void *reg)
> +{
> +	if (reg)
> +		regulator_disable(reg);

This shouldn't be registered this unless reg is true.
So check shouldn't be needed.

> +}
> +

> +static int mcp3564_config(struct iio_dev *indio_dev)
> +{
> +	struct mcp3564_state *adc = iio_priv(indio_dev);
> +	struct device *dev = &adc->spi->dev;
> +	u8 tmp_reg;
> +	u16 tmp_u16;
> +	enum mcp3564_ids ids;
> +	int ret = 0;
> +	unsigned int tmp = 0x01;
> +
> +	/*
> +	 * The address is set on a per-device basis by fuses in the factory,
> +	 * configured on request. If not requested, the fuses are set for 0x1.
> +	 * The device address is part of the device markings to avoid
> +	 * potential confusion. This address is coded on two bits, so four possible
> +	 * addresses are available when multiple devices are present on the same
> +	 * SPI bus with only one Chip Select line for all devices.
> +	 */
> +	device_property_read_u32(dev, "microchip,hw-device-address", &tmp);
> +
> +	if (tmp > 3) {
> +		dev_err_probe(dev, tmp,
> +			      "invalid device address. Must be in range 0-3.\n");
> +		return -EINVAL;
> +	}
> +
> +	adc->dev_addr = 0xff & tmp;

device_property_read_u8() and no mask? though it can't be bigger than 3 anyway..


> +
> +	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
> +
> +	ret = mcp3564_read_8bits(adc, MCP3564_RESERVED_C, &tmp_reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (tmp_reg) {
> +	case MCP3564_REG_C_DEFAULT:
> +		adc->has_vref = false;
> +		break;
> +	case MCP3564R_REG_C_DEFAULT:
> +		adc->has_vref = true;
> +		break;
> +	default:
> +		dev_err_probe(dev, tmp_reg, "Unknown chip found\n");
> +		return -EINVAL;

At this point normal thing to do is dev_info() to moan that we don't konw what
it is, but then carry on on basis that we are probably looking at a dt-binding
that is using fallback compatible to deal with some newer part number.
So we tend to just trust the firmware if this happens.

Obviously if we can identify the part in the driver we should always do
so but sometimes the driver is older than the device.

> +	}
> +
> +	ret = mcp3564_read_16bits(adc, MCP3564_RESERVED_E, &tmp_u16);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (tmp_u16 & MCP3564_HW_ID_MASK) {
> +	case MCP3461_HW_ID:
> +		if (adc->has_vref)
> +			ids = mcp3461r;
> +		else
> +			ids = mcp3461;
> +		break;
> +	case MCP3462_HW_ID:
> +		if (adc->has_vref)
> +			ids = mcp3462r;
> +		else
> +			ids = mcp3462;
> +		break;
> +	case MCP3464_HW_ID:
> +		if (adc->has_vref)
> +			ids = mcp3464r;
> +		else
> +			ids = mcp3464;
> +		break;
> +	case MCP3561_HW_ID:
> +		if (adc->has_vref)
> +			ids = mcp3561r;
> +		else
> +			ids = mcp3561;
> +		break;
...

Jonathan
