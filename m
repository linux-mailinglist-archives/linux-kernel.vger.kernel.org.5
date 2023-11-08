Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C027E527E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjKHJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:16:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6409F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NR0g9BKr77ws3D/m5qgi4Wp76NEsG9kBIfak+efSzws=; b=N+IBcm5Dq2CxC8jXsVZFdx3HIc
        sjqcOeScrYOcuPxSAORHGyHw9AgttFmoinbUY1uiZESG4pw7i4MxtUUezjGI1SRjbfglh4HtTKawA
        ARYVVKMSPqBbl1yoQJuOzodSIaYgUJrEGBDhk2IUBeS8ubBnPXK1DIW65gd2Du7D1vvssLAdJ2OF/
        19F96R4ISFyLLo8nPzMNdJoASVzOjTBpvsGnSU5/HtoDHH84c4u3JLKhgzFprsPKzU+1bYemlrgmJ
        D73lnRT0hbz9YxHqKKqDoCXfZ6b0SyN0I24O+A+UvLURUyw8MWU+bizSOXKk/afmMj/gygRH7tkUK
        xHAcAiLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0eeR-0008UP-WC; Wed, 08 Nov 2023 09:15:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5130D30049D; Wed,  8 Nov 2023 10:15:08 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:15:08 +0100
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
Subject: Re: [RFC PATCH 39/86] sched: handle lazy resched in
 set_nr_*_polling()
Message-ID: <20231108091508.GJ8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-40-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-40-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:25PM -0800, Ankur Arora wrote:
> To trigger a reschedule on a target runqueue a few things need
> to happen first:
> 
>   1. set_tsk_need_resched(target_rq->curr, RESCHED_eager)
>   2. ensure that the target CPU sees the need-resched bit
>   3. preempt_fold_need_resched()
> 
> Most of this is done via some combination of: resched_curr(),
> set_nr_if_polling(), and set_nr_and_not_polling().
> 
> Update the last two to also handle TIF_NEED_RESCHED_LAZY.
> 
> One thing to note is that TIF_NEED_RESCHED_LAZY has run to completion
> semantics, so unlike TIF_NEED_RESCHED, we don't need to ensure that
> the caller sees it, and of course there is no preempt folding.
> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/sched/core.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e2215c417323..01df5ac2982c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -892,14 +892,15 @@ static inline void hrtick_rq_init(struct rq *rq)
>  
>  #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
>  /*
> - * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
> + * Atomically set TIF_NEED_RESCHED[_LAZY] and test for TIF_POLLING_NRFLAG,
>   * this avoids any races wrt polling state changes and thereby avoids
>   * spurious IPIs.
>   */
> -static inline bool set_nr_and_not_polling(struct task_struct *p)
> +static inline bool set_nr_and_not_polling(struct task_struct *p, resched_t rs)
>  {
>  	struct thread_info *ti = task_thread_info(p);
> -	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
> +
> +	return !(fetch_or(&ti->flags, _tif_resched(rs)) & _TIF_POLLING_NRFLAG);
>  }

Argh, this it making the whole thing even worse, because now you're
using that eager naming for setting which has the exact opposite meaning
from testing.

> @@ -916,7 +917,7 @@ static bool set_nr_if_polling(struct task_struct *p)
>  	for (;;) {
>  		if (!(val & _TIF_POLLING_NRFLAG))
>  			return false;
> -		if (val & _TIF_NEED_RESCHED)
> +		if (val & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>  			return true;
>  		if (try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED))
>  			break;

Depending on the exact semantics of LAZY this could be wrong, the
Changeog doesn't clarify.

Changing this in a different patch from resched_curr() makes it
impossible to review :/

