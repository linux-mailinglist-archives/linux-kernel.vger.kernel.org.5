Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D37F44DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjKVLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVLXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:23:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF312A;
        Wed, 22 Nov 2023 03:23:10 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5226945"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="5226945"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 03:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="857687253"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="857687253"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 03:23:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1r5lJv-0000000G4f6-40Kl;
        Wed, 22 Nov 2023 13:23:03 +0200
Date:   Wed, 22 Nov 2023 13:23:03 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 01/39] gpio: ep93xx: split device in multiple
Message-ID: <ZV3kl6spXpF5c6Bg@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-1-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-1-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59:39AM +0300, Nikita Shubin wrote:
> Prepare ep93xx SOC gpio to convert into device tree driver:
> - dropped banks and legacy defines
> - split AB IRQ and make it shared
> 
> We are relying on IRQ number information A, B ports have single shared
> IRQ, while F port have dedicated IRQ for each line.
> 
> Also we had to split single ep93xx platform_device into multiple, one
> for each port, without this we can't do a full working transition from
> legacy platform code into device tree capable. All GPIO_LOOKUP were
> change to match new chip namings.

...

> @@ -335,9 +430,9 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
>  	.dev_id		= "i2c-gpio.0",
>  	.table		= {
>  		/* Use local offsets on gpiochip/port "G" */
> -		GPIO_LOOKUP_IDX("G", 1, NULL, 0,
> +		GPIO_LOOKUP_IDX("gpio-ep93xx.6", 1, NULL, 0,
>  				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
> -		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
> +		GPIO_LOOKUP_IDX("gpio-ep93xx.6", 0, NULL, 1,
>  				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
>  	},

Before doing this patch, please fix the bug, i.e. missing terminator entry here.
If elsewhere the same, fix all of them at once.

>  };

...

> +	gc->label = dev_name(&pdev->dev);
> +	if (platform_irq_count(pdev) > 0) {
> +		dev_dbg(&pdev->dev, "setting up irqs for %s\n", dev_name(&pdev->dev));
> +		ret = ep93xx_setup_irqs(pdev, egc);
> +		if (ret)
> +			dev_err_probe(&pdev->dev, ret, "setup irqs failed");

Non-fatal?

>  	}

...

This change LGTM (assuming the bug is fixed),
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


