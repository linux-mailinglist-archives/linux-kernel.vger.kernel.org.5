Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFBB7D9E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjJ0Qfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJ0Qfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:35:44 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7ECA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698424541;
        bh=QWdx6DFVQZind8QLaT2jE8xtG7kdYVYQ+z2J3UzCR6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=v3LVu9xF93x0G9KkuMjo1xbghtWV5AJI2/xDZIzZhG0FIqmXMWLSh4OhUXMLceOZS
         3ECnssUtl3jEof3LrweXU+FozM1qVBQpgII5viwZhccQog9DfnjkrDCeyWAvl8LZUu
         ZB5Dtbqk5C1RmwmrtL+mFXJwnzMXfpoh3zGVyA4yjeQJhYggUeupHPVFqpEljRwbdb
         MYfqKJA/imvCyzzKkWMwORsO4VgL7+lfJWGp8BkuhuUTC6RdFNZWJMPiBAMoC8N5/v
         q7PpB1aWQzv+zGPPr85R+s42JYsv8P0HbBTsX07bTfCUZ6t7h7VrJ0sWz9+EnRB0cz
         S45DZ+sul1jFw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SH7ZN6LHgz1ZmM;
        Fri, 27 Oct 2023 12:35:40 -0400 (EDT)
Message-ID: <f0741a5b-229a-429a-8451-8af17261be9e@efficios.com>
Date:   Fri, 27 Oct 2023 12:35:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com,
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
References: <20231025235413.597287e1@gandalf.local.home>
 <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
 <20231026071413.4ed47b0e@gandalf.local.home>
 <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
 <CAHk-=whnyt2TccpDaWGTbDsVkKApL3c2FtDPMEwuTmeu_cEL8Q@mail.gmail.com>
 <7871472b-a0c4-4475-9671-69a3244f956d@efficios.com>
 <20231026164549.14d45c60@gandalf.local.home>
 <644da047-2f7a-4d55-a339-f2dc28d2c852@efficios.com>
 <20231027122442.5c76dd62@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231027122442.5c76dd62@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-27 12:24, Steven Rostedt wrote:
> On Fri, 27 Oct 2023 12:09:56 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> I need to clear one bit while seeing if another bit is set. I could also
>>> use subl, as that would also atomically clear the bit.
>>
>> Ah ok, I did not get that you needed to test for a different bit than
>> the one you clear.
> 
> Yeah, maybe I'm not articulating the implementation as well.
> 
>    bit 0: Set by user space to tell the kernel it's in a critical section
> 
>    bit 1: Set by kernel that it gave user space extend time slice
> 
> Bit 1 will only be set by the kernel if bit 0 is set.
> 
> When entering a critical section, user space will set bit 0. When it leaves
> the critical section, it needs to clear bit 0, but also needs to handle the
> race condition from where it clears the bit and where the kernel could
> preempt it and set bit 1. Thus it needs an atomic operation to clear bit 0
> without affecting bit 1. Once bit 0 is cleared, it does not need to worry
> about bit 1 being set after that as the kernel will only set bit 1 if it
> sees that bit 0 was set. After user space clears bit 0, it must check bit 1
> to see if it should now schedule. And it's also up to user space to clear
> bit 1, but it can do that at any time with bit 0 cleared.
> 
>   extend() {
> 	cr_flags = 1;
>   }
> 
>   unextend() {
> 	cr_flags &= ~1;  /* Must be atomic */
> 	if (cr_flags & 2) {
> 		cr_flags = 0;  /* May not be necessary as it gets cleared by extend() */
> 		sched_yield();
> 	}
>   }
> 
> Does that make more sense?

Not really.

Please see my other email about the need for a reference count here, for
nested locks use-cases.

By "atomic" operation I suspect you only mean "single instruction" which can
alter the state of the field and keep its prior content in a register, not a
lock-prefixed atomic operation, right ?

The only reason why you have this asm trickiness is because both states
are placed into different bits from the same word, which is just an
optimization. You could achieve the same much more simply by splitting
this state in two different words, e.g.:

extend() {
   WRITE_ONCE(__rseq_abi->cr_nest, __rseq_abi->cr_nest + 1);
   barrier()
}

unextend() {
   barrier()
   WRITE_ONCE(__rseq_abi->cr_nest, __rseq_abi->cr_nest - 1);
   if (READ_ONCE(__rseq_abi->must_yield)) {
     WRITE_ONCE(__rseq_abi->must_yield, 0);
     sched_yield();
   }
}

Or am I missing something ?

Thanks,

Mathieu
   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

