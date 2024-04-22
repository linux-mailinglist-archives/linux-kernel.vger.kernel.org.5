Return-Path: <linux-kernel+bounces-153259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36858ACB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497461F22DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C1146010;
	Mon, 22 Apr 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NakQG5tX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D5482C1;
	Mon, 22 Apr 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783924; cv=none; b=dtDWLiwykd2WCUpE8SYwLHkjR2SUm7OJMErTh/+m/G+IMdi8D4R7FU0VBewic12gwQQLJ8ERA1K6mfsEncG9f9ADmvcx0OUvpbu2YmBFcqVaPoC0ZqvEDCjz/Lll5cjK+guzIC1goW6pUMmdzxGJbWazqS7GvlTSm+Fd16KY9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783924; c=relaxed/simple;
	bh=PRohRKUfUiEmboFQxA4mCV2Rrj/5/J6lr0wvdeoG1zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqQg9oL0l8XhTFV6++NyWxwHUgfw7WxxN0TRL1ZioilYPL8xZvlJFGonegoEmPo8H5gr6M8da7QS0mosx9T1w0400N/8xHj/tC1AiUKhCnnuC2AfpbtXoyvwpMLVSi7KhtRMLGRWJuZ174Wb1pdW1qIccY1sv9rJ/e2LUqfXvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NakQG5tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DD9C113CC;
	Mon, 22 Apr 2024 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713783923;
	bh=PRohRKUfUiEmboFQxA4mCV2Rrj/5/J6lr0wvdeoG1zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NakQG5tX/Fxkj1S3yPLRaNGan1G0wWhnPB+8alDQLJalQ3pXBPeALibJbZehoHWUS
	 79DSVrsP6bnPvH+S6aBt/ZUXJx90C2F+66Nlyr8Shdf2ZcVir0M3VAfH3wvEaRfLdG
	 tr+29TngyIeTAwX3fj19XBT91k9pwPocNeh4Q+U8rUoK80qgVPOQK2A1cMURyn6+k8
	 XrbTvt/maPQhsI9ufliGsaVQna7LKshTF9znz78ZQrPAUrzxMBxgMsKjnox1DkLKDW
	 CCTNVpu/pxxKWYRIGEZnGfqsUkPXWgqqjSBB8bfogzfVwe8kqYokVdVz4dpkZ6YHg+
	 9EkIG6w3BAcFA==
Date: Mon, 22 Apr 2024 13:05:20 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Nadav Amit <namit@vmware.com>,
	Breno Leitao <leitao@debian.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 09/10] x86/rcu: Add rcu_preempt_count
Message-ID: <ZiZEcBEvK8NOQvwU@localhost.localdomain>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
 <20240328075318.83039-10-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328075318.83039-10-jiangshanlai@gmail.com>

Le Thu, Mar 28, 2024 at 03:53:17PM +0800, Lai Jiangshan a écrit :
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Implement PCPU_RCU_PREEMPT_COUNT for x86.
> Mainly copied from asm/preempt.h
> 
> Make rcu_read_[un]lock() inlined for rcu-preempt.
> Make rcu_read_lock() only one instruction.
> Make rcu_read_unlock() only two instructions in the fast path.
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/Kconfig                   |   1 +
>  arch/x86/include/asm/current.h     |   3 +
>  arch/x86/include/asm/rcu_preempt.h | 107 +++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/common.c       |   7 +-
>  4 files changed, 115 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/include/asm/rcu_preempt.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 78050d5d7fac..7eb17c12f7b7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -257,6 +257,7 @@ config X86
>  	select HAVE_OBJTOOL			if X86_64
>  	select HAVE_OPTPROBES
>  	select HAVE_PAGE_SIZE_4KB
> +	select HAVE_PCPU_RCU_PREEMPT_COUNT
>  	select HAVE_PCSPKR_PLATFORM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_EVENTS_NMI
> diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
> index bf5953883ec3..dcc2ef784120 100644
> --- a/arch/x86/include/asm/current.h
> +++ b/arch/x86/include/asm/current.h
> @@ -24,6 +24,9 @@ struct pcpu_hot {
>  			unsigned long		top_of_stack;
>  			void			*hardirq_stack_ptr;
>  			u16			softirq_pending;
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +			int			rcu_preempt_count;
> +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
>  #ifdef CONFIG_X86_64
>  			bool			hardirq_stack_inuse;
>  #else
> diff --git a/arch/x86/include/asm/rcu_preempt.h b/arch/x86/include/asm/rcu_preempt.h
> new file mode 100644
> index 000000000000..cb25ebe038a5
> --- /dev/null
> +++ b/arch/x86/include/asm/rcu_preempt.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_RCU_PREEMPT_H
> +#define __ASM_RCU_PREEMPT_H
> +
> +#include <asm/rmwcc.h>
> +#include <asm/percpu.h>
> +#include <asm/current.h>
> +
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +
> +/* We use the MSB mostly because its available */

I think you can safely remove the "We " from all the comments :-)

> +#define RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED	0x80000000

How about RCU_PREEMPT_UNLOCK_FASTPATH ?

> +
> +/*
> + * We use the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit as an inverted
> + * current->rcu_read_unlock_special.s such that a decrement hitting 0
> + * means we can and should call rcu_read_unlock_special().
> + */
> +#define RCU_PREEMPT_INIT	(0 + RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED)

Or simply:

#define RCU_PREEMPT_INIT     RCU_PREEMPT_UNLOCK_FASTPATH

Or you can even remove RCU_PREEMPT_INIT and use RCU_PREEMPT_UNLOCK_FASTPATH directly.

> +/*
> + * Because we keep RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED set when we do
> + * _not_ need to handle unlock-special for a fast-path decrement.
> + */
> +static __always_inline bool pcpu_rcu_preempt_count_dec_and_test(void)
> +{
> +	return GEN_UNARY_RMWcc("decl", __my_cpu_var(pcpu_hot.rcu_preempt_count), e,
> +			       __percpu_arg([var]));
> +}
> +
> +#define pcpu_rcu_read_unlock_special()						\
> +do {										\
> +	rcu_read_unlock_special();						\
> +} while (0)

Why not just call that directly?

> +
> +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +
> +#endif /* __ASM_RCU_PREEMPT_H */
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index ba8cf5e9ce56..0b204a649442 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1992,9 +1992,10 @@ static __init int setup_clearcpuid(char *arg)
>  __setup("clearcpuid=", setup_clearcpuid);
>  
>  DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
> -	.current_task	= &init_task,
> -	.preempt_count	= INIT_PREEMPT_COUNT,
> -	.top_of_stack	= TOP_OF_INIT_STACK,
> +	.current_task		= &init_task,
> +	.preempt_count		= INIT_PREEMPT_COUNT,
> +	.top_of_stack		= TOP_OF_INIT_STACK,
> +	.rcu_preempt_count	= RCU_PREEMPT_INIT,

#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT ?

Thanks.


>  };
>  EXPORT_PER_CPU_SYMBOL(pcpu_hot);
>  EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
> -- 
> 2.19.1.6.gb485710b
> 

