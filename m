Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2437A352E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjIQKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjIQKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:35:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62212185;
        Sun, 17 Sep 2023 03:35:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00840C433C8;
        Sun, 17 Sep 2023 10:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694946928;
        bh=INcQNgh+tzcZPEcNqs8A4PERfXHmQR8Qh3uxTtvZAJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TKNbIKpn+5uevXfWVX7NSkjOV4K1S/cNeEqUdfIVjR0sfM14MrJ+wX2ZaUE69ZGoq
         06DMlodkUhbMY2xMovR1l6QdkrAnOr+Tu1urUAg3QjhIN0FjS6CuYR4ONaOVFzIgKc
         SHuf4Q8Q7n3hVfcHRrcIDpb3KUragoaj73Wh0hHhnmcY6ZBmJlIIttQic8RRB1FFf+
         RFfZh2ftZi4ExpEpl84kTal60e2tt8m4jvej/7JsYZSVMxXgQ7fQX3szjMdTiKquSc
         11dv0lSk09kyLjBBzqrqBwR0tTbi3k7tqhF0W+qV93eECKEkwt8+tEnmcOP1jRr8fg
         q4egkuKdIPYdw==
Date:   Sun, 17 Sep 2023 11:35:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230917113518.7c4bb1a0@jic23-huawei>
In-Reply-To: <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
References: <cover.1694760170.git.mazziesaccount@gmail.com>
        <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
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

On Fri, 15 Sep 2023 09:56:19 +0300
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
> 
> The FIFO measurement mode is only measuring the pressure and not the
> temperature. The driver measures temperature when FIFO is flushed and
> simply uses the same measured temperature value to all reported
> temperatures. This should not be a problem when temperature is not
> changing very rapidly (several degrees C / second) but allows users to
> get the temperature measurements from sensor without any additional logic.
> 
> This driver allows the sensor to be used in two muitually exclusive ways,
> 
> 1. With trigger (data-ready IRQ).
> In this case the FIFO is not used as we get data ready for each collected
> sample. Instead, for each data-ready IRQ we read the sample from sensor
> and push it to the IIO buffer.
> 
> 2. With hardware FIFO and watermark IRQ.
> In this case the data-ready is not used but we enable watermark IRQ. At
> each watermark IRQ we go and read all samples in FIFO and push them to the
> IIO buffer.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

I think this is coming together nicely. A few comments inline.

Jonathan

> 
> ---
> Revision history:
> v1 => v2:
> - prefer s64 over int64_t
> - drop not needed handling of 2's complements
> - plenty of styling changes
> - drop dead code (write_raw)
> - fix typos in comments
> - explain trigger and FIFO usage in commit message
> - do better job at cheking the return values
> - ensure there's no race when checking if triggered buffer is used
>   before enabling the FIFO
> - print warning if register read fails at IRQ handler
> - drop unnecessary warning if IRQ is not given
> - explain why we prefer asynchronous probing
> ---

> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> new file mode 100644
> index 000000000000..d3cc229d1688
> --- /dev/null
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -0,0 +1,899 @@

...

> +
> +static const unsigned long bm1390_scan_masks[] = {
> +	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0
Why?  Doesn't look hard to support just one or the other?
Normally we only do this sort of limitation when there is a heavily
optimized read routine for a set of channels and it is better
to grab them all and throw away the ones we don't care about.
That doesn't seem to be true here. So if the fifo grabbed both
temp and pressure it would makes sense here, but doesn't seem
like it does.

> +};

> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
> +{
> +	__be16 temp_raw;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_raw,
> +			       sizeof(temp_raw));
> +	if (ret)
> +		return ret;
> +
> +	*temp = be16_to_cpu(temp_raw);
> +
> +	return 0;
> +}

> +static int bm1390_read_raw(struct iio_dev *idev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bm1390_data *data = iio_priv(idev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 31;
> +			*val2 = 250000;
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		} else if (chan->type == IIO_PRESSURE) {
> +			*val = 0;
> +			/*
> +			 * pressure in hPa is register value divided by 2048.
> +			 * This means kPa is 1/20480 times the register value,
> +			 * which equals to 48828.125 * 10 ^ -9
> +			 * This is 48828.125 nano kPa.
> +			 *
> +			 * When we scale this using IIO_VAL_INT_PLUS_NANO we
> +			 * get 48828 - which means we lose some accuracy. Well,
> +			 * let's try to live with that.
> +			 */
> +			*val2 = 48828;
> +
> +			return IIO_VAL_INT_PLUS_NANO;

IIO_VAL_FRACTIONAL?  Mind you I'm not sure that will result in enough precision
either here.   For in kernel use it will have full precision though as will be
kept as a fraction.  I guess question of whether it is worse than what you have
here.  There hasn't been much demand for IIO_VAL_INTO_PLUS_PICO, but if we have
to look at that we can - with proviso that existing userspace software won't know
anything about it.

> +		}
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(idev);
> +		if (ret)
> +			return ret;
> +
> +		ret = bm1390_read_data(data, chan, val, val2);
> +		iio_device_release_direct_mode(idev);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
> +			       bool irq)
> +{
> +	struct bm1390_data *data = iio_priv(idev);
> +	struct bm1390_data_buf buffer;
> +	int smp_lvl, ret, i, warn;
> +	u64 sample_period;
> +	__be16 temp = 0;
> +
> +	/*
> +	 * If the IC is accessed during FIFO read samples can be dropped.
> +	 * Prevent access until FIFO_LVL is read
Comment doesn't seem to have much to do with code that follows it?
Maybe needs more detail given you clearly access the IC before reading
FIFO_LVL.

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
> +	if (!smp_lvl)
> +		return 0;
> +
> +	if (smp_lvl > 4) {
> +		/*
> +		 * The fifo holds maximum of 4 samples so valid values
> +		 * should be 0, 1, 2, 3, 4 - rest are probably bit errors
> +		 * in I2C line. Don't overflow if this happens.
> +		 */
> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
> +		smp_lvl = 4;
> +	}
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
> +	warn = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
> +	if (warn)
> +		dev_warn(data->dev, "Closing FIFO sequence failed\n");
> +
> +	if (!ret)
> +		return ret;
> +
> +	return smp_lvl;
> +}
> +
> +static int bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples)
> +{
> +	struct bm1390_data *data = iio_priv(idev);
> +	int ret;
> +
> +	/*
> +	 * If fifo_flush is being called from IRQ handler we know the stored timestamp
> +	 * is fairly accurate for the last stored sample. If we are

Odd line wrapping.  Tidy this up to go near but not over 80 chars

> +	 * called as a result of a read operation from userspace and hence
> +	 * before the watermark interrupt was triggered, take a timestamp
> +	 * now. We can fall anywhere in between two samples so the error in this
> +	 * case is at most one sample period.
> +	 * We need to have the IRQ disabled or we risk of messing-up
> +	 * the timestamps. If we are ran from IRQ, then the
> +	 * IRQF_ONESHOT has us covered - but if we are ran by the
> +	 * user-space read we need to disable the IRQ to be on a safe
> +	 * side. We do this usng synchronous disable so that if the
> +	 * IRQ thread is being ran on other CPU we wait for it to be
> +	 * finished.

That irq disable is potentially expensive.
Why not just pass the current timestamp into the __bm1390_fifo_flush?

The locks should prevent other races I think..   
> +	 */
> +	disable_irq(data->irq);
> +	data->timestamp = iio_get_time_ns(idev);
> +
> +	mutex_lock(&data->mutex);

scoped_guard() will work nicely here

> +	ret = __bm1390_fifo_flush(idev, samples, false);
> +	mutex_unlock(&data->mutex);
> +
> +	enable_irq(data->irq);
> +
> +	return ret;
> +}

> +
> +static irqreturn_t bm1390_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct bm1390_data *data = iio_priv(idev);
> +	int ret, status;
> +
> +	/* DRDY is acked by reading status reg */
> +	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
> +	if (ret || !status)
> +		return IRQ_NONE;
> +
> +	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
> +
> +	ret = bm1390_pressure_read(data, &data->buf.pressure);
> +	if (ret) {
> +		dev_warn(data->dev, "sample read failed %d\n", ret);
> +		return IRQ_NONE;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI,
> +			       &data->buf.temp, BM1390_TEMP_SIZE);
> +	if (ret)
> +		dev_warn(data->dev, "temp read failed %d\n", ret);

I don't want to see garbage (or a zero :) pushed into the buffer. So
if you get a read fail, don't push to buffers.

> +
> +	iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}


> +static int bm1390_trigger_set_state(struct iio_trigger *trig,
> +				    bool state)
> +{
> +	struct bm1390_data *data = iio_trigger_get_drvdata(trig);
> +	int ret = 0;
> +
> +	mutex_lock(&data->mutex);

Nice case for the new guard() calls which do automatic release of locks
on exit from a function - we also have scoped_guard for stuff inside
functions.

Here it will let you use direct returns throughout as lock will always
be released for you.


> +
> +	if (data->trigger_enabled == state)
> +		goto unlock_out;
> +
> +	if (data->state == BM1390_STATE_FIFO) {
> +		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	data->trigger_enabled = state;
> +
> +	if (state) {
> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
> +		if (ret)
> +			goto unlock_out;
> +	} else {
> +		int dummy;
> +
> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
> +		if (ret)
> +			goto unlock_out;
> +
> +		/*
> +		 * We need to read the status register in order to ACK the
> +		 * data-ready which may have been generated just before we
> +		 * disabled the measurement.
> +		 */
> +		ret = regmap_read(data->regmap, BM1390_REG_STATUS, &dummy);
> +		if (ret)
> +			dev_warn(data->dev, "status read failed\n");
> +	}
> +
> +	ret = bm1390_set_drdy_irq(data, state);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
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
> +	/* Nothing to do if we don't have IRQ for data-ready and WMI */
> +	if (irq < 0)
> +		return 0;

Matter of taste, so I won't argue strongly but I'd prefer to see this
check at the call site, not down in the function.  Makes the flow more
obvious and we don't have usual reasons for doing it this way
(either too much indenting at the call site, or lots of similar calls).

> +
> +	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
> +					      &iio_pollfunc_store_time,
> +					      &bm1390_trigger_handler,
> +					      &bm1390_buffer_ops);

Why doesn't this still apply even if we don't have an irq for this device?
Can use a sysfs or hrtimer trigger or an irq on another device.

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

Mixing trigger and buffer stuff in here. I'd rather see them
separate - so move this up to where you set the buffer up.

> +
> +	itrig->ops = &bm1390_trigger_ops;
> +	iio_trigger_set_drvdata(itrig, data);
> +
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
> +			      dev_name(data->dev));

Check the allocation.  Definitely don't want name not defined here.

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
> +	return 0;
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

Given it's unconditionally set and no line length issue, I'd prefer this
done on the local variable definitions block above.

	struct device *dev = &i2c->dev;
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
Why this ordering?  I'd expect this either:
1) Immediately after it becomes available so above the regulator enable,
or
2) immediately before it is used, so a few lines down above data->regmap...
Here it just looks a bit lost :)

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
> +	 * For now we just allow BM1390_WMI_MIN to BM1390_WMI_MAX and
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
> +	return 0;
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
> +		/*
> +		 * The probe issues a few msleep()s - which can result
> +		 * measurable delays. Additionally, enabling the VDD may cause
> +		 * some (slight) delay depending on the ramp-rate of the
> +		 * regulator. Delays are propably magnitude of tens of
> +		 * milliseconds - but async probing should not be a problem so
> +		 * we should have nothing to lose here. Let's revise this if
> +		 * async probing proves to cause problems here.
> +		 */
Perhaps we can summarise this with just the sleep info? - don't need to
predict the future :)
		/*
		 * Probing explicitly requires a few millisecond of sleep.
	 	 * Enabling the VDD regulator may include ramp up rates.
		 */
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

