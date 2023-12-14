Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5678134B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573780AbjLNP1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjLNP13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:27:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF302A3;
        Thu, 14 Dec 2023 07:27:35 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392309700"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="392309700"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:27:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="774405344"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="774405344"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:27:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDncY-00000005sVG-0e1D;
        Thu, 14 Dec 2023 17:27:30 +0200
Date:   Thu, 14 Dec 2023 17:27:29 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 4/5] gpiolib: cdev: reduce locking in
 gpio_desc_to_lineinfo()
Message-ID: <ZXse4UDKGlVqzsyD@smile.fi.intel.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-5-warthog618@gmail.com>
 <ZXsa39xneH6Rh7Gd@smile.fi.intel.com>
 <ZXsc5T1G5Y28lVqw@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsc5T1G5Y28lVqw@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:19:01PM +0800, Kent Gibson wrote:
> On Thu, Dec 14, 2023 at 05:10:23PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 14, 2023 at 05:58:13PM +0800, Kent Gibson wrote:
> > > Reduce the time holding the gpio_lock by snapshotting the desc flags,
> > > rather than testing them individually while holding the lock.
> > >
> > > Accept that the calculation of the used field is inherently racy, and
> > > only check the availability of the line from pinctrl if other checks
> > > pass, so avoiding the check for lines that are otherwise in use.

...

> > > -	spin_lock_irqsave(&gpio_lock, flags);
> >
> > Shouldn't this be covered by patch 1 (I mean conversion to scoped_guard()
> > instead of spinlock)?
> >
> 
> Read the cover letter.
> Doing that made the change larger, as flags gets removed then restored.
> I had also thought the flag tests would get indented then unindented, but
> if we use guard() the indentation should remain unchanged.

I'm fine with that as I pointed out (have you received that mail? I had
problems with my mail server) the dflags is better semantically, so restoration
with _different_ name is fine.

> Can do it in 1 if you are happy with the flags declaration being
> removed in patch 1 and restored in 4.

Definitely.

-- 
With Best Regards,
Andy Shevchenko


