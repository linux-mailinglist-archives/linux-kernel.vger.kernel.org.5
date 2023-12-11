Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15CE80CB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbjLKNjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbjLKNjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:39:20 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D8FC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702301965;
        bh=PJbq8p4AKEAVO0chtogCRS8QRlZvL+bMmeEbhWJtFRg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R8c6UEo0hgrynNPwVBlk6gzGqcX0sevDoK60/ZmeIgTrgQ4l25tyrEXrNmFC0ZsEC
         V09EaM48CuD/E+FKF1yRIqFCyVQEPrT1VsNp9XxaTz6zm/fFf976tJzdtVaoH8wJpC
         Wdsd6Mtc1L8zUCJr5GjJZA3tmxlz5qaEbVPfz1wUET9oM4UnZzhpL1Hqvr9viY4oax
         LOY+O5FomeagM0+LS1aDS/ggZ6kGU+XrkkahSnd/RJ2ARlin61ziLidOepdhtm+4J7
         GZRp0J2VYnCIARwXpqWrqBbJ4YhWE+BJ7UTaZ4KsyapaCIuJ0nuWQNmREup/Fc1Dik
         GJixdR7GW5AeA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SpjXD5bKYzFfN;
        Mon, 11 Dec 2023 08:39:24 -0500 (EST)
Message-ID: <05ece6bc-2a2f-40c6-b68c-a16c4b69dbef@efficios.com>
Date:   Mon, 11 Dec 2023 08:39:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] membarrier: riscv: Add full memory barrier in
 switch_mm()
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231211094414.8078-1-parri.andrea@gmail.com>
 <20231211094414.8078-2-parri.andrea@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231211094414.8078-2-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-11 04:44, Andrea Parri wrote:
> The membarrier system call requires a full memory barrier after storing
> to rq->curr, before going back to user-space.  The barrier is only
> needed when switching between processes: the barrier is implied by
> mmdrop() when switching from kernel to userspace, and it's not needed
> when switching from userspace to kernel.
> 
> Rely on the feature/mechanism ARCH_HAS_MEMBARRIER_CALLBACKS and on the
> primitive membarrier_arch_switch_mm(), already adopted by the PowerPC
> architecture, to insert the required barrier.
> 
> Fixes: fab957c11efe2f ("RISC-V: Atomic and Locking Code")
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Thanks!

Feel free to add those tags:

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   MAINTAINERS                         |  2 +-
>   arch/riscv/Kconfig                  |  1 +
>   arch/riscv/include/asm/membarrier.h | 29 +++++++++++++++++++++++++++++
>   arch/riscv/mm/context.c             |  2 ++
>   kernel/sched/core.c                 |  5 +++--
>   5 files changed, 36 insertions(+), 3 deletions(-)
>   create mode 100644 arch/riscv/include/asm/membarrier.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2c6187a3ac80..a9166d82ffced 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13807,7 +13807,7 @@ M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   M:	"Paul E. McKenney" <paulmck@kernel.org>
>   L:	linux-kernel@vger.kernel.org
>   S:	Supported
> -F:	arch/powerpc/include/asm/membarrier.h
> +F:	arch/*/include/asm/membarrier.h
>   F:	include/uapi/linux/membarrier.h
>   F:	kernel/sched/membarrier.c
>   
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 95a2a06acc6a6..f7db95097caf1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -27,6 +27,7 @@ config RISCV
>   	select ARCH_HAS_GCOV_PROFILE_ALL
>   	select ARCH_HAS_GIGANTIC_PAGE
>   	select ARCH_HAS_KCOV
> +	select ARCH_HAS_MEMBARRIER_CALLBACKS
>   	select ARCH_HAS_MMIOWB
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_PMEM_API
> diff --git a/arch/riscv/include/asm/membarrier.h b/arch/riscv/include/asm/membarrier.h
> new file mode 100644
> index 0000000000000..4be218fa03b14
> --- /dev/null
> +++ b/arch/riscv/include/asm/membarrier.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_RISCV_MEMBARRIER_H
> +#define _ASM_RISCV_MEMBARRIER_H
> +
> +static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
> +					     struct mm_struct *next,
> +					     struct task_struct *tsk)
> +{
> +	/*
> +	 * Only need the full barrier when switching between processes.
> +	 * Barrier when switching from kernel to userspace is not
> +	 * required here, given that it is implied by mmdrop(). Barrier
> +	 * when switching from userspace to kernel is not needed after
> +	 * store to rq->curr.
> +	 */
> +	if (IS_ENABLED(CONFIG_SMP) &&
> +	    likely(!(atomic_read(&next->membarrier_state) &
> +		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
> +		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
> +		return;
> +
> +	/*
> +	 * The membarrier system call requires a full memory barrier
> +	 * after storing to rq->curr, before going back to user-space.
> +	 */
> +	smp_mb();
> +}
> +
> +#endif /* _ASM_RISCV_MEMBARRIER_H */
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 217fd4de61342..ba8eb3944687c 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -323,6 +323,8 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>   	if (unlikely(prev == next))
>   		return;
>   
> +	membarrier_arch_switch_mm(prev, next, task);
> +
>   	/*
>   	 * Mark the current MM context as inactive, and the next as
>   	 * active.  This is at least used by the icache flushing
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a708d225c28e8..711dc753f7216 100644
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
> +		 *   on PowerPC and on RISC-V.
>   		 * - finish_lock_switch() for weakly-ordered
>   		 *   architectures where spin_unlock is a full barrier,
>   		 * - switch_to() for arm64 (weakly-ordered, spin_unlock

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

