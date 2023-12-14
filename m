Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149F4813591
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573344AbjLNQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443492AbjLNQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:02:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADDA10E;
        Thu, 14 Dec 2023 08:02:25 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8536366"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="8536366"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1021555801"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1021555801"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:02:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDoAC-00000005t5z-0qB3;
        Thu, 14 Dec 2023 18:02:16 +0200
Date:   Thu, 14 Dec 2023 18:02:15 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 4/5] gpiolib: cdev: reduce locking in
 gpio_desc_to_lineinfo()
Message-ID: <ZXsnB-N77Zg-YvTs@smile.fi.intel.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-5-warthog618@gmail.com>
 <ZXsa39xneH6Rh7Gd@smile.fi.intel.com>
 <ZXsc5T1G5Y28lVqw@rigel>
 <ZXse4UDKGlVqzsyD@smile.fi.intel.com>
 <ZXsglIJtK50XYCIV@rigel>
 <ZXsjbvUYJGmGU6bs@rigel>
 <ZXsk5hOxXM7oJIy4@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsk5hOxXM7oJIy4@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:53:10PM +0800, Kent Gibson wrote:
> On Thu, Dec 14, 2023 at 11:46:54PM +0800, Kent Gibson wrote:
> > On Thu, Dec 14, 2023 at 11:34:44PM +0800, Kent Gibson wrote:
> > > On Thu, Dec 14, 2023 at 05:27:29PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Dec 14, 2023 at 11:19:01PM +0800, Kent Gibson wrote:
> > > > > On Thu, Dec 14, 2023 at 05:10:23PM +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Dec 14, 2023 at 05:58:13PM +0800, Kent Gibson wrote:

...

> > > > > > > -	spin_lock_irqsave(&gpio_lock, flags);
> > > > > >
> > > > > > Shouldn't this be covered by patch 1 (I mean conversion to scoped_guard()
> > > > > > instead of spinlock)?
> > > > >
> > > > > Read the cover letter.
> > > > > Doing that made the change larger, as flags gets removed then restored.
> > > > > I had also thought the flag tests would get indented then unindented, but
> > > > > if we use guard() the indentation should remain unchanged.
> > > >
> > > > I'm fine with that as I pointed out (have you received that mail? I had
> > > > problems with my mail server) the dflags is better semantically, so restoration
> > > > with _different_ name is fine.
> > >
> > > I have noted that some of your replies have been delayed, and I can't be sure
> > > of what I might not've received. I can't say I've seen one that mentions the
> > > dflags name being preferable.
> > >
> > > I prefer the plain flags name, if there is only one flag variable in the
> > > function.
> > >
> > > > > Can do it in 1 if you are happy with the flags declaration being
> > > > > removed in patch 1 and restored in 4.
> > > >
> > > > Definitely.
> > >
> > > Ok will re-arrange in v3.
> >
> > Hang on - patch 4 has to use a scoped_guard(), so are you ok for patch 1
> > to introduce a guard(), to avoid changing the indentation, only to
> > replace it with a scoped_guard(), to perform the tests after releasing
> > the lock, in patch 4?
> 
> Alternatively, I can move patch 4 to the top of the series.

I'm fine as long as we do one thing in one patch (not spread over a few
as it seems feasible).

-- 
With Best Regards,
Andy Shevchenko


