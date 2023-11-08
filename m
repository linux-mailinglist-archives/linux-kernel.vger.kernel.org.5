Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69F7E52F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKHJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:59:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006591BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sn3OfzVlyBbtRSdn9Yn/q14IvVXQuQu5C9ul2NWMZe8=; b=jbnHMjVJNLD07fWvagwdbW+y70
        4Yoh2EcQhAnGy6AFksbwjYn2h2WEAGSvctl7KqPkPc1uLjcpL9+SrhdE7Az0eSbtSyr7Wlrp3PMCc
        4bgyle2kEk68Z3zkgujBK7anh+hIFIS2AEPMd/BAfkqrHSccVDnv0LP0ODbFv1lrPO/fEaqsYgwUj
        VYDTwmlFSBK1VeTDTiO8LtVQ0+dozDeFBkpVXhuHAdrkuo6pl9S8ncPEQ6JZyqj8kjZ1xcCE3qNeD
        L2KVaVwgFj/Zw+2oLfYDYXsuZlvqM4n9cXADOGypybuu21xZbB3ye09roXHNNqIwjv2f1vwcZQ5ee
        SGmm9jmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0fKC-00DOlL-1a;
        Wed, 08 Nov 2023 09:58:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C4DC30049D; Wed,  8 Nov 2023 10:58:16 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:58:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 43/86] sched: enable PREEMPT_COUNT, PREEMPTION for
 all preemption models
Message-ID: <20231108095816.GN8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-44-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-44-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:29PM -0800, Ankur Arora wrote:
> The scheduler uses PREEMPT_COUNT and PREEMPTION to drive
> preemption: the first to demarcate non-preemptible sections and
> the second for the actual mechanics of preemption.
> 
> Enable both for voluntary preemption models.
> 
> In addition, define a new scheduler feature FORCE_PREEMPT which
> can now be used to distinguish between voluntary and full
> preemption models at runtime.
> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  init/Makefile           |  2 +-
>  kernel/Kconfig.preempt  | 12 ++++++++----
>  kernel/entry/common.c   |  3 +--
>  kernel/sched/core.c     | 26 +++++++++++---------------
>  kernel/sched/features.h |  6 ++++++
>  5 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/init/Makefile b/init/Makefile
> index 385fd80fa2ef..99e480f24cf3 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -24,7 +24,7 @@ mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
>  #
>  
>  smp-flag-$(CONFIG_SMP)			:= SMP
> -preempt-flag-$(CONFIG_PREEMPT)          := PREEMPT
> +preempt-flag-$(CONFIG_PREEMPTION)       := PREEMPT_DYNAMIC
>  preempt-flag-$(CONFIG_PREEMPT_RT)	:= PREEMPT_RT
>  
>  build-version = $(or $(KBUILD_BUILD_VERSION), $(build-version-auto))
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index aa87b5cd3ecc..074fe5e253b5 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -6,20 +6,23 @@ choice
>  
>  config PREEMPT_NONE
>  	bool "No Forced Preemption (Server)"
> +	select PREEMPTION
>  	help
>  	  This is the traditional Linux preemption model, geared towards
>  	  throughput. It will still provide good latencies most of the
> -	  time, but there are no guarantees and occasional longer delays
> -	  are possible.
> +	  time, but occasional delays are possible.
>  
>  	  Select this option if you are building a kernel for a server or
>  	  scientific/computation system, or if you want to maximize the
>  	  raw processing power of the kernel, irrespective of scheduling
> -	  latencies.
> +	  latencies. Unless your architecture actively disables preemption,
> +	  you can always switch to one of the other preemption models
> +	  at runtime.


> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 6433e6c77185..f7f2efabb5b5 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -422,8 +422,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  		}
>  
>  		instrumentation_begin();
> -		if (IS_ENABLED(CONFIG_PREEMPTION))
> -			irqentry_exit_cond_resched();
> +		irqentry_exit_cond_resched();
>  		/* Covers both tracing and lockdep */
>  		trace_hardirqs_on();
>  		instrumentation_end();

I'm totally confused by the PREEMPT_NONE changes here. How does that
make sense?
