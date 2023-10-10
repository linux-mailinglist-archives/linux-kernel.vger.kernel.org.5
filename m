Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B467BFF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjJJOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjJJOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:37:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7B9E;
        Tue, 10 Oct 2023 07:37:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D78C433C8;
        Tue, 10 Oct 2023 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696948675;
        bh=vgqGK+bwKmgCqLMj0qSiCgmwuDuxCsWZb3n+ldqxMl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KiA0INp/5GMCI0d8qst0BFsRsqScTdAI1O0UXw4sUwuLG/N2f0oBfMpUPg5EznWk5
         m5JvIAPnNS/sanQhzwCIn4fo9YCTgmwO6XcD3j0+KfSx51/AlwBdlZoVict9F1aC48
         IXuJpPqYMEc7pbEdOqB7r7qSmYlkUTcyJMAga/zkFZLO51PN9QgyjayLUmONMI2hmU
         +h3Z4XEfNL6t4IBuSVm95gZN+GBRGjAODNr2l1GM19pwkMNNOhHs/orWxHMAyndlTL
         f0IZZmbKRylOXqZcGWOCjqzS7bbyJuxsgU0It51/uio8Lrfk5vtz8co0chXs5YoESC
         xflowjYV3KBCg==
Date:   Tue, 10 Oct 2023 15:38:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: Re: [PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <20231010153807.6335a043@jic23-huawei>
In-Reply-To: <20231008154857.24162-3-subhajit.ghosh@tweaklogic.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
        <20231008154857.24162-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Oct 2023 02:18:57 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Driver support for Avago (Broadcom) APDS9306
> Ambient Light Sensor with als and clear channels.
> This driver exposes raw values for both the channels and
> processed(lux) values for the als channel.
> Support for both with or without hardware interrupt
> configurations are provided.
Hi Subhajit,

No need to wrap the patch description quite so short. Aim
for up to 75 char for a commit message (and 80 for the code)
Here you are under 60.

> 
> Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> 
There is a tag for datasheets in the format tags block so
Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

I took a quick look at the most similar part number adps9300 and
this does look substantially different but could you confirm you've
taken a look at the plausible drivers to which support for this part
could be added and perhaps mention why that doesn't make sense
I think it will be mainly feature set being different here, but also
it seems they have completely different register maps despite similar
part numbers!


A few other comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> new file mode 100644
> index 000000000000..02c8285b230b
> --- /dev/null
> +++ b/drivers/iio/light/apds9306.c


...


> +};
> +
> +enum apds9306_int_channels {
> +	CLEAR,
> +	ALS,
> +};

Is this used?

> +
> +/**
> + * struct part_id_nlux_per_count - Part no. & corresponding nano lux per count
> + * @part_id: Part ID of the device
> + * @nlux_per_count: Nano lux per ADC count
> + */
> +struct part_id_nlux_per_count {
> +	int part_id;
> +	int nlux_per_count;
> +};
> +
> +/*
> + * As per the datasheet, at HW Gain = 3x, Integration time 100mS (32x),
> + * typical 2000 ADC counts are observed for 49.8 uW per sq cm (340.134 lux)
> + * for apds9306 and 43 uW per sq cm (293.69 lux) for apds9306-065.
> + * Assuming lux per count is linear across all integration time ranges,
> + * saving in nano lux per count.
> + * Nano Lux per count = (340.134 * 1000000000)/ (32 * 3 * 2000) for apds9306
> + * Nano Lux per count = (293.69 * 1000000000)/ (32 * 3 * 2000) for apds9306-065

Even though it's a comment stick to kernel maths syntax and put a space before the /
Otherwise some script will complain it's not correctly formatted code :)

> + */
> +static struct part_id_nlux_per_count apds9306_part_id_nlux_per_count[] = {
> +	{.part_id = 0xB1, .nlux_per_count = 1787156},
> +	{.part_id = 0xB3, .nlux_per_count = 1529635},

Prefer { .part_id = 0xB3, .nlux_per_count = 1629635 },
for tables liek this as it ends up a tiny bit easier to read.

> +};

...

> +#define APDS9306_CHANNEL(_type) \
> +	.type = _type, \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +
> +static struct iio_chan_spec apds9306_channels_with_events[] = {
> +	{
> +		APDS9306_CHANNEL(IIO_LIGHT)
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PROCESSED),
> +		.event_spec = apds9306_event_spec_als,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_als),
> +	}, {
> +		APDS9306_CHANNEL(IIO_INTENSITY)
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = 1,
> +		.event_spec = apds9306_event_spec_clear,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_clear),
> +	},
> +};
> +
> +static struct iio_chan_spec apds9306_channels_without_events[] = {
> +	{
> +		APDS9306_CHANNEL(IIO_LIGHT)
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PROCESSED),

This needs an explanation for why as a comment in the code.
We very rarely support both raw and processed for the same channel and
mostly when we do it is due to some historical changes.

You are using the gts stuff here so it should be possible to expose
the controls for scale necessary to have userspace perform the raw to processed
conversion.  

> +	}, {
> +		APDS9306_CHANNEL(IIO_INTENSITY)
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = 1,
> +	},
> +};
> +
> +/* INT_PERSISTENCE available */
> +IIO_CONST_ATTR(thresh_either_period_available, "[0 15]");
> +
> +/* ALS_THRESH_VAR available */
> +IIO_CONST_ATTR(thresh_adaptive_either_values_available, "[0 7]");
Not valid range syntax for IIO attributes, you need to include
the step.

[0 1 7]

> +
> +static struct attribute *apds9306_event_attributes[] = {
> +	&iio_const_attr_thresh_either_period_available.dev_attr.attr,
> +	&iio_const_attr_thresh_adaptive_either_values_available.dev_attr.attr,
> +	NULL	
> +};
> +

> +
> +static const struct regmap_config apds9306_regmap = {
> +	.name = "apds9306_regmap",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.rd_table = &apds9306_readable_table,
> +	.wr_table = &apds9306_writable_table,
> +	.volatile_table = &apds9306_volatile_table,
> +	.precious_table = &apds9306_precious_table,
> +	.max_register = APDS9306_ALS_THRES_VAR,
> +	.cache_type = REGCACHE_RBTREE,
> +	.disable_locking = true,
This normally deserves a statement of what you are doing about locking instead.

The interrupt controller for starters takes to no locks and can run concurrently
with other accesses from other CPUs.  That seems unwise.

> +};
+
...

> +
> +static int apds9306_intg_time_get(struct apds9306_data *data, int *val2)
> +{
> +	*val2 = iio_gts_find_int_time_by_sel(&data->gts, data->intg_time_idx);
> +	if (*val2 < 0)
> +		return *val2;

You shouldn't have side effects on *val2 if an error occurs.
Its not a bug in this case, but it is generally something to avoid

	int ret;

	ret = iio_gts...
	if (ret < 0)
		return ret;

	*val2 = ret;

	return 0;

> +
> +	return 0;
> +}
> +
> +static int apds9306_intg_time_set_hw(struct apds9306_data *data, int sel)
> +{
> +	int ret;
> +
> +	ret = regmap_field_write(data->regfield_intg_time, sel);
> +	if (ret)
> +		return ret;
> +	data->intg_time_idx = sel;
> +
> +	return ret;
> +}

> +
> +static int apds9306_sampling_freq_set(struct apds9306_data *data, int val,
> +				int val2)
> +{
> +	int i, ret = -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++)
> +		if (apds9306_repeat_rate_freq[i][0] == val &&
> +				apds9306_repeat_rate_freq[i][1] == val2) {
> +			ret = regmap_field_write(data->regfield_repeat_rate, i);
> +			if (ret)
> +				return ret;
> +			data->repeat_rate_idx = i;
> +			break;
Might as well return here instead of break as nothing else to do.

> +		}
> +
> +	return ret;
> +}

> +static int apds9306_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, reg;
> +
> +	mutex_lock(&data->mutex);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
> +			reg = APDS9306_CLEAR_DATA_0;
> +		else
> +			reg = APDS9306_ALS_DATA_0;
> +		ret = apds9306_read_data(data, val, reg);
> +		if (ret)
> +			break;
> +		ret = IIO_VAL_INT;
> +		*val2 = 0;

As below.  No need to set *val2 to 0 if returning IIO_VAL_INT.

> +		break;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = apds9306_read_lux(data, val);
> +		if (ret)
> +			break;
> +		*val2 = 0;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		ret = apds9306_intg_time_get(data, val2);
> +		if (ret)
> +			break;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = apds9306_sampling_freq_get(data, val, val2);
> +		if (ret)
> +			break;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = apds9306_scale_get(data, val, val2);
> +		if (ret)
> +			break;
> +		ret = IIO_VAL_INT_PLUS_NANO;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +};
>
> +
> +static irqreturn_t apds9306_irq_handler(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, status;
> +
> +	/*
> +	 * The interrupt line is released and the interrupt flag is
> +	 * cleared as a result of reading the status register. All the
> +	 * status flags are cleared as a result of this read.
> +	 */
> +	ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS, &status);
> +	if (ret < 0) {
> +		dev_err(data->dev, "status reg read failed\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +			       data->int_ch, IIO_EV_TYPE_THRESH,
> +			       IIO_EV_DIR_EITHER), iio_get_time_ns(indio_dev));
> +	}
> +
> +	/*
> +	 * If a one-shot read through sysfs is underway at the same time
> +	 * as this interrupt handler is executing and a read data available
> +	 * flag was set, this flag is set to inform read_poll_timeout()
> +	 * to exit.
> +	 */
> +	if ((status & APDS9306_ALS_DATA_STAT_MASK))
> +		data->read_data_available = 1;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int apds9306_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
> +			ret = apds9306_event_period_get(data, val);
> +		else
> +			ret = apds9306_event_thresh_get(data, dir, val);
> +		break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = apds9306_event_thresh_adaptive_get(data, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	if (ret)
> +		return ret;
> +
> +	*val2 = 0;

The IIO core won't use val2 if you return IIO_VAL_INT, so don't bother setting it.

> +	return IIO_VAL_INT;
> +}
> +
> +static int apds9306_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
> +			ret = apds9306_event_period_set(data, val);
> +		else
> +			ret = apds9306_event_thresh_set(data, dir, val);
> +		break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = apds9306_event_thresh_adaptive_set(data, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	unsigned int val, val2;
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
As below
	guard(mutex)(&data->mutex);

should simplify this - I won't comment on this one above this point (reviewing backwards
through the code).

> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		ret = regmap_field_read(data->regfield_int_en, &val);
> +		if (ret)
> +			break;
> +		ret = regmap_field_read(data->regfield_int_src, &val2);
> +		if (ret)
> +			break;
> +		if (chan->type == IIO_LIGHT)
> +			ret = val & val2;
> +		else if (chan->type == IIO_INTENSITY)
> +			ret = val & !val2;

This logic would benefit from better variable naming.
en and src for example..

> +		else
> +			ret = -EINVAL;
> +		break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = regmap_field_read(data->regfield_int_thresh_var_en,
> +					&val);
> +		if (ret)
> +			break;
> +		ret = val;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
> +static int apds9306_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	state = !!state;
> +	mutex_lock(&data->mutex);

Perfect place to use the new cleanup.h trickery here.

guard(mutex)(&data->mutex); 

and then you can just return in error paths which will simplify this code

> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		if (state) {
> +			if (chan->type == IIO_LIGHT) {
> +				ret = regmap_field_write(data->regfield_int_src, 1);
> +				if (ret)
> +					break;
> +			} else if (chan->type == IIO_INTENSITY) {
> +				ret = regmap_field_write(data->regfield_int_src, 0);
> +				if (ret)
> +					break;
> +			} else {
> +				ret = -EINVAL;
> +				break;
> +			}
> +		}
> +		ret = regmap_field_write(data->regfield_int_en, state);
> +		if (ret)
> +			break;
> +		ret = apds9306_runtime_power(data, state);
> +		break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = regmap_field_write(data->regfield_int_thresh_var_en,
> +					 state);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +#define APDS9306_IIO_INFO \
> +	.read_avail = apds9306_read_avail, \
> +	.read_raw = apds9306_read_raw, \
> +	.write_raw = apds9306_write_raw, \
> +	.write_raw_get_fmt = apds9306_write_raw_get_fmt,
> +
> +static const struct iio_info apds9306_info_no_events = {
> +	APDS9306_IIO_INFO
> +};
> +
> +static const struct iio_info apds9306_info = {
> +	APDS9306_IIO_INFO
> +	.event_attrs = &apds9306_event_attr_group,
> +	.read_event_value = apds9306_read_event,
> +	.write_event_value = apds9306_write_event,
> +	.read_event_config = apds9306_read_event_config,
> +	.write_event_config = apds9306_write_event_config,
> +};
> +
> +static int get_device_id_lux_per_count(struct apds9306_data *data)
> +{
> +	int ret, part_id;
> +
> +	ret = regmap_read(data->regmap, APDS9306_PART_ID, &part_id);
> +	if (ret)
> +		return ret;
> +
> +	if (part_id == apds9306_part_id_nlux_per_count[0].part_id)
> +		data->nlux_per_count =
> +			apds9306_part_id_nlux_per_count[0].nlux_per_count;
> +	else if (part_id == apds9306_part_id_nlux_per_count[1].part_id)
> +		data->nlux_per_count =
> +			apds9306_part_id_nlux_per_count[1].nlux_per_count;

For loop over ARRAY_SIZE(apds9306_part_id_nlux_per_count)
would be more extensible with a return on match, so that if you
don't we just return -ENXIO on exit from the loop.


> +	else
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +
> +static void apds9306_powerdown(void *ptr)
> +{
> +	struct apds9306_data *data = (struct apds9306_data *)ptr;
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	/* Disable interrupts */
> +	ret = regmap_field_write(data->regfield_int_thresh_var_en, 0);
> +	if (ret)
> +		dev_err(dev, "Failed to disable variance interrupts\n");

Muddling on when things are failing is probably not worthwhile. I'd be
tempted to just error out of here.  Worst that happens is we leave the
device partly enabled which is a bit of a power waste, but it's not expected
to happen so I don't think we care.  Much easier to follow code if we
always return on error.

> +	ret = regmap_field_write(data->regfield_int_en, 0);
> +	if (ret)
> +		dev_err(dev, "Failed to disable interrupts\n");
> +	/* Put the device in standby mode */
> +	ret = apds9306_power_state(data, STANDBY);
> +	if (ret)
> +		dev_err(dev, "Failed to power down device\n");
> +}

> +static int apds9306_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct apds9306_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	mutex_init(&data->mutex);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &apds9306_regmap);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
> +
> +	data->dev = dev;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = apds9306_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "regfield initialization failed\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vin");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	indio_dev->name = "apds9306";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	if (client->irq) {
> +		indio_dev->info = &apds9306_info;
> +		indio_dev->channels = apds9306_channels_with_events;
> +		indio_dev->num_channels =
> +				ARRAY_SIZE(apds9306_channels_with_events);
> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +					apds9306_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

The direction of the interrupt should come from device tree.  Sometimes people
use level conversion by using an not gate and that flips the logic of the
interrupt in a way that the driver can't see.  Hence we leave that
detail for firmware, not the driver.

> +					"apds9306_event", indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					"failed to assign interrupt.\n");
> +	} else {
> +		indio_dev->info = &apds9306_info_no_events;
> +		indio_dev->channels = apds9306_channels_without_events;
> +		indio_dev->num_channels =
> +				ARRAY_SIZE(apds9306_channels_without_events);
> +	}
> +
> +	ret = devm_iio_init_iio_gts(dev, APDS9306_SCALE_1X, 0, apds9306_gains,
> +				    ARRAY_SIZE(apds9306_gains), apds9306_itimes,
> +				    ARRAY_SIZE(apds9306_itimes), &data->gts);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);

Why at this point? I'd have thought it wasn't powered up until init_device()
which follows?  So I'd expect to see this call after that, not before.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				"failed to add action on driver unwind\n");
> +
> +	ret = apds9306_init_device(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init device\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int apds9306_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = apds9306_power_state(data, STANDBY);
> +	if (ret)
> +		regcache_cache_only(data->regmap, true);

What is the logic of putting the regcache into cache only mode
if we fail to power down the device?  

> +
> +	return ret;
> +}
> +
> +static int apds9306_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	regcache_cache_only(data->regmap, false);
> +	ret = regcache_sync(data->regmap);
> +	if (ret)
> +		return ret;
> +	ret = apds9306_power_state(data, ACTIVE);
> +	if (ret)
> +		regcache_cache_only(data->regmap, true);

If you get here an this failed we are in an unknown state where
the device is effectively dead anyway.  I'd not bother
with juggling the state of the regcache.  Or am I missing some path
in which this regcache_cache_only() is called that isn't
an error path?

> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops,
> +				 apds9306_runtime_suspend,
> +				 apds9306_runtime_resume,
> +				 NULL);
> +
> +static const struct i2c_device_id apds9306_id[] = {
> +	{ "apds9306" }, { }

Put the terminator on a new line because it reduces the noise if we ever add
more devices by removing the need to reformat this first.

> +};
> +MODULE_DEVICE_TABLE(i2c, apds9306_id);
> +
> +static const struct of_device_id apds9306_of_match[] = {
> +	{ .compatible = "avago,apds9306" }, { }

Same as above.

> +};
> +MODULE_DEVICE_TABLE(of, apds9306_of_match);
> +
> +static struct i2c_driver apds9306_driver = {
> +	.driver = {
> +		.name = "apds9306",
> +		.pm = pm_ptr(&apds9306_pm_ops),
> +		.of_match_table = apds9306_of_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe_new = apds9306_probe,
> +	.id_table = apds9306_id,
> +};
> +
> +module_i2c_driver(apds9306_driver);
> +
> +MODULE_AUTHOR("Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>");
> +MODULE_DESCRIPTION("APDS9306 Ambient Light Sensor driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_GTS_HELPER);

