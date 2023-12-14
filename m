Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE397813538
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573884AbjLNPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573892AbjLNPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:50:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F7121;
        Thu, 14 Dec 2023 07:50:22 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2295708"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="2295708"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918098808"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="918098808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:50:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDnyb-00000005st6-0zna;
        Thu, 14 Dec 2023 17:50:17 +0200
Date:   Thu, 14 Dec 2023 17:50:16 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 4/5] gpiolib: cdev: reduce locking in
 gpio_desc_to_lineinfo()
Message-ID: <ZXskOKAyEtXTLMRt@smile.fi.intel.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-5-warthog618@gmail.com>
 <ZXsa39xneH6Rh7Gd@smile.fi.intel.com>
 <ZXsc5T1G5Y28lVqw@rigel>
 <ZXse4UDKGlVqzsyD@smile.fi.intel.com>
 <ZXsglIJtK50XYCIV@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsglIJtK50XYCIV@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:34:44PM +0800, Kent Gibson wrote:
> On Thu, Dec 14, 2023 at 05:27:29PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 14, 2023 at 11:19:01PM +0800, Kent Gibson wrote:
> > > On Thu, Dec 14, 2023 at 05:10:23PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Dec 14, 2023 at 05:58:13PM +0800, Kent Gibson wrote:

...

> > > > > -	spin_lock_irqsave(&gpio_lock, flags);
> > > >
> > > > Shouldn't this be covered by patch 1 (I mean conversion to scoped_guard()
> > > > instead of spinlock)?
> > >
> > > Read the cover letter.
> > > Doing that made the change larger, as flags gets removed then restored.
> > > I had also thought the flag tests would get indented then unindented, but
> > > if we use guard() the indentation should remain unchanged.
> >
> > I'm fine with that as I pointed out (have you received that mail? I had
> > problems with my mail server) the dflags is better semantically, so restoration
> > with _different_ name is fine.
> 
> I have noted that some of your replies have been delayed, and I can't be sure
> of what I might not've received. I can't say I've seen one that mentions the
> dflags name being preferable.
> 
> I prefer the plain flags name, if there is only one flag variable in the
> function.

I pointed out that lflags / dflags is kinda idiomatic internally to gpiolib*
code base. Using flags might feel misleading and otherwise will hint about
semantics of the variable. That said, I prefer it being named dflags.

-- 
With Best Regards,
Andy Shevchenko


