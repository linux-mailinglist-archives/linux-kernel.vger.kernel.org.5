Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB147B461C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjJAISx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJAISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:18:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B819C;
        Sun,  1 Oct 2023 01:18:49 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="446656290"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="446656290"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 01:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="700047588"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="700047588"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 01:18:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qmrez-00000001qqK-11KX;
        Sun, 01 Oct 2023 11:18:41 +0300
Date:   Sun, 1 Oct 2023 11:18:40 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
Message-ID: <ZRkrYChL0hKZwQGp@smile.fi.intel.com>
References: <20230924-pxa-gpio-v1-0-2805b87d8894@skole.hr>
 <20230924-pxa-gpio-v1-1-2805b87d8894@skole.hr>
 <ZRE3JNVNqFN0knHl@smile.fi.intel.com>
 <CACRpkdZdSTCeobuFdXNbJcHTKJp1V=t1sfp2tp25Mb0FBh74pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZdSTCeobuFdXNbJcHTKJp1V=t1sfp2tp25Mb0FBh74pA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 04:01:58PM +0200, Linus Walleij wrote:
> On Mon, Sep 25, 2023 at 9:30 AM Andy Shevchenko <andy@kernel.org> wrote:

...

> > > +     if (pxa_ohci->usb_host)
> > > +             gpiod_put(pxa_ohci->usb_host);
> >
> > Linus, Bart, do we have misdesigned _optinal() GPIO APIs?
> >
> > In GPIOLIB=n, the above requires that redundant check. Shouldn't we replace
> > gpiod_put() stub to be simply no-op?
> 
> You mean the WARN_ON(desc) in gpiod_put() in the static inline
> stub version?
> 
> I thought about it for a bit, drafted a patch removing them, and then
> realized the following:
> 
> If someone is making the gpiolib optional for a driver, i.e. neither
> DEPENDS ON GPIOLIB nor SELECT GPIOLIB, they are a quite
> narrow segment. I would say in 9 cases out of 10 or more this is
> just a driver that should depend on or select GPIOLIB.
> 
> I think such drivers should actually do the NULL checks and not be
> too convenient, the reason is readability: someone reading that
> driver will be thinking gpios are not optional if they can call
> gpiod_set_value(), gpiod_put() etc without any sign that the
> desc is optional.
> 
> If the driver uses [devm_]gpiod_get_optional() the library is not
> using the stubs and does the right thing, and it is clear that
> the GPIO is *runtime* optional.
> 
> But *compile time* optional, *combined* with runtime optional -
> I'm not so happy if we try to avoid warnings around that. I think
> it leads to confusing configs and code that looks like gpiolib is
> around despite it wasn't selected.
> 
> If the code isn't depending on or selecting GPIOLIB and still
> use _optional() calls, it better be ready to do some extra checks,
> because this is a weird combo, it can't be common.
> 
> Could be a documentation update making this clear though.
> 
> What do you other people think?

The problem here indeed if the code is not selecting or being dependent on
GPIOLIB and uses _optional() calls.

I agree that this is quite a niche that should be addressed on the driver side.

-- 
With Best Regards,
Andy Shevchenko


