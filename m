Return-Path: <linux-kernel+bounces-58428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580584E667
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCE7287AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2138174B;
	Thu,  8 Feb 2024 17:12:24 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171C80058;
	Thu,  8 Feb 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412343; cv=none; b=TvWQ5mFPCyufTy6P/Hk4ZBhYlzhdhaqE+exZvW07ppGYUr/fCEspGQsNq/Oh++yk4Sd2L7Y++vDdirNZyEMvNJQsvSVePOadFyjrG7FQtqxVoPVEvYFl+AAWK0toD7kJ8smSFR1JnLw3K+PyMmY6wiawpUV3qgU/WhUtuBLNYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412343; c=relaxed/simple;
	bh=ikmrajBjiS9pNbKrgcg+hLzP4loGkWGqrgxqEb0J8SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQ1wA/0vuQw2jr5FOuHy3loh+jYTEepz8RpWgTkDfuaBG/lyFxS7ygMA2InQ2ez76cOguPuAxPlNvhxq2il5X7Rq3TmVN/RHVOPzgMOsBTtTaqcSEcPZTEMzhO6usaCt0afkp+VAN43eAGfsGXIwEPFbETLpbq31lyws8NkUfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id F363EFF802;
	Thu,  8 Feb 2024 17:12:06 +0000 (UTC)
Message-ID: <f3095c09-74db-4a0a-b53e-68ce58ef5ba8@ghiti.fr>
Date: Thu, 8 Feb 2024 18:12:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20240124-fencei-v10-0-a25971f4301d@rivosinc.com>
 <20240124-fencei-v10-1-a25971f4301d@rivosinc.com>
 <5849b66f-d7c4-4011-b556-10725ac0958e@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <5849b66f-d7c4-4011-b556-10725ac0958e@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 07/02/2024 19:55, Samuel Holland wrote:
> Hi Charlie,
>
> On 2024-01-24 10:23 PM, Charlie Jenkins wrote:
>> Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
>> optimization of cross modifying code. This prctl enables userspace code
>> to use icache flushing instructions such as fence.i with the guarantee
>> that the icache will continue to be clean after thread migration.
>>
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/mmu.h       |  2 ++
>>   arch/riscv/include/asm/processor.h |  7 ++++
>>   arch/riscv/include/asm/switch_to.h | 13 ++++++++
>>   arch/riscv/mm/cacheflush.c         | 67 ++++++++++++++++++++++++++++++++++++++
>>   arch/riscv/mm/context.c            | 13 ++++++--
>>   include/uapi/linux/prctl.h         |  6 ++++
>>   kernel/sys.c                       |  6 ++++
>>   7 files changed, 111 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
>> index 355504b37f8e..60be458e94da 100644
>> --- a/arch/riscv/include/asm/mmu.h
>> +++ b/arch/riscv/include/asm/mmu.h
>> @@ -19,6 +19,8 @@ typedef struct {
>>   #ifdef CONFIG_SMP
>>   	/* A local icache flush is needed before user execution can resume. */
>>   	cpumask_t icache_stale_mask;
>> +	/* Force local icache flush on all migrations. */
>> +	bool force_icache_flush;
>>   #endif
>>   #ifdef CONFIG_BINFMT_ELF_FDPIC
>>   	unsigned long exec_fdpic_loadmap;
>> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>> index a8509cc31ab2..816cdc2395f4 100644
>> --- a/arch/riscv/include/asm/processor.h
>> +++ b/arch/riscv/include/asm/processor.h
>> @@ -123,6 +123,10 @@ struct thread_struct {
>>   	struct __riscv_v_ext_state vstate;
>>   	unsigned long align_ctl;
>>   	struct __riscv_v_ext_state kernel_vstate;
>> +#ifdef CONFIG_SMP
>> +	bool force_icache_flush;
>> +	unsigned int prev_cpu;
>> +#endif
>>   };
>>   
>>   /* Whitelist the fstate from the task_struct for hardened usercopy */
>> @@ -184,6 +188,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
>>   #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
>>   #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
>>   
>> +#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
>> +extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
>> +
>>   #endif /* __ASSEMBLY__ */
>>   
>>   #endif /* _ASM_RISCV_PROCESSOR_H */
>> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
>> index 7efdb0584d47..ac99ab64499c 100644
>> --- a/arch/riscv/include/asm/switch_to.h
>> +++ b/arch/riscv/include/asm/switch_to.h
>> @@ -8,6 +8,7 @@
>>   
>>   #include <linux/jump_label.h>
>>   #include <linux/sched/task_stack.h>
>> +#include <linux/mm_types.h>
>>   #include <asm/vector.h>
>>   #include <asm/cpufeature.h>
>>   #include <asm/processor.h>
>> @@ -72,14 +73,26 @@ static __always_inline bool has_fpu(void) { return false; }
>>   extern struct task_struct *__switch_to(struct task_struct *,
>>   				       struct task_struct *);
>>   
>> +static inline bool switch_to_should_flush_icache(struct task_struct *task)
>> +{
>> +	bool stale_mm = task->mm && (task->mm->context.force_icache_flush);
> No parentheses needed here.
>
>> +	bool stale_thread = task->thread.force_icache_flush;
>> +	bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
> This fails to compile when SMP is disabled:
>
> In file included from arch/riscv/kernel/ptrace.c:14:
> ./arch/riscv/include/asm/switch_to.h:78:49: error: no member named
> 'force_icache_flush' in 'mm_context_t'
>          bool stale_mm = task->mm && (task->mm->context.force_icache_flush);
>                                       ~~~~~~~~~~~~~~~~~ ^
> ./arch/riscv/include/asm/switch_to.h:79:35: error: no member named
> 'force_icache_flush' in 'struct thread_struct'
>          bool stale_thread = task->thread.force_icache_flush;
>                              ~~~~~~~~~~~~ ^
> ./arch/riscv/include/asm/switch_to.h:80:60: error: no member named 'prev_cpu' in
> 'struct thread_struct'
>          bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
>                                                       ~~~~~~~~~~~~ ^
>    CC      arch/riscv/kernel/sys_hwprobe.o
>
>> +
>> +	return thread_migrated && (stale_mm || stale_thread);
>> +}
>> +
>>   #define switch_to(prev, next, last)			\
>>   do {							\
>>   	struct task_struct *__prev = (prev);		\
>>   	struct task_struct *__next = (next);		\
>> +	__next->thread.prev_cpu = smp_processor_id();	\
> Shouldn't this instead update __prev (the task being scheduled out)?

We need to know what was the last cpu a task was executed on, so either 
we store this info before it gets scheduled (what we do here) or when it 
is about to get scheduled out, to me that makes no difference.


>
>>   	if (has_fpu())					\
>>   		__switch_to_fpu(__prev, __next);	\
>>   	if (has_vector())					\
>>   		__switch_to_vector(__prev, __next);	\
>> +	if (switch_to_should_flush_icache(__next))	\
>> +		local_flush_icache_all();		\
>>   	((last) = __switch_to(__prev, __next));		\
>>   } while (0)
>>   
>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>> index 55a34f2020a8..2d5e1575f6c1 100644
>> --- a/arch/riscv/mm/cacheflush.c
>> +++ b/arch/riscv/mm/cacheflush.c
>> @@ -5,6 +5,7 @@
>>   
>>   #include <linux/acpi.h>
>>   #include <linux/of.h>
>> +#include <linux/prctl.h>
>>   #include <asm/acpi.h>
>>   #include <asm/cacheflush.h>
>>   
>> @@ -152,3 +153,69 @@ void __init riscv_init_cbo_blocksizes(void)
>>   	if (cboz_block_size)
>>   		riscv_cboz_block_size = cboz_block_size;
>>   }
>> +
>> +/**
>> + * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instructions in
>> + * userspace.
>> + * @ctx: Set the type of icache flushing instructions permitted/prohibited in
>> + *	 userspace. Supported values described below.
>> + *
>> + * Supported values for ctx:
>> + *
>> + * * %PR_RISCV_CTX_SW_FENCEI_ON: Allow fence.i in userspace.
>> + *
>> + * * %PR_RISCV_CTX_SW_FENCEI_OFF: Disallow fence.i in userspace. All threads in
>> + *   a process will be affected when ``scope == PR_RISCV_SCOPE_PER_PROCESS``.
>> + *   Therefore, caution must be taken -- only use this flag when you can
>> + *   guarantee that no thread in the process will emit fence.i from this point
>> + *   onward.
>> + *
>> + * @scope: Set scope of where icache flushing instructions are allowed to be
>> + *	   emitted. Supported values described below.
>> + *
>> + * Supported values for scope:
>> + *
>> + * * %PR_RISCV_SCOPE_PER_PROCESS: Ensure the icache of any thread in this process
>> + *                               is coherent with instruction storage upon
>> + *                               migration.
>> + *
>> + * * %PR_RISCV_SCOPE_PER_THREAD: Ensure the icache of the current thread is
>> + *                              coherent with instruction storage upon
>> + *                              migration.
>> + *
>> + * When ``scope == PR_RISCV_SCOPE_PER_PROCESS``, all threads in the process are
>> + * permitted to emit icache flushing instructions. Whenever any thread in the
>> + * process is migrated, the corresponding hart's icache will be guaranteed to be
>> + * consistent with instruction storage. Note this does not enforce any
>> + * guarantees outside of migration. If a thread modifies an instruction that
>> + * another thread may attempt to execute, the other thread must still emit an
>> + * icache flushing instruction before attempting to execute the potentially
>> + * modified instruction. This must be performed by the userspace program.
>> + *
>> + * In per-thread context (eg. ``scope == PR_RISCV_SCOPE_PER_THREAD``), only the
>> + * thread calling this function is permitted to emit icache flushing
>> + * instructions. When the thread is migrated, the corresponding hart's icache
>> + * will be guaranteed to be consistent with instruction storage.
>> + *
>> + * On kernels configured without SMP, this function is a nop as migrations
>> + * across harts will not occur.
>> + */
>> +int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
>> +{
>> +#ifdef CONFIG_SMP
>> +	switch (ctx) {
>> +	case PR_RISCV_CTX_SW_FENCEI_ON:
>> +		switch (scope) {
>> +		case PR_RISCV_SCOPE_PER_PROCESS:
>> +			current->mm->context.force_icache_flush = true;
>> +			break;
>> +		case PR_RISCV_SCOPE_PER_THREAD:
>> +			current->thread.force_icache_flush = true;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
> At some point you dropped the implementation for PR_RISCV_CTX_SW_FENCEI_OFF.
> It's still documented, so I don't think that was intentional.
>
> Also, PR_RISCV_CTX_SW_FENCEI_OFF needs to mark the icache on all other CPUs as
> stale, as in flush_icache_mm(). Consider the following sequence:
>   1. Migrate from CPU A to CPU B
>   2. CMODX on CPU B
>   3. fence.i in userspace on CPU B
>   4. prctl(PR_RISCV_CTX_SW_FENCEI_OFF) on CPU B
>   5. Migrate back to CPU A -- force_icache_flush is false, no flush happens
>   6. Execute the modified code -- fails, because CPU A's I$ never got flushed
>
>> +	}
>> +#endif
>> +	return 0;
> This makes the prtcl() call silently succeed for invalid ctx values, whereas it
> should fail for those instead.
>
> Regards,
> Samuel
>
>> +}
>> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
>> index 217fd4de6134..5cabbc449080 100644
>> --- a/arch/riscv/mm/context.c
>> +++ b/arch/riscv/mm/context.c
>> @@ -15,6 +15,7 @@
>>   #include <asm/tlbflush.h>
>>   #include <asm/cacheflush.h>
>>   #include <asm/mmu_context.h>
>> +#include <asm/switch_to.h>
>>   
>>   #ifdef CONFIG_MMU
>>   
>> @@ -297,7 +298,8 @@ static inline void set_mm(struct mm_struct *prev,
>>    *
>>    * The "cpu" argument must be the current local CPU number.
>>    */
>> -static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
>> +static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
>> +					 struct task_struct *task)
>>   {
>>   #ifdef CONFIG_SMP
>>   	cpumask_t *mask = &mm->context.icache_stale_mask;
>> @@ -309,7 +311,12 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
>>   		 * This pairs with a barrier in flush_icache_mm.
>>   		 */
>>   		smp_mb();
>> -		local_flush_icache_all();
>> +
>> +		/*
>> +		 * If cache will be flushed in switch_to, no need to flush here.
>> +		 */
>> +		if (!(task && switch_to_should_flush_icache(task)))
>> +			local_flush_icache_all();
>>   	}
>>   
>>   #endif
>> @@ -332,5 +339,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>   
>>   	set_mm(prev, next, cpu);
>>   
>> -	flush_icache_deferred(next, cpu);
>> +	flush_icache_deferred(next, cpu, task);
>>   }
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 370ed14b1ae0..524d546d697b 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -306,4 +306,10 @@ struct prctl_mm_map {
>>   # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
>>   # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
>>   
>> +#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
>> +# define PR_RISCV_CTX_SW_FENCEI_ON	0
>> +# define PR_RISCV_CTX_SW_FENCEI_OFF	1
>> +# define PR_RISCV_SCOPE_PER_PROCESS	0
>> +# define PR_RISCV_SCOPE_PER_THREAD	1
>> +
>>   #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index e219fcfa112d..69afdd8b430f 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -146,6 +146,9 @@
>>   #ifndef RISCV_V_GET_CONTROL
>>   # define RISCV_V_GET_CONTROL()		(-EINVAL)
>>   #endif
>> +#ifndef RISCV_SET_ICACHE_FLUSH_CTX
>> +# define RISCV_SET_ICACHE_FLUSH_CTX(a, b)	(-EINVAL)
>> +#endif
>>   
>>   /*
>>    * this is where the system-wide overflow UID and GID are defined, for
>> @@ -2743,6 +2746,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>   	case PR_RISCV_V_GET_CONTROL:
>>   		error = RISCV_V_GET_CONTROL();
>>   		break;
>> +	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
>> +		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>> +		break;
>>   	default:
>>   		error = -EINVAL;
>>   		break;
>>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

