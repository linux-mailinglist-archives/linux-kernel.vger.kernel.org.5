Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291D878B2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjH1OQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjH1OQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5432F103;
        Mon, 28 Aug 2023 07:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E3762880;
        Mon, 28 Aug 2023 14:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31045C433C8;
        Mon, 28 Aug 2023 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693232173;
        bh=tY2WazLm1HAd7r/wxr1o+Gku4dnYppTMAwSRYkb5lE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MbshX8XRElXt6xYNteDCAVnIzgvTERuDeqzOlWcRan883F4f+h9D4UufXAFtAKKvH
         25sTBTeD/dtTDHHUM8sGEcBjaQQrrz1d+6xsEDkuxL+zNCZ7um2HYYrkQfL/sXFYxr
         gCYcRG8F8UPTM5PAPYTmMFdeYMeIkwlvoHMf1EQJ8yHdpCiW1FMS9qnlBSCy54lhqx
         wlw5qDPUfVDXivlV5H0iT/jcnM6G1GoWWNn673A4S53JgxkoFTI1ugsnJe+xJfLE8X
         Oredjp65Ac8CJ1VXJiRnq8nTgZS9xvrdBN2+hXyOnp5cz3IYqZ31v2d2ghM4UGaxpL
         /YWKT0RsB+fvw==
Date:   Mon, 28 Aug 2023 15:16:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230828151631.6a60282b@jic23-huawei>
In-Reply-To: <20230818165750.55406-3-marius.cristea@microchip.com>
References: <20230818165750.55406-1-marius.cristea@microchip.com>
        <20230818165750.55406-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 19:57:50 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the iio driver for Microchip family of 153.6 ksps,
> Low-Noise 16/24-Bit Delta-Sigma ADCs with an SPI interface
> (Microchip's  MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> MCP3562R and MCP3564R analog to digital converters).
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

Hi Marius,

A few more things came up when I was reading this version.
See inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index e07e4a3e6237..91f713af574f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_MAX1363) +=3D max1363.o
>  obj-$(CONFIG_MAX9611) +=3D max9611.o
>  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
>  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> +obj-$(CONFIG_MCP3564) +=3D mcp3564.o
>  obj-$(CONFIG_MCP3911) +=3D mcp3911.o
>  obj-$(CONFIG_MEDIATEK_MT6360_ADC) +=3D mt6360-adc.o
>  obj-$(CONFIG_MEDIATEK_MT6370_ADC) +=3D mt6370-adc.o
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> new file mode 100644
> index 000000000000..8c5649781093
> --- /dev/null
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -0,0 +1,1527 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP356X/MCP356XR and MCP346X/MCP346XR series ADC chip =
family
> + *
> + * Copyright (C) 2022-2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Marius Cristea <marius.cristea@microchip.com>
> + *
> + * Datasheet for MCP3561, MCP3562, MCP3564 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/Produ=
ctDocuments/DataSheets/MCP3561-2-4-Family-Data-Sheet-DS20006181C.pdf
> + * Datasheet for MCP3561R, MCP3562R, MCP3564R can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/Produ=
ctDocuments/DataSheets/MCP3561_2_4R-Data-Sheet-DS200006391C.pdf
> + * Datasheet for MCP3461, MCP3462, MCP3464 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/Produ=
ctDocuments/DataSheets/MCP3461-2-4-Two-Four-Eight-Channel-153.6-ksps-Low-No=
ise-16-Bit-Delta-Sigma-ADC-Data-Sheet-20006180D.pdf
> + * Datasheet for MCP3461R, MCP3462R, MCP3464R can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/Produ=
ctDocuments/DataSheets/MCP3461-2-4R-Family-Data-Sheet-DS20006404C.pdf
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

> +#define MCP3564_CONFIG2_REG		0x03
> +#define MCP3564_CONFIG2_AZ_REF_MASK		BIT(1)
> +#define MCP3564_CONFIG2_AZ_REF_SET(x)		FIELD_PREP(MCP3564_CONFIG2_AZ_REF=
_MASK, (x))
> +#define MCP3564_CONFIG2_AZ_MUX_MASK		BIT(2)
> +#define MCP3564_CONFIG2_AZ_MUX_SET(x)		FIELD_PREP(MCP3564_CONFIG2_AZ_MUX=
_MASK, (x))
> +
> +#define MCP3564_CONFIG2_HARDWARE_GAIN_MASK	GENMASK(5, 3)
> +#define MCP3564_CONFIG2_HARDWARE_GAIN_SET(x)	FIELD_PREP(MCP3564_CONFIG2_=
HARDWARE_GAIN_MASK, (x))
I don't find the GAIN_SET() macros to be more readable than FIELD_PREP used=
 directly
as the MASK naming makes it clear what is being set.

So I would drop all these in favour of inline use of FIELD_PREP

> +#define MCP3564_DEFAULT_HARDWARE_GAIN		0x01
> +#define MCP3564_CONFIG2_BOOST_CURRENT_MASK	GENMASK(7, 6)
> +#define MCP3564_CONFIG2_BOOST_CURRENT_SET(x)	FIELD_PREP(MCP3564_CONFIG2_=
BOOST_CURRENT_MASK, (x))
> +

...

> +#define MCP3464_CONFIG3_DATA_FORMAT_MASK	GENMASK(5, 4)
> +#define MCP3564_CONFIG3_DATA_FORMAT_SET(x)	FIELD_PREP(MCP3464_CONFIG3_DA=
TA_FORMAT_MASK, (x))
> +
> +/* 0b11 =3D Continuous Conversion mode or continuous conversion cycle in=
 SCAN mode. */
> +#define MCP3464_CONFIG3_CONV_MODE_CONTINUOUS		3

Values defined - so need for them in the comment which is otherwise useful.

> +/*
> + * 0b10 =3D One-shot conversion or one-shot cycle in SCAN mode. It sets =
ADC_MODE[1:0] to =E2=80=9810=E2=80=99
> + *        (standby) at the end of the conversion or at the end of the co=
nversion cycle in SCAN mode.
> + */
> +#define MCP3464_CONFIG3_CONV_MODE_ONE_SHOT_STANDBY	2
> +/*
> + * 0b0x =3D One-shot conversion or one-shot cycle in SCAN mode. It sets =
ADC_MODE[1:0] to =E2=80=980x=E2=80=99 (ADC
> + *        Shutdown) at the end of the conversion or at the end of the co=
nversion cycle in SCAN
> + *        mode (default).
> + */

> +#define MCP3564_CMD_HW_ADDR_MASK	GENMASK(7, 6)
> +#define MCP3564_CMD_HW_ADDR_SET(x)	FIELD_PREP(MCP3564_CMD_HW_ADDR_MASK, =
(x))
> +#define MCP3564_CMD_ADDR_MASK		GENMASK(5, 2)
> +#define MCP3564_CMD_ADDR_SET(x)		FIELD_PREP(MCP3564_CMD_ADDR_MASK, (x))

More cases where I'd like to see the FIELD_PREP() used directly not hidden =
in a macro.

> +
> +/*
> + * Current Source/Sink Selection Bits for Sensor Bias (source on VIN+/si=
nk on VIN-)
> + */
> +static const int mcp3564_burnout_avail[][2] =3D {
> +	[MCP3564_CONFIG0_CS_SEL_0_0_uA] =3D {0, 0},
> +	[MCP3564_CONFIG0_CS_SEL_0_9_uA] =3D {0, 900},
> +	[MCP3564_CONFIG0_CS_SEL_3_7_uA] =3D {0, 3700},
> +	[MCP3564_CONFIG0_CS_SEL_15_uA] =3D {0, 15000}
> +};

Trivial, but I'd like brackets after the { and before the } as makes things=
 a tiny bit
more readable to my eye.

> +/**
> + * struct mcp3564_chip_info - chip specific data
> + * @name:		device name
> + * @num_channels:	number of channels
> + * @resolution:		ADC resolution
> + * @has_vref:		does the hardware has an internal voltage reference?

have

> + */
> +struct mcp3564_chip_info {
> +	const char	*name;
> +	unsigned int	num_channels;
> +	unsigned int	resolution;
> +	bool		has_vref;
> +};
> +

...


> +
> +static int mcp3564_write_8bits(struct mcp3564_state *adc, u8 reg, u8 val)
> +{
> +	u8 tmp;
> +	u8 tx_buf[2];
> +
> +	tx_buf[0] =3D mcp3564_cmd_write(adc->dev_addr, reg);
> +	tx_buf[1] =3D val;
> +
> +	return spi_write_then_read(adc->spi, tx_buf, sizeof(tx_buf), &tmp, 0);
as below.


> +}
> +
> +static int mcp3564_write_24bits(struct mcp3564_state *adc, u8 reg, u32 v=
al)
> +{
> +	u8 tmp;
> +	__be32 val_be;
> +
> +	val |=3D (mcp3564_cmd_write(adc->dev_addr, reg) << 24);
> +	val_be =3D cpu_to_be32(val);
> +
> +	return spi_write_then_read(adc->spi, &val_be, sizeof(val_be), &tmp, 0);

as below.

> +}
> +
> +static int mcp3564_fast_cmd(struct mcp3564_state *adc, u8 fast_cmd)
> +{
> +	u8 val;
> +	u8 tmp;
> +
> +	val =3D MCP3564_CMD_HW_ADDR_SET(adc->dev_addr) | MCP3564_CMD_ADDR_SET(f=
ast_cmd);
> +
> +	return spi_write_then_read(adc->spi, &val, 1, &tmp, 0);

No need for tmp. I'm fairly sure spi_write_then_read is fine with NULL buff=
ers.

> +}
> +
> +static int mcp3564_update_8bits(struct mcp3564_state *adc, u8 reg, u32 m=
ask, u8 val)
> +{
> +	u8 tmp;
> +	int ret;
> +
> +	ret =3D mcp3564_read_8bits(adc, reg, &tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	val &=3D mask;
This looks wrong - would expect this to be
        val &=3D ~mask; // wipe out the bits in mask.
> +	val |=3D tmp & ~mask;
and
	val |=3D tmp & mask;  //write the bitss in mask.

Is the mask the inverse ?  At first glance it doesn't seem to be.

> +	ret =3D mcp3564_write_8bits(adc, reg, val);
> +
> +	return ret;

return mcp...

> +}


...



> +
> +static int mcp3564_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp3564_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *channel, int val,
> +			     int val2, long mask)
> +{
> +	struct mcp3564_state *adc =3D iio_priv(indio_dev);
> +	int tmp;
> +	unsigned int hwgain;
> +	enum mcp3564_burnout burnout;
> +	int ret =3D 0;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!channel->output)
> +			return -EINVAL;
> +
> +		for (burnout =3D 0; burnout < MCP3564_MAX_BURNOUT_IDX; burnout++) {
> +			if (val =3D=3D mcp3564_burnout_avail[burnout][0] &&
> +			    val2 =3D=3D mcp3564_burnout_avail[burnout][1])
> +				break;
> +		}
> +
> +		if (burnout =3D=3D MCP3564_MAX_BURNOUT_IDX)
> +			return -EINVAL;
> +
> +		if (burnout =3D=3D adc->burnout_mode)
> +			return ret;
> +
> +		mutex_lock(&adc->lock);
> +		ret =3D mcp3564_update_8bits(adc, MCP3564_CONFIG0_REG,
> +					   MCP3564_CONFIG0_CS_SEL_MASK,
> +					   MCP3564_CONFIG0_CS_SEL_SET(burnout));
As above - I'd find this clearer with FIELD_PREP here
					   FIELD_PREP(MCP3564_CONFIG0_CS_SEL_MASK, burnout));

> +
> +		if (ret)
> +			dev_err(&indio_dev->dev, "Failed to configure burnout current\n");
> +		else
> +			adc->burnout_mode =3D burnout;
> +		mutex_unlock(&adc->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
> +			return -EINVAL;
> +
> +		mutex_lock(&adc->lock);
> +		ret =3D mcp3564_write_24bits(adc, MCP3564_OFFSETCAL_REG, val);
> +		if (!ret)
> +			adc->calib_bias =3D val;
> +		mutex_unlock(&adc->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val < mcp3564_calib_scale[0] && val > mcp3564_calib_scale[2])
> +			return -EINVAL;
> +
> +		if (adc->calib_scale =3D=3D val)
> +			return ret;
> +
> +		mutex_lock(&adc->lock);
> +		ret =3D mcp3564_write_24bits(adc, MCP3564_GAINCAL_REG, val);
> +		if (!ret)
> +			adc->calib_scale =3D val;
> +		mutex_unlock(&adc->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		tmp =3D find_closest(val, mcp3564_oversampling_avail,
> +				   ARRAY_SIZE(mcp3564_oversampling_avail));
> +
> +		if (adc->oversampling =3D=3D tmp)
> +			return ret;
> +
> +		mutex_lock(&adc->lock);
> +		ret =3D mcp3564_update_8bits(adc, MCP3564_CONFIG1_REG,
> +					   MCP3564_CONFIG1_OVERSPL_RATIO_MASK,
> +					   MCP3564_CONFIG1_OVERSPL_RATIO_SET(adc->oversampling));
> +		if (!ret)
> +			adc->oversampling =3D tmp;
> +		mutex_unlock(&adc->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		for (hwgain =3D 0; hwgain < MCP3564_MAX_PGA; hwgain++) {
> +			if (val =3D=3D adc->scale_tbls[hwgain][0] &&
> +			    val2 =3D=3D adc->scale_tbls[hwgain][1])
> +				break;
> +		}
> +
> +		if (hwgain =3D=3D MCP3564_MAX_PGA)
> +			return -EINVAL;
> +
> +		if (hwgain =3D=3D adc->hwgain)
> +			return ret;
> +
> +		mutex_lock(&adc->lock);
> +		/* Update GAIN in CONFIG2[5:3] -> GAIN[2:0]*/

I'd drop this comment as this is clear from teh code that follows and comme=
nts
rot over time ;)


> +		ret =3D mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG,
> +					   MCP3564_CONFIG2_HARDWARE_GAIN_MASK,
> +					   MCP3564_CONFIG2_HARDWARE_GAIN_SET(hwgain));
As above.=20
> +		if (!ret)
> +			adc->hwgain =3D hwgain;
> +
> +		mutex_unlock(&adc->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +
> +static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
> +{
> +	struct mcp3564_state *adc =3D iio_priv(indio_dev);
> +	struct device *dev =3D &adc->spi->dev;
> +	struct iio_chan_spec *channels;
> +	struct fwnode_handle *child;
> +	struct iio_chan_spec chanspec =3D mcp3564_channel_template;
> +	struct iio_chan_spec temp_chanspec =3D mcp3564_temp_channel_template;
> +	struct iio_chan_spec burnout_chanspec =3D mcp3564_burnout_channel_templ=
ate;
> +	int chan_idx =3D 0;
> +	unsigned int num_ch;
> +	u32 inputs[2];
> +	const char *node_name;
> +	const char *label;
> +	int ret;
> +
> +	num_ch =3D device_get_child_node_count(dev);
> +	if (num_ch =3D=3D 0)
> +		return dev_err_probe(&indio_dev->dev, -ENODEV,
> +				     "FW has no channels defined\n");
> +
> +	/* Reserve space for burnout and temperature channel */
> +	num_ch +=3D 2;
> +
> +	if (num_ch > adc->chip_info->num_channels) {
> +		return dev_err_probe(dev, -EINVAL, "Too many channels %d > %d\n",
> +				     num_ch, adc->chip_info->num_channels);

As below. My interpretation kernel style tells me that this doesn't need br=
ackets.

> +	}
> +
> +	channels =3D devm_kcalloc(dev, num_ch, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
> +
> +	device_for_each_child_node(dev, child) {
> +		node_name =3D fwnode_get_name(child);
> +
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			ret =3D fwnode_property_read_u32_array(child,
> +							     "diff-channels",
> +							     inputs,
> +							     ARRAY_SIZE(inputs));
> +			chanspec.differential =3D 1;
> +		} else {
> +			ret =3D fwnode_property_read_u32(child, "reg", &inputs[0]);
> +
> +			chanspec.differential =3D 0;
> +			inputs[1] =3D MCP3564_AGND;
> +		}
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		if (inputs[0] > MCP3564_INTERNAL_VCM ||
> +		    inputs[1] > MCP3564_INTERNAL_VCM) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(&indio_dev->dev, -EINVAL,
> +					     "Channel index > %d, for %s\n",
> +					     MCP3564_INTERNAL_VCM + 1,
> +					     node_name);
> +		}
> +
> +		chanspec.address =3D (inputs[0] << 4) | inputs[1];
> +		chanspec.channel =3D inputs[0];
> +		chanspec.channel2 =3D inputs[1];
> +		chanspec.scan_index =3D chan_idx;
> +
> +		if (fwnode_property_present(child, "label")) {
> +			fwnode_property_read_string(child, "label", &label);
> +			adc->labels[chan_idx] =3D label;
> +		}
> +
> +		channels[chan_idx] =3D chanspec;
> +		chan_idx++;
> +	}
> +
> +	/* Add burnout current channel */
> +	burnout_chanspec.scan_index =3D chan_idx;
> +	channels[chan_idx] =3D burnout_chanspec;
> +	adc->labels[chan_idx] =3D mcp3564_channel_labels[0];
> +	chanspec.scan_index =3D chan_idx;
> +	chan_idx++;
> +
> +	/* Add temperature channel */
> +	temp_chanspec.scan_index =3D chan_idx;
> +	channels[chan_idx] =3D temp_chanspec;
> +	adc->labels[chan_idx] =3D mcp3564_channel_labels[1];
> +	chan_idx++;
> +
> +	indio_dev->num_channels =3D chan_idx;
> +	indio_dev->channels =3D channels;
> +
> +	return 0;
> +}

...

> +
> +static int mcp3564_config(struct iio_dev *indio_dev)
> +{
> +	struct mcp3564_state *adc =3D iio_priv(indio_dev);
> +	struct device *dev =3D &adc->spi->dev;
> +	const struct spi_device_id *dev_id;
> +	u8 tmp_reg;
> +	u16 tmp_u16;
> +	enum mcp3564_ids ids;
> +	int ret =3D 0;
> +	unsigned int tmp =3D 0x01;
> +	bool err =3D true;
> +
> +	/*
> +	 * The address is set on a per-device basis by fuses in the factory,
> +	 * configured on request. If not requested, the fuses are set for 0x1.
> +	 * The device address is part of the device markings to avoid
> +	 * potential confusion. This address is coded on two bits, so four poss=
ible
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
> +	adc->dev_addr =3D MCP3564_HW_ADDR_MASK & tmp;

FIELD_GET() as then we don't have to care if the mask goes to bit 0

> +
> +	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
> +
> +	ret =3D mcp3564_read_8bits(adc, MCP3564_RESERVED_C_REG, &tmp_reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (tmp_reg) {
> +	case MCP3564_C_REG_DEFAULT:
> +		adc->has_vref =3D false;
> +		break;
> +	case MCP3564R_C_REG_DEFAULT:
> +		adc->has_vref =3D true;
> +		break;
> +	default:
> +		dev_info(dev, "Unknown chip found: %d\n", tmp_reg);
> +		err =3D true;
> +	}
> +
> +	if (!err) {
> +		ret =3D mcp3564_read_16bits(adc, MCP3564_RESERVED_E_REG, &tmp_u16);
> +		if (ret < 0)
> +			return ret;
> +
> +		switch (tmp_u16 & MCP3564_HW_ID_MASK) {
> +		case MCP3461_HW_ID:
> +			if (adc->has_vref)
> +				ids =3D mcp3461r;
> +			else
> +				ids =3D mcp3461;
> +			break;
> +		case MCP3462_HW_ID:
> +			if (adc->has_vref)
> +				ids =3D mcp3462r;
> +			else
> +				ids =3D mcp3462;
> +			break;
> +		case MCP3464_HW_ID:
> +			if (adc->has_vref)
> +				ids =3D mcp3464r;
> +			else
> +				ids =3D mcp3464;
> +			break;
> +		case MCP3561_HW_ID:
> +			if (adc->has_vref)
> +				ids =3D mcp3561r;
> +			else
> +				ids =3D mcp3561;
> +			break;
> +		case MCP3562_HW_ID:
> +			if (adc->has_vref)
> +				ids =3D mcp3562r;
> +			else
> +				ids =3D mcp3562;
> +			break;
> +		case MCP3564_HW_ID:
> +			if (adc->has_vref)
> +				ids =3D mcp3564r;
> +			else
> +				ids =3D mcp3564;
> +			break;
> +		default:
> +			dev_info(dev, "Unknown chip found: %d\n", tmp_u16);
> +			err =3D true;
> +		}
> +	}
> +
> +	if (err) {
> +		/*
> +		 * If failed to identify the hardware based on internal registers,
> +		 * try using fallback compatible in device tree to deal with some newe=
r part number.
> +		 */
> +		adc->chip_info =3D spi_get_device_match_data(adc->spi);
> +		if (!adc->chip_info) {
> +			dev_id =3D spi_get_device_id(adc->spi);
> +			adc->chip_info =3D (const struct mcp3564_chip_info *)dev_id->driver_d=
ata;
> +		}
> +
> +		adc->has_vref =3D adc->chip_info->has_vref;
> +	} else {
> +		adc->chip_info =3D &mcp3564_chip_infos_tbl[ids];
> +	}
> +
> +	dev_dbg(dev, "Found %s chip\n", adc->chip_info->name);
> +
> +	adc->vref =3D devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(adc->vref)) {
> +		if (IS_ERR(adc->vref)) {
I guess this is meant to be an ENODEV check.=20

I would suggest flipping the logic so the error return is out of line but t=
he rest isn't.


		if (PTR_ERR(adc->vref) !=3D -ENODEV)
			return dev_err_probe(...);
//side note that you are inconsistent on brackets around a single line stat=
ement with
// a line break.  None of them need brackets.


		if (!adc->has_vref)=20
			return dev_err_probe(..);

		adc->vref =3D NULL;
		dev_dbg();
	} else {

		...
	=09
> +			/* Check if chip has internal vref */
> +			if (!adc->has_vref)
> +				return dev_err_probe(dev, PTR_ERR(adc->vref),
> +					     "Unknown Vref\n");
> +			adc->vref =3D NULL;
> +			dev_dbg(dev, "%s: Using internal Vref\n", __func__);
> +		} else {
> +			return dev_err_probe(dev, PTR_ERR(adc->vref),
> +					     "failed to get regulator\n");
> +		}
> +	} else {
> +		ret =3D regulator_enable(adc->vref);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_add_action_or_reset(dev, mcp3564_disable_reg,
> +					       adc->vref);
> +		if (ret)
> +			return ret;
> +
> +		dev_dbg(dev, "%s: Using External Vref\n", __func__);
> +
> +		ret =3D regulator_get_voltage(adc->vref);
> +		if (ret < 0) {
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read vref regulator\n");

Brackets not needed.  Consistency matters more than whether you do or do no=
t have
brackets as the multiline because of a line break case may not be well cove=
red
by the kernel style docs.

> +		}
> +
> +		adc->vref_mv =3D ret / MILLI;
> +	}
> +
> +	ret =3D mcp3564_parse_fw_children(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Command sequence that ensures a recovery with the desired settings
> +	 * in any cases of loss-of-power scenario (Full Chip Reset):
> +	 *  - Write LOCK register to 0xA5
> +	 *  - Write IRQ register to 0x03
> +	 *  - Send "Device Full Reset" fast command
> +	 *  - Wait 1ms for "Full Reset" to complete
> +	 */
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_LOCK_REG, MCP3564_LOCK_WRITE_A=
CCESS_PASSWORD);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_IRQ_REG, 0x03);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_fast_cmd(adc, MCP3564_FASTCMD_RESET);
> +	if (ret)
> +		return ret;
> +
> +	mdelay(1);=20

Always good to have a doc reference for delays - sometimes they turn out to=
 be a possible
cause of instability - so good to know if this is much larger than the spec=
 requires
or rather close to whatever it says.

> +
> +	/* set a gain of 1x for GAINCAL */
> +	ret =3D mcp3564_write_24bits(adc, MCP3564_GAINCAL_REG, MCP3564_DEFAULT_=
GAINCAL);
> +	if (ret)
> +		return ret;
> +
> +	adc->calib_scale =3D MCP3564_DEFAULT_GAINCAL;
> +
> +	ret =3D mcp3564_write_24bits(adc, MCP3564_OFFSETCAL_REG, MCP3564_DEFAUL=
T_OFFSETCAL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_24bits(adc, MCP3564_TIMER_REG, MCP3564_TIMER_DEFA=
ULT_VALUE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_24bits(adc, MCP3564_SCAN_REG,
> +				   MCP3564_SCAN_DELAY_TIME_SET(MCP3564_NO_DELAY) |
> +				   MCP3564_SCAN_CH_SEL_SET(MCP3564_SCAN_DEFAULT_VALUE));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_MUX_REG, MCP3564_MUX_SET(MCP35=
64_CH0, MCP3564_CH1));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_IRQ_REG,
> +				  FIELD_PREP(MCP3464_EN_FASTCMD_MASK, 1) |
> +				  FIELD_PREP(MCP3464_EN_STP_MASK, 1));
> +	if (ret)
> +		return ret;
> +
> +	tmp_reg =3D MCP3564_CONFIG3_CONV_MODE_SET(MCP3464_CONFIG3_CONV_MODE_ONE=
_SHOT_STANDBY);
> +	tmp_reg |=3D MCP3564_CONFIG3_DATA_FORMAT_SET(MCP3464_CONFIG3_DATA_FMT_3=
2B_SGN_EXT);
> +	tmp_reg |=3D MCP3464_CONFIG3_EN_OFFCAL_MASK;
> +	tmp_reg |=3D MCP3464_CONFIG3_EN_GAINCAL_MASK;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_CONFIG3_REG, tmp_reg);
> +	if (ret)
> +		return ret;
> +
> +	tmp_reg =3D MCP3564_CONFIG2_BOOST_CURRENT_SET(MCP3564_BOOST_CURRENT_x1_=
00);
> +	tmp_reg |=3D MCP3564_CONFIG2_HARDWARE_GAIN_SET(0x01);
> +	tmp_reg |=3D MCP3564_CONFIG2_AZ_MUX_SET(1);
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_CONFIG2_REG, tmp_reg);
> +	if (ret)
> +		return ret;
> +
> +	adc->hwgain =3D 0x01;
> +	adc->auto_zeroing_mux =3D true;
> +	adc->auto_zeroing_ref =3D false;
> +	adc->current_boost_mode =3D MCP3564_BOOST_CURRENT_x1_00;
> +
> +	tmp_reg =3D MCP3564_CONFIG1_OVERSPL_RATIO_SET(MCP3564_OVERSAMPLING_RATI=
O_98304);
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_CONFIG1_REG, tmp_reg);
> +	if (ret)
> +		return ret;
> +
> +	adc->oversampling =3D MCP3564_OVERSAMPLING_RATIO_98304;
> +
> +	tmp_reg =3D MCP3564_CONFIG0_ADC_MODE_MASK_SET(MCP3564_ADC_MODE_STANDBY);
> +	tmp_reg |=3D MCP3564_CONFIG0_CS_SEL_SET(MCP3564_CONFIG0_CS_SEL_0_0_uA);
> +	tmp_reg |=3D MCP3564_CONFIG0_CLK_SEL_SET(MCP3564_CONFIG0_USE_INT_CLK);
> +	tmp_reg |=3D MCP3456_CONFIG0_BIT6_DEFAULT;
> +
> +	if (!adc->vref) {
> +		tmp_reg |=3D MCP3564_CONFIG0_VREF_SET(1);
> +		adc->vref_mv =3D MCP3564R_INT_VREF_MV;
> +	}
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_CONFIG0_REG, tmp_reg);
> +
> +	adc->burnout_mode =3D MCP3564_CONFIG0_CS_SEL_0_0_uA;
> +
> +	return ret;
> +}
> +
> +static IIO_DEVICE_ATTR(auto_zeroing_ref_enable, 0644,
> +		       mcp3564_auto_zeroing_ref_show,
> +		       mcp3564_auto_zeroing_ref_store, 0);
> +
> +static IIO_DEVICE_ATTR(auto_zeroing_mux_enable, 0644,
> +		       mcp3564_auto_zeroing_mux_show,
> +		       mcp3564_auto_zeroing_mux_store, 0);
> +
> +//#define MCP3564_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)

This wants deleting...




