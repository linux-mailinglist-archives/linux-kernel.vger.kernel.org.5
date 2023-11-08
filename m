Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE507E524E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjKHJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjKHJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:01:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141DE172A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bat+oFMjR+WD3rQTX+7QbHoxEOeuaClOIahl7QgxMgo=; b=bazDYm4KTzY0ZMyl6+axaxsEjE
        7T8MT0/yOgOBFx77kVQyxtufb5esI5BMIRuyggU3wWJwpBU7m8+bDv/oSlZrrJQmIzBR6+DTQc9SK
        dzeMkO8XCKu5NeWcJMufsdqW3pOqWmcBvCUVlACAi+TP4MLOArePZzSoaaTXhrbZRD0AVoYFRKeX3
        /jl5L3HxbVaKHVvw6feHBHhKHO2jVM9KDd2yeVXzp2kdfBbShw661vjCNh/zkfdYPSdC1bUebhcxp
        XXzPECHGfvkyIINm76X11wEQhvgsdfM/RldnPoEzo4PqrJMGJv3Q9ztEao4QteYGztMdLBBE7vApo
        CPNfe6HA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0eQp-00DMsX-3B;
        Wed, 08 Nov 2023 09:01:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A015A30049D; Wed,  8 Nov 2023 10:01:03 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:01:03 +0100
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
Subject: Re: [RFC PATCH 36/86] entry: irqentry_exit only preempts
 TIF_NEED_RESCHED
Message-ID: <20231108090103.GG8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-37-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-37-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:22PM -0800, Ankur Arora wrote:
> The scheduling policy for RESCHED_lazy (TIF_NEED_RESCHED_LAZY) is
> to let anything running in the kernel run to completion.
> Accordingly, while deciding whether to call preempt_schedule_irq()
> narrow the check to tif_need_resched(RESCHED_eager).
> 
> Also add a comment about why we need to check at all, given that we
> have aleady checked the preempt_count().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/entry/common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 0d055c39690b..6433e6c77185 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -384,7 +384,15 @@ void irqentry_exit_cond_resched(void)
>  		rcu_irq_exit_check_preempt();
>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>  			WARN_ON_ONCE(!on_thread_stack());
> -		if (need_resched())
> +
> +		/*
> +		 * If the scheduler really wants us to preempt while returning
> +		 * to kernel, it would set TIF_NEED_RESCHED.
> +		 * On some archs the flag gets folded in preempt_count, and
> +		 * thus would be covered in the conditional above, but not all
> +		 * archs do that, so check explicitly.
> +		 */
> +		if (tif_need_resched(RESCHED_eager))
>  			preempt_schedule_irq();

See, I'm reading this like if we're eager to preempt, but then it's not
actually eager at all and only wants to preempt when forced.

This naming sucks...
