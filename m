Return-Path: <linux-kernel+bounces-99131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2F8783C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F25A281B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C954F95;
	Mon, 11 Mar 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hagV4cUv"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847E481A0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170729; cv=none; b=uvcJUI/RF3xFp1EmiP1ZjuOO0ummkm/yrAMxHOxQC6WtureoJaYrnSs6aeZp/XWuqBBpayCg3M1EemeYJuly0JhkwmOJ8URjYlf07Iet4YIHsHk0x/1LJwzpNWm04hLytcsbfeGbMaCDZf3jCM0BgaU+36graQE77MLJ+X24dPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170729; c=relaxed/simple;
	bh=WqAq1R6yO6HvXBTzzPZ0POe3MSgm5MFe0edq/GBp6Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ+RF8h41I7fELC1+9bLoQVNpT+8DEFSLJ1/zxIJgrw/ZLeI/FGaT761nQlRKAzuVWy8L40Itbh5QXr/dPDwLWqZCk1VTBwR109swLIFJb8/YVFKoMwIOhj0egZquEfpxdn/3lnqJsepHcKj9zfmfHjfRg9oH/6u9u14Pnkj0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=hagV4cUv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690c1747c3cso18447996d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710170727; x=1710775527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7goTOKHG5U20FH3hktlSLLPFkEuKqOdbocb84e8A6Ow=;
        b=hagV4cUvrTixHkCRMKRLWAIAi88Z/r+TKcIfycWtf97i6o/qtWXIS9v9aqsfFjQXac
         E7Ip5NtuLPAId1yXhTW25fJV/KsojCDmYvaOlZ/PKkd9OGiY46oDdcs0CPdXH0IWTBiB
         MaI7+zx3u7gbt/FU4u3zSF5LvMYyxfogBV/Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710170727; x=1710775527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7goTOKHG5U20FH3hktlSLLPFkEuKqOdbocb84e8A6Ow=;
        b=lgmX3nSXAB4q3EBii7tLdYqnX3OQOHy7Yj8jahi1mDhnpy0C/EpRKAGlvoxDy3SvX7
         1+riTD/+oLXx9T2PRXFBR1emW98oSPsDA4bdsGePzRemABUkZeFsKkWLpTtBTgkEbOWw
         Gtg0QZ3viJInTaoxRZ5hCwuM0vcUd5w3rbBcy3m7BqySQBcnz5g2lCCFU0xoI+JAv4mV
         e/yTULywiB+Z6JWm29zBK1trH9mo/DF3i7WHKzordNiztZeF9zw172yavKXDO6XYNeA5
         JAVdyPDn92jmvTuNv/an2Gef6TlWfAdQukJBXX0OI94gKsK8Ii10Ael+AzfAN/3JMW7F
         LlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2CSevg0kAlXInhGaDAHLbSR5UG1MpCW9GBIWuGizgK94IfQf7M3ElLN8oNEXoXbWHZnGFQKfHofHsdXLMhGXRvrX33HnMRnN6Wcu6
X-Gm-Message-State: AOJu0YzogdtGMxaODg0Ntpr6YYeWQ06bzmjnRWNl+KJf/eycPpPEtRzK
	cdi+a4OOYqUpyFrORWcBkj2vFFMCus5j8oKgBLax5XWiBLayMhq8xvZECvmQspo=
X-Google-Smtp-Source: AGHT+IF3FQmSHAmEeluwZPY3Ss33P+572AGSt88NnI997HJdkS9hnIbAo35OwjXzW0lv+yWyaziFJA==
X-Received: by 2002:ad4:4eab:0:b0:68f:c83f:a5c8 with SMTP id ed11-20020ad44eab000000b0068fc83fa5c8mr13657818qvb.2.1710170726341;
        Mon, 11 Mar 2024 08:25:26 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id w18-20020a056214013200b0068fc5887c9fsm2747887qvs.97.2024.03.11.08.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 08:25:25 -0700 (PDT)
Message-ID: <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
Date: Mon, 11 Mar 2024 11:25:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 peterz@infradead.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, rcu@vger.kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <87r0ghl51f.fsf@oracle.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <87r0ghl51f.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/2024 1:18 AM, Ankur Arora wrote:
> 
> Joel Fernandes <joel@joelfernandes.org> writes:
> 
>> On 3/10/2024 2:56 PM, Paul E. McKenney wrote:
>>> On Sun, Mar 10, 2024 at 06:03:30AM -0400, Joel Fernandes wrote:
>>>> Hello Ankur and Paul,
>>>>
>>>> On Mon, Feb 12, 2024 at 09:55:39PM -0800, Ankur Arora wrote:
>>>>> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
>>>>> states for read-side critical sections via rcu_all_qs().
>>>>> One reason why this was necessary: lacking preempt-count, the tick
>>>>> handler has no way of knowing whether it is executing in a read-side
>>>>> critical section or not.
>>>>>
>>>>> With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
>>>>> PREEMPT_RCU=n). This means that cond_resched() is a stub which does
>>>>> not provide for quiescent states via rcu_all_qs().
>>>>>
>>>>> So, use the availability of preempt_count() to report quiescent states
>>>>> in rcu_flavor_sched_clock_irq().
>>>>>
>>>>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>>> ---
>>>>>  kernel/rcu/tree_plugin.h | 11 +++++++----
>>>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>>> index 26c79246873a..9b72e9d2b6fe 100644
>>>>> --- a/kernel/rcu/tree_plugin.h
>>>>> +++ b/kernel/rcu/tree_plugin.h
>>>>> @@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>>>>>   */
>>>>>  static void rcu_flavor_sched_clock_irq(int user)
>>>>>  {
>>>>> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
>>>>> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
>>>>> +	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
>>>>> +	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
>>>>
>>>> I was wondering if it makes sense to even support !PREEMPT_RCU under
>>>> CONFIG_PREEMPT_AUTO.
>>>>
>>>> AFAIU, this CONFIG_PREEMPT_AUTO series preempts the kernel on
>>>> the next tick boundary in the worst case, with all preempt modes including
>>>> the preempt=none mode.
>>>>
>>>> Considering this, does it makes sense for RCU to be non-preemptible in
>>>> CONFIG_PREEMPT_AUTO=y? Because if that were the case, and a read-side critical
>>>> section extended beyond the tick, then it prevents the PREEMPT_AUTO preemption
>>>> from happening, because rcu_read_lock() would preempt_disable().
>>>
>>> Yes, it does make sense for RCU to be non-preemptible in kernels
>>> built with CONFIG_PREEMPT_AUTO=y and either CONFIG_PREEMPT_NONE=y or
>>> CONFIG_PREEMPT_VOLUNTARY=y.
>>> As noted in earlier discussions, there are
>>
>> Sorry if I missed a discussion, appreciate a link.
>>
>>> systems that are adequately but not abundantly endowed with memory.
>>> Such systems need non-preemptible RCU to avoid preempted-reader OOMs.
>>
>> Then why don't such systems have a problem with CONFIG_PREEMPT_DYNAMIC=y and
>> preempt=none mode? CONFIG_PREEMPT_DYNAMIC forces CONFIG_PREEMPT_RCU=y. There's
>> no way to set CONFIG_PREEMPT_RCU=n with CONFIG_PREEMPT_DYNAMIC=y and
>> preempt=none boot parameter.  IMHO, if this feature is inconsistent with
>> CONFIG_PREEMPT_DYNAMIC, that makes it super confusing.  In fact, I feel
>> CONFIG_PREEMPT_AUTO should instead just be another "preempt=auto" boot parameter
>> mode added to CONFIG_PREEMPT_DYNAMIC feature, otherwise the proliferation of
>> CONFIG_PREEMPT config options is getting a bit insane. And likely going to be
>> burden to the users configuring the PREEMPT Kconfig option IMHO.
>>
>>> Note well that non-preemptible RCU explicitly disables preemption across
>>> all RCU readers.
>>
>> Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
>> being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
>> preemption in preempt=none. So the "Don't preempt the kernel" behavior has
>> changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
>> CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on
> 
> I think that's a view from too close to the implementation. Someone
> using the kernel is not necessarily concered with whether tasks are
> preempted or not. They are concerned with throughput and latency.

No, we are not only talking about that (throughput/latency). We are also talking
about the issue related to RCU reader-preemption causing OOM (well and that
could hurt both throughput and latency as well).

With CONFIG_PREEMPT_AUTO=y, you now preempt in the preempt=none mode. Something
very different from the classical CONFIG_PREEMPT_NONE=y.

Essentially this means preemption is now more aggressive from the point of view
of a preempt=none user. I was suggesting that, a point of view could be RCU
should always support preepmtiblity (don't give PREEEMPT_RCU=n option) because
AUTO *does preempt* unlike classic CONFIG_PREEMPT_NONE. Otherwise it is
inconsistent -- say with CONFIG_PREEMPT=y (another *preemption mode*) which
forces CONFIG_PREEMPT_RCU. However to Paul's point, we need to worry about those
users who are concerned with running out of memory due to reader preemption.

In that vain, maybe we should also support CONFIG_PREEMPT_RCU=n for
CONFIG_PREEMPT=y as well. There are plenty of popular systems with relatively
low memory that need low latency (like some low-end devices / laptops :-)).

> Framed thus:
> 
> preempt=none: tasks typically run to completion, might result in high latency
> preempt=full: preempt at the earliest opportunity, low latency
> preempt=voluntary: somewhere between these two
> 
> In that case you could argue that CONFIG_PREEMPT_NONE,
> (CONFIG_PREEMPT_DYNAMIC, preempt=none) and (CONFIG_PREEMPT_AUTO,
> preempt=none) have broadly similar behaviour.

Yes, in that respect I agree.

> 
>> the way. It is like saying, you want an option for CONFIG_PREEMPT_RCU to be set
>> to =n for CONFIG_PREEMPT=y kernels, sighting users who want a fully-preemptible
>> kernel but are worried about reader preemptions.
>>
>> That aside, as such, I do agree your point of view, that preemptible readers
>> presents a problem to folks using preempt=none in this series and we could
>> decide to keep CONFIG_PREEMPT_RCU optional for whoever wants it that way. I was
>> just saying that I want CONFIG_PREEMPT_AUTO's preempt=none mode to be somewhat
>> consistent with CONFIG_PREEMPT_DYNAMIC's preempt=none. Because I'm pretty sure a
> 
> PREEMPT_DYNAMIC and PREEMPT_AUTO are trying to do different tasks.
> 
> PREEMPT_DYNAMIC: allow dynamic switching between the original
> PREEMPT_NONE, PREEMPT_VOLUNTARY, PREEEMPT models.
> 
> PREEMPT_AUTO: remove the need for explicit preemption points, by
>  - bringing the scheduling model under complete control of the
>    scheduler
>  - always having unconditional preemption (and using it to varying
>    degrees of strictness based on the preemption model in effect.)
> 
> So, even though PREEMPT_AUTO does use PREEMPT_NONE, PREEMPT_VOLUNTARY,
> PREEMPT options, those are just meant to loosely identify with Linux's
> preemption models, and the intent is not to be identical to it -- they
> can't be identical because the underlying implementation is completely
> different.
> 
> The eventual hope is that we can get rid of explicit preemption points.

Sounds good.

>> week from now, no one will likely be able to tell the difference ;-). So IMHO
>> either CONFIG_PREEMPT_DYNAMIC should be changed to make CONFIG_PREEMPT_RCU
>> optional, or this series should be altered to force CONFIG_PREEMPT_RCU=y.
>>
> I think that's a patch for CONFIG_PREEMPT_DYNAMIC :).

Yes, I'm curious to explore it more. Specifically, with DYNAMIC=y, I'll explore
during my free time about how different does preempt=none behave from an RCU PoV
(say versus CONFIG_PREEMPT_NONE). I will also continue reviewing these patches.

Thanks!

 - Joel


