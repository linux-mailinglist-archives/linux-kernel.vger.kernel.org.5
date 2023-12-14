Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C75813685
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjLNQll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjLNQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:41:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C3112;
        Thu, 14 Dec 2023 08:41:45 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8504528"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="8504528"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="774432692"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="774432692"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:41:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDomK-00000005tgs-3qwS;
        Thu, 14 Dec 2023 18:41:40 +0200
Date:   Thu, 14 Dec 2023 18:41:40 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXswRCsT0OYwHe3N@smile.fi.intel.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-3-warthog618@gmail.com>
 <ZXsZJ9z7iln8uMf8@smile.fi.intel.com>
 <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
 <ZXsp8QjxsUMPlZIR@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsp8QjxsUMPlZIR@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2023 at 12:14:41AM +0800, Kent Gibson wrote:
> On Thu, Dec 14, 2023 at 05:09:01PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 14, 2023 at 05:03:03PM +0200, Andy Shevchenko wrote:
> > > On Thu, Dec 14, 2023 at 05:58:11PM +0800, Kent Gibson wrote:

...

> > > > +static void supinfo_init(void)
> > > > +{
> > > > +	supinfo.tree = RB_ROOT;
> > > > +	spin_lock_init(&supinfo.lock);
> > > > +}
> > >
> > > Can it be done statically?
> > >
> > > supinfo = {
> > > 	.tree = RB_ROOT,
> > > 	.lock = __SPIN_LOCK_UNLOCKED(supinfo.lock),
> >
> > I even checked the current tree, we have 32 users of this pattern in drivers/.
> 
> Ah, that is what you meant.  Yeah sure can - the supinfo_init() is
> another hangover from when I was trying to create the supinfo per chip,
> but now it is a global a static initialiser makes sense.

Yep, the DEFINE_MUTEX() / DEFINE_SPINLOCK() / etc looks better naturally
than above.

> And I still haven't received the email you quote there.

:-( I'm not sure we will get it, it most likely that I removed it already
and it has disappeared due to problems with email server...

-- 
With Best Regards,
Andy Shevchenko


