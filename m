Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0747B80CD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbjLKOIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbjLKOIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:08:14 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E74224
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702302920;
        bh=JZS3M0CY1us1Zr6CsScLovyExIwx8qNZhpLweKknXaE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uPyaDTl+S8XIhiVgq1qBTupBCuXyUUOkvGxko1XPRUnNefzAB/+idE2DeRK8L2DAi
         jz7A+pm98Xmnp6OmKW5rIdlPuSVfQAr0ED4PUDIbdVpsOxf1JsvD3D0D4387UL4cCe
         a4r00aaVb9DaAAxWREkmxENRYgNbr9rKlsXFcPZmrRAOQuh8N3VEYb6ZaZZRVm4NpL
         cE94hTIC5IeTONV7hvv0ycqpr+s7+6paY+t7DSh0lfPepXNFAINkXAunUDEbftwSGf
         B71Te4cYN4BagXcPAh8D141lkDFF21vw5kiq1s9yz1M8YJdwGQtODUomUgpyejyNag
         GQiarQjP67N+A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Spjtb6Fjbz1hsB;
        Mon, 11 Dec 2023 08:55:19 -0500 (EST)
Message-ID: <fc29a938-c34a-45ee-8c6e-3aa71964c873@efficios.com>
Date:   Mon, 11 Dec 2023 08:55:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] membarrier: riscv: Provide core serializing
 command
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231211094414.8078-1-parri.andrea@gmail.com>
 <20231211094414.8078-4-parri.andrea@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231211094414.8078-4-parri.andrea@gmail.com>
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

On 2023-12-11 04:44, Andrea Parri wrote:
> RISC-V uses xRET instructions on return from interrupt and to go back
> to user-space; the xRET instruction is not core serializing.
> 
> Use FENCE.I for providing core serialization as follows:
> 
>   - by calling sync_core_before_usermode() on return from interrupt (cf.
>     ipi_sync_core()),
> 
>   - via switch_mm() and sync_core_before_usermode() (respectively, for
>     uthread->uthread and kthread->uthread transitions) to go back to
>     user-space.
> 
> On RISC-V, the serialization in switch_mm() is activated by resetting
> the icache_stale_mask of the mm at prepare_sync_core_cmd().
> 
> Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>   .../membarrier-sync-core/arch-support.txt     | 18 +++++++++++-
>   MAINTAINERS                                   |  1 +
>   arch/riscv/Kconfig                            |  3 ++
>   arch/riscv/include/asm/membarrier.h           | 19 ++++++++++++
>   arch/riscv/include/asm/sync_core.h            | 29 +++++++++++++++++++
>   5 files changed, 69 insertions(+), 1 deletion(-)
>   create mode 100644 arch/riscv/include/asm/sync_core.h
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index d96b778b87ed8..a163170fc0f48 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -10,6 +10,22 @@
>   # Rely on implicit context synchronization as a result of exception return
>   # when returning from IPI handler, and when returning to user-space.
>   #
> +# * riscv
> +#
> +# riscv uses xRET as return from interrupt and to return to user-space.
> +#
> +# Given that xRET is not core serializing, we rely on FENCE.I for providing
> +# core serialization:
> +#
> +#  - by calling sync_core_before_usermode() on return from interrupt (cf.
> +#    ipi_sync_core()),
> +#
> +#  - via switch_mm() and sync_core_before_usermode() (respectively, for
> +#    uthread->uthread and kthread->uthread transitions) to go back to
> +#    user-space.
> +#
> +#  The serialization in switch_mm() is activated by prepare_sync_core_cmd().
> +#
>   # * x86
>   #
>   # x86-32 uses IRET as return from interrupt, which takes care of the IPI.
> @@ -43,7 +59,7 @@
>       |    openrisc: | TODO |
>       |      parisc: | TODO |
>       |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>       |        s390: |  ok  |
>       |          sh: | TODO |
>       |       sparc: | TODO |
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a9166d82ffced..f6f1fdc76cf46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13808,6 +13808,7 @@ M:	"Paul E. McKenney" <paulmck@kernel.org>
>   L:	linux-kernel@vger.kernel.org
>   S:	Supported
>   F:	arch/*/include/asm/membarrier.h
> +F:	arch/*/include/asm/sync_core.h
>   F:	include/uapi/linux/membarrier.h
>   F:	kernel/sched/membarrier.c
>   
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f7db95097caf1..db7b1acd943e4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,14 +28,17 @@ config RISCV
>   	select ARCH_HAS_GIGANTIC_PAGE
>   	select ARCH_HAS_KCOV
>   	select ARCH_HAS_MEMBARRIER_CALLBACKS
> +	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>   	select ARCH_HAS_MMIOWB
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_PMEM_API
> +	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_SET_DIRECT_MAP if MMU
>   	select ARCH_HAS_SET_MEMORY if MMU
>   	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>   	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
> +	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>   	select ARCH_HAS_SYSCALL_WRAPPER
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_HAS_UBSAN_SANITIZE_ALL
> diff --git a/arch/riscv/include/asm/membarrier.h b/arch/riscv/include/asm/membarrier.h
> index 4be218fa03b14..a1071039c20ed 100644
> --- a/arch/riscv/include/asm/membarrier.h
> +++ b/arch/riscv/include/asm/membarrier.h
> @@ -22,6 +22,25 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
>   	/*
>   	 * The membarrier system call requires a full memory barrier
>   	 * after storing to rq->curr, before going back to user-space.
> +	 *
> +	 * The barrier is also needed for the SYNC_CORE command when
> +	 * switching between processes; in particular, on a transition
> +	 * from a thread belonging to another mm to a thread belonging
> +	 * to the mm for which a membarrier SYNC_CORE is done on CPU0:
> +	 *
> +	 *   - [CPU0] sets all bits in the mm icache_stale_mask.
> +	 *
> +	 *   - [CPU1] store to rq->curr (by the scheduler).
> +	 *
> +	 *   - [CPU0] loads rq->curr within membarrier and observes
> +	 *     cpu_rq(1)->curr->mm != mm, so the IPI is skipped on
> +	 *     CPU1; this means membarrier relies on switch_mm() to
> +	 *     issue the sync-core.
> +	 *
> +	 *   - [CPU1] switch_mm() loads icache_stale_mask; if the bit
> +	 *     is zero, switch_mm() may incorrectly skip the sync-core.
> +	 *
> +	 * Matches the full barrier in membarrier_private_expedited().

There are two full barriers in membarrier_private_expedited(). We
should clearly state which one it matches, and update the associated
barrier to state that it matches this barrier as well.

The barrier it matches is near the membarrier system call entry:

         /*
          * Matches memory barriers around rq->curr modification in
          * scheduler.
          */
         smp_mb();       /* system call entry is not a mb. */

Note that membarrier _also_ requires a full barrier between entering
the kernel and storing to rq->curr. This is provided by __schedule():

          * Also, the membarrier system call requires a full memory barrier
          * after coming from user-space, before storing to rq->curr.
          */
         rq_lock(rq, &rf);
         smp_mb__after_spinlock();

This other barrier is matched by the barrier near the membarrier system call
exit:

         /*
          * Memory barrier on the caller thread _after_ we finished
          * waiting for the last IPI. Matches memory barriers around
          * rq->curr modification in scheduler.
          */
         smp_mb();       /* exit from system call is not a mb */

I don't think this second barrier pairing matters for the cpumask update
though.

Thanks,

Mathieu

>   	 */
>   	smp_mb();
>   }
> diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
> new file mode 100644
> index 0000000000000..9153016da8f14
> --- /dev/null
> +++ b/arch/riscv/include/asm/sync_core.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_SYNC_CORE_H
> +#define _ASM_RISCV_SYNC_CORE_H
> +
> +/*
> + * RISC-V implements return to user-space through an xRET instruction,
> + * which is not core serializing.
> + */
> +static inline void sync_core_before_usermode(void)
> +{
> +	asm volatile ("fence.i" ::: "memory");
> +}
> +
> +#ifdef CONFIG_SMP
> +/*
> + * Ensure the next switch_mm() on every CPU issues a core serializing
> + * instruction for the given @mm.
> + */
> +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> +{
> +	cpumask_setall(&mm->context.icache_stale_mask);
> +}
> +#else
> +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> +{
> +}
> +#endif /* CONFIG_SMP */
> +
> +#endif /* _ASM_RISCV_SYNC_CORE_H */

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

