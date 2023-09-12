Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11B79CF80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjILLJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjILLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:08:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64419BE;
        Tue, 12 Sep 2023 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694516891; x=1726052891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfmEYJdif4poI0+XqqQuKlUGSGajQG71iNFDtsotJaA=;
  b=hbzU1xt2R/cm0CjZAqqGbQhi3tVJG7EhcbOBn2FFB/Yqw/hzMQEEEFlb
   mIIzEHfjscSYdatgza0/UZinGOBJWVIG+EPAMZkGnPUZ7BgJsu6kr1s+u
   8hcNWhsOhmPne85cQhg33E0R4pIVT+UwOeUwRAuSCFsEkkd07hs+qlSep
   eA3c4jFJo10n35I46xP8UteQa+Ror5bnBHMoacoCli8jzLMJlRuESkBNQ
   7nFxtpDYan4NLZJl/hJk8y7XDsIUDFdOdlgb5Pkd2l29tP0BdATrdY1rI
   XzFHOjbtAL1Q6ryZvy6s8RSe60M9epZYxXJeFMhUXsiEmIj8Gnvq4XsCT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442358522"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="442358522"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813778526"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="813778526"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:08:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg1FV-008ZI7-2K;
        Tue, 12 Sep 2023 14:08:05 +0300
Date:   Tue, 12 Sep 2023 14:08:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 07/11] gpiolib: replace find_chip_by_name() with
 gpio_device_find_by_label()
Message-ID: <ZQBGlSnx3McF8m2r@smile.fi.intel.com>
References: <20230912100727.23197-1-brgl@bgdev.pl>
 <20230912100727.23197-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912100727.23197-8-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:07:23PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Remove all remaining uses of find_chip_by_name() (and subsequently:
> gpiochip_find()) from gpiolib.c and use the new
> gpio_device_find_by_label() instead.

...

>  	for (hog = &hogs[0]; hog->chip_label; hog++) {
> +		struct gpio_device *gdev __free(gpio_device_put) = NULL;

In the loop?! How does it work when loop goes second iteration and so on?

>  		list_add_tail(&hog->list, &gpio_machine_hogs);
>  
>  		/*
>  		 * The chip may have been registered earlier, so check if it
>  		 * exists and, if so, try to hog the line now.
>  		 */
> -		gc = find_chip_by_name(hog->chip_label);
> -		if (gc)
> -			gpiochip_machine_hog(gc, hog);
> +		gdev = gpio_device_find_by_label(hog->chip_label);
> +		if (gdev)
> +			gpiochip_machine_hog(gpio_device_get_chip(gdev), hog);

So, do we expect the chip_label be different between hogs? Ah, seems so
as it covers _all_ hogs in the system.

>  	}

Even if the __free() scope works fine, I think this algorithm should be
revisited to make sure we have iterating only on hogs of the same chip.
Hence, the hogs should be placed into tree structure with a label being
the key in it.

...

> +		struct gpio_device *gdev __free(gpio_device_put) = NULL;

> +		gc = gpio_device_get_chip(gdev);

Similar wish here, perhaps maple tree can be utilized in the future for both of them.

-- 
With Best Regards,
Andy Shevchenko


