Return-Path: <linux-kernel+bounces-103488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B6087C020
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CF11F21862
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239173530;
	Thu, 14 Mar 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ8QaZTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B973161;
	Thu, 14 Mar 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429942; cv=none; b=CmmRcVe+QHnJtHMZJeu2BqAt89QzLn2nqSxcecLMdDsv05+I+lL7OVR+AXsVsCayPmXe7OYB50Cs5bf3xGXCKxcPYySlO3JelIPc9MCXA+4lv9Mky7uWbz8YluC6IPjGJIm7mbfLRpGTZb3aD3VqmzbYUj11q8MV+lTPRMk2So4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429942; c=relaxed/simple;
	bh=iLn1CpDFM+9e9zq2OzwAyHwPd6aGu3OYpuTEjq5jK4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEeWmN4SBcD666oLfrk4bOMQ7TMeFZ7Un7PmXemXOKVdsAI+nGWfnPRqZ7gCJgEFgvJ/v6UrIVW/wl2bxpirn2a+2w9VLa4A2NWgMjmNvHjtKaxbtrMVNvmHn7ZZmTPdrWtIAFu4KpkioUSzMMq4ifC37ExzQf4uvlCLId/9Dpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ8QaZTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170F0C433F1;
	Thu, 14 Mar 2024 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710429942;
	bh=iLn1CpDFM+9e9zq2OzwAyHwPd6aGu3OYpuTEjq5jK4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZ8QaZTLDKoRpQT+ChaTJUo7h9y4C+ZauSw9MyG4Uzt/ViX3rYqr2eVqqarOPSgI3
	 C8W43ZdhRaN6+zZxBE6Rg+v6qHKJYQ0LTtKMB4VWO7Cqq/ejEG6zx3CQz6PRvSnPfB
	 X2NWn0ilDUyCZTXsNahMYqfcuCk7mOfje3icej3LqhKYHae4+/BteikLVzAdppCHS4
	 8cRxlpgeCfhEQw5nyTiSxyKYqUUyvqWV0FkggUa+yXD5hMy/KNDUfRYDFZ05qI1q00
	 3SqordU3esg+CTmYWTUPRsAiP/VU7+qoMTwinC/xAey5yTwk4OT/h2o/gz1Rc7mAd2
	 QGVA0xQpcH6bQ==
Date: Thu, 14 Mar 2024 15:25:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240314152525.51bcdcd6@jic23-huawei>
In-Reply-To: <20240313174007.1934983-7-vassilisamir@gmail.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-7-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 18:40:07 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add a buffer struct that will hold the values of the measurements
> and will be pushed to userspace and a buffer_handler function to
> read the data and push them.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/Kconfig       |  2 +
>  drivers/iio/pressure/bmp280-core.c | 61 ++++++++++++++++++++++++++++++
>  drivers/iio/pressure/bmp280.h      |  7 ++++
>  3 files changed, 70 insertions(+)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 79adfd059c3a..5145b94b4679 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -31,6 +31,8 @@ config BMP280
>  	select REGMAP
>  	select BMP280_I2C if (I2C)
>  	select BMP280_SPI if (SPI_MASTER)
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
>  	  and BMP580 pressure and temperature sensors. Also supports the BME280 with
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index f2cf9bef522c..7c889cda396a 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -40,7 +40,10 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #include <asm/unaligned.h>
>  
> @@ -2188,6 +2191,57 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
>  	return 0;
>  }
>  
> +static irqreturn_t bmp280_buffer_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	int ret, temp;
> +
> +	/*
> +	 * data->buf[3] is used to transfer data from the device. Whenever a
> +	 * pressure or a humidity reading takes place, the data written in the
> +	 * data->buf[3] overwrites the iio_buf.temperature value. Keep the
> +	 * temperature value and apply it after the readings.

See comment below. Given you saw this problem did you not think maybe you
were doing something a little unusual / wrong? Should have rung alarm
bells beyond just putting a comment here to explain you needed to work around
the issue.

> +	 */
> +	mutex_lock(&data->lock);
> +
> +	if (test_bit(BMP280_TEMP, indio_dev->active_scan_mask)) {
> +		ret = data->chip_info->read_temp(data);
> +		if (ret < 0)
> +			goto done;
> +
> +		temp = ret;
> +	}
> +
> +	if (test_bit(BMP280_PRESS, indio_dev->active_scan_mask)) {
> +		ret = data->chip_info->read_press(data);
> +		if (ret < 0)
> +			goto done;
> +
> +		data->iio_buf.pressure = ret;
> +		data->iio_buf.temperature = temp;
Try running this with the tooling in tools/iio and you'll see that
you are getting the wrong output if you have just humidity and
temperature enabled - IIO packs channels, so disable an early
one and everything moves down in address.

If you an this device without timestamps and only a single channel
the buffer used will have one s32 per scan for example.

> +	}
> +
> +	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
> +		ret = data->chip_info->read_humid(data);
> +		if (ret < 0)
> +			goto done;
> +
> +		data->iio_buf.humidity = ret;
> +		data->iio_buf.temperature = temp;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
> +					   iio_get_time_ns(indio_dev));
> +
> +done:
> +	mutex_unlock(&data->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void bmp280_pm_disable(void *data)
>  {
>  	struct device *dev = data;
> @@ -2329,6 +2383,13 @@ int bmp280_common_probe(struct device *dev,
>  			return ret;
>  	}
>  
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      &bmp280_buffer_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio triggered buffer setup failed\n");
> +
>  	/* Enable runtime PM */
>  	pm_runtime_get_noresume(dev);
>  	pm_runtime_set_active(dev);
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index c8cb7c417dab..b5369dd496ba 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -407,6 +407,13 @@ struct bmp280_data {
>  	union {
>  		/* Sensor data buffer */
>  		u8 buf[3];
> +		/* Data buffer to push to userspace */

Why is this in the union?  This union is to ensure cache safe buffers for
DMAing directly into.  That's not applicable here.  Even though it may
be safe to do this (I was reading backwards so wrote a comment here
on you corrupting temperature before seeing the comment above)
it is giving a misleading impression of how this struct is used.
Pull the struct to after t_fine - It only needs to
be 8 byte aligned and the aligned marking you have will ensure that
 
> +		struct {
> +			s32 temperature;
> +			u32 pressure;
> +			u32 humidity;

As above, this is 3 4 byte buffers but they don't have these meanings
unless all channels are enabled.

You could set available mask to enforce that, but don't as it makes
limited sense for this hardware.  Just make these
			u32 chans[3];
and fill them in with an index incremented for each channel that is
enabled.

Jonathan

> +			s64 timestamp __aligned(8);
> +		} iio_buf;
>  		/* Calibration data buffers */
>  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
>  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];


