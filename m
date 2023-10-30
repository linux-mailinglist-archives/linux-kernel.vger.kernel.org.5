Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFE77DBA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjJ3M4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3M4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:56:38 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05848A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698670592;
        bh=sTuGSzxlodREgxcS2UWzIxTYJ0GN5DcFjE0VtX76IPs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fE3NbRc9/1Qae9xJ15f2b8QPi3Jz7XjazZFaXa7xTg/aPoR5Pa2E5+Ibx/akSB1Gx
         9IDAnNU9lfazAasXyaIbFdcXYC27nZiqy/Tb0zgMAtedAVZ68OZBs3CofgdZ92T66F
         Fh2N73pltZ7zros/GUN/mqYl3qR756zzawajm2xO6/6cmdafuYqmRss9VgaDmUkWEr
         OaKd5Vn9vlvtyadkFqVOo2SCX+17pDDB1ft6PCLf+T/bonkze/qJ/+LngEcmIzROkb
         3Y/zkZG/4hODUOHZyyL9OXY7tILFfZIqKcBCSEIllQMFbJMhpZy4vFVq+vnqMvlJXb
         sxbld5/DpSrvg==
Received: from [IPV6:2606:6d00:100:4000:2d85:44b8:ccb0:e487] (unknown [IPv6:2606:6d00:100:4000:2d85:44b8:ccb0:e487])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SJtZ82FF0z1Zr7;
        Mon, 30 Oct 2023 08:56:32 -0400 (EDT)
Message-ID: <ce0dbdaf-6be4-4f3b-9b5a-aedeac00ddf6@efficios.com>
Date:   Mon, 30 Oct 2023 08:56:50 -0400
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231027124930.3753cdd4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-27 12:49, Steven Rostedt wrote:
> On Fri, 27 Oct 2023 12:35:56 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> Does that make more sense?
>>
>> Not really.
>>
>> Please see my other email about the need for a reference count here, for
>> nested locks use-cases.
> 
> Note, my original implementation of nested locking was done completely in
> user space.
> 
> int __thread lock_cnt;
> 
> extend() {
> 	if (lock_cnt++)
> 		return;
> 	...
> }
> 
> unextend() {
> 	if (--lock_cnt)
> 		return;
> 	...
> }

This only works if "your" lock implementation is the only user of this 
RSEQ feature within a process. RSEQ requires that multiple libraries can 
share the facilities. Therefore, the rseq field should include the 
nesting counter as part of the RSEQ ABI so various userspace libraries 
can use it collaboratively.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

