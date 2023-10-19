Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4331E7CECB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjJSAVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJSAVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:21:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A3114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:21:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697674898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgueBkt4kYQzaRy3wxPYD9LBickMKu6tS5euJeZE7UI=;
        b=pLiquqPV1baovoOfFbQq+MjcrHhJdy5RUGkdgN7LZYGV4/1ln1VsvDiCpKOQ538LpSeb9K
        imC7qaT8JqAd6mcXSJ48uHV6SHgKIHudLSC/si0K4jd+bB/l66IOj23mSYn1JgYqAB03P7
        pzuLdM7EfUpYpvSPYY1GmKKT/WyEzRrSGUhksq6XURKbFJlAHG81hCVNIhrEDnSKTfeXMf
        QLox5f6B6BXEVkxUYUfW7vhMjN651fExpe6q0I47i/vfF+HodHSixFgTFRjxcJT+z4p8lz
        p0IonkWqRqhw6ji5k+Gt74e6LDacvxNtCvdWYKoVQdtH21s6gzDQjF0kno0RPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697674898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgueBkt4kYQzaRy3wxPYD9LBickMKu6tS5euJeZE7UI=;
        b=ASPzTGAGnabI9Az9qXprl5havDK+++EZl4kHAYSUkHGkmvhiBdghZ41jr6l5gvPh3ZLzL4
        nL1KlaoGIJWK/YDg==
To:     paulmck@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
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
In-Reply-To: <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
Date:   Thu, 19 Oct 2023 02:21:35 +0200
Message-ID: <8734y74g34.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

On Wed, Oct 18 2023 at 10:19, Paul E. McKenney wrote:
> On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
>> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
>> > Belatedly calling out some RCU issues.  Nothing fatal, just a
>> > (surprisingly) few adjustments that will need to be made.  The key thing
>> > to note is that from RCU's viewpoint, with this change, all kernels
>> > are preemptible, though rcu_read_lock() readers remain
>> > non-preemptible.
>> 
>> Why? Either I'm confused or you or both of us :)
>
> Isn't rcu_read_lock() defined as preempt_disable() and rcu_read_unlock()
> as preempt_enable() in this approach?  I certainly hope so, as RCU
> priority boosting would be a most unwelcome addition to many datacenter
> workloads.

Sure, but that's an orthogonal problem, really.

>> With this approach the kernel is by definition fully preemptible, which
>> means means rcu_read_lock() is preemptible too. That's pretty much the
>> same situation as with PREEMPT_DYNAMIC.
>
> Please, just no!!!
>
> Please note that the current use of PREEMPT_DYNAMIC with preempt=none
> avoids preempting RCU read-side critical sections.  This means that the
> distro use of PREEMPT_DYNAMIC has most definitely *not* tested preemption
> of RCU readers in environments expecting no preemption.

It does not _avoid_ it, it simply _prevents_ it by not preempting in
preempt_enable() and on return from interrupt so whatever sets
NEED_RESCHED has to wait for a voluntary invocation of schedule(),
cond_resched() or return to user space.

But under the hood RCU is fully preemptible and the boosting logic is
active, but it does not have an effect until one of those preemption
points is reached, which makes the boosting moot.

>> For throughput sake this fully preemptible kernel provides a mechanism
>> to delay preemption for SCHED_OTHER tasks, i.e. instead of setting
>> NEED_RESCHED the scheduler sets NEED_RESCHED_LAZY.
>> 
>> That means the preemption points in preempt_enable() and return from
>> interrupt to kernel will not see NEED_RESCHED and the tasks can run to
>> completion either to the point where they call schedule() or when they
>> return to user space. That's pretty much what PREEMPT_NONE does today.
>> 
>> The difference to NONE/VOLUNTARY is that the explicit cond_resched()
>> points are not longer required because the scheduler can preempt the
>> long running task by setting NEED_RESCHED instead.
>> 
>> That preemption might be suboptimal in some cases compared to
>> cond_resched(), but from my initial experimentation that's not really an
>> issue.
>
> I am not (repeat NOT) arguing for keeping cond_resched().  I am instead
> arguing that the less-preemptible variants of the kernel should continue
> to avoid preempting RCU read-side critical sections.

That's the whole point of the lazy mechanism:

   It avoids (repeat AVOIDS) preemption of any kernel code as much as it
   can by _not_ setting NEED_RESCHED.

   The only difference is that it does not _prevent_ it like
   preempt=none does. It will preempt when NEED_RESCHED is set.

Now the question is when will NEED_RESCHED be set?

   1) If the preempting task belongs to a scheduling class above
      SCHED_OTHER

      This is a PoC implementation detail. The lazy mechanism can be
      extended to any other scheduling class w/o a big effort.

      I deliberately did not do that because:

        A) I'm lazy

        B) More importantly I wanted to demonstrate that as long as
           there are only SCHED_OTHER tasks involved there is no forced
           (via NEED_RESCHED) preemption unless the to be preempted task
           ignores the lazy resched request, which proves that
           cond_resched() can be avoided.

           At the same time such a kernel allows a RT task to preempt at
           any time.

   2) If the to be preempted task does not react within a certain time
      frame (I used a full tick in my PoC) on the NEED_RESCHED_LAZY
      request, which is the prerequisite to get rid of cond_resched()
      and related muck.

      That's obviously mandatory for getting rid of cond_resched() and
      related muck, no?

I concede that there are a lot of details to be discussed before we get
there, but I don't see a real show stopper yet.

The important point is that the details are basically boiling down to
policy decisions in the scheduler which are aided by hints from the
programmer.

As I said before we might end up with something like

   preempt_me_not_if_not_absolutely_required();
   ....
   preempt_me_I_dont_care();

(+/- name bike shedding) to give the scheduler a better understanding of
the context.

Something like that has distinct advantages over the current situation
with all the cond_resched() muck:

  1) It is clearly scope based

  2) It is properly nesting

  3) It can be easily made implicit for existing scope constructs like
     rcu_read_lock/unlock() or regular locking mechanisms.

The important point is that at the very end the scheduler has the
ultimate power to say: "Not longer Mr. Nice Guy" without the risk of any
random damage due to the fact that preemption count is functional, which
makes your life easier as well as you admitted already. But that does
not mean you can eat the cake and still have it. :)

That said, I completely understand your worries about the consequences,
but please take the step back and look at it from a conceptual point of
view.

The goal is to replace the hard coded (Kconfig or DYNAMIC) policy
mechanisms with a flexible scheduler controlled policy mechanism.

That allows you to focus on one consolidated model and optimize that
for particular policy scenarios instead of dealing with optimizing the
hell out of hardcoded policies which force you to come up with
horrible workaround for each of them.

Of course the policies have to be defined (scheduling classes affected
depending on model, hint/annotation meaning etc.), but that's way more
palatable than what we have now. Let me give you a simple example:

  Right now the only way out on preempt=none when a rogue code path
  which lacks a cond_resched() fails to release the CPU is a big fat
  stall splat and a hosed machine.

  I rather prefer to have the fully controlled hammer ready which keeps
  the machine usable and the situation debuggable.

  You still can yell in dmesg, but that again is a flexible policy
  decision and not hard coded by any means.

>> > 3.	For nohz_full CPUs that run for a long time in the kernel,
>> > 	there are no scheduling-clock interrupts.  RCU reaches for
>> > 	the resched_cpu() hammer a few jiffies into the grace period.
>> > 	And it sets the ->rcu_urgent_qs flag so that the holdout CPU's
>> > 	interrupt-entry code will re-enable its scheduling-clock interrupt
>> > 	upon receiving the resched_cpu() IPI.
>> 
>> You can spare the IPI by setting NEED_RESCHED on the remote CPU which
>> will cause it to preempt.
>
> That is not sufficient for nohz_full CPUs executing in userspace,

That's not what I was talking about. You said:

>> > 3.	For nohz_full CPUs that run for a long time in the kernel,
                                                           ^^^^^^
Duh! I did not realize that you meant user space. For user space there
is zero difference to the current situation. Once the task is out in
user space it's out of RCU side critical sections, so that's obiously
not a problem.

As I said: I might be confused. :)

>> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
>> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
>> CONFIG_RT or such as it does not really change the preemption
>> model itself. RT just reduces the preemption disabled sections with the
>> lock conversions, forced interrupt threading and some more.
>
> Again, please, no.
>
> There are situations where we still need rcu_read_lock() and
> rcu_read_unlock() to be preempt_disable() and preempt_enable(),
> repectively.  Those can be cases selected only by Kconfig option, not
> available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.

Why are you so fixated on making everything hardcoded instead of making
it a proper policy decision problem. See above.

>> > 8.	As has been noted elsewhere, in this new limited-preemption
>> > 	mode of operation, rcu_read_lock() readers remain preemptible.
>> > 	This means that most of the CONFIG_PREEMPT_RCU #ifdefs remain.
>> 
>> Why? You fundamentally have a preemptible kernel with PREEMPT_RCU, no?
>
> That is in fact the problem.  Preemption can be good, but it is possible
> to have too much of a good thing, and preemptible RCU read-side critical
> sections definitely is in that category for some important workloads. ;-)

See above.

>> > 10.	The cond_resched_rcu() function must remain because we still
>> > 	have non-preemptible rcu_read_lock() readers.
>> 
>> Where?
>
> In datacenters.

See above.

>> > 14.	The kernel/trace/trace_osnoise.c file's run_osnoise() function
>> > 	might need to do something for non-preemptible RCU to make
>> > 	up for the lack of cond_resched() calls.  Maybe just drop the
>> > 	"IS_ENABLED()" and execute the body of the current "if" statement
>> > 	unconditionally.
>> 
>> Again. There is no non-preemtible RCU with this model, unless I'm
>> missing something important here.
>
> And again, there needs to be non-preemptible RCU with this model.

See above.

Thanks,

        tglx
