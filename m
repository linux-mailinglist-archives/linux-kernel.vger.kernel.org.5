Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316C0807732
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378951AbjLFSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378944AbjLFSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:00:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8024A122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:00:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8437C433C8;
        Wed,  6 Dec 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701885628;
        bh=MsDm6ySBk7Gn55vOi86nxzClQi3SSWxVXbvoAoJ6ceM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G7Y8wjq7QNhQqxOlpgNHOYbIusAelAxuhGLduCV/KAOL6A65APHP9Xj7/F7kjSiqy
         Bw/vC4pAQpURiRKx2AawNrySguLYu9bvoSZJrrAgNrjtIitMwpi3JXAlrBAxpvsAB2
         tvI5PF9AjvS4Q0HXkxCEPBn1ErWkRh34z9kwuPwfFIrug/Y315FT4fXbCC7fAqhj4T
         2nDAlIdstbvKtSvLNaqIy+TDbxDsNqYnsm1YSxd4V6NfQPC/ZaT5BSJJd5Ca6R6XG2
         yc8BPnLeSOsDP05rlBi4GJJun0zz+F9oZDY03Wo1a90qqCsdDTU0Kp+evYX+p/VLnJ
         gOwsOPOc7wvdw==
Date:   Wed, 6 Dec 2023 18:00:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Li peiyu <579lpy@gmail.com>
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: humidity: Add driver for ti HDC302x
 humidity sensors
Message-ID: <20231206180020.3f48652a@jic23-huawei>
In-Reply-To: <20231206135123.559547-1-579lpy@gmail.com>
References: <20231206134655.559474-1-579lpy@gmail.com>
        <20231206135123.559547-1-579lpy@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Wed,  6 Dec 2023 21:51:23 +0800
Li peiyu <579lpy@gmail.com> wrote:

> Add support for HDC302x integrated capacitive based relative
> humidity (RH) and temperature sensor.
> This driver supports reading values, reading the maximum and
> minimum of values and controlling the integrated heater of
> the sensor.
> 
> Co-developed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Signed-off-by: Li peiyu <579lpy@gmail.com>

Hi.

A few minor comments inline from a fresh thread through.

Jonathan

>  hts221-y := hts221_core.o \
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> new file mode 100644
> index 000000000000..8575eb00775e
> --- /dev/null
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -0,0 +1,468 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hdc3020.c - Support for the TI HDC3020,HDC3021 and HDC3022
> + * temperature + relative humidity sensors
> + *
> + * Copyright (C) 2023
> + *
> + * Datasheet: https://www.ti.com/lit/ds/symlink/hdc3020.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/bitops.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/cleanup.h>

This block should be in alphabetical order. (IIO convention, other bits
of the kernel use other weird ordering rules!)

J
> +struct hdc3020_data {
> +	struct i2c_client *client;
> +	/*
> +	 * Ensure that only one operation can communicate with the device
> +	 * at the same time.
Why? What is being protected.  State changes on device perhaps?  Good
to give more detail as it makes it easier to check the lock is used correctly
in the future.

> +	 */
> +	struct mutex lock;
> +};
> +
> +static const int hdc3020_heater_vals[] = {0, 1, 0x3FFF};
> +
> +static const struct iio_chan_spec hdc3020_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
> +		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
> +		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +	{
> +		/*
> +		 * For setting the internal heater, which can be switched on to
> +		 * prevent or remove any condensation that may develop when the
> +		 * ambient environment approaches its dew point temperature.
> +		 */
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate_available = 1,

This takes the same bits as info_mask_separate.
So BIT(IIO_CHAN_INFO_RAW) which is probably 1 but I haven't checked.  
> +		.output = 1,
> +	},
> +};

> +static int hdc3020_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct hdc3020_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {

Odd indent.  One table to many for the following few lines.

> +			guard(mutex)(&data->lock);
> +			ret = hdc3020_read_measurement(data, chan->type, val);
> +			if (ret < 0)
> +				return ret;
> +
> +			return IIO_VAL_INT;
> +	}
>
> +	case IIO_CHAN_INFO_SCALE:
> +		*val2 = 65536;
> +		if (chan->type == IIO_TEMP)
> +			*val = 175;
> +		else
> +			*val = 100;
> +		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type == IIO_TEMP)
> +			*val = 16852;

Seems backwards to check the type, but not deal with
it being wrong.  Check the inverse and return an error.

		if (chan->type != IIO_TEMP)
			return -EINVAL;

		*val = ...

> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}

> +
> +static int hdc3020_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hdc3020_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	crc8_populate_msb(hdc3020_crc8_table, HDC3020_CRC8_POLYNOMIAL);
> +
> +	indio_dev->name = "hdc3020";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hdc3020_info;
> +	indio_dev->channels = hdc3020_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
> +
> +	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Unable to set up measurement\n");
> +
> +	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_stop, data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to add device\n");

This isn't adding the device... So the error message needs an update.
It's vanishingly unlikely to actually happen, so fine to not have a message
at all for this one.

> +
> +	ret = devm_iio_device_register(&data->client->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to add device\n");
> +
> +	return 0;
> +}

