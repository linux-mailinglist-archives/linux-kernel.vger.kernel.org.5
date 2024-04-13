Return-Path: <linux-kernel+bounces-143795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058F28A3D8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D14281EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0E48CCC;
	Sat, 13 Apr 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkTCYCc9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10428EA;
	Sat, 13 Apr 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713023746; cv=none; b=Q9qFUd4xO8zjhHdC6e2wAolpPw1v0VnmUMNuayiM2pOzag5cwn8tVAFxPrIxhNXfsyL8y1pHOnToge8aGkgxadcBwoE9Oa+V/iOI95fWk2u77sB+CXR2q3PqwM2S6+rGz9+Rz6X/oMJBreqqNRJdAhgwtzdik1THUKHIfMhS5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713023746; c=relaxed/simple;
	bh=riSxMRuxE6qzQeFr/XEA348uVfmFoWqdoDtSU3FzVQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDbVeMSALePTu0uMxLDU7zGXvb+3Q4aiItQrZXEl7emFawoB69MpuRrcgYXhUQtGz/8qvU0nlSYkxscDc5gKd20xXMhvgYUUcnw/hZFV/Rbd0oYDdMkObr9QNh3V4hsDQhRPvI/Q/PCM9OqIFjIfHeO8T1OhRyTr/5Ni3FUNpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkTCYCc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C2C2BD11;
	Sat, 13 Apr 2024 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713023745;
	bh=riSxMRuxE6qzQeFr/XEA348uVfmFoWqdoDtSU3FzVQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nkTCYCc9jqR1oulvw8iHQuUdk48GFlIcewW37IY2fMdRDYwjoYA0jJ2f2fjc2ri6+
	 T4b8sEP/fCqIQWMNsliePbpTJPAH0QPYMR5OYilUlSRMTuiLzMGd3qbM0VyBVPdn+o
	 urHiRPMp33J2MSUdN8PlloWRRSmMjc9fj08zGCqpYVz0e6+YN5akNn+jP0WpL8qHEm
	 Ke0AmFzja7GSqzNOq9lbqSrES8vCzbmLLg0x72hAhmN/NLrmc4Z8hvU66ZpgTM161y
	 YTK6SQLl0nryiDtUImus87/8B216IxB15l6X3/9FSencMgjO+ACOi75KWgGPcdscXf
	 XUQafmtp6VLlA==
Date: Sat, 13 Apr 2024 16:55:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>
Subject: Re: [PATCH 4/4] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Message-ID: <20240413165529.0e8f6deb@jic23-huawei>
In-Reply-To: <20240412032102.136071-5-kimseer.paller@analog.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-5-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 11:21:02 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC
> LTC2672 5 channel, 16 bit Current Output Softspan DAC
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Hi

Most of the questions are in the earlier patch reviews in this series,
so just minor stuff in here.

Jonathan

> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 55bf89739..62df8d7e4 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_DS4424) += ds4424.o
>  obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
>  obj-$(CONFIG_LTC1660) += ltc1660.o
>  obj-$(CONFIG_LTC2632) += ltc2632.o
> +obj-$(CONFIG_LTC2664) += ltc2664.o
>  obj-$(CONFIG_LTC2688) += ltc2688.o
>  obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> new file mode 100644
> index 000000000..70c43fe17
> --- /dev/null
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -0,0 +1,785 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC driver
> + * LTC2672 5 channel, 16 bit Current Output Softspan DAC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#define LTC2664_CMD_WRITE_N(n)		(0x00 + (n))
> +#define LTC2664_CMD_UPDATE_N(n)		(0x10 + (n))
> +#define LTC2664_CMD_WRITE_N_UPDATE_ALL	0x20
> +#define LTC2664_CMD_WRITE_N_UPDATE_N(n)	(0x30 + (n))
> +#define LTC2664_CMD_POWER_DOWN_N(n)	(0x40 + (n))
> +#define LTC2664_CMD_POWER_DOWN_ALL	0x50
> +#define LTC2664_CMD_SPAN_N(n)		(0x60 + (n))
> +#define LTC2664_CMD_CONFIG		0x70
> +#define LTC2664_CMD_MUX			0xB0
> +#define LTC2664_CMD_TOGGLE_SEL		0xC0
> +#define LTC2664_CMD_GLOBAL_TOGGLE	0xD0
> +#define LTC2664_CMD_NO_OPERATION	0xF0
> +#define LTC2664_REF_DISABLE		0x0001
> +#define LTC2664_MSPAN_SOFTSPAN		7
> +
> +#define LTC2672_MAX_CHANNEL		5
> +#define LTC2672_MAX_SPAN		7
> +#define LTC2672_OFFSET_CODE		384

Comment for OFFSET_CODE would be good. I'm not sure what it is or where the
value comes from.

> +#define LTC2672_SCALE_MULTIPLIER(n)	(50 * BIT(n))
> +
> +enum ltc2664_ids {
> +	LTC2664,
> +	LTC2672,
I've mentioned it inline, but this is often a bad sign as it means that some
control logic is used in place of data in a chip_info structure.
Better to avoid tying what happens directly to IDs, but instead have the
chip_info structure cover the particular set of things that a device does.
That ends up a lot easier to extend when a driver gains additional part support.

> +};

> +
> +static const u16 ltc2664_mspan_lut[8][2] = {
> +	{LTC2664_SPAN_RANGE_M10V_10V, 32768}, /* MPS2=0, MPS1=0, MSP0=0 (0)*/
> +	{LTC2664_SPAN_RANGE_M5V_5V, 32768}, /* MPS2=0, MPS1=0, MSP0=1 (1)*/
> +	{LTC2664_SPAN_RANGE_M2V5_2V5, 32768}, /* MPS2=0, MPS1=1, MSP0=0 (2)*/
> +	{LTC2664_SPAN_RANGE_0V_10V, 0}, /* MPS2=0, MPS1=1, MSP0=1 (3)*/
> +	{LTC2664_SPAN_RANGE_0V_10V, 32768}, /* MPS2=1, MPS1=0, MSP0=0 (4)*/
> +	{LTC2664_SPAN_RANGE_0V_5V, 0}, /* MPS2=1, MPS1=0, MSP0=1 (5)*/
> +	{LTC2664_SPAN_RANGE_0V_5V, 32768}, /* MPS2=1, MPS1=1, MSP0=0 (6)*/
> +	{LTC2664_SPAN_RANGE_0V_5V, 0} /* MPS2=1, MPS1=1, MSP0=1 (7)*/
As below, spaces after { and before } 
> +};
> +
> +struct ltc2664_chip_info {
> +	enum ltc2664_ids id;
> +	const char *name;
> +	unsigned int num_channels;
> +	const struct iio_chan_spec *iio_chan;
> +	const int (*span_helper)[2];
> +	unsigned int num_span;
> +};

> +
> +static const int ltc2664_span_helper[][2] = {
> +	{0, 5000}, {0, 10000}, {-5000, 5000}, {-10000, 10000}, {-2500, 2500},
> +};
> +
> +static const int ltc2672_span_helper[][2] = {
> +	{0, 3125}, {0, 6250}, {0, 12500}, {0, 25000}, {0, 50000}, {0, 100000},
> +	{0, 200000}, {0, 300000},
Spaces preferred and better on separate lines.
	{ 0, 3125 },
	{ 0, 6250 }, 

etc as more readable.
 
> +};
> +
> +static int ltc2664_scale_get(const struct ltc2664_state *st, int c, int *val)
> +{
> +	const struct ltc2664_chan *chan = &st->channels[c];
> +	const int (*span_helper)[2] = st->chip_info->span_helper;
> +	int span, fs;
> +
> +	span = chan->span;
> +	if (span < 0)
> +		return span;
> +
> +	switch (st->chip_info->id) {

Make this 'data' rather than using an ID.
There shouldn't be an ID in chip_info because it almost always means
that a coding pattern has been used that isn't as extensible as either
an appropriate callback or appropriate data.

> +	case LTC2664:
> +		fs = span_helper[span][1] - span_helper[span][0];
> +
> +		if (st->vref)

How do we get here with st->vref == 0 ?

> +			*val = (fs / 2500) * st->vref;
> +		else
> +			*val = fs;
> +
> +		return 0;
> +	case LTC2672:
> +		if (span == LTC2672_MAX_SPAN)
> +			*val = 4800 * (1000 * st->vref / st->rfsadj);
> +		else
> +			*val = LTC2672_SCALE_MULTIPLIER(span) *
> +			       (1000 * st->vref / st->rfsadj);

Seem to divide by same thing so add a local variable for that and
use it in both paths.
	
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc2664_offset_get(const struct ltc2664_state *st, int c, int *val)
> +{
> +	const struct ltc2664_chan *chan = &st->channels[c];
> +	int span;
> +
> +	span = chan->span;
> +	if (span < 0)
> +		return span;
> +
> +	if (st->chip_info->span_helper[span][0] < 0)
> +		*val = -32768;
> +	else if (chan->raw[0] >= LTC2672_OFFSET_CODE ||
> +		 chan->raw[1] >= LTC2672_OFFSET_CODE)

This would benefit from a comment. I'm not sure what it is doing.

> +		*val = st->chip_info->span_helper[1][span] / 250;
> +	else
> +		*val = 0;
> +
> +	return 0;
> +}



..

> +/*
> + * For toggle mode we only expose the symbol attr (sw_toggle) in case a TGPx is
> + * not provided in dts.
> + */
> +static const struct iio_chan_spec_ext_info ltc2664_toggle_sym_ext_info[] = {
> +	LTC2664_CHAN_EXT_INFO("raw0", LTC2664_INPUT_A, IIO_SEPARATE,
> +			      ltc2664_dac_input_read, ltc2664_dac_input_write),
> +	LTC2664_CHAN_EXT_INFO("raw1", LTC2664_INPUT_B, IIO_SEPARATE,
> +			      ltc2664_dac_input_read, ltc2664_dac_input_write),
> +	LTC2664_CHAN_EXT_INFO("powerdown", LTC2664_POWERDOWN, IIO_SEPARATE,
> +			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
> +	LTC2664_CHAN_EXT_INFO("symbol", LTC2664_GLOBAL_TOGGLE, IIO_SEPARATE,
> +			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
> +	LTC2664_CHAN_EXT_INFO("toggle_en", LTC2664_TOGGLE_EN,
> +			      IIO_SEPARATE, ltc2664_reg_bool_get,
> +			      ltc2664_reg_bool_set),
> +	{}
> +};
> +
> +static const struct iio_chan_spec_ext_info ltc2664_ext_info[] = {
> +	LTC2664_CHAN_EXT_INFO("powerdown", LTC2664_POWERDOWN, IIO_SEPARATE,
> +			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
as mentioned in the ABI review, powerdown usually comes with a matching
powerdown_mode to say what state the DAC output enters on power down.

Here there is only one option, so should have a read only Ext info attribute
to say it is always 42kohm_to_gnd 
You should also add that as an option to the main docs.
Perhaps this is the point where we define that as a catch all rather than listing
every value though.


> +	{}
> +};

..

> +static int ltc2664_channel_config(struct ltc2664_state *st)
> +{
> +	const struct ltc2664_chip_info *chip_info = st->chip_info;
> +	struct device *dev = &st->spi->dev;
> +	u32 reg, tmp[2], mspan;
> +	int ret, span;
> +
> +	mspan = LTC2664_MSPAN_SOFTSPAN;
> +	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
> +				       &mspan);
> +	if (!ret) {
> +		if (chip_info->id != LTC2664)

Check for a flag that says this config is supported or not, rather than ID.
To support new devices we can just add the flag to their chip_info rather than having
to change the ID checks throughout the code.

> +			return dev_err_probe(dev, -EINVAL,
> +				"adi,manual-span-operation-config not supported\n");
> +
> +		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
> +			return dev_err_probe(dev, -EINVAL,
> +				"adi,manual-span-operation-config not in range\n");
> +	}
> +
> +	st->rfsadj = 20000;
> +	ret = device_property_read_u32(dev, "adi,rfsadj-ohms", &st->rfsadj);
> +	if (!ret) {
> +		if (chip_info->id != LTC2672)

As before. Use a flag, not an ID match.

> +			return dev_err_probe(dev, -EINVAL,
> +					     "adi,rfsadj-ohms not supported\n");
> +
> +		if ((st->rfsadj < 19000 || st->rfsadj > 41000) ||
> +		     chip_info->id != LTC2672)

You already checked the ID.

> +			return dev_err_probe(dev, -EINVAL,
> +					     "adi,rfsadj-ohms not in range\n");
> +	}
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		struct ltc2664_chan *chan;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get reg property\n");
> +
> +		if (reg >= chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg bigger than: %d\n",
> +					     chip_info->num_channels);
> +
> +		chan = &st->channels[reg];
> +
> +		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
> +			chan->toggle_chan = true;
> +			/* assume sw toggle ABI */
> +			st->iio_channels[reg].ext_info = ltc2664_toggle_sym_ext_info;
> +			/*
> +			 * Clear IIO_CHAN_INFO_RAW bit as toggle channels expose
> +			 * out_voltage/current_raw{0|1} files.
> +			 */
> +			__clear_bit(IIO_CHAN_INFO_RAW,
> +				    &st->iio_channels[reg].info_mask_separate);
> +		}
> +
> +		chan->raw[0] = ltc2664_mspan_lut[mspan][1];
> +		chan->raw[1] = ltc2664_mspan_lut[mspan][1];
> +
> +		chan->span = ltc2664_mspan_lut[mspan][0];
> +
> +		ret = fwnode_property_read_u32_array(child, "adi,output-range-microvolt",
> +						     tmp, ARRAY_SIZE(tmp));
> +		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {

I don't like this pattern of doing things only on error. Probably easiet
is to factor each of these blocks out as a function to call and then you
can just return from that if !ret.  Will end up more redable than this
is.

> +			/* voltage type measurement */
> +			st->iio_channels[reg].type = IIO_VOLTAGE;
> +
> +			span = ltc2664_span_lookup(st, (int)tmp[0] / 1000,
> +						   tmp[1] / 1000);
> +			if (span < 0)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "output range not valid");
> +
> +			ret = regmap_write(st->regmap,
> +					   LTC2664_CMD_SPAN_N(reg),
> +					   span);
> +			if (ret)
> +				return dev_err_probe(dev, -EINVAL,
> +						"failed to set chan settings\n");
> +
> +			chan->span = span;
> +		}
> +
> +		ret = fwnode_property_read_u32(child,
> +					       "adi,output-range-microamp",
> +					       &tmp[0]);
> +		if (!ret) {
> +			/* current type measurement */
> +			st->iio_channels[reg].type = IIO_CURRENT;
> +
> +			span = ltc2664_span_lookup(st, 0,
> +						   (int)tmp[0] / 1000);
> +			if (span < 0)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "output range not valid");
> +
> +			ret = regmap_write(st->regmap,
> +					   LTC2664_CMD_SPAN_N(reg),
> +					   span + 1);
> +			if (ret)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "failed to set chan settings\n");
> +
> +			chan->span = span;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltc2664_setup(struct ltc2664_state *st, struct regulator *vref)
> +{
> +	const struct ltc2664_chip_info *chip_info = st->chip_info;
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	/*
> +	 * If we have a clr/reset pin, use that to reset the chip.

Single line comment style is

	/* If we have.. chip. */

> +	 */
> +	gpio = devm_gpiod_get_optional(&st->spi->dev, "clr", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio))
> +		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
> +				     "Failed to get reset gpio");
> +	if (gpio) {
> +		usleep_range(1000, 1200);
> +		/* bring device out of reset */
I'd argue that comment is obvious enough we don't need it.


> +		gpiod_set_value_cansleep(gpio, 0);
> +	}
> +
> +	/*
> +	 * Duplicate the default channel configuration as it can change during
> +	 * @ltc2664_channel_config()
> +	 */
> +	st->iio_channels = devm_kmemdup(&st->spi->dev, chip_info->iio_chan,
> +					chip_info->num_channels *
> +					sizeof(*chip_info->iio_chan),
> +					GFP_KERNEL);

Is that big enough? I'd expect 1 more entry as a null terminator.

> +
> +	ret = ltc2664_channel_config(st);
> +	if (ret)
> +		return ret;
> +
> +	if (!vref)
> +		return 0;
> +
> +	return regmap_set_bits(st->regmap, LTC2664_CMD_CONFIG, LTC2664_REF_DISABLE);
> +}

..

> +static int ltc2664_probe(struct spi_device *spi)
> +{
> +	static const char * const regulators[] = { "vcc", "iovcc" };
> +	const struct ltc2664_chip_info *chip_info;
> +	struct device *dev = &spi->dev;
> +	struct regulator *vref_reg;
> +	struct iio_dev *indio_dev;
> +	struct ltc2664_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	chip_info = spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -ENOMEM;
> +
> +	st->chip_info = chip_info;
> +
> +	mutex_init(&st->lock);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ltc2664_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to init regmap");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					     regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	vref_reg = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(vref_reg)) {
> +		if (PTR_ERR(vref_reg) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(vref_reg),
> +					     "Failed to get vref regulator");
> +
> +		vref_reg = NULL;
> +
> +		/* internal reference */
> +		if (chip_info->id == LTC2664)

Push all chip specific data into the chip_info structure. Never match on ID value
as it is extensible as you add more devices to a driver over time.

		st->vref = chip_info->internal_vref; or something like that.


> +			st->vref = 2500;
> +		else
> +			st->vref = 1250;
> +	} else {
> +		ret = regulator_enable(vref_reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable vref regulators\n");
> +
> +		ret = devm_add_action_or_reset(dev, ltc2664_disable_regulator,
> +					       vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(vref_reg);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to get vref\n");
> +
> +		st->vref = ret / 1000;
> +	}
> +
> +	ret = ltc2664_setup(st, vref_reg);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = chip_info->name;
> +	indio_dev->info = &ltc2664_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->iio_channels;
> +	indio_dev->num_channels = chip_info->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ltc2664_id[] = {
> +	{ "ltc2664", (kernel_ulong_t)&ltc2664_chip },
> +	{ "ltc2672", (kernel_ulong_t)&ltc2672_chip },
> +	{ },

No trailing commas needed or desirable on terminating entries like this.
We will never add anything after them.

Jonathan


