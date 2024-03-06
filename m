Return-Path: <linux-kernel+bounces-94619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED3874236
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69271F254F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9504F1B81C;
	Wed,  6 Mar 2024 21:55:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162817543;
	Wed,  6 Mar 2024 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762107; cv=none; b=Bqqqt1yLgBS8sTP3LXu9XzShXFnYTYNM7uWEaYbL5nnwyddOe49aj4RLHMsmATIlGrDcNZgyWOBLsY/lrbC4LxsT382X5fUwhiNeGvYDLp2idFzb21p/2nD2SeAe7mi1rxyzR6cSCF70ztxKlatTF2PzKnChe0WL5naCTN0P7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762107; c=relaxed/simple;
	bh=bvR21HUFQSjXL1lKOF4+wYG7LzV7EvRmk0SjKWA1rI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZ2mgK/IHFNVAC/8x+WkH3Fl69xmLZPe7buvG1CvhgzSw/iTReyEVweQ7jNlxo6gex4AOgIuaa2Uz3NMEqN64VMFjrJ/V6hZQo7tpCvqGTzIAX5+RLpFL6RpPI/0j4BQbs/593BYoYcMfykOuNd/NWvDqde1xKuY63FXPdqP8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B09A01FB;
	Wed,  6 Mar 2024 13:55:40 -0800 (PST)
Received: from [192.168.20.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020883F73F;
	Wed,  6 Mar 2024 13:54:58 -0800 (PST)
Message-ID: <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
Date: Wed, 6 Mar 2024 15:54:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Guo Hui <guohui@uniontech.com>,
 Manoj.Iyer@arm.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, James Yang <james.yang@arm.com>,
 Shiyou Huang <shiyou.huang@arm.com>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/6/24 14:46, Arnd Bergmann wrote:
> On Wed, Mar 6, 2024, at 00:33, Kees Cook wrote:
>> On Tue, Mar 05, 2024 at 04:18:24PM -0600, Jeremy Linton wrote:
>>> The existing arm64 stack randomization uses the kernel rng to acquire
>>> 5 bits of address space randomization. This is problematic because it
>>> creates non determinism in the syscall path when the rng needs to be
>>> generated or reseeded. This shows up as large tail latencies in some
>>> benchmarks and directly affects the minimum RT latencies as seen by
>>> cyclictest.
>>>
>>> Other architectures are using timers/cycle counters for this function,
>>> which is sketchy from a randomization perspective because it should be
>>> possible to estimate this value from knowledge of the syscall return
>>> time, and from reading the current value of the timer/counters.
> 
> As I commented on the previous version, I don't want to see
> a change that only addresses one architecture like this. If you
> are convinced that using a cycle counter is a mistake, then we
> should do the same thing on the other architectures as well
> that currently use a cycle counter.

I personally tend to agree as long as we aren't creating a similar set 
of problems for those architectures as we are seeing on arm. Currently 
the kstack rng on/off choice is basically zero overhead for them.

> 
>>> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>>> +DEFINE_PER_CPU(struct rnd_state, kstackrng);
>>> +
>>> +static u16 kstack_rng(void)
>>> +{
>>> +	u32 rng = prandom_u32_state(this_cpu_ptr(&kstackrng));
>>> +
>>> +	return rng & 0x1ff;
>>> +}
>>> +
>>> +/* Should we reseed? */
>>> +static int kstack_rng_setup(unsigned int cpu)
>>> +{
>>> +	u32 rng_seed;
>>> +
>>> +	/* zero should be avoided as a seed */
>>> +	do {
>>> +		rng_seed = get_random_u32();
>>> +	} while (!rng_seed);
>>> +	prandom_seed_state(this_cpu_ptr(&kstackrng), rng_seed);
>>> +	return 0;
>>> +}
>>> +
>>> +static int kstack_init(void)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:kstackrandomize",
>>> +				kstack_rng_setup, NULL);
>>
>> This will run initial seeding, but don't we need to reseed this with
>> some kind of frequency?
> 
> Won't that defeat the purpose of the patch that was intended
> to make the syscall latency more predictable? At least the
> simpler approaches of reseeding from the kstack_rng()
> function itself would have this problem, deferring it to
> another context comes with a separate set of problems.

And that describes why I've not come up with an inline reseeding 
solution. Which of course isn't a problem on !arm if one just pushes a 
few bits of a cycle counter into the rnd_state every few dozen syscalls, 
or whatever. Mark R, mentioned offline the idea of just picking a few 
bits off CNTVCT as a seed, but its so slow it basically has to be used 
to fuzz a bit or two of rnd_state on some fairly long interval. Long 
enough that if someone has a solution for extracting rnd_state it might 
not add any additional security. Or that is my take, since i'm not a big 
fan of any independent counter/clock based RNG seeding (AFAIK, entropy 
from clocks requires multiple _independent_ sources).

This is a bit out of my wheelhouse, so I defer to anyone with a better 
feel or some actual data.

The best plan I have at the moment is just some deferred work to call 
kstack_rng_setup on some call or time based interval, which AFAIK isn't 
ideal for RT workloads which expect ~100% CPU isolation. Plus, that 
solution assumes we have some handle on how fast an attacker can extract 
kstackrng sufficiently to make predictions.

Again, thanks to everyone for looking at this,
Jeremy


