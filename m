Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106EC7FC38B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbjK1SjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjK1SjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:39:13 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3344E1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1701196756;
        bh=a5nAofpMJbYiY38PUq8cQCUSoZ0WexOPOFEczQlZ4xA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k5Cv5ceQLSuzV+UAiLaWtU9jAwAS0WQQdL3OJdFoDFegaw4YgR4gxZrvR8oGKVT/Q
         FC2AfaCam4YBqX63yr86cg6RMHBrHPZC1SAlXgH+gyomIa22Ya74thyyhWJMhVY6q2
         j0VWkqq9Mh99XeEiTW6PAZE2s30sGdqRCE4SYU4ceXu5qWyC/Bp2tVzQJL1bqncQXc
         qeMl918bt+8vW6Y6nhA2V9in2uv6GUpRBaX1jWzr+g0TB4gW6laefgJ1PeJozC6YgQ
         1tim/4YBVmnl2mWBp8uhuW+su/L1h81Gvj32sO8cF8uARSqfvbJa1cApRyCkGMWQf1
         tqEY6cw5Y56gA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SfrpD0Dmhz1dDB;
        Tue, 28 Nov 2023 13:39:16 -0500 (EST)
Message-ID: <0a84c0e0-2571-4c7f-82ae-a429f467a16b@efficios.com>
Date:   Tue, 28 Nov 2023 13:39:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231127103235.28442-1-parri.andrea@gmail.com>
 <20231127103235.28442-3-parri.andrea@gmail.com>
 <91ab0210-07f9-42c4-af7f-a98799250cf7@efficios.com> <ZWYDtB/otYvTMZWd@andrea>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZWYDtB/otYvTMZWd@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-28 10:13, Andrea Parri wrote:
>> I am concerned about the possibility that this change lacks two barriers in the
>> following scenario:
>>
>> On a transition from uthread -> uthread on [CPU 0], from a thread belonging to
>> another mm to a thread belonging to the mm [!mm -> mm] for which a concurrent
>> membarrier sync-core is done on [CPU 1]:
>>
>> - [CPU 1] sets all bits in the mm icache_stale_mask [A]. There are no barriers
>>    associated with these stores.
>>
>> - [CPU 0] store to rq->curr [B] (by the scheduler) vs [CPU 1] loads rq->curr [C]
>>    within membarrier to decide if the IPI should be skipped. Let's say CPU 1 observes
>>    cpu_rq(0)->curr->mm != mm, so it skips the IPI.
>>
>> - This means membarrier relies on switch_mm() to issue the sync-core.
>>
>> - [CPU 0] switch_mm() loads [D] the icache_stale_mask. If the bit is zero, switch_mm()
>>    may incorrectly skip the sync-core.
>>
>> AFAIU, [C] can be reordered before [A] because there is no barrier between those
>> operations within membarrier. I suspect it can cause the switch_mm() code to skip
>> a needed sync-core.
>>
>> AFAIU, [D] can be reordered before [B] because there is no documented barrier
>> between those operations within the scheduler, which can also cause switch_mm()
>> to skip a needed sync-core.
>>
>> We possibly have a similar scenario for uthread->uthread when the scheduler
>> switches between mm -> !mm.
>>
>> One way to fix this would be to add the following barriers:
>>
>> - A smp_mb() between [A] and [C], possibly just after cpumask_setall() in
>>    prepare_sync_core_cmd(), with comments detailing the ordering it guarantees,
>> - A smp_mb() between [B] and [D], possibly just before cpumask_test_cpu() in
>>    flush_icache_deferred(), with appropriate comments.
>>
>> Am I missing something ?
> 
> Thanks for the detailed analysis.
> 
> AFAIU, the following barrier (in membarrier_private_expedited())
> 
> 	/*
> 	 * Matches memory barriers around rq->curr modification in
> 	 * scheduler.
> 	 */
> 	smp_mb();	/* system call entry is not a mb. */
> 
> can serve the purpose of ordering [A] before [C] (to be documented in v2).

Agreed. Yes it should be documented.

> 
> But I agree that [B] and [D] are unordered /missing suitable synchronization.
> Worse, RISC-V has currently no full barrier after [B] and before returning to
> user-space: I'm thinking (inspired by the PowerPC implementation),

If RISC-V currently supports the membarrier private cmd and lacks the 
appropriate smp_mb() in switch_mm(), then it's a bug. This initial patch 
should be a "Fix" and fast-tracked as such.

Indeed, looking at how ASID is used to implement switch_mm, it appears 
to not require a full smp_mb() at all as long as there are no ASID 
rollovers.

> 
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 217fd4de61342..f63222513076d 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -323,6 +323,23 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>   	if (unlikely(prev == next))
>   		return;
>   
> +#if defined(CONFIG_MEMBARRIER) && defined(CONFIG_SMP)
> +	/*
> +	 * The membarrier system call requires a full memory barrier
> +	 * after storing to rq->curr, before going back to user-space.
> +	 *
> +	 * Only need the full barrier when switching between processes:
> +	 * barrier when switching from kernel to userspace is not
> +	 * required here, given that it is implied by mmdrop(); barrier
> +	 * when switching from userspace to kernel is not needed after
> +	 * store to rq->curr.
> +	 */
> +	if (unlikely(atomic_read(&next->membarrier_state) &
> +		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
> +		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) && prev)
> +		smp_mb();
> +#endif

The approach looks good. Please implement it within a separate 
membarrier_arch_switch_mm() as done on powerpc.

> +
>   	/*
>   	 * Mark the current MM context as inactive, and the next as
>   	 * active.  This is at least used by the icache flushing
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a708d225c28e8..a1c749fddd095 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6670,8 +6670,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   		 *
>   		 * Here are the schemes providing that barrier on the
>   		 * various architectures:
> -		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
> -		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
> +		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC,
> +		 *   RISC-V.  switch_mm() relies on membarrier_arch_switch_mm()
> +		 *   on PowerPC.
>   		 * - finish_lock_switch() for weakly-ordered
>   		 *   architectures where spin_unlock is a full barrier,
>   		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
> 
> The silver lining is that similar changes (probably as a separate/preliminary
> patch) also restore the desired order between [B] and [D] AFAIU; so with them,
> 2/2 would just need additions to document the above SYNC_CORE scenario.

Exactly.

> Thoughts?

I think we should be OK with the changes you suggest.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

