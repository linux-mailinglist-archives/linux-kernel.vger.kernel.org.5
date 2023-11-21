Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93437F3142
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjKUOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjKUOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:40:08 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31090;
        Tue, 21 Nov 2023 06:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700577603;
        bh=slOFY68DjOchIUSbT+0P10wYKdi7DSeShvA8TWwjWz8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KUshoXXQ6U+EbM1gWiZMHcLrEe4/UVNuVSMc8hLAxI8KOXpXSpe/ojGA076MWNKOx
         HeseirwwDI2Y1PKCD/UHEt8Uh1pzHO4s/F+plqwai+8GwqerVcSzvi3ke7DOyR/mh3
         a0aDfS0xZz1kji2I/sSHCsS3WDG7/29Mi2R/Brs3nYEd2wnw8dPjsnLaqkG+jHhiKg
         +WFh597cY+92PEio+40+y5XPtLVjTiDs8ovVzeIouUQtv62JyyiHx7c0TXI+czGqXM
         +7gjwvwNjs7FBmPTr9HbyK55WtJka8NuW8Yekb7J5O/wGqOlWUgWSesxtGarnsV5UI
         HLNTWMVlFuX3A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZRqR20Rqz1dDq;
        Tue, 21 Nov 2023 09:40:03 -0500 (EST)
Message-ID: <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
Date:   Tue, 21 Nov 2023 09:40:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231121143647.GI8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 09:36, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 09:06:18AM -0500, Mathieu Desnoyers wrote:
>> Task trace RCU fits a niche that has the following set of requirements/tradeoffs:
>>
>> - Allow page faults within RCU read-side (like SRCU),
>> - Has a low-overhead read lock-unlock (without the memory barrier overhead of SRCU),
>> - The tradeoff: Has a rather slow synchronize_rcu(), but tracers should not care about
>>    that. Hence, this is not meant to be a generic replacement for SRCU.
>>
>> Based on my reading of https://lwn.net/Articles/253651/ , preemptible RCU is not a good
>> fit for the following reasons:
>>
>> - It disallows blocking within a RCU read-side on non-CONFIG_PREEMPT kernels,
> 
> Your counter points are confused, we simply don't build preemptible RCU
> unless PREEMPT=y, but that could surely be fixed and exposed as a
> separate flavour.
> 
>> - AFAIU the mmap_sem used within the page fault handler does not have priority inheritance.
> 
> What's that got to do with anything?
> 
> Still utterly confused about what task-tracing rcu is and how it is
> different from preemptible rcu.

In addition to taking the mmap_sem, the page fault handler need to block
until its requested pages are faulted in, which may depend on disk I/O.
Is it acceptable to wait for I/O while holding preemptible RCU read-side?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

