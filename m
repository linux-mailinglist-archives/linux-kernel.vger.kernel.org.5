Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E5A7E4C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjKGXRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjKGXRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:17:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0254C1BC0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:17:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1445C433CB;
        Tue,  7 Nov 2023 23:17:09 +0000 (UTC)
Date:   Tue, 7 Nov 2023 18:17:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 08/86] Revert "arm64: Support PREEMPT_DYNAMIC"
Message-ID: <20231107181712.28989b02@gandalf.local.home>
In-Reply-To: <20231107215742.363031-9-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-9-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:56:54 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> This reverts commit 1b2d3451ee50a0968cb9933f726e50b368ba5073.
> 

I just realized that the maintainers of these patches are not being Cc'd.
If you want comments, you may want to Cc them. (I didn't do that for this
patch).

-- Steve


> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/arm64/Kconfig               |  1 -
>  arch/arm64/include/asm/preempt.h | 19 ++-----------------
>  arch/arm64/kernel/entry-common.c | 10 +---------
>  3 files changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 78f20e632712..856d7be2ee45 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -221,7 +221,6 @@ config ARM64
>  	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> -	select HAVE_PREEMPT_DYNAMIC_KEY
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>  	select HAVE_FUNCTION_ARG_ACCESS_API
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> index 0159b625cc7f..e83f0982b99c 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -2,7 +2,6 @@
>  #ifndef __ASM_PREEMPT_H
>  #define __ASM_PREEMPT_H
>  
> -#include <linux/jump_label.h>
>  #include <linux/thread_info.h>
>  
>  #define PREEMPT_NEED_RESCHED	BIT(32)
> @@ -81,24 +80,10 @@ static inline bool should_resched(int preempt_offset)
>  }
>  
>  #ifdef CONFIG_PREEMPTION
> -
>  void preempt_schedule(void);
> +#define __preempt_schedule() preempt_schedule()
>  void preempt_schedule_notrace(void);
> -
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> -
> -DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -void dynamic_preempt_schedule(void);
> -#define __preempt_schedule()		dynamic_preempt_schedule()
> -void dynamic_preempt_schedule_notrace(void);
> -#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
> -
> -#else /* CONFIG_PREEMPT_DYNAMIC */
> -
> -#define __preempt_schedule()		preempt_schedule()
> -#define __preempt_schedule_notrace()	preempt_schedule_notrace()
> -
> -#endif /* CONFIG_PREEMPT_DYNAMIC */
> +#define __preempt_schedule_notrace() preempt_schedule_notrace()
>  #endif /* CONFIG_PREEMPTION */
>  
>  #endif /* __ASM_PREEMPT_H */
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 0fc94207e69a..5d9c9951562b 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -225,17 +225,9 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>  		lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -#define need_irq_preemption() \
> -	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> -#else
> -#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
> -#endif
> -
>  static void __sched arm64_preempt_schedule_irq(void)
>  {
> -	if (!need_irq_preemption())
> +	if (!IS_ENABLED(CONFIG_PREEMPTION))
>  		return;
>  
>  	/*

