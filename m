Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81179CF17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjILLBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjILLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:00:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6764610EA;
        Tue, 12 Sep 2023 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694516413; x=1726052413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7LI0Lcn1tZ9nSaNU+/wLNDgyjDl4hPoZ/HYUyLym8Q=;
  b=dbRV3gd2/tOuWbPDk1lwlD0oae9xH0ffpy9vR8MyaVJRMRP07vne06rb
   kS71goBxGTGQe92BfwTIZwdNModKoRlOh1jigIa7WAaHcr5yB7v9c7fcr
   dyJAEIUTWtYnFSr1NrMUVn/C7GzU/e3GzsGe3dnv+/IFl2em/2Q6pDR3v
   IBp7CSUilELssZIb7blRNP9kIweBXjjQ/wNGJ6eeaKYelgNfjBTIq+pQ6
   d9RTIoR3T2oDwGaOPTzQhKm+D4MDUndtspuKG7bv67zpsixhkZjxgtXmV
   XBaosEE+6X0PD3ALTF7zDnR78mZ80s6xGSJ1AD+DUYanj/8UQsQpAQfJF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357771306"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="357771306"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778747712"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="778747712"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:00:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg17n-008ZCq-2F;
        Tue, 12 Sep 2023 14:00:07 +0300
Date:   Tue, 12 Sep 2023 14:00:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 05/11] gpiolib: provide gpio_device_get_desc()
Message-ID: <ZQBEtxYO1hb4KJ1V@smile.fi.intel.com>
References: <20230912100727.23197-1-brgl@bgdev.pl>
 <20230912100727.23197-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912100727.23197-6-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:07:21PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Getting the GPIO descriptor directly from the gpio_chip struct is
> dangerous as we don't take the reference to the underlying GPIO device.
> In order to start working towards removing gpiochip_get_desc(), let's
> provide a safer variant that works with an existing reference to struct
> gpio_device.

...

> +struct gpio_desc *
> +gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum)
> +{
> +	struct gpio_chip *gc = gdev->chip;

I prefer

	struct gpio_chip *gc;

> +	/*
> +	 * FIXME: This will be locked once we protect gdev->chip everywhere
> +	 * with SRCU.
> +	 */

	gc = gdev->chip;

as it is more robust against changes in between and easier to read and
understand in the code what's going on. With decoupled assignment in this case
it's harder to see at the flash glance if the gc is parameter of the function
or being derived from somewhere else.

> +	if (!gc)
> +		return ERR_PTR(-ENODEV);
>  
>  	if (hwnum >= gdev->ngpio)
>  		return ERR_PTR(-EINVAL);
>  
>  	return &gdev->descs[hwnum];
>  }

-- 
With Best Regards,
Andy Shevchenko


