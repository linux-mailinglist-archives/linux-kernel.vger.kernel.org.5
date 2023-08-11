Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB67791C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjHKOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHKOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:24:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF3119;
        Fri, 11 Aug 2023 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691763887; x=1723299887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xgmlMY7GVvsgZ9tRIQomLS6YY/6BnxOw9F3jE7e7+zU=;
  b=HhE7jZjYJwX+8bE+VjbdrW1sLMdt4g2owl5tT+IXMUW6ed2tAcKlHw20
   tdK2gAOpRwqDVcY8H3RDcrKKz+1HothHZCBRlm76TiYwQN+1tb3FAdjzU
   SlmGAIeJ6QpD4PykcS0ULNdb0CBJ1b0rehssZOt65KJl+/otoAzNwiuGF
   gO6GPV9flBYibx3cQJSHDon2QNeiozJoTRYZcaWFAkZlcGSTEq25J48ND
   9VRkxdi9V000ZtlVdI/FrSJjXHNoXtIOXbtIliDVR1zeKyixcONJscGGF
   FJEK4qqtmLNkDRqTUiAJ2hQu97sjrIgAk4lMm8+BDCtRvetXznSoRXWkZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351289024"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351289024"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="856318002"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="856318002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2023 07:24:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUT4F-0016SZ-37;
        Fri, 11 Aug 2023 17:24:43 +0300
Date:   Fri, 11 Aug 2023 17:24:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2 v2] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZNZEq5wo655rttb/@smile.fi.intel.com>
References: <20230811131427.40466-1-brgl@bgdev.pl>
 <20230811131427.40466-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811131427.40466-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:14:27PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in gpio-sim.

...

>  	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
>  	int ret;
>  
> -	mutex_lock(&chip->lock);
> -	ret = !!test_bit(offset, chip->value_map);
> -	mutex_unlock(&chip->lock);
> +	scoped_guard(mutex, &chip->lock)
> +		ret = !!test_bit(offset, chip->value_map);
>  
>  	return ret;

Isn't the same approach applicable here?

...

>  {
>  	struct gpio_sim_chip *chip = gpiochip_get_data(gc);

With

	unsigned long *map = ...->value_map;

> -	mutex_lock(&chip->lock);
> -	bitmap_replace(chip->value_map, chip->value_map, bits, mask, gc->ngpio);
> -	mutex_unlock(&chip->lock);
> +	scoped_guard(mutex, &chip->lock)
> +		bitmap_replace(chip->value_map, chip->value_map, bits, mask,
> +			       gc->ngpio);

...you can satisfy me as well :-)

		bitmap_replace(map, map, bits, mask, gc->ngpio);

>  }

...

>  {
>  	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
>  
> -	mutex_lock(&chip->lock);
> -	__assign_bit(offset, chip->value_map, !!test_bit(offset, chip->pull_map));
> -	mutex_unlock(&chip->lock);
> +	scoped_guard(mutex, &chip->lock)
> +		__assign_bit(offset, chip->value_map,
> +			     !!test_bit(offset, chip->pull_map));

Ditto (I checked the line size).

>  }

...

>  	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
>  	struct gpio_sim_chip_name_ctx ctx = { bank->swnode, page };
> -	int ret;
>  
> -	mutex_lock(&dev->lock);
> +	guard(mutex)(&dev->lock);
> +
>  	if (gpio_sim_device_is_live_unlocked(dev))
> -		ret = device_for_each_child(&dev->pdev->dev, &ctx,
> -					    gpio_sim_emit_chip_name);
> -	else
> -		ret = sprintf(page, "none\n");
> -	mutex_unlock(&dev->lock);
> +		return device_for_each_child(&dev->pdev->dev, &ctx,
> +					     gpio_sim_emit_chip_name);
>  
> -	return ret;
> +	return sprintf(page, "none\n");

I looked at the original and at the change and maybe it could be done as

	struct device *parent = &dev->pdev->dev; // Naming?
	bool live;

	live = gpio_sim_device_is_live_unlocked(dev);
	if (!live)
		return sprintf(page, "none\n");

	return device_for_each_child(parent, &ctx, gpio_sim_emit_chip_name);

...

>  	int ret;
>  
> -	mutex_lock(&dev->lock);
> -	ret = sprintf(page, "%s\n", hog->name ?: "");
> -	mutex_unlock(&dev->lock);
> +	scoped_guard(mutex, &dev->lock)
> +		ret = sprintf(page, "%s\n", hog->name ?: "");
>  
>  	return ret;

guard() ?

-- 
With Best Regards,
Andy Shevchenko


