Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28347FC13C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbjK1REd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjK1REb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:04:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE54110EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:04:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701191074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xfko3HMIoKv9mdpGScU+7vTPH+jGNQNO1UKU6GwR9yA=;
        b=07ofSme9YUvQgryEpVhg44lrLogDCyumJ3hy4MaHGcCnBrz236kh0U9II9+lblo874CUXO
        te5W3gSbGGj0bWX/Lc6oGvz4jR1XwkdFKHpzBZ8GzcsRT++j/W+JswAAT/WclHpqsR8xle
        swMpHjkGMK6Me7zldR7DH5Ipgmu1o1zT8j8yiL/o8odJM3KK2dXaU/Kr9kDsazzWnJOe66
        0SQfTWPugExYwTdUhtdaM3eRsi+QWCaF4tbvTvFxR7VvSyQkU9kef5ftEx4ys/Sj34ebz/
        zSl1k0Io1mpm0SJtdEtta+sO3a32z0ZaITI944s9qyBoyWs6z2RuFEI7qxiRTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701191074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xfko3HMIoKv9mdpGScU+7vTPH+jGNQNO1UKU6GwR9yA=;
        b=EVBWFb7XtKdcqybnG2Hs74oRpvnl8zsjRZH0FVFTjyRJVXM0GwjBQH9y9Sn/xE3p6L5o3D
        AclsCwKiP2kvRyDw==
To:     paulmck@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
In-Reply-To: <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
Date:   Tue, 28 Nov 2023 18:04:33 +0100
Message-ID: <87v89lzu5a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

On Mon, Nov 20 2023 at 16:38, Paul E. McKenney wrote:
> But...
>
> Suppose we have a long-running loop in the kernel that regularly
> enables preemption, but only momentarily.  Then the added
> rcu_flavor_sched_clock_irq() check would almost always fail, making
> for extremely long grace periods.  Or did I miss a change that causes
> preempt_enable() to help RCU out?

So first of all this is not any different from today and even with
RCU_PREEMPT=y a tight loop:

    do {
    	preempt_disable();
        do_stuff();
        preempt_enable();
    }

will not allow rcu_flavor_sched_clock_irq() to detect QS reliably. All
it can do is to force reschedule/preemption after some time, which in
turn ends up in a QS.

The current NONE/VOLUNTARY models, which imply RCU_PRREMPT=n cannot do
that at all because the preempt_enable() is a NOOP and there is no
preemption point at return from interrupt to kernel.

    do {
        do_stuff();
    }

So the only thing which makes that "work" is slapping a cond_resched()
into the loop:

    do {
        do_stuff();
        cond_resched();
    }

But the whole concept behind LAZY is that the loop will always be:

    do {
    	preempt_disable();
        do_stuff();
        preempt_enable();
    }

and the preempt_enable() will always be a functional preemption point.

So let's look at the simple case where more than one task is runnable on
a given CPU:

    loop()

      preempt_disable();

      --> tick interrupt
          set LAZY_NEED_RESCHED

      preempt_enable() -> Does nothing because NEED_RESCHED is not set

      preempt_disable();

      --> tick interrupt
          set NEED_RESCHED

      preempt_enable()
        preempt_schedule()
          schedule()
            report_QS()

which means that on the second tick a quiesent state is
reported. Whether that's really going to be a full tick which is granted
that's a scheduler decision and implementation detail and not really
relevant for discussing the concept.

Now the problematic case is when there is only one task runnable on a
given CPU because then the tick interrupt will set neither of the
preemption bits. Which is fine from a scheduler perspective, but not so
much from a RCU perspective.

But the whole point of LAZY is to be able to enforce rescheduling at the
next possible preemption point. So RCU can utilize that too:

rcu_flavor_sched_clock_irq(bool user)
{
	if (user || rcu_is_cpu_rrupt_from_idle() ||
	    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
		rcu_qs();
                return;
	}

        if (this_cpu_read(rcu_data.rcu_urgent_qs))
        	set_need_resched();
}

So:

    loop()

      preempt_disable();

      --> tick interrupt
            rcu_flavor_sched_clock_irq()
                sets NEED_RESCHED

      preempt_enable()
        preempt_schedule()
          schedule()
            report_QS()

See? No magic nonsense in preempt_enable(), no cond_resched(), nothing.

The above rcu_flavor_sched_clock_irq() check for rcu_data.rcu_urgent_qs
is not really fundamentaly different from the check in rcu_all_gs(). The
main difference is that it is bound to the tick, so the detection/action
might be delayed by a tick. If that turns out to be a problem, then this
stuff has far more serious issues underneath.

So now you might argue that for a loop like this:

    do {
        mutex_lock();
        do_stuff();
        mutex_unlock();
    }

the ideal preemption point is post mutex_unlock(), which is where
someone would mindfully (*cough*) place a cond_resched(), right?

So if that turns out to matter in reality and not just by academic
inspection, then we are far better off to annotate such code with:

    do {
        preempt_lazy_disable();
        mutex_lock();
        do_stuff();
        mutex_unlock();
        preempt_lazy_enable();
    }

and let preempt_lazy_enable() evaluate the NEED_RESCHED_LAZY bit.

Then rcu_flavor_sched_clock_irq(bool user) can then use a two stage
approach like the scheduler:

rcu_flavor_sched_clock_irq(bool user)
{
	if (user || rcu_is_cpu_rrupt_from_idle() ||
	    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
		rcu_qs();
                return;
	}

        if (this_cpu_read(rcu_data.rcu_urgent_qs)) {
        	if (!need_resched_lazy()))
                	set_need_resched_lazy();
                else
                	set_need_resched();
	}
}

But for a start I would just use the trivial

        if (this_cpu_read(rcu_data.rcu_urgent_qs))
        	set_need_resched();

approach and see where this gets us.

With the approach I suggested to Ankur, i.e. having PREEMPT_AUTO(or
LAZY) as a config option we can work on the details of the AUTO and
RCU_PREEMPT=n flavour up to the point where we are happy to get rid
of the whole zoo of config options alltogether.

Just insisting that RCU_PREEMPT=n requires cond_resched() and whatsoever
is not really getting us anywhere.

Thanks,

        tglx
