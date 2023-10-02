Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D21D7B54EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbjJBOOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbjJBOOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:14:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A0A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:14:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAD8C433C8;
        Mon,  2 Oct 2023 14:14:11 +0000 (UTC)
Date:   Mon, 2 Oct 2023 10:15:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20231002101514.44b9c812@gandalf.local.home>
In-Reply-To: <87jzshhexi.ffs@tglx>
References: <87ttrngmq0.ffs@tglx>
        <87jzshhexi.ffs@tglx>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2023 03:11:05 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Though definitely I'm putting a permanent NAK in place for any attempts
> to duct tape the preempt=NONE model any further by sprinkling more
> cond*() and whatever warts around.

Well, until we have this fix in, we will still need to sprinkle those
around when they are triggering watchdog timeouts. I just had to add one
recently due to a timeout report :-(




> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2722,6 +2722,8 @@ unsigned int tracing_gen_ctx_irq_test(un
>  
>  	if (tif_need_resched())
>  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
> +	if (tif_need_resched_lazy())
> +		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
>  	if (test_preempt_need_resched())
>  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
>  	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |

> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -178,8 +178,8 @@ unsigned int tracing_gen_ctx_irq_test(un
>  
>  enum trace_flag_type {
>  	TRACE_FLAG_IRQS_OFF		= 0x01,
> -	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,

I never cared for that NOSUPPORT flag. It's from 2008 and only used by
archs that do not support irq tracing (aka lockdep). I'm fine with dropping
it and just updating the user space libraries (which will no longer see it
not supported, but that's fine with me).

> -	TRACE_FLAG_NEED_RESCHED		= 0x04,
> +	TRACE_FLAG_NEED_RESCHED		= 0x02,
> +	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,

Is LAZY only used for PREEMPT_NONE? Or do we use it for CONFIG_PREEMPT?
Because, NEED_RESCHED is known, and moving that to bit 2 will break user
space. Having LAZY replace the IRQS_NOSUPPORT will cause the least
"breakage".

-- Steve

>  	TRACE_FLAG_HARDIRQ		= 0x08,
>  	TRACE_FLAG_SOFTIRQ		= 0x10,
>  	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
> @@ -205,11 +205,11 @@ static inline unsigned int tracing_gen_c
>  
>  static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
>  {
> -	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
> +	return tracing_gen_ctx_irq_test(0);
>  }
>  static inline unsigned int tracing_gen_ctx(void)
>  {
> -	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
> +	return tracing_gen_ctx_irq_test(0);
>  }
>  #endif
>  
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -460,17 +460,29 @@ int trace_print_lat_fmt(struct trace_seq
>  		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
>  		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
>  		bh_off ? 'b' :
> -		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
> +		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
>  		'.';
>  
> -	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
> +	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
>  				TRACE_FLAG_PREEMPT_RESCHED)) {
> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> +		need_resched = 'B';
> +		break;
>  	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
>  		need_resched = 'N';
>  		break;
> +	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> +		need_resched = 'L';
> +		break;
> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
> +		need_resched = 'b';
> +		break;
>  	case TRACE_FLAG_NEED_RESCHED:
>  		need_resched = 'n';
>  		break;
> +	case TRACE_FLAG_NEED_RESCHED_LAZY:
> +		need_resched = 'l';
> +		break;
>  	case TRACE_FLAG_PREEMPT_RESCHED:
>  		need_resched = 'p';
>  		break;
