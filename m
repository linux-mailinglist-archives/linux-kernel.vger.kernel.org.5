Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE897B05E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjI0N7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjI0N7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:59:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72758FC;
        Wed, 27 Sep 2023 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695823182; x=1727359182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NC6JKmlxB0G+yQV5Q1g46Gz7YqnMXE9hYwJXZnngYVY=;
  b=GfiCUfc/T8+QskXKmEkLPLOIk9pX1iI568rKzuCzaG5vPh/RIzTHAlH0
   TKp99oT1GOcwcQcAKR1nlIlP75yi3P/hxtwrx4PfmBqj42x+ZxpF0BXj4
   NSm9pg64XbT2cbPvyTMa78Y5YApMy4rlCmAZORnio3GeCvbdCnW7FsYJD
   EqsNDLK/9LtjmxvLtfTclWsHBBcI9KqYDj1puJGYNT1sGraYPMyURLXHd
   JghaGaPT6SK35XGKD7mpSxEse2xEMfYB5zpi7jvehNDa8uz1GIn78ocdV
   ZSQo2fi5Ck3cUsXcs5Su0kkZlS+CMAidBxJh4PNJNyNjyye8IcsVmehQC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="468113006"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="468113006"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="698891923"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698891923"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:59:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlV4h-00000000u3a-1XH9;
        Wed, 27 Sep 2023 16:59:35 +0300
Date:   Wed, 27 Sep 2023 16:59:34 +0300
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
Subject: Re: [PATCH v1 5/5] gpiolib: cdev: Utilize more bitmap APIs
Message-ID: <ZRQ1RpHEapodQ0xU@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZROGG44v5kfktdVs@sol>
 <ZRQdQnL5VbX659cl@smile.fi.intel.com>
 <ZRQy795YoPOKsOcz@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQy795YoPOKsOcz@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:49:35PM +0800, Kent Gibson wrote:
> On Wed, Sep 27, 2023 at 03:17:06PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 27, 2023 at 09:32:11AM +0800, Kent Gibson wrote:
> > > On Tue, Sep 26, 2023 at 08:20:07AM +0300, Andy Shevchenko wrote:
> > > > Currently we have a few bitmap calls that are open coded in the library
> > > > module. Let's convert them to use generic bitmap APIs instead.
> > > 
> > > Firstly, I didn't consider using the bitmap module here as, in my mind at
> > > least, that is intended for bitmaps wider than 64 bits, or with variable
> > > width. In this case the bitmap is fixed at 64 bits, so bitops seemed more
> > > appropriate.
> > > 
> > > And I would argue that they aren't "open coded" - they are parallelized
> > > to reduce the number of passes over the bitmap.
> > > This change serialises them, e.g. the get used to require 2 passes over
> > > the bitmap, it now requires 3 or 4.  The set used to require 1 and now
> > > requires 2.
> > > And there are additional copies that the original doesn't require.
> > > So your change looks less efficient to me - unless there is direct
> > > hardware support for bitmap ops??
> > > 
> > > Wrt the argument that the serialized form is clearer and more
> > > maintainable, optimised code is frequently more cryptic - as noted in
> > > bitmap.c itself, and this code has remained unchanged since it was merged
> > > 3 years ago, so the only maintenance it has required is to be more
> > > maintainable??  Ok then.
> > > 
> > > Your patch is functionally equivalent and pass my uAPI tests, so 
> > > 
> > > Tested-by: Kent Gibson <warthog618@gmail.com>
> > 
> > Thanks for testing!
> 
> Not a problem - that is what test suites are for.
> 
> > > but my preference is to leave it as is.
> > 
> > As Yury mentioned we need to look at bitmap APIs and make them possible to have
> > a compile-time optimizations. With that in mind, I would prefer bitmap APIs
> > over open-coded stuff which is hardly to be understood (yes, I still point
> > out that it takes a few hours to me, maybe because I'm stupid enough, to
> > get what's the heck is going one there, esp. for the == 1 case).
> 
> Really?  With all the bits out in the open it seems pretty clear to me.
> Clearer than scatter/gather in fact.

Yes, you are biased. :-) Ask some stranger about this code and I am pretty sure
there will be double-figures percentage of people who can tell that the current
code is a bit voodoo.

> Sure, if there is suitable hardware support then bitmaps COULD be faster
> than bitops.  But without that, and that is the general case, it will be
> slower.  Do you have ANY cases where your implementation is currently
> faster?  Then you would have a stronger case.

Why do we care here about performance? But if we do, I would check this on
the 32-bit platform where 64-bit operations somewhat problematic / slow.

If Yury gives an idea about performance tests I can consider to add this
piece to compare with and we might see the difference.

> And if you find the existing implementation unclear then the appropriate
> solution is to better document it, as bitmaps itself does, not replace it
> with something simpler and slower.

Documentation will be needed either way. In general statistics it will be 50/50
who (mis)understands this or new code. Pity that the original author of the code
hadn't though about documenting this...

> > Yet, it opens a way to scale this in case we might have v3 ABI that let's say
> > allows to work with 512 GPIOs at a time. With your code it will be much harder
> > to achieve and see what you wrote about maintenance (in that case).
> 
> v3 ABI?? libgpiod v2 is barely out the door!
> Do you have any cases where 64 lines per request is limiting?

IIRC it was SO question where the OP asks exactly about breaking the 64 lines
limitation in the current ABI.

> If that sort of speculation isn't premature optimisation then I don't know
> what is.

No, based on the real question / discussion, just have no link at hand.
But it's quite a niche, I can agree.

-- 
With Best Regards,
Andy Shevchenko


