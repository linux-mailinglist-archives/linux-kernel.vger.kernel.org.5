Return-Path: <linux-kernel+bounces-65319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4E854B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC613B224B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FB55C3C;
	Wed, 14 Feb 2024 14:08:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B454BE9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919711; cv=none; b=uuEMOyAnQIyApU63ytbGGJGlYrol220Npvugkggy/uT6CFePdmArakFhhNbOChZ5yv8YdhIHtMTxY4M+QnOjzv5Z7in9USeD0L2uZ+WGtX0tnh8sYLeFh3M4afhoZssvgtWAgb8hXG3UaE3iR7SP935KJgUKKJKZoAPOVMwA9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919711; c=relaxed/simple;
	bh=GVhI7fpwupHeVjQBeVFrJG0s69SDhUbykzEZVqG2L00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLP4Fly8na6RwQn5NX+MRT4cjJRg1NRqqgdfyHWa77QS6rj3bXF4JMWwIgvkGs/s8bcMnsE8u6B+XNXIVY4xyeu5+hSg9pBQM7L1tFU2bvaGeA3er3i/OZNAG606a9gsDTaV24BzmeCzHCgCqH5BsVkl9DEx3xSgVdhhswJv1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD8281FB;
	Wed, 14 Feb 2024 06:09:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6043F5A1;
	Wed, 14 Feb 2024 06:08:22 -0800 (PST)
Date: Wed, 14 Feb 2024 14:08:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 03/30] thread_info: tif_need_resched() now takes
 resched_t as param
Message-ID: <ZczJU8uZdbRKvcAE@FVFF77S0Q05N>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213055554.1802415-4-ankur.a.arora@oracle.com>

On Mon, Feb 12, 2024 at 09:55:27PM -0800, Ankur Arora wrote:
> tif_need_resched() now takes a resched_t parameter to decide the
> immediacy of the need-resched.

I see at the end of the series, most callers pass a constant:

[mark@lakrids:~/src/linux]% git grep -w tif_need_resched
arch/s390/include/asm/preempt.h:        return !--S390_lowcore.preempt_count && tif_need_resched(NR_now);
arch/s390/include/asm/preempt.h:                        tif_need_resched(NR_now));
include/asm-generic/preempt.h:  return !--*preempt_count_ptr() && tif_need_resched(NR_now);
include/asm-generic/preempt.h:                  tif_need_resched(NR_now));
include/linux/preempt.h:        if (tif_need_resched(NR_now)) \
include/linux/sched.h:  return unlikely(tif_need_resched(NR_now));
include/linux/sched.h:          unlikely(tif_need_resched(NR_lazy));
include/linux/thread_info.h:static __always_inline bool tif_need_resched(resched_t rs)
include/linux/thread_info.h:     * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
kernel/entry/common.c:          if (tif_need_resched(NR_now))
kernel/sched/debug.c:   nr = tif_need_resched(NR_now) ? "need_resched" : "need_resched_lazy";
kernel/trace/trace.c:   if (tif_need_resched(NR_now))
kernel/trace/trace.c:   if (tif_need_resched(NR_lazy))

I think it'd be clearer if we had tif_need_resched_now() and
tif_need_resched_lazy() wrappers rather than taking a parameter. I think that
if we did similar elsewhere (e.g. {set,test}_tsk_need_resched_{now,lazy}()),
it'd be a bit cleaner overall, since we can special-case the lazy behaviour
more easily/clearly.

> Update need_resched() and should_resched() so they both check for
> tif_need_resched(NR_now), which keeps the current semantics. Also
> define need_resched_lazy(), which as the name suggests, checks for
> tif_need_resched(NR_lazy).
>
> Given that need_resched() (and should_resched() to a lesser extent)
> are used extensively in the kernel, it is worth noting their common
> uses and any changes to them:
> 
>  - preempt_count(): we only ever want to fold or make preemption
>    decisions based on TIF_NEED_RESCHED, not TIF_NEED_RESCHED_LAZY.
>    So, related logic now uses tif_need_resched(NR_now).
> 
>  - cond_resched_*(): checks for should_resched() and preempts if
>    TIF_NEED_RESCHED were set (and if (preempt_count() == offset).
> 
>    Hand-rolled versions typically first check for need_resched()
>    which would also continue to check for the same thing.
> 
>    So, in either case relinquish resources only if immediate
>    rescheduling was needed, not for lazy-rescheduling.
> 
>  - idle: run to completion is not meaningful for the idle task and
>    so we always schedule out of idle whenever there is any work.
> 
>    Most idle code uses a mixture of tif_need_resched() and
>    need_resched() (the first one especially in the interfaces defined
>    in sched/idle.h.)
> 
>    This change moves all the idle code to need_resched().
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
> Note that the need_resched() semantics here are narrower than
> earlier versions of this code.
> 
>   In previous versions, need_resched() checked for
>   (tif_need_resched(NR_now) || tif_need_resched(NR_lazy)).
> 
>   However, there's a fair bit of code which relinquishes resources
>   temporarily based on need_resched()/should_resched() checks. Or,
>   in the case of mutex_can_spin_on_owner() decides to optimistically
>   spin or not based on need_resched().
> 
>   So, this version limits need_resched() to only checking
>   TIF_NEED_RESCHED.
> 
>  arch/s390/include/asm/preempt.h |  4 ++--
>  drivers/acpi/processor_idle.c   |  2 +-
>  include/asm-generic/preempt.h   |  4 ++--
>  include/linux/preempt.h         |  2 +-
>  include/linux/sched.h           |  7 ++++++-
>  include/linux/sched/idle.h      |  8 ++++----
>  include/linux/thread_info.h     | 25 +++++++++++++++++++------
>  kernel/sched/idle.c             |  2 +-
>  kernel/trace/trace.c            |  2 +-
>  9 files changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
> index bf15da0fedbc..97fda8e06b6c 100644
> --- a/arch/s390/include/asm/preempt.h
> +++ b/arch/s390/include/asm/preempt.h
> @@ -114,13 +114,13 @@ static inline void __preempt_count_sub(int val)
>  
>  static inline bool __preempt_count_dec_and_test(void)
>  {
> -	return !--S390_lowcore.preempt_count && tif_need_resched();
> +	return !--S390_lowcore.preempt_count && tif_need_resched(NR_now);
>  }
>  
>  static inline bool should_resched(int preempt_offset)
>  {
>  	return unlikely(preempt_count() == preempt_offset &&
> -			tif_need_resched());
> +			tif_need_resched(NR_now));
>  }
>  
>  #endif /* CONFIG_HAVE_MARCH_Z196_FEATURES */
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 55437f5e0c3a..7fc47007b926 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -108,7 +108,7 @@ static const struct dmi_system_id processor_power_dmi_table[] = {
>   */
>  static void __cpuidle acpi_safe_halt(void)
>  {
> -	if (!tif_need_resched()) {
> +	if (!need_resched()) {
>  		raw_safe_halt();
>  		raw_local_irq_disable();
>  	}
> diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
> index 51f8f3881523..ed98e6168b99 100644
> --- a/include/asm-generic/preempt.h
> +++ b/include/asm-generic/preempt.h
> @@ -66,7 +66,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
>  	 * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
>  	 * lost.
>  	 */
> -	return !--*preempt_count_ptr() && tif_need_resched();
> +	return !--*preempt_count_ptr() && tif_need_resched(NR_now);
>  }
>  
>  /*
> @@ -75,7 +75,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
>  static __always_inline bool should_resched(int preempt_offset)
>  {
>  	return unlikely(preempt_count() == preempt_offset &&
> -			tif_need_resched());
> +			tif_need_resched(NR_now));
>  }
>  
>  #ifdef CONFIG_PREEMPTION
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 7233e9cf1bab..336cb76f0830 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -312,7 +312,7 @@ do { \
>  } while (0)
>  #define preempt_fold_need_resched() \
>  do { \
> -	if (tif_need_resched()) \
> +	if (tif_need_resched(NR_now)) \
>  		set_preempt_need_resched(); \
>  } while (0)
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index cdb8ea53c365..7a22a56350bb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2099,7 +2099,12 @@ static inline bool preempt_model_preemptible(void)
>  
>  static __always_inline bool need_resched(void)
>  {
> -	return unlikely(tif_need_resched());
> +	return unlikely(tif_need_resched(NR_now));
> +}
> +
> +static __always_inline bool need_resched_lazy(void)
> +{
> +	return unlikely(tif_need_resched(NR_lazy));
>  }
>  
>  /*
> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> index 478084f9105e..d8ce85dff47a 100644
> --- a/include/linux/sched/idle.h
> +++ b/include/linux/sched/idle.h
> @@ -63,7 +63,7 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
>  	 */
>  	smp_mb__after_atomic();
>  
> -	return unlikely(tif_need_resched());
> +	return need_resched();
>  }
>  
>  static __always_inline bool __must_check current_clr_polling_and_test(void)
> @@ -76,7 +76,7 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
>  	 */
>  	smp_mb__after_atomic();
>  
> -	return unlikely(tif_need_resched());
> +	return unlikely(need_resched());
>  }
>  
>  #else
> @@ -85,11 +85,11 @@ static inline void __current_clr_polling(void) { }
>  
>  static inline bool __must_check current_set_polling_and_test(void)
>  {
> -	return unlikely(tif_need_resched());
> +	return unlikely(need_resched());
>  }
>  static inline bool __must_check current_clr_polling_and_test(void)
>  {
> -	return unlikely(tif_need_resched());
> +	return unlikely(need_resched());
>  }
>  #endif
>  
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 99043cbbb6b0..8752dbc2dac7 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -211,22 +211,35 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
>  
>  #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
>  
> -static __always_inline bool tif_need_resched(void)
> +static __always_inline bool __tif_need_resched(int nr_flag)
>  {
> -	return arch_test_bit(TIF_NEED_RESCHED,
> -			     (unsigned long *)(&current_thread_info()->flags));
> +	return arch_test_bit(nr_flag,
> +		     (unsigned long *)(&current_thread_info()->flags));
>  }
>  
>  #else
>  
> -static __always_inline bool tif_need_resched(void)
> +static __always_inline bool __tif_need_resched(int nr_flag)
>  {
> -	return test_bit(TIF_NEED_RESCHED,
> -			(unsigned long *)(&current_thread_info()->flags));
> +	return test_bit(nr_flag,
> +		(unsigned long *)(&current_thread_info()->flags));
>  }
>  
>  #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>  
> +static __always_inline bool tif_need_resched(resched_t rs)
> +{
> +	/*
> +	 * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
> +	 * as TIF_NEED_RESCHED (the TIF_NEED_RESCHED_LAZY flag is not
> +	 * defined). Return false in that case.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
> +		return __tif_need_resched(tif_resched(rs));
> +	else
> +		return false;
> +}

As above, I think this would be a bit simpler/clearer if we did:

static __always_inline bool tif_need_resched_now(void)
{
	return __tif_need_resched(TIF_NEED_RESCHED);
}

static __always_inline bool tif_need_resched_lazy(void)
{
	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
	        __tif_need_resched(TIF_NEED_RESCHED_LAZY);
}

Mark.

> +
>  #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
>  static inline int arch_within_stack_frames(const void * const stack,
>  					   const void * const stackend,
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 31231925f1ec..be53d164e267 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -57,7 +57,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
>  	ct_cpuidle_enter();
>  
>  	raw_local_irq_enable();
> -	while (!tif_need_resched() &&
> +	while (!need_resched() &&
>  	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
>  		cpu_relax();
>  	raw_local_irq_disable();
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a7c6fd934e9..0a9642fba852 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2701,7 +2701,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
>  	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
>  		trace_flags |= TRACE_FLAG_BH_OFF;
>  
> -	if (tif_need_resched())
> +	if (tif_need_resched(NR_now))
>  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
>  	if (test_preempt_need_resched())
>  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
> -- 
> 2.31.1
> 

