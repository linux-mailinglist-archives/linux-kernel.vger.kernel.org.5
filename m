Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FA7F94BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjKZR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:57:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E1DE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:57:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D97C433C9;
        Sun, 26 Nov 2023 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701021452;
        bh=y4Qt+uCCLxYMjJVpRtNnL0sHbol8OhGFOSiObKkTYeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IHGg6a1FmpW9XCQQw6d4kXf618dBRiCoypT/+Me3gf3fc/IG24f6Squ0udYEBiGrj
         rnTIEwwgjztXlNR6tF8tr7xBNJLG9w62QHSvOkAq+/VMmFbYXrbYPf17X8KkMiv89c
         03IGRhg/wEwfTR37HqwXNs8bQfgntjPnSHITnrESWvy5QajfkB4SUssGRcaoZi8jeT
         3rz2taPQOKPg2fJPnvRvaN3XkiUsRwXpgBVbyNADdEFeVqbzTdAnIqaBfeXn1PD13N
         q4RuNRAy32uHpfZZaiX//rbrMdKU+UFIrx818I8Q37KE2HI9Psa/Qe4eUvNSPbkwmn
         q+nKRqEaaic0A==
Date:   Sun, 26 Nov 2023 17:57:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: temperature: Add support for AMS AS6200
Message-ID: <20231126175726.1ec003c5@jic23-huawei>
In-Reply-To: <cbde9aa61905a0fae6573d707b4c9c4fc4598fa5.1699740057.git.alkuor@gmail.com>
References: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
        <cbde9aa61905a0fae6573d707b4c9c4fc4598fa5.1699740057.git.alkuor@gmail.com>
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

On Sat, 11 Nov 2023 17:05:02 -0500
Abdel Alkuor <alkuor@gmail.com> wrote:

> as6200 is a high accuracy temperature sensor of 0.0625C with a range
> between -40 to 125 Celsius degrees. The driver implements the alert
> trigger event in comparator mode where an alert would trigger
> when n number of consecutive current temperature is above the upper
> temp limit, and the alert is only cleared when the n number of
> consecutive current temperature is below the lower temp limit.
> 
Hi Abdel,

Comments inline.  Sorry it took so long for you get a review.  I've been
travelling + snowed under since returning.
Seems like a very feature rich driver whilst still being nice and short :)

> The driver supports the following:
> - show available sampling frequencey
> - read/write sampling frequency
> - read raw temperature
> - read scaling factor
> - read/write consective faults to trigger/clear an alert
> - show available consecutive faults
> - buffer trigger
> - temperature alert event trigger
> 
> https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf

Use a formal tag in the tag block for this.

> 
Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>



> ---
>  drivers/iio/temperature/Kconfig  |   9 +
>  drivers/iio/temperature/Makefile |   1 +
>  drivers/iio/temperature/as6200.c | 507 +++++++++++++++++++++++++++++++
>  3 files changed, 517 insertions(+)
>  create mode 100644 drivers/iio/temperature/as6200.c
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index ed384f33e0c7..f32691744952 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -157,5 +157,14 @@ config MAX31865
>  
>  	  This driver can also be build as a module. If so, the module
>  	  will be called max31865.
blank line.  Also should be in alphabetical order, not down the end of the file.

Appending to the end causes a lot more trouble for merging multiple series than
alphabetical order, which is one reason we always try to keep these files in order.

> +config AS6200
> +       tristate "AS6200 temperature sensor"
> +       depends on I2C
> +       help
> +         If you say yes here you get support for AS6200
> +         temperature sensor chip connected via I2C.
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called as6200.
>  
>  endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index dfec8c6d3019..48f647c273c1 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_TMP007) += tmp007.o
>  obj-$(CONFIG_TMP117) += tmp117.o
>  obj-$(CONFIG_TSYS01) += tsys01.o
>  obj-$(CONFIG_TSYS02D) += tsys02d.o
> +obj-$(CONFIG_AS6200) += as6200.o
Alphabetical order.

> diff --git a/drivers/iio/temperature/as6200.c b/drivers/iio/temperature/as6200.c
> new file mode 100644
> index 000000000000..a18c5be0a229
> --- /dev/null
> +++ b/drivers/iio/temperature/as6200.c
> @@ -0,0 +1,507 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for AMS AS6200 Temperature sensor
> + *
> + * Auther: Abdel Alkuor <alkuor@gmail.com>
Spell check comments Author.
> + */
> +
> +#include <linux/i2c.h>

Alphabetical order, but it's common to have the iio/*
headers as a separate block afterwards given this is an IIO driver.

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/device.h>
> +#include <linux/bitfield.h>
> +#include <linux/kstrtox.h>
> +
> +#define AS_TVAL_REG	0x0

Probably want a more specific prefix.
AS6200_TVAL_REG etc

> +#define AS_CONFIG_REG	0x1
> +#define AS_TLOW_REG	0x2
> +#define AS_THIGH_REG	0x3
> +
> +/* AS_CONFIG_REG */
The register and field naming should make it clear enough which register
these are in.  It think that is true here so you don't need the comment.
Excess comments are just opportunities for code rot so keep them for when
they add significant value.

> +#define AS_CONFIG_AL	BIT(5)
> +#define AS_CONFIG_CR	GENMASK(7, 6)
> +#define AS_CONFIG_SM	BIT(8)
> +#define AS_CONFIG_IM	BIT(9)
> +#define AS_CONFIG_POL	BIT(10)
> +#define AS_CONFIG_CF	GENMASK(12, 11)
> +
> +#define AS_TEMP_SCALE		62500

This isn't a magic number, it's an actual quantity. As such, just put the
number inline in the code rather than use a define that just makes it harder
to review.

> +
> +struct as6200_freq {
> +	int val;
> +	int val2;
> +};

I don't mind the structure, but not sure it adds much over a simple 2d array of
integers given the ordering of val and val2 is fairly natural anyway.

> +
> +struct as6200 {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex lock;
All locks need a comment to explain what data they are protecting.

> +	struct iio_dev *indio_dev;

You may have noticed this is almost never done in IIO drivers. It normally
indicates a problem with the architecture.  There is a natural way to go
from iio_dev to iio_priv() so we shouldn't nee to go the other way.

If you did need to have a remove() (which you don't - see later) then
should by the struct iio_dev * in the i2c_clientdata not the
iio_priv() structure.

> +
> +	unsigned int data[3];
> +};
> +
> +static const struct as6200_freq as6200_samp_freq[4] = {
> +	{0, 250000},

Trivial: Slight preference for more spaces { 0, 2500000 },

> +	{1, 0},
> +	{4, 0},
> +	{8, 0},
> +};
> +
> +static const struct iio_event_spec as6200_temp_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> +	},
> +};
> +
> +static const struct iio_chan_spec as6200_temp_channels[] = {

There aren't any other channels so as6200_channels is enough.

> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 0,
That's the 'obvious' default so don't provide it.
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_index = 0,

With .indexed =0, this isn't used so no need to specify it here.

> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.shift = 4,
> +		},
> +		.event_spec = as6200_temp_event,
> +		.num_event_specs = ARRAY_SIZE(as6200_temp_event),
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static const struct regmap_config as6200_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = 0x7F,
> +};
> +
> +static int
> +as6200_modify_config_reg(struct as6200 *as, unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	ret = regmap_read(as->regmap, AS_CONFIG_REG, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg &= ~mask;
> +	reg |= val << (ffs(mask) - 1);
> +
> +	return regmap_write(as->regmap, AS_CONFIG_REG, reg);

regmap has functions to handle a read modify write cycle as simple as this.
Use those instead of inventing your own.  regmap_update_bits() for example

They also hold the regmap lock over the whole cycle which can simplify locking
requirements on a driver using it.


> +}
> +
> +static int
> +as6200_read_config_reg(struct as6200 *as, unsigned int mask, unsigned int *val)

All the masks passed to this are constant, so it would be better to just
put something like

	ret = regmap_read(as->regmap, AS_CONFIG_REG, &reg);
	if (ret)
		return ret;

	x = FIELD_GET(reg, MASK);

inline and get rid of this function entirely.

> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	ret = regmap_read(as->regmap, AS_CONFIG_REG, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*val = (reg & mask) >> (ffs(mask) - 1);
> +
> +	return 0;
> +}
> +

> +
> +static int as6200_read_event_value(struct iio_dev *indio_dev,
> +			 const struct iio_chan_spec *chan,
> +			 enum iio_event_type type,
> +			 enum iio_event_direction dir,
> +			 enum iio_event_info info,
> +			 int *val, int *val2)
> +{
> +	struct as6200 *as = iio_device_get_drvdata(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +	unsigned int temp;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_FALLING:
> +		reg = AS_TLOW_REG;
> +		break;
> +	case IIO_EV_DIR_RISING:
> +		reg = AS_THIGH_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(as->regmap, reg, &temp);
> +	if (ret)
> +		return ret;
> +
> +	*val = sign_extend32(temp >> 4, 11);

That shift looks like it should be handled via a FIELD_GET()
an appropriate mask.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int as6200_write_event_value(struct iio_dev *indio_dev,
> +			  const struct iio_chan_spec *chan,
> +			  enum iio_event_type type,
> +			  enum iio_event_direction dir,
> +			  enum iio_event_info info,
> +			  int val, int val2)
> +{
> +	struct as6200 *as = iio_device_get_drvdata(indio_dev);

Why? You have the iio_dev so
	struct as6000 *as = iio_priv(indio_dev);

> +	unsigned int temp;
> +	unsigned int reg;
> +
> +	/*
> +	 * range without applying the scaling
> +	 * factor of 0.06250
> +	 */
> +	if (val > 2000 || val < -640)
> +		return -EINVAL;
> +
> +	temp = (val & 0xfff) << 4;

FIELD_PREP() with appropriately defined _MASK

> +
> +	switch (dir) {
> +	case IIO_EV_DIR_FALLING:
> +		reg = AS_TLOW_REG;
> +		break;
> +	case IIO_EV_DIR_RISING:
> +		reg = AS_THIGH_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_write(as->regmap, reg, temp);
> +}
> +
> +static irqreturn_t as6200_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct as6200 *as = iio_device_get_drvdata(indio_dev);
As above.
> +	unsigned int alert;
> +	enum iio_event_direction dir;
> +	int ret;
> +
> +	mutex_lock(&as->lock);
	guard(mutex)(&as->lock);

then you don't need to do any manual unlocking.

> +
> +	ret = as6200_read_config_reg(as, AS_CONFIG_AL, &alert);
> +	if (ret) {
> +		mutex_unlock(&as->lock);
> +		return IRQ_NONE;
> +	}
> +
> +	dir = alert ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> +
> +	iio_push_event(indio_dev,
> +		       IIO_EVENT_CODE(IIO_TEMP, 0, 0,
> +				      dir,
> +				      IIO_EV_TYPE_THRESH,
> +				      0, 0, 0),
> +		       iio_get_time_ns(indio_dev));
> +
> +	mutex_unlock(&as->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t as6200_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct as6200 *as = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&as->lock);

	scoped_guard(mutex, &as->lock) {
		ret = regmap_read(as->regmap, AS_TVAL_REG, &as->data[0]);
		if (ret)
			break;

		iio_push_to_buffers_with_timestamp(indio_dev, as->data,
						   iio_get_time_ns(indio_dev));

However, data isn't big enough. It should contain enough space for the data + 
a naturally aligned s64 (so 16 bytes).  This interface is deeply unintuitive
but we have been stuck with it for a long time now :(

Also, I'm not sure why we can't just have data on the stack and if we do,
is there a need for the lock?

	}

	iio_trigger_notify_done()....

	
> +
> +	ret = regmap_read(as->regmap, AS_TVAL_REG, &as->data[0]);
> +	if (!ret)
> +		iio_push_to_buffers_with_timestamp(indio_dev, as->data,
> +						   iio_get_time_ns(indio_dev));
> +
> +	mutex_unlock(&as->lock);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +

> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.25 1 4 8");
> +static IIO_CONST_ATTR(avail_consecutive_faults, "1 2 4 6");
> +static IIO_DEVICE_ATTR_RW(consecutive_faults, 0);
> +
> +static struct attribute *as6200_event_attributes[] = {
> +	&iio_const_attr_avail_consecutive_faults.dev_attr.attr,
> +	&iio_dev_attr_consecutive_faults.dev_attr.attr,
Custom ABI, so should be some documentation.

I'm guessing a bit, but sounds like the standard ABI period
to me.
https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-iio#L1163

However you will need to take into account current sampling frequency
and provide this in seconds as per the documentation.

It's absolutely fine to have available change with the sampling
frequency.

> +	NULL,
> +};
> +
> +static struct attribute *as6200_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,

For this one, use read_avail() and appropriate bitmaps.
That both reduces manual handling of attributes and allows in kernel
consumers to potentially access this parameter.

> +	NULL,
> +};
> +
> +static const struct attribute_group as6200_attribute_group = {
> +	.attrs = as6200_attributes,
> +};
> +
> +static const struct attribute_group as6200_event_attribute_group = {
> +	.attrs = as6200_event_attributes,
> +};
> +
> +static const struct iio_info as6200_temp_info = {
> +	.event_attrs = &as6200_event_attribute_group,
> +	.attrs = &as6200_attribute_group,
> +	.read_raw = &as6200_read_raw,
> +	.write_raw = &as6200_write_raw,
> +	.read_event_value = &as6200_read_event_value,
> +	.write_event_value = &as6200_write_event_value,
> +};
> +
> +static int as6200_probe(struct i2c_client *client)
> +{
> +	struct as6200 *as;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EINVAL;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, 0);
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	as = devm_kzalloc(&client->dev, sizeof(*as), GFP_KERNEL);
> +	if (IS_ERR(as))
> +		return PTR_ERR(as);
> +
> +	as->regmap = devm_regmap_init_i2c(client, &as6200_regmap_config);
> +	if (IS_ERR(as->regmap))
> +		return PTR_ERR(as->regmap);
> +
> +	mutex_init(&as->lock);
> +
> +	as->dev = &client->dev;
> +	as->indio_dev = indio_dev;
> +
> +	iio_device_set_drvdata(indio_dev, as);
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = as6200_temp_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as6200_temp_channels);
> +	indio_dev->name = client->name;

Encode the string directly here. The different firmware types fill client->name
in via various fragile means. Things are safer if we don't rely on that.

> +	indio_dev->info = &as6200_temp_info;
> +
> +	ret = devm_iio_triggered_buffer_setup(as->dev, indio_dev,
> +					      NULL,
> +					      as6200_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(as->dev,
> +						client->irq,
> +						NULL,
> +						&as6200_event_handler,
> +						IRQF_ONESHOT,
> +						client->name,
> +						indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	i2c_set_clientdata(client, as);
> +
> +	return iio_device_register(indio_dev);

As only thing in remove is iio_device_unregister() use
	return devm_iio_device_register(indio_dev);
and drop remove() callback entirely.

> +}
> +
> +static void as6200_remove(struct i2c_client *client)
> +{
> +	struct as6200 *as = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(as->indio_dev);
> +}

...

> +
> +static const struct dev_pm_ops as6200_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(as6200_suspend, as6200_resume)
> +};
> +
> +static const struct i2c_device_id as6200_id_table[] = {
> +	{ "as6200" },
> +	{ },
As below.

> +};
> +MODULE_DEVICE_TABLE(i2c, as6200_id_table);
> +
> +static const struct of_device_id as6200_of_match[] = {
> +	{ .compatible = "ams,as6200" },
> +	{ },

No point in a , after a 'NULL' like terminator as we will 
never add anything after it.

> +};
> +MODULE_DEVICE_TABLE(of, as6200_of_match);
> +
> +static struct i2c_driver as6200_driver = {
> +	.driver = {
> +		.name = "as6200",
> +		.pm = &as6200_pm_ops,
		.pm = pm_sleep_ptr(&as6200_pm_ops),

see what that function is doing to understand why (all about cleaning up
unnecessary code if the PM config doesn't require it)

> +		.of_match_table = as6200_of_match,
> +	},
> +	.probe = as6200_probe,
> +	.remove = as6200_remove,
> +	.id_table = as6200_id_table,
> +};
> +module_i2c_driver(as6200_driver);
> +
> +MODULE_AUTHOR("Abdel Alkuor <alkuor@gmail.com");
> +MODULE_DESCRIPTION("AMS AS6200 Temperature Sensor");
> +MODULE_LICENSE("GPL");

