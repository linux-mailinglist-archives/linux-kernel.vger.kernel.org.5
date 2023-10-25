Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32D7D738E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJYStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJYStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:49:36 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153D128
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698259771;
        bh=ZVx1Dd7UUSNMJt/FMbzBDNVrdpJzMCrzVrAzp4eNAq0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=meVTLcDJsVk464UwUqmGKOXvf8firSVrqfWIhyKrLm0s2ZwzTr3kHBoi+mfcJX7tq
         T30GnP0KhYnCS/HK8q9JAT7ffhHzHJGKNuCNr26F+K9QTv5rBprMSbjO3WMp9TM7z7
         0pZZY6NvluaWH5RejWgGMjSTAeUAkk4/ZMfqSnBrFmLqnCHeaoO/uyCS9F5HyTm8Kr
         rsOP47d+mnifU36SG4Y/ZIMYTtLT3Hix/u1PXi01NnY9P6C846rqwWCcqQoEBLW3QQ
         0S1OpTzv9uYFFPq1AsI+8SJ9d/ZUAB2BEvCFPDJWBReaFm1wqUGoJA9SAhSjvEPBcP
         0btgXqEPy6uGA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SFydj4Fzmz1ZQw;
        Wed, 25 Oct 2023 14:49:29 -0400 (EDT)
Message-ID: <0d95385f-1be1-4dcf-93cb-8c5df3bc9d0c@efficios.com>
Date:   Wed, 25 Oct 2023 14:49:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
 <20231025085434.35d5f9e0@gandalf.local.home>
 <20231025135545.GG31201@noisy.programming.kicks-ass.net>
 <20231025103105.5ec64b89@gandalf.local.home>
 <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
 <20231025162435.ibhdktcshhzltr3r@f>
 <20231025131731.48461873@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231025131731.48461873@gandalf.local.home>
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

On 2023-10-25 13:17, Steven Rostedt wrote:
> On Wed, 25 Oct 2023 18:24:35 +0200
> Mateusz Guzik <mjguzik@gmail.com> wrote:
> 
>> On Wed, Oct 25, 2023 at 11:42:34AM -0400, Mathieu Desnoyers wrote:
>>> On 2023-10-25 10:31, Steven Rostedt wrote:
>>>> On Wed, 25 Oct 2023 15:55:45 +0200
>>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>
[...]
> 
> No, I wouldn't say it's the same as priority inheritance, which is to help
> with determinism and not performance. PI adds overhead but removes
> unbounded latency. On average, a non PI mutex is faster than PI mutex, but
> can suffer from unbounded priority inversion.

AFAIU, this is because PI mutex as implemented by sys futex only boosts the
priority of the lock owner. In my proposal here the owner would be able to
borrow scheduler slices from the waiters as well.

[...]

>>>
>>> Hopefully I'm not oversimplifying if I state that we have mainly two
>>> actors to consider:
>>>
>>> [A] the lock owner thread
>>>
>>> [B] threads that block trying to acquire the lock
>>>
>>> The fast-path here is [A]. [B] can go through a system call, I don't
>>> think it matters at all.
> 
> No, B going into a system call can be just as devastating. Adaptive
> spinning helps with that. The thing here is that if A gets preempted, there
> will be a lot more B's getting stuck.

I would indeed combine this with an adaptive spinning scheme to allow waiters to
stay in userspace if contention is short. As you know, rseq can also help there:

https://lore.kernel.org/lkml/20230529191416.53955-1-mathieu.desnoyers@efficios.com/

Therefore, it's only the blocking case that would call into the kernel, which
should not be so devastating.

> 
> I implemented the test with futexes (where you go to sleep on contention)
> and the performance dropped considerably, where the benefits of not having
> A get preempted made no difference at all. Sure, adaptive spinning helps in
> that case, but adaptive spinning would only make it as good as my spinning
> in user space logic is without any changes.

I'm not sure what you are arguing here.

My overall idea would be to combine:

1) Adaptive spinning in userspace,
2) Priority inheritance,
3) Scheduler slices inheritance.

> 
>>>
>>> Those lock addresses could then be used as keys for private locks,
>>> or transformed into inode/offset keys for shared-memory locks. Threads
>>> [B] blocking trying to acquire the lock can call a system call which
>>> would boost the lock owner's slice and/or priority for a given lock key.
> 
> Do you mean that this would be done in user space? Going into the kernel to
> do any of this would make it already lost.

Going to the kernel only happens when threads need to block, which means
that the typical contended half-happy path should be busy-spinning in userspace
(adaptive spinning).

I see why blocking in a scenario where busy-spinning would be better is
inefficient, but I don't see how going to the kernel for the _blocking_
case is bad.

> 
>>>
>>> When the scheduler preempts [A], it would check whether the rseq
>>> per-thread area has a "held locks" field set and use this information
>>> to find the slice/priority boost which are currently active for each
>>> lock, and use this information to boost the task slice/priority
>>> accordingly.
> 
> Why do we care about locks here? Note, I'm looking at using this same
> feature for VMs on interrupt handlers. The only thing user space needs to
> tell the kernel is "It's not a good time to preempt me, but it will be
> shortly".
> 

Quoting https://lore.kernel.org/lkml/20231024103426.4074d319@gandalf.local.home/

"The goal is to prevent a thread / vCPU being preempted while holding a lock
or resource that other threads / vCPUs will want. That is, prevent
contention, as that's usually the biggest issue with performance in user
space and VMs."

We care about locks here because this is in fact your own problem statement.
If you want to consider the different problem of making VM interrupt handlers
go fast, then you should state it up front. Those two distinct problems may
or may not require entirely different solutions.

>>>
>>> A scheme like this should allow lock priority inheritance without
>>> requiring system calls on the userspace lock/unlock fast path.
> 
> Priority inheritance doesn't make sense when everything is running.

I should have also said that this scheme should allow the lock owner to
borrow scheduler time slices from waiters (in addition to PI).

[...]

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

