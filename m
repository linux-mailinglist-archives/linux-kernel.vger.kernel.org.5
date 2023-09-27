Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB47B043F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjI0Mdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0Mdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:33:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75545C0;
        Wed, 27 Sep 2023 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695818024; x=1727354024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RQkDGkoB+AgZ4DklgY/4FYp96be0UV7xEwXdT2sMe2c=;
  b=KsRiuJzz7LOSDw4jPZysiDVxuq+DK/pe28ZB1zrFr34Ggt8PgeNEyS5U
   RoHgM8bmYcdQYJC9ZrQYw9vlpONKV7mDxKIjPPiWIEKbjU593fBz93qXv
   pMAIrayryxWDfZ2eu5Z7cSURBg5a7jBk+H4uDyrx3nYQAUIT2teF2Ktu9
   xu78BsYSqN21K/9knIpTOj8zecmYdXIUSOrHmVphfZkBMQNUlDOY1Dxa1
   3NDFSZPpRJ8girc4RRrjegMMqP4i7l2J3JmLb7RX0OgegvN1hbEjztRZH
   M80bs+NDMg/bF7CBc2VnpD9FJurOfc1E455Qm21obapyNjqugh7ecJwyr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="448303524"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="448303524"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="698860978"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698860978"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:33:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlTjX-00000000spT-06SH;
        Wed, 27 Sep 2023 15:33:39 +0300
Date:   Wed, 27 Sep 2023 15:33:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 04/11] gpiolib: provide gpio_device_find_by_label()
Message-ID: <ZRQhIqpb6Ho9ifgz@smile.fi.intel.com>
References: <20230915150327.81918-1-brgl@bgdev.pl>
 <20230915150327.81918-5-brgl@bgdev.pl>
 <ZQf6E+itll3dmCnU@smile.fi.intel.com>
 <CAMRc=Mcq-0yWcYp6ksDF5RP-B+7b+r2KYh5onEMKx1tpS9O4hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcq-0yWcYp6ksDF5RP-B+7b+r2KYh5onEMKx1tpS9O4hQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:22:36PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 18, 2023 at 9:19 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Sep 15, 2023 at 05:03:19PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > By far the most common way of looking up GPIO devices is using their
> > > label. Provide a helpers for that to avoid every user implementing their
> > > own matching function.

...

> > > +static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
> > > +{
> > > +     return gc->label && !strcmp(gc->label, label);
> > > +}
> >
> > I am still wondering if we can oblige providers to have label to be non-empty.
> 
> Of course we can. Just bail out of gpiochip_add_data_with_key() if it
> is. But that's material for a different patch.

Yes, but my point here is that
1) the current users are already following this requirement;
2) the enforcement can be done explicitly somewhere (in the register function).

Is the 1) incorrect assumption?

-- 
With Best Regards,
Andy Shevchenko


