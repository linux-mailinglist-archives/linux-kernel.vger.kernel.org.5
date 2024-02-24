Return-Path: <linux-kernel+bounces-79721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952178625C7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21371282B22
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C1D46521;
	Sat, 24 Feb 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw2m32dw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD942E559;
	Sat, 24 Feb 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708787642; cv=none; b=NAj7bs6j0xWMv50iVGPxXk7NxkSk4eWIUE82jKZaoG4ni8/FhR24GuQ7S8EjBOfY16V2C4bDxq2X3Ue+y+TKgITakUm8T76cd6HqZFOlzPRPtDwRCHoPeXUlHPeFv+fUZexk4LE++0zUZD4FMQnWsnP5sSme0qGXS6MH/oaVXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708787642; c=relaxed/simple;
	bh=LYTswCYwGiUPqj0hP+seBEAuBuZy43MNvVr8kKMlJKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHbFVxC9v1joqoYex7K0ws8SVFT75Qhopsnl6i/FTku98Af4qntS80bZWaneX5FhTHO+Z9hecTqokMSNFmjWvmlrlXVQHekTOib464aj4ko24sAo6/q6sr8N9cf0hByYc27mbyFLmu0UlKEYzetRQf1Ob0aIcUNXW/v5WH+xCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw2m32dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9FAC433F1;
	Sat, 24 Feb 2024 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708787642;
	bh=LYTswCYwGiUPqj0hP+seBEAuBuZy43MNvVr8kKMlJKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bw2m32dwtbhFOh88jtTl4rKfD91QOF3TVDkW6MalPxdEfWyOQF6pwA7jUFYu6Ho4J
	 YhNo/njO8ufhPhg+RIuvgRURvvx4mrA5kW60kwUrOX2VCB2wQIuaaOUDQe2iF7HA5M
	 G+x5/i0kRqQyPnySqZLS52H9Vv6LiEqac6k5pkM03jH/6MfgjnGASaWTJRnDrA5HPR
	 HFAzwV7rb5EGj9dinzKhP6gbGLq37CAkDb+GSZ3doaf8t+NbE4LwF1WsyGdOc9rUmp
	 SCktJNBeiOjwqcAm/zb12++f5j8HFyz91o8w/IcnjUQoYF9p/ru/m5/236/lpO4Uqd
	 xGLwZvPHb+5Tw==
Date: Sat, 24 Feb 2024 15:13:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240224151340.3f2f51e8@jic23-huawei>
In-Reply-To: <20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
	<20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Feb 2024 16:18:26 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
> channel approximates the response of the human-eye providing direct
> read out where the output count is proportional to ambient light levels.
> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
> caused by artificial light sources. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.
> 
> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
> Scales, Gains and Integration time implementation.
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
I applied this but then got some build warnings that made me look
more closely at the int_src handling.

This is confusing because of the less than helpful datasheet defintion
of a 2 bit register that takes values 0 and 1 only.

I thought about trying to fix this up whilst applying but the event code
issue is too significant to do without a means to test it.

Jonathan



> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> new file mode 100644
> index 000000000000..c18e0d48556b
> --- /dev/null
> +++ b/drivers/iio/light/apds9306.c
> @@ -0,0 +1,1336 @@
>
...

> +
> +static struct iio_event_spec apds9306_event_spec_als[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static struct iio_event_spec apds9306_event_spec_clear[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,

Specify dir.

> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +#define APDS9306_CHANNEL(_type) \

I think the code would be easier to read without this macro.  It will 
be a few lines longer but simpler

> +	.type = _type, \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +
> +static struct iio_chan_spec apds9306_channels_with_events[] = {
> +	{
> +		APDS9306_CHANNEL(IIO_LIGHT)
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
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
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +	}, {
> +		APDS9306_CHANNEL(IIO_INTENSITY)
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = 1,
> +	},
> +};
> +
> +/* INT_PERSISTENCE available */
> +IIO_CONST_ATTR(thresh_either_period_available, "[0 1 15]");
> +
> +/* ALS_THRESH_VAR available */
> +IIO_CONST_ATTR(thresh_adaptive_either_values_available, "[0 1 7]");

These need to be static

> +
> +static struct attribute *apds9306_event_attributes[] = {
> +	&iio_const_attr_thresh_either_period_available.dev_attr.attr,
> +	&iio_const_attr_thresh_adaptive_either_values_available.dev_attr.attr,
> +	NULL
> +};

> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
> +{
> +	struct device *dev = data->dev;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct apds9306_regfields *rf = &data->rf;
> +	int ret, delay, intg_time, intg_time_idx, repeat_rate_idx, int_src;
> +	int status = 0;
> +	u8 buff[3];
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(rf->repeat_rate, &repeat_rate_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(rf->int_src, &int_src);
> +	if (ret)
> +		return ret;
> +
> +	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> +	if (intg_time < 0)
> +		return intg_time;
> +
> +	/* Whichever is greater - integration time period or sampling period. */
> +	delay = max(intg_time, apds9306_repeat_rate_period[repeat_rate_idx]);
> +
> +	/*
> +	 * Clear stale data flag that might have been set by the interrupt
> +	 * handler if it got data available flag set in the status reg.
> +	 */
> +	data->read_data_available = 0;
> +
> +	/*
> +	 * If this function runs parallel with the interrupt handler, either
> +	 * this reads and clears the status registers or the interrupt handler
> +	 * does. The interrupt handler sets a flag for read data available
> +	 * in our private structure which we read here.
> +	 */
> +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
> +				       status, data->read_data_available ||
> +				       (status & (APDS9306_ALS_DATA_STAT_MASK |
> +						  APDS9306_ALS_INT_STAT_MASK)),
> +				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* If we reach here before the interrupt handler we push an event */
> +	if ((status & APDS9306_ALS_INT_STAT_MASK))
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +			       int_src, IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),

You are pushing an event on channel 0 or 1 (which is non obvious as that
int_src is a 2 bit value again).  However you don't use indexed channels
so this is wrong.
It's also pushing IIO_LIGHT for both channels which makes no sense as you
only have one IIO_LIGHT channel.


> +			       iio_get_time_ns(indio_dev));
> +
> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> +	if (ret) {
> +		dev_err_ratelimited(dev, "read data failed\n");
> +		return ret;
> +	}
> +
> +	*val = get_unaligned_le24(&buff);
> +
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	return 0;
> +}
> +

..

> +
> +static irqreturn_t apds9306_irq_handler(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	struct apds9306_regfields *rf = &data->rf;
> +	int ret, status, int_ch;
> +
> +	/*
> +	 * The interrupt line is released and the interrupt flag is
> +	 * cleared as a result of reading the status register. All the
> +	 * status flags are cleared as a result of this read.
> +	 */
> +	ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS_REG, &status);
> +	if (ret < 0) {
> +		dev_err_ratelimited(data->dev, "status reg read failed\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_field_read(rf->int_src, &int_ch);
> +	if (ret)
> +		return ret;
> +
> +	if ((status & APDS9306_ALS_INT_STAT_MASK))
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +			       int_ch, IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));

As commented on elsewhere I'm not seeing the relationship between the event
pushed here and the channels this device provides (one of which is modified
for starters).

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

..

> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	struct apds9306_regfields *rf = &data->rf;
> +	int int_en, event_ch_is_light, ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		guard(mutex)(&data->mutex);
> +
> +		ret = regmap_field_read(rf->int_src, &event_ch_is_light);

Call the local value int_src - it's not obvious to a reviewer what 
relationship between that and int_src is. I had to go read the datasheet
to find out.

> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_field_read(rf->int_en, &int_en);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->type == IIO_LIGHT)
> +			return int_en & event_ch_is_light;
> +
> +		if (chan->type == IIO_INTENSITY)
> +			return int_en & !event_ch_is_light;
This is the specific line the compiler doesn't like
drivers/iio/light/apds9306.c:1036:39: warning: dubious: x & !y   

I would match int_src against specific values rather than using tricks
based on what those values happen to be.

			return int_en && (int_src == APDS9306_INT_SRC_CLEAR);
                                                      


> +
> +		return -EINVAL;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = regmap_field_read(rf->int_thresh_var_en, &int_en);
> +		if (ret)
> +			return ret;
> +
> +		return int_en;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int apds9306_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	struct apds9306_regfields *rf = &data->rf;
> +	int ret, val;
> +
> +	state = !!state;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		guard(mutex)(&data->mutex);
Better to add explicit scope if you are going to use a guard.
	case IIO_EV_TYPE_THRESH: {
		guard(mutex)(&data->mutex);
so we can see where the scope ends more clearly.

> +
> +		/*
> +		 * If interrupt is enabled, the channel is set before enabling
> +		 * the interrupt. In case of disable, no need to switch
> +		 * channels. In case of different channel is selected while
> +		 * interrupt in on, just change the channel.
> +		 */
> +		if (state) {
> +			if (chan->type == IIO_LIGHT)
> +				val = 1;
> +			else if (chan->type == IIO_INTENSITY)
> +				val = 0;
> +			else
> +				return -EINVAL;
> +
> +			ret = regmap_field_write(rf->int_src, val);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = regmap_field_read(rf->int_en, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (val == state)
> +			return 0;
> +
> +		ret = regmap_field_write(rf->int_en, state);
> +		if (ret)
> +			return ret;
> +
> +		if (state)
> +			return pm_runtime_resume_and_get(data->dev);
> +
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
> +
> +		return 0;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		return regmap_field_write(rf->int_thresh_var_en, state);
> +	default:
> +		return -EINVAL;
> +	}
> +}



