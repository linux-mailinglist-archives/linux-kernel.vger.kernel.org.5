Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D477112C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHER7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHER7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F8F183;
        Sat,  5 Aug 2023 10:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1785C60DB5;
        Sat,  5 Aug 2023 17:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE08C433C7;
        Sat,  5 Aug 2023 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691258347;
        bh=qtciY70Elxd0E98RlHJnsELzA1xoPRn5X6dSzgvOaS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jg1TaL7XOG5bEIRiaEooawwe+un1J9I8lEPm0/u4XHkQvTrKj2C7MU/AcoW1Ge0p5
         y6YPDMK96x4B7fhN90O4uMLbIkS/MDIDgKCyqK6Wf7TgQgWWJEJ1IbtB6o0kBvsI9O
         ac9n118ifhdNsFFecqxuTyULDh8Uys3hEjRMd4kPwMo38RerfFt9hIeoDIJHl+XPx0
         79jptu9Ulks1VwO46U87pfkYpvUqa/B2W3VIRU0N3Kz8e7s9CyYhmJBaUCbruEnSz7
         Yk6tdjvx9uMykGpFGDv5Ugp0jceU4yiSZvVYi7SCNU3K78qtyGVVTFqtOAY/iaQxcJ
         1MHt/2lZDqbbw==
Date:   Sat, 5 Aug 2023 18:59:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230805185900.2441a20e@jic23-huawei>
In-Reply-To: <20230804142820.89593-3-marius.cristea@microchip.com>
References: <20230804142820.89593-1-marius.cristea@microchip.com>
        <20230804142820.89593-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 17:28:20 +0300
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
Hi Marius

Various things inline.  Driver is coming together nicely so mostly
suggestions on how to tidy things up a little + give an easier to
review / maintain driver.

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-mcp3564     |   53 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/mcp3564.c                     | 1541 +++++++++++++++++
>  5 files changed, 1615 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
>  create mode 100644 drivers/iio/adc/mcp3564.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564 b/Docume=
ntation/ABI/testing/sysfs-bus-iio-adc-mcp3564
> new file mode 100644
> index 000000000000..feed2f596537
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

Units?  Should be  mA given that is what we use for other current attributes
in IIO.

This one may cause us problems with generality of the description if we reu=
se
if for other devices (and hence move it to the more general files), but we
can figure this out at the time.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/boost_current_available
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible values for
> +		the current biasing circuit of the Delta-Sigma modulator.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/auto_zeroing_mux_enable
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
> +What:		/sys/bus/iio/devices/iio:deviceX/auto_zeroing_ref_enable
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to enable the chopping algorithm for the=20
> +		internal voltage reference buffer. This setting has no effect
> +		when external voltage reference is selected.
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

...


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
> index 000000000000..60d6a803c0c2
> --- /dev/null
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -0,0 +1,1541 @@
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
> + *
Last blank line here adds nothing so I'd drop it.

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
> +
> +#define MCP3564_ADCDATA		0x00

Always good to name register addresses so it is clear what they are.
_REG or _ADDR or similar.

> +#define MCP3564_CONFIG0		0x01
> +#define MCP3564_CONFIG1		0x02
> +#define MCP3564_CONFIG2		0x03
> +#define MCP3564_CONFIG3		0x04
> +#define MCP3564_IRQ		0x05
> +#define MCP3564_MUX		0x06
> +#define MCP3564_SCAN		0x07
> +#define MCP3564_TIMER		0x08
> +#define MCP3564_OFFSETCAL	0x09
> +#define MCP3564_GAINCAL		0x0A
> +#define MCP3564_RESERVED_B	0x0B
> +#define MCP3564_RESERVED_C	0x0C
> +#define MCP3564_LOCK		0x0D
> +#define MCP3564_RESERVED_E	0x0E
> +#define MCP3564_CRCCFG		0x0F
> +
Lots of the comments that follow apply across all the
register field definitions.  Main theme is I'm looking for
explicit naming of everything and minimal number of defines.

> +/*
> + * CONFIG 3 Register - Conversion Mode Selection
> + * 0b11 =3D Continuous Conversion mode or continuous conversion cycle in=
 SCAN mode.
> + * 0b10 =3D One-shot conversion or one-shot cycle in SCAN mode. It sets =
ADC_MODE[1:0] to =E2=80=9810=E2=80=99
> + *        (standby) at the end of the conversion or at the end of the co=
nversion cycle in SCAN mode.
> + * 0b0x =3D One-shot conversion or one-shot cycle in SCAN mode. It sets =
ADC_MODE[1:0] to =E2=80=980x=E2=80=99 (ADC
> + *        Shutdown) at the end of the conversion or at the end of the co=
nversion cycle in SCAN
> + *        mode (default).
> + */
> +#define MCP3464_CONV_MODE_CONTINUOUS		3
> +#define MCP3464_CONV_MODE_ONE_SHOT_STANDBY	2
> +#define MCP3464_CONV_MODE_ONE_SHOT_SHUTDOWN	0
> +#define MCP3464_CONV_MODE_MASK			GENMASK(7, 6)
> +#define MCP3564_CONV_MODE_SET(x)		((u8)FIELD_PREP(MCP3464_CONV_MODE_MASK=
, (x)))
> +
> +/*
> + * CONFIG 3 Register - ADC Output Data Format Selection
> + * 0b11 =3D 32-bit (25-bit right justified data + Channel ID):
> + *        CHID[3:0] + SGN extension (4 bits) + 24-bit ADC data.
> + *        It allows overrange with the SGN extension.

I'd put these immediately before each define rather than in a block up here.

> + * 0b10 =3D 32-bit (25-bit right justified data):
> + *        SGN extension (8-bit) + 24-bit ADC data.
> + *        It allows overrange with the SGN extension.
> + * 0b01 =3D 32-bit (24-bit left justified data):
> + *        24-bit ADC data + 0x00 (8-bit).
> + *        It does not allow overrange (ADC code locked to 0xFFFFFF or 0x=
800000).
> + * 0b00 =3D 24-bit (default ADC coding): 24-bit ADC data.
> + *        It does not allow overrange (ADC code locked to 0xFFFFFF or 0x=
800000).
> + */
> +#define MCP3456_DATA_FORMAT_32B_WITH_CH_ID	3
> +#define MCP3456_DATA_FORMAT_32B_SGN_EXT		2
> +#define MCP3456_DATA_FORMAT_32B_LEFT_JUSTIFIED	1
> +#define MCP3456_DATA_FORMAT_24B			0
> +#define MCP3464_DATA_FORMAT_MASK		GENMASK(5, 4)
I'd generally like to see the register name in these field names as well.
Perhaps

#define MCP3464_CONFIG3_DATA_FMT_...
as it makes it easy to see if thy are being written to the write registers.

Same for all other register fields.  Sometimes the code is a bit longer doi=
ng
this but it makes it easier to tell if there is a mismatch.

> +#define MCP3564_DATA_FORMAT_SET(x)		((u8)FIELD_PREP(MCP3464_DATA_FORMAT_=
MASK, (x)))
> +
> +#define MCP3464_CRC_FORMAT		BIT(3)
> +#define MCP3464_EN_CRCCOM		BIT(2)
> +#define MCP3464_EN_OFFCAL		BIT(1)
> +#define MCP3464_EN_GAINCAL		BIT(0)
> +
> +/* IRQ REGISTER */
> +#define MCP3564_DATA_READY_MASK		BIT(6)
> +#define MCP3564_CRCCFG_STATUS		BIT(5)

For consistency name these all _MASK as they are all fields that can have v=
alues 0 or 1 in them.

> +#define MCP3564_POR_STATUS		BIT(4)
> +#define MCP3464_IRQ_MODE_1		BIT(3)
> +#define MCP3464_IRQ_MODE_0		BIT(2)
> +#define MCP3464_EN_FASTCMD		BIT(1)
> +#define MCP3464_EN_STP			BIT(0)
> +
> +/* MULTIPLEXER (MUX) REGISTER */
> +#define MCP3564_MUX_VIN_P_MASK		GENMASK(7, 4)
> +#define MCP3564_MUX_VIN_N_MASK		GENMASK(3, 0)
> +#define MCP3564_MUX_SET(x, y)		((u8)FIELD_PREP(MCP3564_MUX_VIN_P_MASK, (=
x)) |	\
> +					 (u8)FIELD_PREP(MCP3564_MUX_VIN_N_MASK, (y)))

This one (unlike below) is probably worth having, but why are the casts nee=
ded?


> +/* OFFSETCAL REGISTER */
> +#define MCP3564_DEFAULT_OFFSETCAL	0
> +#define MCP3564_OFFSETCAL_MASK		GENMASK(23, 0)
> +#define MCP3564_OFFSETCAL_SET(x)	((u32)FIELD_PREP(MCP3564_OFFSETCAL_MASK=
, (x)))
> +
> +/* GAINCAL REGISTER */
You could move these up to next to the register definition.
A bit of playing with indenting can then be used to separate the fields from
the register itself. That tends to make things more self documenting so you=
 can
get rid of the comments and end up with tidier code.

e.g.

#define MCP3564_GAINCAL_REG		0x0A
#define   MCP3564_DEFAULT_GAINCAL		0x00800000
#define   MCP3564_GAINCAL_MASK			GENMASK(23, 0)


> +#define MCP3564_DEFAULT_GAINCAL		0x00800000
> +#define MCP3564_GAINCAL_MASK		GENMASK(23, 0)
> +#define MCP3564_GAINCAL_SET(x)		((u32)FIELD_PREP(MCP3564_GAINCAL_MASK, (=
x)))

Are these _SET macros worth having?
FIELD_PREP(MCP3565_GAINCAL_MASK, x) is pretty clear without needing a macro=
 to name it.

> +
> +
> +#define MCP3564_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)

For 3 uses?  I'd be tempted to just have them long hand



> +
> +static const struct iio_chan_spec_ext_info mcp3564_ext_info[] =3D {
> +	IIO_ENUM("boost_current", IIO_SHARED_BY_ALL, &mcp3564_current_boost_mod=
e_enum),
> +	{
> +		.name =3D "boost_current_available",
> +		.shared =3D IIO_SHARED_BY_ALL,
> +		.read =3D iio_enum_available_read,
> +		.private =3D (uintptr_t)&mcp3564_current_boost_mode_enum,
> +	},
> +	{}
	{ }

for consistency with some cases below.

> +};

> +static int mcp3564_read_single_value(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *channel,
> +				     int *val)
> +{
> +	struct mcp3564_state *adc =3D iio_priv(indio_dev);
> +	int ret;
> +	u8 tmp;
> +	int ret_read =3D 0;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_MUX, channel->address);
> +	if (ret)
> +		return ret;
> +
> +	/* Start ADC Conversion using fast command (overwrites ADC_MODE[1:0] =
=3D 11) */
> +	ret =3D mcp3564_fast_cmd(adc, MCP3564_FASTCMD_START);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Check if the conversion is ready. If not, wait a little bit, and
> +	 * in case of timeout exit with an error.
> +	 */
> +	ret =3D read_poll_timeout(mcp3564_read_8bits, ret_read,
> +				ret_read || !(tmp & MCP3564_DATA_READY_MASK),
> +				20000, MCP3564_DATA_READY_TIMEOUT_MS * 1000, true,
> +				adc, MCP3564_IRQ, &tmp);
> +
> +	/* failed to read status register */
> +	if (ret_read)
> +		return ret;

Probably want to to return ret_read in this case.

> +
> +	if (ret)
> +		return -ETIMEDOUT;

ret should be -ETIMEDOUT so just return ret and save anyone reading the doc=
s :)

> +
> +	if (tmp & MCP3564_DATA_READY_MASK)
> +		/* failing to finish conversion */
> +		return -EBUSY;
> +
> +	return mcp3564_read_32bits(adc, MCP3564_ADCDATA, val);
> +}

> +static int mcp3564_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mcp3564_state *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (channel->output) {
> +			mutex_lock(&adc->lock);
> +			*val =3D mcp3564_burnout_avail[adc->burnout_mode][0];
> +			*val2 =3D mcp3564_burnout_avail[adc->burnout_mode][1];
> +			mutex_unlock(&adc->lock);
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +
> +		ret =3D mcp3564_read_single_value(indio_dev, channel, val);
> +		if (ret)
> +			return -EINVAL;
> +		else

Drop the else.

> +			return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		mutex_lock(&adc->lock);
> +		*val =3D adc->scale_tbls[adc->hwgain][0];
> +		*val2 =3D adc->scale_tbls[adc->hwgain][1];
> +		mutex_unlock(&adc->lock);
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val =3D mcp3564_oversampling_avail[adc->oversampling];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val =3D adc->calib_bias;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val =3D adc->calib_scale;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

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
> +		if (channel->output) {

Flip logic to cut down on indent
		if (!channel->output)
			return -EINVAL;

		for (..

> +			for (burnout =3D 0; burnout < MCP3564_MAX_BURNOUT_IDX; burnout++) {
> +				if (val =3D=3D mcp3564_burnout_avail[burnout][0] &&
> +				    val2 =3D=3D mcp3564_burnout_avail[burnout][1])
> +					break;
> +			}
> +
> +			if (burnout =3D=3D MCP3564_MAX_BURNOUT_IDX)
> +				return -EINVAL;
> +
> +			if (burnout =3D=3D adc->burnout_mode)
> +				return ret;
> +
> +			mutex_lock(&adc->lock);
> +			ret =3D mcp3564_update_8bits(adc, MCP3564_CONFIG0,
> +						   MCP3564_CS_SEL_MASK,
> +						   MCP3564_CS_SEL_SET(burnout));
> +
> +			if (ret)
> +				dev_err(&indio_dev->dev, "Failed to configure burnout current\n");
> +			else
> +				adc->burnout_mode =3D burnout;
> +			mutex_unlock(&adc->lock);
> +			return ret;
> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
> +			return -EINVAL;
> +
> +		mutex_lock(&adc->lock);
> +		ret =3D mcp3564_write_24bits(adc, MCP3564_OFFSETCAL, val);
> +		if (!ret)
> +			adc->calib_bias =3D val;
> +		mutex_unlock(&adc->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])

calib_scale for scale?

> +			return -EINVAL;
> +
> +		if (adc->calib_scale =3D=3D val)
> +			return ret;
> +
> +		mutex_lock(&adc->lock);
> +		ret =3D mcp3564_write_24bits(adc, MCP3564_GAINCAL, val);
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
> +		ret =3D mcp3564_update_8bits(adc, MCP3564_CONFIG1, MCP3564_OVERSPL_RAT=
IO_MASK,
> +					   MCP3564_OVERSAMPLING_RATIO_SET(adc->oversampling));
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
> +		ret =3D mcp3564_update_8bits(adc, MCP3564_CONFIG2, MCP3564_HARDWARE_GA=
IN_MASK,
> +					   MCP3564_HARDWARE_GAIN_SET(hwgain));
> +		if (!ret)
> +			adc->hwgain =3D hwgain;
> +
> +		mutex_unlock(&adc->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

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
> +
> +	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
> +
> +	ret =3D mcp3564_read_8bits(adc, MCP3564_RESERVED_C, &tmp_reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (tmp_reg) {
> +	case MCP3564_REG_C_DEFAULT:
> +		adc->has_vref =3D false;
> +		break;
> +	case MCP3564R_REG_C_DEFAULT:
> +		adc->has_vref =3D true;
> +		break;
> +	default:
> +		dev_info(dev, "Unknown chip found: %d\n", tmp_reg);
> +		err =3D true;
> +	}
> +
> +	if (!err) {
> +		ret =3D mcp3564_read_16bits(adc, MCP3564_RESERVED_E, &tmp_u16);
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

Can we use spi_get_device_match_data() here?

> +		adc->chip_info =3D device_get_match_data(&adc->spi->dev);
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
> +		if (PTR_ERR(adc->vref) =3D=3D -ENODEV) {
> +			/* Check if chip has internal vref */
> +			if (!adc->has_vref)
> +				return dev_err_probe(dev, -EINVAL,

ERR_PTR(adc->vref) would be better as might tell us something more useful.

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
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_LOCK, MCP3564_LOCK_WRITE_ACCES=
S_PASSWORD);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_IRQ, 0x03);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_fast_cmd(adc, MCP3564_FASTCMD_RESET);
> +	if (ret)
> +		return ret;
> +
> +	mdelay(1);
> +
> +	/* set a gain of 1x for GAINCAL */
> +	ret =3D mcp3564_write_24bits(adc, MCP3564_GAINCAL,
> +				   MCP3564_GAINCAL_SET(MCP3564_DEFAULT_GAINCAL));

It's the default register value - I wouldn't expect it to be masked via the
set function (it's not the default of just that field).

> +	if (ret)
> +		return ret;
> +
> +	adc->calib_scale =3D MCP3564_GAINCAL_SET(MCP3564_DEFAULT_GAINCAL);
> +
> +	ret =3D mcp3564_write_24bits(adc, MCP3564_OFFSETCAL,
> +				   MCP3564_OFFSETCAL_SET(MCP3564_DEFAULT_OFFSETCAL));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_24bits(adc, MCP3564_TIMER,
> +				   MCP3564_TIMER_SET(MCP3564_TIMER_DEFAULT_VALUE));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_24bits(adc, MCP3564_SCAN,
> +				   MCP3564_DELAY_TIME_SET(MCP3564_NO_DELAY) |
> +				   MCP3564_SCAN_CH_SEL_SET(MCP3564_SCAN_DEFAULT_VALUE));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_MUX, MCP3564_MUX_SET(MCP3564_C=
H0, MCP3564_CH1));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_IRQ, MCP3464_EN_FASTCMD | MCP3=
464_EN_STP);
> +	if (ret)
> +		return ret;
> +
> +	tmp_reg =3D MCP3564_CONV_MODE_SET(MCP3464_CONV_MODE_ONE_SHOT_STANDBY);
> +	tmp_reg |=3D MCP3564_DATA_FORMAT_SET(MCP3456_DATA_FORMAT_32B_SGN_EXT);
> +	tmp_reg |=3D MCP3464_EN_OFFCAL;
> +	tmp_reg |=3D MCP3464_EN_GAINCAL;
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_CONFIG3, tmp_reg);
> +	if (ret)
> +		return ret;
> +
> +	tmp_reg =3D MCP3564_BOOST_CURRENT_SET(MCP3564_BOOST_CURRENT_x1_00);
> +	tmp_reg |=3D MCP3564_HARDWARE_GAIN_SET(0x01);
> +	tmp_reg |=3D MCP3564_AZ_MUX_SET(1);
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_CONFIG2, tmp_reg);
> +	if (ret)
> +		return ret;
> +
> +	adc->hwgain =3D 0x01;
> +	adc->auto_zeroing_mux =3D true;
> +	adc->auto_zeroing_ref =3D false;
> +	adc->current_boost_mode =3D MCP3564_BOOST_CURRENT_x1_00;
> +
> +	tmp_reg =3D MCP3564_OVERSAMPLING_RATIO_SET(MCP3564_OVERSAMPLING_RATIO_9=
8304);
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_CONFIG1, tmp_reg);
> +	if (ret)
> +		return ret;
> +
> +	adc->oversampling =3D MCP3564_OVERSAMPLING_RATIO_98304;
> +
> +	tmp_reg =3D MCP3564_ADC_MODE_MASK_SET(MCP3564_ADC_MODE_STANDBY);
> +	tmp_reg |=3D MCP3564_CS_SEL_SET(MCP3564_CS_SEL_0_0_uA);
> +	tmp_reg |=3D MCP3564_CLK_SEL_SET(MCP3564_USE_INTERNAL_CLK);
> +	tmp_reg |=3D MCP3456_CONFIG0_BIT6_DEFAULT;
> +
> +	if (!adc->vref) {
> +		tmp_reg |=3D MCP3564_VREF_SET(1);
> +		adc->vref_mv =3D MCP3564R_INT_VREF_MV;
> +	}
> +
> +	ret =3D mcp3564_write_8bits(adc, MCP3564_CONFIG0, tmp_reg);
> +
> +	adc->burnout_mode =3D MCP3564_CS_SEL_0_0_uA;
> +
> +	return ret;
> +}

...

> +
> +static const struct of_device_id mcp3564_dt_ids[] =3D {
> +	{ .compatible =3D "microchip,mcp3461", .data =3D &mcp3564_chip_infos_tb=
l[mcp3461] },
> +	{ .compatible =3D "microchip,mcp3462", .data =3D &mcp3564_chip_infos_tb=
l[mcp3462] },
> +	{ .compatible =3D "microchip,mcp3464", .data =3D &mcp3564_chip_infos_tb=
l[mcp3464] },
> +	{ .compatible =3D "microchip,mcp3561", .data =3D &mcp3564_chip_infos_tb=
l[mcp3561] },
> +	{ .compatible =3D "microchip,mcp3562", .data =3D &mcp3564_chip_infos_tb=
l[mcp3562] },
> +	{ .compatible =3D "microchip,mcp3564", .data =3D &mcp3564_chip_infos_tb=
l[mcp3564] },
> +	{ .compatible =3D "microchip,mcp3461r", .data =3D &mcp3564_chip_infos_t=
bl[mcp3461r] },
> +	{ .compatible =3D "microchip,mcp3462r", .data =3D &mcp3564_chip_infos_t=
bl[mcp3462r] },
> +	{ .compatible =3D "microchip,mcp3464r", .data =3D &mcp3564_chip_infos_t=
bl[mcp3464r] },
> +	{ .compatible =3D "microchip,mcp3561r", .data =3D &mcp3564_chip_infos_t=
bl[mcp3561r] },
> +	{ .compatible =3D "microchip,mcp3562r", .data =3D &mcp3564_chip_infos_t=
bl[mcp3562r] },
> +	{ .compatible =3D "microchip,mcp3564r", .data =3D &mcp3564_chip_infos_t=
bl[mcp3564r] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp3564_dt_ids);
> +
> +static const struct spi_device_id mcp3564_id[] =3D {
> +	{ "mcp3461", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3461] },
> +	{ "mcp3462", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3462] },
> +	{ "mcp3464", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3464] },
> +	{ "mcp3561", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3561] },
> +	{ "mcp3562", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3562] },
> +	{ "mcp3564", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3564] },
> +	{ "mcp3461r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3461r] },
> +	{ "mcp3462r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3462r] },
> +	{ "mcp3464r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3464r] },
> +	{ "mcp3561r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3561r] },
> +	{ "mcp3562r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3562r] },
> +	{ "mcp3564r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3564r] },
> +	{ }
> +};
> +

No blank line here (for consistency with above)

> +MODULE_DEVICE_TABLE(spi, mcp3564_id);


