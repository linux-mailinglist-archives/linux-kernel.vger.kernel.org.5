Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1D797688
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjIGQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbjIGQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:11:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9774B46B9;
        Thu,  7 Sep 2023 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102918; x=1725638918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gRENciT8jBMpxnPJqxQEyKj0ZSurw8NkK4neNf8ZT2I=;
  b=X55WUztJ/vKr8HaFbN/W4CrrLjjPi+gmnacWYRzvCspWyACKN2P6MWUG
   0BFY54xn97aa+RgD+2LeUeVQ+stRTGclDxzuo430NtdMj6Dieq3X3tnqa
   ho6V7EapV7TB2g1AjLf2e1Q1+RMjElI+R65pBWmvD9XBjRzIziTICQefJ
   gKSwtViasBPzm3XZ72moYO0kxSeCG2p5reB2DwG+tBLnhnzFLe4nr0i8l
   p9JURhfkfSLfmaaJYYujBUA+1hbhDVM0H+FyohLcRT6b0jOBi+85xJAfb
   gBA9gKmFUJ0QEtTY73NMoyx6PSHFBDG98x0JnSAdJA0I1N/eNwR3Uxr/8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="380099915"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="380099915"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="865666292"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="865666292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:13:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qeFlY-007KM0-2S;
        Thu, 07 Sep 2023 17:13:52 +0300
Date:   Thu, 7 Sep 2023 17:13:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPnaoOUiYDR3yqGu@smile.fi.intel.com>
References: <20230907082751.22996-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907082751.22996-1-brgl@bgdev.pl>
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

On Thu, Sep 07, 2023 at 10:27:51AM +0200, Bartosz Golaszewski wrote:
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
> For kobjects needed by sysfs callbacks: we can iterate over the children
> devices of the top-level platform device and compare their fwnodes
> against the one passed to the init function from probe.
> 
> While at it: fix one line break and remove the untrue part about
> configfs callbacks using dev_get_drvdata() from a comment.

Will LGTM with the couple of remarks being addressed.

...

>  #include <linux/completion.h>
>  #include <linux/configfs.h>
>  #include <linux/device.h>

> +#include <linux/device/bus.h>

No need, the device.h guarantees that.

...

> +static int gpio_sim_dev_match_fwnode(struct device *dev, void *data)
> +{
> +	/*
> +	 * We can't pass this directly to device_find_child() due to pointer
> +	 * type mismatch.
> +	 */

Not sure if this comment adds any value.

> +	return device_match_fwnode(dev, data);
> +}

-- 
With Best Regards,
Andy Shevchenko


