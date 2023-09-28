Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3947B26C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjI1Uoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1Uoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:44:38 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D14919C;
        Thu, 28 Sep 2023 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1695933874;
        bh=9aw0BPEYNd90DJaMDLBC1QrPFfgdOGYswPNrGMMC+Jo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kQmhU7WCur4kGAIitZt1UW+sOUNw/tzQmiKAvbldPzHKscXuIsBVKfYXirPm52xus
         6l6eDyNgM9JikY371xnNuMdP26JC6oE2AdONEKdObMimS7miq3g54V4R7846LyiDaK
         9iKlDwZfwTOUIHbBZ2gDoaM8GPiXQjjSGcuo6MHW965pS8acdehV+Na+K4LPSmzxsN
         i1qThFkuG24sKTtm9tTgR2WvSfg9P75FOYBMFJU2NSktfCYrfsUx5rFyI0z1M6Chvo
         vCMjD/wlQNqhdJzabIeEaJ8aRzmdbcirwyQwPMMoopzU3/DCLhS+AzQ2ezo/Tzb6Zb
         8E4LtfZqmK/AQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RxQSx6Qmbz1Qnb;
        Thu, 28 Sep 2023 16:44:33 -0400 (EDT)
Message-ID: <94c23850-265c-5d71-f0a3-e02b5dbc050e@efficios.com>
Date:   Thu, 28 Sep 2023 16:43:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com,
        Florian Weimer <fweimer@redhat.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com> <87r0midp5u.ffs@tglx>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87r0midp5u.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 16:21, Thomas Gleixner wrote:
> On Mon, May 29 2023 at 15:14, Mathieu Desnoyers wrote:
>> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state);
>> +
>> +static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
>> +{
>> +	if (t->rseq_sched_state)
>> +		__rseq_set_sched_state(t, state);
> 
> This is invoked on every context switch and writes over that state
> unconditionally even in the case that the state was already
> cleared. There are enough situations where tasks are scheduled out
> several times while being in the kernel.

Right, if this becomes more than a PoC, I'll make sure to keep track of 
the current state within the task struct, and only update userspace on 
state transition.

> 
>>   /* rseq_preempt() requires preemption to be disabled. */
>>   static inline void rseq_preempt(struct task_struct *t)
>>   {
>>   	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
>>   	rseq_set_notify_resume(t);
>> +	rseq_set_sched_state(t, 0);
> 
> This code is already stupid to begin with. __set_bit() is cheap, but
> rseq_set_notify_resume() is not as it has a conditional and a locked
> instruction

What alternative would you recommend to set a per-thread state that has 
the same effect as TIF_NOTIFY_RESUME ? Indeed all it really needs to 
synchronize with is the thread owning the flags, but AFAIU having this 
flag part of the TIF flags requires use of an atomic instruction to 
synchronize updates against concurrent threads.

If we move this thread flag into a separate field of struct thread_info, 
then we could turn this atomic set bit into a more lightweight store, 
but then we'd need to check against an extra field on return to userspace.

And if we want to remove the conditional branch on the scheduler 
fast-path, we could always load and test both the task struct's rseq 
pointer and the thread_info "preempted" state on return to userspace.

The tradeoff there would be to add extra loads and conditional branches 
on return to userspace to speed up the scheduler fast-path.

Is this what you have in mind or am I missing your point ?

> and now you add two more conditionals into the context
> switch path.

I'm open to suggestions on how to improve this if this goes beyond PoC 
stage and we observe measurable benefits on the userspace side.

Thanks,

Mathieu

> 
> Thanks,
> 
>          tglx

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

