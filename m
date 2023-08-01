Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE676BD6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjHATL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHATL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:11:58 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4844D1BF0;
        Tue,  1 Aug 2023 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690917117; x=1722453117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rrFkhhbjbOMeLFqhmMaRKqF2Hny9pm7kqMF7teDKeh4=;
  b=A1M1GY2xAypbxRkjJfX9puKTm9iYpGuOtrmg6LK448E6rnhVnQ9lpEhe
   AXDDJZcdrT/Qs7itcu2CbiOw92m00ngxCZ7fJVh+KH+3j/r0ofolh4eij
   LFOi1sepJ3Y3XFHreKXpGVMdcKRnUT+uusSwqdpNvwwLLWdR9OE6sqUlp
   eLhSpgQQ8qOzPcoIawRV/mUEFoqhkiu/S+DqD2MT8KDn15khLQ1DWWi/D
   vr1XOu1+0yb3iigZX4UZgHUO1W90EVgck0aKF841t9uT6tpsJrE5SfrT1
   /2gRoH8wIvScMeYvQjMDHIVwXvhcg9n+0yEhm5TNw9si0iH+xC2s3Jv88
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368292183"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="368292183"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 12:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872179339"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2023 12:11:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qQumf-00G2eS-2D;
        Tue, 01 Aug 2023 22:11:53 +0300
Date:   Tue, 1 Aug 2023 22:11:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: mark the GPIO chip as a one that can sleep
Message-ID: <ZMlY+QU+yXIl4yab@smile.fi.intel.com>
References: <20230801190951.51818-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801190951.51818-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:09:51PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Simulated chips use a mutex for synchronization in driver callbacks so
> they must not be called from interrupt context. Set the can_sleep field
> of the GPIO chip to true to force users to only use threaded irqs.

Ah, good catch! Doesn't it deserve a Fixes tag?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-sim.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index cfbdade841e8..5f8723ad0048 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -429,6 +429,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
>  	gc->set_config = gpio_sim_set_config;
>  	gc->to_irq = gpio_sim_to_irq;
>  	gc->free = gpio_sim_free;
> +	gc->can_sleep = true;
>  
>  	ret = devm_gpiochip_add_data(dev, gc, chip);
>  	if (ret)
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


