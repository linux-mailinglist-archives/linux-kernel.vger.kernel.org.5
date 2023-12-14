Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5149813333
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573498AbjLNOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573453AbjLNOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:35:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D1A7;
        Thu, 14 Dec 2023 06:35:14 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394873872"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="394873872"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:35:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918076811"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="918076811"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:35:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDmnu-00000005rsw-18w9;
        Thu, 14 Dec 2023 16:35:10 +0200
Date:   Thu, 14 Dec 2023 16:35:09 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXsSnTcnAsopYodl@smile.fi.intel.com>
References: <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
 <ZXnU3tMYCc2Rw8Qv@rigel>
 <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
 <CAMRc=Mfj_4YvQVP=UWkULBwJniDDjapttU+qSgqfN5ZWNgikKw@mail.gmail.com>
 <ZXnb-ks_noYLWZZ2@smile.fi.intel.com>
 <CAMRc=MfaHKKKNkXW0L1FPjCH4VvG22Vn9q8z9tupZCtCEKZU2g@mail.gmail.com>
 <ZXoO8B0N3S49GnvX@smile.fi.intel.com>
 <ZXpJueTnmtUIecCd@rigel>
 <ZXplMThBSD53UV0s@rigel>
 <CAMRc=MeZg0xg7ASA3x4PxCYymCmCEp0zZbUgGTCCzrjPaPZCag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeZg0xg7ASA3x4PxCYymCmCEp0zZbUgGTCCzrjPaPZCag@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:40:26AM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 14, 2023 at 3:15 AM Kent Gibson <warthog618@gmail.com> wrote:
> > On Thu, Dec 14, 2023 at 08:18:01AM +0800, Kent Gibson wrote:
> > > On Wed, Dec 13, 2023 at 10:07:12PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Dec 13, 2023 at 08:03:44PM +0100, Bartosz Golaszewski wrote:

...

> > > > > > - it adds complications for no benefit
> > >
> > > It provides a placeholder for collective documentation and clarifies
> > > scope for the reader.
> >
> > Turns out kernel-doc can't deal with a struct variable declaration - it
> > needs the struct to be named.
> >
> > So this doesn't parse:
> >
> > static struct {
> >         struct rb_root tree;
> >         spinlock_t lock;
> > } supinfo;
> >
> > but this does:
> >
> > static struct supinfo {
> >         struct rb_root tree;
> >         spinlock_t lock;
> > } supinfo;
> >
> > at which point I prefer the separate struct and var declarations as per
> > the patch.
> >
> > Opinions?
> 
> Yeah, don't make it a kernel doc. It's a private structure, no need to
> expose documentation for it in docs. Just use a regular comment - say
> what it is and why it's here.

I agree with Bart, make it plain comment if needed.

-- 
With Best Regards,
Andy Shevchenko


