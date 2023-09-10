Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DD7799E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbjIJNWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjIJNWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:22:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33BD19C;
        Sun, 10 Sep 2023 06:22:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F05C433C7;
        Sun, 10 Sep 2023 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694352153;
        bh=IqfoNUwqoFBf6pjJWTPxNFnd6GPUIV3wxA2QAlC/u3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fmtrKRKrrxxcgNVHI97kOWa6fUEl4d9UNMBAmoZYxNr69PHRViLZOMiO8ORXH1zRR
         Lwz94+EfLygOsApJ+sWc5ehExFWigAtmQ2gsbbBxWjV34M6FZ4DV8j0M5ceYwvEWG9
         hKMhCW3k4KOYfnfk+f2jTRLHZbLy8+3ywsAiBWw5/M00W5QalymVDaiYJyxA/IMBQc
         DXYkcKw/gABbjeiGK6jJJUKkPrqy9YrBv+PUouRP7VrfPu7ak8wQ4r8DcDUyzNrCz2
         dhbkqrWi4uYaHzgCEfTVKNjNCPH/nYWWptk8LX5V860bTtce59cqi+CQNGAAzMF336
         C369ha7oQWr6g==
Date:   Sun, 10 Sep 2023 14:22:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230910142225.5863a850@jic23-huawei>
In-Reply-To: <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
        <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2023 15:37:48 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
> averaging and internal FIFO. The sensor does also provide temperature
> measurements.
> 
> Sensor does also contain IIR filter implemented in HW. The data-sheet
> says the IIR filter can be configured to be "weak", "middle" or
> "strong". Some RMS noise figures are provided in data sheet but no
> accurate maths for the filter configurations is provided. Hence, the IIR
> filter configuration is not supported by this driver and the filter is
> configured to the "middle" setting (at least not for now).

*sigh*  We all love fuzzily described filters...

> 
> The FIFO measurement mode is only measuring the pressure and not the
> temperature. The driver measures temperature when FIFO is flushed and
> simply uses the same measured temperature value to all reported
> temperatures. This should not be a problem when temperature is not
> changing very rapidly (several degrees C / second) but allows users to
> get the temperature measurements from sensor without any additional logic.

IIRC this is a bit different from what we've typically done in the past
where we just take the view that a slow moving thing like temperature
can be read from sysfs or that enabling it disables the watermark.

However, what you have seems like valid use of the ABI to me so I'm
fine with this approach if it makes sense for your expected users
(which you get to guess at ;)

Given there are multiple ways of handling combination of FIFO hardware
and triggers, it's good to add a little bit of info on that in this
patch description (I misunderstood what you were doing initially)




> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> new file mode 100644
> index 000000000000..2d51a99a58fc
> --- /dev/null
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -0,0 +1,944 @@

...

> +
> +enum {
> +	BM1390_CHAN_PRESSURE,
> +	BM1390_CHAN_TEMP,
> +};

> +static int bm1390_read_data(struct bm1390_data *data,
> +			struct iio_chan_spec const *chan, int *val, int *val2)
> +{
> +	int ret;
> +
> +	*val2 = 0;

Why?  No need to pass val2 in or zero it if going to return IIO_VAL_INT to the
IIO core.  It's never used.

> +
> +	mutex_lock(&data->mutex);
> +	/*
> +	 * We use 'continuous mode' even for raw read because according to the
> +	 * data-sheet an one-shot mode can't be used with IIR filter
> +	 */
> +	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
> +	if (ret)
> +		goto unlock_out;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		msleep(BM1390_MAX_MEAS_TIME_MS);
> +		ret = bm1390_pressure_read(data, val);
> +		break;
> +	case IIO_TEMP:
> +		msleep(BM1390_MAX_MEAS_TIME_MS);
> +		ret = bm1390_read_temp(data, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}

> +
> +static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
> +			       bool irq)
> +{
> +	/* The fifo holds maximum of 4 samples */

Whilst useful info - why have comment here?

> +	struct bm1390_data *data = iio_priv(idev);
> +	struct bm1390_data_buf buffer;
> +	int smp_lvl, ret, i;
> +	u64 sample_period;
> +	__be16 temp = 0;
> +
> +	/*
> +	 * If the IC is accessed during FIFO read samples can be dropped.
> +	 * Prevent access until FIFO_LVL is read
> +	 */
> +	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
> +		ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
> +				       sizeof(temp));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
> +	if (ret)
> +		return ret;
> +
> +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
> +
> +	if (smp_lvl > 4) {
> +		/*
> +		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
> +		 * bit errors in I2C line. Don't overflow if this happens.
> +		 */
> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
> +		smp_lvl = 4;
> +	}
> +
> +	if (!smp_lvl)
> +		return ret;
> +
> +	sample_period = data->timestamp - data->old_timestamp;
> +	do_div(sample_period, smp_lvl);
> +
> +	if (samples && smp_lvl > samples)
> +		smp_lvl = samples;
> +
> +	for (i = 0; i < smp_lvl; i++) {
> +		ret = bm1390_pressure_read(data, &buffer.pressure);
> +		if (ret)
> +			break;
> +
> +		buffer.temp = temp;
> +		/*
> +		 * Old timestamp is either the previous sample IRQ time,
> +		 * previous flush-time or, if this was first sample, the enable
> +		 * time. When we add a sample period to that we should get the
> +		 * best approximation of the time-stamp we are handling.
> +		 *
> +		 * Idea is to always keep the "old_timestamp" matching the
> +		 * timestamp which we are currently handling.
> +		 */
> +		data->old_timestamp += sample_period;
> +
> +		iio_push_to_buffers_with_timestamp(idev, &buffer,
> +						   data->old_timestamp);
> +	}
> +	/* Reading the FIFO_LVL closes the FIFO access sequence */
> +	regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);

ret = 

> +
> +	if (!ret)
> +		return ret;
> +
> +	return smp_lvl;
> +}

...

> +static int bm1390_write_raw(struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(idev);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	default:
> +		ret = -EINVAL;

?

> +	}
> +	iio_device_release_direct_mode(idev);
> +
> +	return ret;
> +}
> +
> +static int bm1390_set_watermark(struct iio_dev *idev, unsigned int val)
> +{
> +	struct bm1390_data *data = iio_priv(idev);
> +
> +	if (val < BM1390_WMI_MIN || val > BM1390_WMI_MAX)
> +		return -EINVAL;

It's definitely possible to argue a watermark of 1 is also supported - just
run in bypass mode with data ready interrupt.  Not sure we care enough to 
make that supported in this interface though.  Driver doesn't need to
support everything possible.


> +
> +	mutex_lock(&data->mutex);
> +	data->watermark = val;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info bm1390_info = {
> +	.read_raw = &bm1390_read_raw,
> +	.write_raw = &bm1390_write_raw,
> +	.validate_trigger = iio_validate_own_trigger,
> +	.hwfifo_set_watermark = bm1390_set_watermark,
> +	.hwfifo_flush_to_buffer = bm1390_fifo_flush,
> +};
> +
> +static int bm1390_chip_init(struct bm1390_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_write_bits(data->regmap, BM1390_REG_POWER,
> +				BM1390_MASK_POWER, BM1390_POWER_ON);
> +	if (ret)
> +		return ret;
> +
> +	msleep(1);
> +
> +	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
> +				BM1390_MASK_RESET, BM1390_RESET);
> +	if (ret)
> +		return ret;
> +
> +	msleep(1);
> +
> +	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
> +				BM1390_MASK_RESET, BM1390_RESET_RELEASE);
> +	if (ret)
> +		return ret;
> +
> +	msleep(1);
> +
> +	ret = regmap_reinit_cache(data->regmap, &bm1390_regmap);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to reinit reg cache\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
> +	 * be fixed when IIR is in use
> +	 */
> +	ret = regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
> +				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, BM1390_REG_FIFO_CTRL,
> +				 BM1390_MASK_IIR_MODE, BM1390_IIR_MODE_MID);
> +
> +	return ret;

return regmap...

> +}
> +
> +static int bm1390_fifo_set_wmi(struct bm1390_data *data)
> +{
> +	u8 regval;
> +
> +	regval = data->watermark - BM1390_WMI_MIN;
> +	regval = FIELD_PREP(BM1390_MASK_FIFO_LEN, regval);
> +
> +	return regmap_update_bits(data->regmap, BM1390_REG_FIFO_CTRL,
> +				  BM1390_MASK_FIFO_LEN, regval);
> +}
> +
> +static int bm1390_fifo_enable(struct iio_dev *idev)
> +{
> +	struct bm1390_data *data = iio_priv(idev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +
> +	/* Update watermark to HW */
> +	ret = bm1390_fifo_set_wmi(data);
> +	if (ret)
> +		goto unlock_out;
> +
> +	/* Enable WMI_IRQ */
> +	ret = regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
> +				 BM1390_MASK_WMI_EN);

check ret.

> +	/* Enable FIFO */
> +	ret = regmap_set_bits(data->regmap, BM1390_REG_FIFO_CTRL,
> +			      BM1390_MASK_FIFO_EN);
> +	if (ret)
> +		goto unlock_out;
> +
> +	data->state = BM1390_STATE_FIFO;
> +
> +	data->old_timestamp = iio_get_time_ns(idev);
> +	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bm1390_fifo_disable(struct iio_dev *idev)
> +{
> +	struct bm1390_data *data = iio_priv(idev);
> +	int ret;
> +
> +	msleep(1);
> +
> +	mutex_lock(&data->mutex);
> +	/* Disable FIFO */
> +	ret = regmap_clear_bits(data->regmap, BM1390_REG_FIFO_CTRL,
> +				BM1390_MASK_FIFO_EN);
> +	if (ret)
> +		goto unlock_out;
> +
> +	data->state = BM1390_STATE_SAMPLE;
> +
> +	/* Disable WMI_IRQ */
> +	ret = regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
> +				 BM1390_MASK_WMI_EN);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bm1390_buffer_postenable(struct iio_dev *idev)
> +{
> +	/*
> +	 * If we use data-ready trigger, then the IRQ masks should be handled by
> +	 * trigger enable and the hardware buffer is not used but we just update
> +	 * results to the IIO fifo when data-ready triggers.

FIFO

> +	 */
> +	if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	return bm1390_fifo_enable(idev);
> +}
> +
> +static int bm1390_buffer_predisable(struct iio_dev *idev)
> +{
> +	if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	return bm1390_fifo_disable(idev);
> +}
> +
> +static const struct iio_buffer_setup_ops bm1390_buffer_ops = {
> +	.postenable = bm1390_buffer_postenable,
> +	.predisable = bm1390_buffer_predisable,
> +};
> +
> +static irqreturn_t bm1390_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct bm1390_data *data = iio_priv(idev);
> +	int ret, dummy;
> +
> +	/* DRDY is acked by reading status reg */
> +	ret = regmap_read(data->regmap, BM1390_REG_STATUS,
> +			  &dummy);

I'd expect 'dummy' to be irrelevant data.  Perhaps give it
a better name if you are going to use the value like this.

> +	if (ret || !dummy)
> +		return IRQ_NONE;
> +
> +	dev_dbg(data->dev, "DRDY trig status 0x%x\n", dummy);
> +
> +	ret = bm1390_pressure_read(data, &data->buf.pressure);
> +	if (ret) {
> +		dev_warn(data->dev, "sample read failed %d\n", ret);
> +		return IRQ_NONE;
As below.  Still our interrupt even if we couldn't read the data
As such, IRQ_HANDLED; is current reutrn value.
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI,
> +			       &data->buf.temp, BM1390_TEMP_SIZE);
> +
ret not checked.

> +	iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Get timestamps and wake the thread if we need to read data */
> +static irqreturn_t bm1390_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct bm1390_data *data = iio_priv(idev);
> +
> +	data->timestamp = iio_get_time_ns(idev);
> +
> +	if (data->state == BM1390_STATE_FIFO || data->trigger_enabled)
> +		return IRQ_WAKE_THREAD;
> +
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t bm1390_irq_thread_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct bm1390_data *data = iio_priv(idev);
> +	int ret = IRQ_NONE;
> +
> +	mutex_lock(&data->mutex);
> +
> +	if (data->trigger_enabled) {
> +		iio_trigger_poll_nested(data->trig);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (data->state == BM1390_STATE_FIFO) {

Can this and trigger_enabled be true?  

> +		int ok;
> +
> +		ok = __bm1390_fifo_flush(idev, BM1390_TEMP_SIZE, true);
> +		if (ok > 0)
> +			ret = IRQ_HANDLED;

An error should not result in IRQ_NONE.  At most we tend to print
an error message and return IRQ_HANDLED anyway to avoid the interrupt
being treated as spurious.

> +	}
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bm1390_set_drdy_irq(struct bm1390_data *data, bool en)
> +{
> +	if (en)
> +		return regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
> +				       BM1390_MASK_DRDY_EN);
> +	return regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
> +				 BM1390_MASK_DRDY_EN);
> +}
> +
> +static int bm1390_trigger_set_state(struct iio_trigger *trig,
> +				    bool state)
> +{
> +	struct bm1390_data *data = iio_trigger_get_drvdata(trig);
> +	int ret = 0;
> +
> +	mutex_lock(&data->mutex);
> +
> +	if (data->trigger_enabled == state)
> +		goto unlock_out;
> +
> +	if (data->state == BM1390_STATE_FIFO) {
> +		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");

Why not?  Spec reference ideally.  I haven't gotten my head around this
but I'd expect an attempt to set the trigger state to indicate that we don't
want to use the fifo and as such it should be disabled in this path.

> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	data->trigger_enabled = state;
> +
> +	if (state) {
> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);

Is this a trigger characteristic?  Feels more like a feature of enabling buffering.
Ah well. That's always a blurry boundary so it is probably fine here.

ret set but not checked...  

> +	} else {
> +		int dummy;
> +
> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
> +
> +		/*
> +		 * We need to read the status register in order to ACK the
> +		 * data-ready which may have been generated just before we
> +		 * disabled the measurement.
> +		 */
> +		if (!ret)
> +			ret = regmap_read(data->regmap, BM1390_REG_STATUS,
> +					  &dummy);

Should check for errors in ret.

> +	}
> +
> +	ret = bm1390_set_drdy_irq(data, state);
> +	if (ret)
> +		goto unlock_out;

Not a lot of point in that :)

> +
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +
> +}
> +
> +static const struct iio_trigger_ops bm1390_trigger_ops = {
> +	.set_trigger_state = bm1390_trigger_set_state,
> +};
> +
> +static int bm1390_setup_trigger(struct bm1390_data *data, struct iio_dev *idev,
> +				int irq)
> +{
> +	struct iio_trigger *itrig;
> +	char *name;
> +	int ret;
> +
> +	if (irq < 0) {
> +		dev_warn(data->dev, "No IRQ - skipping buffering\n");

I don't see that as deserving a warning. Device should be fine with out it.
Maybe dev_info could be justified (just).

> +		return 0;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
> +					      &iio_pollfunc_store_time,
> +					      &bm1390_trigger_handler,
> +					      &bm1390_buffer_ops);
> +
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio_triggered_buffer_setup FAIL\n");
> +
> +	itrig = devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d", idev->name,
> +					    iio_device_id(idev));
> +	if (!itrig)
> +		return -ENOMEM;
> +
> +	data->trig = itrig;
> +	idev->available_scan_masks = bm1390_scan_masks;
> +
> +	itrig->ops = &bm1390_trigger_ops;
> +	iio_trigger_set_drvdata(itrig, data);



> +
> +	/*
> +	 * No need to check for NULL. request_threaded_irq() defaults to
> +	 * dev_name() should the alloc fail.
> +	 */
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
> +			      dev_name(data->dev));

Whist true, checking for it is less code than not doing so and
adding the comment. So I'd just check for it!

> +
> +	ret = devm_request_threaded_irq(data->dev, irq, bm1390_irq_handler,
> +					&bm1390_irq_thread_handler,
> +					IRQF_ONESHOT, name, idev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> +
> +
> +	ret = devm_iio_trigger_register(data->dev, itrig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Trigger registration failed\n");
> +
> +
> +	return ret;

return 0 as that's the only value and it's good to make it clear that
was the intention in this path.


> +}
> +
> +static int bm1390_probe(struct i2c_client *i2c)
> +{
> +	struct bm1390_data *data;
> +	struct regmap *regmap;
> +	struct iio_dev *idev;
> +	struct device *dev;
> +	unsigned int part_id;
> +	int ret;
> +
> +	dev = &i2c->dev;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &bm1390_regmap);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
> +
> +	data = iio_priv(idev);
> +
> +	ret = regmap_read(regmap, BM1390_REG_PART_ID, &part_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> +
> +	if (part_id != BM1390_ID)
> +		dev_warn(dev, "unknown device 0x%x\n", part_id);
> +
> +	data->regmap = regmap;
> +	data->dev = dev;
> +	data->irq = i2c->irq;
> +	/*
> +	 * Default watermark to WMI_MAX. We could also allow setting WMI to 0,
> +	 * and interpret that as "WMI is disabled, use FIFO_FULL" but I've
> +	 * no idea what is assumed if watermark is 0. Does it mean each sample
> +	 * should trigger IRQ, or no samples should do that?

In my head at least, if we are using fifo_full it is still a watermark but one
that matches size of buffer.
I think for previous drivers we've had 0 and 1 both meaning it's a dataready
interrupt (i.e. one entry in the fifo).  That would be fine here as well
and would correspond to putting the device in bypass mode.
	
> +	 *
> +	 * Well, for now we just allow BM1390_WMI_MIN to BM1390_WMI_MAX and
> +	 * discard every other configuration when triggered mode is not used.
> +	 */
> +	data->watermark = BM1390_WMI_MAX;
> +	mutex_init(&data->mutex);
> +
> +	idev->channels = bm1390_channels;
> +	idev->num_channels = ARRAY_SIZE(bm1390_channels);
> +	idev->name = "bm1390";
> +	idev->info = &bm1390_info;
> +	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;

The triggered buffer setup should set the second of these inside
the IIO core code (as it always needs to be set if that code is called).


> +
> +	ret = bm1390_chip_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "sensor init failed\n");
> +
> +	ret = bm1390_setup_trigger(data, idev, i2c->irq);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, idev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id bm1390_of_match[] = {
> +	{ .compatible = "rohm,bm1390glv-z" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bm1390_of_match);
> +
> +static const struct i2c_device_id bm1390_id[] = {
> +	{ "bm1390glv-z", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, bm1390_id);
> +
> +static struct i2c_driver bm1390_driver = {
> +	.driver = {
> +		.name = "bm1390",
> +		.of_match_table = bm1390_of_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

I don't mind seeing this but I do want it to have a comment saying 'why'.
I assume there is something really slow involved in probing this?

> +	},
> +	.probe = bm1390_probe,
> +	.id_table = bm1390_id,
> +};
> +module_i2c_driver(bm1390_driver);
> +
> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
> +MODULE_DESCRIPTION("Driver for ROHM BM1390 pressure sensor");
> +MODULE_LICENSE("GPL");

