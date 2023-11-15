Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B337EC7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjKOPxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjKOPxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:53:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2746C1984
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ohw8B+zfYq83PiKh9y615T9FB+14QEtb0yQj55L35vo=; b=kbDZgjCN23Mf9HFPPOewICpcar
        nLURtKdc1k6B7eeBATeTKp9Y+LOA7fC3C9voX6MdqlD+W9VPemJ64b9hP8uP8Wa/3j7PRiXDwIxRK
        yoKrVsk8QtAWkSGGi/+kL1C+Pgd/OQ/sZXiI7z2UoMcP3q+pMMOlRVN1me7w2yIoLnOepceCcSqip
        yitP+LxYnYpPKgA/MyxeC/88Mqx9N30WuTXOxY/ukZYqKEbkdquXlHFh2AP6pC2mLYiwCcY2AiiLC
        YpEG8nBj6zQ8Mh5EVIYtvSWZMx/IWAWULNWIkny1IMirGPrK3g2ervG7ZDvdOrKDvWg5Zfkp4MQZt
        Dhb9TSCA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3IBs-0047qU-2V;
        Wed, 15 Nov 2023 15:52:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 709B1300427; Wed, 15 Nov 2023 16:52:32 +0100 (CET)
Date:   Wed, 15 Nov 2023 16:52:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer
 reprogram
Message-ID: <20231115155232.GD8262@noisy.programming.kicks-ass.net>
References: <20231115151325.6262-1-frederic@kernel.org>
 <20231115151325.6262-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115151325.6262-3-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:13:23AM -0500, Frederic Weisbecker wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> intel_idle_irq() re-enables IRQs very early. As a result, an interrupt
> may fire before mwait() is eventually called. If such an interrupt queues
> a timer, it may go unnoticed until mwait returns and the idle loop
> handles the tick re-evaluation. And monitoring TIF_NEED_RESCHED doesn't
> help because a local timer enqueue doesn't set that flag.
> 
> The issue is mitigated by the fact that this idle handler is only invoked
> for shallow C-states when, presumably, the next tick is supposed to be
> close enough. There may still be rare cases though when the next tick
> is far away and the selected C-state is shallow, resulting in a timer
> getting ignored for a while.
> 
> Fix this with using sti_mwait() whose IRQ-reenablement only triggers
> upon calling mwait(), dealing with the race while keeping the interrupt
> latency within acceptable bounds.
> 
> Fixes: c227233ad64c (intel_idle: enable interrupts before C1 on Xeons)
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>

Feel free to change to normal SOB, I'm assuming it actually compiles and
works by now :-)

> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/x86/include/asm/mwait.h | 11 +++++++++--
>  drivers/idle/intel_idle.c    | 19 +++++++------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 341ee4f1d91e..920426d691ce 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -124,8 +124,15 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
>  		}
>  
>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> -		if (!need_resched())
> -			__mwait(eax, ecx);
> +
> +		if (!need_resched()) {
> +			if (ecx & 1) {
> +				__mwait(eax, ecx);
> +			} else {
> +				__sti_mwait(eax, ecx);
> +				raw_local_irq_disable();
> +			}
> +		}
>  	}
>  	current_clr_polling();
>  }
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index dcda0afecfc5..3e01a6b23e75 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -131,11 +131,12 @@ static unsigned int mwait_substates __initdata;
>  #define MWAIT2flg(eax) ((eax & 0xFF) << 24)
>  
>  static __always_inline int __intel_idle(struct cpuidle_device *dev,
> -					struct cpuidle_driver *drv, int index)
> +					struct cpuidle_driver *drv,
> +					int index, bool irqoff)
>  {
>  	struct cpuidle_state *state = &drv->states[index];
>  	unsigned long eax = flg2MWAIT(state->flags);
> -	unsigned long ecx = 1; /* break on interrupt flag */
> +	unsigned long ecx = 1*irqoff; /* break on interrupt flag */
>  
>  	mwait_idle_with_hints(eax, ecx);
>  
> @@ -159,19 +160,13 @@ static __always_inline int __intel_idle(struct cpuidle_device *dev,
>  static __cpuidle int intel_idle(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv, int index)
>  {
> -	return __intel_idle(dev, drv, index);
> +	return __intel_idle(dev, drv, index, true);
>  }
>  
>  static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
>  				    struct cpuidle_driver *drv, int index)
>  {
> -	int ret;
> -
> -	raw_local_irq_enable();
> -	ret = __intel_idle(dev, drv, index);
> -	raw_local_irq_disable();
> -
> -	return ret;
> +	return __intel_idle(dev, drv, index, false);
>  }
>  
>  static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
> @@ -184,7 +179,7 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
>  	if (smt_active)
>  		__update_spec_ctrl(0);
>  
> -	ret = __intel_idle(dev, drv, index);
> +	ret = __intel_idle(dev, drv, index, true);
>  
>  	if (smt_active)
>  		__update_spec_ctrl(spec_ctrl);
> @@ -196,7 +191,7 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
>  				       struct cpuidle_driver *drv, int index)
>  {
>  	fpu_idle_fpregs();
> -	return __intel_idle(dev, drv, index);
> +	return __intel_idle(dev, drv, index, true);
>  }
>  
>  /**
> -- 
> 2.42.1
> 
