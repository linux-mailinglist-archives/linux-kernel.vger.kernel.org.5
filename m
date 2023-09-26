Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50407AEB15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjIZLLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIZLL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:11:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD9E5;
        Tue, 26 Sep 2023 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695726682; x=1727262682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bcmQvoUINisqkhRF3+IALIewrp6wbQqm3oJ9C0S/4TA=;
  b=RXnBsy8mpST3Z2ZMBNgSyldOTxXPkdQwYo2ZkhsYHksfvBDVXkswpOcp
   fE9042hAaYNEViOFgvh3U97Xgwuk/5NVhKmpi4/7z06JZo71HRYwR0cqp
   kcWc5vM8ZMjVusgz778KS7qHK3mxpVqhMoNZk1YSctj+ijgAFD/JzpKUQ
   2K8e9m3ljY9fyGFxFoRAdd1k11Okav+WaYQFeO/bT5CX3z4xam1tBmOA5
   wcIPGu1Zik0tL6Q0bYmR7Rfye0NEGJuwAOxPVUL0XeuJucC1g9ZJZlKt+
   UDV84KWHzPI6+XJBWOEyEn3b1dSY5xZu6jJkrnnS9tzdfqRVgBz35VDNl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="448039810"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="448039810"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698432385"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698432385"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:11:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ql5yF-00000000aM0-0723;
        Tue, 26 Sep 2023 14:11:15 +0300
Date:   Tue, 26 Sep 2023 14:11:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 4/5] gpio: xilinx: Replace bitmap_bitremap() calls
Message-ID: <ZRK8Uq699oeSOOg6@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-5-andriy.shevchenko@linux.intel.com>
 <ZRK1PA2vZBdfAozG@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRK1PA2vZBdfAozG@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 06:41:00PM +0800, Kent Gibson wrote:
> On Tue, Sep 26, 2023 at 08:20:06AM +0300, Andy Shevchenko wrote:
> > We have sparse and dence masks of the line mappings based on
> 
> dense
> 
> > the view point (Linux numbering or hardware numbering). Since
> > the Linux side uses sequential bits for the mask, we can simply
> > convert a Linux number to the hardware one and vise versa by
> 
> vice
> 
> > counting set bits in the respective mask. Hence replace
> > bitmap_bitremap() calls by simpler equivalents.
> > 
> > With this done the dence mask is not needed and thus dropped.
> 
> And dense again.

Thank you, Kent, I really appreciate your help with my poor English,
nevertheless it would be nice if you can look at the last patch and
maybe even test it, so we have a bit of confidence that it works
as expected.

(The spelling will be fixed in the next version.)

-- 
With Best Regards,
Andy Shevchenko


