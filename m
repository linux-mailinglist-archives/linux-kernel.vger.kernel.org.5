Return-Path: <linux-kernel+bounces-86889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D4A86CC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B94B224FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D41137C3F;
	Thu, 29 Feb 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGzoHtFK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A27D419;
	Thu, 29 Feb 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219001; cv=none; b=S5f4uSzR4HX+WuJMIy/wBiyWw0gMYu997lz8Pp2PFrKl7QUK/V4AGaz8CeWKOuuP/rixejPbQ8hMupZlpI1SmNzSi+viBettGiJywm89d1ifv1Vn26hZFNgayg9fJljy0kQK28JmeefSaEIeLK5XGWsgAmpFniZr3t893l7tNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219001; c=relaxed/simple;
	bh=B3j6dMfEFF9rdkpHUi9+vQzEugFC8IlTQWqn9S39dXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/XAila3jpM6hi4SSSNHERDAMaF1Y2fwigBFYYblctYevaYT+zLrCDJDsRxtOfX3tA8NA4/pZ4x7MaUAcIv5O1dJjau4F122bMjgjYW0MK9wMS0ZF2zrciU9vC4NELOvWGJF5VoXmZCj2rOcd8akMGp89e3IBSgolsajSTp8ykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGzoHtFK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709219000; x=1740755000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3j6dMfEFF9rdkpHUi9+vQzEugFC8IlTQWqn9S39dXg=;
  b=HGzoHtFKH08DyvlxChM4Tvd9JPPpxynJu5NOCsU2XPNrz5X/3bHXp2a6
   I26j9UDxol+3Ac6U/eP+aEcnHZhylCbel/lmD5iZ8T72yFywt57Y8eThe
   fS5bDkXdbFS2MH5MagZoI1c8QQAwxyP6bJOxdd/rJmKGtM1nPVfyMAErV
   OfRnCm1pMpxyiQqYqlf6o/wjfR1At8IVBc00uvKHqcxwzl9E7HUoi+xmK
   ZocHYssr2LDxbNsk9I97/UOwK4bJ46zIrrg147exu2Gc78OsSz8yB3eC3
   bomwNZ0d+Ro9pq9ODUmlhwVCmLNVXxhoSReScJWa37NwOpzbBFrApSUhR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3571423"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3571423"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913984045"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913984045"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:03:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfhw2-00000008hTr-0HOK;
	Thu, 29 Feb 2024 17:02:58 +0200
Date: Thu, 29 Feb 2024 17:02:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2 1/2] gpiolib-of: Make of_gpio_get_count() take
 firmware node as a parameter
Message-ID: <ZeCcoYb8gTRGQTku@smile.fi.intel.com>
References: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
 <20240229145303.3801332-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229145303.3801332-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 04:51:38PM +0200, Andy Shevchenko wrote:
> Make of_gpio_get_count() take firmware node as a parameter in order
> to be aligned with other functions and decouple from unused device
> pointer. The latter helps to create a common fwnode_gpio_count()
> in the future.
> 
> While at it, rename to be of_gpio_count() to be aligned with the others.

..

>  struct device;
> +struct fwnode_handle;

I just realized that this should be replacement, not addition.

 -struct device;
 +struct fwnode_handle;

Bart, tell me if you can update, or should I send a v3?

-- 
With Best Regards,
Andy Shevchenko



