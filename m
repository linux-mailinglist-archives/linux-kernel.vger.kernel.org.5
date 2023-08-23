Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0A78588C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjHWNLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjHWNLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:11:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D89E51;
        Wed, 23 Aug 2023 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692796307; x=1724332307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0oPlxHPZRbdXx8eP6dtgFIGoNChzCBCKIdc/q6TJcc=;
  b=ATMCoJZBCWv40x6MWCUcuBqLoYw9hztV14b1LjnEtx8dfYU1Aizo/WGj
   YRiS6BmIQl3NarhiqyuGA92pqLomgpYNK1CYyPxy78dHzN8Q6HJMCoTJ5
   BHLpKsSs/2j73yXsYEXzP7gDXd4NF80mz5qVv0gZiiG4eZAklFCtfsXOQ
   Q4P5D0ussshIWOBg3gyU4MIQPFXJI7SGQxaAKOf7cwq7FD/SJF2ZUpNPA
   r9+ZDGpnbnKtzDlpTOVnsbfcNygLOzSD0wckK155B/FosmmJTOu+Y7+cK
   M338hxnOQuan9+tlMGzS5InC2mv4tkCGVXaxMNojMYciJOPiX613CLdUB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="371569745"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="371569745"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="686452026"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686452026"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2023 06:11:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYneB-008bo4-0D;
        Wed, 23 Aug 2023 16:11:43 +0300
Date:   Wed, 23 Aug 2023 16:11:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/2] gpio: sim: dispose of irq mappings before
 destroying the irq_sim domain
Message-ID: <ZOYFjtt/+9hPw4u0@smile.fi.intel.com>
References: <20230822192943.493182-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822192943.493182-1-brgl@bgdev.pl>
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

On Tue, Aug 22, 2023 at 09:29:42PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> If a GPIO simulator device is unbound with interrupts still requested,
> we will hit a use-after-free issue in __irq_domain_deactivate_irq(). The
> owner of the irq domain must dispose of all mappings before destroying
> the domain object.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: cb8c474e79be ("gpio: sim: new testing module")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - drop the return value check of irq_find_mapping()
> 
>  drivers/gpio/gpio-sim.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index f1f6f1c32987..8fb11a5395eb 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -291,6 +291,15 @@ static void gpio_sim_mutex_destroy(void *data)
>  	mutex_destroy(lock);
>  }
>  
> +static void gpio_sim_dispose_mappings(void *data)
> +{
> +	struct gpio_sim_chip *chip = data;
> +	unsigned int i;
> +
> +	for (i = 0; i < chip->gc.ngpio; i++)
> +		irq_dispose_mapping(irq_find_mapping(chip->irq_sim, i));
> +}
> +
>  static void gpio_sim_sysfs_remove(void *data)
>  {
>  	struct gpio_sim_chip *chip = data;
> @@ -406,6 +415,10 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
>  	if (IS_ERR(chip->irq_sim))
>  		return PTR_ERR(chip->irq_sim);
>  
> +	ret = devm_add_action_or_reset(dev, gpio_sim_dispose_mappings, chip);
> +	if (ret)
> +		return ret;
> +
>  	mutex_init(&chip->lock);
>  	ret = devm_add_action_or_reset(dev, gpio_sim_mutex_destroy,
>  				       &chip->lock);
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


