Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B06A7E5287
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjKHJRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjKHJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:17:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFED92
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MDzDW5trhXZAtgtw+EBjub3mRJGPR6d0OzZtQvClRM4=; b=UNGYz+wK9LkozU0IkOzlx4xix1
        ivVakekP4PyZR/aG5WewvFjBAxtxyIxOdXmDdeddsRf4S/4SZj+mZpXLFcvMaHDRiwhMFNqwWzULX
        hI6+ixYRu+KP2ncm0KUJJtGlhoYEEFYcPRbT9p7dpEkqv73IrdqA8I+WzLxf40bfuBU5ZcIautP/j
        bRvNKysBSYlerKQHXr4ufr2YL7zRs2kpgI7lEAxsOVybC6/8sI5cnUEOcy7m1oOQJpctUfo6KS46I
        f8mU+XbqVrz6wDGfYteIPLZ5fOwthUxG1+Ik2rovKSfEj2dEhFsYVOpEm9n5rYQPTqn+pRSyf/mKV
        Pgq4YUlg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0egF-0008Z5-JL; Wed, 08 Nov 2023 09:17:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA16630049D; Wed,  8 Nov 2023 10:16:59 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:16:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 40/86] context_tracking: add ct_state_cpu()
Message-ID: <20231108091659.GK8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-41-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-41-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:26PM -0800, Ankur Arora wrote:
> While making up its mind about whether to reschedule a target
> runqueue eagerly or lazily, resched_curr() needs to know if the
> target is executing in the kernel or in userspace.
> 
> Add ct_state_cpu().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> ---
> Using context-tracking for this seems like overkill. Is there a better
> way to achieve this? One problem with depending on user_enter() is that
> it happens much too late for our purposes. From the scheduler's
> point-of-view the exit state has effectively transitioned once the
> task exits the exit_to_user_loop() so we will see stale state
> while the task is done with exit_to_user_loop() but has not yet
> executed user_enter().
> 
> ---
>  include/linux/context_tracking_state.h | 21 +++++++++++++++++++++
>  kernel/Kconfig.preempt                 |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index bbff5f7f8803..6a8f1c7ba105 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -53,6 +53,13 @@ static __always_inline int __ct_state(void)
>  {
>  	return raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
>  }
> +
> +static __always_inline int __ct_state_cpu(int cpu)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +
> +	return atomic_read(&ct->state) & CT_STATE_MASK;
> +}
>  #endif
>  
>  #ifdef CONFIG_CONTEXT_TRACKING_IDLE
> @@ -139,6 +146,20 @@ static __always_inline int ct_state(void)
>  	return ret;
>  }
>  
> +static __always_inline int ct_state_cpu(int cpu)
> +{
> +	int ret;
> +
> +	if (!context_tracking_enabled_cpu(cpu))
> +		return CONTEXT_DISABLED;
> +
> +	preempt_disable();
> +	ret = __ct_state_cpu(cpu);
> +	preempt_enable();
> +
> +	return ret;
> +}

Those preempt_disable/enable are pointless.

But this patch is problematic, you do *NOT* want to rely on context
tracking. Context tracking adds atomics to the entry path, this is slow
and even with CONFIG_CONTEXT_TRACKING it is disabled until you configure
the NOHZ_FULL nonsense.

This simply cannot be.
