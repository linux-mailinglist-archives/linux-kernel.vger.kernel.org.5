Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9497E5A66
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjKHPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjKHPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:45:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 095C01FEF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:45:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39CF11476;
        Wed,  8 Nov 2023 07:46:09 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 819713F64C;
        Wed,  8 Nov 2023 07:45:19 -0800 (PST)
Date:   Wed, 8 Nov 2023 15:44:30 +0000
From:   Mark Rutland <mark.rutland@arm.com>
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 08/86] Revert "arm64: Support PREEMPT_DYNAMIC"
Message-ID: <ZUus3jr6gXV6ZG1T@FVFF77S0Q05N>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-9-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-9-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:56:54PM -0800, Ankur Arora wrote:
> This reverts commit 1b2d3451ee50a0968cb9933f726e50b368ba5073.

As the author of the commit being reverted, I'd appreciate being Cc'd on
subsequent versions of this patch (and ideally, for the series as a whole).

Mark.

> 
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
> -- 
> 2.31.1
> 
