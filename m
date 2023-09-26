Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49397AED6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjIZM60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjIZM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:58:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401CE120;
        Tue, 26 Sep 2023 05:58:18 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445688601"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="445688601"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 05:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814453477"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="814453477"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 05:58:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1ql7dh-00000000bcf-3MTn;
        Tue, 26 Sep 2023 15:58:09 +0300
Date:   Tue, 26 Sep 2023 15:58:09 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, alex@shruggie.ro,
        aboutphysycs@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: timberdale: Fix potential deadlock on &tgpio->lock
Message-ID: <ZRLVYWDc/3IRJBor@smile.fi.intel.com>
References: <20230926102914.6145-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926102914.6145-1-dg573847474@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:29:14AM +0000, Chengfeng Ye wrote:
> As timbgpio_irq_enable()/timbgpio_irq_disable() callback could be
> executed under irq context, it could introduce double locks on
> &tgpio->lock if it preempts other execution units requiring
> the same locks.
> 
> timbgpio_gpio_set()
> --> timbgpio_update_bit()
> --> spin_lock(&tgpio->lock)
> <interrupt>
>    --> timbgpio_irq_disable()
>    --> spin_lock_irqsave(&tgpio->lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> on &tgpio->lock inside timbgpio_gpio_set() to prevent the possible
> deadlock scenario.

Okay, makes sense.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

Question to the users of this hardware if they ever want to have this IRQ chip
in the RT environment. In that case the locking type needs to be raw.

-- 
With Best Regards,
Andy Shevchenko


