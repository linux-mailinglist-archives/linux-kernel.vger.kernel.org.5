Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638E47728A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjHGPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjHGPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:07:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF91BFF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420789; x=1722956789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2c+nj8vIWoWHU5yXQEiQFKDo3Rw14j0iZrAqheVIpbc=;
  b=Rd0hVGKOLHh2Ggj/vbnCLDmUX6PKK1gGgPevNCU0BZptnMOKmOCSH/OF
   5e7S0Cws4y0C05v22NFnlePasq107baHqaX5ZAIyafpn6usEXm8IMNykq
   93pGKwQaPWkSmnRHUR3JzFo32ES6QWbgvE2zQ0cGUl0xkbqV5bOhyi5cw
   RCQdVVH5+/sjISuC4ts0AWND+5/NrX/HijUsBWbO3gvClCTD+p/gGq4/P
   bsjBQe9GM1axffVyb2h7m3U9/phWmVmEWLJyd8hf9k3woaKNOlEJFiCL5
   1TszsdFyju2RUubo/2g+rRmtgfNwY52sfpD4Z3kAkxkxdjPwzH78n4S8d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350876157"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="350876157"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766030293"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="766030293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 07 Aug 2023 08:06:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT1oO-00GdKa-2h;
        Mon, 07 Aug 2023 18:06:24 +0300
Date:   Mon, 7 Aug 2023 18:06:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 1/1] irqdomain: Refactor error path in
 __irq_domain_alloc_fwnode()
Message-ID: <ZNEIcDk7tQktPMGd@smile.fi.intel.com>
References: <20230804164932.40582-1-andriy.shevchenko@linux.intel.com>
 <84f2ea9ee0c08c8826c0f26c4a6291c9@kernel.org>
 <ZM1bm2+/lyb+IH86@smile.fi.intel.com>
 <86cz025tvh.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cz025tvh.wl-maz@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:24:02PM +0100, Marc Zyngier wrote:
> On Fri, 04 Aug 2023 21:12:11 +0100,
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Aug 04, 2023 at 06:33:07PM +0100, Marc Zyngier wrote:
> > > On 2023-08-04 17:49, Andy Shevchenko wrote:

...

> > > >  		n = kasprintf(GFP_KERNEL, "irqchip@%pa", pa);
> > > >  		break;
> > > >  	}
> > > > -
> > > > -	if (!fwid || !n) {
> > > > +	if (!n) {
> > > >  		kfree(fwid);
> > > > -		kfree(n);
> > > >  		return NULL;
> > > >  	}
> > > 
> > > What are you trying to fix?
> > 
> > I'm not trying to fix anything (there is no such statement from me),
> > but I would think of some micro-optimization (speedup boot for
> > unnoticeable time? Dunno.).
> 
> Error handling paths rarely qualify as an optimisation.

OK.

...

> > > We have a common error handling path, which makes it easy to
> > > track the memory management. I don't think this sort of bike
> > > shedding adds much to the maintainability of this code.
> > 
> > Your call, of course, but I not often see in the kernel two or three attempts
> > to allocate some memory and have grouped check for the failure.
> 
> Things like this[1]?

Yes.

> Well, this is a pattern I use often enough. Maybe
> it isn't everybody's taste, but it suits me.

Understand. Thanks for review!

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-gic-v3-its.c#n3438

-- 
With Best Regards,
Andy Shevchenko


