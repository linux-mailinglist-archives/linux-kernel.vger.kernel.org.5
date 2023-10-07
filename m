Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2707BC5A1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbjJGHgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbjJGHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:36:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F0B9;
        Sat,  7 Oct 2023 00:36:16 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363258789"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="363258789"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="876236536"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="876236536"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:36:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy@kernel.org>)
        id 1qp1r9-00000003Xnq-2voy;
        Sat, 07 Oct 2023 10:36:11 +0300
Date:   Sat, 7 Oct 2023 10:36:11 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct
 gpio_chip
Message-ID: <ZSEKa3gwBRzR7HI+@smile.fi.intel.com>
References: <20231006115147.18559-1-brgl@bgdev.pl>
 <ZSAKdOXpo+xOI3sJ@smile.fi.intel.com>
 <CAMRc=MeYiiWaaqRtSjRBfaWGFtZCPWCjYk+ZrX5TwicNq9MQeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeYiiWaaqRtSjRBfaWGFtZCPWCjYk+ZrX5TwicNq9MQeA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:07:49PM +0200, Bartosz Golaszewski wrote:
> On Fri, Oct 6, 2023 at 3:24 PM Andy Shevchenko <andy@kernel.org> wrote:
> >
> > On Fri, Oct 06, 2023 at 01:51:47PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > struct gpio_chip is not only used to carry the information needed to
> > > set-up a GPIO device but is also used in all GPIOLIB callbacks and is
> > > passed to the matching functions of lookup helpers.
> > >
> > > In that last case, it is currently impossible to match a GPIO device by
> > > fwnode unless it was explicitly assigned to the chip in the provider
> > > code. If the fwnode is taken from the parent device, the pointer in
> > > struct gpio_chip will remain NULL.
> > >
> > > If we have a parent device but gc->fwnode was not assigned by the
> > > provider, let's assign it ourselves so that lookup by fwnode can work in
> > > all cases.

...

> > > +             gc->fwnode = parent_fwnode;
> >
> > Ah, this is basically reverts my commit, the whole idea of which was to go
> > towards constant struct gpio_chip object that is supplied by a provider.
> 
> Then this idea was wrong in the first place and that goal will never
> be achieved.

Why not? You always can have internal opaque data structure that takes constant
object from the provider.

> Whether that's a correct approach is questionable but
> struct gpio_chip has become so much more than a simple config
> structure and - given how ubiquitous GPIO providers are throughout the
> different subsystems of the kernel - it'll stay that way unless we're
> ready to rebuild every GPIO provider in linux.

> The best we can do now is at least make its usage safe. Meaning: it's
> a structure with which providers will interact using GPIOLIB callbacks
> which will in turn assure that during the execution of any function
> taking struct gpio_chip as argument, it will remain alive and
> protected from concurrent access.
> 
> The providers however will continue to use gpio_chip for many
> purposes. One of such purposes is matching the GPIO device BY its
> backing gpio_chip structure. It not having the same fwnode in this
> particular case is an inconsistency rather than design IMO.
> 
> I don't see any good reason for it not having the fwnode assigned.

I see it clearly that we don't need to go this dead end.
The fwnode used by GPIO devices is not semantically the same as fwnode that is
supplied by the provider. Moreover, your patch will bring a clear layering
violation since it changes the member behind the owner's back.

> User calling gpio_device_find() will have to jump through hoops in
> order to match the device by fwnode (include gpiolib.h and dereference
> gpiodev?) but it could be very easily facilitated by just assigning it
> at registration-time - just like we assign a whole bunch of other
> pointers and data structures.

No, please do not do this hack with fwnode.

-- 
With Best Regards,
Andy Shevchenko


