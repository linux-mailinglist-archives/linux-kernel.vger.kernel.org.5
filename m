Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A077CB35
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjHOKjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbjHOKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:38:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BDF1736
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692095933; x=1723631933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CiioKECLe25zyP+6Cf9JgnYx6m5rHM/EGqAR0+WcDAY=;
  b=C9NkDe4XwoUmxQURyJB4sWiDqm6iJoXZdlecNwnkFiVpc+ECgChGwJ/z
   SbyyIhlyMQ1gBFg82TMWC6KEYyFRU3ggzbMvvHEdNYG4T9bJOFp+3aC7p
   nlg8XXNk/VKLgedLvQjuh/IjxU3IZWcP07K6K0nt9cHzVYWASDm56dxlS
   vrz84SOPv6A8/zdMR5jfCofcO9Ok6HF812yEjQMgcot7KHX/lAsxx/3/t
   j7o5A2A9JIavUBZBA3Z80ty6kIXrDtE9xpesDypvtQ9R0UplVFYprsdZo
   cNnRnR8S+aPgs6XhZol5TctqLLc369sKmdoG3z+i7xXMAUal9BDZGAfOH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357216070"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="357216070"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 03:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763233688"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763233688"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2023 03:38:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVrRq-00Ev6n-0L;
        Tue, 15 Aug 2023 13:38:50 +0300
Date:   Tue, 15 Aug 2023 13:38:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/4] genirq/irq_sim: dispose of remaining mappings before
 removing the domain
Message-ID: <ZNtVuUWTZa0gLwXz@smile.fi.intel.com>
References: <20230812194457.6432-1-brgl@bgdev.pl>
 <20230812194457.6432-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812194457.6432-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:44:54PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> If the device providing simulated interrupts is unbound (real life
> example: gpio-sim is disabled with users that didn't free their irqs)
> and removes the simulated domain while interrupts are still requested,
> we will hit memory issues when they are eventually freed and the
> mappings destroyed in the process.
> 
> Specifically we'll access freed memory in __irq_domain_deactivate_irq().
> 
> Dispose of all mappings before removing the simulator domain.

...

> +#include <linux/list.h>

Maybe ordered?

>  #include <linux/irq.h>
>  #include <linux/irq_sim.h>
>  #include <linux/irq_work.h>

...

> @@ -16,12 +17,14 @@ struct irq_sim_work_ctx {
>  	unsigned int		irq_count;
>  	unsigned long		*pending;
>  	struct irq_domain	*domain;
> +	struct list_head	irqs;
>  };
>  
>  struct irq_sim_irq_ctx {
>  	int			irqnum;
>  	bool			enabled;
>  	struct irq_sim_work_ctx	*work_ctx;

> +	struct list_head	siblings;

You can reduce the code size by moving this to be the first member.
Not sure about struct irq_sim_work_ctx, you can play with bloat-o-meter.

>  };

-- 
With Best Regards,
Andy Shevchenko


