Return-Path: <linux-kernel+bounces-73628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8BA85C54A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3A8285C11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457914A4C7;
	Tue, 20 Feb 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksy4Bdm+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7B37142;
	Tue, 20 Feb 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459063; cv=none; b=AFCDxbnC62qp7V8WR8e9AYpyd3rV5GggMQaJg7lpqfbfE5wmc9Riwx4XZxePzUp6O0adJmfx6cgTCJIqvn6eZYSsYXF3+qyYn3+YzLZRX9+UHyFawaTA2gV4yvD9SX2KAatC037sFg0Wt1P+RBfnHLmuD7joBMUWAroeJ4sZ0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459063; c=relaxed/simple;
	bh=etqvtIyKL0SnaWuBPHsMZK/bvT4f9hkIS7LhmNh7K1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrtkR46lKVgGOsaLC5iNwxZZjfGXPTiwQZC/X5OefVrFQZAwtYBDZ7VIwKvxIAdjFMFw/aBU25S8uBOr7t2vY1i/eHjBvErk9YhVUz5NdOMyzeycrruKmJBvyEo1Ids8bqPWtE7yyJ8azPoRNE42J5LLvND2h7BfQNzHRnEa6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksy4Bdm+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708459062; x=1739995062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etqvtIyKL0SnaWuBPHsMZK/bvT4f9hkIS7LhmNh7K1I=;
  b=ksy4Bdm+f2hlL4anrUmuyzCTfOOlQt9ePyzQovWdWXeDtEhtSufAbcAs
   QNhdnhuyNct4zWjOV7yRSJQssXVYPOL6DV7t5Ddyphn1xzxbJV+r/zzxZ
   g8Bk4ZV/vDmvRxEUnura3KmgupLfihPvXNOwmUPiGm3N2Igcgv7lN7XQJ
   T9S9Ar5yzqm3JLkqBmqxd0zX3NODIw2q5N4AYOdjG8NtfkhsKcNcqWjvx
   kFEacU+lLWqr9fAl25Er9vRDC2kq34cilozEURggfM90+7GFAsG4PjFll
   m2g4NSPM8A7z/Z7gNsbZjSg4sB3FWYvEMx4xOVCH+FCUpalWaREB2aNc6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2728745"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2728745"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 11:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913134867"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="913134867"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 11:57:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcWFD-00000006BRC-3mhA;
	Tue, 20 Feb 2024 21:57:35 +0200
Date: Tue, 20 Feb 2024 21:57:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <ZdUEL4zTfCZpWSyt@smile.fi.intel.com>
References: <20240220184125.32602-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220184125.32602-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 07:41:24PM +0100, Vasileios Amoiridis wrote:
> According to the datasheet of BMP38x and BMP390 devices, for an SPI
> read operation the first byte that is returned needs to be dropped,
> and the rest of the bytes are the actual data returned from the
> sensor.

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

I would add a blank line here.

> +	/*
> +	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
> +	 * the first byte needs to be dropped and the rest are the requested
> +	 * data.
> +	 */
> +	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
> +	if (status)
> +		return status;
> +
> +	memcpy(val, rx_buf + 1, val_size);
> +
> +	return 0;
> +}

With above and bits.h location being addressed
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



