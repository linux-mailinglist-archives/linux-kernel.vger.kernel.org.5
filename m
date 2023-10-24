Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BF07D5424
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjJXOee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjJXOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:34:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E468F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:34:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79B2C433C7;
        Tue, 24 Oct 2023 14:34:27 +0000 (UTC)
Date:   Tue, 24 Oct 2023 10:34:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20231024103426.4074d319@gandalf.local.home>
In-Reply-To: <87cyyfxd4k.ffs@tglx>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
        <20230908070258.GA19320@noisy.programming.kicks-ass.net>
        <87zg1v3xxh.fsf@oracle.com>
        <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
        <87edj64rj1.fsf@oracle.com>
        <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
        <87zg1u1h5t.fsf@oracle.com>
        <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
        <20230911150410.GC9098@noisy.programming.kicks-ass.net>
        <87h6o01w1a.fsf@oracle.com>
        <20230912082606.GB35261@noisy.programming.kicks-ass.net>
        <87cyyfxd4k.ffs@tglx>
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

On Tue, 19 Sep 2023 01:42:03 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

>    2) When the scheduler wants to set NEED_RESCHED due it sets
>       NEED_RESCHED_LAZY instead which is only evaluated in the return to
>       user space preemption points.
> 
>       As NEED_RESCHED_LAZY is not folded into the preemption count the
>       preemption count won't become zero, so the task can continue until
>       it hits return to user space.
> 
>       That preserves the existing behaviour.

I'm looking into extending this concept to user space and to VMs.

I'm calling this the "extended scheduler time slice" (ESTS pronounced "estis")

The ideas is this. Have VMs/user space share a memory region with the
kernel that is per thread/vCPU. This would be registered via a syscall or
ioctl on some defined file or whatever. Then, when entering user space /
VM, if NEED_RESCHED_LAZY (or whatever it's eventually called) is set, it
checks if the thread has this memory region and a special bit in it is
set, and if it does, it does not schedule. It will treat it like a long
kernel system call.

The kernel will then set another bit in the shared memory region that will
tell user space / VM that the kernel wanted to schedule, but is allowing it
to finish its critical section. When user space / VM is done with the
critical section, it will check the bit that may be set by the kernel and
if it is set, it should do a sched_yield() or VMEXIT so that the kernel can
now schedule it.

What about DOS you say? It's no different than running a long system call.
No task can run forever. It's not a "preempt disable", it's just "give me
some more time". A "NEED_RESCHED" will always schedule, just like a kernel
system call that takes a long time. The goal is to allow user space to get
out of critical sections that we know can cause problems if they get
preempted. Usually it's a user space / VM lock is held or maybe a VM
interrupt handler that needs to wake up a task on another vCPU.

If we are worried about abuse, we could even punish tasks that don't call
sched_yield() by the time its extended time slice is taken. Even without
that punishment, if we have EEVDF, this extension will make it less
eligible the next time around.

The goal is to prevent a thread / vCPU being preempted while holding a lock
or resource that other threads / vCPUs will want. That is, prevent
contention, as that's usually the biggest issue with performance in user
space and VMs.

I'm going to work on a POC, and see if I can get some benchmarks on how
much this could help tasks like databases and VMs in general.

-- Steve
