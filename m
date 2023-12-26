Return-Path: <linux-kernel+bounces-11583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1081E883
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3091F21AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BDB4F887;
	Tue, 26 Dec 2023 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjTIIcxg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C64F612;
	Tue, 26 Dec 2023 16:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4722FC433C8;
	Tue, 26 Dec 2023 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703609367;
	bh=AY4SBbe9wQAPj8fiGXaTO0vwoGHZ0Hp5cbz7yRNOd2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bjTIIcxgg1Gf5CmsGBwmTqKsxtnnMEMYZyWDtyekTvXc8307J0nu1MzRIdl7EGOXy
	 WipoHANZcSsPGX9VdHTU9tcTuYcU5zZnk3cJKoXf09S3Vb3VEgR7Sxkei0WKr1nKCS
	 gLSEi8SwcqV/NoAJYhbJisjtYSj/zDYrP0FY7qUN0d4E06nVszoBx0MLzQz02bjjip
	 X1Vm8i8kvFwB02HCYZpBprK+lHZbmID07Z2w1uSsxYVZpRruw3mr7wPFkjqnzyQBE5
	 YhJATQHT3/yGTSIAWJSINw9oboJJfJ877XsLqXhjoQk/cNTpaMFrvqmLByFV5o+IVg
	 bld/CeYSO/2jw==
Date: Tue, 26 Dec 2023 16:49:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Klinger
 <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 08/10] iio: pressure: mprls0025pa.c refactor
Message-ID: <20231226164922.6d7132c1@jic23-huawei>
In-Reply-To: <20231224143500.10940-9-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-9-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Dec 2023 16:34:53 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Refactor driver by splitting the code into core and i2c.
> 
> Seemingly redundant read/write function parameters are required for
> compatibility with the SPI driver.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

A few minor comments inline.

Thanks,

Jonathan


> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> index e14cdee7989f..cb5d6c0cca7e 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
...

> -static int mpr_probe(struct i2c_client *client)
> +int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
>  {
>  	int ret;
>  	struct mpr_data *data;
>  	struct iio_dev *indio_dev;
> -	struct device *dev = &client->dev;
>  	s64 scale, offset;
>  	u32 func;
> 
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
> -		return dev_err_probe(dev, -EOPNOTSUPP,
> -					"I2C functionality not supported\n");
> -
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> -		return dev_err_probe(dev, -ENOMEM, "couldn't get iio_dev\n");
> +		return -ENOMEM;
> 
>  	data = iio_priv(indio_dev);
> -	data->client = client;
> -	data->irq = client->irq;
> +	data->dev = dev;
> +	data->ops = ops;
> +	data->irq = irq;
> 
>  	mutex_init(&data->lock);
>  	init_completion(&data->completion);
> @@ -350,32 +284,36 @@ static int mpr_probe(struct i2c_client *client)
>  		return dev_err_probe(dev, ret,
>  				"can't get and enable vdd supply\n");
> 
> -	if (dev_fwnode(dev)) {

So you now rely on device_property_read_u32() failing I guess to cover this
which is fine.  However do that in the earlier patch instead of burying that
change in here.

Should make it easier to tell what changed here as well.


> -		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
> +	ret = data->ops->init(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_read_u32(dev,
> +				       "honeywell,transfer-function", &func);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			     "honeywell,transfer-function could not be read\n");
> +	data->function = func - 1;
> +	if (data->function > MPR_FUNCTION_C)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "honeywell,transfer-function %d invalid\n",
> +				     data->function);
> +
> +	ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
>  					       &data->pmin);
> -		if (ret)
> -			return dev_err_probe(dev, ret,
> +	if (ret)
> +		return dev_err_probe(dev, ret,
>  				   "honeywell,pmin-pascal could not be read\n");
> 
> -		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> -					       &data->pmax);
> -		if (ret)
> -			return dev_err_probe(dev, ret,
> +	ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> +				       &data->pmax);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
>  				   "honeywell,pmax-pascal could not be read\n");
> -		ret = device_property_read_u32(dev,
> -				"honeywell,transfer-function", &func);
> -		if (ret)
> -			return dev_err_probe(dev, ret,
> -				"honeywell,transfer-function could not be read\n");
> -		data->function = func - 1;
> -		if (data->function > MPR_FUNCTION_C)
> -			return dev_err_probe(dev, -EINVAL,
> -				"honeywell,transfer-function %d invalid\n",
> -								data->function);
> -	} else {
> +
> +	if (data->pmin >= data->pmax)
>  		return dev_err_probe(dev, -EINVAL,
> -				  "driver needs to be initialized in the dt\n");
> -	}
> +				     "pressure limits are invalid\n");
> 
>  	data->outmin = mpr_func_spec[data->function].output_min;
>  	data->outmax = mpr_func_spec[data->function].output_max;
> @@ -394,7 +332,7 @@ static int mpr_probe(struct i2c_client *client)
> 
>  	if (data->irq > 0) {
>  		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> -				IRQF_TRIGGER_RISING, client->name, data);
> +				      IRQF_TRIGGER_RISING, dev_name(dev), data);

Even though you'll change it again here, would have been nice to have
the alignment fixed in the earlier patch then the code update here.

>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					  "request irq %d failed\n", data->irq);
> @@ -421,29 +359,8 @@ static int mpr_probe(struct i2c_client *client)
> 
>  	return 0;
>  }


...


> diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
> new file mode 100644
> index 000000000000..89d6a206192b
> --- /dev/null
> +++ b/drivers/iio/pressure/mprls0025pa_i2c.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MPRLS0025PA - Honeywell MicroPressure pressure sensor series driver
> + *
> + * Copyright (c) Andreas Klinger <ak@it-klinger.de>
> + *
> + * Data sheet:
> + *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>

Why include this?  Can't see an IIO specific stuff in here.


> +
> +#include "mprls0025pa.h"
> +
> +static int mpr_i2c_init(struct device *unused)
> +{
> +	return 0;
> +}
> +
> +static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
> +{
> +	int ret;
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +
> +	if (cnt > MPR_MEASUREMENT_RD_SIZE)
> +		return -EOVERFLOW;
> +
> +	memset(data->buffer, 0, MPR_MEASUREMENT_RD_SIZE);
> +	ret = i2c_master_recv(client, data->buffer, cnt);
> +	if (ret != cnt) {
> +		return -EIO;
As below.

> +	}
> +
> +	return 0;
> +}
> +
> +static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
> +{
> +	int ret;
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +	u8 wdata[MPR_PKT_SYNC_LEN];
> +
> +	memset(wdata, 0, sizeof(wdata));
> +	wdata[0] = cmd;
> +
> +	ret = i2c_master_send(client, wdata, MPR_PKT_SYNC_LEN);
> +	if (ret != MPR_PKT_SYNC_LEN) {

No {} as per Coding Style docs for single statement blocks like this.

Ideally we tend to handle ret < 0 separately from ret != MPR_PKT_SYNC_LEN
as then we don't eat a possible more useful error code.



> +		return -EIO;
> +	}
> +
> +	return 0;
> +}


