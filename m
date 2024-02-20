Return-Path: <linux-kernel+bounces-73155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626985BE40
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899D81C20E55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570B16A8DB;
	Tue, 20 Feb 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9M8KbcQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528B6A8A7;
	Tue, 20 Feb 2024 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438173; cv=none; b=eZt/ve24Fqw0JBKDFy12qUc3p+aWT2AHvXfKSMJ1YmOgGMAYn8l3biF6RVYD4rsEk3BsIjVnwmbegNdcjar/wiHULnecN+LVCZ0LVbue/e7OuTOTYaM77+vg6kkl+1Ppe3U9CJAVIVw7NXe/puSMTQKzczOPSETqtaPZf9ocSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438173; c=relaxed/simple;
	bh=j/YnzyTz1wKrobyyvYpo/CHxXfXEWCwp2tQdOVkqBKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqnG+ji8GQFNURhnyGwkAluBqYd6pLeK96VT8IQxFZugVhM0dLLkGiEIIjznwivV9nYvuA+7wYQAT1CJOwU5+rsI1x4OfEXXK5u3YbNEIMGVKOeqP0qAVrMPPbGGLbcgkGL8dcmYHqOxO8/Udz/qym1+WYPFowpnj4m6SGbW+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9M8KbcQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708438172; x=1739974172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/YnzyTz1wKrobyyvYpo/CHxXfXEWCwp2tQdOVkqBKY=;
  b=I9M8KbcQOrkPXijljq6tTd0mJXit3xZhlmAhgTgANIv7lCbUyHEuAbzx
   rU/3yUj/zOazDwjIqCK2QcobOQ6dNkbM8wU6ZTPZpSJZn/bwPsLjFY1D1
   /vfuVIBGqeTA8hYrK16MYnX7HLzDJFZuGkCTzyDSWiWKEplRNXEGig2cm
   WjREuGIrzZ8vmaAhAvgaFra3i8khlsbxFcogF+U8xzzfG+sMjyN38gTj2
   AfPU3zMWR8JtjfAfIDRVh02pXiNiilTlfU/vXX6cIDaj7ZWDZDS32rn/T
   a0Wb9b4FIJ/8z7FgcMHGHK1MdM5vrn2po+REUvFgG2cAQd/9pqpX7feWh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6358970"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6358970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:09:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913082208"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913082208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:09:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcQoI-000000066IQ-2xbo;
	Tue, 20 Feb 2024 16:09:26 +0200
Date: Tue, 20 Feb 2024 16:09:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <ZdSyljwOyxIY7Gvb@smile.fi.intel.com>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219191359.18367-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 08:13:59PM +0100, Vasileios Amoiridis wrote:
> According to the datasheet of BMP38x and BMP390 devices, for an SPI
> read operation the first byte that is returned needs to be dropped,
> and the rest of the bytes are the actual data returned from the
> sensor.

..

>  #include <linux/spi/spi.h>
>  #include <linux/err.h>
>  #include <linux/regmap.h>
> +#include <linux/bits.h>

I see that it's unsorted, but try to squeeze a new header to the better place
where more will be kept sorted. With given context, it should go before all
others, but it might be even better location.

..

> +static int bmp380_regmap_spi_read(void *context, const void *reg,
> +				  size_t reg_size, void *val, size_t val_size)
> +{
> +	struct spi_device *spi = to_spi_device(context);
> +	u8 rx_buf[4];
> +	ssize_t status;
> +
> +	/*
> +	 * Maximum number of consecutive bytes read for a temperature or
> +	 * pressure measurement is 3.
> +	 */
> +	if (val_size > 3)
> +		return -EINVAL;
> +	/*
> +	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
> +	 * the first byte needs to be dropped and the rest are the requested
> +	 * data.
> +	 */
> +	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
> +	if (status)
> +		return status;

> +	memcpy(val, rx_buf + 1, val_size);

Okay, endianess is defined in the regmap_bus below...

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



