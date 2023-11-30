Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198E7FF8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346625AbjK3RyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3RyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:54:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB73F103;
        Thu, 30 Nov 2023 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701366859; x=1732902859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xY9UO/AFJ95k9qDE3bYzg6crNx1pieB9BtEPFySYi+I=;
  b=CJTVhQ/ySLKAazpZ3x/2sD2I+bzxG3qOpIZu3BcsQkE9E+UEOF0L3AA2
   Zn74B78R6hVHfevmBreZAkwm1biETqM6UZ1nrY3SQlwvNLEAA9nx1H6cQ
   zYcEWUyBc08CtmkVwKc3bJ9PgP0qgx4aWut6gtxVDbtv+4Zn0HRR3qqWX
   Xg775dKLhKV9qMPgskNje0PPN9v6aeD+Zq3btkiwWFwXzv0PxVgZnX5Nm
   Qh/vQ0km/VdGtH++dniGN79ZPMqg4kKHzB7/TB8R2iQm6cT3k7R9nnUf4
   zd7YcshAYYkQeyDfr0P77oTKUR3rY6I1myWrEp5uOB0C0885uAxxTSZU8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="459857850"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="459857850"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 09:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803778169"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="803778169"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 09:54:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8lEs-00000000lzU-3Nbk;
        Thu, 30 Nov 2023 19:54:14 +0200
Date:   Thu, 30 Nov 2023 19:54:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 09/10] gpiolib: use gpiochip_dup_line_label() in
 for_each helpers
Message-ID: <ZWjMRklCbCaBABQW@smile.fi.intel.com>
References: <20231130134630.18198-1-brgl@bgdev.pl>
 <20231130134630.18198-10-brgl@bgdev.pl>
 <ZWi6_WnOQZB0vgPL@smile.fi.intel.com>
 <CAMRc=MfC9sxgvaigtP5=MMZwbzaSkUukfH61QBf+r_eTJh5fJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfC9sxgvaigtP5=MMZwbzaSkUukfH61QBf+r_eTJh5fJA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:42:37PM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 30, 2023 at 5:40 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Nov 30, 2023 at 02:46:29PM +0100, Bartosz Golaszewski wrote:

...

> > >  const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset);
> > >  char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset);
> > >
> > > +
> >
> > One blank line is enough.
> >
> > > +struct _gpiochip_for_each_data {
> > > +     const char **label;
> > > +     int *i;
> >
> > Why is this a signed?
> 
> Some users use signed, others use unsigned. It doesn't matter as we
> can't overflow it with the limit on the lines we have.

What's the problem to make it unsigned and be done with that for good?

> > > +};

...

> > > +DEFINE_CLASS(_gpiochip_for_each_data,
> > > +          struct _gpiochip_for_each_data,
> > > +          if (*_T.label) kfree(*_T.label),
> > > +          ({ struct _gpiochip_for_each_data _data = { label, i };
> > > +             *_data.i = 0;
> > > +             _data; }),
> >
> > To me indentation of ({}) is quite weird. Where is this style being used
> > instead of more readable
> 
> There are no guidelines for this type of C abuse AFAIK. The macro may
> be ugly but at least it hides the details from users which look nice
> instead.

If we can make it more readable for free, why not doing that way?

> >         ({
> >            ...
> >         })
> >
> > ?

-- 
With Best Regards,
Andy Shevchenko


