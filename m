Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EAD803255
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjLDMRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:17:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABC7D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:17:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD9DC433C7;
        Mon,  4 Dec 2023 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701692273;
        bh=fLflBYKuMdPoCfZzqnCXrDdRGvlTaZaGZ4RaZN68BtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tt72/bczB116z7osIDi7rF6tx7Tj23Q7usTlE2Mt4YX9ZgquQekjcS7M6es0PtEPt
         rsBQzbNOo+5pSuELtZLCQI/471v9AADvETt2wtj7ngeAnkYUGOBe07k7QsNLHDfhWl
         eDBeYK4dVfg1TU9Icx02fH4TIvjhP/amXBH+2Efz5YBz/K7Hmc5AhxgCW0/W/8eyvH
         9DHpPRHvRr3ZsUaOfOLGhKfGLxA/Pf0Ke/9289GOu8iMLAZ2mH6970BYFVTojOct78
         2PrNIJVA2ltngGgnU4p4lJEwHAFrHSG7P99nvNQ9f/LL7ECl45Sprm7i/k94QBOZKk
         2IvgDQjUWVNJQ==
Date:   Mon, 4 Dec 2023 12:17:44 +0000
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
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series
Message-ID: <20231204121744.6c0becb9@jic23-huawei>
In-Reply-To: <20231129170425.3562-2-petre.rodan@subdimension.ro>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
        <20231129170425.3562-2-petre.rodan@subdimension.ro>
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

On Wed, 29 Nov 2023 19:04:12 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors.
> Communication is one way. The sensor only requires 4 bytes worth of
> clock pulses on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.
> 
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Hi Petre,

A few additional comments from me inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
> new file mode 100644
> index 000000000000..d25dafa137d0
> --- /dev/null
> +++ b/drivers/iio/pressure/hsc030pa.c
> @@ -0,0 +1,497 @@

...

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
> +static int hsc_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *channel, int *val,
> +			int *val2, long mask)
> +{
> +	struct hsc_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u32 recvd;
> +	int raw;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = hsc_get_measurement(data);
> +		if (ret)
> +			return ret;
> +
> +		recvd = get_unaligned_be32(data->buffer);
> +		switch (channel->type) {
> +		case IIO_PRESSURE:
> +			raw = FIELD_GET(HSC_PRESSURE_MASK, recvd);
> +			*val = raw;

Why is putting it in raw first useful?

			*val = FIELD_GET(HSC_PRESSURE_MASK, recvd);
seems clear enough to me.

> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			raw = FIELD_GET(HSC_TEMPERATURE_MASK, recvd);
> +			*val = raw;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
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
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +int hsc_common_probe(struct device *dev, void *client, hsc_recv_fn recv,
> +			const char *name)
> +{

Given client is always either to_i2c_client(dev) or to_spi_device(dev)
just use dev plus those macros in the callbacks and drop the client pointer being
passed in here.

name always takes the same value and the method for obtaining it is fragile
if that ever changes (device tree tables can easily get out of sync with
the other tables used and fallback compatibles make it even more complex)
So just hard code it where you use it in this function and drop that parameter as well.


> +	struct hsc_data *hsc;
> +	struct iio_dev *indio_dev;
> +	const char *triplet;
> +	u64 tmp;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	hsc = iio_priv(indio_dev);
> +
> +	hsc->chip = &hsc_chip;
> +	hsc->recv_cb = recv;
> +	hsc->client = client;
> +
> +	ret = device_property_read_u32(dev, "honeywell,transfer-function",
> +				     &hsc->function);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"honeywell,transfer-function could not be read\n");
> +	if (hsc->function > HSC_FUNCTION_F)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "honeywell,transfer-function %d invalid\n",
> +				     hsc->function);
> +
> +	ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> +					&triplet);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"honeywell,pressure-triplet could not be read\n");
> +
> +	if (str_has_prefix(triplet, "NA")) {
> +		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
> +					       &hsc->pmin);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmin-pascal could not be read\n");

Trivial but a blank line here would help readability a little.

> +		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> +					       &hsc->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmax-pascal could not be read\n");
> +	} else {
> +		ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> +						triplet);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +				"honeywell,pressure-triplet is invalid\n");
> +
> +		hsc->pmin = hsc_range_config[ret].pmin;
> +		hsc->pmax = hsc_range_config[ret].pmax;
> +	}
> +
> +	if (hsc->pmin >= hsc->pmax)
> +		return dev_err_probe(dev, -EINVAL,
> +			"pressure limits are invalid\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "can't get vdd supply\n");
> +
> +	hsc->outmin = hsc_func_spec[hsc->function].output_min;
> +	hsc->outmax = hsc_func_spec[hsc->function].output_max;
> +
> +	tmp = div_s64(((s64)(hsc->pmax - hsc->pmin)) * MICRO,
> +		      hsc->outmax - hsc->outmin);
> +	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_dec);
> +	tmp = div_s64(((s64)hsc->pmin * (s64)(hsc->outmax - hsc->outmin)) *
> +		      MICRO, hsc->pmax - hsc->pmin);
> +	tmp -= (s64)hsc->outmin * MICRO;
> +	hsc->p_offset = div_s64_rem(tmp, MICRO, &hsc->p_offset_dec);
> +
> +	mutex_init(&hsc->lock);
> +	indio_dev->name = name;

As above. Might as well hard code this given it's always the same and that
avoids issues with fragility of how this is established.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hsc_info;
> +	indio_dev->channels = hsc->chip->channels;
> +	indio_dev->num_channels = hsc->chip->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_NS(hsc_common_probe, IIO_HONEYWELL_HSC030PA);
> +
> +MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
> +MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor core driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
> new file mode 100644
> index 000000000000..169921da759f
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
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#define HSC_REG_MEASUREMENT_RD_SIZE 4
> +
> +struct device;
> +
> +struct iio_chan_spec;
> +struct iio_dev;
> +
> +struct hsc_data;
> +struct hsc_chip_data;
> +
> +typedef int (*hsc_recv_fn)(struct hsc_data *);
> +
> +/**
> + * struct hsc_data
> + * @client: either i2c or spi kernel interface struct for current dev

As below. I'd much rather see a struct device in ehre.

> + * @chip: structure containing chip's channel properties
> + * @lock: lock protecting chip reads

There is no need to protect reads in general.  What do you really mean here?
I'm guessing it's to protect against concurrent use of the buffer into
which the read is being done?

> + * @recv: function that implements the chip reads
> + * @is_valid: false if last transfer has failed

Nitpick, but also the value it takes if there hasn't been a transfer yet I think...
Perhaps that's a detail we can ignore.

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
> +	hsc_recv_fn recv_cb;
> +	bool is_valid;
> +	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
The aligned magic is to ensure that this buffer starts on a cacheline. The idea
being that we can't end up with incoherent DMA issues wiping out changes in other
data that happens to come just before it.

That provides no protection on what happens afterwards....
Which is why such buffers are always the last element of the iio_priv() structure.
(more or less - we might have other dma buffers after them).
We then rely on the C spec to enforce that the structure overall size is a multiple
of the largest alignment to ensure nothing else uses the rest of the cacheline.

In conclusion, move this to the end of the structure.


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
> index 000000000000..17f335e5631f
> --- /dev/null
> +++ b/drivers/iio/pressure/hsc030pa_i2c.c
> @@ -0,0 +1,71 @@
Similar comments to below on spi driver apply.

> diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
> new file mode 100644
> index 000000000000..846b0922c4d4
> --- /dev/null
> +++ b/drivers/iio/pressure/hsc030pa_spi.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Honeywell TruStability HSC Series pressure/temperature sensor
> + *
> + * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
> + *
> + * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "hsc030pa.h"
> +
> +static int hsc_spi_recv(struct hsc_data *data)
> +{
> +	struct spi_transfer xfer = {
> +		.tx_buf = NULL,
> +		.rx_buf = data->buffer,
> +		.len = HSC_REG_MEASUREMENT_RD_SIZE,
> +	};
> +
> +	return spi_sync_transfer(data->client, &xfer, 1);
> +}
> +
> +static int hsc_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);

As mentioned above, spi_get_device_id() can be fragile as it relies on
searching for the modalias which if it comes from device tree is done
by stripping vendor off the compatible.  https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L2338
That doesn't necessarily match anything (obviously it does currently but
this often gets broken as people add more compatibles etc).

Key here is that we don't need it anyway, just hard code the name in the
common probe code.  That side steps all the issues.

> +
> +	return hsc_common_probe(&spi->dev, spi, hsc_spi_recv, id->name);
> +}

