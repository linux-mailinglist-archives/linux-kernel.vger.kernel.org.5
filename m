Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA063813411
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573657AbjLNPJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573642AbjLNPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:09:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8438E;
        Thu, 14 Dec 2023 07:09:07 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2217992"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="2217992"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844740792"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="844740792"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:09:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDnKg-00000005sHL-1OEJ;
        Thu, 14 Dec 2023 17:09:02 +0200
Date:   Thu, 14 Dec 2023 17:09:01 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-3-warthog618@gmail.com>
 <ZXsZJ9z7iln8uMf8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsZJ9z7iln8uMf8@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 05:03:03PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 14, 2023 at 05:58:11PM +0800, Kent Gibson wrote:

...

> > +/*
> > + * Used to populate gpio_v2_line_info with cdev specific fields not contained
> > + * in the struct gpio_desc.
> > + * A line is determined to contain supplemental information by
> > + * line_is_supplemental().
> > + */
> > +static struct {
> > +	/* a rbtree of the struct lines containing the supplemental info */
> > +	struct rb_root tree;
> > +	/* covers tree */
> > +	spinlock_t lock;
> > +} supinfo;

Hmm... If I read the kernel-doc script it should support anonymous structs
and unions...

...

> > +static void supinfo_init(void)
> > +{
> > +	supinfo.tree = RB_ROOT;
> > +	spin_lock_init(&supinfo.lock);
> > +}
> 
> Can it be done statically?
> 
> supinfo = {
> 	.tree = RB_ROOT,
> 	.lock = __SPIN_LOCK_UNLOCKED(supinfo.lock),

I even checked the current tree, we have 32 users of this pattern in drivers/.

> };

-- 
With Best Regards,
Andy Shevchenko


