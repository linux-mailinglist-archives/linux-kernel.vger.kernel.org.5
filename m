Return-Path: <linux-kernel+bounces-7122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE0981A1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4702A288009
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704E3F8D6;
	Wed, 20 Dec 2023 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLJBB9yw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842993FE20;
	Wed, 20 Dec 2023 15:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51163C433C7;
	Wed, 20 Dec 2023 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703085200;
	bh=+NT4zzRTOVI8jaaZ/sQ4A5+O0Wf0rqTsTRlaB+9MhmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oLJBB9yw5AfSe2Yxi9fv+cS5lcLGCn6HWn8Z3DS77VqjtfwL3affpn+5FQEgk1Sdx
	 8L7f4HI/x/SMo/ALrDVXoNmQFNw2Bpmfj9qXk60rpWOFk2tAk8aEY4Digz+zJzzVOg
	 SoZQLac125V7/bhtSMH+oiUTECZQ9zaK6NffseUM8N7F+nRdt16+k6Ypeu1TLdgOg7
	 EAuzm6A+hevhDkThTxwjUbHDVUS3hbl1xfAzQNlJSngwaWjyr7KCfhwY4c3hBdX/Gf
	 qxP2Z8qx4qlzJzu5xe3BY0YtMjURNtR2/qXgNt6clwR/JfrchYNelxOdXCuKwXEY2M
	 C1N2+mIzwNXDw==
Date: Wed, 20 Dec 2023 15:13:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Andreas Klinger <ak@it-klinger.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: change driver for Honeywell MPR
 series
Message-ID: <20231220151305.00b4d1f0@jic23-huawei>
In-Reply-To: <20231219130230.32584-3-petre.rodan@subdimension.ro>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
	<20231219130230.32584-3-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 15:02:21 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> ChangeLog
>  - rewrite flow so that driver can use either i2c or spi as communication bus
>  - add spi driver (tested on MPRLS0015PA0000SA)
>  - add pressure-triplet property that automatically sets pmin, pmax
>  - fix transfer-function enum typo based on previous review [1]
>  - fix interrupt example in binding file (FALLING -> RISING edge)
>  - indentation changes based on previous code reviews
>  - renamed mpr_read_pressure to mpr_read_conversion since the sensor is
>    supposed to also provide temperature measuremets
>    (but I think mine is broken since the raw temperature value is always
>    0x800000 - so temp reading not currently implemented)

This is a lot of different things.  You need to break them up into
individual patches in the order.

1. Fixes (to enable easy backports)
2. Cleanup (usually better to do these ahead of new stuff)
3. Refactors to enable each new item, then for each one
4. New stuff such as the spi support and the new properties etc.

Also good to spell check your commit messages as at least one typo above.


I took a quick glance - but it's much more challenging to review a mixed
up patch like this than a series of well defined changes so its just
a few things I happened to notice rather than a proper review.

thanks,

Jonathan
> 
> I've been told in the past that the use of mutexes is redundant in these cases
> so please assess if the guard() from the driver code is required or should be
> removed.
> 
> patch uses device_property_match_property_string() from the 'togreg' branch
> 
> [1]: https://lore.kernel.org/lkml/20231116-grudge-hankering-b7a71d831b93@squawk/T/
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

...

> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> index 30fb2de36821..4a999bf73964 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -5,17 +5,14 @@


>  	mutex_init(&data->lock);
>  	init_completion(&data->completion);
> @@ -345,64 +344,85 @@ static int mpr_probe(struct i2c_client *client)
>  	indio_dev->num_channels = ARRAY_SIZE(mpr_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = devm_regulator_get_enable(dev, "vdd");
> +#ifdef TESTING_NOT_PART_OF_PRODUCTION_VERSION

Looks like you didn't clear this out...

> +	/* when loaded as i2c device we need to use default values */
> +	dev_notice(dev, "firmware node not found; using defaults\n");
> +	data->pmin = 0;
> +	data->pmax = 172369; /* 25 psi */
> +	data->function = MPR_FUNCTION_A;
> +#else
> +	ret = device_property_read_u32(dev,
> +			       "honeywell,transfer-function", &func);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
> -				"can't get and enable vdd supply\n");
> +			    "honeywell,transfer-function could not be read\n");
> +	data->function = func - 1;
> +	if (data->function > MPR_FUNCTION_C)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "honeywell,transfer-function %d invalid\n",
> +				     data->function);
> +
> +	ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> +					  &triplet);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			     "honeywell,pressure-triplet could not be read\n");
>  
> -	if (dev_fwnode(dev)) {
> +	if (str_has_prefix(triplet, "NA")) {
>  		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
> -								&data->pmin);
> +					       &data->pmin);
>  		if (ret)
>  			return dev_err_probe(dev, ret,
> -				"honeywell,pmin-pascal could not be read\n");
> +				  "honeywell,pmin-pascal could not be read\n");
> +
>  		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> -								&data->pmax);
> -		if (ret)
> -			return dev_err_probe(dev, ret,
> -				"honeywell,pmax-pascal could not be read\n");
> -		ret = device_property_read_u32(dev,
> -				"honeywell,transfer-function", &data->function);
> +					       &data->pmax);
>  		if (ret)
>  			return dev_err_probe(dev, ret,
> -				"honeywell,transfer-function could not be read\n");
> -		if (data->function > MPR_FUNCTION_C)
> -			return dev_err_probe(dev, -EINVAL,
> -				"honeywell,transfer-function %d invalid\n",
> -								data->function);
> +				  "honeywell,pmax-pascal could not be read\n");
>  	} else {
> -		/* when loaded as i2c device we need to use default values */
> -		dev_notice(dev, "firmware node not found; using defaults\n");
> -		data->pmin = 0;
> -		data->pmax = 172369; /* 25 psi */
> -		data->function = MPR_FUNCTION_A;
> +		ret = device_property_match_property_string(dev,
> +						  "honeywell,pressure-triplet",
> +						  mpr_triplet_variants,
> +						  MPR_VARIANTS_MAX);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +				    "honeywell,pressure-triplet is invalid\n");
> +
> +		data->pmin = mpr_range_config[ret].pmin;
> +		data->pmax = mpr_range_config[ret].pmax;
>  	}
> +#endif
...

>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  				"request irq %d failed\n", data->irq);
>  	}
>  
>  	data->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
> -							GPIOD_OUT_HIGH);
> +						    GPIOD_OUT_HIGH);
>  	if (IS_ERR(data->gpiod_reset))
>  		return dev_err_probe(dev, PTR_ERR(data->gpiod_reset),
>  						"request reset-gpio failed\n");
> @@ -410,41 +430,20 @@ static int mpr_probe(struct i2c_client *client)
>  	mpr_reset(data);
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> -						mpr_trigger_handler, NULL);
> +					      mpr_trigger_handler, NULL);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
> -					"iio triggered buffer setup failed\n");
> +				     "iio triggered buffer setup failed\n");
>  
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
> -					"unable to register iio device\n");
> +				     "unable to register iio device\n");
>  
Any white space changes need to be in their own patch so they don't add noise to a patch
doing anything else.



> diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
> new file mode 100644
> index 000000000000..b47fc26a309d
> --- /dev/null
> +++ b/drivers/iio/pressure/mprls0025pa.h
> @@ -0,0 +1,103 @@
> +/**
> + * struct mpr_data
> + * @dev: current device structure
> + * @read_cb: function that implements the sensor reads
> + * @write_cb: function that implements the sensor writes
> + * @pmin: minimal pressure in pascal
> + * @pmax: maximal pressure in pascal
> + * @function: transfer function
> + * @outmin: minimum raw pressure in counts (based on transfer function)
> + * @outmax: maximum raw pressure in counts (based on transfer function)
> + * @scale: pressure scale
> + * @scale2: pressure scale, decimal places
> + * @offset: pressure offset
> + * @offset2: pressure offset, decimal places
> + * @gpiod_reset: reset
> + * @irq: end of conversion irq. used to distinguish between irq mode and
> + *       reading in a loop until data is ready
> + * @completion: handshake from irq to read
> + * @chan: channel values for buffered mode
> + * @buffer: raw conversion data
> + */
> +struct mpr_data {
> +	struct device		*dev;
> +	mpr_xfer_fn		read_cb;
> +	mpr_xfer_fn		write_cb;
> +	struct mutex		lock;
> +	u32			pmin;
> +	u32			pmax;
> +	enum mpr_func_id	function;
> +	u32			outmin;
> +	u32			outmax;
> +	int			scale;
> +	int			scale_dec;
> +	int			offset;
> +	int			offset_dec;
Docs don't match.
> +	struct gpio_desc	*gpiod_reset;
> +	int			irq;
> +	struct completion	completion;
> +	struct mpr_chan		chan;
> +	u8			buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> +};
> +

...

> diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
> new file mode 100644
> index 000000000000..41cd4bad02f7
> --- /dev/null
> +++ b/drivers/iio/pressure/mprls0025pa_spi.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MPRLS0025PA - Honeywell MicroPressure MPR series SPI sensor driver
> + *
> + * Copyright (c) 2024 Petre Rodan <petre.rodan@subdimension.ro>
> + *
> + * Data sheet:
> + *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "mprls0025pa.h"
> +
> +static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
> +{
> +	struct spi_device *spi = to_spi_device(data->dev);
> +	u8 tx_buf[MPR_MEASUREMENT_RD_SIZE];
> +	struct spi_transfer xfer;
> +
> +	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
> +		return -EOVERFLOW;
> +
> +	tx_buf[0] = cmd;
> +	xfer.tx_buf = tx_buf;
> +	xfer.rx_buf = data->buffer;
> +	xfer.len = pkt_len;
> +
> +	return spi_sync_transfer(spi, &xfer, 1);

Fairly sure that requires dma safe buffers which tx_buf is not.

> +}



