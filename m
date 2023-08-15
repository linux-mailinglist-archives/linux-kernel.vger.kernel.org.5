Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2828877CABE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjHOJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbjHOJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:50:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE5CE3;
        Tue, 15 Aug 2023 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692092999; x=1723628999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T7avx6akMBj8VUyBxXusJjovm//UmqITJGtB1agsYRQ=;
  b=Z/JekSAn1vGgGa/OpByVm7vXxrpXpSTRkasiqmJ6VoTh+uuKMCDQlv1x
   9+5JdyEE0W7sFrNyl4s9gpoF2WwygeDZFR0DG/PFzJAzPyP2oSDHBWvzO
   YgyA7563jqpfaVKJ1imajh988c9XsF2HxAA0rJV7muEC2HiGY2s7A6roU
   Dijhpg0dtx5BiMrSer7sTYxGzCb4Peynjpsy7/7dUisBxXz5NKaBK4NZ9
   PZSiRf8rLmDxbAFD/vZCOkdEGnCa5Q1+iAvUP6q3tyLQDNFh6im5b+ras
   Q1mPlM89SUQpo9CEd15Wa7X/HHf16UNr/wgA6Bw04N69AgmrokAtq6Wv8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="362392954"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362392954"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733788881"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733788881"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 02:49:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVqgU-00DF2A-2w;
        Tue, 15 Aug 2023 12:49:54 +0300
Date:   Tue, 15 Aug 2023 12:49:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpiolib: fix reference leaks when removing GPIO chips
 still in use
Message-ID: <ZNtKQlnQxFediB0J@smile.fi.intel.com>
References: <20230811193034.59124-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811193034.59124-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:30:34PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> After we remove a GPIO chip that still has some requested descriptors,
> gpiod_free_commit() will fail and we will never put the references to the
> GPIO device and the owning module in gpiod_free().
> 
> Rework this function to:
> - not warn on desc == NULL as this is a use-case on which most free
>   functions silently return
> - put the references to desc->gdev and desc->gdev->owner unconditionally
>   so that the release callback actually gets called when the remaining
>   references are dropped by external GPIO users

...

> -	if (desc && desc->gdev && gpiod_free_commit(desc)) {

The commit message doesn't explain disappearing of gdev check.

> -		module_put(desc->gdev->owner);
> -		gpio_device_put(desc->gdev);
> -	} else {
> +	/*
> +	 * We must not use VALIDATE_DESC_VOID() as the underlying gdev->chip
> +	 * may already be NULL but we still want to put the references.
> +	 */
> +	if (!desc)
> +		return;
> +
> +	if (!gpiod_free_commit(desc))
>  		WARN_ON(extra_checks);
> -	}
> +
> +	module_put(desc->gdev->owner);
> +	gpio_device_put(desc->gdev);
>  }

So, if gdev can be NULL, you will get an Oops with new code.

To keep a status quo this needs to be rewritten.

-- 
With Best Regards,
Andy Shevchenko


