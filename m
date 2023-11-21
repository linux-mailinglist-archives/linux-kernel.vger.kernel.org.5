Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3C7F31B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjKUO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjKUO4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:56:40 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455BD9A;
        Tue, 21 Nov 2023 06:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700578594;
        bh=gCXHbPeW/4/LB/bSJQ/3MhPkRCxJ7g2+PzpBkp1VBrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R3LIKvyMEbskpJj2vtUJMorWCchBcKg7clor1RjYIHZ48x4MlX9pQoY08zbJmwbj/
         3HCX/MGaN/7GRz9zwta3YU+2pCjQmJGuPCuH8g3CknUHDHcoOCQ7ek5Z9i15FDiJgB
         9u/PMAv9OW1/pFVAAlKbaL6YG/Th+gz8x547gtcfIdZ/HgjLaSAhvtFI48+kVez4lc
         AZ71BOB6VtkF3D3Uv8GCKNqGDSLaec5R4vwdknqd1XDkh/HNJptCOAi+OZneC5qc5h
         8+uwn32qSQzmJIeV4OVXXr8LXDV99FiZ60KRsBLE1Z9eWX3y4A3zNXRHhDCz93UXZp
         Y+KcdRzPaPXdA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZSBV1kNhz1d1C;
        Tue, 21 Nov 2023 09:56:34 -0500 (EST)
Message-ID: <0364d2c5-e5af-4bb5-b650-124a90f3d220@efficios.com>
Date:   Tue, 21 Nov 2023 09:56:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 09:46, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 09:40:24AM -0500, Mathieu Desnoyers wrote:
>> On 2023-11-21 09:36, Peter Zijlstra wrote:
>>> On Tue, Nov 21, 2023 at 09:06:18AM -0500, Mathieu Desnoyers wrote:
>>>> Task trace RCU fits a niche that has the following set of requirements/tradeoffs:
>>>>
>>>> - Allow page faults within RCU read-side (like SRCU),
>>>> - Has a low-overhead read lock-unlock (without the memory barrier overhead of SRCU),
>>>> - The tradeoff: Has a rather slow synchronize_rcu(), but tracers should not care about
>>>>     that. Hence, this is not meant to be a generic replacement for SRCU.
>>>>
>>>> Based on my reading of https://lwn.net/Articles/253651/ , preemptible RCU is not a good
>>>> fit for the following reasons:
>>>>
>>>> - It disallows blocking within a RCU read-side on non-CONFIG_PREEMPT kernels,
>>>
>>> Your counter points are confused, we simply don't build preemptible RCU
>>> unless PREEMPT=y, but that could surely be fixed and exposed as a
>>> separate flavour.
>>>
>>>> - AFAIU the mmap_sem used within the page fault handler does not have priority inheritance.
>>>
>>> What's that got to do with anything?
>>>
>>> Still utterly confused about what task-tracing rcu is and how it is
>>> different from preemptible rcu.
>>
>> In addition to taking the mmap_sem, the page fault handler need to block
>> until its requested pages are faulted in, which may depend on disk I/O.
>> Is it acceptable to wait for I/O while holding preemptible RCU read-side?
> 
> I don't know, preemptible rcu already needs to track task state anyway,
> it needs to ensure all tasks have passed through a safe spot etc.. vs regular
> RCU which only needs to ensure all CPUs have passed through start.
> 
> Why is this such a hard question?

Personally what I am looking for is a clear documentation of preemptible 
rcu with respect to whether it is possible to block on I/O (take a page 
fault, call schedule() explicitly) from within a preemptible rcu 
critical section. I guess this is a hard question because there is no 
clear statement to that effect in the kernel documentation.

If it is allowed (which I doubt), then I wonder about the effect of 
those long readers on grace period delays. Things like expedited grace 
periods may suffer.

Based on Documentation/RCU/rcu.rst:

   Preemptible variants of RCU (CONFIG_PREEMPT_RCU) get the
   same effect, but require that the readers manipulate CPU-local
   counters.  These counters allow limited types of blocking within
   RCU read-side critical sections.  SRCU also uses CPU-local
   counters, and permits general blocking within RCU read-side
   critical sections.  These variants of RCU detect grace periods
   by sampling these counters.

Then we just have to find a definition of "limited types of blocking"
vs "general blocking".

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

