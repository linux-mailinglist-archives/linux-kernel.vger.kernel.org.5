Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524447F8B34
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjKYOGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:06:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F98127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:06:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2445DC433C8;
        Sat, 25 Nov 2023 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700921211;
        bh=xgu5CUNmadqhE0LLhfUEnVwZD/5HyWC4DIhQLmBk+Ms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ge/cX3qpZukqKrjNaMcG4B03IryQxEg5cNsuCcKS4JH/16IU1Boho/soQKvUiQ4HT
         ogRevvvwpVuc3lHLxDfixTXzpPNomA29OTaKWMlFDL4jlX+BU0BHUuUyG1rMo+SY/f
         I5bVWSCxeGRPNoibjDmlcruG7iXTDvGWIhxekepNf5GPHTF5QuW7l7lXFk1uK8lSs+
         +MFz/JZ2j5mhUYb5LqsqBAGewRKqeEbMAw3B1EXfmj7NzW3pfXMty3bG8xWCcSmYla
         B5yNNtc3qRGbdbrLPnXtJ2pRwsv1lyxlw5Yn5+bmU5Ggy8PYUhlHhezekXFad69gMr
         pSb99ATrOvfOg==
Date:   Sat, 25 Nov 2023 14:06:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] iio: light: driver for Lite-On ltr390
Message-ID: <20231125140641.08284929@jic23-huawei>
In-Reply-To: <20231117074554.700970-2-anshulusr@gmail.com>
References: <20231117074554.700970-1-anshulusr@gmail.com>
        <20231117074554.700970-2-anshulusr@gmail.com>
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

On Fri, 17 Nov 2023 13:15:53 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Implements driver for the Ambient/UV Light sensor LTR390.
> The driver exposes two ways of getting sensor readings:
>   1. Raw UV Counts directly from the sensor
>   2. The computed UV Index value with a percision of 2 decimal places
> 
> NOTE: Ambient light sensing has not been implemented yet.
> 
> Datasheet:
>   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
Make this a formal Datasheet tag, just before the Signed-off-by below

> 
> Driver tested on RPi Zero 2W
> 
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

Hi Anshul,

Some comments on this one inline.  Some of these overlap with comments on the
other drivers you've submitted. Normally I'd moan about sending too many drivers
at a time, but fair enough given you sent them out over a couple of weeks and just
happened to hit time when I was travelling.

My main question in here is why have the two channels - conversion looks linear
so you should be fine exposing IIO_CHAN_INFO_RAW + IIO_CHAN_INFO_SCALE on a
single channel and leaving userspace to do the maths.

Jonathan

> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> new file mode 100644
> index 000000000000..67ca028ce828
> --- /dev/null
> +++ b/drivers/iio/light/ltr390.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * IIO driver for Lite-On LTR390 ALS and UV sensor
> + * (7-bit I2C slave address 0x53)
> + *
> + * Based on the work of:
> + *   Shreeya Patel and Shi Zhigang (LTRF216 Driver)
> + *
> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
> + *
> + * Datasheet:
> + *   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
> + *
> + * TODO:
> + *   - Support for configurable gain and resolution

Not using PROCESSED will help with this, so I'd drop that even in this initial
driver.

> + *   - Sensor suspend/resume support
> + *   - Add support for reading the ALS
> + *   - Interrupt support

> + */
> +
> +#include <asm/unaligned.h>

Put this in a block of includes after the linux ones.

> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +
> +#define LTR390_DEVICE_NAME	    "ltr390"
> +
> +#define LTR390_MAIN_CTRL	    0x00
> +#define LTR390_PART_ID		    0x06
> +#define LTR390_UVS_DATA		    0x10
> +
> +#define LTR390_SW_RESET		    BIT(4)
> +#define LTR390_UVS_MODE		    BIT(3)
> +#define LTR390_SENSOR_ENABLE	    BIT(1)
> +
> +#define LTR390_PART_NUMBER_ID	    0xb
> +#define LTR390_FRACTIONAL_PERCISION 100
> +
> +/*
> + * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
> + * the sensor are equal to 1 UV Index [Datasheet Page#8].
> + *
> + * For the default resolution of 18-bit (integration time: 100ms) and default
> + * gain of 3x, the counts/uvi are calculated as follows:
> + * 2300 / ((3/18) * (100/400)) = 95.83
> + */
> +#define LTR390_COUNTS_PER_UVI 96
> +
> +/*
> + * Window Factor is needed when the device is under Window glass with coated
> + * tinted ink. This is to compensate for the light loss due to the lower
> + * transmission rate of the window glass and helps * in calculating lux.
> + */
> +#define LTR390_WINDOW_FACTOR 1
> +
> +struct ltr390_data {
> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +	struct mutex lock;

All locks need a comment explaining the scope of data they protect.
Note that regmap and the i2c bus will have their own locks by default
so I'm not sure you need one here at all as I'm not seeing read modify write
cycles or anything like that (I might be missing one though!)


> +};
> +
> +static const struct regmap_config ltr390_regmap_config = {
> +	.name = LTR390_DEVICE_NAME,
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.val_bits = 8,
> +};
> +
> +static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +	u8 recieve_buffer[3];
> +
> +	mutex_lock(&data->lock);

guard(mutex)(&data->lock); 
here then you can just return directly without worrying about manual
unlocking of the mutex.  This stuff is fairly new in the kernel but very
useful for cases like this!  I have a set of driver cleanup that I'll send
out that does this in a few IIO drivers, once I've caught up with reviews etc.

This isn't a critical path where we have to care that we will then unlock
after the maths to extract value in the final line of the function.

> +
> +	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
> +			       sizeof(recieve_buffer));
> +	if (ret) {
> +		dev_err(dev, "failed to read measurement data: %d\n", ret);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +	return get_unaligned_le24(recieve_buffer);
> +}
> +
> +static int ltr390_get_uv_index(struct ltr390_data *data)
> +{
> +	int ret;
> +	int uv_index;
> +
> +	ret = ltr390_register_read(data, LTR390_UVS_DATA);
> +	if (ret < 0)
> +		return ret;
> +
> +	uv_index = DIV_ROUND_CLOSEST(ret * LTR390_FRACTIONAL_PERCISION *
> +					     LTR390_WINDOW_FACTOR,
> +				     LTR390_COUNTS_PER_UVI);

This looks like a linear conversion.  Perhaps make it a userspace problem
as division much easier in userspace where floating point is available.

> +
> +	return uv_index;
> +}
> +

> +
> +static const struct iio_chan_spec ltr390_channels[] = {
> +	{
> +		.type = IIO_UVINDEX,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel2 = IIO_MOD_LIGHT_UV,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +	},
> +};
> +
> +static int ltr390_probe(struct i2c_client *client)
> +{
> +	struct ltr390_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret, part_number;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
There are quite a few &client->dev in here. I'd introduce
struct device *dev = &client->dev;
as a local variable then use that to shorten all those lines a little.

> +				     "regmap initialization failed\n");
> +
> +	data->client = client;
> +	i2c_set_clientdata(client, indio_dev);

Why set this? I don' think you are using it.

> +	mutex_init(&data->lock);
> +
> +	indio_dev->info = &ltr390_info;
> +	indio_dev->channels = ltr390_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltr390_channels);
> +	indio_dev->name = LTR390_DEVICE_NAME;

I prefer to see strings for names like this rather than making a reviewer
find the define to make sure it's of appropriate format etc.  Just duplicate
the string in the few places it's used.

> +
> +	ret = regmap_read(data->regmap, LTR390_PART_ID, &part_number);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to get sensor's part id: %d",
> +			ret);
dev_err_probe() for all error prints in probe(). Some of the functionality
won't matter in cases like this, but its cleaner anyway so use it everywhere
+ then a reviewer doesn't need to consider what might defer.

> +		return ret;
> +	}
> +	/* Lower 4 bits of `part_number` change with hardware revisions */
> +	if (part_number >> 4 != LTR390_PART_NUMBER_ID) {
> +		dev_err(&client->dev, "received invalid product id: 0x%x",
> +			part_number);
return dev_err_probe()

Also, to enable device tree fallback compatibles (used when a new part is
released that is completely compatible with a driver for an older one)
we don't want to error out here.  Fine to print a dev_info() message though
to indicate we don't know if the driver is compatible or not.  
Please check your other drivers for this (I may have missed it!)

> +		return -ENODEV;
> +	}
> +	dev_dbg(&client->dev, "LTR390, product id: 0x%x\n", part_number);
> +
> +	/* reset sensor, chip fails to respond to this, so ignore any errors */
> +	regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SW_RESET);
> +
> +	/* Wait for the registers to reset before proceeding */
> +	usleep_range(1000, 2000);
> +
> +	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
> +			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to enable the sensor: %d\n", ret);
return dev_err_probe()
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id ltr390_id[] = {
> +	{ LTR390_DEVICE_NAME, 0 },

That 0 adds nothing useful so drop it.

> +	{ /* Sentinel */ },
No comma after sentinal.
> +};
> +MODULE_DEVICE_TABLE(i2c, ltr390_id);
> +
> +static const struct of_device_id ltr390_of_table[] = {
> +	{ .compatible = "liteon,ltr390"},
uneven spacing.  Should be one before }
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ltr390_id_table);

Always build test as a module.  0-day pointed this out - name here is
wrong.

> +
> +static struct i2c_driver ltr390_driver = {
> +	.driver = {
> +		.name = LTR390_DEVICE_NAME,
> +		.of_match_table = ltr390_of_table,
> +	},
> +	.probe = ltr390_probe,
> +	.id_table = ltr390_id,
> +};
> +
trivial, but we often don't have a blank line here as the
structure only exists to pass to module_i2c_driver() macro so
we might as well group them together.
> +module_i2c_driver(ltr390_driver);
> +
> +MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
> +MODULE_DESCRIPTION("Lite-On LTR390 ALS and UV sensor Driver");
> +MODULE_LICENSE("GPL");

