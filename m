Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F04777BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbjHJPRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjHJPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:17:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A5990;
        Thu, 10 Aug 2023 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691680653; x=1723216653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8CVVsjoamN4H2mUkLpTIG9S3YNeAEWn9KFgADz2XT4Q=;
  b=NxkMx2f4enboHju1jKTyp1gpPnVHUqF82dIjp47DDiHjnPpHkRrF4rYD
   l2ZQkG/ifqlc+xSDBQzP0LPYy5zLfUo9yX1MDGw4BCP/NgyyvK9AcQGkN
   y+n09ROYRYNZ7bNmSLr1fyjwFDKumEDgFeAE7kO22S91T/gj9s9bs6Edn
   DxgGaXH6s6HjvEgJJaocdFqIeLqnb+sR0+/6ccFjtIeHBvMk6Leb1rJek
   48abCXZgPC4abC75PPYMqggJspEikh1OUui0dx0ztEguZdm+9pmS8ipa6
   SJ3Lk7ZrnCGOkXys4hWCq53ZqcCue+MaRUd7/mL15mONuLPo4r8CtDvi2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351749312"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="351749312"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="735456107"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="735456107"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 10 Aug 2023 08:17:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU7Pi-006Uv3-1O;
        Thu, 10 Aug 2023 18:17:26 +0300
Date:   Thu, 10 Aug 2023 18:17:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: fix reference leaks when removing GPIO chips
 still in use
Message-ID: <ZNT/hvkZswZsZUFU@smile.fi.intel.com>
References: <20230810100335.9330-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810100335.9330-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:03:34PM +0200, Bartosz Golaszewski wrote:
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

>  void gpiod_free(struct gpio_desc *desc)
>  {
> -	if (desc && desc->gdev && gpiod_free_commit(desc)) {
> -		module_put(desc->gdev->owner);
> -		gpio_device_put(desc->gdev);
> -	} else {
> +	if (!desc)
> +		return;

	VALIDATE_DESC_VOID() ?

> +	if (!gpiod_free_commit(desc))
>  		WARN_ON(extra_checks);
> -	}
> +
> +	gpio_device_put(desc->gdev);
> +	module_put(desc->gdev->owner);
>  }

-- 
With Best Regards,
Andy Shevchenko


