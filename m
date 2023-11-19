Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6D7F0704
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjKSPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjKSPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:02:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C6126
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:02:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146E5C433CA;
        Sun, 19 Nov 2023 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700406160;
        bh=diJ6YDu9UXGGquL+z5uLmO5HkizQcp+FNce3fqbLgu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nn7WIHfw2RVFIzlXcY6pmOfeHPqsUu4Vc5a5mhthoAsFlLYnxh4nevODIqBtQSXG5
         fluj/6mAQYnlVUvazQCMR5N6XVJV2wJw9kl6y8wy+VuZ32GsHcXkYmL5ZAfP3cTtwa
         xvSTMnFFXegtkQhFyZpC7a23kEzpxUQ0+zW88z17yaFdZ0LP630uU6l22fztIMcFOD
         usUBauQd1VK8AZcRd8L0MDgg9icFKfYXeiRqW0kdqYx6Jkg3T2kxaEulTu32LGqoa2
         LXJnjxhRkGI9EWMndJTzezCYXPOt91kf3Eei5w/WMQCrDE1uOs+hx2qhZQfy/XzrTl
         QfhcZpiT+/jTQ==
Date:   Sun, 19 Nov 2023 15:02:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: add VEML6075 UVA and UVB light sensor
 driver
Message-ID: <20231119150233.10fdc66e@jic23-huawei>
In-Reply-To: <20231110-veml6075-v1-1-354b3245e14a@gmail.com>
References: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
        <20231110-veml6075-v1-1-354b3245e14a@gmail.com>
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

On Sun, 19 Nov 2023 05:58:03 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The Vishay VEMl6075 is a low power, 16-bit resolution UVA and UVB
> light sensor with I2C interface and noise compensation (visible and
> infrarred).
> 
> Every UV channel generates an output measured in counts per integration
> period. Available integration times are 50 ms, 100 ms, 200 ms, 400 ms
> and 800 ms,
> 
> This driver adds support for both UV channels and the ultraviolet
> index (UVI) inferred from them according to the device application note
> with open-air (no teflon) coefficients.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Javier,

Various comments inline, but all minor stuff. Looks good in general to me.

Jonathan

...

> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c0db4c4c36ec..c8289e24e3f6 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -60,5 +60,6 @@ obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>  obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
>  obj-$(CONFIG_VEML6030)		+= veml6030.o
>  obj-$(CONFIG_VEML6070)		+= veml6070.o
> +obj-$(CONFIG_VEML6075)		+= veml6075.o
>  obj-$(CONFIG_VL6180)		+= vl6180.o
>  obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> new file mode 100644
> index 000000000000..b7d9319c3906
> --- /dev/null
> +++ b/drivers/iio/light/veml6075.c
> @@ -0,0 +1,503 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * veml6075.c - Support for Vishay VEML6075 UVA and UVB light sensor

Little point in having the filename inside the file comments. Just makes it
a pain to move if we ever do and adds little of use.
Arguably "Support for" also a bit pointless.
Vishay VEML... 
is what Id' keep.

> + *
> + * Copyright 2023 Javier Carrasco <javier.carrasco.cruz@gmail.com>
> + *
> + * IIO driver for VEML6075 (7-bit I2C slave address 0x10)

The IIO and driver bit is obvious from the file.  Fine to keep the address
if you like.

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

You won't need sysfs.h after the changes suggested inline.
Every time it is included, it's a signal to reviewers to take a close
look at the ABI.  There are still reasons to use it but they normally
mean there should be additional documentation as well in the patch.

> +
> +#define VEML6075_DRIVER_NAME "veml6075"

As mentioned below, even though there are several uses of this I'd
rather see the string inline than hidden behind a define.

> +
> +#define VEML6075_CMD_CONF	0x00 /* configuration register */
> +#define VEML6075_CMD_UVA	0x07 /* UVA channel */
> +#define VEML6075_CMD_UVB	0x09 /* UVB channel */
> +#define VEML6075_CMD_COMP1	0x0A /* visible light compensation */
> +#define VEML6075_CMD_COMP2	0x0B /* infrarred light compensation */
> +#define VEML6075_CMD_ID		0x0C /* device ID */
> +
> +#define VEML6075_CONF_IT	GENMASK(6, 4) /* intregration time */
> +#define VEML6075_CONF_HD	BIT(3) /* dynamic setting */
> +#define VEML6075_CONF_TRIG	BIT(2) /* trigger */
> +#define VEML6075_CONF_AF	BIT(1) /* active force enable */
> +#define VEML6075_CONF_SD	BIT(0) /* shutdown */
> +
> +#define VEML6075_CONF_IT_50	0x00 /* integration time 50 ms */
Rename them to _IT_50_MS etc and drop the comments as they only really
tell us the unit.  The other part is fairly obvious.
> +#define VEML6075_CONF_IT_100	0x01 /* integration time 100 ms */
> +#define VEML6075_CONF_IT_200	0x02 /* integration time 200 ms */
> +#define VEML6075_CONF_IT_400	0x03 /* integration time 400 ms */
> +#define VEML6075_CONF_IT_800	0x04 /* integration time 800 ms */
> +
> +/* Open-air coefficients and responsivity */
> +#define VEML6075_A_COEF		2220
> +#define VEML6075_B_COEF		1330
> +#define VEML6075_C_COEF		2950
> +#define VEML6075_D_COEF		1740
> +#define VEML6075_UVA_RESP	1461
> +#define VEML6075_UVB_RESP	2591
> +
> +static const int veml6075_it_ms[] = { 50, 100, 200, 400, 800 };
> +static const char veml6075_it_ms_avail[] = "50 100 200 400 800";

A strong reason for using read_avail() is that you can just use the
array of numbers. See below for more on this.

> +
> +struct veml6075_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct mutex lock; /* register access lock */

regmap provides register locking as typically does the bus lock, so good to
say exactly what you mean here.  Is there a Read Modify Write cycle you need
to protect for instance, or consistency across multiple register accesses?

> +};

> +
> +static const struct iio_chan_spec veml6075_channels[] = {
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel = CH_UVA,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_UV,
> +		.extend_name = "UVA",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel = CH_UVB,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_UV,
> +		.extend_name = "UVB",

Extent name is very rarely used any more.  It's a horrible userspace interface
and an old design mistake. 
Instead we use the channel label infrastructure.  Provide the read_label()
callback to use that instead.

I'm not sure this is a great solution here though.  For some similar cases
such as visible light colours we've just added additional modifiers, but that
doesn't really scale to lots of sensitive ranges.

One thing we have talked about in the past, but I don't think we have done in
a driver yet, is to provide actual characteristics of the sensitivity graph.
Perhaps just a wavelength of maximum sensitivity?

Visible light sensors often have hideous sensitivity curves, including sometimes
have multiple peaks, but in this case they look pretty good.
Do you think such an ABI would be more useful than A, B labelling?



> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type = IIO_UVINDEX,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +};
> +
> +static IIO_CONST_ATTR_INT_TIME_AVAIL(veml6075_it_ms_avail);
> +
> +static struct attribute *veml6075_attributes[] = {
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
Use the core support for handling available callbacks.
See read_avail() and the matching bit masks.

That makes this info accessible to in kernel consumers + is generally
cleaner than hand rolling an attribute.  We have a lot of drivers
that predate that core code existing and haven't yet converted them
all over so you'll find plenty of code that looks like yours in the tree.
It's just out of date style wise.

Note you won't need iio/sysfs.h after that change.

> +	NULL,
> +};

...

> +
> +static int veml6075_read_uvb_count(struct veml6075_data *data, int *uvb)
> +{
> +	return regmap_read(data->regmap, VEML6075_CMD_UVB, uvb);

Up to you, but to my mind wrappers that basically do nothing beyond calling
regmap_read() don't aid code readability - so you might as well call the regmap_read
inline.

> +}
> +
> +static int veml6075_read_uv_direct(struct veml6075_data *data, int chan,
> +				   int *val)
> +{
> +	int c1, c2, ret;
> +
> +	ret = veml6075_request_measurement(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = veml6075_read_comp(data, &c1, &c2);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (chan) {
> +	case CH_UVA:
> +		ret = veml6075_read_uva_count(data, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = veml6075_uva_comp(*val, c1, c2);
> +		break;
> +	case CH_UVB:
> +		ret = veml6075_read_uvb_count(data, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = veml6075_uvb_comp(*val, c1, c2);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
return directly above. Lets us see the type right next to the functions
filling in val.

> +}


> +
> +static int veml6075_read_responsivity(int chan, int *val, int *val2)
> +{
> +	/* scale = 1 / resp */
> +	switch (chan) {
> +	case CH_UVA:
> +		/* resp = 0.93 c/uW/cm2: scale = 1.75268817 */
> +		*val = 1;
> +		*val2 = 75268817;
> +		break;
> +	case CH_UVB:
> +		/* resp = 2.1 c/uW/cm2: scale = 0.476190476 */
> +		*val = 0;
> +		*val2 = 476190476;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT_PLUS_NANO;
return instead of break above, so the formatting is right next to the values.

> +}
> +
> +static int veml6075_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct veml6075_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
> +		ret = veml6075_read_uv_direct(data, chan->channel, val);
> +		break;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		mutex_lock(&data->lock);

Use guard(mutex)(&data->lock); and appropriate scope (add {})
so you can return directly from each of these.
Current scheme of unlocking is nasty.

Note that if we didn't have those, just unlocking before break;
in each of these would be better than what you currently have where
the lock scope is hard to follow.

> +		ret = veml6075_read_uvi(data, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		mutex_lock(&data->lock);
> +		ret = veml6075_read_int_time_ms(data, val);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		return veml6075_read_responsivity(chan->channel, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int veml6075_write_int_time_ms(struct veml6075_data *data, int val)
> +{

> +	int conf, i = ARRAY_SIZE(veml6075_it_ms);

Don't combine variable declarations that set values with ones that don't.
It's just a little bit hard to read, so better to use multiple lines if
you are setting values.

> +
> +	while (i-- > 0) {
> +		if (val == veml6075_it_ms[i])
> +			break;
> +	}
> +	if (i < 0)
> +		return -EINVAL;
> +
> +	conf = FIELD_PREP(VEML6075_CONF_IT, i);

Put this conf inline in the call below.  Saves us a few lines and
an unnecessary local variable.

> +
> +	return regmap_update_bits(data->regmap, VEML6075_CMD_CONF,
> +				  VEML6075_CONF_IT, conf);
> +}
> +
> +static int veml6075_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct veml6075_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		mutex_lock(&data->lock);

A nice place to use the new automated guard stuff.
Cleanest here is probably scoped_guard.

	case IIO_CHAN_INFO_INT_TIME: {
		guard(mutex)(&data->lock);
		return veml6075_write_int_time_ms(data, val);
	}
> +		ret = veml6075_write_int_time_ms(data, val);
> +		mutex_unlock(&data->lock);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +

Then drop this return ret; Which incidentally can return uninitialized values
in current code.  Also worth noting this would still be needed if you did a
scoped_guard() above in order to squash a compiler warning.

> +	return ret;
> +}
> +
> +static const struct iio_info veml6075_info = {
> +	.read_raw = veml6075_read_raw,
> +	.write_raw = veml6075_write_raw,
> +	.attrs = &veml6075_attribute_group,
> +};
...

> +
> +static int veml6075_probe(struct i2c_client *client)
> +{
> +	struct veml6075_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int config, ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &veml6075_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	data->regmap = regmap;
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = VEML6075_DRIVER_NAME;

As below, I'd rather see the string here.

> +	indio_dev->info = &veml6075_info;
> +	indio_dev->channels = veml6075_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(veml6075_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable_optional(&client->dev, "vdd");

Main power supplies tend not to be optional... They may not have been specified
if they are always on, but in that case the regulator framework will provide us
with a fake regulator anyway so that's safe.  Hence just
devm_regulator_get_enable()



> +	if (ret < 0 && ret != -ENODEV)
> +		return ret;
> +
> +	/* default: 100ms integration time, active force enable, shutdown */
> +	config = FIELD_PREP(VEML6075_CONF_IT, VEML6075_CONF_IT_100) |
> +		VEML6075_CONF_AF | VEML6075_CONF_SD;

For consistency, use FIELD_PREP for all fields, even the single bit ones.

> +	ret = regmap_write(data->regmap, VEML6075_CMD_CONF, config);
> +	if (ret < 0)
> +		return ret;
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static void veml6075_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);

Finding just a device unregister in here is odd...
If you need to handle this manually as opposed to
devm_iio_device_register() and automated cleanup, then there would need
to be something else to do first.

> +}
> +
> +static const struct i2c_device_id veml6075_id[] = {
> +	{ "veml6075", 0 },

The 0 isn't used so I wouldn't set it explicitly - it will be zeroed anyway
due to how C handles this sort of initializer.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, veml6075_id);
> +
> +static const struct of_device_id veml6075_of_match[] = {
> +	{ .compatible = "vishay,veml6075" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, veml6075_of_match);
> +
> +static struct i2c_driver veml6075_driver = {
> +	.driver = {
> +		.name   = VEML6075_DRIVER_NAME,
I'm not a fan of putting a string used as a device indentifier behind
a define as I like to be able to quickly check what .name is set to.
So I'd rather just see the string inline in all the places this is used.

Jonathan


