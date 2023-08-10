Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D3777B03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjHJOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjHJOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:42:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE287D7;
        Thu, 10 Aug 2023 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691678561; x=1723214561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sT/az+HrwfNw7HOP0aykpm15ZvFdEf/p5ptL+sS/SWk=;
  b=DXpYzul2gQxQNGoiKT4YP5nFpMdwTgUTXrqIHNJy5QDo/KMDlT8dGJyl
   iJfAD1pvZBprFGZ90aoonSuuRlAOmwuuD1hY8sl2QVrjBNPBH2sijqkWb
   VOyLUIfA8k+3Glo6bsjefdD+LKJju8ANnUvLqD/QcmrnznE6jzfjd5H8k
   X9LONEYXBouGc/TlZtG6is2hJIgkgDpJfQT/mxkBCEUD/w6qkArkT+ckN
   rw4FImA7QWUK3pUOKqTtjY2b9qAiqIbiGDo1DUT5SvgOF/9lDoYf+heaG
   YKyyxEQujs+umYgeh2NN6CJbcOGfUlriFQpK8mwlV/rhMdH920CiDizY1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351023425"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="351023425"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 07:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="822269952"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="822269952"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2023 07:39:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU6p2-005CWD-1U;
        Thu, 10 Aug 2023 17:39:32 +0300
Date:   Thu, 10 Aug 2023 17:39:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZNT2pNW3aPu82vs1@smile.fi.intel.com>
References: <20230809131442.25524-1-brgl@bgdev.pl>
 <20230809131442.25524-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809131442.25524-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:14:42PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the gpio-simulator.

gpio-sim ?

...

> -	mutex_lock(&chip->lock);
> +	guard(mutex)(&chip->lock);

I hoped to see somehing like

	guard_mutex(...);

But looking into cleanup.h it seems to me that the lock itself on GPIO library
can be defined with respective class, no?

...

> +	scoped_guard(mutex, &chip->lock)
> +		bitmap_replace(chip->value_map, chip->value_map, bits, mask,
> +			       gc->ngpio);

Perhaps with {} ?

...

>  	int ret;
>  
> -	mutex_lock(&dev->lock);
> +	guard(mutex)(&dev->lock);
> +
>  	pdev = dev->pdev;
>  	if (pdev)
>  		ret = sprintf(page, "%s\n", dev_name(&pdev->dev));
>  	else
>  		ret = sprintf(page, "gpio-sim.%d\n", dev->id);
> -	mutex_unlock(&dev->lock);
>  
>  	return ret;

Now can be

	if (...)
		return ...
	else // if you wish (not needed)
		return ...

...

>  	int ret;
>  
> -	mutex_lock(&dev->lock);
> +	guard(mutex)(&dev->lock);
> +
>  	if (gpio_sim_device_is_live_unlocked(dev))
>  		ret = device_for_each_child(&dev->pdev->dev, &ctx,
>  					    gpio_sim_emit_chip_name);
>  	else
>  		ret = sprintf(page, "none\n");
> -	mutex_unlock(&dev->lock);
>  
>  	return ret;

As per above. And may be other functions as well.

...

>  	int ret;
>  
> -	mutex_lock(&dev->lock);
> -	ret = sprintf(page, "%s\n", line->name ?: "");
> -	mutex_unlock(&dev->lock);
> +	scoped_guard(mutex, &dev->lock)
> +		ret = sprintf(page, "%s\n", line->name ?: "");
>  
>  	return ret;

Why not

	guard(...);
	return sprintf(...);

?

-- 
With Best Regards,
Andy Shevchenko


