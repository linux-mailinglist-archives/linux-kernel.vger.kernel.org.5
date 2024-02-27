Return-Path: <linux-kernel+bounces-83264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BB8690FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FB1F27A88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988B13AA51;
	Tue, 27 Feb 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="htSMDbmL"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0613B783
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038425; cv=none; b=RqY9Mlai31gvmK5bhyWUp0nvS7sGdBnqg32brdtW6yTpTGsksikIMcvgwf2FC4cDQqOsRe/JA4rfLYeRKvrMwg6rPsu1EjG9xhlyqYyOBFG28Ym0pBPjWutLR6QhVGQzebAMUGD5pKAKguOK83JTxSdBvMekctSOmsyF3olDHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038425; c=relaxed/simple;
	bh=Jye65YB0o9+FQhgW7OM95JwCrvLNzuRqvxglt5+B+jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IFnL6cBrycmNcR2zhVFnYLdOUypXVBirmre2qytxawWNzUWybZ7en5LxUVt5wFQdBW8II30z1Z+nSU5L7f/8Edp9c6pAowQLunLC5hYD0KAM1PaB6RU6F8QWoobylvGEXeB09ilsXUeIhaxq3ISVCyk3jNTHtev9Js0oaAltrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=htSMDbmL; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso83040939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709038420; x=1709643220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hICIPe+xrrPI8ZX4QKZiQ6QZ6jLDkbU9RzUBnS4pcZ8=;
        b=htSMDbmLgBJmzN1dShYewHxjBTEPywe3Z3XsW8vQQRP7tIxOsv0fd+QSRSwagFHWQ9
         EwfBWUV2fAFv67UyYHYEifY4py74UJi8YVjp0pOFIKaclyFlJKcJN5YIiCdKxwYWD/86
         JoyHuVVmTAkaBycDnVRgaYWzpjCnFetf1+6PD2J0d4BpemtuNaz0ZKeC2G3jGXxty9Ot
         9Tna2pa/pYYpLETBwChwKSgogZ21R7IHgc3dHiAa1P3KWNBLUMzSgcmJJcUwPwhsp9xN
         zbZhaEKlyn553pxiaBXNLR9GuNXYtvRZOTyQ6oDR2AI2EnxDDobNIKUcKIdIWH9Iare7
         rjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038420; x=1709643220;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hICIPe+xrrPI8ZX4QKZiQ6QZ6jLDkbU9RzUBnS4pcZ8=;
        b=RNE8FKpXofncvOHVZ+WFyTKYdj2JdCismuMUsNV+uHCD1TVbMLggLEP/h3suNDZaBw
         tIYGGVBVGFFdqiMvr+v7Vu2iBFbv0IcMVWULCVXH5pfoUjFMtJtB5Rz/gGwBWi7+dSRe
         m7lkmE/OhouWzNuWJjuxneleb5woFm0a3Xx69TSG+LJ5yt/hx7G5OQHRZfQRE6us8Wz6
         BTGPTO3/MLT7zL85cjJUl0zr8Cm0HGeuMnxVSON5SS0T6R+pS2QC9AJK3yZIsPcLG3yP
         wd2q3aO8l8KDTDtfh/EjUZBBa870XPEAPk2a41UFdUWl+NK7JXqYtoSz3hZzqVOcPszH
         D/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVK8D6jag6W7kCUMe6LPh/TK0UI/5uZMHwmM+hCFlVg9gBtpV4VLLlfMJ88ShsmAPgt8r15if9nw6ylp6m5i1QCDYio6o1R87OuDU5j
X-Gm-Message-State: AOJu0YyocFtUsgDI1K7QSriOSzP/dhB+HfZJFu0txinuhXymZFwZ0ZRd
	XPPN9ns45psmxvxlVcEvnFc0lhZ+jLGe+ka8dhNMILhGItuJaUEM2UItFmbdq2ZV24TfIb0LKco
	L
X-Google-Smtp-Source: AGHT+IEYFCHLxHf4TibNX8tW6UvOBuQ12+sdghFqbNqZUZ/PZxrU+c7YFScoxAeDJSmvW5tFA9BqqA==
X-Received: by 2002:a92:cda6:0:b0:365:4e45:33ad with SMTP id g6-20020a92cda6000000b003654e4533admr8730427ild.1.1709038420132;
        Tue, 27 Feb 2024 04:53:40 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056a00325400b006e2301e702fsm5877189pfb.125.2024.02.27.04.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 04:53:39 -0800 (PST)
Message-ID: <df434f80-adb1-46b4-9502-f39b089ee4a3@kernel.dk>
Date: Tue, 27 Feb 2024 05:53:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: split iowait state into two states
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>
References: <9610e52e-1d9a-466d-be2b-29482f0d0490@kernel.dk>
 <00d36e83-c9a5-412d-bf49-2e109308d6cd@arm.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00d36e83-c9a5-412d-bf49-2e109308d6cd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/24 3:50 AM, Christian Loehle wrote:
> Hi Jens,
> 
> On 26/02/2024 16:15, Jens Axboe wrote:
>> iowait is a bogus metric, but it's helpful in the sense that it allows
>> short waits to not enter sleep states that have a higher exit latency
>> than we would've picked for iowait'ing tasks. However, it's harmless in
>> that lots of applications and monitoring assumes that iowait is busy
>> time, or otherwise use it as a health metric. Particularly for async
>> IO it's entirely nonsensical.> 
>> Split the iowait part into two parts - one that tracks whether we need
>> boosting for short waits, and one that says we need to account the task
>> as such. ->in_iowait_acct nests inside of ->in_iowait, both for
>> efficiency reasons, but also so that the relationship between the two
>> is clear. A waiter may set ->in_wait alone and not care about the
>> accounting> 
>> Existing users of nr_iowait() for accounting purposes are switched to
>> use nr_iowait_acct(), which leaves the governor using nr_iowait() as it
>> only cares about iowaiters, not the accounting side.
>>
>> io_schedule_prepare() and io_schedule_finish() are changed to return
>> a simple mask of two state bits, as we now have more than one state to
>> manage. Outside of that, no further changes are needed to suppor this
>> generically.
>> [snip]
> 
> Actually there are probably three uses of the in_iowait flag
> 1. The (original) accounting use
> 2. The sleep state heuristic based on nr_iowaiters in cpuidle/governors/menu.c
> 3. The CPU frequency boost when in_iowait tasks wake up implemented in both
> intel_pstate.c and cpufreq_schedutil.c cpufreq governors.
> 
> 2 & 3 have just been piggybacked onto 1 because they work somewhat, but as
> your patch also shows they really don't.

Right, I did collapse 2 & 3 into cpufreq related sleep/wakeup latencies.

> I have been working on a hopefully better approach for 3., I'll use
> your patch as a chance to reintroduce the problem. I was going to ask
> for your thoughts on the patch anyway.
> 
> The piggybacking of 2 and 3 have (IMHO) more dire consequences than
> just the fact that you have to accept being accounted for as busy
> (until now) if you wanted to make use of 2 and 3.
> 
> I assume the intention of your patch is to remove this link for the
> io_uring case in particular, given that AFAICT it's the only occurence
> actually affected by your patch (sets in_iowait directly and not the
> helper functions which will set both in_iowait and in_iowait_acct).

Right. It doesn't matter too much for storage as people kind of expect
iowait on that side, but for high frequency network IO (or just
networked IO in general), adding iowait to the mix tends to confuse
application owners. And since stat is mostly garbage anyway, I can
either spend time arguing with people that it's a useless metric, or I
can do something about it and just eliminate it on my side for good.
BTW, reading your email you seem to equate io_uring with storage, this
is very much not the case. Just wanted to clarify that this is in no way
storage specific.

> I think that is the right direction, but if we touch this stuff, can
> we also consider reworking it entirely? Let's take io_uring as an
> example, not because it's the worst, but because it's overhead is so
> low it shows the biggest problem (or room for improvement).

Sure, I have no objections to that, though I do want to fix the
immediate problem of just getting rid of iowait accounting. As I don't
think the next step is immediately obvious, I'd prefer if we can at
least fix the immediate issue and defer a rework to a step 2.

> The iowait boosting of the CPU frequency will currently lead to e.g.
> io_uring NR_CPUS threads with high enough iodepth (let's say 128) to
> possibly run all CPUs on the highest, or at least one of the higher
> OPPs (frequency and therefore power consumption). (fio  --rw=randread
> --bs=4k --ioengine=io_uring --iodepth=128 --numjobs=$(nproc) for 12
> CPUs) if we're using e.g. cpufreq_schedutil.c on all of them. This is
> an issue as on many systems even running them on the lowest OPP
> suffices to saturate the storage device (using cpufreq governor
> powersave on all). The frequency boost based on iowait is therefore
> incredibly wasteful here and destroys the incredibly low overhead of
> io_uring and the impact it could have on energy being spent by the
> CPU.

To be honest, I think it's hard to generalize on that. For the above
example, it completely depends on what you're driving. If this is 12
CPUs doing IO to N devices, what kind of devices are these? Are they
doing millions of IOPS each, or is is 100k each? A storage device is
many things, and you can easily have a storage device that it would take
more than one CPU to fully saturate. Or you can have 12 of them that one
can easily saturate.

> Looking at git grep io_schedule and mutex_lock_io iowait currently
> means anything from actual block io over sending CXL transactions to
> waiting for DMA fences as a i915 GPU driver. These things are clearly
> very different and deserve distinct handling.
> 
> Even if we remain in the realm of block io we have, as you already put
> it nicely, "for async IO it's entirely nonsensical", but it doesn't
> stop there. Writes in general have a similar problem, for some SSDs we
> just boost the CPU frequency to land a tiny bit earlier in the SSDs
> DRAM cache, where it will be flushed to flash at it's convenience (or
> necessity). Again, boosting being entirely wasteful. Boosting is of
> course also applied on periodic page cache writebacks for usually no
> good reason at all.

I don't think that is true at all. We don't boost to have data land in
the drive cache earlier, we boost so that:

1) prepare IO to device
2) submit IO to device
3) wait on IO completion, task goes to sleep
4) IO completes, wake task
5) task wakes up, gets completion

the last two steps here aren't burdened by latencies that are higher
than they need to be, IOW steps 2 & 3 from above. This is why I'm
bundling them into one, as they really are the same thing from that
perspective.

> I have a patch for 3 that (among other changes) tracks if the boost
> actually improved throughput (measured in the only way we currently
> can, iowait wakeups per time interval). I think it's an improvement
> over the current situation, but it's far from perfect.
> 
> Ideally we would get the three different signals as distinct:
> 1. iowait_acct
> 2. iowait_short_sleep or something, we expect to wake up pretty soon
> due to some IO, (which in case of the block layer maybe there would
> even be some estimate when?)
> 3. iowait_util_boost to signal we are in a scenario where the time
> between iowaits (that the task is potentially using the CPU), is
> critical to IO throughput and therefore running it as quickly as
> possible is worth the energy spending of boosting.
>
> 
> Ideally we (the sched folks) would move away from these
> iowait-piggybacked heuristics and try to get as much information as
> possible from the e.g. the block layer and act accordingly. At least
> for the iowait boosting of frequency I would claim the heuristics are
> wrong more often than not.
> 
> Would love to hear your thoughts and thanks for the patch (and
> apologies for this scope-explosion, but I think the discussion is
> worth having).

As mentioned higher up, I do agree that there's room for improvement for
the heuristics in general, and I'll be more than happy to help test and
help with the block layer side or io_uring of things too. If we can get
good latencies when we need it and be cognizant of power at the same
time, that's certainly a win all around.

However, I would greatly prefer to sort out the mixing up of iowait
accounting and boosting first as it's a much simpler problem and
deserves fixing separately, and is not one that will inevitably get
complicated as it needs to coordinate across layers. Outside of that,
any change in heuristics for that will need considerable testing,
whereas the existing one is not encumbered by that.

I'll respin this version to try and avoid the atomics here, as that was
a comment that Peter had. If we can improve the existing nr_iowait
accounting and logic with that as well, then I think that's an exercise
that's worthwhile separately.

-- 
Jens Axboe


