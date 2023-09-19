Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774607A601C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjISKuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjISKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:50:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197AAE42;
        Tue, 19 Sep 2023 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695120573; x=1726656573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0klRbsvIFZBpR09ph8KYAGbk+boJM0fgzVGIgayXCZk=;
  b=QyP3/PEro9qghCyxel3147XZK80Y/MA9LeaTwxNvxEEVCD2wGXxgzGeO
   RpTwnG+rriyeHboQpQsr5d9g7Yq0AfMBM2ZApyWRn36c1gTDV8LCBdpJE
   zI7QMhQWuaT5wi36/185KQwbv07tZbjxx403LqWQjSQoork7AB8ICk+we
   CDFtljzqsw+I7Y2AjJ6efs/xupmEWNKzkU43cEg6xAoLfZAZHSxPfBmnS
   DRvUihBFE3+DSw22HfAwErk02Knnyvat06oDbWHm1F+kXUUcjUXvr+B/S
   t42EdJ8t6imLPODkQuoH7mX1w1geerw4N5eZp/FoOo27OYeviLJObMRV+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377218220"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="377218220"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076939400"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="1076939400"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:49:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiYII-0000000Ek42-3X8J;
        Tue, 19 Sep 2023 13:49:26 +0300
Date:   Tue, 19 Sep 2023 13:49:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     brgl@bgdev.pl
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4] gpio: sim: fix an invalid __free() usage
Message-ID: <ZQl8tkWnQcjtFBbQ@smile.fi.intel.com>
References: <20230918145533.14642-1-brgl@bgdev.pl>
 <ZQhtWNaCiHVu5yzL@smile.fi.intel.com>
 <CAMRc=MfkzdFgwEuNGJYgxyCA_b__Ds-jA4S+jVT1ULJ9DTRhOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfkzdFgwEuNGJYgxyCA_b__Ds-jA4S+jVT1ULJ9DTRhOw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:31:36AM -0700, brgl@bgdev.pl wrote:
> On Mon, 18 Sep 2023 17:31:36 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Mon, Sep 18, 2023 at 04:55:33PM +0200, Bartosz Golaszewski wrote:

...

> > Of course this can be replace with...
> >
> >> +		line_names = kcalloc(line_names_size, sizeof(*line_names),
> >> +				     GFP_KERNEL);
> >
> >> +		if (!line_names)
> >
> > ZERO_OR_NULL_PTR() check here, but I assume we discourage use of it.
> 
> Why? There are less than 40 instances of using it in the kernel. kmalloc()
> returns NULL on failure.

Nope, k*alloc*() returns ZERO or NULL on failure. That's what most developers
are missing :-)

> >> +			return ERR_PTR(-ENOMEM);

Hence either one needs to check for 0 the size given to the kmalloc(),
_or_ to check for all possible return values from it.

-- 
With Best Regards,
Andy Shevchenko


