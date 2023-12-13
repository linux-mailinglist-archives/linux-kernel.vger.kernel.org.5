Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD5811971
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjLMQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjLMQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:29:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12BF199;
        Wed, 13 Dec 2023 08:29:50 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16540646"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="16540646"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="839939338"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="839939338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:29:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDS7G-00000005ZZv-2YRa;
        Wed, 13 Dec 2023 18:29:46 +0200
Date:   Wed, 13 Dec 2023 18:29:46 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXnb-ks_noYLWZZ2@smile.fi.intel.com>
References: <20231212054253.50094-1-warthog618@gmail.com>
 <20231212054253.50094-2-warthog618@gmail.com>
 <ZXm3rayrcvfO1t1Z@smile.fi.intel.com>
 <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
 <ZXnU3tMYCc2Rw8Qv@rigel>
 <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
 <CAMRc=Mfj_4YvQVP=UWkULBwJniDDjapttU+qSgqfN5ZWNgikKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfj_4YvQVP=UWkULBwJniDDjapttU+qSgqfN5ZWNgikKw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 05:15:38PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 13, 2023 at 5:12 PM Andy Shevchenko <andy@kernel.org> wrote:
> > On Wed, Dec 13, 2023 at 11:59:26PM +0800, Kent Gibson wrote:
> > > On Wed, Dec 13, 2023 at 04:40:12PM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Dec 13, 2023 at 3:27 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > On Wed, Dec 13, 2023 at 03:54:53PM +0200, Andy Shevchenko wrote:
> > > > > > On Tue, Dec 12, 2023 at 01:42:50PM +0800, Kent Gibson wrote:

...

> > > > > > > +static struct supinfo supinfo;
> > > > > >
> > > > > > Why supinfo should be a struct to begin with? Seems to me as an unneeded
> > > > > > complication.
> > > >
> > > > I think we should keep it as a struct but defined the following way:
> > > >
> > > > struct {
> > > >     spinlock_t lock;
> > > >     struct rb_root tree;
> > > > } supinfo;
> > >
> > > That is what I meant be merging the struct definition with the variable
> > > definition.  Or is there some other way to completely do away with the
> > > struct that I'm missing?
> >
> > Look at the top of gpiolib.c:
> >
> > static DEFINE_MUTEX(gpio_lookup_lock);
> > static LIST_HEAD(gpio_lookup_list);
> >
> > In the similar way you can simply do
> >
> > static DEFINE_SPINLOCK(gpio_sup_lock);
> > static struct rb_root gpio_sup_tree;
> 
> The fact that this has been like this, doesn't mean it's the only
> right way. IMO putting these into the same structure makes logical
> sense.

I disagree on the struct like this on the grounds:
- it's global
- it's one time use
- it adds complications for no benefit
- it makes code uglier and longer

What we probably want to have is a singleton objects in C language or at least
inside Linux kernel project. But I'm not sure it's feasible.

> > > > > Yeah, that is a hangover from an earlier iteration where supinfo was
> > > > > contained in other object rather than being a global.
> > > > > Could merge the struct definition into the variable now.

-- 
With Best Regards,
Andy Shevchenko


