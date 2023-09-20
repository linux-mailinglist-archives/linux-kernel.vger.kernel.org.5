Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999887A877F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbjITOrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbjITOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:47:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571341739
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695221146; x=1726757146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6bT0uqKFMEAc4J6f/2U70Tu3Ei/p6f9a6aUNh7tMdcE=;
  b=boFk79RbK1mghql58vaHiierxCATu44cE52Z/G2aUygmQHkkwTMrN8Lq
   l5LQ60+EVNokMf33MHfdDBhlUWvG0IiHdkmBfejcs3k94YFZ82HnIZ0pK
   Gzb7RkNNUc9Coz+n+yr0vQwPwiKnAPO8IUYYXsm6Suu1xxeNxh8wdmQXQ
   HzONoqlZUE5LbK8KvTaLTEOHxf09LG4lL3GdbEEeg1PcgComReB/n0/uI
   YCWgiK0t8tp+jsZ3NtlncLfQUr4GCw6D+lyvvwv19PxHFN+RGfoxTOoOR
   /qytrZhSwfeSppZiQJ+hkQ9KNnGdATzm6i392NzxvvduyfaydxOXPiJAd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466552178"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="466552178"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 07:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077458344"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077458344"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 07:45:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiySK-0000000FxGx-2dZv;
        Wed, 20 Sep 2023 17:45:32 +0300
Date:   Wed, 20 Sep 2023 17:45:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH printk v2 09/11] panic: Add atomic write enforcement to
 oops
Message-ID: <ZQsFjN5euQgt5CI7@smile.fi.intel.com>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-10-john.ogness@linutronix.de>
 <ZQrzhh62pDB5yUyi@smile.fi.intel.com>
 <871qetsz8j.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qetsz8j.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 04:26:12PM +0206, John Ogness wrote:
> On 2023-09-20, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Sep 20, 2023 at 01:14:54AM +0206, John Ogness wrote:

...

> >> +	if (atomic_read(&oops_cpu) == smp_processor_id()) {
> >> +		oops_nesting--;
> >> +		if (oops_nesting == 0) {
> >> +			atomic_set(&oops_cpu, -1);
> >
> > Between read and set the variable can change, can't it?
> 
> CPU migration is disabled. @oops_cpu contains the CPU ID of the only CPU
> that is printing the oops. (Perhaps the variable should be called
> "oops_printing_cpu"?)
> 
> If this matches smp_processor_id(), then the current CPU is the only one
> that is allowed to change it back to -1. So no, if the first condition
> is true, it cannot change before atomic_set(). And if the second
> condition is true, this is the only CPU+context that is allowed to
> change it back to -1;
> 
> > If not, why this variable is atomic then? Or, why it's not a problem?
> > If the latter is the case, perhaps a comment to explain this?
> 
> If not atomic, it will be a data race since one CPU might be changing
> @oops_cpu and another is reading it. For type "int" such a data race
> would be fine because it doesn't matter which side of the race the
> reader was on, both values will not match the current CPU ID.
> 
> The reason that I didn't implement it using cmpxchg(),
> data_race(READ_ONCE()), and WRITE_ONCE() is because I once learned that
> you should never mix cmpxchg() with READ_ONCE()/WRITE_ONCE() because
> there are architectures that do not support cmpxchg() as an atomic
> instruction. The answer was always: "use atomic_t instead... that is
> what it is for".
> 
> But AFAICT for this case it would be fine because obviously cmpxchg()
> will not race with itself. And successfully reading a matching CPU ID
> means there cannot be any cmpxchg() in progress. And writing only occurs
> after seeing a matching CPU ID.
> 
> So I can change it from atomic_t to int. Although I do feel like that
> might require explanation about why the data race is safe.

Either way a comment is needed, but I think the usage of atomic above
is a bit confusing as you see I immediately rose the concern.

> Or perhaps it is enough just to have something like this:
> 
> /**
>  * oops_printing_cpu - The ID of the CPU responsible for printing the
>  *                     OOPS message(s) to the consoles.
>  *
>  * This is atomic_t because multiple CPUs can read this variable
>  * simultaneously when exiting OOPS while another CPU can be
>  * modifying this variable to begin or end its printing duties.
>  */
> static atomic_t oops_printing_cpu = ATOMIC_INIT(-1);

-- 
With Best Regards,
Andy Shevchenko


