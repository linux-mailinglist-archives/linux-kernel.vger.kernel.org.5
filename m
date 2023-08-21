Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58634782671
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjHUJn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHUJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:43:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C89A1;
        Mon, 21 Aug 2023 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692611005; x=1724147005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h21lF5LTe7/PzxfMJq5TNFM6Jcep3pRFpY375l+KoMo=;
  b=HxcVbcnaKuo/OZjRmUdYzMzdTXLK8fCqw2oa3R7uD7nPlL5RbyZcrUKh
   vsux1pi/FecHHhrWH1G+hqZ9UjlGELf91NplvcegyhTuN1A8SZSK2M0oM
   jwTGDxWnoDbmYP57JN3E9yrxkB1BwpiKAzLHitC50Tz9bjYRY275w0U5m
   G5ixgHldDTBGGjlUhYv4MrFwl2TDAIDCaKsdn3BkFuqjeykHgVT5wCBVe
   YaMiwCjfcc4HhQJ4MMoy+KPR5TmGPRvf7M9YD2vrthRgetdAHncEtWWBc
   zn3HTe0HufZJhU+HH0LbJD20L3WHfqM8bQhfgOOeAHqHOC2KYHfQEqtJj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="370980094"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="370980094"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879457956"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2023 02:43:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY1RR-008BxD-3C;
        Mon, 21 Aug 2023 12:43:21 +0300
Date:   Mon, 21 Aug 2023 12:43:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: tie module references to GPIO devices, not
 requested descs
Message-ID: <ZOMxue7lvHFWMCCb@smile.fi.intel.com>
References: <20230818190108.22031-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818190108.22031-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:01:08PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> After a deeper look at commit 3386fb86ecde ("gpiolib: fix reference
> leaks when removing GPIO chips still in use") I'm now convinced that
> gpiolib gets module reference counting wrong.
> 
> As we only take the reference to the owner module when a descriptor is
> requested and put it when it's freed, we can easily trigger a crash by
> removing a module which registered a driver bound to a GPIO chip which
> is unused as nothing prevents us from doing so.
> 
> For correct behavior, we should take the reference to the module when
> we're creating a GPIO device and only put it when that device is
> released as it's at this point that we can safely remove the module's
> code from memory.

Two cases to consider:
1) legacy gpio_*() APIs, do they suppose to create a GPIO device?
2) IRQ request without GPIO being requested, is it the case?

Seems to me that the 1) is the case, while 2) is not.

-- 
With Best Regards,
Andy Shevchenko


