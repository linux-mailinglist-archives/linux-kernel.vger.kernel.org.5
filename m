Return-Path: <linux-kernel+bounces-108817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD588106A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A4B1C23366
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20343C46B;
	Wed, 20 Mar 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu+5nK3s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D233B293;
	Wed, 20 Mar 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932766; cv=none; b=M0e2XZTeuymCBvDAigkh+li5A76JnpuUERuSRvTPBnysC1bp1hvOQFRVJs4NjP8ui44XEW1b2PPc6rMshIBdOkzPuf2s7/cFDasKHdaDpFgs1PvTjhz/z+vF286gEK+6WADpjraCNRTqSpAtw1+LRc/FqC8sPyc+Q7wlCfLAfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932766; c=relaxed/simple;
	bh=tPdwuzKiTw4ZFvAg3Qj/XFVE/x7MXCkgcJpWEmJgm8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biBE75z/7GBVpXHVTiBbDThhBEk2YMebUPNfM5dC4vw//FA/HNeYAYtyyTYhVXGUOOOBU1uPBUY3jBdCjZtBxvvkkZv2tQqi27pZxEZTs4bOVzrEc+Q0ffCEFz0IzC4PI7ts/qJ/KpoPH2X2ne5l5OREqjPadbBXjsXxO0QbRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu+5nK3s; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710932766; x=1742468766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tPdwuzKiTw4ZFvAg3Qj/XFVE/x7MXCkgcJpWEmJgm8Y=;
  b=Yu+5nK3syKTwN4OXk2pknJW+1hlj8lbF1H2664EZ+i7QvK9mkt2XQyc8
   wRVRba7GldHq8sWf1juItKoYlHGazqG8G3UzlAqndhf4qycTcz3yVfdgc
   AN422kBFFsIctJLpG9p6eI18ZUwwQxyX/8BHuxper2OF4n5XioUj0aAmz
   DquivRN+aDvfJuRdE6571+CU1R6R1mrCFGeBdoWeDywM+GBooTh7z4PFn
   ckAxEK2wPNVDZEPQGGqcREugUurXQmI9nny7wZmB4hDiCRhc9j/oh2lCi
   2VC+njKNov8+GzSgR6Ghs3XV/c0is02Pa7Hak+BVTby96OmY9wMbY42Ss
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17295182"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17295182"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914662993"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914662993"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:06:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtle-0000000EY6h-3Iuv;
	Wed, 20 Mar 2024 13:05:58 +0200
Date: Wed, 20 Mar 2024 13:05:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iio: pressure: Add SCALE and RAW values for
 channels
Message-ID: <ZfrDFl-rmts9tPjk@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-5-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319002925.2121016-5-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 01:29:23AM +0100, Vasileios Amoiridis wrote:
> Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> able to calculate the processed value with standard userspace IIO
> tools. Can be used for triggered buffers as well.
> 
> Even though it is not a good design choice to have SCALE, RAW and
> PROCESSED together, the PROCESSED channel is kept for ABI compatibility.

..

> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			ret = data->chip_info->read_humid(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_value;
> +			return IIO_VAL_INT;
> +		case IIO_PRESSURE:
> +			ret = data->chip_info->read_press(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_value;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			ret = data->chip_info->read_press(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_value;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}

> +		return 0;

Dead code.

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = data->chip_info->humid_coeffs[0];
> +			*val2 = data->chip_info->humid_coeffs[1];
> +			return data->chip_info->humid_coeffs_type;
> +		case IIO_PRESSURE:
> +			*val = data->chip_info->press_coeffs[0];
> +			*val2 = data->chip_info->press_coeffs[1];
> +			return data->chip_info->press_coeffs_type;
> +		case IIO_TEMP:
> +			*val = data->chip_info->temp_coeffs[0];
> +			*val2 = data->chip_info->temp_coeffs[1];
> +			return data->chip_info->temp_coeffs_type;
> +		default:
> +			return -EINVAL;
> +		}

> +		return 0;

Ditto.

-- 
With Best Regards,
Andy Shevchenko



