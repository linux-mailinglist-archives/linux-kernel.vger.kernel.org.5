Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4029678F61D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347793AbjHaXZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHaXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:25:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499BE54;
        Thu, 31 Aug 2023 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693524306; x=1725060306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+i7hqSDClaxEdZAuo9sNl0FYXSUAPr3Xs/8KN7dhc8=;
  b=dEa0b7pDbh3Fz0EOH06sRYZ09mtsk1HQg5qPxKKoxGZDFI3MRPMiSGGC
   w4N830+7Mhz6VV1lbH4KzI5+invLwNhtAGkJqBm5O81+e/TROr2UuVmqs
   A9ymGns0Kc596PvHVMveZGLy/ZSp9Ut87O3RIRGlOwLZfLxKEfxCdbsbV
   HGcmyw1XEb9FuAUNEN0FBjW0K2RCHwjcbZcd4DFdEJmobMzNpqq4yHJYc
   jn+7oEuFfHjiSHIrzdoSW5bFXK1gBjn327E7UDIy6CRzj55LEAAwzK1e4
   qVpKJWEzJhR0WX8OBiofX71McgkMYthxGxM2I/wVfNYXadHN/rXlGllPj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366317575"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="366317575"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829904226"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="829904226"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:25:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbr23-005WmK-1D;
        Fri, 01 Sep 2023 02:24:59 +0300
Date:   Fri, 1 Sep 2023 02:24:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
Message-ID: <ZPEhS0uBWABpaE+/@smile.fi.intel.com>
References: <20230831194934.19628-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831194934.19628-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:49:34PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Currently the bcm2835 SPI driver uses functions meant for GPIO providers
> exclusively to locate the GPIO chip it gets its CS pins from and request
> the relevant pin. I don't know the background and what bug forced this.

...

>  	/*
> +	 * TODO: The code below is a slightly better alternative to the utter
> +	 * abuse of the GPIO API that I found here before. It creates a
> +	 * temporary lookup table, assigns it to the SPI device, gets the GPIO
> +	 * descriptor and then releases the lookup table.
>  	 *
> +	 * Still the real problem is unsolved. Looks like the cs_gpiods table
> +	 * is not assigned correctly from DT?
>  	 */

I'm not sure why this quirk is here. AFAIR the SPI CS quirks are located in
gpiolib-of.c.

-- 
With Best Regards,
Andy Shevchenko


