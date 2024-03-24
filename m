Return-Path: <linux-kernel+bounces-112649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A0E887C86
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C070281A99
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4517742;
	Sun, 24 Mar 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCh1Ncfb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33A28E7;
	Sun, 24 Mar 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711280192; cv=none; b=nHFJKNMgOd7vZ4AqiqD31U8P38wjXHPAkJv6mbv/KAKWyuJczlAgUVICab0rUKn94Z7/AQKzW1eJW8ou7Wboxw4GsRqLEjYpY8aTzjxX3+7Wbp9nMJAAhx/l1RvzVSKfaTdpCsAP99BVTw3KDoh9OllfL1T0ZrtfCp80xkMX/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711280192; c=relaxed/simple;
	bh=0ad8LYllcbY4Ac2blpqvmpG1kU1FUyA+sNyhDuKl5f8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk05QWRLdEzDPqRuVqRSlAhlhFK9gaqylsAHfvnq7s90GghZJhrHelxlEMrzdJeYEBry9iZK+UxCnCPuwoNtKJRFy8wUnodhpzO+sgzUE45PB3E2qhMN/y9g+qSteXLV2/rDclUnB0InsLfWUug6Ro/OEDHK4xwrQSocmpNOToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCh1Ncfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F065C433C7;
	Sun, 24 Mar 2024 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711280191;
	bh=0ad8LYllcbY4Ac2blpqvmpG1kU1FUyA+sNyhDuKl5f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCh1NcfbjoXGii1W8TH7gL8OCr2oAEHwDzqvQviVBOQCJGT0/TVbW8/JtxCfWKpS6
	 NU0EQkiVye6Eth8SDKB/X/hIH6Fdgkf5UH1IHCP+ShbeONDk588sadfpSLucwEZwAw
	 9hKgBWgTSzZIMOI3tXNwPoG/uyyaF++f0YWe2dH3KsKZv94MCQrTq6AS27PJc9KCWb
	 yCoBDj2Sk21bejzqBVUji1SocMX+QE9SWqZY74JMftVkZOXl5JgBrF5ApteAhXVWVV
	 YEI7GGhodIMLhdreZKTQp48iq7vmYFDo04scisXO8G749NLkbA9AmCKwiMU8qWftN4
	 kkiOuf65udL7w==
Date: Sun, 24 Mar 2024 11:36:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: Generalize
 read_{temp/press/humid}() functions
Message-ID: <20240324113616.02f9f391@jic23-huawei>
In-Reply-To: <20240319002925.2121016-4-vassilisamir@gmail.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
	<20240319002925.2121016-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 01:29:22 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add the coefficients for the IIO standard units and the return
> IIO value inside the chip_info structure.
> 
> Remove the calculations with the coefficients for the IIO unit
> compatibility from inside the read_{temp/press/humid}() functions
> and move it to the general read_raw() function.
> 
> Execute the calculations with the coefficients inside the read_raw()
> oneshot capture function.
> 
> In this way, all the data for the calculation of the value are
> located in the chip_info structure of the respective sensor.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hi,

Perhaps it's later in the series, but I still don't much like the hidden nature
of t_fine. I'd much rather that was explicitly 'returned' by the function
- by that I mean read_temp takes an s32 *t_fine and provides that if the pointer
isn't NULL.

Then drop the cached value in bmp280_data which I think just serves to make
this code less readable than it could be.

Then bmp280_compensate_pressure() can take a struct bmp280_calib, s32 adc_press and
s32 t_fine so it just has the data it needs.
Something similar for bmp280_compenstate_temp()

Obviously this is cleaning up stuff that's been there a long time, but
given you are generalizing these functions this seems like the time to
make these other changes.

As it stands, I don't think this code works as t_fine isn't updated
everywhere it needs to be and that is hidden away by it being updated
as a side effect of other calls.

Jonathan


> ---
>  drivers/iio/pressure/bmp280-core.c | 189 +++++++++++++++--------------
>  drivers/iio/pressure/bmp280.h      |  13 +-
>  2 files changed, 106 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index f7a13ff6f26c..6d6173c4b744 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -363,10 +363,9 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
>  	return (u32)p;
>  }
>  
> -static int bmp280_read_temp(struct bmp280_data *data,
> -			    int *val, int *val2)
> +static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
>  {
> -	s32 adc_temp, comp_temp;
> +	s32 adc_temp;
>  	int ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> @@ -382,29 +381,20 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  		dev_err(data->dev, "reading temperature skipped\n");
>  		return -EIO;
>  	}
> -	comp_temp = bmp280_compensate_temp(data, adc_temp);
>  
> -	/*
> -	 * val might be NULL if we're called by the read_press routine,
> -	 * who only cares about the carry over t_fine value.
> -	 */
> -	if (val) {
> -		*val = comp_temp * 10;
> -		return IIO_VAL_INT;
> -	}
> +	if (comp_temp)
> +		*comp_temp = bmp280_compensate_temp(data, adc_temp);

As below, I don't think this is updating t_fine.
Another reason to make that update very obvious rather than burried
in this function call.

>  
>  	return 0;
>  }
>  
> -static int bmp280_read_press(struct bmp280_data *data,
> -			     int *val, int *val2)
> +static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
>  {
> -	u32 comp_press;
>  	s32 adc_press;
>  	int ret;
>  
>  	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp280_read_temp(data, NULL, NULL);
> +	ret = bmp280_read_temp(data, NULL);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -421,22 +411,19 @@ static int bmp280_read_press(struct bmp280_data *data,
>  		dev_err(data->dev, "reading pressure skipped\n");
>  		return -EIO;
>  	}
> -	comp_press = bmp280_compensate_press(data, adc_press);
>  
> -	*val = comp_press;
> -	*val2 = 256000;
> +	*comp_press = bmp280_compensate_press(data, adc_press);
>  
> -	return IIO_VAL_FRACTIONAL;
> +	return 0;
>  }
>  
> -static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> +static int bmp280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
>  {
> -	u32 comp_humidity;
>  	s32 adc_humidity;
>  	int ret;
>  
>  	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp280_read_temp(data, NULL, NULL);
> +	ret = bmp280_read_temp(data, NULL);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -453,11 +440,10 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  		dev_err(data->dev, "reading humidity skipped\n");
>  		return -EIO;
>  	}
> -	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
>  
> -	*val = comp_humidity * 1000 / 1024;
> +	*comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
>  
> -	return IIO_VAL_INT;
> +	return 0;
>  }
>  
>  static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
> @@ -465,6 +451,8 @@ static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
>  				   int *val, int *val2, long mask)
>  {
>  	struct bmp280_data *data = iio_priv(indio_dev);
> +	int chan_value;
> +	int ret;
>  
>  	guard(mutex)(&data->lock);
>  
> @@ -472,11 +460,29 @@ static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> -			return data->chip_info->read_humid(data, val, val2);
> +			ret = data->chip_info->read_humid(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = data->chip_info->humid_coeffs[0] * chan_value;
> +			*val2 = data->chip_info->humid_coeffs[1];
> +			return data->chip_info->humid_coeffs_type;
>  		case IIO_PRESSURE:
> -			return data->chip_info->read_press(data, val, val2);
> +			ret = data->chip_info->read_press(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = data->chip_info->press_coeffs[0] * chan_value;
> +			*val2 = data->chip_info->press_coeffs[1];
> +			return data->chip_info->press_coeffs_type;
>  		case IIO_TEMP:
> -			return data->chip_info->read_temp(data, val, val2);
> +			ret = data->chip_info->read_temp(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = data->chip_info->temp_coeffs[0] * chan_value;
> +			*val2 = data->chip_info->temp_coeffs[1];
> +			return data->chip_info->temp_coeffs_type;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -787,6 +793,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  
>  static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
>  static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
> +static const int bmp280_temp_coeffs[] = { 10, 1 };
> +static const int bmp280_press_coeffs[] = { 1, 256000 };
>  
>  const struct bmp280_chip_info bmp280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> @@ -815,6 +823,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
>  	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>  	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
>  
> +	.temp_coeffs = bmp280_temp_coeffs,
> +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> +	.press_coeffs = bmp280_press_coeffs,
> +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> +
>  	.chip_config = bmp280_chip_config,
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
> @@ -841,6 +854,7 @@ static int bme280_chip_config(struct bmp280_data *data)
>  }
>  
>  static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
> +static const int bme280_humid_coeffs[] = { 1000, 1024 };
>  
>  const struct bmp280_chip_info bme280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> @@ -863,6 +877,14 @@ const struct bmp280_chip_info bme280_chip_info = {
>  	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>  	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
>  
> +	.temp_coeffs = bmp280_temp_coeffs,
> +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> +	.press_coeffs = bmp280_press_coeffs,
> +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> +	.humid_coeffs = bme280_humid_coeffs,
> +	.humid_coeffs_type = IIO_VAL_FRACTIONAL,
> +
> +
One blank line is almost always enough.

>  	.chip_config = bme280_chip_config,
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
> @@ -988,9 +1010,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
>  	return comp_press;
>  }
>  
> -static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
> +static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
>  {
> -	s32 comp_temp;
>  	u32 adc_temp;
>  	int ret;
>  
> @@ -1006,29 +1027,20 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
>  		dev_err(data->dev, "reading temperature skipped\n");
>  		return -EIO;
>  	}
> -	comp_temp = bmp380_compensate_temp(data, adc_temp);
>  
> -	/*
> -	 * Val might be NULL if we're called by the read_press routine,
> -	 * who only cares about the carry over t_fine value.
> -	 */
> -	if (val) {
> -		/* IIO reports temperatures in milli Celsius */
> -		*val = comp_temp * 10;
> -		return IIO_VAL_INT;
> -	}
> +	if (comp_temp)
> +		*comp_temp = bmp380_compensate_temp(data, adc_temp);
>  

I'm confused. If comp_temp is not provided then t_fine isn't updated
so this function isn't doing anything?

>  	return 0;
>  }
>  
> -static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
> +static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
>  {
> -	s32 comp_press;
>  	u32 adc_press;
>  	int ret;
>  
>  	/* Read and compensate for temperature so we get a reading of t_fine */

As above, I don't think it does. 

> -	ret = bmp380_read_temp(data, NULL, NULL);
> +	ret = bmp380_read_temp(data, NULL);
>  	if (ret)
>  		return ret;
>  
> @@ -1044,13 +1056,10 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
>  		dev_err(data->dev, "reading pressure skipped\n");
>  		return -EIO;
>  	}
> -	comp_press = bmp380_compensate_press(data, adc_press);
>  
> -	*val = comp_press;
> -	/* Compensated pressure is in cPa (centipascals) */
> -	*val2 = 100000;
> +	*comp_press = bmp380_compensate_press(data, adc_press);
>  
> -	return IIO_VAL_FRACTIONAL;
> +	return 0;
>  }
>  

J

