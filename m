Return-Path: <linux-kernel+bounces-67364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445C856A73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57FE1F26184
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54199136661;
	Thu, 15 Feb 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1MypJe7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FF1754B;
	Thu, 15 Feb 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016618; cv=none; b=pY11Xn3WymbbMrarhcttl7Lifjy7c+dOhk72vOe4OicxkaqpuiPgYi5gELvonZtwHaYz+FYr6iu/0WmuhRJesBoqvUavq0YGsnrQJLe2nF9iGs02DFyj1DVz/G71y7mWh1RnKnWY/2bdgf0FDF7APKqiELwHzbDTB4xulgsBSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016618; c=relaxed/simple;
	bh=zENlI1nyDk9gIlHapvGCt964eDj8R89UcvJ0TSOCsJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRXvUyzE60kN5wt2x/h8QJTjclTjqtaoBqX4U/Emx7DapxOyrRxPzwO5dQErPprc9V6OV2NG4LMlIk9bT4rqiYmtMKa5K2XSuyHIaSYCABbb7ybEX2sfamVEp4FP2+cpKZ6gDHI1A42HmG0j8fLoxFVr+f8/xIUjvMOawz/5rS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1MypJe7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708016616; x=1739552616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zENlI1nyDk9gIlHapvGCt964eDj8R89UcvJ0TSOCsJs=;
  b=b1MypJe7/8hjFLQAuiiYSRExYVVepRfVjSM0Ps9ghBbQu4HMNCmU6D0q
   zxTcXgeeotvMOzjcLQFeCq6ROded61InbyniI2JRjLkTLbKA6TOejULXb
   X6D9o/jToYy4ho/lbkLVSgDKs8N1UcJPwuMg25ziTW6YpEfiBbXXTT83r
   pFUoHhyzNjNNHq+iWneNNgU01+RH+alCg5VZqXFhAvY3XeSGeZ1QR3vkh
   F9agCVCoYMliu/ElZx61WN9iewazefjpxYNvuVWgV565Rxqr10L3xcCoW
   ppDIu7JCxII9dUq5hi9nuSUncoHe9p2By9mUxZsudmJ2wd1eTZlIfPj0J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2256119"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2256119"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="826437696"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="826437696"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:03:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raf8x-00000004qbb-3ncM;
	Thu, 15 Feb 2024 19:03:27 +0200
Date: Thu, 15 Feb 2024 19:03:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and
 BMP390
Message-ID: <Zc5D35_4FdERZXe4@smile.fi.intel.com>
References: <20240215164332.506736-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215164332.506736-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 05:43:32PM +0100, Vasileios Amoiridis wrote:
> According to the datasheet of BMP38x and BMP390 devices, in SPI
> operation, the first byte that returns after a read operation is
> garbage and it needs to be dropped and return the rest of the
> bytes.

Thank you for the patch, my comments below.

..

> +static int bmp380_regmap_spi_read(void *context, const void *reg,
> +				  size_t reg_size, void *val, size_t val_size)
> +{
> +	struct spi_device *spi = to_spi_device(context);
> +	u8 ret[BMP380_SPI_MAX_REG_COUNT_READ + 1];
> +	ssize_t status;
> +	u8 buf;

AFAIU this buffer is not DMA-capable.

> +	memcpy(&buf, reg, reg_size);

I prefer to see a switch case with cases based on allowed sizes and proper
endianess accessors.

> +	buf |= 0x80;

This is done by regmap, no?

> +	/*
> +	 * According to the BMP380, BMP388, BMP390 datasheets, for a basic
> +	 * read operation, after the write is done, 2 bytes are received and
> +	 * the first one has to be dropped. The 2nd one is the requested
> +	 * value.
> +	 */
> +	status = spi_write_then_read(spi, &buf, 1, ret, val_size + 1);

sizeof() ?

> +	if (status)
> +		return status;

> +	memcpy(val, ret + 1, val_size);

As per above.

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



