Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A907FA118
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjK0N24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjK0N2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:28:53 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF24CAA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1701091738;
        bh=eA/Ebz+NfzTlrh+9vkBwg8LcxLGPp/UbUBh8p02oCwU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YsJiiOuzAJRQsxju0pHZ+mnHUHZ4BwE2N1WyS3xLcuAAusgZzlGo8p/1rwJx8A4Ea
         4eJTVAtuMUREMyv59zAEegOMWQWg0yLbNaySDKIXqBpf1L6BMcmlwfdqCWe6nymeb4
         J3r/jkDzWa9qggLNrQs73W8xpotSRulMP+IDOUVhmzbIkUf6idZkVexDaypYDUXmrY
         uyhMx/4eCREw9f2vkVtlVZOh8W6bgljQYrLG7opnUYJhnWUV6zcQ47U6v88FUd8oFx
         QRWQBYB6XvuWE1AA08PlIUPyIqeM4HhzEfy5w4VdF+aNIPgb/1ZILu7po0jPxC13ne
         o8slyvWf88+0A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sf5yf322qz1dXq;
        Mon, 27 Nov 2023 08:28:58 -0500 (EST)
Message-ID: <91ab0210-07f9-42c4-af7f-a98799250cf7@efficios.com>
Date:   Mon, 27 Nov 2023 08:28:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231127103235.28442-1-parri.andrea@gmail.com>
 <20231127103235.28442-3-parri.andrea@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231127103235.28442-3-parri.andrea@gmail.com>
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

On 2023-11-27 05:32, Andrea Parri wrote:
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
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---

[...]

> +
> +#ifdef CONFIG_SMP
> +/*
> + * Ensure the next switch_mm() on every CPU issues a core serializing
> + * instruction for the given @mm.
> + */
> +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> +{
> +	cpumask_setall(&mm->context.icache_stale_mask);

I am concerned about the possibility that this change lacks two barriers in the
following scenario:

On a transition from uthread -> uthread on [CPU 0], from a thread belonging to
another mm to a thread belonging to the mm [!mm -> mm] for which a concurrent
membarrier sync-core is done on [CPU 1]:

- [CPU 1] sets all bits in the mm icache_stale_mask [A]. There are no barriers
   associated with these stores.

- [CPU 0] store to rq->curr [B] (by the scheduler) vs [CPU 1] loads rq->curr [C]
   within membarrier to decide if the IPI should be skipped. Let's say CPU 1 observes
   cpu_rq(0)->curr->mm != mm, so it skips the IPI.

- This means membarrier relies on switch_mm() to issue the sync-core.

- [CPU 0] switch_mm() loads [D] the icache_stale_mask. If the bit is zero, switch_mm()
   may incorrectly skip the sync-core.

AFAIU, [C] can be reordered before [A] because there is no barrier between those
operations within membarrier. I suspect it can cause the switch_mm() code to skip
a needed sync-core.

AFAIU, [D] can be reordered before [B] because there is no documented barrier
between those operations within the scheduler, which can also cause switch_mm()
to skip a needed sync-core.

We possibly have a similar scenario for uthread->uthread when the scheduler
switches between mm -> !mm.

One way to fix this would be to add the following barriers:

- A smp_mb() between [A] and [C], possibly just after cpumask_setall() in
   prepare_sync_core_cmd(), with comments detailing the ordering it guarantees,
- A smp_mb() between [B] and [D], possibly just before cpumask_test_cpu() in
   flush_icache_deferred(), with appropriate comments.

Am I missing something ?

Thanks,

Mathieu

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

