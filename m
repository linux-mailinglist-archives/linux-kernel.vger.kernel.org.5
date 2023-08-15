Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8077CB29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjHOKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbjHOKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:31:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF41985;
        Tue, 15 Aug 2023 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692095459; x=1723631459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJUIvic7IuQ8vCjZjHOyXIIeJgNvKrCCngFXveoiJ6c=;
  b=DVlyUyQcioq8vZYbN3PE+DZ1jAHVdYqvxP0ZIQBGd8NMthHiFztiOUtI
   L5dHHcL8A8tg8V671UEVGvgawkm+etwlztn0ZmfnRyzsKSjdr3sywm/9x
   FTrRCgkOHMP+DpA/VgAAX7qCuyvIztJJX5gbJIZDqw3bmDFA0cds1zCgF
   yV3fdt7DtN7kIkaa9AEIx/WQYxb5+v/NbIPvqBrzRpgPQ9t26OIFrNsG5
   OsUzDtxiPDOe7zvHB3bT/3mujNYbq1kRTz59hUXrXRwyw/5a4hYg5gXUQ
   Z0C4AEGkyt9dlYWWe2xAPSmCnGIKDTOL4MJvpwpMsei+PMLomaCXSanWn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372245439"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372245439"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 03:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803784014"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="803784014"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 03:30:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVrKB-00EeMM-37;
        Tue, 15 Aug 2023 13:30:55 +0300
Date:   Tue, 15 Aug 2023 13:30:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZNtT37d3eR6FcQyR@smile.fi.intel.com>
References: <20230812183635.5478-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812183635.5478-1-brgl@bgdev.pl>
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

On Sat, Aug 12, 2023 at 08:36:35PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in gpio-sim.

...

>  static void gpio_sim_set(struct gpio_chip *gc, unsigned int offset, int value)
>  {
>  	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
>  
> -	mutex_lock(&chip->lock);
> -	__assign_bit(offset, chip->value_map, value);
> -	mutex_unlock(&chip->lock);
> +	scoped_guard(mutex, &chip->lock)
> +		__assign_bit(offset, chip->value_map, value);

But this can also be guarded.

	guard(mutex)(&chip->lock);

	__assign_bit(offset, chip->value_map, value);

>  }

...

>  {
>  	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
>  
> -	mutex_lock(&chip->lock);
> -	bitmap_replace(chip->value_map, chip->value_map, bits, mask, gc->ngpio);
> -	mutex_unlock(&chip->lock);
> +	scoped_guard(mutex, &chip->lock)
> +		bitmap_replace(chip->value_map, chip->value_map, bits, mask,
> +			       gc->ngpio);

Ditto.

	guard(mutex)(&chip->lock);

	bitmap_replace(chip->value_map, chip->value_map, bits, mask, gc->ngpio);

(exactly 80 for the sectants of 80 characters :).

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

Ditto.

	guard(mutex)(&chip->lock);

	__assign_bit(offset, chip->value_map, test_bit(offset, chip->pull_map));

(in this form fanatics of 80 can sleep well :-)

Note that !! is redundant as test_bit() family of functions were fixed to
return boolean.

>  }

-- 
With Best Regards,
Andy Shevchenko


