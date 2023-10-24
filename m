Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C07D4F91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjJXMPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjJXMPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:15:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAA4A2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:15:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698149725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=07gZYsTHRr4IpF7/NnHkBXjK8ai5GvZ2wIbyODgIsGk=;
        b=jVcCl2VTHO1Bgg9hoMdzE3QgkVZJ8zaknxpscT7hJF6KxMuqYkkJiYqC1cjBf0J5rzXFgR
        aDD4+Spq+05NspJzt8YDqlfR1O5fCLx6lMajHitA1h2jq9xrM2idnyp70SttM9TLT8p9BZ
        ug+szjQY9BEuL6afeV6qafVhI3VB+7/TT4c0wrhYgABE5yLMdnitCChJOo86aUzLrCI89v
        fpL5U+UuvE05Xg/J/aSGtr+/XhqUH1qJL4PZn+eaIjX/HkUcgAzbSVW9FDQCa7kHs2oAJn
        0ewNO7UvC9pjW1ZwWFQN5iXtkiGtN4Vo/wKPxKqjzUsjwRCqruW047vC1R6vow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698149725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=07gZYsTHRr4IpF7/NnHkBXjK8ai5GvZ2wIbyODgIsGk=;
        b=Rrmr/x6ckg0rses0pUJS+BocRUGKCM7BcZIenpabqQifFVtNevg6Pwz/2adzEvP4glFhza
        22dSVe1MKc+Zu6Dw==
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
In-Reply-To: <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
Date:   Tue, 24 Oct 2023 14:15:25 +0200
Message-ID: <87cyx4cj36.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

On Thu, Oct 19 2023 at 12:13, Paul E. McKenney wrote:
> On Thu, Oct 19, 2023 at 02:21:35AM +0200, Thomas Gleixner wrote:
>> The important point is that at the very end the scheduler has the
>> ultimate power to say: "Not longer Mr. Nice Guy" without the risk of any
>> random damage due to the fact that preemption count is functional, which
>> makes your life easier as well as you admitted already. But that does
>> not mean you can eat the cake and still have it. :)
>
> Which is exactly why I need rcu_read_lock() to map to preempt_disable()
> and rcu_read_unlock() to preempt_enable().  ;-)

After reading back in the thread, I think we greatly talked past each
other mostly due to the different expectations and the resulting
dependencies which seem to be hardwired into our brains.

I'm pleading guilty as charged as I failed completely to read your
initial statement

 "The key thing to note is that from RCU's viewpoint, with this change,
  all kernels are preemptible, though rcu_read_lock() readers remain
  non-preemptible."

with that in mind and instead of dissecting it properly I committed the
fallacy of stating exactly the opposite, which obviously reflects only
the point of view I'm coming from.

With a fresh view, this turns out to be a complete non-problem because
there is no semantical dependency between the preemption model and the
RCU flavour.

The unified kernel preemption model has the following properties:

  1) It provides full preemptive multitasking.

  2) Preemptability is limited by implicit and explicit mechanisms.

  3) The ability to avoid overeager preemption for SCHED_OTHER tasks via
     the PREEMPT_LAZY mechanism.

     This emulates the NONE/VOLUNTARY preemption models which
     semantically provide collaborative multitasking.

     This emulation is not breaking the semantical properties of full
     preemptive multitasking because the scheduler still has the ability
     to enforce immediate preemption under consideration of #2.

     Which in turn is a prerequiste for removing the semantically
     ill-defined cond/might_resched() constructs.

The compile time selectable RCU flavour (preemptible/non-preemptible) is
not imposing a semantical change on this unified preemption model.

The selection of the RCU flavour is solely affecting the preemptability
(#2 above). Selecting non-preemptible RCU reduces preemptability by
adding an implicit restriction via mapping rcu_read_lock()
to preempt_disable().

IOW, the current upstream enforcement of RCU_PREEMPT=n when PREEMPTION=n
is only enforced by the the lack of the full preempt counter in
PREEMPTION=n configs. Once the preemption counter is always enabled this
hardwired dependency goes away.

Even PREEMPT_DYNAMIC should just work with RCU_PREEMPT=n today because
with PREEMPT_DYNAMIC the preemption counter is unconditionally
available.

So that makes these hardwired dependencies go away in practice and
hopefully soon from our mental models too :)

RT will keep its hard dependency on RCU_PREEMPT in the same way it
depends hard on forced interrupt threading and other minor details to
enable the spinlock substitution.

>> That said, I completely understand your worries about the consequences,
>> but please take the step back and look at it from a conceptual point of
>> view.
>
> Conceptual point of view?  That sounds suspiciously academic.

Hehehe.

> Who are you and what did you do with the real Thomas Gleixner?  ;-)

The point I'm trying to make is not really academic, it comes from a
very practical point of view. As you know for almost two decades I'm
mostly busy with janitoring and mopping up the kernel.

A major takeaway from this eclectic experience is that there is a
tendency to implement very specialized solutions for different classes
of use cases.

The reasons to do so in the first place:

 1) Avoid breaking the existing and established solutions:

    E.g. the initial separation of x8664 and i386

 2) Enforcement due to dependencies on mechanisms, which are
    considered "harmful" for particular use cases

    E.g. Preemptible RCU, which is separate also due to #1

 3) Because we can and something is sooo special

    You probably remember the full day we both spent in a room with SoC
    people to make them understand that their SoCs are not so special at
    all. :)

So there are perfectly valid reasons (#1, #2) to separate things, but we
really need to go back from time to time and think hard about the
question whether a particular separation is still justified. This is
especially true when dependencies or prerequisites change.

But in many cases we just keep going, take the separation as set in
stone forever and add features and workarounds on all ends without
rethinking whether we could unify these things for the better. The real
bad thing about this is that the more we add to the separation the
harder consolidation or unification becomes.

Granted that my initial take of consolidating on preemptible RCU might
be too brisk or too naive, but I still think that with the prospect of
an unified preemption model it's at least worth to have a very close
look at this question.

Not asking such questions or dismissing them upfront is a real danger
for the long term sustainability and maintainability of the kernel in my
opinion. Especially when the few people who actively "janitor" these
things are massively outnumbered by people who indulge in
specialization. :)

That said, the real Thomas Gleixner and his grumpy self are still there,
just slightly tired of handling the slurry brush all day long :)

Thanks,

        tglx

