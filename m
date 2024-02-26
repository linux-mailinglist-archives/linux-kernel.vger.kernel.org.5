Return-Path: <linux-kernel+bounces-81591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B48677EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108B3290D25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DA129A95;
	Mon, 26 Feb 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wf7ZRLx8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779E128389;
	Mon, 26 Feb 2024 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956753; cv=none; b=GizA9HWRHPhIorjDDiuyGwncMk1uaix8PFK4koYpTLqRcmCH0nZVe3QueWNmQLEK1/sxCAg6lm0q0U9xXZ84mfknHSEGVZXS5qt3nOLwAZuce3n0QoyQ1WfrBr4NcFbM3O9ZXCiEFHp/WQ+6/8rRhBba/ld3ELfyL6pSVDTIWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956753; c=relaxed/simple;
	bh=UtF0hU+9ize1OU+qLoslQEHlSpGHD5zpSnj1SCFGdww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMXrZbwgQ843Y2czSEwTuwQWqF7DUhD7U7cipWZqf8tREcZIvQFBKJCQBnH7LFbikNO3hsyMPweonKeYC/O2T0wv1xFo0WMvWoHmKVWc/UKKDtT+b1jRFwth5DwfWAiwTQouiBOOUY6oLmYpj/zD9QRZvFQxw7L9RsAo83n1Mpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wf7ZRLx8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708956753; x=1740492753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UtF0hU+9ize1OU+qLoslQEHlSpGHD5zpSnj1SCFGdww=;
  b=Wf7ZRLx8fzxO0iwIciHCEZHDRFVtFM3+eEbRMHJHHMnpkwfru1XCnkGU
   XZsZ7FXGCnqfxBrWZs1sbPGT724mF79406ij4M6Ag2W0ZxyHckUw8G/Jn
   ySIjptUp5tFbQ5PDm9RfBP+k6WGre2HezqhwxWdaYDQfXX8TXNY8Iei79
   UioeVWBJbbGikjh8Yah3o7z/g/bAKZapMXsKRuC3FGc06+dB0eHZwbQGN
   O/51ZcGGxktB930Oo7AbuA1R9I3NhPgK4on58e8DPTwkbWd2hTzGLn9ub
   OBYU05lzaFw5Wzd4Ars2rMfDowvGO9IbnCr2XNA+7Szn8Ebz9PAXxw9oG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="7046723"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7046723"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913871995"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913871995"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:12:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rebiS-00000007hMH-04x7;
	Mon, 26 Feb 2024 16:12:24 +0200
Date: Mon, 26 Feb 2024 16:12:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZdycR6nr3rtrnuth@smile.fi.intel.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
 <20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 18, 2024 at 04:18:26PM +1030, Subhajit Ghosh wrote:
> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
> channel approximates the response of the human-eye providing direct
> read out where the output count is proportional to ambient light levels.
> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
> caused by artificial light sources. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.
> 
> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
> Scales, Gains and Integration time implementation.

..

> +/*
> + * Available scales with gain 1x - 18x, timings 3.125, 25, 50, 100, 200, 400 mS

"mS" --> "ms."

> + * Time impacts to gain: 1x, 8x, 16x, 32x, 64x, 128x
> + */

..

> +	/*
> +	 * If this function runs parallel with the interrupt handler, either
> +	 * this reads and clears the status registers or the interrupt handler
> +	 * does. The interrupt handler sets a flag for read data available
> +	 * in our private structure which we read here.
> +	 */
> +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
> +				       status, data->read_data_available ||
> +				       (status & (APDS9306_ALS_DATA_STAT_MASK |
> +						  APDS9306_ALS_INT_STAT_MASK)),
> +				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);

> +

Redundant blank line

> +	if (ret)
> +		return ret;

..

> +static int apds9306_init_iio_gts(struct apds9306_data *data)
> +{
> +	int i, ret, part_id;
> +
> +	ret = regmap_read(data->regmap, APDS9306_PART_ID_REG, &part_id);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(apds9306_gts_mul); i++)
> +		if (part_id == apds9306_gts_mul[i].part_id)
> +			break;
> +
> +	if (i == ARRAY_SIZE(apds9306_gts_mul))
> +		return -ENXIO;

Strange choice of the error code, why not (one of) -ENOENT / -ENODATA ?

> +	return devm_iio_init_iio_gts(data->dev,
> +				     apds9306_gts_mul[i].max_scale_int,
> +				     apds9306_gts_mul[i].max_scale_nano,
> +				     apds9306_gains, ARRAY_SIZE(apds9306_gains),
> +				     apds9306_itimes, ARRAY_SIZE(apds9306_itimes),
> +				     &data->gts);

> +
> +	return -ENXIO;

Dead code.

> +}

..

Jonathan, are you going to apply this and addressing comments at the same time?
Or should it be another version?

-- 
With Best Regards,
Andy Shevchenko



