Return-Path: <linux-kernel+bounces-98008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B7877341
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F3F1F2174B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1F142A84;
	Sat,  9 Mar 2024 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEtwtS66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563410EF;
	Sat,  9 Mar 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009139; cv=none; b=kot9S4gLlE7Hcj4gfdmitGglhAb6YmvEcp7OhugUJFs3w6ZFktRb7BAQNHJ+gukR2w/1nhEqbF3iEYjxU7YgRhz+EKlbTgj3qCvc9HH44nYT1ff0kb/BFYXAS8UxOrIR4awuNchg5vC3v82ayvjVdzw/uv//tVbMXhNjAaffHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009139; c=relaxed/simple;
	bh=a19Mj7UuNKUlUmJjQOULWhPTOSlnX1wnFYTkE9gIbAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXG4pHoHxcc1cP4KzwLlJIZW00PD6s81+NA9jWaBfKclWwkbwn/ylQJXYeT3N3pOZdy/TRKXpQS9NGq+9eR4zyVi6d8lWD/5Qd10/zkhh9MIz7ALNDXtiN2l8Np9TMmQbZ/odWWRkYQXBpzsgd4jaQ4QGNMU11ytSs1K2mfhNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEtwtS66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610DCC433C7;
	Sat,  9 Mar 2024 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009139;
	bh=a19Mj7UuNKUlUmJjQOULWhPTOSlnX1wnFYTkE9gIbAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DEtwtS66INajEAxeg2/85w5co+c/qfWOvLNpe351HEwlSiadoc3L2EpPSm0Cz0Qyk
	 OyzkpNlMhytbsCPHHCy6CIj3B//GmyiOAfJgB+D0sJhf5GbOSWY9Z+AcsEtk5hXWK+
	 FAr8/foeRaH9RYnJGd8rQS7PJmrGKZcGPtjVGQpP64FAi01fuEPlx9aYQYCfv+XXGz
	 nZdSFbCFJkkTsmHSY3e9351tTknGVmm5MT5AgpfN8bQIe3e7nRg8I/BB/nfytZUJd4
	 XNzFAnudlSdDCzyOe2ag03QCE+CRAUdHe2eRlUMgw/R9i0Byy5/P/xr8yW0/h6wPay
	 rL6KIcqcB3/yw==
Date: Sat, 9 Mar 2024 18:32:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240309183206.72bfee46@jic23-huawei>
In-Reply-To: <20240303165300.468011-5-vassilisamir@gmail.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
	<20240303165300.468011-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Mar 2024 17:53:00 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add a buffer struct that will hold the values of the measurements
> and will be pushed to userspace. Modify all read_* functions in order
> to just read and compensate the data without though converting to the
> required IIO measurement units which are used for the oneshot captures.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hi Vasileios,

This falls into the usual problem hole of drivers that provide
only processed channels.  The assumption is that the data in the buffer
obeys the same description as the sysfs files. So if we only have
processsed assumption is that scale should not be applied (it's rare
enough I suspect our test code doesn't know this subtlety.
We can resolve it as per comment on earlier patch to add _raw as well.

> ---
>  drivers/iio/pressure/Kconfig       |   2 +
>  drivers/iio/pressure/bmp280-core.c | 155 +++++++++++++++++++++++------
>  drivers/iio/pressure/bmp280.h      |   7 ++
>  3 files changed, 134 insertions(+), 30 deletions(-)
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
> index 3bdf6002983f..3b1a159e57ea 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -31,8 +31,12 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>

This is normally only needed for devices registering a trigger.  This one doesn't.

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h> /* For irq_get_irq_data() */
>  #include <linux/module.h>

>  
> @@ -2133,10 +2179,16 @@ static int bmp180_read_press(struct bmp280_data *data,
>  
>  	comp_press = bmp180_compensate_press(data, adc_press);
>  
> -	*val = comp_press;
> -	*val2 = 1000;
> +	/* val might be NULL if we're called by the buffer handler */
> +	if (val) {
> +		*val = comp_press;
> +		*val2 = 1000;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	data->iio_buffer.pressure = comp_press;

Putting the filling of the internal cache in here makes this hard to read.
I think I'd prefer seeing the code shared by the sysfs and this path
factored out to a separate function then a simple
bmp180_read_press_raw() as an additional callback so we can see this value
being set at the caller.

>  
> -	return IIO_VAL_FRACTIONAL;
> +	return 0;
>  }
>  
>  static int bmp180_chip_config(struct bmp280_data *data)
> @@ -2217,6 +2269,43 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
>  	return 0;
>  }
>  
> +static irqreturn_t bmp280_buffer_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (test_bit(BMP280_TEMP, indio_dev->active_scan_mask)) {
> +		ret = data->chip_info->read_temp(data, NULL, NULL);
> +		if (ret < 0)
> +			goto done;
> +	}
> +
> +	if (test_bit(BMP280_PRESS, indio_dev->active_scan_mask)) {
> +		ret = data->chip_info->read_press(data, NULL, NULL);
> +		if (ret < 0)
> +			goto done;
> +	}
> +
> +	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
> +		ret = data->chip_info->read_humid(data, NULL, NULL);
> +		if (ret < 0)
> +			goto done;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buffer,
> +					   pf->timestamp);
> +
> +done:
> +	mutex_unlock(&data->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +
> +}

blank line here.

>  static void bmp280_pm_disable(void *data)
>  {
>  	struct device *dev = data;
> @@ -2358,6 +2447,12 @@ int bmp280_common_probe(struct device *dev,
>  			return ret;
>  	}
>  
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      &bmp280_buffer_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio triggered buffer setup failed\n");
>  	/* Enable runtime PM */
>  	pm_runtime_get_noresume(dev);
>  	pm_runtime_set_active(dev);
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index d77402cb3121..d5c0451ebf68 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -400,6 +400,13 @@ struct bmp280_data {
>  	 */
>  	s32 t_fine;
>  
> +	/* IIO sysfs buffer */

Sysfs is very much one thing it isn't if you have a timestamp. This is for
the chardev flow. So drop the missleading comment.

> +	struct {
> +		s32 temperature;
> +		u32 pressure;
> +		u32 humidity;
> +		s64 timestamp;
> +	} iio_buffer;
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.


