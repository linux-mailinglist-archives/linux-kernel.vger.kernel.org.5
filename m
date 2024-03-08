Return-Path: <linux-kernel+bounces-97329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F18768D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005BC28378A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C71C2BC;
	Fri,  8 Mar 2024 16:49:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FFA12B8B;
	Fri,  8 Mar 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916598; cv=none; b=IdZGeojYHgaWlPt/cf6d2/YrLunKtXocNnA9IbVdXkjzlI/BTdTzzbM5MlasI1ls0SOHAtGLEcTvV2PmzmkHIiUkL8S7SFfrgIYjR+o+mClyRg4MGwG+c80doz0uE+kS8B75MIfyY4WuOy/mRmow2DvmFhgkmgJEyqKrNjhAQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916598; c=relaxed/simple;
	bh=/plhOfjukKj5FUm7CFldizCqePmY3uzfOWtq4S76Cj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZorFgKX3EtZYK7JPyc0gUFsOqqLTJlhn1UbYlJ56bJ4F+FOfmuOZXAgvaczgiLaOACI2lF07SGeyz++sb8qRnSfSvrUN0wTs3xXfrEgqr+WF3FLY0oCC76nNiR3B39D8fF887IqFdRs/JCUFFud+88huLGpn2BLkJmGeZYeghME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B28DBC15;
	Fri,  8 Mar 2024 08:50:32 -0800 (PST)
Received: from [192.168.20.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DF763F73F;
	Fri,  8 Mar 2024 08:49:51 -0800 (PST)
Message-ID: <db7dfa2d-c7c6-4b10-981a-a7ecc87c8541@arm.com>
Date: Fri, 8 Mar 2024 10:49:46 -0600
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
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/7/24 05:10, Arnd Bergmann wrote:
> On Wed, Mar 6, 2024, at 22:54, Jeremy Linton wrote:
>> On 3/6/24 14:46, Arnd Bergmann wrote:
>>> On Wed, Mar 6, 2024, at 00:33, Kees Cook wrote:
>>>> On Tue, Mar 05, 2024 at 04:18:24PM -0600, Jeremy Linton wrote:
>>>>> The existing arm64 stack randomization uses the kernel rng to acquire
>>>>> 5 bits of address space randomization. This is problematic because it
>>>>> creates non determinism in the syscall path when the rng needs to be
>>>>> generated or reseeded. This shows up as large tail latencies in some
>>>>> benchmarks and directly affects the minimum RT latencies as seen by
>>>>> cyclictest.
>>>>>
>>>>> Other architectures are using timers/cycle counters for this function,
>>>>> which is sketchy from a randomization perspective because it should be
>>>>> possible to estimate this value from knowledge of the syscall return
>>>>> time, and from reading the current value of the timer/counters.
>>>
>>> As I commented on the previous version, I don't want to see
>>> a change that only addresses one architecture like this. If you
>>> are convinced that using a cycle counter is a mistake, then we
>>> should do the same thing on the other architectures as well
>>> that currently use a cycle counter.
>>
>> I personally tend to agree as long as we aren't creating a similar set
>> of problems for those architectures as we are seeing on arm. Currently
>> the kstack rng on/off choice is basically zero overhead for them.
> 
> I think we have two separate problems to solve here: how
> strong a kernel stack randomization should be on a given system,
> and who gets to make the decision.
> 
> For the strength, we have at least four options:
> 
> - strong rng, most expensive
> - your new prng, less strong but somewhat cheaper and/or more
>    predictable overhead
> - cycle counter, cheap but probably even less strong,
>    needs architecture code.
> - no rng, no overhead and no protection.
> 
> On architectures that have a cheap hardware rng instruction, you
> can count that one as well.
> 
> For picking between the options, we have
> 
> - architecture maintainer
> - defconfig (CONFIG_RANDOMIZE_KSTACK_OFFSET)
> - boot time (randomize_kstack_offset=on)
> 
> For both of these lists, I would like to see as few options
> as possible, and in particular I think the architecture
> maintainer should not make that decision for the users.
> 
> If we want to improve this, I would start by changing
> the binary CONFIG_RANDOMIZE_KSTACK_OFFSET option into
> a three-way choice between cycle counter (where available),
> strong rng and off, possibly adding the cycle counter
> option to the two architectures that currently don't use
> it, while moving the strong rng into common code.
> 
> After that, we can debate adding a fourth option, or
> replacing one of the existing two that is too slow or
> not random enough.
> 
>>> Won't that defeat the purpose of the patch that was intended
>>> to make the syscall latency more predictable? At least the
>>> simpler approaches of reseeding from the kstack_rng()
>>> function itself would have this problem, deferring it to
>>> another context comes with a separate set of problems.
>>
>> And that describes why I've not come up with an inline reseeding
>> solution. Which of course isn't a problem on !arm if one just pushes a
>> few bits of a cycle counter into the rnd_state every few dozen syscalls,
>> or whatever. Mark R, mentioned offline the idea of just picking a few
>> bits off CNTVCT as a seed, but its so slow it basically has to be used
>> to fuzz a bit or two of rnd_state on some fairly long interval. Long
>> enough that if someone has a solution for extracting rnd_state it might
>> not add any additional security. Or that is my take, since i'm not a big
>> fan of any independent counter/clock based RNG seeding (AFAIK, entropy
>> from clocks requires multiple _independent_ sources).
> 
> I'm not sure I understand the logic. Do you mean that accessing
> CNTVCT itself is slow, or that reseeding based on CNTVCT is slow
> because of the overhead of reseeding?

Slow, as in, its running at a much lower frequency than a cycle counter.


> 
> On powerpc/s390/x86, the low bits of the respective cycle counter
> is simply used without any kind of bit shuffling, and we already
> rely on the cycle counter to be fast to access since it's used
> for timekeeping anywhere.
> 
> There is not even any attempt to use the most random bits of
> the cycle counter, as both the high 22 to 24 bits get masked
> out (to keep the wasted stack space small) and the low 3 or 4
> bits get ignored because of stack alignment. If there was
> any desire to make it more random, a trivial improvement
> would be:
> 
> +++ b/include/linux/randomize_kstack.h
> @@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
>          if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
>                                  &randomize_kstack_offset)) {            \
>                  u32 offset = raw_cpu_read(kstack_offset);               \
> -               offset ^= (rand);                                       \
> +               offset = ror32(offset, 5) & (rand);                     \
>                  raw_cpu_write(kstack_offset, offset);                   \
>          }                                                               \
>   } while (0)
> 
> My impression is that is is already bordering on becoming
> a "bespoke rng" implementation that Jason was objecting to,
> so the current version is intentionally left weak in order
> to not even give the appearance of being a security relevant
> feature.
> 
>> This is a bit out of my wheelhouse, so I defer to anyone with a better
>> feel or some actual data.
>>
>> The best plan I have at the moment is just some deferred work to call
>> kstack_rng_setup on some call or time based interval, which AFAIK isn't
>> ideal for RT workloads which expect ~100% CPU isolation. Plus, that
>> solution assumes we have some handle on how fast an attacker can extract
>> kstackrng sufficiently to make predictions.
> 
> I think you fundamentally can't have both. If you rely on the
> reseeding to happen for a particular number of syscalls, you
> eventually end up blocking on it, regardless of the context
> it runs in. Deferring it to another process means blocking
> for longer, and deferring it to a low-priority task would mean
> that real-time tasks get less randomness.
> 
>         Arnd


