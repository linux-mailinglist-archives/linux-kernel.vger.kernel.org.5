Return-Path: <linux-kernel+bounces-158407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E7A8B1F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BDBB2687E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A832200BF;
	Thu, 25 Apr 2024 10:39:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C52182AE;
	Thu, 25 Apr 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041586; cv=none; b=qQeKNMcAZykEnhbPLi7WEZ/csUThZJ8OoaJd0kD/X3mbmGsHXQczaDMP9XpBStS37vFFvV986cUFzXW30W6GoNUZmLmZJJALfQPFP5BPXt6QD2+weuov2K+3AsjNQNxv/txumHfkGg/iskJqsrwEiHHsZ5dI/iGulqY4ik+BipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041586; c=relaxed/simple;
	bh=QOQqcsY1p+kptI6Tc0m7bn42wAqmzhfACV714bqm4xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWMOsRIn86E8f3hBfzlreX0G161aBSDR16HImjCQ3nPIidRzEoFtSljvcg90DZgot+vU0/DEr2oyR++RfP3Ns88ecK9mz7plSOUH46XNXc/kDvHOyshe1AnmlDpjqw29UvZ3KY/3WE0PHSkY5lDbJYgxiuIl0L2oRNwqnXvPli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED0D1007;
	Thu, 25 Apr 2024 03:40:12 -0700 (PDT)
Received: from [10.1.30.55] (e133047.arm.com [10.1.30.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4343F64C;
	Thu, 25 Apr 2024 03:39:42 -0700 (PDT)
Message-ID: <530475c7-5bba-444c-8045-0e4f8679306e@arm.com>
Date: Thu, 25 Apr 2024 11:39:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/core: split iowait state into two states
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-pm@vger.kernel.org, daniel.lezcano@linaro.org
References: <20240416121526.67022-1-axboe@kernel.dk>
 <20240416121526.67022-5-axboe@kernel.dk>
 <20240424100127.GV40213@noisy.programming.kicks-ass.net>
 <f82fdfa3-8743-4d42-82d4-a4ca9bc24e15@arm.com>
 <20240425101629.GC21980@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240425101629.GC21980@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 11:16, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 11:08:42AM +0100, Christian Loehle wrote:
>> On 24/04/2024 11:01, Peter Zijlstra wrote:
>>> On Tue, Apr 16, 2024 at 06:11:21AM -0600, Jens Axboe wrote:
>>>> iowait is a bogus metric, but it's helpful in the sense that it allows
>>>> short waits to not enter sleep states that have a higher exit latency
>>>> than would've otherwise have been picked for iowait'ing tasks. However,
>>>> it's harmless in that lots of applications and monitoring assumes that
>>>> iowait is busy time, or otherwise use it as a health metric.
>>>> Particularly for async IO it's entirely nonsensical.
>>>
>>> Let me get this straight, all of this is about working around
>>> cpuidle menu governor insaity?
>>>
>>> Rafael, how far along are we with fully deprecating that thing? Yes it
>>> still exists, but should people really be using it still?
>>>
>>
>> Well there is also the iowait boost handling in schedutil and intel_pstate
>> which, at least in synthetic benchmarks, does have an effect [1].
> 
> Those are cpufreq not cpuidle and at least they don't use nr_iowait. The
> original Changelog mentioned idle states, and I hate on menu for using
> nr_iowait.

I'd say they care about any regression, but I'll let Jens answer that.
The original change also mentions cpufreq and Jens did mention in an
earlier version that he doesn't care, for them it's all just increased
latency ;) 
https://lore.kernel.org/lkml/00d36e83-c9a5-412d-bf49-2e109308d6cd@arm.com/T/#m216536520bc31846aff5875993d22f446a37b297

> 
>> io_uring (the only user of iowait but not iowait_acct) works around both.
>>
>> See commit ("8a796565cec3 io_uring: Use io_schedule* in cqring wait")
>>
>> [1]
>> https://lore.kernel.org/lkml/20240304201625.100619-1-christian.loehle@arm.com/#t
> 
> So while I agree with most of the short-commings listed in that set,
> however that patch is quite terrifying.

Not disagreeing with you on that.

> 
> I would prefer to start with something a *lot* simpler. How about a tick
> driven decay of iops count per task. And that whole step array
> *shudder*.

It's an attempt of solving unnecessary boosting based upon what is there for
us to work with now: iowait wakeups.
There are many workloads with e.g. > 5000 iowait wakeups per second that don't
benefit from boosting at all (and therefore it's a complete energy waste).
I don't see anything obvious how we would attempt to detect non-boost-worthy
scenarios with a tick driven decay count, but please do elaborate.

(If you *really* care about IO throughput, the task wakeup path is hopefully
not critical anyway (i.e. you do everything in your power to have IO pending
during that time) and then we don't need boosting, but just looking
at a tick-length period doesn't let us distinguish those scenarios AFAICS.)

Regards,
Christian

