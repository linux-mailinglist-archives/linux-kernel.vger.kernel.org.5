Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7609C7D88A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjJZS7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjJZS7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:59:01 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D60F1AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698346738;
        bh=EzH15LLRG+ol+aSrFbKJfdK9hIa1sr7P6ThkbyXJ/9c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HZurCEiejfK4ERnwCy7KHs4XpysBsfsxQIhtI7vW32hYkhGOOQ7a9qUVklxIpPHG7
         YTWUnvLUiHrgoAhi/Vcllhisd0Swg2wJAWTpA7yFPXiRSKIUf5wyZxuvl4wGsSLNQe
         8mtaQA0b84AD5y2tIhEET6bdMB1I3htbnLmKyuJlVH24DH2wTQaQmU+3OxpPMJY0U5
         UVqeiDm21thNFkIZqWQkwMkYb7y1aloeZlrJ+R4Ohl6vwGS9NItgHJoeCEturDIWH1
         QToga4bAlsbSugRqT7yj9U+L1Me079VBI8eXB1oMSrQtQzXOVbFOT5S5U+E4425Ajn
         YDB/LjyzWhNew==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SGZpB1lgCz1Zd1;
        Thu, 26 Oct 2023 14:58:58 -0400 (EDT)
Message-ID: <7871472b-a0c4-4475-9671-69a3244f956d@efficios.com>
Date:   Thu, 26 Oct 2023 14:59:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=whnyt2TccpDaWGTbDsVkKApL3c2FtDPMEwuTmeu_cEL8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-26 14:50, Linus Torvalds wrote:
> On Thu, 26 Oct 2023 at 08:36, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>>>        asm volatile("xchg %b0,%1"
>>
>> which has an implicit lock prefix (xchg with a memory operand is a
>> special-case):
> 
> Yeah, this is why we do "percpu_xchg()" - which does not want locked
> semantics - as a "cmpxchg" loop.
> 
> Steven, check out
> 
>      arch/x86/include/asm/percpu.h
> 
> for a rough implementation of a 'xchg()' without SMP coherency, just
> cpu-local one (ie atomic wrt being preempted by the kernel, but not
> atomic wrt other CPU's accessing the same variable concurrently)

Actually Steven does not need a xchg to test-and-set a single bit which
is only accessed concurrently between kernel and userspace from the same
thread. Either "bts" or "andb" should work fine.

Thanks,

Mathieu

> 
>               Linus

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

