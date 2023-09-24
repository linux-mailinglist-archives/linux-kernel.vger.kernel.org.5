Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E217ACA05
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjIXObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjIXObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:31:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C7DFA;
        Sun, 24 Sep 2023 07:31:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C38C433C7;
        Sun, 24 Sep 2023 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695565863;
        bh=MifHPrnweUgv4MNKXzdDevJH6n2kck+z2SzMNpF8z7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=km1iYKeRSnNCaiGWg0crgao+oZK+zlBM2l0D2iTWwPX31N4cV2hrUGA2pUJUzV+Fj
         7YOsWEXGPjzcQJF/onm/wxUfTeBiWzQ2X9bWshSR14hL8dZpXZED09oYWdS29TwuzD
         tyoLijZxjzL3I0cvFAAEHKZcyGAaVde5IqnlDe3FwHHNMVrGrgSROhi/8silO+O4jm
         EwYTz+6wF3U6HYgrYGoWnMGm/vctboywMPZuJFv73nKRq4UoN87gpr3t5nX5V5n3cY
         Y8n0uaivVAcRhDAwjydtNuiWLxKhbygClgM5ciU7k/aOaWT2o6g1fHFGgNUACFAmOj
         IhRWmA6i0Ae2g==
Date:   Sun, 24 Sep 2023 15:30:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <20230924153055.0b3486f9@jic23-huawei>
In-Reply-To: <20230918080314.11959-3-jagathjog1996@gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
        <20230918080314.11959-3-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 13:33:14 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> The Bosch BMI323 is a 6-axis low-power IMU that provide measurements for
> acceleration, angular rate, and temperature. This sensor includes
> motion-triggered interrupt features, such as a step counter, tap detection,
> and activity/inactivity interrupt capabilities.
> 
> The driver supports various functionalities, including data ready, FIFO
> data handling, and events such as tap detection, step counting, and
> activity interrupts
> 
> Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi323-ds000.pdf
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Given Andy has done a thorough review (as he always does!)
and there is quite a bit in my review queue, I'll just scan
through quickly and call out a few things.  Will take a closer
look at next version.

One thing that is useful for a complex driver like this is to include
(typically in the cover letter) a full listing of what shows up in sysfs.
That gives an easy way to check the ABI looks right without having to figure
out what all the generated file names are from the code.

Thanks,

Jonathan



> ---
>  MAINTAINERS                          |    7 +
>  drivers/iio/imu/Kconfig              |    1 +
>  drivers/iio/imu/Makefile             |    1 +
>  drivers/iio/imu/bmi323/Kconfig       |   33 +
>  drivers/iio/imu/bmi323/Makefile      |    7 +
>  drivers/iio/imu/bmi323/bmi323.h      |  198 +++
>  drivers/iio/imu/bmi323/bmi323_core.c | 2260 ++++++++++++++++++++++++++
>  drivers/iio/imu/bmi323/bmi323_i2c.c  |  115 ++
>  drivers/iio/imu/bmi323/bmi323_spi.c  |  106 ++
>  9 files changed, 2728 insertions(+)
>  create mode 100644 drivers/iio/imu/bmi323/Kconfig
>  create mode 100644 drivers/iio/imu/bmi323/Makefile
>  create mode 100644 drivers/iio/imu/bmi323/bmi323.h
>  create mode 100644 drivers/iio/imu/bmi323/bmi323_core.c
>  create mode 100644 drivers/iio/imu/bmi323/bmi323_i2c.c
>  create mode 100644 drivers/iio/imu/bmi323/bmi323_spi.c
> 

> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> new file mode 100644
> index 000000000000..adbcfbc6b97d
> --- /dev/null
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -0,0 +1,2260 @@

> +struct bmi323_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct iio_mount_matrix orientation;
> +	enum bmi323_irq_pin irq_pin;
> +	struct iio_trigger *trig;
> +	bool drdy_trigger_enabled;
> +	enum bmi323_state state;
> +	s64 fifo_tstamp, old_fifo_tstamp;
> +	u32 odrns[2];
> +	u32 odrhz[2];
> +	unsigned int feature_events;
> +
> +	/*
> +	 * Lock to protect the members of device's private data from concurrent
> +	 * access and also to serialize the access of extended registers.
> +	 * See bmi323_write_ext_reg(..) for more info.
> +	 */
> +	struct mutex mutex;
> +	int watermark;
> +	__le16 fifo_buff[BMI323_FIFO_FULL_IN_WORDS] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		__le16 channels[6];
> +		s64 ts __aligned(8);

Hopefully Andy's aligned_s64 set will land soon and we can tidy this up.
I'm a bit unsure of this, but can you overlap some of these buffers or are
they used concurrently? (if they are then we have problems with DMA safety.)

Perhaps an anonymous union is appropriate?



> +	} buffer;
> +	__le16 steps_count[2];
> +};





> +static int bmi323_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->mutex);
> +	/*
> +	 * When the ODR of the accelerometer and gyroscope do not match, the
> +	 * maximum ODR value between the accelerometer and gyroscope is used
> +	 * for FIFO and the signal with lower ODR will insert dummy frame.
yuk.
> +	 * So allow buffer read only when ODR's of accelero and gyro are equal.
> +	 * See datasheet section 5.7 "FIFO Data Buffering".

Good :)

> +	 */
> +	if (data->odrns[BMI323_ACCEL] != data->odrns[BMI323_GYRO]) {
> +		dev_err(data->dev, "Accelero and Gyro ODR doesn't match\n");
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}

> +
> +static int bmi323_set_drdy_irq(struct bmi323_data *data,
> +			       enum bmi323_irq_pin irq_pin)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, BMI323_INT_MAP2_REG,
> +				 BMI323_GYR_DRDY_MSK,
> +				 FIELD_PREP(BMI323_GYR_DRDY_MSK, irq_pin));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, BMI323_INT_MAP2_REG,
> +				  BMI323_ACC_DRDY_MSK,
> +				  FIELD_PREP(BMI323_ACC_DRDY_MSK, irq_pin));
> +}
> +
> +static int bmi323_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					     bool state)
> +{
> +	struct bmi323_data *data = iio_trigger_get_drvdata(trig);
> +	enum bmi323_irq_pin irq_pin;
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
guard(mutex)(&data->mutex);

> +
> +	if (data->state == BMI323_BUFFER_FIFO) {
> +		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	if (state) {
> +		data->state = BMI323_BUFFER_DRDY_TRIGGERED;
> +		irq_pin = data->irq_pin;
> +	} else {
> +		data->state = BMI323_IDLE;
> +		irq_pin = BMI323_IRQ_DISABLED;
> +	}
> +
> +	ret = bmi323_set_drdy_irq(data, irq_pin);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops bmi323_trigger_ops = {
> +	.set_trigger_state = &bmi323_data_rdy_trigger_set_state,
> +};
> +
> +static irqreturn_t bmi323_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Lock to protect the data->buffer */
> +	mutex_lock(&data->mutex);

scoped_guard(mutex)(&data->mutex); might work well here though it
will push up the indent.

> +	ret = regmap_bulk_read(data->regmap, BMI323_ACCEL_X_REG,
> +			       &data->buffer.channels,
> +			       ARRAY_SIZE(data->buffer.channels));
> +	if (ret)
> +		goto unlock_out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +					   iio_get_time_ns(indio_dev));
> +	mutex_unlock(&data->mutex);
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +	return IRQ_NONE;
> +}
> +



> +static IIO_DEVICE_ATTR_RW(in_accel_gyro_averaging, 0);
> +static IIO_CONST_ATTR(in_accel_gyro_averaging_available, "2 4 8 16 32 64");
> +
> +static struct attribute *bmi323_attributes[] = {
> +	&iio_dev_attr_in_accel_gyro_averaging.dev_attr.attr,
> +	&iio_const_attr_in_accel_gyro_averaging_available.dev_attr.attr,

So averaging often maps directly to oversampling.  Kind of different names
for the same thing.  Perhaps that standard ABI can be used?
It tends to make sampling frequency reporting need to take it into account
though as that drops as divided by oversampling ratio.

> +	NULL
> +};
> +

> +}
> +
> +static int bmi323_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long mask)
> +{
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&data->mutex);
> +		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
> +				     val, val2);
> +		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&data->mutex);
> +		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
> +				       val, val2);
> +		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_ENABLE:
> +		mutex_lock(&data->mutex);
> +		ret = bmi323_enable_steps(data, val);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (val || !FIELD_GET(BMI323_FEAT_IO0_STP_CNT_MSK,
> +				      data->feature_events))
> +			return -EINVAL;
> +
> +		/* Clear step counter value */
> +		return bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
> +					     BMI323_STEP_SC1_RST_CNT_MSK,
> +					     FIELD_PREP(BMI323_STEP_SC1_RST_CNT_MSK,
> +							1));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bmi323_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		mutex_lock(&data->mutex);

	scoped_guard() might be mice for some of these cases
or push the guards down into the function being called perhaps.


> +		ret = bmi323_read_steps(data, val);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +		case IIO_ANGL_VEL:
> +			ret = iio_device_claim_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +
> +			mutex_lock(&data->mutex);
> +			ret = bmi323_read_axis(data, chan, val);
> +			mutex_unlock(&data->mutex);
> +
> +			iio_device_release_direct_mode(indio_dev);
> +			return ret;
> +		case IIO_TEMP:
> +			mutex_lock(&data->mutex);
> +			ret = bmi323_get_temp_data(data, val);
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmi323_get_odr(data, chan->type, val, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +		case IIO_ANGL_VEL:
> +			*val = 0;
> +			mutex_lock(&data->mutex);
> +			ret = bmi323_get_scale(data, chan->type, val2);
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		case IIO_TEMP:
> +			*val = BMI323_TEMP_SCALE / MEGA;
> +			*val2 = BMI323_TEMP_SCALE % MEGA;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = BMI323_TEMP_OFFSET;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_ENABLE:
> +		mutex_lock(&data->mutex);
> +		*val = FIELD_GET(BMI323_FEAT_IO0_STP_CNT_MSK,
> +				 data->feature_events);
> +		mutex_unlock(&data->mutex);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info bmi323_info = {
> +	.read_raw = bmi323_read_raw,
> +	.write_raw = bmi323_write_raw,
> +	.read_avail = bmi323_read_avail,
> +	.attrs = &bmi323_attrs_group,
> +	.hwfifo_set_watermark = bmi323_set_watermark,
> +	.write_event_config = bmi323_write_event_config,
> +	.read_event_config = bmi323_read_event_config,
> +	.write_event_value = bmi323_write_event_value,
> +	.read_event_value = bmi323_read_event_value,
> +	.event_attrs = &bmi323_event_attribute_group,
> +};
> +
> +#define BMI323_SCAN_MASK_ACCEL_3AXIS		\
> +	(BIT(BMI323_ACCEL_X) | BIT(BMI323_ACCEL_Y) | BIT(BMI323_ACCEL_Z))
> +
> +#define BMI323_SCAN_MASK_GYRO_3AXIS		\
> +	(BIT(BMI323_GYRO_X) | BIT(BMI323_GYRO_Y) | BIT(BMI323_GYRO_Z))
> +
> +static const unsigned long bmi323_avail_scan_masks[] = {
> +	/* 3-axis accel + 3-axis gyro */
> +	BMI323_SCAN_MASK_ACCEL_3AXIS | BMI323_SCAN_MASK_GYRO_3AXIS,

Can you poke this an see if you get what you expect which is the minimum
sufficient set of channels.  Matti pointed out earlier that the search
logic isn't well documented in iio_scan_mask_match() but it
looks to match against first case where the requested values are a subset.
So this would need to be in the opposite order or you will always
get everything turned on.

Chances are we have this wrong in other drivers as well :(
Won't break things, but may mean that we over read in some configurations.

> +	/* 3-axis accel */
> +	BMI323_SCAN_MASK_ACCEL_3AXIS,
> +	/* 3-axis gyro */
> +	BMI323_SCAN_MASK_GYRO_3AXIS,
> +	0
> +};
> +
> +static int bmi323_int_pin_config(struct bmi323_data *data,
> +				 enum bmi323_irq_pin irq_pin,
> +				 bool active_high, bool open_drain, bool latch)
> +{
> +	unsigned int mask, field_value = 0;
> +	int ret;
> +
> +	switch (irq_pin) {
> +	case BMI323_IRQ_INT1:
> +		mask = BMI323_IO_INT1_LVL_OD_OP_MSK;
> +
> +		set_mask_bits(&field_value, BMI323_IO_INT1_LVL_MSK,
> +			      FIELD_PREP(BMI323_IO_INT1_LVL_MSK, active_high));
> +
> +		set_mask_bits(&field_value, BMI323_IO_INT1_OD_MSK,
> +			      FIELD_PREP(BMI323_IO_INT1_OD_MSK, open_drain));
> +
> +		set_mask_bits(&field_value, BMI323_IO_INT1_OP_EN_MSK,
> +			      FIELD_PREP(BMI323_IO_INT1_OP_EN_MSK, 1));
Given you are filling in a value that starts as zero and don't overwrite values
you set earlier this is much simpler as
		mask = ...
		field_value = FIELD_PREP(...) |
			      FIELD_PREP(...) |
			      FIELD_PREP(...);

Also move working this out to just before it is used. Right now it is hard
to spot where that is.

> +		break;
> +	case BMI323_IRQ_INT2:
> +		mask = BMI323_IO_INT2_LVL_OD_OP_MSK;
> +
> +		set_mask_bits(&field_value, BMI323_IO_INT2_LVL_MSK,
> +			      FIELD_PREP(BMI323_IO_INT2_LVL_MSK, active_high));
> +
> +		set_mask_bits(&field_value, BMI323_IO_INT2_OD_MSK,
> +			      FIELD_PREP(BMI323_IO_INT2_OD_MSK, open_drain));
> +
> +		set_mask_bits(&field_value, BMI323_IO_INT2_OP_EN_MSK,
> +			      FIELD_PREP(BMI323_IO_INT2_OP_EN_MSK, 1));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, BMI323_IO_INT_CONF_REG,
> +				 BMI323_IO_INT_LTCH_MSK,
> +				 FIELD_PREP(BMI323_IO_INT_LTCH_MSK, latch));
> +	if (ret)
> +		return ret;
> +
> +	ret = bmi323_update_ext_reg(data, BMI323_GEN_SET1_REG,
> +				    BMI323_GEN_HOLD_DUR_MSK,
> +				    FIELD_PREP(BMI323_GEN_HOLD_DUR_MSK, 0));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, BMI323_IO_INT_CTR_REG, mask,
> +				  field_value);
> +}
> +
> +static int bmi323_trigger_probe(struct bmi323_data *data,
> +				struct iio_dev *indio_dev)
> +{
> +	bool open_drain, active_high, latch;
> +	struct fwnode_handle *fwnode;
> +	enum bmi323_irq_pin irq_pin;
> +	int ret, irq, irq_type;
> +	struct irq_data *desc;
> +
> +	fwnode = dev_fwnode(data->dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq > 0) {
> +		irq_pin = BMI323_IRQ_INT1;
> +	} else {
> +		irq = fwnode_irq_get_byname(fwnode, "INT2");
> +		if (irq <= 0)
> +			return 0;
> +
> +		irq_pin = BMI323_IRQ_INT2;
> +	}
> +
> +	desc = irq_get_irq_data(irq);
> +	if (!desc) {
> +		dev_err(data->dev, "Could not find IRQ %d\n", irq);
> +		return -EINVAL;
> +	}
> +
> +	irq_type = irqd_get_trigger_type(desc);
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +		latch = false;
> +		active_high = true;
> +		break;
> +	case IRQF_TRIGGER_HIGH:
> +		latch = true;
> +		active_high = true;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		latch = false;
> +		active_high = false;
> +		break;
> +	case IRQF_TRIGGER_LOW:
> +		latch = true;
> +		active_high = false;
> +		break;
> +	default:
> +		dev_err(data->dev, "Invalid interrupt type 0x%x specified\n",
> +			irq_type);
> +		return -EINVAL;
> +	}
> +
> +	open_drain = fwnode_property_read_bool(fwnode, "drive-open-drain");
> +
> +	ret = bmi323_int_pin_config(data, irq_pin, active_high, open_drain,
> +				    latch);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to configure irq line\n");
> +
> +	data->trig = devm_iio_trigger_alloc(data->dev, "%s-trig-%d",
> +					    indio_dev->name, irq_pin);
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &bmi323_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, data);
> +
> +	ret = devm_request_threaded_irq(data->dev, irq, NULL,
> +					bmi323_irq_thread_handler,
> +					irq_type | IRQF_ONESHOT,

I think if you leave the irq_type bit out, it will be set up to match what was
specified in firmware anyway. Could be wrong on that though so check.

> +					"bmi323-int", indio_dev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Failed to request IRQ\n");
> +
> +	ret = devm_iio_trigger_register(data->dev, data->trig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Trigger registration failed\n");
> +
> +	data->irq_pin = irq_pin;
> +
> +	return ret;
> +}
> +
> +static int bmi323_feature_engine_enable(struct bmi323_data *data, bool en)
> +{
> +	unsigned int feature_status;
> +	int ret, i;
> +
> +	if (en) {
> +		ret = regmap_write(data->regmap, BMI323_FEAT_IO2_REG,
> +				   0x012c);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(data->regmap, BMI323_FEAT_IO_STATUS_REG,
> +				   BMI323_FEAT_IO_STATUS_MSK);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(data->regmap, BMI323_FEAT_CTRL_REG,
> +				   BMI323_FEAT_ENG_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		i = 5;

Why 5?

> +		do {
> +			ret = regmap_read(data->regmap, BMI323_FEAT_IO1_REG,
> +					  &feature_status);
> +			if (ret)
> +				return ret;
> +
> +			i--;
> +			mdelay(2);
> +		} while (feature_status != 0x01 && i);

GET_FIELD() always rather than directly masking out values
It means we have a clear name for what is being checked.

> +
> +		if (feature_status != 0x01) {
> +			dev_err(data->dev, "Failed to enable feature engine\n");
> +			return -EINVAL;
> +		}
> +
> +		return ret;
> +	} else {
> +		return regmap_write(data->regmap, BMI323_FEAT_CTRL_REG, 0);
Flip the logic for readability by reducing indent
	if (!en)
		return regmap_write()

	ret = regmap_write() etc

> +	}
> +}

> +static int bmi323_init(struct bmi323_data *data)
> +{
> +	int ret, val;
> +
> +	/*
> +	 * Perform soft reset to make sure the device is in a known state after
> +	 * start up. A delay of 1.5 ms is required after reset.
> +	 * See datasheet section 5.17 "Soft Reset".
> +	 */
> +	ret = regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1500, 2000);
> +
> +	/*
> +	 * Dummy read is required to enable SPI interface after reset.
> +	 * See datasheet section 7.2.1 "Protocol Selection".
> +	 */
> +	regmap_read(data->regmap, BMI323_CHIP_ID_REG, &val);
> +
> +	ret = regmap_read(data->regmap, BMI323_CHIP_ID_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if ((val & 0xFF) != BMI323_CHIP_ID_VAL) {

FIELD_GET() and appropriate mask given this is half of a 16 bit register.

> +		dev_err(data->dev, "Chip ID mismatch\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = bmi323_feature_engine_enable(data, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, BMI323_ERR_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val) {
> +		dev_err(data->dev, "Sensor power error = 0x%x\n", val);
> +		return -EINVAL;
I think this is only called in probe() so an use dev_err_probe()
in here as well.

> +	}
> +
> +	ret = regmap_read(data->regmap, BMI323_STATUS_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 0x01) {

FIELD_GET() and appropriate definition.

> +		dev_err(data->dev, "Sensor initialization error = 0x%x\n", val);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Set the Bandwidth coefficient which defines the 3 dB cutoff
> +	 * frequency in relation to the ODR.
> +	 */
> +	ret = bmi323_set_bw(data, BMI323_ACCEL, BMI323_BW_ODR_BY_2);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = bmi323_set_bw(data, BMI323_GYRO, BMI323_BW_ODR_BY_2);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = bmi323_set_odr(data, BMI323_ACCEL, 25, 0);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = bmi323_set_odr(data, BMI323_GYRO, 25, 0);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = devm_add_action_or_reset(data->dev, bmi323_disable, data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int bmi323_core_probe(struct device *dev)
> +{
> +	static const char * const regulator_names[] = { "vdd", "vddio" };
> +	struct iio_dev *indio_dev;
> +	struct bmi323_data *data;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = dev_get_regmap(dev, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "No regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +	mutex_init(&data->mutex);
> +
> +	ret = bmi323_init(data);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = iio_read_mount_matrix(dev, &data->orientation);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "bmi323-imu";
> +	indio_dev->info = &bmi323_info;
> +	indio_dev->channels = bmi323_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(bmi323_channels);
> +	indio_dev->available_scan_masks = bmi323_avail_scan_masks;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	dev_set_drvdata(data->dev, indio_dev);
> +
> +	ret = bmi323_trigger_probe(data, indio_dev);

What if interrupt isn't wired?  Do we need it for basic read of channels?
Would expect the interfaces provided to be more limited, but not that we
would provide none at all.

> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = devm_iio_triggered_buffer_setup_ext(data->dev, indio_dev,
> +						  &iio_pollfunc_store_time,
> +						  bmi323_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_IN,
> +						  &bmi323_buffer_ops,
> +						  bmi323_fifo_attributes);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to setup trigger buffer\n");
> +
> +	ret = devm_iio_device_register(data->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
> +
> +MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
> +MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> new file mode 100644
> index 000000000000..afbaa3d3c638
> --- /dev/null
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I2C driver for Bosch BMI323 6-Axis IMU.
> + *
> + * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "bmi323.h"
> +
> +/*
> + * From BMI323 datasheet section 4: Notes on the Serial Interface Support.
> + * Each I2C register read operation requires to read two dummy bytes before
> + * the actual payload.
> + */
> +static int bmi323_regmap_i2c_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct i2c_msg msgs[2];
> +	u8 *buff = NULL;
> +	int ret;
> +
> +	buff = kmalloc(val_size + BMI323_I2C_DUMMY, GFP_KERNEL);
> +	if (!buff)
> +		return -ENOMEM;
> +
> +	msgs[0].addr = i2c->addr;
> +	msgs[0].flags = i2c->flags;
> +	msgs[0].len = reg_size;
> +	msgs[0].buf = (u8 *)reg_buf;
> +
> +	msgs[1].addr = i2c->addr;
> +	msgs[1].len = val_size + BMI323_I2C_DUMMY;
> +	msgs[1].buf = (u8 *)buff;
> +	msgs[1].flags = i2c->flags | I2C_M_RD;
> +
> +	ret = i2c_transfer(i2c->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0) {
> +		kfree(buff);
> +		return -EIO;
> +	}
> +
> +	memcpy(val_buf, buff + BMI323_I2C_DUMMY, val_size);

Annoyingly can't do same trick as I suggest for SPI as we need
the address send vs when data turns up to be correct.

Whilst this code is 'generic' do you know the max size of the
buffer that might be read?  If it's small I'd just use an array
on the stack.  If large, then the cleanup.h stuff will help
with code, but it's still annoying to have to do an allocation
in here.  You can probably put something in context alongside
dev.

> +	kfree(buff);
> +
> +	return 0;
> +}
> +
> +static int bmi323_regmap_i2c_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +	u8 reg;
> +
> +	reg = *(u8 *)data;
> +	ret = i2c_smbus_write_i2c_block_data(i2c, reg, count - 1,
> +					     data + sizeof(u8));
> +
	return i2c_smbus...

> +	return ret;
> +}
> +
> +static struct regmap_bus bmi323_regmap_bus = {
> +	.read = bmi323_regmap_i2c_read,
> +	.write = bmi323_regmap_i2c_write,
> +};
> +
> +static int bmi323_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init(dev, &bmi323_regmap_bus, dev,
> +				  &bmi323_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to initialize I2C Regmap\n");
> +
> +	return bmi323_core_probe(dev);
> +}
> +
> +static const struct i2c_device_id bmi323_i2c_ids[] = {
> +	{ "bmi323", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, bmi323_i2c_ids);
> +
> +static const struct of_device_id bmi323_of_i2c_match[] = {
> +	{ .compatible = "bosch,bmi323" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bmi323_of_i2c_match);
> +
> +static struct i2c_driver bmi323_i2c_driver = {
> +	.driver = {
> +		.name = "bmi323",
> +		.of_match_table = bmi323_of_i2c_match,
> +	},
> +	.probe_new = bmi323_i2c_probe,
> +	.id_table = bmi323_i2c_ids,
> +};
> +module_i2c_driver(bmi323_i2c_driver);
> +
> +MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
> +MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_BMI323);
> diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
> new file mode 100644
> index 000000000000..2b802a0c6d9d
> --- /dev/null
> +++ b/drivers/iio/imu/bmi323/bmi323_spi.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SPI driver for Bosch BMI323 6-Axis IMU.
> + *
> + * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "bmi323.h"
> +
> +/*
> + * From BMI323 datasheet section 4: Notes on the Serial Interface Support.
> + * Each SPI register read operation requires to read one dummy byte before
> + * the actual payload.
> + */
> +static int bmi323_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	u8 reg, *buff = NULL;
> +	int ret;
> +
> +	buff = kmalloc(val_size + BMI323_SPI_DUMMY, GFP_KERNEL);

Hmm.  Regmap has pad_bits (which can be multiple bytes) but this case
is unusual in that they only apply to reads.

I wonder if we can make this cheaper though rather than having
to handle either some context or having dynamic allocations in here.

How about making the write bigger?  Does that have any effect?
Looks like don't care state in Figure 31.  If that's the case,
send some zeros on that as it's known fixed size (2 bytes including
the padding) and then you can directly use the read buffer without
yet another memcpy.


> +	if (!buff)
> +		return -ENOMEM;
> +
> +	reg = *(u8 *)reg_buf | 0x80;
> +	ret = spi_write_then_read(spi, &reg, sizeof(reg), buff,
> +				  val_size + BMI323_SPI_DUMMY);
> +	if (ret) {
> +		kfree(buff);
> +		return ret;
> +	}
> +
> +	memcpy(val_buf, buff + BMI323_SPI_DUMMY, val_size);
> +	kfree(buff);
> +
> +	return ret;
> +}
> +
> +static int bmi323_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	struct spi_device *spi = context;
> +
> +	return spi_write(spi, data, count);
> +}
> +
> +static struct regmap_bus bmi323_regmap_bus = {
> +	.read = bmi323_regmap_spi_read,
> +	.write = bmi323_regmap_spi_write,
> +};

