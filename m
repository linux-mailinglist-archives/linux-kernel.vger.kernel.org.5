Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CC77CE93B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjJRUm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:42:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C53A4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:42:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC79C433C8;
        Wed, 18 Oct 2023 20:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697661742;
        bh=RjEGy53VoxaTJ1W6q5mGi360GS1eyr9FMldrIArMCz0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j1kPeGY/78hSmBnfGznQt/X0aWbRWjTb5Jo/tG0k2OJ3xWc6Bdz7hcBQmtzA6iyZI
         o3qjzKTMKLpNyH4Y/8apcZ7gq15w2Jix0s+XQGITfm4+u/QogDr94TL/KWL9zeD71M
         Oy9n+di9RLmXc+cLpR8i6Ubt5OjRuvBy+eDZynYk/Ftg5RItc95wZ6DeNSSRFasuVA
         64gTJN56FCsK1JermJPfkAJ/yyEzphkCoS1LoOKoI9aoHpbClodn7CGvCPLuVPM5ly
         eZteM358//nFpcTn51vxpXq/2xqZWgLGpnoZd+VvNrRDMPaSIwspgPtpvGajixWRtD
         GpDcv8xJWVguw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DBF3ECE0BB0; Wed, 18 Oct 2023 13:42:21 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:42:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ebfe3ca1-2f48-42ce-9d03-513a8c1bc530@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
 <87r0lroffj.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0lroffj.fsf@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:15:28PM -0700, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
> >> Paul!
> >>
> >> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
> >> > Belatedly calling out some RCU issues.  Nothing fatal, just a
> >> > (surprisingly) few adjustments that will need to be made.  The key thing
> >> > to note is that from RCU's viewpoint, with this change, all kernels
> >> > are preemptible, though rcu_read_lock() readers remain
> >> > non-preemptible.
> >>
> >> Why? Either I'm confused or you or both of us :)
> >
> > Isn't rcu_read_lock() defined as preempt_disable() and rcu_read_unlock()
> > as preempt_enable() in this approach?  I certainly hope so, as RCU
> > priority boosting would be a most unwelcome addition to many datacenter
> > workloads.
> 
> No, in this approach, PREEMPT_AUTO selects PREEMPTION and thus
> PREEMPT_RCU so rcu_read_lock/unlock() would touch the
> rcu_read_lock_nesting.  Which is identical to what PREEMPT_DYNAMIC does.

Understood.  And we need some way to build a kernel such that RCU
read-side critical sections are non-preemptible.  This is a hard
requirement that is not going away anytime soon.

> >> With this approach the kernel is by definition fully preemptible, which
> >> means means rcu_read_lock() is preemptible too. That's pretty much the
> >> same situation as with PREEMPT_DYNAMIC.
> >
> > Please, just no!!!
> >
> > Please note that the current use of PREEMPT_DYNAMIC with preempt=none
> > avoids preempting RCU read-side critical sections.  This means that the
> > distro use of PREEMPT_DYNAMIC has most definitely *not* tested preemption
> > of RCU readers in environments expecting no preemption.
> 
> Ah. So, though PREEMPT_DYNAMIC with preempt=none runs with PREEMPT_RCU,
> preempt=none stubs out the actual preemption via __preempt_schedule.
> 
> Okay, I see what you are saying.

More to the point, currently, you can build with CONFIG_PREEMPT_DYNAMIC=n
and CONFIG_PREEMPT_NONE=y and have non-preemptible RCU read-side critical
sections.

> (Side issue: but this means that even for PREEMPT_DYNAMIC preempt=none,
> _cond_resched() doesn't call rcu_all_qs().)

I have no idea if anyone runs with CONFIG_PREEMPT_DYNAMIC=y and
preempt=none.  We don't do so.  ;-)

> >> For throughput sake this fully preemptible kernel provides a mechanism
> >> to delay preemption for SCHED_OTHER tasks, i.e. instead of setting
> >> NEED_RESCHED the scheduler sets NEED_RESCHED_LAZY.
> >>
> >> That means the preemption points in preempt_enable() and return from
> >> interrupt to kernel will not see NEED_RESCHED and the tasks can run to
> >> completion either to the point where they call schedule() or when they
> >> return to user space. That's pretty much what PREEMPT_NONE does today.
> >>
> >> The difference to NONE/VOLUNTARY is that the explicit cond_resched()
> >> points are not longer required because the scheduler can preempt the
> >> long running task by setting NEED_RESCHED instead.
> >>
> >> That preemption might be suboptimal in some cases compared to
> >> cond_resched(), but from my initial experimentation that's not really an
> >> issue.
> >
> > I am not (repeat NOT) arguing for keeping cond_resched().  I am instead
> > arguing that the less-preemptible variants of the kernel should continue
> > to avoid preempting RCU read-side critical sections.
> 
> [ snip ]
> 
> >> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
> >> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
> >> CONFIG_RT or such as it does not really change the preemption
> >> model itself. RT just reduces the preemption disabled sections with the
> >> lock conversions, forced interrupt threading and some more.
> >
> > Again, please, no.
> >
> > There are situations where we still need rcu_read_lock() and
> > rcu_read_unlock() to be preempt_disable() and preempt_enable(),
> > repectively.  Those can be cases selected only by Kconfig option, not
> > available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.
> 
> As far as non-preemptible RCU read-side critical sections are concerned,
> are the current
> - PREEMPT_DYNAMIC=y, PREEMPT_RCU, preempt=none config
>   (rcu_read_lock/unlock() do not manipulate preempt_count, but do
>    stub out preempt_schedule())
> - and PREEMPT_NONE=y, TREE_RCU config (rcu_read_lock/unlock() manipulate
>    preempt_count)?
> 
> roughly similar or no?

No.

There is still considerable exposure to preemptible-RCU code paths,
for example, when current->rcu_read_unlock_special.b.blocked is set.

> >> > I am sure that I am missing something, but I have not yet seen any
> >> > show-stoppers.  Just some needed adjustments.
> >>
> >> Right. If it works out as I think it can work out the main adjustments
> >> are to remove a large amount of #ifdef maze and related gunk :)
> >
> > Just please don't remove the #ifdef gunk that is still needed!
> 
> Always the hard part :).

Hey, we wouldn't want to insult your intelligence by letting you work
on too easy of a problem!  ;-)

						Thanx, Paul
