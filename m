Return-Path: <linux-kernel+bounces-1298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DF814D10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34ED1C23A53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45B3C6A4;
	Fri, 15 Dec 2023 16:31:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230FED4;
	Fri, 15 Dec 2023 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394171609"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="394171609"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840713621"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840713621"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:31:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rEB5a-00000006AWR-2XWd;
	Fri, 15 Dec 2023 18:31:02 +0200
Date: Fri, 15 Dec 2023 18:31:02 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXx_RjbamEene24U@smile.fi.intel.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-3-warthog618@gmail.com>
 <ZXsZJ9z7iln8uMf8@smile.fi.intel.com>
 <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
 <ZXsp8QjxsUMPlZIR@rigel>
 <ZXswRCsT0OYwHe3N@smile.fi.intel.com>
 <CAMRc=Md55pSWwbKqxO-eHJyn1+vtLMuWmD0d1_iqFT4h7dJ4Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md55pSWwbKqxO-eHJyn1+vtLMuWmD0d1_iqFT4h7dJ4Yg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 14, 2023 at 10:06:14PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 14, 2023 at 5:41 PM Andy Shevchenko <andy@kernel.org> wrote:
> > On Fri, Dec 15, 2023 at 12:14:41AM +0800, Kent Gibson wrote:
> > > On Thu, Dec 14, 2023 at 05:09:01PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Dec 14, 2023 at 05:03:03PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Dec 14, 2023 at 05:58:11PM +0800, Kent Gibson wrote:

...

> > > > > > +static void supinfo_init(void)
> > > > > > +{
> > > > > > +       supinfo.tree = RB_ROOT;
> > > > > > +       spin_lock_init(&supinfo.lock);
> > > > > > +}
> > > > >
> > > > > Can it be done statically?
> > > > >
> > > > > supinfo = {
> > > > >   .tree = RB_ROOT,
> > > > >   .lock = __SPIN_LOCK_UNLOCKED(supinfo.lock),
> 
> Double underscore typically means it's private and shouldn't be used.

Right, but when you have a struct you have no other means to initialize this
directly.

> > > > I even checked the current tree, we have 32 users of this pattern in drivers/.

See, there are users of the __ initializers.

> > > Ah, that is what you meant.  Yeah sure can - the supinfo_init() is
> > > another hangover from when I was trying to create the supinfo per chip,
> > > but now it is a global a static initialiser makes sense.
> >
> > Yep, the DEFINE_MUTEX() / DEFINE_SPINLOCK() / etc looks better naturally
> > than above.
> 
> Yeah, so maybe we should use non-struct, global variables after all.

At least this will allow to get rid of (questionable) initcall.

> > > And I still haven't received the email you quote there.
> >
> > :-( I'm not sure we will get it, it most likely that I removed it already
> > and it has disappeared due to problems with email server...

-- 
With Best Regards,
Andy Shevchenko



