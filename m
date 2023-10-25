Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B927D7118
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbjJYPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjJYPmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:42:24 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEE712F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698248539;
        bh=XLfjy5zK7rJ7BMk5Ub8hm0MefkN9QOqzEYXN3ub6whY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MC8mRgur6RYYIFlpPIj61wRMo+5Lsu4bmCXztRoVJSi0WiQi7slsbsII/ZCcqRU+P
         FesRkK+nVYKoGzDINqGPIi3j7feftFqBCfdZucNPJyxYxsUddPK34S5sX27HMOX7jO
         L/2A4prBLwjEPfVYfCeYfqxMmIHvw6HKL+XjUvUmSLppK5SN09xX81uek2azxmQxZc
         Pdt73liohzZ4R1MDVxT0bqEVSRNTZfa+i+JUFFNBPqy4oZDxkH8leAr00ytjJBqbbS
         6mgpuvH9NDCrojRiwc07L7LDsw+CiTBGK+9ztHcK/fWJW6w+OKyemKEHWEzK9/Js25
         +s2akE3r4PWRg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SFtTk6t9dz1ZWm;
        Wed, 25 Oct 2023 11:42:18 -0400 (EDT)
Message-ID: <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
Date:   Wed, 25 Oct 2023 11:42:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
 <20231025085434.35d5f9e0@gandalf.local.home>
 <20231025135545.GG31201@noisy.programming.kicks-ass.net>
 <20231025103105.5ec64b89@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231025103105.5ec64b89@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-25 10:31, Steven Rostedt wrote:
> On Wed, 25 Oct 2023 15:55:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

[...]

After digging lore for context, here are some thoughts about the actual
proposal: AFAIU the intent here is to boost the scheduling slice for a
userspace thread running with a mutex held so it can complete faster,
and therefore reduce contention.

I suspect this is not completely unrelated to priority inheritance
futexes, except that one goal stated by Steven is to increase the
owner slice without requiring to call a system call on the fast-path.

Compared to PI futexes, I think Steven's proposal misses the part
where a thread waiting on a futex boosts the lock owner's priority
so it can complete faster. By making the lock owner selfishly claim
that it needs a larger scheduling slice, it opens the door to
scheduler disruption, and it's hard to come up with upper-bounds
that work for all cases.

Hopefully I'm not oversimplifying if I state that we have mainly two
actors to consider:

[A] the lock owner thread

[B] threads that block trying to acquire the lock

The fast-path here is [A]. [B] can go through a system call, I don't
think it matters at all.

So perhaps we can extend the rseq per-thread area with a field that
implements a "held locks" list that allows [A] to let the kernel know
that it is currently holding a set of locks (those can be chained when
locks are nested). It would be updated on lock/unlock with just a few
stores in userspace.

Those lock addresses could then be used as keys for private locks,
or transformed into inode/offset keys for shared-memory locks. Threads
[B] blocking trying to acquire the lock can call a system call which
would boost the lock owner's slice and/or priority for a given lock key.

When the scheduler preempts [A], it would check whether the rseq
per-thread area has a "held locks" field set and use this information
to find the slice/priority boost which are currently active for each
lock, and use this information to boost the task slice/priority
accordingly.

A scheme like this should allow lock priority inheritance without
requiring system calls on the userspace lock/unlock fast path.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

