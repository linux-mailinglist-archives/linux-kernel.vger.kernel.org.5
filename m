Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4B7B207A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjI1PGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjI1PG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:06:27 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C19F9;
        Thu, 28 Sep 2023 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VEh/P4CZIN7dtMmrMKJYQdsmVpbhrLGW/qbCtoGRHn4=; b=YXiSVfYwN2g/6rkn5PnqoRAI4+
        p5KiqJ15ZG5Z2dkuvs+oJ/jLWj6IuN1B4FppVeXB7ejs7E1aEZbIO8zT4fFEQRkx54RvWwU80wVZZ
        UXOJVl/OoJMldN81hAL4mt6LlaG8VRny/uzvmbzpNxSVWyzd8Gxo7eFKQi7JbuhG2a89+BGMnpwoZ
        Z/n8LtiQZeSeBCnOKBw8DrvXupCQ6SSDXmc5iXhTkmvWBy+w8Q/fZpDDgsYMD8RulKlO/Srpk5ydB
        5S5Qyg4xlNMdcNtCj2F5YH0bEVUSU+dLyQ9txViKcSpBs1YyIeAvgwhz9hpZDZXJ7o6836a13QxUL
        +81Evc5Q==;
Received: from [176.177.19.228] (helo=[192.168.1.19])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qlsaZ-009JpF-0b; Thu, 28 Sep 2023 17:06:03 +0200
Message-ID: <ab59863f-25f0-4635-8408-4aaec39ec6c2@igalia.com>
Date:   Thu, 28 Sep 2023 17:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        "carlos@redhat.com" <carlos@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        "longman@redhat.com" <longman@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
 <20230928103926.GI9829@noisy.programming.kicks-ass.net>
 <ef39143ad24743008a896d2a09da1066@AcuMS.aculab.com>
 <34ddb730-8893-19a8-00fe-84c4e281eef1@efficios.com>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <34ddb730-8893-19a8-00fe-84c4e281eef1@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/23 15:20, Mathieu Desnoyers wrote:
> On 9/28/23 07:22, David Laight wrote:
>> From: Peter Zijlstra
>>> Sent: 28 September 2023 11:39
>>>
>>> On Mon, May 29, 2023 at 03:14:13PM -0400, Mathieu Desnoyers wrote:
>>>> Expose the "on-cpu" state for each thread through struct rseq to allow
>>>> adaptative mutexes to decide more accurately between busy-waiting and
>>>> calling sys_futex() to release the CPU, based on the on-cpu state 
>>>> of the
>>>> mutex owner.
>>
>> Are you trying to avoid spinning when the owning process is sleeping?
>
> Yes, this is my main intent.
>
>> Or trying to avoid the system call when it will find that the futex
>> is no longer held?
>>
>> The latter is really horribly detremental.
>
> That's a good questions. What should we do in those three situations 
> when trying to grab the lock:
>
> 1) Lock has no owner
>
> We probably want to simply grab the lock with an atomic instruction. 
> But then if other threads are queued on sys_futex and did not manage 
> to grab the lock yet, this would be detrimental to fairness.
>
> 2) Lock owner is running:
>
> The lock owner is certainly running on another cpu (I'm using the term 
> "cpu" here as logical cpu).
>
> I guess we could either decide to bypass sys_futex entirely and try to 
> grab the lock with an atomic, or we go through sys_futex nevertheless 
> to allow futex to guarantee some fairness across threads.

About the fairness part:

Even if you enqueue everyone, the futex syscall doesn't provide any 
guarantee about the order of the wake. The current implementation tries 
to be fair, but I don't think it works for every case. I wouldn't be 
much concern about being fair here, given that it's an inherent problem 
of the futex anyway.

 From the man pages:

"No guarantee is provided about which waiters are awoken"

>
> 3) Lock owner is sleeping:
>
> The lock owner may be either tied to the same cpu as the requester, or 
> a different cpu. Here calling FUTEX_WAIT and friends is pretty much 
> required.
>
> Can you elaborate on why skipping sys_futex in scenario (2) would be 
> so bad ? I wonder if we could get away with skipping futex entirely in 
> this scenario and still guarantee fairness by implementing MCS locking 
> or ticket locks in userspace. Basically, if userspace queues itself on 
> the lock through either MCS locking or ticket locks, it could 
> guarantee fairness on its own.
>
> Of course things are more complicated with PI-futex, is that what you 
> have in mind ?
>
>>
>>>>
>>>> It is only provided as an optimization hint, because there is no
>>>> guarantee that the page containing this field is in the page cache, 
>>>> and
>>>> therefore the scheduler may very well fail to clear the on-cpu 
>>>> state on
>>>> preemption. This is expected to be rare though, and is resolved as 
>>>> soon
>>>> as the task returns to user-space.
>>>>
>>>> The goal is to improve use-cases where the duration of the critical
>>>> sections for a given lock follows a multi-modal distribution, 
>>>> preventing
>>>> statistical guesses from doing a good job at choosing between 
>>>> busy-wait
>>>> and futex wait behavior.
>>>
>>> As always, are syscalls really *that* expensive? Why can't we busy wait
>>> in the kernel instead?
>>>
>>> I mean, sure, meltdown sucked, but most people should now be running
>>> chips that are not affected by that particular horror show, no?
>>
>> IIRC 'page table separation' which is what makes system calls expensive
>> is only a compile-time option. So is likely to be enabled on any 
>> 'distro'
>> kernel.
>> But a lot of other mitigations (eg RSB stuffing) are also pretty 
>> detrimental.
>>
>> OTOH if you have a 'hot' userspace mutex you are going to lose whatever.
>> All that needs to happen is for a ethernet interrupt to decide to 
>> discard
>> completed transmits and refill the rx ring, and then for the softint 
>> code
>> to free a load of stuff deferred by rcu while you've grabbed the mutex
>> and no matter how short the user-space code path the mutex won't be
>> released for absolutely ages.
>>
>> I had to change a load of code to use arrays and atomic increments
>> to avoid delays acquiring mutex.
>
> That's good input, thanks! I mostly defer to André Almeida on the 
> use-case motivation. I mostly provided this POC patch to show that it 
> _can_ be done with sys_rseq(2).
>
> Thanks!
>
> Mathieu
>
>>
>>     David
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, 
>> MK1 1PT, UK
>> Registration No: 1397386 (Wales)
>>
>
