Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F37D9DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbjJ0QJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJ0QJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:09:47 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D4C1B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698422981;
        bh=5H2knSLNVRZjGwvUbx+qNm8pfuijDJno13zOo0IuzuU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jNjKzUUAZlZJL/a/KVBndVE/ZSUxYE3u61NVqoDojd5xTvFFmZ9BnPy2fHoAzvv4T
         VO9CgG96/v6uMW9Nn0KoYaTLLQmSit5G/tR6GXaZjk1374mFeySJyDaolRQu5U+Shu
         7mvhbAuFnqIvbvDy/rdtKUFb9vNojrGPow6sM3fx2gi9HK0bWgkwjXSFy2tXlJm2vs
         lYzIsnxVSM/NhG3rTN5LFti8eTMMpeGV5Nuc1ujMkzL16NDMRLKNlHAJIJxNc58mch
         dJm6AK/y5IkslkYEcwXS+gLGgsmUx+lpa7XRMMP1ax93W47vBjtVGAxhCJcL0cSI8O
         3pkbFKXcknn4w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SH70N4kCgz1ZPV;
        Fri, 27 Oct 2023 12:09:40 -0400 (EDT)
Message-ID: <644da047-2f7a-4d55-a339-f2dc28d2c852@efficios.com>
Date:   Fri, 27 Oct 2023 12:09:56 -0400
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231026164549.14d45c60@gandalf.local.home>
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

On 2023-10-26 16:45, Steven Rostedt wrote:
> On Thu, 26 Oct 2023 14:59:13 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> for a rough implementation of a 'xchg()' without SMP coherency, just
>>> cpu-local one (ie atomic wrt being preempted by the kernel, but not
>>> atomic wrt other CPU's accessing the same variable concurrently)
>>
>> Actually Steven does not need a xchg to test-and-set a single bit which
>> is only accessed concurrently between kernel and userspace from the same
>> thread. Either "bts" or "andb" should work fine.
> 
> Hmm, how would bts work? Doesn't that just set a bit?

Yes, and it saves the bit state in the CF flag before setting it.

If you need to clear a bit then it would be "btr".

> 
> I need to clear one bit while seeing if another bit is set. I could also
> use subl, as that would also atomically clear the bit.

Ah ok, I did not get that you needed to test for a different bit than 
the one you clear.

Thanks,

Mathieu

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

