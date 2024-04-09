Return-Path: <linux-kernel+bounces-136667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FD89D6DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8560B1F225AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9870782883;
	Tue,  9 Apr 2024 10:17:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4D7F482;
	Tue,  9 Apr 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657838; cv=none; b=Lthr2DbitRhF3AX3/RSDtnT7cnw0RBTYkGbZl91nywiYTJArKsaAmh8RDbnFs+IHoeZHotulhsNbcvbbtFcc2mcipt2I9yTz2uitwO2W60E3jl9BG8w4Lg1q1YJv4LADd8zcQOoWz94W+vnhpgs17RUmr1QvkyW8s9tYUnHMHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657838; c=relaxed/simple;
	bh=PnhPyTJsR2kysR6qD9bNLqvMTYpX2niQDC8JCyRLBiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMDqnRbyTD5lLAs0R6KlCIZEsjG66izdyTGWqRtbI9oBy2ypiGZNEgmf2s4e2YGw57ObOkA2mimikbxrNKh/dmGlABBpO3YP7RQ+tZ6zA6xzb4Nzs+hCGYNFp/13pP6hca17irEBsIbTo5bLbPIVnrxiHwbymqVDE8kZEOv5nro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6221BC433F1;
	Tue,  9 Apr 2024 10:17:14 +0000 (UTC)
Date: Tue, 9 Apr 2024 11:17:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, "levi . yun" <yeoreum.yun@arm.com>,
	stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] sched: Add missing memory barrier in switch_mm_cid
Message-ID: <ZhUVpwwqKxWKgU0Q@arm.com>
References: <20240308150719.676738-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308150719.676738-1-mathieu.desnoyers@efficios.com>

On Fri, Mar 08, 2024 at 10:07:19AM -0500, Mathieu Desnoyers wrote:
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 35389b2af88e..0d5e54201eb2 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -79,6 +79,9 @@ do {									\
>  #define __smp_mb__before_atomic()	do { } while (0)
>  #define __smp_mb__after_atomic()	do { } while (0)
>  
> +/* Writing to CR3 provides a full memory barrier in switch_mm(). */
> +#define smp_mb__after_switch_mm()	do { } while (0)
> +
>  #include <asm-generic/barrier.h>
>  
>  /*
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 961f4d88f9ef..5a6c94d7a598 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -296,5 +296,13 @@ do {									\
>  #define io_stop_wc() do { } while (0)
>  #endif
>  
> +/*
> + * Architectures that guarantee an implicit smp_mb() in switch_mm()
> + * can override smp_mb__after_switch_mm.
> + */
> +#ifndef smp_mb__after_switch_mm
> +#define smp_mb__after_switch_mm()	smp_mb()
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __ASM_GENERIC_BARRIER_H */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e5a95486a42..044d842c696c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -79,6 +79,8 @@
>  # include <asm/paravirt_api_clock.h>
>  #endif
>  
> +#include <asm/barrier.h>
> +
>  #include "cpupri.h"
>  #include "cpudeadline.h"
>  
> @@ -3481,13 +3483,19 @@ static inline void switch_mm_cid(struct rq *rq,
>  		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
>  		 * Provide it here.
>  		 */
> -		if (!prev->mm)                          // from kernel
> +		if (!prev->mm) {                        // from kernel
>  			smp_mb();
> -		/*
> -		 * user -> user transition guarantees a memory barrier through
> -		 * switch_mm() when current->mm changes. If current->mm is
> -		 * unchanged, no barrier is needed.
> -		 */
> +		} else {				// from user
> +			/*
> +			 * user -> user transition relies on an implicit
> +			 * memory barrier in switch_mm() when
> +			 * current->mm changes. If the architecture
> +			 * switch_mm() does not have an implicit memory
> +			 * barrier, it is emitted here.  If current->mm
> +			 * is unchanged, no barrier is needed.
> +			 */
> +			smp_mb__after_switch_mm();
> +		}

I'm fine with the change from the arm64 perspective but I guess we need
an ack from the x86 and sched maintainers. FWIW:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

