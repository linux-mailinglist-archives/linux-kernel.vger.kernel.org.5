Return-Path: <linux-kernel+bounces-100697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C80C879C12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790371C22634
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B8A142623;
	Tue, 12 Mar 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yFoSLRbu"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285F1386B5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710270474; cv=none; b=EgKvYqjqJxTjEPgRhkwrkLxArtO+reCeXTODYCq47H8yVXjIhQjQclmcy48JzObG7NJ0hsnRNyocqAkPnkzFzEC4aJzgkqB0yAeALMD/U1UJr7/rAp5V4lXsCKCB+Yh4a+KlXYTkmkGP2truiMyhmXr/HmBm/dTcOsMxAkEjKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710270474; c=relaxed/simple;
	bh=JNgB/eEFOVQvohdouQjbuQDtOVHkhkYXtii11NX3qj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG/rP2MMq6DQSDq1rfHtH6HhhuokKUpGXvRL1LGAPeUdWRUWQBHvDpOEZ+hXhK4uShZcvaFQJI9g062bFeMH1/I6CmyF6cSmt3VwYNUTE0hMC8ocI/nfQvR8mbNmRIIN0YLkzkzvV+3tD6DeFItihqOKPn+bPudPTQqGb+vhhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yFoSLRbu; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59fdcf8ebbcso3772668eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710270471; x=1710875271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuhzBsBorB3vv8EkPlH7Xk1BNxZXU5f1Cq+e1Y2ub2w=;
        b=yFoSLRbulbFRlvDmeJN7K2Bk3y2vjcxs92Id6emOK8xUs62c0ZWfpodftyUl6OKy0l
         yCTYoFXa4DQNq80xN+Qc3O4T4YUGEBhYDgjVVbI6WzeBLCJmHlJZWED+RDx+ESDC0/9b
         RzJZAD6uQ7WD3QrJxFFvZrZXawTmi3Wi/sOR8J/Q6xFTTXM8nrBbjx4/UEi/lMw5a66K
         8BbuH+wjxHpScj+oH6rZpiBx1FBgWoq2kv+mp63gDB0wykadQjbZ5WtE0vMESe2viZXy
         aPnFgeIpiEcMYmAc6V4HwzYfAkNGFkwUu+iAW2yNkJvz/keK4Un2nn4fqSBTZl66I4+h
         z+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710270471; x=1710875271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuhzBsBorB3vv8EkPlH7Xk1BNxZXU5f1Cq+e1Y2ub2w=;
        b=PJAdIt74V7ozZ1Pmn4enC407wctiGU7NhHYWVGMWlxYExrQuI/FBmJQN1op53nzsyp
         pI+AStBLvZHwO0bHMHuNlvHlRw2hsR+8Y6D3QRrOJTtPRFWoldFuAFu//pffZD+HdMyL
         ZoGNtCQEqxl5Y8AehiHIh5lJCRz6UvEHsuu25lB5VJTOR+AeWXaZ/G4VDY91WxzxHzgX
         3YjmhMc9qfSUhy7O/mjFzPROeIWtkYE828HSgRhXOL988TYE2Kz2TVjmfG2RIpAKnISk
         eUigaPw78XvqEAR+X30caPQRPEgB4sLXvXJ4bFJClackUmCPxrrJvqdxIOmawC278vRv
         IrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTKUURyvozvNmyerescJTQ5FJOvlh40K/DB49uu+sxICqyVGFIrtpRtFXmh4DXnE/p6Prp5Ez9gCxjZo9O6BZom2zkoqtFo//o2Pp2
X-Gm-Message-State: AOJu0Yyr3LWSgUisLJruEZ5jknXHJPThFwlV1j6bnqtYxiMa3GGGWGn9
	qv5x+t3gucHpyH32eJ/1/CS9UEvoSFQMJV1r6icDHVZFiUGTCdz/oMhQGKk5ztc=
X-Google-Smtp-Source: AGHT+IFUOzYb7vyIzDt8HuL5+J2GufaucYiVzQ1ft93DnhXrTzS9NSIBcs+9DKh8OLX4dH7R7IW8Rw==
X-Received: by 2002:a05:6218:288c:b0:17b:b559:2ba3 with SMTP id vw12-20020a056218288c00b0017bb5592ba3mr12049505rwc.11.1710270470680;
        Tue, 12 Mar 2024 12:07:50 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:78a0:6361:8c91:fefc])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a0010c800b006e685c36d41sm5087354pfu.55.2024.03.12.12.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 12:07:49 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:07:47 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v11 2/4] riscv: Include riscv_set_icache_flush_ctx prctl
Message-ID: <ZfCoA0X9LXekTbFd@ghost>
References: <20240212-fencei-v11-0-e1327f25fe10@rivosinc.com>
 <20240212-fencei-v11-2-e1327f25fe10@rivosinc.com>
 <6cf4cb6b-86af-48c5-9301-de2499048240@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf4cb6b-86af-48c5-9301-de2499048240@sifive.com>

On Tue, Mar 12, 2024 at 01:00:43PM -0500, Samuel Holland wrote:
> On 2024-02-12 5:36 PM, Charlie Jenkins wrote:
> > Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
> > optimization of cross modifying code. This prctl enables userspace code
> > to use icache flushing instructions such as fence.i with the guarantee
> > that the icache will continue to be clean after thread migration.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/mmu.h       |   2 +
> >  arch/riscv/include/asm/processor.h |  12 +++++
> >  arch/riscv/include/asm/switch_to.h |  23 ++++++++
> >  arch/riscv/mm/cacheflush.c         | 105 +++++++++++++++++++++++++++++++++++++
> >  arch/riscv/mm/context.c            |  18 +++++--
> >  include/uapi/linux/prctl.h         |   6 +++
> >  kernel/sys.c                       |   6 +++
> >  7 files changed, 167 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> > index 355504b37f8e..60be458e94da 100644
> > --- a/arch/riscv/include/asm/mmu.h
> > +++ b/arch/riscv/include/asm/mmu.h
> > @@ -19,6 +19,8 @@ typedef struct {
> >  #ifdef CONFIG_SMP
> >  	/* A local icache flush is needed before user execution can resume. */
> >  	cpumask_t icache_stale_mask;
> > +	/* Force local icache flush on all migrations. */
> > +	bool force_icache_flush;
> >  #endif
> >  #ifdef CONFIG_BINFMT_ELF_FDPIC
> >  	unsigned long exec_fdpic_loadmap;
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index a8509cc31ab2..46c5c3b91165 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -69,6 +69,7 @@
> >  #endif
> >  
> >  #ifndef __ASSEMBLY__
> > +#include <linux/cpumask.h>
> >  
> >  struct task_struct;
> >  struct pt_regs;
> > @@ -123,6 +124,14 @@ struct thread_struct {
> >  	struct __riscv_v_ext_state vstate;
> >  	unsigned long align_ctl;
> >  	struct __riscv_v_ext_state kernel_vstate;
> > +#ifdef CONFIG_SMP
> > +	/* A local icache flush is needed before user execution can resume on one of these cpus. */
> > +	cpumask_t icache_stale_mask;
> > +	/* Regardless of the icache_stale_mask, flush the icache on migration */
> > +	bool force_icache_flush;
> > +	/* A forced icache flush is not needed if migrating to the previous cpu. */
> > +	unsigned int prev_cpu;
> > +#endif
> >  };
> >  
> >  /* Whitelist the fstate from the task_struct for hardened usercopy */
> > @@ -184,6 +193,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
> >  #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
> >  #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
> >  
> > +#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
> > +extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
> > +
> >  #endif /* __ASSEMBLY__ */
> >  
> >  #endif /* _ASM_RISCV_PROCESSOR_H */
> > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> > index 7efdb0584d47..7594df37cc9f 100644
> > --- a/arch/riscv/include/asm/switch_to.h
> > +++ b/arch/riscv/include/asm/switch_to.h
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/jump_label.h>
> >  #include <linux/sched/task_stack.h>
> > +#include <linux/mm_types.h>
> >  #include <asm/vector.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/processor.h>
> > @@ -72,14 +73,36 @@ static __always_inline bool has_fpu(void) { return false; }
> >  extern struct task_struct *__switch_to(struct task_struct *,
> >  				       struct task_struct *);
> >  
> > +static inline bool switch_to_should_flush_icache(struct task_struct *task)
> > +{
> > +#ifdef CONFIG_SMP
> > +	bool stale_mm = task->mm && task->mm->context.force_icache_flush;
> > +	bool stale_thread = task->thread.force_icache_flush;
> > +	bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
> > +
> > +	return thread_migrated && (stale_mm || stale_thread);
> > +#else
> > +	return false;
> > +#endif
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +#define __set_prev_cpu(thread) ((thread).prev_cpu = smp_processor_id())
> > +#else
> > +#define __set_prev_cpu(thread)
> > +#endif
> > +
> >  #define switch_to(prev, next, last)			\
> >  do {							\
> >  	struct task_struct *__prev = (prev);		\
> >  	struct task_struct *__next = (next);		\
> > +	__set_prev_cpu(__prev->thread);			\
> >  	if (has_fpu())					\
> >  		__switch_to_fpu(__prev, __next);	\
> >  	if (has_vector())					\
> >  		__switch_to_vector(__prev, __next);	\
> > +	if (switch_to_should_flush_icache(__next))	\
> > +		local_flush_icache_all();		\
> >  	((last) = __switch_to(__prev, __next));		\
> >  } while (0)
> >  
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 55a34f2020a8..6513a0ab8655 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -5,6 +5,7 @@
> >  
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> > +#include <linux/prctl.h>
> >  #include <asm/acpi.h>
> >  #include <asm/cacheflush.h>
> >  
> > @@ -152,3 +153,107 @@ void __init riscv_init_cbo_blocksizes(void)
> >  	if (cboz_block_size)
> >  		riscv_cboz_block_size = cboz_block_size;
> >  }
> > +
> > +/**
> > + * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instructions in
> > + * userspace.
> > + * @ctx: Set the type of icache flushing instructions permitted/prohibited in
> > + *	 userspace. Supported values described below.
> > + *
> > + * Supported values for ctx:
> > + *
> > + * * %PR_RISCV_CTX_SW_FENCEI_ON: Allow fence.i in user space.
> > + *
> > + * * %PR_RISCV_CTX_SW_FENCEI_OFF: Disallow fence.i in user space. All threads in
> > + *   a process will be affected when ``scope == PR_RISCV_SCOPE_PER_PROCESS``.
> > + *   Therefore, caution must be taken; use this flag only when you can guarantee
> > + *   that no thread in the process will emit fence.i from this point onward.
> > + *
> > + * @scope: Set scope of where icache flushing instructions are allowed to be
> > + *	   emitted. Supported values described below.
> > + *
> > + * Supported values for scope:
> > + *
> > + * * %PR_RISCV_SCOPE_PER_PROCESS: Ensure the icache of any thread in this process
> > + *                               is coherent with instruction storage upon
> > + *                               migration.
> > + *
> > + * * %PR_RISCV_SCOPE_PER_THREAD: Ensure the icache of the current thread is
> > + *                              coherent with instruction storage upon
> > + *                              migration.
> > + *
> > + * When ``scope == PR_RISCV_SCOPE_PER_PROCESS``, all threads in the process are
> > + * permitted to emit icache flushing instructions. Whenever any thread in the
> > + * process is migrated, the corresponding hart's icache will be guaranteed to be
> > + * consistent with instruction storage. This does not enforce any guarantees
> > + * outside of migration. If a thread modifies an instruction that another thread
> > + * may attempt to execute, the other thread must still emit an icache flushing
> > + * instruction before attempting to execute the potentially modified
> > + * instruction. This must be performed by the user-space program.
> > + *
> > + * In per-thread context (eg. ``scope == PR_RISCV_SCOPE_PER_THREAD``) only the
> > + * thread calling this function is permitted to emit icache flushing
> > + * instructions. When the thread is migrated, the corresponding hart's icache
> > + * will be guaranteed to be consistent with instruction storage.
> > + *
> > + * On kernels configured without SMP, this function is a nop as migrations
> > + * across harts will not occur.
> > + */
> > +int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
> > +{
> > +#ifdef CONFIG_SMP
> > +	switch (ctx) {
> > +	case PR_RISCV_CTX_SW_FENCEI_ON:
> > +		switch (scope) {
> > +		case PR_RISCV_SCOPE_PER_PROCESS:
> > +			current->mm->context.force_icache_flush = true;
> > +			break;
> > +		case PR_RISCV_SCOPE_PER_THREAD:
> > +			current->thread.force_icache_flush = true;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case PR_RISCV_CTX_SW_FENCEI_OFF:
> > +		cpumask_t *mask;
> > +
> > +		switch (scope) {
> > +		case PR_RISCV_SCOPE_PER_PROCESS:
> > +			bool stale_cpu;
> > +
> > +			current->mm->context.force_icache_flush = false;
> > +
> > +			/*
> > +			 * Mark every other hart's icache as needing a flush for
> > +			 * this MM. Maintain the previous value of the current
> > +			 * cpu to handle the case when this function is called
> > +			 * concurrently on different harts.
> > +			 */
> > +			mask = &current->mm->context.icache_stale_mask;
> > +			stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
> > +
> > +			cpumask_setall(mask);
> > +			assign_bit(cpumask_check(smp_processor_id()), cpumask_bits(mask), stale_cpu);
> > +			break;
> > +		case PR_RISCV_SCOPE_PER_THREAD:
> > +			current->thread.force_icache_flush = false;
> > +
> > +			/*
> > +			 * Mark every other hart's icache as needing a flush for
> > +			 * this thread.
> > +			 */
> > +			mask = &current->thread.icache_stale_mask;
> > +			cpumask_setall(mask);
> > +			cpumask_clear_cpu(smp_processor_id(), mask);
> 
> I don't think we need to maintain another cpumask for every thread (and check it
> at every mm switch) just to optimize this prctl() call.
> PR_RISCV_CTX_SW_FENCEI_OFF is unlikely to be in anything's hot path. It should
> be sufficient for both scopes to just do:
> 
>   cpumask_setall(&current->mm->context.icache_stale_mask);
> 
> and accept the extra one-time icache flushes.
> 
> Otherwise this looks good to me.
> 
> Regards,
> Samuel

Yes that is reasonable. I will collapse the switch statement to execute
the PR_RISCV_SCOPE_PER_PROCESS code for PR_RISCV_SCOPE_PER_THREAD as
well. However, there is still value to doing the setall + assign_cpu
instead of just a setall since it eliminates the redundant flush when
migrating back onto the same hart.

- Charlie

> 
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +#endif
> > +	return 0;
> > +}
> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 217fd4de6134..2eb13b89cced 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -15,6 +15,7 @@
> >  #include <asm/tlbflush.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/mmu_context.h>
> > +#include <asm/switch_to.h>
> >  
> >  #ifdef CONFIG_MMU
> >  
> > @@ -297,21 +298,28 @@ static inline void set_mm(struct mm_struct *prev,
> >   *
> >   * The "cpu" argument must be the current local CPU number.
> >   */
> > -static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
> > +static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
> > +					 struct task_struct *task)
> >  {
> >  #ifdef CONFIG_SMP
> >  	cpumask_t *mask = &mm->context.icache_stale_mask;
> >  
> > -	if (cpumask_test_cpu(cpu, mask)) {
> > +	if (cpumask_test_and_clear_cpu(cpu, mask) ||
> > +	    (task && cpumask_test_and_clear_cpu(cpu, &task->thread.icache_stale_mask))) {
> >  		cpumask_clear_cpu(cpu, mask);
> > +
> >  		/*
> >  		 * Ensure the remote hart's writes are visible to this hart.
> >  		 * This pairs with a barrier in flush_icache_mm.
> >  		 */
> >  		smp_mb();
> > -		local_flush_icache_all();
> > -	}
> >  
> > +		/*
> > +		 * If cache will be flushed in switch_to, no need to flush here.
> > +		 */
> > +		if (!(task && switch_to_should_flush_icache(task)))
> > +			local_flush_icache_all();
> > +	}
> >  #endif
> >  }
> >  
> > @@ -332,5 +340,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >  
> >  	set_mm(prev, next, cpu);
> >  
> > -	flush_icache_deferred(next, cpu);
> > +	flush_icache_deferred(next, cpu, task);
> >  }
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index 370ed14b1ae0..524d546d697b 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -306,4 +306,10 @@ struct prctl_mm_map {
> >  # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
> >  # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
> >  
> > +#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
> > +# define PR_RISCV_CTX_SW_FENCEI_ON	0
> > +# define PR_RISCV_CTX_SW_FENCEI_OFF	1
> > +# define PR_RISCV_SCOPE_PER_PROCESS	0
> > +# define PR_RISCV_SCOPE_PER_THREAD	1
> > +
> >  #endif /* _LINUX_PRCTL_H */
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index e219fcfa112d..69afdd8b430f 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -146,6 +146,9 @@
> >  #ifndef RISCV_V_GET_CONTROL
> >  # define RISCV_V_GET_CONTROL()		(-EINVAL)
> >  #endif
> > +#ifndef RISCV_SET_ICACHE_FLUSH_CTX
> > +# define RISCV_SET_ICACHE_FLUSH_CTX(a, b)	(-EINVAL)
> > +#endif
> >  
> >  /*
> >   * this is where the system-wide overflow UID and GID are defined, for
> > @@ -2743,6 +2746,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >  	case PR_RISCV_V_GET_CONTROL:
> >  		error = RISCV_V_GET_CONTROL();
> >  		break;
> > +	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> > +		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> > +		break;
> >  	default:
> >  		error = -EINVAL;
> >  		break;
> > 
> 

