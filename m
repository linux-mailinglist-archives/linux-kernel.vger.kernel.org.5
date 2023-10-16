Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A97CAD76
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjJPP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjJPP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:27:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4F3EA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:27:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EE7C433C7;
        Mon, 16 Oct 2023 15:27:18 +0000 (UTC)
Date:   Mon, 16 Oct 2023 11:28:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Youssef Esmat <youssefesmat@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bsegall@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de, wuyun.abel@bytedance.com
Subject: Re: [PATCH] sched/eevdf: Toggle eligibility through sched_feat
Message-ID: <20231016112851.5cc0ccad@gandalf.local.home>
In-Reply-To: <20231015104428.GA11840@noisy.programming.kicks-ass.net>
References: <20231013030213.2472697-1-youssefesmat@chromium.org>
        <20231015104428.GA11840@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2023 12:44:28 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Right.. could you pretty please try:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/eevdf
> 
> as of yesterday or so.
> 
> It defaults to (EEVDF relevant features):
> 
> SCHED_FEAT(PLACE_LAG, true)
> SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
> SCHED_FEAT(PREEMPT_SHORT, true)
> SCHED_FEAT(PLACE_SLEEPER, false)
> SCHED_FEAT(GENTLE_SLEEPER, true)
> SCHED_FEAT(EVDF, false)
> SCHED_FEAT(DELAY_DEQUEUE, true)
> SCHED_FEAT(GENTLE_DELAY, true)
> 
> If that doesn't do well enough, could you please try, in order of
> preference:
> 
> 2) NO_GENTLE_DELAY
> 3) NO_DELAY_DEQUEUE, PLACE_SLEEPER
> 4) NO_DELAY_DEQUEUE, PLACE_SLEEPER, NO_GENTLE_SLEEPER

Thanks Peter, we'll give this a try.

> 
> I really don't like the EVDF option, and I think you'll end up
> regretting using it sooner rather than later, just to make this one
> benchmark you have happy.

Note, the benchmark we use is very close to real world settings that we
care about. And if we were to go further with Youssef's feature, we would
test it by sending it out to 1% of our user base, then 2%, 5%, and so on,
with a lot more feedback analysis going on. If it were to cause any
regressions, it would likely be noticed during this process, and be able to
back out any changes.

The main point is, our testing is not around any single benchmark that we
are trying to make happy. We really are looking at what makes the user base
run better in the real world.

> 
> I'm hoping the default is enough, but otherwise any of the above should
> be a *much* better scheduler.
> 
> Also, bonus points if you can create us a stand alone benchmark that
> captures your metric (al-la facebook's schbench) without the whole
> chrome nonsense, that'd be epic.

As I stated above. We don't really care about any one benchmark, but our
focus is on our user base. It's not as simple as what facebook would have,
as they are server focused and have a lot more information to test with. We
are more focused on the quality of chromebooks for kids in school, which is
much more difficult to analyze ;-)

What we could do, is give you a way to have access to run our benchmarks in
our infrastructure if you want to test anything in particular. Would you be
interested in that?

-- Steve

