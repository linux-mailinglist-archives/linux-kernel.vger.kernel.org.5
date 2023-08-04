Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BAB770984
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjHDUMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHDUMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:12:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B36A3A8C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691179935; x=1722715935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+hQ4vNpCTz70OaKtz2FBTdqtkBD+Xe76/s5giJCLmwg=;
  b=ORpv5c7SSnAZpNVq5QnFpc3d+hWizjlRfOVGTG0BOR7+aoqVMzsTqKAZ
   /hAe2GdWEt1r5qVZix/AZGpfGRG/gOKzOKk53v953hRPTzGzYDWplNoyd
   byyrs3c1qm/Pm5da2efc7rXNcB5ZQjAhtUK59UMDGY7y0qYik25YzTYNl
   6IpMbjb3Sn8UI+cHC+U/scPnx6Dk8+5DwNawWXqibvyh9lSKHc+esI6Nu
   85S7u2/YSh1dCCeuv+hbwLGpp1vqUYgxD2poKWrA8QreS07+oSOKC5EaS
   5Ii50pFyKblWxO2bnHEkI65BTW7dJv2xHt3iZ2v/kSC59OyCtpbQ93B2G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="436561933"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="436561933"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="765239145"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="765239145"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 13:12:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qS19g-006GOO-06;
        Fri, 04 Aug 2023 23:12:12 +0300
Date:   Fri, 4 Aug 2023 23:12:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 1/1] irqdomain: Refactor error path in
 __irq_domain_alloc_fwnode()
Message-ID: <ZM1bm2+/lyb+IH86@smile.fi.intel.com>
References: <20230804164932.40582-1-andriy.shevchenko@linux.intel.com>
 <84f2ea9ee0c08c8826c0f26c4a6291c9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f2ea9ee0c08c8826c0f26c4a6291c9@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 06:33:07PM +0100, Marc Zyngier wrote:
> On 2023-08-04 17:49, Andy Shevchenko wrote:
> > First of all, there is no need to call kasprintf() if the previous
> > allocation failed. Second, there is no need to call for kfree()
> > when we know that its parameter is NULL. Refactor the code accordingly.

...

> >  		n = kasprintf(GFP_KERNEL, "irqchip@%pa", pa);
> >  		break;
> >  	}
> > -
> > -	if (!fwid || !n) {
> > +	if (!n) {
> >  		kfree(fwid);
> > -		kfree(n);
> >  		return NULL;
> >  	}
> 
> What are you trying to fix?

I'm not trying to fix anything (there is no such statement from me),
but I would think of some micro-optimization (speedup boot for
unnoticeable time? Dunno.).

> We have a common error handling path, which makes it easy to
> track the memory management. I don't think this sort of bike
> shedding adds much to the maintainability of this code.

Your call, of course, but I not often see in the kernel two or three attempts
to allocate some memory and have grouped check for the failure.

> Now if you have spotted an actual bug, I'm all ears.

-- 
With Best Regards,
Andy Shevchenko


