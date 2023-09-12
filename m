Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA5379CFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjILLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjILLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:16:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69900B3;
        Tue, 12 Sep 2023 04:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694517393; x=1726053393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R2Ot7xPyVMFbYyedKENeMRGoNL1E1ZnSVA5Nz2FEqo4=;
  b=h3Lc7f1VhySMFrN3skxUdtUetUrGIu5+7ysX9BTNslWeGEd3BjAYNLlH
   XBCJZNQDAgUiAzKQs4U7VtMnF0tE87aceIphoBJAexZ7qCYAGTQKYwmTU
   NBqHX7DSnnHS97btJsy1OCfbo7Fiba3PZDBBuNs6bpUjsboLIFzvUQGYA
   nMKc1JzDj7k1aVFH2C9pGXlwGbOO7p5UzKPkw5OqS99y7bPNA8fzWDdqs
   TGB+PE9bHGV0uy22YTjEVdSeXnBTkDjJxcA4+mdgLk/HZ1od0NlFdC9r7
   tXOIl9uUa5AcyqxAfT/N51qVIdsMXnlv6gzAhTVF+LFCp/cAw+hZ8NLRa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381044654"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381044654"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720364871"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720364871"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:16:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg1Nb-008ZNh-1r;
        Tue, 12 Sep 2023 14:16:27 +0300
Date:   Tue, 12 Sep 2023 14:16:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 07/11] gpiolib: replace find_chip_by_name() with
 gpio_device_find_by_label()
Message-ID: <ZQBIi3OsUUe+JcoB@smile.fi.intel.com>
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

>  	for (p = &table->table[0]; p->key; p++) {
> -		struct gpio_chip *gc;
> +		struct gpio_device *gdev __free(gpio_device_put) = NULL;

> +		gc = gpio_device_get_chip(gdev);

What the heck is this, btw? You have gdev NULL here.

>  		/* idx must always match exactly */
>  		if (p->idx != idx)
> @@ -4004,9 +3996,8 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
>  			return ERR_PTR(-EPROBE_DEFER);
>  		}
>  
> -		gc = find_chip_by_name(p->key);
> -
> -		if (!gc) {
> +		gdev = gpio_device_find_by_label(p->key);
> +		if (!gdev) {

...

>  		if (gc->ngpio <= p->chip_hwnum) {
>  			dev_err(dev,
>  				"requested GPIO %u (%u) is out of range [0..%u] for chip %s\n",
> -				idx, p->chip_hwnum, gc->ngpio - 1,
> +				idx, p->chip_hwnum, gdev->chip->ngpio - 1,

In other patch you use wrapper to get gdev->chip, why not here?

>  				gc->label);

Is this gc is different to gdev->chip?

>  			return ERR_PTR(-EINVAL);
>  		}

...

Sorry, but this patch seems to me as WIP. Please, revisit it, make sure all
things are done consistently.

-- 
With Best Regards,
Andy Shevchenko


