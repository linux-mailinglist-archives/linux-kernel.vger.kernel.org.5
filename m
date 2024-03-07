Return-Path: <linux-kernel+bounces-95665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328D8750F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977EE1F2559B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FAF5F86B;
	Thu,  7 Mar 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KlmSRKzH"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37312BE88;
	Thu,  7 Mar 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819581; cv=none; b=LPHZ1ubGw38lQtvrcG6k/H5+N1X/oWHL2aD4d89gR5tApjx22gSeqWmwHU9fRaq9Ibcx+7zRWyo3DKgRvqrFUYOiNdqn6XoPl22yXoiuvx7LHujYbJLOx4ETK/z7rdzyp27O3b2IpmZXCznfSG8vECh+nnH8HWy3C0tkhLSnlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819581; c=relaxed/simple;
	bh=iO+0TYAx2ydkRilhRnATUfwILFeAow/FzODPadKT+qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/tJoIUz7u5GHaoMTVhOWWYaM43Z99wAwF2kgjlNLkAWqdyNo+TlaEBWv0crUrPZBuV66LBUt1jnYVGfppZ/WkygZeFGuK69YDHKYPVJBamfhbRs2om/ERdweBx4GUbv3//BRfYf2tB26alruHZ0arZPzSh/Ygw3rbpuj7qu6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KlmSRKzH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709819576;
	bh=iO+0TYAx2ydkRilhRnATUfwILFeAow/FzODPadKT+qs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KlmSRKzHN4bmU3ruJRJVxCayr3zvTshQS6TqEQ0jNqR3VGfPyD2hWetuVL+ywxO6G
	 9hHqfzysCYdBNy4x6deKNqoxB1eqpnmVscpa7FNDzvwp0ELijoaQQHsgp3rBv9iK+R
	 ilAZ0kUIQ5uvcwjvydMxhMgnudn61K4hz9hecvyBEx+ALjwmn7TOoigNVfzXIH/Opa
	 XR297ncjReLBxoglCFvTSpOAnsOSLieN/YYhqVatim//sqD96ee+Zhg2mUKh8mgn+7
	 M+a8Zatn1A+IuDZzIv22wQzdHViKrdSU5U326crTGFQk5LGS/CZrHZ6gKV7wr+VkPp
	 UYI3A/DSQ01iw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tr9jg5cgtzg3L;
	Thu,  7 Mar 2024 08:52:55 -0500 (EST)
Message-ID: <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com>
Date: Thu, 7 Mar 2024 08:53:05 -0500
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
References: <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
 <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
 <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-06 22:37, Paul E. McKenney wrote:
> On Wed, Mar 06, 2024 at 10:06:21PM -0500, Mathieu Desnoyers wrote:
[...]
> 
>> As far as the WRITE_ONCE(x, READ_ONCE(x) + 1) pattern
>> is concerned, the only valid use-case I can think of is
>> split counters or RCU implementations where there is a
>> single updater doing the increment, and one or more
>> concurrent reader threads that need to snapshot a
>> consistent value with READ_ONCE().
> 
[...]
> 
> So what would you use that pattern for?
> 
> One possibility is a per-CPU statistical counter in userspace on a
> fastpath, in cases where losing the occasional count is OK.  Then learning
> your CPU (and possibly being immediately migrated to some other CPU),
> READ_ONCE() of the count, increment, and WRITE_ONCE() might (or might not)
> make sense.
> 
> I suppose the same in the kernel if there was a fastpath so extreme you
> could not afford to disable preemption.
> 
> At best, very niche.
> 
> Or am I suffering a failure of imagination yet again?  ;-)

The (niche) use-cases I have in mind are split-counters and RCU
grace period tracking, where precise counters totals are needed
(no lost count).

In the kernel, this could be:

- A per-cpu counter, each counter incremented from thread context with
   preemption disabled (single updater per counter), read concurrently by
   other threads. WRITE_ONCE/READ_ONCE is useful to make sure there
   is no store/load tearing there. Atomics on the update would be stronger
   than necessary on the increment fast-path.

- A per-thread counter (e.g. within task_struct), only incremented by the
   single thread, read by various threads concurrently.

- A counter which increment happens to be already protected by a lock, read
   by various threads without taking the lock. (technically doable, but
   I'm not sure I see a relevant use-case for it)

In user-space:

- The "per-cpu" counter would have to use rseq for increments to prevent
   inopportune migrations, which needs to be implemented in assembler anyway.
   The counter reads would have to use READ_ONCE().

- The per-thread counter (Thread-Local Storage) incremented by a single
   thread, read by various threads concurrently, is a good target
   for WRITE_ONCE()/READ_ONCE() pairing. This is actually what we do in
   various liburcu implementations which track read-side critical sections
   per-thread.

- Same as for the kernel, a counter increment protected by a lock which
   needs to be read from various threads concurrently without taking
   the lock could be a valid use-case, though I fail to see how it is
   useful due to lack of imagination on my part. ;-)

I'm possibly missing other use-cases, but those come to mind as not
involving racy counter increments.

I agree that use-cases are so niche that we probably do _not_ want to
introduce ADD_SHARED() for that purpose in a common header file,
because I suspect that it would then become misused in plenty of
scenarios where the updates are actually racy and would be better
served by atomics or local-atomics.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


