Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CFA7A2E81
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjIPIBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjIPIBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 04:01:22 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DD19A8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 01:01:16 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hQEkqqje4Bh1whQElqxQEC; Sat, 16 Sep 2023 10:01:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694851269;
        bh=3LMNoCG9d7rslxiT14uY/FJc0uqkR5qNPqeL0aUnp9U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EgNisnKVhWsOp9CG2oBYANzkH8IOAZzGIfDrKxdE/4zBi1sCez16Z1S4YBkdESGpk
         XDFjOU1tNrxqhTnfN3Cx1yMElJaK6sLCLzmzBYO5JBVqf15SzVTLXWAf3JUyeo2E1h
         k5xCa5P5vKiTLmq082RFRjjLCqkKhtyBv/rpUqw1TwvcWMz7Hv0kaq7k9D65Y4VzZR
         O+uPr9XSVSlI48I4dQmBvxXNGKNTX/oo1TFGCSFjN3ez4+AEnRA/5iuDztuJca2IA0
         tJjBOQhrI8oOPzCqqyVEJTjSe8mvbnQsDDjC27lOZqH5lsD2ZjG7624UwitBLB+8ei
         2wghuHwvHjt3A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Sep 2023 10:01:09 +0200
X-ME-IP: 86.243.2.178
Message-ID: <cdc9a8f8-fbd5-1eb3-7bac-1e6e5893bc9b@wanadoo.fr>
Date:   Sat, 16 Sep 2023 10:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
To:     mazziesaccount@gmail.com
Cc:     ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        ang.iglesiasg@gmail.com, bbara93@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, robh+dt@kernel.org
References: <cover.1694760170.git.mazziesaccount@gmail.com>
 <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/09/2023 à 08:56, Matti Vaittinen a écrit :
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
> Signed-off-by: Matti Vaittinen <mazziesaccount-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 

...

> +struct bm1390_data_buf {
> +	u32 pressure;
> +	__be16 temp;

I've not looked in details so I'm not sure if related, but 
bm1390_read_temp() seems to use int.

> +	s64 ts __aligned(8);
> +};
> +
> +/* Pressure data is in 3 8-bit registers */
> +#define BM1390_PRESSURE_SIZE	3

Unused? (see other comment below)

> +
> +/* BM1390 has FIFO for 4 pressure samples */
> +#define BM1390_FIFO_LENGTH	4
> +
> +/* Temperature data is in 2 8-bit registers */
> +#define BM1390_TEMP_SIZE	2

Unused? (see other comment below)

...

> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
> +{
> +	__be16 temp_raw;

Something to do with BM1390_TEMP_SIZE?

> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_raw,
> +			       sizeof(temp_raw));
> +	if (ret)
> +		return ret;
> +
> +	*temp = be16_to_cpu(temp_raw);

See potential link with the comment above related to 
bm1390_data_buf.temp being a __be16 an temp being a int.

> +
> +	return 0;
> +}
> +
> +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
> +{
> +	int ret;
> +	u8 raw[3];

BM1390_PRESSURE_SIZE?

(not sure if it make sense because we still have [0..2] below, so having 
3 here looks useful)

> +
> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
> +			       raw, sizeof(raw));
> +	if (ret < 0)
> +		return ret;
> +
> +	*pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);
> +
> +	return 0;
> +}

...

> +static int bm1390_read_data(struct bm1390_data *data,
> +			struct iio_chan_spec const *chan, int *val, int *val2)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	/*
> +	 * We use 'continuous mode' even for raw read because according to the
> +	 * data-sheet an one-shot mode can't be used with IIR filter.
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

"ret =" missing, or done on purpose?

> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
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

Certainly useless, but should we break and return -EINVAL after the 
switch, so that it is more explicit that bm1390_read_raw() always 
returns a value?

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

if (ret)?
If done on purpose "return 0;" would be more explicit.

> +		return ret;
> +
> +	return smp_lvl;
> +}

...

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
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
> +			      dev_name(data->dev));

Missing NULL check?

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

...

