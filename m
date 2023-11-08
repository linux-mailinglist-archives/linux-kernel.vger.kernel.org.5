Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9E7E5484
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344554AbjKHKup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344750AbjKHKub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:50:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C1D4789
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ztB9pBHiFR07Il8Vv5GBfT7IWnf46mh1rpUe76Z1+FE=; b=j6aB/r9AvPhSHnZ2k8Xnwo+0Yy
        pdqDyjhNVN1LOPglg8yHSd5dWVGtI094Cxa4G6FozEGClloZHH8QezTIOo1b0oHPY7dWwvnoysMIP
        habOzZdjI+IebmFt1ZBHYd60uuY4En7eoedJZptanwhjLlWAfYfo/qGgNhLIleiSm4AyjzZL8oZ39
        0Vl/vQvDRG1S32H3qyvEcXRsK5uZF/3YOeNXVoayP4o5WF6/Tv+najNJhrHXPy6trzwbWaBnKqoZB
        2tGC0/19M6GHaQBPzH/8imiZMqKayhx0wq6SNXPM9OnL0B2a6owhtyd4xpN4ABtG2IXSYNcoWm1O3
        PscoOjHw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0g4e-00DPVe-0N;
        Wed, 08 Nov 2023 10:46:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBC2330049D; Wed,  8 Nov 2023 11:46:15 +0100 (CET)
Date:   Wed, 8 Nov 2023 11:46:15 +0100
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
Subject: Re: [RFC PATCH 41/86] sched: handle resched policy in resched_curr()
Message-ID: <20231108104615.GO8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-42-ankur.a.arora@oracle.com>
 <20231108093645.GL8262@noisy.programming.kicks-ass.net>
 <87fs1gk0bm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs1gk0bm.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 02:26:37AM -0800, Ankur Arora wrote:
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Tue, Nov 07, 2023 at 01:57:27PM -0800, Ankur Arora wrote:
> >
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -1027,13 +1027,13 @@ void wake_up_q(struct wake_q_head *head)
> >>  }
> >>
> >>  /*
> >> - * resched_curr - mark rq's current task 'to be rescheduled now'.
> >> + * __resched_curr - mark rq's current task 'to be rescheduled'.
> >>   *
> >> - * On UP this means the setting of the need_resched flag, on SMP it
> >> - * might also involve a cross-CPU call to trigger the scheduler on
> >> - * the target CPU.
> >> + * On UP this means the setting of the need_resched flag, on SMP, for
> >> + * eager resched it might also involve a cross-CPU call to trigger
> >> + * the scheduler on the target CPU.
> >>   */
> >> -void resched_curr(struct rq *rq)
> >> +void __resched_curr(struct rq *rq, resched_t rs)
> >>  {
> >>  	struct task_struct *curr = rq->curr;
> >>  	int cpu;
> >> @@ -1046,17 +1046,77 @@ void resched_curr(struct rq *rq)
> >>  	cpu = cpu_of(rq);
> >>
> >>  	if (cpu == smp_processor_id()) {
> >> -		set_tsk_need_resched(curr, RESCHED_eager);
> >> -		set_preempt_need_resched();
> >> +		set_tsk_need_resched(curr, rs);
> >> +		if (rs == RESCHED_eager)
> >> +			set_preempt_need_resched();
> >>  		return;
> >>  	}
> >>
> >> -	if (set_nr_and_not_polling(curr, RESCHED_eager))
> >> -		smp_send_reschedule(cpu);
> >> -	else
> >> +	if (set_nr_and_not_polling(curr, rs)) {
> >> +		if (rs == RESCHED_eager)
> >> +			smp_send_reschedule(cpu);
> >
> > I think you just broke things.
> >
> > Not all idle threads have POLLING support, in which case you need that
> > IPI to wake them up, even if it's LAZY.
> 
> Yes, I was concerned about that too. But doesn't this check against the
> idle_sched_class in resched_curr() cover that?

I that's what that was. Hmm, maybe.

I mean, we have idle-injection too, those don't as FIFO, but as such,
they can only get preempted from RT/DL, and those will already force
preempt anyway.

The way you've split and structured the code makes it very hard to
follow. Something like:

	if (set_nr_and_not_polling(curr, rs) &&
	    (rs == RESCHED_force || is_idle_task(curr)))
		smp_send_reschedule();

is *far* clearer, no?
