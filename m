Return-Path: <linux-kernel+bounces-103412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D654B87BF15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8743C1F24132
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D6E5D8E1;
	Thu, 14 Mar 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElSDM7sw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226626AF3;
	Thu, 14 Mar 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427111; cv=none; b=rfGZ4Wd29mKNLbH1lrKHBV17mYOkUTnyGky9OKfN9AqTrb3NDV40x7yEKTVRKk/NxP6/2JuYxcM4GXTgby6nppFCfUoPI7y/BvNzq8rRCzmjm8VlfMNEaGarKhZ+sVwee21ucmTJLaR9GX6OcngkpD2jI9rts6YUwyArSQNp4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427111; c=relaxed/simple;
	bh=UDk+oouaBX8vVHCqM/TYisvTh91sSlyDcrs/ar3dbao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwybZpneYyjyG+rrXgIAp+MWXnUDKxbxfxZaQuw4Jbidb+HkBlxYJLDH035AEVvgJkPdXNutoLKCPJNEjyj82DUQ08Fi+mRLyG4Xt7k3P0MVS2MonhXyQDuu6TUxrz3Sk5RLf2SsFcWErfCuyLQmK0LlP2oFGAinyzLkxh14/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElSDM7sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F80C433C7;
	Thu, 14 Mar 2024 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427110;
	bh=UDk+oouaBX8vVHCqM/TYisvTh91sSlyDcrs/ar3dbao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ElSDM7swuEJhZdfFJUhSL28X/ug43a3P0rJeX2yHMmd75M4L90jXWxVxQ/ZYLk101
	 YmKjFk7s6kC+pkZQl/meBtwT/BxQHc2+BDNdakhTV2p6K5IzhkPdaJkQdgy8KTXErW
	 MozzxrwGlaWslqoD5XE9+ksCvqwlc39533V3LWLDHOEf3stTyn31xT+Q8Q/ZEmM+cf
	 ky5ZY2yDvAV+YKj4Gxvaxx8r8KRW6EV3aJLbaM3wLHbrqHcT+qdeSZW2pzTKsenMIM
	 ThixMA5LcZFKveP+WiuHkBRcIojqmqzt2WFbjnnq/xnVAwVYDRtz+IW7kMGhrqao/e
	 9pnvR88MSCD7A==
Date: Thu, 14 Mar 2024 14:38:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: pressure: Simplify read_* functions
Message-ID: <20240314143813.69087bf3@jic23-huawei>
In-Reply-To: <20240313174007.1934983-3-vassilisamir@gmail.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 18:40:03 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add the coefficients for the IIO standard units inside the chip_info
> structure.
> 
> Remove the calculations with the coefficients for the IIO compatibility
> from inside the read_(temp/press/humid) functions and move it to the
> read_raw function.
> 
> Execute the calculations with the coefficients inside the read_raw
> oneshot capture functions.
> 
> Also fix raw_* and comp_* values signs.

That needs some more explanation.  Is this a fix that needs backporting?

> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 150 +++++++++++++----------------
>  drivers/iio/pressure/bmp280.h      |  10 +-
>  2 files changed, 74 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 871b2214121b..dfd845acfa22 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -363,8 +363,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
>  	return (u32)p;
>  }
>  
> -static int bmp280_read_temp(struct bmp280_data *data,
> -			    int *val, int *val2)
> +static s32 bmp280_read_temp(struct bmp280_data *data)

It's returning error codes through here. If you need to force a specific type,
don't use the return code.  Pass in a variable to put it in.

static int bm280_read_temp(struct bmp280_data *data, u32 *result)


>  {
>  	s32 adc_temp, comp_temp;
>  	int ret;
> @@ -384,27 +383,17 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  	}
>  	comp_temp = bmp280_compensate_temp(data, adc_temp);
>  
> -	/*
> -	 * val might be NULL if we're called by the read_press routine,
> -	 * who only cares about the carry over t_fine value.
> -	 */
> -	if (val) {
> -		*val = comp_temp * 10;
> -		return IIO_VAL_INT;
> -	}
> -
> -	return 0;
> +	return comp_temp;
>  }
>  
> -static int bmp280_read_press(struct bmp280_data *data,
> -			     int *val, int *val2)
> +static u32 bmp280_read_press(struct bmp280_data *data)
>  {
>  	u32 comp_press;
>  	s32 adc_press;
>  	int ret;
>  
>  	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp280_read_temp(data, NULL, NULL);
> +	ret = bmp280_read_temp(data);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -423,20 +412,17 @@ static int bmp280_read_press(struct bmp280_data *data,
>  	}
>  	comp_press = bmp280_compensate_press(data, adc_press);
>  
> -	*val = comp_press;
> -	*val2 = 256000;
> -
> -	return IIO_VAL_FRACTIONAL;
> +	return comp_press;
>  }
>  
> -static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> +static u32 bmp280_read_humid(struct bmp280_data *data)
>  {
>  	u32 comp_humidity;
>  	s32 adc_humidity;
>  	int ret;
>  
>  	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp280_read_temp(data, NULL, NULL);
> +	ret = bmp280_read_temp(data);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -455,9 +441,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  	}
>  	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
>  
> -	*val = comp_humidity * 1000 / 1024;
> -
> -	return IIO_VAL_INT;
> +	return comp_humidity;
>  }
>  
>  static int bmp280_read_raw(struct iio_dev *indio_dev,
> @@ -474,13 +458,27 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> -			ret = data->chip_info->read_humid(data, val, val2);
> +			ret = data->chip_info->read_humid(data);

You can still get an error code back from this and you must handle it.
Previously it was fine because both errors and IIO_VAL_ were returned by
the callback so error returns were handled, now they aren't.

> +			*val = data->chip_info->humid_coeffs[0] * ret;
> +			*val2 = data->chip_info->humid_coeffs[1];
> +			ret = IIO_VAL_FRACTIONAL;
>  			break;
Same applies in all the other cases.

Jonathan


