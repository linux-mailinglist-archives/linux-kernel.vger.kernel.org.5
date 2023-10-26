Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469157D886B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJZSg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJZSgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:36:25 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C460710A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698345381;
        bh=wVwxr0EqhCa/79uqd0S0BfYl2wt+pSfYm2ZTXUv0IJg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=svHuDhDy3Ida9p47ja1VfvQycI6QkrRyu10ZjHZY2WQZuQYUNJyTpCg80O9WM9EeR
         07/cJGWJSStjt5A/Daw3fAy3FREH73TDChQzfoVuBgNQsdSMiA41J8pWmGkc9d1ok4
         t+oCOifi7gPN4j4cYFJyYcMWVGuga8Ks3kUzAKa01MAXU9GEJ8CWFxsfVXRzqpxO7P
         DlkvL3f6v/GZUoDGIw0iGQwkxCIkKcme6KXMtdWaeWbPvs+FgDu3ac0DqOwQTmaouv
         Orkv6NoA2RlFsUGXcoLksDThUDcUqlv5hGIjVMlHtCIrItsNtvp7fRmdbHpw1T1ajx
         dU5pY876gteZw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SGZJ53Htgz1ZCH;
        Thu, 26 Oct 2023 14:36:21 -0400 (EDT)
Message-ID: <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
Date:   Thu, 26 Oct 2023 14:36:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
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
References: <20231025235413.597287e1@gandalf.local.home>
 <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
 <20231026071413.4ed47b0e@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231026071413.4ed47b0e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-26 07:14, Steven Rostedt wrote:
> On Thu, 26 Oct 2023 12:59:44 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Wed, Oct 25, 2023 at 11:54:13PM -0400, Steven Rostedt wrote:
>>
>>>   static void extend(void)
>>>   {
>>> 	rseq_map.cr_flags = 1;
>>>   }
>>>
>>>   static void unextend(void)
>>>   {
>>> 	unsigned long prev;
>>>
>>> 	prev = xchg(&rseq_map.cr_flags, 0);
>>
>> So you complain about overhead and then you add one of the most
>> expensive ops possible here? xchg has an implicit LOCK prefix and you
>> really don't need LOCK prefix here.
> 
> Peter, this is the user space side, where I cut and pasted the code from
> the file I attached.
> 
> That has:
> 
> static inline unsigned long
> xchg(volatile unsigned *ptr, unsigned new)
> {
>          unsigned ret = new;
> 
> 	asm volatile("xchg %b0,%1"

which has an implicit lock prefix (xchg with a memory operand is a 
special-case):

Quoting Intel manual:

"If a memory operand is referenced, the processor’s locking protocol is 
automatically implemented for the duration of the exchange operation, 
regardless of the presence or absence of the LOCK prefix or of the value 
of the IOPL. (See the LOCK prefix description in this chapter for more 
information on the locking protocol.)"

Thanks,

Mathieu


> 		     : "+r"(ret), "+m"(*(ptr))
> 		     : : "memory");
>          return ret;
> }
> 
> -- Steve
> 
> 
>>
>>> 	if (prev & 2) {
>>> 		tracefs_printf(NULL, "Yield!\n");
>>> 		sched_yield();
>>> 	}
>>>   }
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

