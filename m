Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12D77D068
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbjHOQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjHOQxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:53:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E511B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692118393; x=1723654393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sTQIaXCrzI/ym6V65Yk6O8oSu9EVhRhxGtTrLsAYcfQ=;
  b=iFCivBrL2I/45gjwSwWxXPehF3zr9WkMJB1jlKvOCbrd5rWkf8B+pxfX
   L56+iqFj4Dr4e7P2HLJNpbs9/Xh/lkiGvJP7OjZ0zes5YhSHLgyuNkl4t
   tGWy2dN6q0O7flwGVqJFGaNxG5Qhhqcm/L8C8wRr2/+Tvt9ZnqDFYFlyh
   tZMBuJc8vhZCt0onbS2xYsuA/cfHB3aN/GNwLB/EvHdslKFASdhghVCQN
   XEsVH/eiljq1GCnIzEwUa+mxOoLJS+6/KKBmM4fTiOYglmgsedHk9glVU
   JtetnrMfOwQIFeYWzqtNylqUGsPax3geArAI7zD5jcHNEpn4QMyzXdm5X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436218094"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="436218094"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727423435"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="727423435"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 09:53:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVxI5-00ADJ0-1L;
        Tue, 15 Aug 2023 19:53:09 +0300
Date:   Tue, 15 Aug 2023 19:53:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/4] genirq/irq_sim: dispose of remaining mappings before
 removing the domain
Message-ID: <ZNutdXlS5R/0rqqH@smile.fi.intel.com>
References: <20230812194457.6432-1-brgl@bgdev.pl>
 <20230812194457.6432-2-brgl@bgdev.pl>
 <ZNtVuUWTZa0gLwXz@smile.fi.intel.com>
 <ZNujJhy9fmCFwwLK@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNujJhy9fmCFwwLK@yury-ThinkPad>
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

On Tue, Aug 15, 2023 at 09:09:10AM -0700, Yury Norov wrote:
> On Tue, Aug 15, 2023 at 01:38:49PM +0300, Andy Shevchenko wrote:
> > On Sat, Aug 12, 2023 at 09:44:54PM +0200, Bartosz Golaszewski wrote:

...

> > > @@ -16,12 +17,14 @@ struct irq_sim_work_ctx {
> > >  	unsigned int		irq_count;
> > >  	unsigned long		*pending;
> > >  	struct irq_domain	*domain;
> > > +	struct list_head	irqs;
> > >  };
> > >  
> > >  struct irq_sim_irq_ctx {
> > >  	int			irqnum;
> > >  	bool			enabled;
> > >  	struct irq_sim_work_ctx	*work_ctx;
> > 
> > > +	struct list_head	siblings;
> > 
> > You can reduce the code size by moving this to be the first member.
> > Not sure about struct irq_sim_work_ctx, you can play with bloat-o-meter.
> 
> Pahole you meant?

No. I meant bloat-o-meter.

...

> But as Bartosz said in the other email, "it's just good practice
> resulting from years of" kernel coding to have:
>  - members declared strongly according to the logic of the code, and
>    if no strong preference: 

>  - list head be the first element of the structure, to let compiler
>    avoid generating offsets when traversing lists;

Exactly.

>  - put elements of greater size at the beginning, so no holes will be
>    emitted like in the example above.
> 
> So I'd suggest:
> 
>   struct irq_sim_irq_ctx {
>      struct list_head        siblings;
>      struct irq_sim_work_ctx *work_ctx;
>      int                     irqnum;
>      bool                    enabled;
>   }

Yes, I like this.

-- 
With Best Regards,
Andy Shevchenko


