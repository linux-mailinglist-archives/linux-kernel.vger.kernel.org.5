Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4097DBF82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJ3SEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJ3SEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:04:52 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D2D9E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698689086;
        bh=ydHT5HXh6Ag6yIfOyy0n3n6NmVWPONL5Lz07QfKKJII=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hxh0JUIMlf04sqOC8ePwr5m+Ol3cmuHirj4HrbrIvVG5lDpeG+tDbJu8iXD3zoj37
         4ZEDsHL+2BiZdLi/LNI4xHzysZ4Qpd7qWDAw59xu8OIj7E3dmerfq54D3YWdDrDwlN
         wMawV6LAnr+sqwTW2XJdWm2MYBV7ZwOcmQ4IcR9tJF6rXbr98CNIfmDnonMq75YBt8
         IcgWCcOZs0bEgqQtCgPc2NrpiQ1xj7W43al6zgFasllh2jU6//KcxzQwOWIpPl5J7I
         cIhXz6Rgw6T0VILrpjMJDER3ilGaDnw8pUE+ojWj1mLurmSi7wV6kR6wen0phKNTw2
         wN/Vl8XY2kwoA==
Received: from [IPV6:2606:6d00:100:4000:2d85:44b8:ccb0:e487] (unknown [IPv6:2606:6d00:100:4000:2d85:44b8:ccb0:e487])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SK1Pp2Wmvz1ZQN;
        Mon, 30 Oct 2023 14:04:46 -0400 (EDT)
Message-ID: <bb628206-28eb-470e-aaea-0f18ce94e983@efficios.com>
Date:   Mon, 30 Oct 2023 14:05:05 -0400
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
 <f0741a5b-229a-429a-8451-8af17261be9e@efficios.com>
 <20231027124930.3753cdd4@gandalf.local.home>
 <ce0dbdaf-6be4-4f3b-9b5a-aedeac00ddf6@efficios.com>
 <20231030094508.031357b4@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231030094508.031357b4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30 09:45, Steven Rostedt wrote:
> On Mon, 30 Oct 2023 08:56:50 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>> This only works if "your" lock implementation is the only user of this
>> RSEQ feature within a process. RSEQ requires that multiple libraries can
>> share the facilities. Therefore, the rseq field should include the
>> nesting counter as part of the RSEQ ABI so various userspace libraries
>> can use it collaboratively.
>>
> 
> Then I would suggest allowing bit 31 be an "on/off" switch, and the lower
> bits to be a counter. When I first tried this with postgres, there was one
> lwlock that looked to be held for the majority of the run, so I got rid of
> the nesting. But I think a mixture of both would work, where you can have a
> nesting counter and an on/off switch with the caveat that if you use it and
> enable it, another library may disable it.

If you have the nesting counter, why do you need the explicit on/off 
switch ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

