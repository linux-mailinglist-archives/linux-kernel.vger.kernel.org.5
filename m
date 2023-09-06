Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C7793F8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbjIFOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIFOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:52:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310C10D0;
        Wed,  6 Sep 2023 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694011955; x=1725547955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=inkf0Vv2sw3e1+dq2vxBlduL5A9wIEDv+hfvFclNOlw=;
  b=abt4nUVCMuaT/gHOabGR7uBLGZ0hx6cfdAAh8D8N2d11XqJgCK0m2SXQ
   YNdl7oTLirpqw1iHpfyiV9LR+HWd5GDyah8y3wvJiwCBic5dRf1onkT+J
   J8JoUJxv9seRFtrqgMIXgCjQKwIRHlFN5FGpuNvQ9VuGWj6VriiQRjVQi
   T5lFY9ZzAdrQuStBCpO0xcnzoHFwcEFvBkQzCZ+KG/xxxrcUooJuPYZys
   OVEcfCZexJbrrQctgKVk9L9ztggdjylZWZ54CqIUOrdSBDAbfak/CnVr8
   Bvr3LLlfDci/Y+nS8yYbek3nyVF/YoI3NWI36/91QZWarktCYxVNFfF/j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362116757"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="362116757"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="735086303"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="735086303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:52:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdttJ-006y5B-3D;
        Wed, 06 Sep 2023 17:52:26 +0300
Date:   Wed, 6 Sep 2023 17:52:25 +0300
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
Subject: Re: [PATCH 19/21] gpio: swnode: replace gpiochip_find() with
 gpio_device_find_by_label()
Message-ID: <ZPiSKTfIU3BSrqTj@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-20-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-20-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:53:07PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the swnode GPIO code.

...

> -static int swnode_gpiochip_match_name(struct gpio_chip *chip, void *data)
> +static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
>  {
> -	return !strcmp(chip->label, data);
> -}
> +	const struct software_node *gdev_node;
> +	struct gpio_device *gdev;
>  
> -static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
> -{

Not sure if you used --patience. Patches might look better.

> -	const struct software_node *chip_node;
> -	struct gpio_chip *chip;
> -
> -	chip_node = to_software_node(fwnode);
> -	if (!chip_node || !chip_node->name)
> +	gdev_node = to_software_node(fwnode);
> +	if (!gdev_node || !gdev_node->name)
>  		return ERR_PTR(-EINVAL);
>  
> -	chip = gpiochip_find((void *)chip_node->name, swnode_gpiochip_match_name);
> -	return chip ?: ERR_PTR(-EPROBE_DEFER);
> +	gdev = gpio_device_find_by_label((void *)gdev_node->name);
> +	return gdev ?: ERR_PTR(-EPROBE_DEFER);
>  }

...

> -	desc = gpiochip_get_desc(chip, args.args[0]);
> +	desc = gpiochip_get_desc(gdev->chip, args.args[0]);

gpio_device_get_desc() ?

-- 
With Best Regards,
Andy Shevchenko


