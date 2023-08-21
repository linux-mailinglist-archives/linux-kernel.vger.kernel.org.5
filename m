Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23246782748
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjHUKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjHUKn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:43:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2E0D9;
        Mon, 21 Aug 2023 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692614635; x=1724150635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uWDQ0hDmmTvUeeUWNtSBTpJLcnSI8IVr0bANJMxmQ2w=;
  b=NJTGPu/0ry7FF9WX1lvIPrdPvd9QV4GITlBX1l7gqsLbZ/Ijc1YdqpGT
   hKag8iCbxv/6tZiuSKM0tOM2DcLRoAmrNV/6i/4/zH3kNlS7cfgO5SL1q
   bdCzNKXyhA+YMKo0Sld5tdQQ6XlkflD9jX2ptjBQI2+ksFJZic2P++jOE
   hZHHTYUPe6A+/eeSky+JCzzXNChBHMNeXEr0xm3QQqvR7vxN9LTU1y2He
   DP3KAmHeAP1g9Ao3/z+j1aA9kfMytlZXY1Nnak3xtn5Yt+9U/H7S7Jzq1
   heODYsuQD2ixkbygxFLKDHMal4hQImjd/DEjF+8bGlHmiwzuEY1p8/HtD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="373527471"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="373527471"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="805884069"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="805884069"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2023 03:43:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY2Nz-00AG8E-2S;
        Mon, 21 Aug 2023 13:43:51 +0300
Date:   Mon, 21 Aug 2023 13:43:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: notify user-space about line state changes
 triggered by kernel
Message-ID: <ZOM/59nLZwNWrha2@smile.fi.intel.com>
References: <20230818190944.22177-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818190944.22177-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:09:44PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Interestingly why you keep submitter and author different...

> We currently only emit CHANGED_CONFIG events when the user-space changes
> GPIO config. We won't be notified if changes come from in-kernel. Let's
> call the notifier chain whenever kernel users change direction or any of
> the active-low, debounce or consumer name settings. We don't notify the
> user-space about the persistence as the uAPI has no notion of it.

...

> -	if (!ret)
> +	if (!ret) {
>  		set_bit(FLAG_IS_OUT, &desc->flags);
> +		blocking_notifier_call_chain(&desc->gdev->notifier,
> +					     GPIO_V2_LINE_CHANGED_CONFIG,
> +					     desc);
> +	}
>  	trace_gpio_value(desc_to_gpio(desc), 0, val);
>  	trace_gpio_direction(desc_to_gpio(desc), 0, ret);
>  	return ret;

The if (!ret) makes me a bit slower to understand as usual pattern to test
for the errors first.

That said, perhaps

	if (ret)
		goto out_trace_event;

	set_bit(FLAG_IS_OUT, &desc->flags);
	blocking_notifier_call_chain(&desc->gdev->notifier,
				     GPIO_V2_LINE_CHANGED_CONFIG, desc);

out_trace_event:
	trace_gpio_value(desc_to_gpio(desc), 0, val);
	trace_gpio_direction(desc_to_gpio(desc), 0, ret);
	return ret;

...

> +	ret = gpiod_set_config(desc, config);
> +	if (!ret)
> +		blocking_notifier_call_chain(&desc->gdev->notifier,
> +					     GPIO_V2_LINE_CHANGED_CONFIG,
> +					     desc);
> +	return ret;

Ditto.

	ret = gpiod_set_config(desc, config);
	if (ret)
		return ret;

	blocking_notifier_call_chain(&desc->gdev->notifier,
				     GPIO_V2_LINE_CHANGED_CONFIG, desc);
	return 0;

-- 
With Best Regards,
Andy Shevchenko


