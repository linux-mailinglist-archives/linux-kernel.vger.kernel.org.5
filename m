Return-Path: <linux-kernel+bounces-83064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D5868E02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0914A1F24A50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76813959D;
	Tue, 27 Feb 2024 10:51:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223613957E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031061; cv=none; b=VULtBeYFB0TftdVSOzLLTaRYkfdaTfT85v6cdyKOLTJRH6Tm8vDViYA60OZZMXVksmg7Dq5SJEXPwHWnjhnuNPqk0QqqPDuDA4+CpUKEXMrfDosZlaKV9Kn/m0+CsubjI6MTcVpo7VKXW8++yBzgbAeefn/SA/4FjmiS1D9ZjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031061; c=relaxed/simple;
	bh=2Rd7/znJ9ldjs+c85dWA3pin44oLTIYZC7TKswh7vJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YMWpyyduwoCwpfxcfy+oPqpczslGbnkaGw4OrlpABQDkVqIMs5HeD+rqNmwlsyvjTypDFHf+F6LKfrRmK0JKdRoSmZzW8rhD/v9zpkqok6AfBbmzGEpUhyi0Wpq6JWGNu5OpOoHz58sBsyI51G1UbijR2C0iDOcLv8SkRgyIkgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB1ADA7;
	Tue, 27 Feb 2024 02:51:37 -0800 (PST)
Received: from [10.1.25.55] (e133047.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60E243F6C4;
	Tue, 27 Feb 2024 02:50:58 -0800 (PST)
Message-ID: <00d36e83-c9a5-412d-bf49-2e109308d6cd@arm.com>
Date: Tue, 27 Feb 2024 10:50:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: split iowait state into two states
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
References: <9610e52e-1d9a-466d-be2b-29482f0d0490@kernel.dk>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <9610e52e-1d9a-466d-be2b-29482f0d0490@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jens,

On 26/02/2024 16:15, Jens Axboe wrote:
> iowait is a bogus metric, but it's helpful in the sense that it allows
> short waits to not enter sleep states that have a higher exit latency
> than we would've picked for iowait'ing tasks. However, it's harmless in
> that lots of applications and monitoring assumes that iowait is busy
> time, or otherwise use it as a health metric. Particularly for async
> IO it's entirely nonsensical.> 
> Split the iowait part into two parts - one that tracks whether we need
> boosting for short waits, and one that says we need to account the task
> as such. ->in_iowait_acct nests inside of ->in_iowait, both for
> efficiency reasons, but also so that the relationship between the two
> is clear. A waiter may set ->in_wait alone and not care about the
> accounting> 
> Existing users of nr_iowait() for accounting purposes are switched to
> use nr_iowait_acct(), which leaves the governor using nr_iowait() as it
> only cares about iowaiters, not the accounting side.
> 
> io_schedule_prepare() and io_schedule_finish() are changed to return
> a simple mask of two state bits, as we now have more than one state to
> manage. Outside of that, no further changes are needed to suppor this
> generically.
> [snip]

Actually there are probably three uses of the in_iowait flag
1. The (original) accounting use
2. The sleep state heuristic based on nr_iowaiters in cpuidle/governors/menu.c
3. The CPU frequency boost when in_iowait tasks wake up implemented in both
intel_pstate.c and cpufreq_schedutil.c cpufreq governors.

2 & 3 have just been piggybacked onto 1 because they work somewhat, but as
your patch also shows they really don't.
I have been working on a hopefully better approach for 3., I'll use your patch
as a chance to reintroduce the problem. I was going to ask for your thoughts
on the patch anyway.

The piggybacking of 2 and 3 have (IMHO) more dire consequences than just the
fact that you have to accept being accounted for as busy (until now) if you
wanted to make use of 2 and 3.

I assume the intention of your patch is to remove this link for the io_uring
case in particular, given that AFAICT it's the only occurence actually affected
by your patch (sets in_iowait directly and not the helper functions which will
set both in_iowait and in_iowait_acct).

I think that is the right direction, but if we touch this stuff, can we also
consider reworking it entirely?
Let's take io_uring as an example, not because it's the worst, but because it's
overhead is so low it shows the biggest problem (or room for improvement).

The iowait boosting of the CPU frequency will currently lead to e.g.
io_uring NR_CPUS threads with high enough iodepth (let's say 128) to possibly run
all CPUs on the highest, or at least one of the higher OPPs (frequency and
therefore power consumption).
(fio  --rw=randread --bs=4k --ioengine=io_uring --iodepth=128 --numjobs=$(nproc) for 12 CPUs)
if we're using e.g. cpufreq_schedutil.c on all of them.
This is an issue as on many systems even running them on the lowest OPP suffices
to saturate the storage device (using cpufreq governor powersave on all).
The frequency boost based on iowait is therefore incredibly wasteful here
and destroys the incredibly low overhead of io_uring and the impact it could have
on energy being spent by the CPU.

Looking at git grep io_schedule and mutex_lock_io iowait currently means
anything from actual block io over sending CXL transactions to waiting
for DMA fences as a i915 GPU driver.
These things are clearly very different and deserve distinct handling.

Even if we remain in the realm of block io we have, as you already put it
nicely, "for async IO it's entirely nonsensical", but it doesn't stop there.
Writes in general have a similar problem, for some SSDs we just boost the
CPU frequency to land a tiny bit earlier in the SSDs DRAM cache, where it
will be flushed to flash at it's convenience (or necessity).
Again, boosting being entirely wasteful.
Boosting is of course also applied on periodic page cache writebacks for usually
no good reason at all.

I have a patch for 3 that (among other changes) tracks if the boost actually
improved throughput (measured in the only way we currently can, iowait wakeups
per time interval). I think it's an improvement over the current situation, but
it's far from perfect.

Ideally we would get the three different signals as distinct:
1. iowait_acct
2. iowait_short_sleep or something, we expect to wake up pretty soon due to some IO,
(which in case of the block layer maybe there would even be some estimate when?)
3. iowait_util_boost to signal we are in a scenario where the time between iowaits
(that the task is potentially using the CPU), is critical to IO throughput and
therefore running it as quickly as possible is worth the energy spending of boosting.

Ideally we (the sched folks) would move away from these iowait-piggybacked
heuristics and try to get as much information as possible from the e.g. the
block layer and act accordingly.
At least for the iowait boosting of frequency I would claim the heuristics are
wrong more often than not.

Would love to hear your thoughts and thanks for the patch (and apologies for
this scope-explosion, but I think the discussion is worth having).

Kind Regards,
Christian

