Return-Path: <linux-kernel+bounces-108838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BAD8810B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4311F214F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10AB3FBAD;
	Wed, 20 Mar 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oi5X4rSs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40103FB83;
	Wed, 20 Mar 2024 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933373; cv=none; b=E8T27OaJTLvMNMAn5rwmqL5H+X6m9nseGExHd1/v6PyjMm22SZ2QNtI+SLSNCoX99W2jxbspVDvT2X8SEiowEblhLiLFUp0bP05l3GHb7e4v/ZJTdtIT+Xf3+wVKW1LamiDR0K88Zs6XnlEp3ooIy/fhWtN/tcbe55w3DoBErFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933373; c=relaxed/simple;
	bh=/jLqpWHjEC9vw4QQMcy5/bsS1ANfJ+WaN4wN29FCKxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAUZDuL/Ss5QJVhsSdk2ah4QRgJ4ecd06Dsrx0S2HGfxsBgtDYfO0iqReIwaFUlkeR9xDCa/OIpyDbpR6lXbuXBMAElzDYtGX0zIX+6fMXVji+dkgTDC7B+mGnwm/R+cBhhVkjnb7ORnk8J8VSi1Bbm07FWjWf8ldAdsFP9SlCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oi5X4rSs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710933371; x=1742469371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/jLqpWHjEC9vw4QQMcy5/bsS1ANfJ+WaN4wN29FCKxY=;
  b=Oi5X4rSs6ebLdwLwQk+He76SN8jyi9mdmqGHYlBqDF5NY61mq3ocaGCz
   vk69NOTZtkuzcCBu3ieejQ8oK0Mbs3nOEGciebKb2XBVdZLaBdDaFbeXT
   K1KqhOOCxxImT8yabHoZ2h92gy5GjmGptFcvi/dK+OZPOqdurW1T1+DVy
   HMzcEG7+NZ0nVkP73OXpmUetln57JBNn/zeUxClyVQqDir12IzHF88nmy
   fieJM2Q7U+TXY1YvIAyZNTeWAK1wqGnYsgL6526vscQYpp7Lv1fdXLcRf
   YlleJq/o7LZ8PVS2I2ntL9LiEzhr5ExF1ggYtA7xtD6PeE4Yxh7Xh6VHt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17296053"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17296053"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914663385"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914663385"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:16:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtvQ-0000000EYFD-00Yw;
	Wed, 20 Mar 2024 13:16:04 +0200
Date: Wed, 20 Mar 2024 13:16:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <ZfrFc9GF0_Jix5YT@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-7-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319002925.2121016-7-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 01:29:25AM +0100, Vasileios Amoiridis wrote:
> BMP2xx, BMP3xx, and BMP5xx use consecutive buffers for their
> temperature, pressure and humidity readings. This facilitates
> the use of burst reads in order to acquire data much faster
> and in a different way from the one used in oneshot captures.
> 
> BMP085 and BMP180 use a completely different measurement
> process that is well defined and is used in their buffer_handler().

..

>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> -			       data->buf, sizeof(data->buf));
> +			       data->buf, BMP280_NUM_TEMP_BYTES);

>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> -			       data->buf, sizeof(data->buf));
> +			       data->buf, BMP280_NUM_PRESS_BYTES);

>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> -			       &data->be16, sizeof(data->be16));
> +			       &data->be16, BME280_NUM_HUMIDITY_BYTES);

> -	adc_humidity = be16_to_cpu(data->be16);
> +	adc_humidity = get_unaligned_be16(&data->be16);

>  	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
> -			       data->buf, sizeof(data->buf));
> +			       data->buf, BMP280_NUM_TEMP_BYTES);

>  	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> -			       data->buf, sizeof(data->buf));
> +			       data->buf, BMP280_NUM_PRESS_BYTES);

>  	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
> -			       sizeof(data->buf));
> +			       BMP280_NUM_TEMP_BYTES);

>  	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
> -			       sizeof(data->buf));
> +			       BMP280_NUM_PRESS_BYTES);

These smell to me as candidates to a separate patch with more explanation why.
(Yes, with the definitions you introduced.) But I leave it to Jonathan to
decide if we need to split.

..

The below are applicable to the bmp280_buffer_handler(),
bmp380_buffer_handler() implementations as well.

..

> +	/* Burst read data registers */
> +	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
> +			       data->buf, 6);

Magic size.

..

> +	/* Temperature calculations */
> +	memcpy(&chan_value, &data->buf[3], 3);

_le24() + sign_extend32()?

..

> +	/* Pressure calculations */
> +	memcpy(&chan_value, &data->buf[0], 3);

_le24() + sign_extend32()?

..

>  	/*
> -	 * Maximum number of consecutive bytes read for a temperature or
> -	 * pressure measurement is 3.
> +	 * Maximum number of a burst read for temperature, pressure, humidity
> +	 * is 8 bytes.
>  	 */
> -	if (val_size > 3)
> +	if (val_size > 8)

sizeof() / new definition for the buf[] size?

>  		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko



