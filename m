Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310E8118D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjLMQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjLMQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:12:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88904DB;
        Wed, 13 Dec 2023 08:12:54 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="379978078"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="379978078"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:12:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947229929"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="947229929"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:12:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDRqc-00000005ZFp-1DbZ;
        Wed, 13 Dec 2023 18:12:34 +0200
Date:   Wed, 13 Dec 2023 18:12:34 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
References: <20231212054253.50094-1-warthog618@gmail.com>
 <20231212054253.50094-2-warthog618@gmail.com>
 <ZXm3rayrcvfO1t1Z@smile.fi.intel.com>
 <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
 <ZXnU3tMYCc2Rw8Qv@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXnU3tMYCc2Rw8Qv@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:59:26PM +0800, Kent Gibson wrote:
> On Wed, Dec 13, 2023 at 04:40:12PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Dec 13, 2023 at 3:27 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > On Wed, Dec 13, 2023 at 03:54:53PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Dec 12, 2023 at 01:42:50PM +0800, Kent Gibson wrote:

...

> > > > > +static struct supinfo supinfo;
> > > >
> > > > Why supinfo should be a struct to begin with? Seems to me as an unneeded
> > > > complication.
> >
> > I think we should keep it as a struct but defined the following way:
> >
> > struct {
> >     spinlock_t lock;
> >     struct rb_root tree;
> > } supinfo;
> 
> That is what I meant be merging the struct definition with the variable
> definition.  Or is there some other way to completely do away with the
> struct that I'm missing?

Look at the top of gpiolib.c:

static DEFINE_MUTEX(gpio_lookup_lock);
static LIST_HEAD(gpio_lookup_list);

In the similar way you can simply do

static DEFINE_SPINLOCK(gpio_sup_lock);
static struct rb_root gpio_sup_tree;

> > > Yeah, that is a hangover from an earlier iteration where supinfo was
> > > contained in other object rather than being a global.
> > > Could merge the struct definition into the variable now.

-- 
With Best Regards,
Andy Shevchenko


