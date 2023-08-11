Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC37791E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjHKObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbjHKObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:31:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954FA2D43;
        Fri, 11 Aug 2023 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691764268; x=1723300268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V0rWBJnV04HOXO5c5dxMeQmlkk10nRl6UiyUfynHXnE=;
  b=lOiZgb9EEMocypzAxV0gov6EvYcgAldr7CnTMyIvhDbuT0GC117EOhrS
   5s1xGMRhKWTAiLKKrCQ5WminVNCGuUrarhN1RO0SMvffe5y0scgJe5HwY
   Tj390F7aQykfmEnL8X4283mP3IAWcG93Zk4ZXbFWjuZH4o8+x/6W2CNDb
   edkeyv+dIlZD1saQktPw7ON7uf4OKMKEf+w9TS97Bij26pSQHzpKZ6rFx
   fS+6/8/P8DdqFdJ/74NvVvb9nLbGAN5teOt5k+sf1DMxJoi+3lRPMYQmc
   LKfvmnsdWWnXBej0r69B6L58P5rQBZD9NCgtlkepsrtisCKiHLaxOljbx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="374457613"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="374457613"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:31:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="709548677"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709548677"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2023 07:31:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUTAO-001Jz0-34;
        Fri, 11 Aug 2023 17:31:04 +0300
Date:   Fri, 11 Aug 2023 17:31:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2 v2] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZNZGKPq7f5l9yCjB@smile.fi.intel.com>
References: <20230811131427.40466-1-brgl@bgdev.pl>
 <20230811131427.40466-2-brgl@bgdev.pl>
 <ZNZEq5wo655rttb/@smile.fi.intel.com>
 <CAMRc=Me+Oc0hJwLqy_wAhVGjbDm2vZUDpsDbD4+6jiL-vZp9eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me+Oc0hJwLqy_wAhVGjbDm2vZUDpsDbD4+6jiL-vZp9eg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 04:28:38PM +0200, Bartosz Golaszewski wrote:
> On Fri, Aug 11, 2023 at 4:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Aug 11, 2023 at 03:14:27PM +0200, Bartosz Golaszewski wrote:

...

> > >       struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
> > >       struct gpio_sim_chip_name_ctx ctx = { bank->swnode, page };
> > > -     int ret;
> > >
> > > -     mutex_lock(&dev->lock);
> > > +     guard(mutex)(&dev->lock);
> > > +
> > >       if (gpio_sim_device_is_live_unlocked(dev))
> > > -             ret = device_for_each_child(&dev->pdev->dev, &ctx,
> > > -                                         gpio_sim_emit_chip_name);
> > > -     else
> > > -             ret = sprintf(page, "none\n");
> > > -     mutex_unlock(&dev->lock);
> > > +             return device_for_each_child(&dev->pdev->dev, &ctx,
> > > +                                          gpio_sim_emit_chip_name);
> > >
> > > -     return ret;
> > > +     return sprintf(page, "none\n");
> >
> > I looked at the original and at the change and maybe it could be done as
> >
> 
> What's the difference?!
> 
> >         struct device *parent = &dev->pdev->dev; // Naming?
> >         bool live;
> >
> >         live = gpio_sim_device_is_live_unlocked(dev);
> >         if (!live)
> >                 return sprintf(page, "none\n");
> >
> >         return device_for_each_child(parent, &ctx, gpio_sim_emit_chip_name);

No wrapped lines.

-- 
With Best Regards,
Andy Shevchenko


