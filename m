Return-Path: <linux-kernel+bounces-52621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022CD849A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18A2282074
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B22CCB4;
	Mon,  5 Feb 2024 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GemHoD06"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5A1CABD;
	Mon,  5 Feb 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136606; cv=none; b=C9dU/pUeAobrZmJackk1T21vGlMIbJMqwrvrU7w4y8152so/ogaYlbjEngEsp5bG4DcnFPH2hZrxredDe5HS7XWc7U18i+/gDkrPGaFqjeMofuSwAOa+r4w9ANgXCVxCy/a9A5/jIh8HoOwzkMkevziUk8KQ5WiSr015wGRLPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136606; c=relaxed/simple;
	bh=ENgpbAtrqID8ovJNk+F/h+zg1txNrGQPaTzLXnkwiLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6UKTF3AOLbwgWRjmXGsnYD07ylDk2TOOYfkFW+iUj2WmEccdcwMRPmQMo355U7+rhwd8b6ymjELQ/bUsj/6scJKkx07Be/yx7BQjLKnZjF8qgrqJaWJlKUk4QaynjsqudICNBxR8BbDOgoOU/piTTyupXKvFkxQy0PSJeUwMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GemHoD06; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707136604; x=1738672604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ENgpbAtrqID8ovJNk+F/h+zg1txNrGQPaTzLXnkwiLQ=;
  b=GemHoD06K1eA1j4Adi7cIcvvVcGEej9YgMBrxZVsMLyxepWqHfKocaTC
   Xe7y465ZRskszFjS1eqxU2ki9M6KFK2W1wN5x/dxYSn67hbQEqPrIAtGx
   DPDAqHxdwvNHyVpDGCsowz2L2RUwRD8F8Amv/dOJ0Mm4gVGmiAuusOmLU
   yousYO8P+2Ux6mt+C/sBbO+YwWWmGiX8eokuebN4JEcBs3LFkJ6clOyAM
   vGtvqRdm5tgtEWbROaeNkxAroTt+bf6SL5GB0wydyQvvF5YilSMiDrT+s
   T4DCopdGwNlyIRugPPsOJHO1AUN3V9sH2g+vQYACPXca/2OKPyUMHgWtW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11883224"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11883224"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909285677"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909285677"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:36:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWxw1-000000023v6-3Rmk;
	Mon, 05 Feb 2024 14:18:49 +0200
Date: Mon, 5 Feb 2024 14:18:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 08/23] gpio: sysfs: use gpio_device_find() to iterate
 over existing devices
Message-ID: <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-9-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205093418.39755-9-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 10:34:03AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With the list of GPIO devices now protected with SRCU we can use
> gpio_device_find() to traverse it from sysfs.

..

> +static int gpiofind_sysfs_register(struct gpio_chip *gc, void *data)
> +{
> +	struct gpio_device *gdev = gc->gpiodev;
> +	int ret;
> +
> +	if (gdev->mockdev)
> +		return 0;
> +
> +	ret = gpiochip_sysfs_register(gdev);
> +	if (ret)
> +		chip_err(gc, "failed to register the sysfs entry: %d\n", ret);

> +	return 0;

???

> +}

-- 
With Best Regards,
Andy Shevchenko



