Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5BE7B4F12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbjJBJcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjJBJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:32:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409983;
        Mon,  2 Oct 2023 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239149; x=1727775149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6GmsFUuqnSQcHUaemY2k1EPSCoudlb/4q0uxHkXHGLg=;
  b=a+bn3uPCR4UZrIpgag8O2X9jqtq65jffs4Agt000By1mIxViZmRgjVDT
   /SLKL4pvjnaDsgue9N55nkdwvdIo6FJtm5H7JFHUSZmcBI9lM/OS0pfRw
   wuVfPk7lCucuQe/Aoun/Uc/DFbIZqEY7W8qve2lTO9TXojYhPEsU9kPOu
   Lt1eDvgxdsBHZcXH8FF2klTRF3JnnS0lIYzLYe3F9XFodfao7BVolkyk3
   vbSL8JsgaHRsAC7C5jLjgcFa6kw7BC4yEL8et7l5+ZkcCO6Vm1QHa58+u
   zvjUMcFcPg8YnnxAI0EZ/4mFO7ZflSdEVsVlPTQ83p17HwG+6EE6Ghu/Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382515680"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382515680"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081591076"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1081591076"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:32:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnFHq-000000027Vr-1phY;
        Mon, 02 Oct 2023 12:32:22 +0300
Date:   Mon, 2 Oct 2023 12:32:22 +0300
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
Message-ID: <ZRqOJsTAdjN4BsQf@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZROGG44v5kfktdVs@sol>
 <ZRQdQnL5VbX659cl@smile.fi.intel.com>
 <ZRQy795YoPOKsOcz@sol>
 <ZRQ1RpHEapodQ0xU@smile.fi.intel.com>
 <ZRQ60KBtY09uPxp6@sol>
 <ZRqHx+Ihcxor2Jz4@smile.fi.intel.com>
 <ZRqMcSffA7V77mqW@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRqMcSffA7V77mqW@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 05:25:05PM +0800, Kent Gibson wrote:
> On Mon, Oct 02, 2023 at 12:05:11PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 27, 2023 at 10:23:12PM +0800, Kent Gibson wrote:
> > > On Wed, Sep 27, 2023 at 04:59:34PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Sep 27, 2023 at 09:49:35PM +0800, Kent Gibson wrote:
> > > > > On Wed, Sep 27, 2023 at 03:17:06PM +0300, Andy Shevchenko wrote:
> > > > > > On Wed, Sep 27, 2023 at 09:32:11AM +0800, Kent Gibson wrote:

...

> > > > > > Yet, it opens a way to scale this in case we might have v3 ABI that let's say
> > > > > > allows to work with 512 GPIOs at a time. With your code it will be much harder
> > > > > > to achieve and see what you wrote about maintenance (in that case).
> > > > > 
> > > > > v3 ABI?? libgpiod v2 is barely out the door!
> > > > > Do you have any cases where 64 lines per request is limiting?
> > > > 
> > > > IIRC it was SO question where the OP asks exactly about breaking the 64 lines
> > > > limitation in the current ABI.
> > > > 
> > > > > If that sort of speculation isn't premature optimisation then I don't know
> > > > > what is.
> > > > 
> > > > No, based on the real question / discussion, just have no link at hand.
> > > > But it's quite a niche, I can agree.
> > > 
> > > Let me know if you find a ref to that discussion - I'm curious.
> > 
> > Here it is (read comments as well):
> > https://stackoverflow.com/questions/76307370/control-gpio-from-linux-userspace-with-linux-gpio-h
> > 
> 
> That question looks to me to be confusing how many GPIOs can be
> requested per request (64) and in total (effectively unlimited) - thinking
> they are the same.
> That could be due to their desire to use the gpiod_chip_get_all_lines()
> convenience function with a chip with more than 64 lines, rather than
> because they have an actual need for the lines to be managed in a single
> request.
> 
> So that doesn't look like a genuine use case to me - just a "what if I
> want to do X" question.  Certainly not something that would warrant a v3
> ABI.

Sure, and I'm not talking about v3 ABI to go for, see the word "might" in my
reply in the first paragraph of this message.

-- 
With Best Regards,
Andy Shevchenko


