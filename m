Return-Path: <linux-kernel+bounces-75117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1385E376
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD54F1F22B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1982D61;
	Wed, 21 Feb 2024 16:35:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B31DA32;
	Wed, 21 Feb 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533349; cv=none; b=fI9lYQ0N5w3YnRcnwYFal/mI7U7GmciTnj0tOrVtSyYI/tp6nzlBMm+NyfOcoVsi445RZbudl9qLOQP8L1kE73A7ynY96HGvNhvN4XV/FBoZe4PdHryMX8CKOQ70RJjFhoYsIyeNPLedGNRoxDSik9XLfhry+FL6H76Yz7qmd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533349; c=relaxed/simple;
	bh=koaexIjVrUQKYyOgAOY02daVNlyqXBIFMOihF6N7O1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mT8Jd/9WTF3jFSaWzOUZjBNP9yZZ0DJpuMsHL2xkRR2mKuIH+Hd8rnUGhhjT2C1+9znN9FnZc+OARQC7d9ylfdDxcXddsxjG0ulriTvUZYdTRU2nC6sAI9u2AmIT3fQhyX1xzrsTjMF4D2uhJCY4egqm8jafUurTq34xNLWb//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B047914BF;
	Wed, 21 Feb 2024 08:36:24 -0800 (PST)
Received: from [192.168.20.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44BD13F73F;
	Wed, 21 Feb 2024 08:35:41 -0800 (PST)
Message-ID: <6a053c64-f226-4b6f-9099-c9eda563cd2f@arm.com>
Date: Wed, 21 Feb 2024 10:35:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] arm64: syscall: Direct PRNG kstack randomization
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will@kernel.org, gustavoars@kernel.org, mark.rutland@arm.com,
 rostedt@goodmis.org, arnd@arndb.de, broonie@kernel.org,
 guohui@uniontech.com, Manoj.Iyer@arm.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, James Yang <james.yang@arm.com>,
 Shiyou Huang <shiyou.huang@arm.com>
References: <20240221020258.1210148-1-jeremy.linton@arm.com>
 <202402202226.A6817927@keescook>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <202402202226.A6817927@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for looking at this!

On 2/21/24 00:33, Kees Cook wrote:
> On Tue, Feb 20, 2024 at 08:02:58PM -0600, Jeremy Linton wrote:
>> The existing arm64 stack randomization uses the kernel rng to acquire
>> 5 bits of address space randomization. This is problematic because it
>> creates non determinism in the syscall path when the rng needs to be
>> generated or reseeded. This shows up as large tail latencies in some
>> benchmarks and directly affects the minimum RT latencies as seen by
>> cyclictest.
> 
> Some questions:
> 
> - for benchmarks, why not disable kstack randomization?

Benchmark isn't the right word here, maybe workload characterization?

Its hard to justify disabling what is perceived as a security feature, 
and enabled by default in downstream distros in a production environment.


> - if the existing pRNG reseeding is a problem here, why isn't it a
>    problem in the many other places it's used?

I don't have an answer for this, maybe it is? Our workloads/perf team 
which analyses end user problems tripped over this again, and with a bit 
of digging noticed it had been seen more than once with differing 
workloads. Its maybe more of a problem here because it affects 
everything making syscalls rather than just the subset of users 
requesting things which rely on the rng? Some of it could be the HW. The 
machine most of these tests have been run on has lots of cores and can 
have fairly long cache line latency.

> - I though the pRNG already did out-of-line reseeding?

Yes in 6.2.

My understanding from some traces is that the latency in recent kernel 
is largely from crng_make_state grabbing that global lock and doing 
crng_fast_key_erasure() under it which is getting worse with more cores 
active in the system. But now i'm a bit worried my own test doesn't 
fully match the workload system although I don't think they have seen 
the crng_reseed() in the syscall path.


> 
>> Other architectures are using timers/cycle counters for this function,
>> which is sketchy from a randomization perspective because it should be
>> possible to estimate this value from knowledge of the syscall return
>> time, and from reading the current value of the timer/counters.
> 
> The expectation is that it would be, at best, unstable.
> 
>> So, a poor rng should be better than the cycle counter if it is hard
>> to extract the stack offsets sufficiently to be able to detect the
>> PRNG's period.
>>
>> So, we can potentially choose a 'better' or larger PRNG, going as far
>> as using one of the CSPRNGs already in the kernel, but the overhead
>> increases appropriately. Further, there are a few options for
>> reseeding, possibly out of the syscall path, but is it even useful in
>> this case?
> 
> I'd love to find a way to avoid an pRNG that could be reconstructed
> given enough samples. (But perhaps this xorshift RNG resists that?)

Agree. I don't think it does.


Thanks again,


> 
> -Kees
> 
>> Reported-by: James Yang <james.yang@arm.com>
>> Reported-by: Shiyou Huang <shiyou.huang@arm.com>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/syscall.c | 55 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
>> index 9a70d9746b66..70143cb8c7be 100644
>> --- a/arch/arm64/kernel/syscall.c
>> +++ b/arch/arm64/kernel/syscall.c
>> @@ -37,6 +37,59 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
>>   	return syscall_fn(regs);
>>   }
>>   
>> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>> +DEFINE_PER_CPU(u32, kstackrng);
>> +static u32 xorshift32(u32 state)
>> +{
>> +	/*
>> +	 * From top of page 4 of Marsaglia, "Xorshift RNGs"
>> +	 * This algorithm is intended to have a period 2^32 -1
>> +	 * And should not be used anywhere else outside of this
>> +	 * code path.
>> +	 */
>> +	state ^= state << 13;
>> +	state ^= state >> 17;
>> +	state ^= state << 5;
>> +	return state;
>> +}
>> +
>> +static u16 kstack_rng(void)
>> +{
>> +	u32 rng = raw_cpu_read(kstackrng);
>> +
>> +	rng = xorshift32(rng);
>> +	raw_cpu_write(kstackrng, rng);
>> +	return rng & 0x1ff;
>> +}
>> +
>> +/* Should we reseed? */
>> +static int kstack_rng_setup(unsigned int cpu)
>> +{
>> +	u32 rng_seed;
>> +
>> +	do {
>> +		rng_seed = get_random_u32();
>> +	} while (!rng_seed);
>> +	raw_cpu_write(kstackrng, rng_seed);
>> +	return 0;
>> +}
>> +
>> +static int kstack_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:kstackrandomize",
>> +				kstack_rng_setup, NULL);
>> +	if (ret < 0)
>> +		pr_err("kstack: failed to register rng callbacks.\n");
>> +	return 0;
>> +}
>> +
>> +arch_initcall(kstack_init);
>> +#else
>> +static u16 kstack_rng(void) { return 0; }
>> +#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>> +
>>   static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>>   			   unsigned int sc_nr,
>>   			   const syscall_fn_t syscall_table[])
>> @@ -66,7 +119,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>>   	 *
>>   	 * The resulting 5 bits of entropy is seen in SP[8:4].
>>   	 */
>> -	choose_random_kstack_offset(get_random_u16() & 0x1FF);
>> +	choose_random_kstack_offset(kstack_rng());
>>   }
>>   
>>   static inline bool has_syscall_work(unsigned long flags)
>> -- 
>> 2.43.0
>>
> 


