Return-Path: <linux-kernel+bounces-96146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C148757A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B685288092
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6411135A55;
	Thu,  7 Mar 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WsZd/qNi"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CC136997;
	Thu,  7 Mar 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841223; cv=none; b=An1JOoSZBZtNmeKNPohFwXaIndsJyi73XihARo2yobI8ANPdtGjKP7UQYuvy2O38/tzJ/0aQwd1YdQJXa3/7CV9/JsQJLaYat5UolXA0o5mD0V86bwk8gAAUGUb8M5s9S/VOkYNdBJuNoy/j8Po0Ti1f42p+1zyndccEX7hoQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841223; c=relaxed/simple;
	bh=zRgZE5fbXzGYUDe/8aTzaKHsVEJhLmuJGro/sCSB+os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIqm/l3hoc89dUctSdA3jAnDGkMv3qdaMxCB/Mf1ReSpSfGyBIMUzQCl56gABls3opfTYdDqIVKWqx7j6cvRxQg6G88Cz0GxmJy9ka1inSQbdcPc6WBHOlMbLyMuXLbVevGkneGcYCnFS4+IOFEYeO0qWhWPL5jEi+dD7tU5lUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WsZd/qNi; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709841214;
	bh=zRgZE5fbXzGYUDe/8aTzaKHsVEJhLmuJGro/sCSB+os=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WsZd/qNiql9JkebQKPDKJwf4+/oYqeljD1pVDO/f8vKvTj9t4Rrje5MvBO1/pxG3J
	 A6RcO0nSPE3YZXj65B6fsz6DAsXrGGdcLjAoN8cSgKHVAmey9XLuK/IgHaUdYnBa07
	 nRRKw7ZwuQvFvrq5ma8nFl6NS22U8JxBO9zIq819JBrQ8AtebQ0tJvaY40ct3DyyPB
	 sOXLKnIQXi2AswOKGT2/23qWNJMCtbquRJBQFczxHUldm4lCSA0qXUtC3Mt2vcd852
	 R3HSDOHAVOudl3ewroGvcHFdp2vyDBqd4BUZRvfUyUDZrv8SGulI/udotnHz8SWm95
	 N0DZJvhlse0KQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TrKjp1LSzzgT7;
	Thu,  7 Mar 2024 14:53:34 -0500 (EST)
Message-ID: <2721d70f-67a8-428f-903b-1c7c6c6da7f9@efficios.com>
Date: Thu, 7 Mar 2024 14:53:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Content-Language: en-US
To: paulmck@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
 joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
 frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com,
 quic_neeraju@quicinc.com, rcu@vger.kernel.org
References: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
 <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
 <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com>
 <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-07 14:47, Paul E. McKenney wrote:
> On Thu, Mar 07, 2024 at 08:53:05AM -0500, Mathieu Desnoyers wrote:
>> On 2024-03-06 22:37, Paul E. McKenney wrote:
>>> On Wed, Mar 06, 2024 at 10:06:21PM -0500, Mathieu Desnoyers wrote:
>> [...]
>>>
>>>> As far as the WRITE_ONCE(x, READ_ONCE(x) + 1) pattern
>>>> is concerned, the only valid use-case I can think of is
>>>> split counters or RCU implementations where there is a
>>>> single updater doing the increment, and one or more
>>>> concurrent reader threads that need to snapshot a
>>>> consistent value with READ_ONCE().
>>>
>> [...]
>>>
>>> So what would you use that pattern for?
>>>
>>> One possibility is a per-CPU statistical counter in userspace on a
>>> fastpath, in cases where losing the occasional count is OK.  Then learning
>>> your CPU (and possibly being immediately migrated to some other CPU),
>>> READ_ONCE() of the count, increment, and WRITE_ONCE() might (or might not)
>>> make sense.
>>>
>>> I suppose the same in the kernel if there was a fastpath so extreme you
>>> could not afford to disable preemption.
>>>
>>> At best, very niche.
>>>
>>> Or am I suffering a failure of imagination yet again?  ;-)
>>
>> The (niche) use-cases I have in mind are split-counters and RCU
>> grace period tracking, where precise counters totals are needed
>> (no lost count).
>>
>> In the kernel, this could be:
> 
> Thank you for looking into this!
> 
>> - A per-cpu counter, each counter incremented from thread context with
>>    preemption disabled (single updater per counter), read concurrently by
>>    other threads. WRITE_ONCE/READ_ONCE is useful to make sure there
>>    is no store/load tearing there. Atomics on the update would be stronger
>>    than necessary on the increment fast-path.
> 
> But if preemption is disabled, the updater can read the value without
> READ_ONCE() without risk of concurrent update.  Or are you concerned about
> interrupt handlers?  This would have to be a read from the interrupt
> handler, given that an updated from the interrupt handler could result
> in a lost count.

You are correct that the updater don't need READ_ONCE there. It would
however require a WRITE_ONCE() to match READ_ONCE() from concurrent
reader threads.

> 
>> - A per-thread counter (e.g. within task_struct), only incremented by the
>>    single thread, read by various threads concurrently.
> 
> Ditto.

Right, only WRITE_ONCE() on the single updater, READ_ONCE() on readers.

> 
>> - A counter which increment happens to be already protected by a lock, read
>>    by various threads without taking the lock. (technically doable, but
>>    I'm not sure I see a relevant use-case for it)
> 
> In that case, the lock would exclude concurrent updates, so the lock
> holder would not need READ_ONCE(), correct?

Correct.

> 
>> In user-space:
>>
>> - The "per-cpu" counter would have to use rseq for increments to prevent
>>    inopportune migrations, which needs to be implemented in assembler anyway.
>>    The counter reads would have to use READ_ONCE().
> 
> Fair enough!
> 
>> - The per-thread counter (Thread-Local Storage) incremented by a single
>>    thread, read by various threads concurrently, is a good target
>>    for WRITE_ONCE()/READ_ONCE() pairing. This is actually what we do in
>>    various liburcu implementations which track read-side critical sections
>>    per-thread.
> 
> Agreed, but do any of these use WRITE_ONCE(x, READ_ONCE(x) + 1) or
> similar?

Not quite, I recall it's more like WRITE_ONCE(x, READ_ONCE(y)) or such,
so we can grab the value of the current gp counter and store it into a
TLS variable.


> 
>> - Same as for the kernel, a counter increment protected by a lock which
>>    needs to be read from various threads concurrently without taking
>>    the lock could be a valid use-case, though I fail to see how it is
>>    useful due to lack of imagination on my part. ;-)
> 
> In RCU, we have "WRITE_ONCE(*sp, *sp + 1)" for this use case, though
> here we have the WRITE_ONCE() but not the READ_ONCE() because we hold
> the lock excluding any other updates.

You are right, the READ_ONCE() is not needed in this case for the
updater, only for the concurrent readers.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


