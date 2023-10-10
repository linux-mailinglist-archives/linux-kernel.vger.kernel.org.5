Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3747C0039
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjJJPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjJJPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:18:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F428AC;
        Tue, 10 Oct 2023 08:18:11 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363771718"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="363771718"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823812908"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="823812908"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:18:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy@kernel.org>)
        id 1qqEUn-00000004NJZ-3tXk;
        Tue, 10 Oct 2023 18:18:05 +0300
Date:   Tue, 10 Oct 2023 18:18:05 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Dipen Patel <dipenp@nvidia.com>, linus.walleij@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] gpio: tegra186: Set fwnode of the GPIO chip
Message-ID: <ZSVrLZyB278Q0A7I@smile.fi.intel.com>
References: <20231009173858.723686-1-dipenp@nvidia.com>
 <ZSVN73ffDkGBzmmI@smile.fi.intel.com>
 <ZSVWKSVNsBqDcOFS@smile.fi.intel.com>
 <ZSVcFo2sDVbMCW3Z@smile.fi.intel.com>
 <ZSVewh61i8JzwxQQ@smile.fi.intel.com>
 <CAMRc=MdBGf7g1xcGid+AuWaLhm3AJEAvFjK4PFOhs2dUF35QdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdBGf7g1xcGid+AuWaLhm3AJEAvFjK4PFOhs2dUF35QdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 05:10:08PM +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 10, 2023 at 4:25 PM Andy Shevchenko <andy@kernel.org> wrote:
> > On Tue, Oct 10, 2023 at 05:13:42PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 10, 2023 at 04:48:25PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 10, 2023 at 04:13:19PM +0300, Andy Shevchenko wrote:
> > > > > On Mon, Oct 09, 2023 at 10:38:58AM -0700, Dipen Patel wrote:

...

> > > > > > +       /*
> > > > > > +        * This is needed for driver using gpio device matching where it
> > > > > > +        * has to use gpio_chip fwnode to match the gpio controller.
> > > > > > +        */
> > > > > > +       gpio->gpio.fwnode = of_node_to_fwnode(pdev->dev.of_node);
> > > > >
> > > > > of_node_to_fwnode() is specific to IRQ, in other places we use generic
> > > > > of_fwnode_handle(). That's why better just to use dev_fwnode().
> > > >
> > > > On the second thought is there any parent assigned?
> > > > At least I see that in tegra186_gpio_probe(). Are you saying
> > > > it is not working? Or is it (matching) called _before_ we
> > > > add a GPIO device?
> > >
> > > Okay, I think I got it. There is a function called tegra_gpiochip_match()
> > > in drivers/hte/hte-tegra194.c which fails after my patch. Yeah, if provider
> > > doesn't set fwnode, it can't match. But, since the driver sets the parent
> > > properly it means that the matching function should be done against the
> > > device.
> > >
> > > Seems to me that in HTE code the matching function is broken.
> >
> > I'll send a patch soon. Please, test it.
> 
> I'll have you know that if it is about to add any new "#include
> ../gpio/gpiolib.h", then it's a preemptive NAK from me. :)

Nope, see I just sent it.

-- 
With Best Regards,
Andy Shevchenko


