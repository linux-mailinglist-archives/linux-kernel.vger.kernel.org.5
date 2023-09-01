Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F0790386
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349105AbjIAWD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350798AbjIAVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 17:52:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695F41988;
        Fri,  1 Sep 2023 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693602654; x=1725138654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nyCvpEli0+8FWE4zEnhnuy+DIxr5WwG7YAQEEFHoj0A=;
  b=FlvJcQXwSj8QLYLyruD4iV8I60dw3x02XHJUcW4gJzg/UDtDhnnqUOdj
   Zs5KBPYteJNQj3fXI1+K0voJIP8fG8jSsBpo01MuCD3d9OQHWMNyUL/nT
   UdmRUBrmLpDyfnD5nrNxiWA+RYu6wTuCNJ3IBiMqRI4mTISbJ9nFcbwyJ
   ehD/63e6wQhOW3BMtwvMn9pKENWQodtRSeJ0xcBKthx+m35nMR8DlZTYO
   BwhqglpFV7056Q82ueIPkzdTKIu0DmwxY2ZgAbt61bx2gxy8pt8VjLeOw
   ZxigA937ZnBZcc0WUU4lzRC4Y1KrnztweuZQgFQQ4b8FIK7/bFwJpNWvI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="380099637"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="380099637"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 14:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805580889"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="805580889"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 14:10:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qcBPc-005lmA-0Z;
        Sat, 02 Sep 2023 00:10:40 +0300
Date:   Sat, 2 Sep 2023 00:10:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPJTT/l9fX1lhu6O@smile.fi.intel.com>
References: <20230901183240.102701-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901183240.102701-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We access internals of struct gpio_device and struct gpio_desc because
> it's easier but it can actually be avoided and we're working towards a
> better encapsulation of GPIO data structures across the kernel so let's
> start at home.
> 
> Instead of checking gpio_desc flags, let's just track the requests of
> GPIOs in the driver. We also already store the information about
> direction of simulated lines.
> 
> For kobjects needed by sysfs callbacks: we can leverage the fact that
> once created for a software node, struct device is accessible from that
> fwnode_handle. We don't need to dereference gpio_device.
> 
> While at it: fix one line break and remove the untrue part about
> configfs callbacks using dev_get_drvdata() from a comment.

...

> -static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)

Why is this?

> +static int gpio_sim_request(struct gpio_chip *gc, unsigned int offset)
>  {
>  	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
>  
>  	scoped_guard(mutex, &chip->lock)
> +		__set_bit(offset, chip->request_map);
> +
> +	return 0;
> +}
> +
> +static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
> +
> +	scoped_guard(mutex, &chip->lock) {
>  		__assign_bit(offset, chip->value_map,
>  			     !!test_bit(offset, chip->pull_map));
> +		__clear_bit(offset, chip->request_map);
> +	}
>  }

Seems to me like you. shuffled the order of the two functions.
Can you leave _free() at the same location in the file?

...

> -	/* Used by sysfs and configfs callbacks. */
> -	dev_set_drvdata(&gc->gpiodev->dev, chip);
> +	/* Used by sysfs callbacks. */
> +	dev_set_drvdata(swnode->dev, chip);

dev pointer of firmware node is solely for dev links. Is it the case here?
Seems to me you luckily abuse it.

-- 
With Best Regards,
Andy Shevchenko


