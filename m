Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EE6784127
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjHVMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjHVMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:47:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDA9196;
        Tue, 22 Aug 2023 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692708435; x=1724244435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UonbXoSmR1JAmT350Vpu2KT6ofamcHeaMCF7hvGopqU=;
  b=j8bPAihL+4M98plOswfnx/OoduPwoW+JzlFT0X2C3wgeU0XksWH0vzgI
   iW7Lx2AVSVDpxajSdhGklnoFR23OD5v9FH/ypp4XghkDaGMFss5eucpVv
   2kUZm1z+qqlY7/9I0AlnRxC4R3pPQ+TcO5BX0CbV1Ggjbgf6et+DviAds
   TItEyqDuFsG6LjhAif1iW5JFRqimz4sDx9IhvuT6QTp8YCOGdO7kpPA0L
   JbWMCExa+qEJ2vmE40H9wSFjMD/eXf+FHe9oo8ExwYhqlCHi+mvign6VB
   3UbRSHsnVhvpMlj5x5mof3WevWekRfwbh8PWAtsse+EdvnOHo4Oxl4fBQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373849060"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="373849060"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826319745"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="826319745"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2023 05:46:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYQmM-00AloG-0O;
        Tue, 22 Aug 2023 15:46:38 +0300
Date:   Tue, 22 Aug 2023 15:46:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpio: sim: dispose of irq mappings before destroying
 the irq_sim domain
Message-ID: <ZOSuLYst/CZNJCaM@smile.fi.intel.com>
References: <20230822075122.6900-1-brgl@bgdev.pl>
 <ZOSmFGZHrLq3I+zF@smile.fi.intel.com>
 <CAMRc=MenZDhrVb9BgJ3R+NqyvoHJR2stjeXouSRWTkecgo160g@mail.gmail.com>
 <ZOSo+CVYuOxYCNPZ@smile.fi.intel.com>
 <CAMRc=Mfw09z2vnsQXmbc_xrg5xrLv4y1myCdm1zrx8GBWMWTzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfw09z2vnsQXmbc_xrg5xrLv4y1myCdm1zrx8GBWMWTzg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:38:28PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 22, 2023 at 2:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 22, 2023 at 02:16:44PM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Aug 22, 2023 at 2:12 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Aug 22, 2023 at 09:51:21AM +0200, Bartosz Golaszewski wrote:

...

> > > > > +static void gpio_sim_dispose_mappings(void *data)
> > > > > +{
> > > > > +     struct gpio_sim_chip *chip = data;
> > > > > +     unsigned int i, irq;
> > > > > +
> > > > > +     for (i = 0; i < chip->gc.ngpio; i++) {
> > > > > +             irq = irq_find_mapping(chip->irq_sim, i);
> > > >
> > > > > +             if (irq)
> > > >
> > > > This duplicates check in the following call.
> > > >
> > >
> > > Ah so it can be a direct call:
> > >
> > >     irq_dispose_mapping(irq_find_mapping(chip->irq_sim, i));
> > >
> > > ?
> >
> > Hehe, seems yes and no. According to the code — yes, but code seems buggy,
> > and compiler may effectively drop the check (haven't checked this, though).
> >
> > OTOH, the problem may appear if and only if we have no sparse IRQ configuration
> > which is probably rare.
> >
> > That said, I will go without check, it's not your issue.
> > And I found other places in IRQ framework that misses that check.
> >
> 
> I disagree. If there's no strong contract from the provider of this
> function then this check is so cheap that I'm ready to live with it.

There are plenty of calls that don't check and there are calls that check.

> > > > > +                     irq_dispose_mapping(irq);
> > > > > +     }
> > > > > +}

-- 
With Best Regards,
Andy Shevchenko


