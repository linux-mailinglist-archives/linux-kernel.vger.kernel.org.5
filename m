Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629737840AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjHVMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjHVMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:24:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E151B2;
        Tue, 22 Aug 2023 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692707068; x=1724243068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4ryzTupPnh+ZQLrgFqYzTeGOebt/s18d4PhChUNyUEs=;
  b=D9SFhy1a03Hl/COejV3eIRVjRrWL44gwfAuXygQXyTi5qeCGcsPpThbq
   l5PQXQxv+z8mSKjGoJtZe00rHPnVpy0bpDRXB6seDPy1G2kr3e7Fy1uUW
   SSQnBF+s7QkDVmNpVlj1rVkvwirOMdo4jpLVxU2EYPvGDy0AxNaRtyjhZ
   pr6NCO30rLt/213hHW5K1D4Qn2YJK3HG5ZxgM1IALCmXom7gJdpRR8CAf
   674nUirP7epTfVnMptN4TYtm5ZOqO0JikYTzbS9NabJrypnfrYlbHUeTc
   1+PE7j+RPKCDMFCb/xsvuaJW1Aca6nuWA+8v8c9ZTDsPMojurJKAViy/4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404866058"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="404866058"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739288155"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="739288155"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2023 05:24:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYQQq-00A0n7-1A;
        Tue, 22 Aug 2023 15:24:24 +0300
Date:   Tue, 22 Aug 2023 15:24:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpio: sim: dispose of irq mappings before destroying
 the irq_sim domain
Message-ID: <ZOSo+CVYuOxYCNPZ@smile.fi.intel.com>
References: <20230822075122.6900-1-brgl@bgdev.pl>
 <ZOSmFGZHrLq3I+zF@smile.fi.intel.com>
 <CAMRc=MenZDhrVb9BgJ3R+NqyvoHJR2stjeXouSRWTkecgo160g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MenZDhrVb9BgJ3R+NqyvoHJR2stjeXouSRWTkecgo160g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:16:44PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 22, 2023 at 2:12 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 22, 2023 at 09:51:21AM +0200, Bartosz Golaszewski wrote:

...

> > > +static void gpio_sim_dispose_mappings(void *data)
> > > +{
> > > +     struct gpio_sim_chip *chip = data;
> > > +     unsigned int i, irq;
> > > +
> > > +     for (i = 0; i < chip->gc.ngpio; i++) {
> > > +             irq = irq_find_mapping(chip->irq_sim, i);
> >
> > > +             if (irq)
> >
> > This duplicates check in the following call.
> >
> 
> Ah so it can be a direct call:
> 
>     irq_dispose_mapping(irq_find_mapping(chip->irq_sim, i));
> 
> ?

Hehe, seems yes and no. According to the code — yes, but code seems buggy,
and compiler may effectively drop the check (haven't checked this, though).

OTOH, the problem may appear if and only if we have no sparse IRQ configuration
which is probably rare.

That said, I will go without check, it's not your issue.
And I found other places in IRQ framework that misses that check.

> > > +                     irq_dispose_mapping(irq);
> > > +     }
> > > +}

-- 
With Best Regards,
Andy Shevchenko


