Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BCF7D878D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJZR0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344977AbjJZR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:26:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1041A1B5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:26:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA58C433C9;
        Thu, 26 Oct 2023 17:26:41 +0000 (UTC)
Date:   Thu, 26 Oct 2023 13:26:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231026132639.538a0741@gandalf.local.home>
In-Reply-To: <82b0104f-1f05-44b0-9e95-57beecd541c8@kernel.org>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
        <20231025103105.5ec64b89@gandalf.local.home>
        <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
        <20231025162435.ibhdktcshhzltr3r@f>
        <20231025131731.48461873@gandalf.local.home>
        <20231026085414.GL31411@noisy.programming.kicks-ass.net>
        <20231026094035.213e3744@gandalf.local.home>
        <20231026114927.46145fe6@gandalf.local.home>
        <82b0104f-1f05-44b0-9e95-57beecd541c8@kernel.org>
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

On Thu, 26 Oct 2023 18:31:56 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:


> > This feature is a performance boost only, and has nothing to do with
> > "correctness". That's because it has that arbitrary time where it can run a
> > little more. It's more like the difference between having something in
> > cache and a cache miss. This would cause many academics to quit and find a
> > job in sales if they had to prove the correctness of an algorithm that gave
> > you a boost for some random amount of time. The idea here is to help with
> > performance. If it exists, great, your application will likely perform
> > better. If it doesn't, no big deal, you may just have to deal with longer
> > wait times on critical sections.  
> 
> terminologies, terminologies.... those academic people :-)

I hope this doesn't cause you to quit and switch to a career in sales!

> 
> I think that this can also be seen as an extension of the non-preemptive
> mode to the user space, but... not entirely, it is a ceiling to the
> [ higher than fair/lower than RT ] prior?

Well, it's just an extended time slice of SCHED_OTHER (up to 1 ms on 1000Hz
to 4 ms on 250Hz). But if an RT or DL task were to wake up it would preempt
it immediately. This feature is at the whims of the kernel implementation
that provides no guarantees. It's just a hint from user space asking the
kernel if it can have a little more time to get out of a critical section
where the time slice ended unfortunately while the task was in a critical
section. The kernel is allowed to deny the request.

> 
> and it is not global. It is partitioned: once the section starts, it stays
> there, being preempted by RT/DL?

Basically yes. Looking at the v6.6-rc4 kernel (which is where I started
from), the base time slice is 3ms.

  # cat /sys/kernel/debug/sched/base_slice_ns
  3000000

Note, when I upped this to 6ms, the benefits of this patch did drop. That
makes total sense because that would drop the number of times the critical
section would be preempted. Basically, it does somewhat the same thing by
extending all time slices.

With this feature enabled, if the schedule slice ends on a critical section
that has this special bit set, the kernel will give up to 1 more ms (1000
HZ) to get out of that section. It will also tell user space that it is
running on extended time by setting bit 1 (0x2). When user space leaves the
critical section, it should check that bit and if it is set call any system
call which the kernel will then call schedule. In my example, I just used
sched_yield(), but it would work with gettid() as well.

Sure, user space can ignore that bit from the kernel and continue, but when
that 1ms is up,  the kernel will preempt that task with prejudice,
regardless if its in a critical section or not. It's in the task's best
interest to make that system call when it knows it's the best time to do so
(not within a critical section). If it does not, it risks being preempted
within a critical section. Not to mention that the EEVDF scheduler will
lower it's eligibility for the next round.

-- Steve

