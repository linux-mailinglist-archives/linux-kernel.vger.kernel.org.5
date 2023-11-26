Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0254E7F94E7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjKZSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjKZSdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:33:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AC218B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 10:33:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05232C433C7;
        Sun, 26 Nov 2023 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701023623;
        bh=zrU4gLxxf5YEYb6jb9tmW8AYMw7MJgKNjGe8Z4YJh4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gU8fpAydMRMa3H8g6OtUjK0Z7iadrdtC5vXaP8+dbR+dwKrFbnaXhf9M2aqdNPaS5
         NEljrgkGkgXQUTBF/FEHGF1Tt3YOegFMhQdnQvGeE2icE/pUWk54yK6l1VTV5j6h/W
         OBkTCeLeH1P0894AyC6gA0z3Zy7iKi4txk1FgjWjPYvavXIVYGjBaPkMBOFcWokzwB
         7qT7ZERLDwCOAVS4IKv9MONtetBHeBCEMzQ5c6uGsn273GKFasWpt3VBCHoXgE9yKQ
         a4umEnvQlFBSE5gTNZhMO7sTzt49k+mPe+LY03JOBO/sTWypSmgaJkU5PKcdBny24O
         zV95iU3yTP9vA==
Date:   Sun, 26 Nov 2023 18:33:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <20231126183334.625d2d8b@jic23-huawei>
In-Reply-To: <20231126102721.15322-1-petre.rodan@subdimension.ro>
References: <20231126102721.15322-1-petre.rodan@subdimension.ro>
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

On Sun, 26 Nov 2023 12:27:17 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors. 
> Communication is one way. The sensor only requires 4 bytes worth of
> clock signals on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.
> 
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Hi Petre

A quick end of day review.

Jonathan

> diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
> new file mode 100644
> index 000000000000..a118d27e4342
> --- /dev/null
> +++ b/drivers/iio/pressure/hsc030pa.c
> @@ -0,0 +1,414 @@
...

> +
> +#include "hsc030pa.h"
> +
> +#define     HSC_PRESSURE_TRIPLET_LEN  6

Can you make this length based on something like a structure length, or number
of registers?  That would make it self documenting which is always nice to have.

> +#define              HSC_STATUS_MASK  GENMASK(7, 6)
> +#define         HSC_TEMPERATURE_MASK  GENMASK(15, 5)
> +#define            HSC_PRESSURE_MASK  GENMASK(29, 16)

Unusual indenting.  Don't do this.  Just use a single space
as it's much less noise as a driver gets modified over time.

> +
> +struct hsc_func_spec {
> +	u32 output_min;
> +	u32 output_max;
> +};
> +
> +/**
> + * function A: 10% - 90% of 2^14
> + * function B:  5% - 95% of 2^14
> + * function C:  5% - 85% of 2^14
> + * function F:  4% - 94% of 2^14
> + */
> +static const struct hsc_func_spec hsc_func_spec[] = {
> +	[HSC_FUNCTION_A] = {.output_min = 1638, .output_max = 14746},
> +	[HSC_FUNCTION_B] = {.output_min =  819, .output_max = 15565},
> +	[HSC_FUNCTION_C] = {.output_min =  819, .output_max = 13926},
> +	[HSC_FUNCTION_F] = {.output_min =  655, .output_max = 15401},
Space after { and before }
We need a consistent style, and that's my preferred one for IIO.

> +};

> +/* all min max limits have been converted to pascals */
> +static const struct hsc_range_config hsc_range_config[] = {
> +	{.name = "001BA", .pmin =       0, .pmax =  100000 },

space after { in all these.


> +};
>
> +static int hsc_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *channel, int *val,
> +			int *val2, long mask)
> +{
> +	struct hsc_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u32 xfer;
> +	int raw;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = hsc_get_measurement(data);
> +		if (ret)
> +			return ret;
> +
> +		xfer = get_unaligned_be32(data->buffer);
> +		switch (channel->type) {
> +		case IIO_PRESSURE:
> +			raw = FIELD_GET(HSC_PRESSURE_MASK, xfer);
> +			*val = raw;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			raw = FIELD_GET(HSC_TEMPERATURE_MASK, xfer);
> +			*val = raw;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +/**
Not kernel-doc so /* only.

> + * IIO ABI expects
> + * value = (conv + offset) * scale
> + *
> + * datasheet provides the following formula for determining the temperature
> + * temp[C] = conv * a + b
> + *   where a = 200/2047; b = -50
> + *
> + *  temp[C] = (conv + (b/a)) * a * (1000)
> + *  =>
> + *  scale = a * 1000 = .097703957 * 1000 = 97.703957
> + *  offset = b/a = -50 / .097703957 = -50000000 / 97704
> + *
> + *  based on the datasheet
> + *  pressure = (conv - Omin) * Q + Pmin =
> + *          ((conv - Omin) + Pmin/Q) * Q
> + *  =>
> + *  scale = Q = (Pmax - Pmin) / (Omax - Omin)
> + *  offset = Pmin/Q - Omin = Pmin * (Omax - Omin) / (Pmax - Pmin) - Omin
> + */
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (channel->type) {
> +		case IIO_TEMP:
> +			*val = 97;
> +			*val2 = 703957;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_PRESSURE:
> +			*val = data->p_scale;
> +			*val2 = data->p_scale_dec;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (channel->type) {
> +		case IIO_TEMP:
> +			*val = -50000000;
> +			*val2 = 97704;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_PRESSURE:
> +			*val = data->p_offset;
> +			*val2 = data->p_offset_dec;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return -EINVAL;
If you can get to a final return after a case statement you are doing
it wrong. Add a default in the switch - makes it explicit that other
cases are errors rather than having to look down here.


> +}

> +
> +static const struct iio_chan_spec hsc_channels[] = {
> +	{.type = IIO_PRESSURE, .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) },
> +	{.type = IIO_TEMP, .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) },
Format this like every other driver does it.

	{
		.type = IIO_TEMP,
		.info_mask_....
	},
	{
		...
	},

etc
> +};

> +
> +int hsc_probe(struct iio_dev *indio_dev, struct device *dev,
> +	      const char *name, int type)
> +{
> +	struct hsc_data *hsc;
> +	const char *triplet;
> +	u64 tmp;
> +	int index;
> +	int found = 0;
> +	int ret;
> +
> +	hsc = iio_priv(indio_dev);
> +	hsc->chip = &hsc_chip;
> +
> +	ret = device_property_read_u32(dev,
> +				       "honeywell,transfer-function",
> +				       &hsc->function);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			    "honeywell,transfer-function could not be read\n");
> +	if (hsc->function > HSC_FUNCTION_F)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "honeywell,transfer-function %d invalid\n",
> +				     hsc->function);
> +
> +	ret = device_property_read_string(dev,
> +		"honeywell,pressure-triplet", &triplet);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"honeywell,pressure-triplet could not be read\n");
> +
> +	if (strncmp(triplet, "NA", 2) == 0) {
> +		// "not available" in the nomenclature
> +		// we got a custom-range chip so extract pmin, pmax from dt
> +		ret = device_property_read_u32(dev,
> +					       "honeywell,pmin-pascal",
> +					       &hsc->pmin);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmin-pascal could not be read\n");
> +		ret = device_property_read_u32(dev,
> +					       "honeywell,pmax-pascal",
> +					       &hsc->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmax-pascal could not be read\n");
> +	} else {
> +		// chip should be defined in the nomenclature

All comments in IIO use /* */ syntax.

> +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> +			if (strncmp(hsc_range_config[index].name,
> +					triplet,
> +					HSC_PRESSURE_TRIPLET_LEN - 1) == 0) {
> +				hsc->pmin = hsc_range_config[index].pmin;
> +				hsc->pmax = hsc_range_config[index].pmax;
> +				found = 1;
> +				break;
> +			}
> +		}
> +		if (hsc->pmin == hsc->pmax || !found)
> +			return dev_err_probe(dev, -EINVAL,
> +				"honeywell,pressure-triplet is invalid\n");
> +	}

> diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
> new file mode 100644
> index 000000000000..cf1674d36485
> --- /dev/null
> +++ b/drivers/iio/pressure/hsc030pa.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Honeywell TruStability HSC Series pressure/temperature sensor
> + *
> + * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
> + */
> +
> +#ifndef _HSC030PA_H
> +#define _HSC030PA_H
> +
> +#include <linux/property.h>
> +#include <linux/types.h>
> +
> +/**
> + * get all conversions (4 bytes) in one go
> + * since transfers are not address-based
> +*/
> +#define  HSC_REG_MEASUREMENT_RD_SIZE  4
> +
> +struct device;
> +
> +struct iio_chan_spec;
> +struct iio_dev;
> +
> +struct hsc_chip_data;
> +
> +/**
> + * struct hsc_data
> + * @client: either i2c or spi kernel interface struct for current dev
Docs don't match structure

> + * @lock: lock protecting chip reads
> + * @xfer: function that implements the chip reads
> + * @is_valid: false if last transfer has failed
> + * @buffer: raw conversion data
> + * @pmin: minimum measurable pressure limit
> + * @pmax: maximum measurable pressure limit
> + * @outmin: minimum raw pressure in counts (based on transfer function)
> + * @outmax: maximum raw pressure in counts (based on transfer function)
> + * @function: transfer function
> + * @p_scale: pressure scale
> + * @p_scale_dec: pressure scale, decimal places
> + * @p_offset: pressure offset
> + * @p_offset_dec: pressure offset, decimal places
> + */
> +struct hsc_data {
> +	void *client;
> +	const struct hsc_chip_data *chip;
> +	struct mutex lock;
> +	int (*xfer)(struct hsc_data *data);
> +	bool is_valid;
> +	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE];

This is used for SPI transfers so should be DMA safe. It's not currently.
Look at how IIO_DMA_MINALIGN is used in other drivers to ensure there is
no unsafe sharing of cachelines.

On some architectures this is fixed by the stuff that bounces all small transfers
but I don't think that is universal yet.  If you want more info find the talk
by Wolfram Sang from a few years ago an ELCE on I2C DMA safe buffers.

> +	s32 pmin;
> +	s32 pmax;
> +	u32 outmin;
> +	u32 outmax;
> +	u32 function;
> +	s64 p_scale;
> +	s32 p_scale_dec;
> +	s64 p_offset;
> +	s32 p_offset_dec;
> +};

> diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
> new file mode 100644
> index 000000000000..4132db4e356a
> --- /dev/null
> +++ b/drivers/iio/pressure/hsc030pa_i2c.c
> @@ -0,0 +1,81 @@

Very similar comments to spi file, so I haven't repeated them.

> diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
> new file mode 100644
> index 000000000000..d99688a65f04
> --- /dev/null
> +++ b/drivers/iio/pressure/hsc030pa_spi.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Honeywell TruStability HSC Series pressure/temperature sensor
> + *
> + * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
> + *
> + * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "hsc030pa.h"
> +
> +static int hsc_spi_xfer(struct hsc_data *data)
> +{
> +	struct spi_transfer xfer = {
> +		.tx_buf = NULL,
> +		.rx_buf = (char *)&data->buffer,
> +		.len = HSC_REG_MEASUREMENT_RD_SIZE,
> +	};
> +
> +	return spi_sync_transfer(data->client, &xfer, 1);
> +}
> +
> +static int hsc_spi_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hsc_data *hsc;
> +	struct device *dev = &spi->dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	hsc = iio_priv(indio_dev);
> +	hsc->xfer = hsc_spi_xfer;

If it's read only I'd name it to reflect that rather than xfer which
implies both ways.

Also, pass the callback and spi->dev into hsc probe. Easy to use
a container_of() to get back to the struct spi_device *spi

That should let you do the iio_dev allocation etc all inside the generic code
and keep this bus driver to just the bits that are bus specific.

> +	hsc->client = spi;
> +
> +	return hsc_probe(indio_dev, &spi->dev, spi_get_device_id(spi)->name,
> +			 spi_get_device_id(spi)->driver_data);
Don't use anything form spi_get_device_id()

Name is a fixed string currently so pass that directly.
For driver data, there isn't any yet but if there were use
spi_get_device_match_data() and make sure to provide the data in all the
id tables.  That function will search the firmware ones first then call
back to the spi specific varient.

> +}
> +

> +static struct spi_driver hsc_spi_driver = {
> +	.driver = {
> +		.name = "hsc030pa",
> +		.of_match_table = hsc_spi_match,
> +		},

alignment unusual here.
	.driver = {
		.name = "..",
		.of_match_table = ...
	},
is most common form.

> +	.probe = hsc_spi_probe,
> +	.id_table = hsc_spi_id,
> +};
> +module_spi_driver(hsc_spi_driver);
> +
> +MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
> +MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor spi driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HONEYWELL_HSC030PA);

