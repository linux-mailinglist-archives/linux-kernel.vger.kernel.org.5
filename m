Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855E07F3350
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjKUQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:11:44 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B52194;
        Tue, 21 Nov 2023 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700583099;
        bh=DmMeP04wWvVJ9Ig1UHO9FEjPRaZJhRzoI9mQxgdM5yU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b04vGaVkAFuqvUyKimip1PQQQ2lSohFtEsRhADtFH6XYosHXu+5Qhy7+E7ImM082b
         Zl+KRIX8Ra+60eI0lQDe3ezXLq0/kf8qR1yUhweS+0xFzPtEekT9J5e08jovOpbHg9
         DaXb24JPyAwbzqhEmYV6/cKp0JYNwATJAT3ci9PgPrhYTnqPMwrLECly610kdfgp6l
         6uQe1seqFnZV1Ku2eBwOa7Rwn62y8XF+G2h8coEvNsM0iFfjbfjhtJAFjhQhZv/PXq
         50MO23aEX5NozfES6R4Yo6YvV+zWOfOlHVfPGMbAuCUTLT/O9YwLMfzgreJC5n21N2
         74qDXj8kqY4sQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZTs7040Zz1cmd;
        Tue, 21 Nov 2023 11:11:38 -0500 (EST)
Message-ID: <e1d33ff6-bf8d-465f-8626-f692ce4debe5@efficios.com>
Date:   Tue, 21 Nov 2023 11:11:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
References: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
 <20231121155256.GN4779@noisy.programming.kicks-ass.net>
 <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
 <20231121110753.41dc5603@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231121110753.41dc5603@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 11:07, Steven Rostedt wrote:
> On Tue, 21 Nov 2023 11:00:13 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> tasks-tracing-rcu:
>>>     extention of tasks to have critical-sections ? Should this simply be
>>>     tasks?
>>
>> tasks-trace-rcu is meant to allow tasks to block/take a page fault
>> within the read-side. It is specialized for tracing and has a single
>> domain. It does not need the smp_mb on the read-side, which makes it
>> lower-overhead than SRCU.
> 
> IOW, task-trace-rcu allows the call to schedule in its critical section,
> whereas task-rcu does not?

Correct.

And unlike preemptible rcu, tasks-trace-rcu allows calls to schedule 
which do not provide priority inheritance guarantees (such as I/O 
triggered by page faults).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

