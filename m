Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD04F793EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjIFOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIFOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:23:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F36CF4;
        Wed,  6 Sep 2023 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694010222; x=1725546222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NkDVpIGP6hSnJ3pk9APCaVMBJZKKIjfhnS1bhhI9K34=;
  b=mKyCBVWAGWaZlz75eeHuLfvlL+naMw4265lZo5ku0raG7nYXINerp35m
   SmLgWjXZD8VI4atMP1ElGAt7Csff1rg3aTOj6p2IgO4qLuQLl1LJcxRx3
   P9kyW7c8OUqDT94t9pRj0u54X/MrzoM/TSSaJnnlg/TC8JmOgmYfQvoq8
   X9PPHgrwXu9RflooEVqBVTn0sQqUak7CcXUBt1T0KNXVtn+hEryH+iZGG
   wumfIWADkf05r7zrCsWA5SxAx13NubFxu6ob9CAshV4SAxc5pJrtim8Gs
   LJ5Xb4cucE33U3W5FESeCATtvom40yk/3/7IJKZu9H6GaDGY6t0QR7Baf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="408082887"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="408082887"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="915296693"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="915296693"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:23:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdtRK-006xiY-08;
        Wed, 06 Sep 2023 17:23:30 +0300
Date:   Wed, 6 Sep 2023 17:23:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 10/21] gpiolib: replace find_chip_by_name() with
 gpio_device_find_by_label()
Message-ID: <ZPiLYYzzffKaTKlT@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-11-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:52:58PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Remove all remaining uses of find_chip_by_name() (and subsequently:
> gpiochip_find()) from gpiolib.c and use the new
> gpio_device_find_by_label() instead.

...

> -		desc = gpiochip_get_desc(gc, p->chip_hwnum);
> +		desc = gpiochip_get_desc(gdev->chip, p->chip_hwnum);

Why not gpio_device_get_desc()?


-- 
With Best Regards,
Andy Shevchenko


