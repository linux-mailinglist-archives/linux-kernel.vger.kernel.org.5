Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4877093A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjHDT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHDT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:58:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9BCE6E;
        Fri,  4 Aug 2023 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691179104; x=1722715104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+UFLJexDEQ254y7YqmIGhFkuKiS0FmKIYPvZmypYM0w=;
  b=adEzplsubNNXdTuiWk6yecFRQW7lFHWFlzDuH0XnQ7KVusLeHBgkZxha
   q/UejMLIPR++l2Doqnc9PYApRQxBctsQ3ArGo8WdSHtKqcYin7sPiXFi5
   /Pg0U3Ga7DGHZ1e4N1eiXNlCXT4uAJyDtpAO367P/KD/6xfppnXuYsi1V
   zX2JXfZNF3k56kEDYe6xRevm1rQAap9CcbvyORftd40MGJO+rcpI9/7x0
   WrDnNZIEORiDD2Ry48y3q1DZRKJw7mFamR4Jy4zXo8HCkY/O0plyaAxaZ
   BPk3K44jDKxHG0r27eX+g4+eU3G6aS8v/zGl5aDd/I6MAiQwnZND6u7UL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="350546967"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="350546967"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="730179139"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="730179139"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2023 12:58:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qS0wF-005nGB-2T;
        Fri, 04 Aug 2023 22:58:19 +0300
Date:   Fri, 4 Aug 2023 22:58:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC PATCH] gpio: consumer: new virtual driver
Message-ID: <ZM1YW025tD6S/y+Q@smile.fi.intel.com>
References: <20230802152808.33037-1-brgl@bgdev.pl>
 <ZMuR0W303WCbS1K0@smile.fi.intel.com>
 <CAMRc=McEAG7Ezgb=OwMPoRhQzu_A66JMnB=aBSgmdZUvS-ZPhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McEAG7Ezgb=OwMPoRhQzu_A66JMnB=aBSgmdZUvS-ZPhw@mail.gmail.com>
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

On Fri, Aug 04, 2023 at 06:03:47PM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 3, 2023 at 1:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > > +     if (list_empty(&dev->lookup_list))
> > > +             return -ENODATA;
> >
> > Instead you may count nodes here and if 0, return an error, otherwise pass it
> > to the callee.
> 
> I'm not following, please rephrase.

The below call calls list_count_nodes(), you may simply join these two checks
by calling list_count_nodes() and return -ENODATA in case it's 0.

> > > +     swnode = gpio_consumer_make_device_swnode(dev);
> > > +     if (IS_ERR(swnode))
> > > +             return PTR_ERR(swnode);

...

> > > +     if ((!live && !gpio_consumer_device_is_live_unlocked(dev)) ||
> > > +         (live && gpio_consumer_device_is_live_unlocked(dev)))
> >
> >         if (live ^ gpio_consumer_device_is_live_unlocked(dev))
> >
> > ?
> 
> Nah, let's not use bitwise operators for boolean logic.

Then it's even simpler:

	if (live == gpio_consumer_device_is_live_unlocked(dev))

-- 
With Best Regards,
Andy Shevchenko


