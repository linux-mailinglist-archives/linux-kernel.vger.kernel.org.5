Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D23A7B2825
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjI1WME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjI1WMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:12:00 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45381B4;
        Thu, 28 Sep 2023 15:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1695939115;
        bh=10Fr9VebZhIfvq+c2K/IeNKXzZQxLkl3uPdUKenkHRA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CnHIL6UoP8VaHli/wyVUUsUc7OakNJgVwG0Ucrm2P814xYqLrB8JJdaZuFsZj4FsW
         E3+aRiVex6Londpl2cD0u/3XElFVKYK3+DMGqbAwokMjfMHeUVkxqSE7MnlIK3cIy9
         3ZRY97UhqoUfH8LvXVs8LRZKMAXn60rvU5ivuLQx1yk1KGshJATova7KBrrOqcA/DD
         +bPLvsEwkIhXeW4QKfrZphA+E/O+B3MMuxl/5sCDyPpdrrZuNyG6DIKR0lYSnR3+UL
         OyutIZrzyuKcLHFQzSKhgsaq3rvPqb1NH4a6ENz63OpixtWM7QL4AFz4/HnBI7df5P
         QV9vdWC+A8y0g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RxSPk6Xhbz1RRm;
        Thu, 28 Sep 2023 18:11:54 -0400 (EDT)
Message-ID: <2cf3774b-a568-0296-651f-7edf6bf03308@efficios.com>
Date:   Thu, 28 Sep 2023 18:11:19 -0400
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
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com> <87o7hmdnnv.ffs@tglx>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87o7hmdnnv.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 16:54, Thomas Gleixner wrote:
> On Mon, May 29 2023 at 15:14, Mathieu Desnoyers wrote:
>> +/*
>> + * rseq_sched_state should be aligned on the cache line size.
>> + */
>> +struct rseq_sched_state {
>> +	/*
>> +	 * Version of this structure. Populated by the kernel, read by
>> +	 * user-space.
>> +	 */
>> +	__u32 version;
>> +	/*
>> +	 * The state is updated by the kernel. Read by user-space with
>> +	 * single-copy atomicity semantics. This field can be read by any
>> +	 * userspace thread. Aligned on 32-bit. Contains a bitmask of enum
>> +	 * rseq_sched_state_flags. This field is provided as a hint by the
>> +	 * scheduler, and requires that the page holding this state is
>> +	 * faulted-in for the state update to be performed by the scheduler.
>> +	 */
>> +	__u32 state;
>> +	/*
>> +	 * Thread ID associated with the thread registering this structure.
>> +	 * Initialized by user-space before registration.
>> +	 */
>> +	__u32 tid;
>> +};
>> +
>>   /*
>>    * struct rseq is aligned on 4 * 8 bytes to ensure it is always
>>    * contained within a single cache-line.
>> @@ -148,6 +180,15 @@ struct rseq {
>>   	 */
>>   	__u32 mm_cid;
>>   
>> +	__u32 padding1;
>> +
>> +	/*
>> +	 * Restartable sequences sched_state_ptr field. Initialized by
>> +	 * userspace to the address at which the struct rseq_sched_state is
>> +	 * located. Read by the kernel on rseq registration.
>> +	 */
>> +	__u64 sched_state_ptr;
>> +
> 
> Why is this a separate entity instead of being simply embedded into
> struct rseq?
> 
> Neither the code comment nor the changelog tells anything about that.

Here is the email thread from v1 that led to this:

https://lore.kernel.org/lkml/ZGevZxOjJLMO9zlM@boqun-archlinux/

The reason for moving this sched_state to its own structure was to 
optimize for a scenario where we have:

- many threads contending for the lock, thus loading the value of the 
struct rseq "sched_state".
- the lock owner thread doing rseq critical sections with the lock held, 
thus updating the value of struct rseq "rseq_cs" field (in the same 
cache line).

The loads of the sched_state from other threads would slow down (even 
slightly) the update to the rseq_cs field, thus causing the critical 
sections to take a few more cycles.

I am not convinced that the complexity vs speed tradeoff of moving this 
into its own separate structure is worth it though. Especially given 
that it would require userspace to wire things up with an additional 
side-structure, rather than just extend naturally with the 
extensible-rseq ABI. Another approach would be to cacheline-align this 
field within struct rseq and waste space to padding.

I am inclined to just embed this into struct rseq without caring too 
much about slight overhead caused by sharing the cache line with other 
fields.

> 
> If your intention was to provide a solution for process shared futexes
> then you completely failed to understand how process shared futexes
> work. If not, then please explain why you need a pointer and the
> associated hackery to deal with it.

I have not given a single thought to shared futexes in this PoC so far. :)

So let's see: we could do the following to support shared futexes: move 
the information about the owner's struct rseq (could be the thread 
pointer of the owner thread) to a field separate from the "lock" state 
(which is ABI as you pointed out). Therefore, grabbing the lock would be 
done with an atomic instruction, and then setting this extra information 
about lock owner would be done with a simple store.

Given that the lock owner information is only used to statistically 
decide whether other threads should spin or block when contended, we 
don't really care if this information is set a few instructions after 
acquiring the lock.

Thoughts ?

Thanks for the feedback,

Mathieu

> 
> Thanks,
> 
>          tglx
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

