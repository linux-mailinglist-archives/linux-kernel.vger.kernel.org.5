Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0772B7B1E18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjI1NYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjI1NYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:24:03 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4711BD7;
        Thu, 28 Sep 2023 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1695907278;
        bh=aQgmzs+zgElkhFAUe9cVIYtiek4AxaBx9SIvc7Taa3k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rCj2JJBpStddJ8UFVBhHCvO1i34JJCIg1dSVgElFZ/VZjjxBXsjSlHX4/bamQ1b4Y
         AkR+zmAOfBXIEZ0Mz+LDPtqf2F7jU/PFBRL6MnDua7hYl19lqrLaWzgOmJtr7jmLNr
         yt/nlHYMyZzKWa/avqt94HHZ8+H69NMkaF1Htv/aP6r5k1ON5Cvzrlk7d1pBw7tz9s
         Rny/QrzK6tbILSwEWSA7UIdFIKsh49DB0rHafJqvorC4XHs26w4p7BInwW1geC8Lqf
         CURbioBUdnv21M5Jr6sux2TVGSUbYb4ObBFWXuE9tUbbfPto0xykOu0XNyaEWWMmWg
         dLGpOhfyzpdwA==
Received: from [IPV6:2605:8d80:5a1:95e5:4101:ac48:ed0d:d728] (unknown [IPv6:2605:8d80:5a1:95e5:4101:ac48:ed0d:d728])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RxDdS23fZz1RDt;
        Thu, 28 Sep 2023 09:21:16 -0400 (EDT)
Message-ID: <34ddb730-8893-19a8-00fe-84c4e281eef1@efficios.com>
Date:   Thu, 28 Sep 2023 09:20:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
To:     David Laight <David.Laight@ACULAB.COM>,
        'Peter Zijlstra' <peterz@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        "carlos@redhat.com" <carlos@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
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
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ef39143ad24743008a896d2a09da1066@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 07:22, David Laight wrote:
> From: Peter Zijlstra
>> Sent: 28 September 2023 11:39
>>
>> On Mon, May 29, 2023 at 03:14:13PM -0400, Mathieu Desnoyers wrote:
>>> Expose the "on-cpu" state for each thread through struct rseq to allow
>>> adaptative mutexes to decide more accurately between busy-waiting and
>>> calling sys_futex() to release the CPU, based on the on-cpu state of the
>>> mutex owner.
> 
> Are you trying to avoid spinning when the owning process is sleeping?

Yes, this is my main intent.

> Or trying to avoid the system call when it will find that the futex
> is no longer held?
> 
> The latter is really horribly detremental.

That's a good questions. What should we do in those three situations 
when trying to grab the lock:

1) Lock has no owner

We probably want to simply grab the lock with an atomic instruction. But 
then if other threads are queued on sys_futex and did not manage to grab 
the lock yet, this would be detrimental to fairness.

2) Lock owner is running:

The lock owner is certainly running on another cpu (I'm using the term 
"cpu" here as logical cpu).

I guess we could either decide to bypass sys_futex entirely and try to 
grab the lock with an atomic, or we go through sys_futex nevertheless to 
allow futex to guarantee some fairness across threads.

3) Lock owner is sleeping:

The lock owner may be either tied to the same cpu as the requester, or a 
different cpu. Here calling FUTEX_WAIT and friends is pretty much required.

Can you elaborate on why skipping sys_futex in scenario (2) would be so 
bad ? I wonder if we could get away with skipping futex entirely in this 
scenario and still guarantee fairness by implementing MCS locking or 
ticket locks in userspace. Basically, if userspace queues itself on the 
lock through either MCS locking or ticket locks, it could guarantee 
fairness on its own.

Of course things are more complicated with PI-futex, is that what you 
have in mind ?

> 
>>>
>>> It is only provided as an optimization hint, because there is no
>>> guarantee that the page containing this field is in the page cache, and
>>> therefore the scheduler may very well fail to clear the on-cpu state on
>>> preemption. This is expected to be rare though, and is resolved as soon
>>> as the task returns to user-space.
>>>
>>> The goal is to improve use-cases where the duration of the critical
>>> sections for a given lock follows a multi-modal distribution, preventing
>>> statistical guesses from doing a good job at choosing between busy-wait
>>> and futex wait behavior.
>>
>> As always, are syscalls really *that* expensive? Why can't we busy wait
>> in the kernel instead?
>>
>> I mean, sure, meltdown sucked, but most people should now be running
>> chips that are not affected by that particular horror show, no?
> 
> IIRC 'page table separation' which is what makes system calls expensive
> is only a compile-time option. So is likely to be enabled on any 'distro'
> kernel.
> But a lot of other mitigations (eg RSB stuffing) are also pretty detrimental.
> 
> OTOH if you have a 'hot' userspace mutex you are going to lose whatever.
> All that needs to happen is for a ethernet interrupt to decide to discard
> completed transmits and refill the rx ring, and then for the softint code
> to free a load of stuff deferred by rcu while you've grabbed the mutex
> and no matter how short the user-space code path the mutex won't be
> released for absolutely ages.
> 
> I had to change a load of code to use arrays and atomic increments
> to avoid delays acquiring mutex.

That's good input, thanks! I mostly defer to André Almeida on the 
use-case motivation. I mostly provided this POC patch to show that it 
_can_ be done with sys_rseq(2).

Thanks!

Mathieu

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

