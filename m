Return-Path: <linux-kernel+bounces-138875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88089FB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EBC1F2AF90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F30F16EC11;
	Wed, 10 Apr 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AijiieaE"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70215EFAE;
	Wed, 10 Apr 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762975; cv=none; b=WBIBhGkhLfKB2Rspe/zt9LqInuPQJNxI9SuUqTd36cnRJkHnIO+LEDrPVcGXa9aVTq44xvXrSCEceTEsY+uID3azaWrgbr89zynKX+cyc6uQknTXm8HHoOqXS7+bnouTc9SnEqGHcPCsnXE9NcAjaMSeSMDEZ+7/6DoAQIgSK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762975; c=relaxed/simple;
	bh=D6tHl94Mqj+YhPbkPg+wHj8JPc4IGyn8BYCHVddbrgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xgv30t7TIVxvxjWawrnk+Buf0lNhUviCm0KmbXrJk+qFt8QiYS+WXUB6FoQTh9SX8aOgfSq9GVxH+rReAE8T2bWev/fNsIThYpMmSGV+KUE6G/vDuwtqAjzov+gFbiVLnvIlp5YblCQtaJ9zogLm9E0tazqGUirltM3L/95/OOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AijiieaE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1712762536;
	bh=D6tHl94Mqj+YhPbkPg+wHj8JPc4IGyn8BYCHVddbrgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AijiieaEGfw7A7pM0mjmSo8sVX6CMr/cpz12PzZzOquRvaJij36ufyzMY0u0hdCyC
	 ZAGHedAKIakAvMptB0kqkD9KFC+0ja0ugryHuMNJ1scMqCyny2e+teq9W48o7tFfuL
	 EH8VzABUdA+CMndHWNjO77acaUjAqbuIEv0w+h2WJ40vyoRmgzH5DFTHq7b6rc+fJS
	 Ccv89+sQANkzISzE+Noaao87phvo9TkQnsZMePrZ8hWkW11Fx/zBqertHiJ8qi1Z4u
	 qn9mwK2/+L0kvf3tlLe4MRgHkKd02sUcaXKzQp7c98MKPYQw2bTTUVGwrfdGXE6Vbw
	 76Jc1Ii82FDtQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VF6540SSfzrWT;
	Wed, 10 Apr 2024 11:22:16 -0400 (EDT)
Message-ID: <41bbe236-5c61-4a0e-91b1-b292179cde78@efficios.com>
Date: Wed, 10 Apr 2024 11:22:51 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Add missing memory barrier in switch_mm_cid
To: Yeo Reum Yun <YeoReum.Yun@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Mark Rutland <Mark.Rutland@arm.com>, Will Deacon <will@kernel.org>,
 Aaron Lu <aaron.lu@intel.com>
References: <20240308150719.676738-1-mathieu.desnoyers@efficios.com>
 <AM0PR08MB42895432478A020E2C5B6C5FFB2C2@AM0PR08MB4289.eurprd08.prod.outlook.com>
 <AM0PR08MB428921B21B38D517A8A61FC4FB002@AM0PR08MB4289.eurprd08.prod.outlook.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <AM0PR08MB428921B21B38D517A8A61FC4FB002@AM0PR08MB4289.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Peter, Ingo, can you please consider merging this fix ?

It adds a missing memory barrier in switch_mm_cid(), which is a
no-op on x86 because switch_mm already provides it. This issue was
reported more than a month ago.

Thanks,

Mathieu

On 2024-04-08 05:38, Yeo Reum Yun wrote:
> Gentle ping...
> 
> ________________________________________
> From: Yeo Reum Yun <YeoReum.Yun@arm.com>
> Sent: 19 March 2024 09:20
> To: Mathieu Desnoyers; Ingo Molnar; Peter Zijlstra
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Steven Rostedt; Vincent Guittot; Juri Lelli; Dietmar Eggemann; Ben Segall; Mel Gorman; Daniel Bristot de Oliveira; Valentin Schneider; Catalin Marinas; Mark Rutland; Will Deacon; Aaron Lu
> Subject: Re: [PATCH] sched: Add missing memory barrier in switch_mm_cid
> 
> Gentle ping.
> 
> ________________________________________
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Sent: 08 March 2024 15:07
> To: Ingo Molnar; Peter Zijlstra
> Cc: linux-kernel@vger.kernel.org; Mathieu Desnoyers; Yeo Reum Yun; stable@vger.kernel.org; Steven Rostedt; Vincent Guittot; Juri Lelli; Dietmar Eggemann; Ben Segall; Mel Gorman; Daniel Bristot de Oliveira; Valentin Schneider; Catalin Marinas; Mark Rutland; Will Deacon; Aaron Lu
> Subject: [PATCH] sched: Add missing memory barrier in switch_mm_cid
> 
> Many architectures' switch_mm() (e.g. arm64) do not have an smp_mb()
> which the core scheduler code has depended upon since commit:
> 
>      commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
> 
> If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear() can
> unset the actively used cid when it fails to observe active task after it
> sets lazy_put.
> 
> There *is* a memory barrier between storing to rq->curr and _return to
> userspace_ (as required by membarrier), but the rseq mm_cid has stricter
> requirements: the barrier needs to be issued between store to rq->curr
> and switch_mm_cid(), which happens earlier than:
> 
> - spin_unlock(),
> - switch_to().
> 
> So it's fine when the architecture switch_mm happens to have that barrier
> already, but less so when the architecture only provides the full barrier
> in switch_to() or spin_unlock().
> 
> It is a bug in the rseq switch_mm_cid() implementation. All architectures
> that don't have memory barriers in switch_mm(), but rather have the full
> barrier either in finish_lock_switch() or switch_to() have them too late
> for the needs of switch_mm_cid().
> 
> Introduce a new smp_mb__after_switch_mm(), defined as smp_mb() in the
> generic barrier.h header, and use it in switch_mm_cid() for scheduler
> transitions where switch_mm() is expected to provide a memory barrier.
> 
> Architectures can override smp_mb__after_switch_mm() if their
> switch_mm() implementation provides an implicit memory barrier.
> Override it with a no-op on x86 which implicitly provide this memory
> barrier by writing to CR3.
> 
> Link: https://lore.kernel.org/lkml/20240305145335.2696125-1-yeoreum.yun@arm.com/
> Reported-by: levi.yun <yeoreum.yun@arm.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Cc: <stable@vger.kernel.org> # 6.4.x
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: levi.yun <yeoreum.yun@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> ---
>   arch/x86/include/asm/barrier.h |  3 +++
>   include/asm-generic/barrier.h  |  8 ++++++++
>   kernel/sched/sched.h           | 20 ++++++++++++++------
>   3 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 35389b2af88e..0d5e54201eb2 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -79,6 +79,9 @@ do {                                                                  \
>   #define __smp_mb__before_atomic()      do { } while (0)
>   #define __smp_mb__after_atomic()       do { } while (0)
> 
> +/* Writing to CR3 provides a full memory barrier in switch_mm(). */
> +#define smp_mb__after_switch_mm()      do { } while (0)
> +
>   #include <asm-generic/barrier.h>
> 
>   /*
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 961f4d88f9ef..5a6c94d7a598 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -296,5 +296,13 @@ do {                                                                       \
>   #define io_stop_wc() do { } while (0)
>   #endif
> 
> +/*
> + * Architectures that guarantee an implicit smp_mb() in switch_mm()
> + * can override smp_mb__after_switch_mm.
> + */
> +#ifndef smp_mb__after_switch_mm
> +#define smp_mb__after_switch_mm()      smp_mb()
> +#endif
> +
>   #endif /* !__ASSEMBLY__ */
>   #endif /* __ASM_GENERIC_BARRIER_H */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e5a95486a42..044d842c696c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -79,6 +79,8 @@
>   # include <asm/paravirt_api_clock.h>
>   #endif
> 
> +#include <asm/barrier.h>
> +
>   #include "cpupri.h"
>   #include "cpudeadline.h"
> 
> @@ -3481,13 +3483,19 @@ static inline void switch_mm_cid(struct rq *rq,
>                   * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
>                   * Provide it here.
>                   */
> -               if (!prev->mm)                          // from kernel
> +               if (!prev->mm) {                        // from kernel
>                          smp_mb();
> -               /*
> -                * user -> user transition guarantees a memory barrier through
> -                * switch_mm() when current->mm changes. If current->mm is
> -                * unchanged, no barrier is needed.
> -                */
> +               } else {                                // from user
> +                       /*
> +                        * user -> user transition relies on an implicit
> +                        * memory barrier in switch_mm() when
> +                        * current->mm changes. If the architecture
> +                        * switch_mm() does not have an implicit memory
> +                        * barrier, it is emitted here.  If current->mm
> +                        * is unchanged, no barrier is needed.
> +                        */
> +                       smp_mb__after_switch_mm();
> +               }
>          }
>          if (prev->mm_cid_active) {
>                  mm_cid_snapshot_time(rq, prev->mm);
> --
> 2.39.2
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


