Return-Path: <linux-kernel+bounces-108812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2DE881059
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035121F233AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CD43A1CC;
	Wed, 20 Mar 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zyui/hC+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8C38DDC;
	Wed, 20 Mar 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932412; cv=none; b=RCfYzaqgcLm5ty+PJhkrJVQ8k+Vzpv58b7CnMDHqWK9MPjAnkYsqQnqcf4+qMZA8MvZeJHSRJQA61LRDo1uEju3acyWYTFw6BzpKx/2X7BcYw4JO20M0qC7re6EBcxja4Fy8cW3O3kDzT3aj78+l+2QmuYUX/2tPesusT7vagR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932412; c=relaxed/simple;
	bh=Aznw/c+qXOyZ2Z5JWJ5LOuv5wkmjEc5Gz0xaCb7OmTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJtpDJLH1U7d6eVDDAnGksthdceBX2Y3F/KGLH34p90KfX6E4dB4rnfMN1PRNKMV8YVs+XpxO026Bfytd0xKKlcDOVBN/tLkvnchqcD8HAaben0b76A4GLXJyuwpXjerSFkbhPN6th/bERDaIwjGVoZOPA5QrvgfQ9tU2UXjUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zyui/hC+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710932410; x=1742468410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aznw/c+qXOyZ2Z5JWJ5LOuv5wkmjEc5Gz0xaCb7OmTQ=;
  b=Zyui/hC+RXfi55mOOJyz247ZfOcCvbt4eJ9a5mkrwCpKGWgOQPMPEeFn
   X4/uDKh9ssBHNy7mVi+tVSqDJoP92GI16w1btxLRAvQBDTmgF8yTRdwfu
   PnAX04gMKeRNjkjEb9ZdYpD1Hu23cNTi/cfNF8uWWQkx4ii7dPBL/UukS
   obdX3CaCDuyq1PAcBKNiYbDWuRPSLC2+hQYOt9ojA8i/M2+N7Ut82EYpk
   8O68fBw8908hW+u0jsplr2i4ZFQXSkJUvfh6+gMTSuxbQk0LlbpXucNdJ
   UofeI98iH76JBRJhNqXPSdro5w1TXl78jWu4jawtqQGRrJ/+YWOuuaj8i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17294637"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="17294637"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914662756"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="914662756"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:00:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtft-0000000EY24-3tDz;
	Wed, 20 Mar 2024 13:00:01 +0200
Date: Wed, 20 Mar 2024 13:00:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/6] iio: pressure: Introduce new cleanup routines to
 BMP280 driver *_raw() functions
Message-ID: <ZfrBsY1rF-5stHqU@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319002925.2121016-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 01:29:21AM +0100, Vasileios Amoiridis wrote:
> Introduce the new linux/cleanup.h with the guard(mutex) functionality
> in the {read/write}_raw() functions

Missing period at the end of the sentence.

..

>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> -			ret = data->chip_info->read_humid(data, val, val2);
> -			break;
> +			return data->chip_info->read_humid(data, val, val2);
>  		case IIO_PRESSURE:
> -			ret = data->chip_info->read_press(data, val, val2);
> -			break;
> +			return data->chip_info->read_press(data, val, val2);
>  		case IIO_TEMP:
> -			ret = data->chip_info->read_temp(data, val, val2);
> -			break;
> +			return data->chip_info->read_temp(data, val, val2);
>  		default:
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}

> -		break;
> +		return 0;

Now dead code.

>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
>  			*val = 1 << data->oversampling_humid;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		case IIO_PRESSURE:
>  			*val = 1 << data->oversampling_press;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		case IIO_TEMP:
>  			*val = 1 << data->oversampling_temp;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}

> -		break;
> +		return 0;

Ditto.

>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (!data->chip_info->sampling_freq_avail) {
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
>  
>  		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
>  		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
> -		ret = IIO_VAL_INT_PLUS_MICRO;
> -		break;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		if (!data->chip_info->iir_filter_coeffs_avail) {
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
>  
>  		*val = (1 << data->iir_filter_coeff) - 1;
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	default:
> -		ret = -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}

> -	mutex_unlock(&data->lock);
> +	return 0;

Ditto.

..

> +
> +

One blank line is enough.

> +static int bmp280_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)

..

>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		pm_runtime_get_sync(data->dev);
> -		mutex_lock(&data->lock);
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> -			ret = bmp280_write_oversampling_ratio_humid(data, val);
> -			break;
> +			return bmp280_write_oversampling_ratio_humid(data, val);
>  		case IIO_PRESSURE:
> -			ret = bmp280_write_oversampling_ratio_press(data, val);
> -			break;
> +			return bmp280_write_oversampling_ratio_press(data, val);
>  		case IIO_TEMP:
> -			ret = bmp280_write_oversampling_ratio_temp(data, val);
> -			break;
> +			return bmp280_write_oversampling_ratio_temp(data, val);
>  		default:
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
> -		mutex_unlock(&data->lock);
> -		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> -		break;
> +		return 0;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		pm_runtime_get_sync(data->dev);
> -		mutex_lock(&data->lock);
> -		ret = bmp280_write_sampling_frequency(data, val, val2);
> -		mutex_unlock(&data->lock);
> -		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> -		break;
> +		return bmp280_write_sampling_frequency(data, val, val2);
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		pm_runtime_get_sync(data->dev);
> -		mutex_lock(&data->lock);
> -		ret = bmp280_write_iir_filter_coeffs(data, val);
> -		mutex_unlock(&data->lock);
> -		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> -		break;
> +		return bmp280_write_iir_filter_coeffs(data, val);
>  	default:
>  		return -EINVAL;
>  	}
>  
> +	return 0;

As per above, dead code.

..

> +static int bmp280_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct bmp280_data *data = iio_priv(indio_dev);

> +	int ret = 0;

Useless assignment.

> +
> +	pm_runtime_get_sync(data->dev);
> +	ret = bmp280_write_raw_guarded(indio_dev, chan, val, val2, mask);
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +
>  	return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko



