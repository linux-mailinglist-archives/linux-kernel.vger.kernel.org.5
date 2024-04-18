Return-Path: <linux-kernel+bounces-149506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93C8A9222
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83ED6B211EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF7C54BD7;
	Thu, 18 Apr 2024 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PufkN56n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621D3EA64;
	Thu, 18 Apr 2024 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713415754; cv=none; b=ejQD3bllFkzsn6zKFXRyd2Tu4OfuU1A8CDZqtZAm2f5d30F1uiZdzqd5ySwOW86DJs1ykYt72xNkABcNIFocL1BX/4l1VNkaDXI514RIjA/vlURUcVAJ3PslZYjnt2ju8lxjI/ZfxTgP6zQreOS0z/60O5tiKykUGgGYEDntipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713415754; c=relaxed/simple;
	bh=uZZZb7IG5sNRBOUvK6nacLD/6K1v1UZPT35u/AZJAgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPTIWc+4XpaE1dyCbaaYnqceinPZ8BLPh8CxVd2OEvXZcbIJuCUzSqLAzG3UyqzqRpmnkIRwaedQ+gjgqT54qUU05c988OYduik7EEqlcKlpIK9fBu8u0B0kzkWkdiufzjRcz5c+Q3kkqQHIAV8FS8JfJC9VDh7zvDJWANhthvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PufkN56n; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713415752; x=1744951752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZZZb7IG5sNRBOUvK6nacLD/6K1v1UZPT35u/AZJAgA=;
  b=PufkN56nJ8jJHto/foA1y7thj0CDkSw31SUoo7Fxeuxta2cWsdgi8ss6
   kIfzJ1O5A86wLgMlkeRRy7eV/ke004vfKOmFczzB0sQnvbn1ttKxI81JW
   xod/RgiIpSxUnJ6B/dicikYPoiQpirStrsjEujYSYEoZWomV1u96btPjs
   LB5sehtLYyYOVeNz4uPxPvkZothhsWjOURZXr776fnnKW8P+lXdRd0YoI
   zkGjPvMbVpFxECTF//YVn8KYccZqr8VvsKqsREeyW4sdBTy2ckaAf5Rg/
   /dzIleEnfnOQ2a4Y5rQPxRnEgCBWJ68iuOoneEs0Oi+iyPuOai04Yl8iu
   g==;
X-CSE-ConnectionGUID: xSKXAVEtQpWuKy6O5xgtkA==
X-CSE-MsgGUID: Sbdt5TrFTwyIk9ddnkgvVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="11879311"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="11879311"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 21:49:10 -0700
X-CSE-ConnectionGUID: /IQdaY0/RwOdjbuWvJKMvg==
X-CSE-MsgGUID: LafMJ/ZDRNaaWfyKgogHpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22935340"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 17 Apr 2024 21:49:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id E9ECF24D; Thu, 18 Apr 2024 07:49:07 +0300 (EEST)
Date: Thu, 18 Apr 2024 07:49:07 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/2] gpiolib: acpi: Add fwnode name to the GPIO
 interrupt label
Message-ID: <20240418044907.GO112498@black.fi.intel.com>
References: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
 <20240417103829.2324960-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417103829.2324960-2-andriy.shevchenko@linux.intel.com>

On Wed, Apr 17, 2024 at 01:37:27PM +0300, Andy Shevchenko wrote:
> It's ambiguous to have a device-related index in the GPIO interrupt
> label as most of the devices will have it the same or very similar.
> Extend label with fwnode name for better granularity. It significantly
> reduces the scope of searching among devices.

Can you add an example here how it looks like before and after the
patch?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 909113312a1b..0b0c8729fc6e 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1035,6 +1035,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>  int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id, int index,
>  				  bool *wake_capable)
>  {
> +	struct fwnode_handle *fwnode = acpi_fwnode_handle(adev);
>  	int idx, i;
>  	unsigned int irq_flags;
>  	int ret;
> @@ -1044,7 +1045,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
>  		struct gpio_desc *desc;
>  
>  		/* Ignore -EPROBE_DEFER, it only matters if idx matches */
> -		desc = __acpi_find_gpio(acpi_fwnode_handle(adev), con_id, i, true, &info);
> +		desc = __acpi_find_gpio(fwnode, con_id, i, true, &info);
>  		if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
>  			return PTR_ERR(desc);
>  
> @@ -1064,7 +1065,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
>  			acpi_gpio_update_gpiod_flags(&dflags, &info);
>  			acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
>  
> -			snprintf(label, sizeof(label), "GpioInt() %d", index);
> +			snprintf(label, sizeof(label), "%pfwP GpioInt(%d)", fwnode, index);
>  			ret = gpiod_configure_flags(desc, label, lflags, dflags);
>  			if (ret < 0)
>  				return ret;
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac

