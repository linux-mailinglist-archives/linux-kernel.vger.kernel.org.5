Return-Path: <linux-kernel+bounces-99032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264F8782A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4752280DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FA6446AB;
	Mon, 11 Mar 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PqbqpwId"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35741C7A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169277; cv=none; b=KiNqy9qbQhlFNuDTT5E69F0vJaf9ajfYWXNeXbzgrbE7JjA/4jqzGKZEP9L/YJpJR22j0dbzSoI+ukkRn1oY645shippR+FutAhugX+8FGzQWTBTtFk6zbFSuqYZOgzzjU3SYTcljk9loTTggZi5pMIeQlhgOqhPONy7fCccCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169277; c=relaxed/simple;
	bh=7caZxm5oRUPip8DjgnaZJstowj1S3O0C+usn9rSwLRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbdHem2BFKes6TOgCcMxXCX6lkFG8I17dOjxUbcGZo2g79J3pMQon1uICNs16Suwj05a/pAiajhrrBDL2sL4piir7sVhgSdXu5TpTjQnNtKDVHeMnWIMt/NPdsrqAnFv77dWRFkUvFMtqeQDPIgJBKBiuYHsRDBuIiNpe7APZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=PqbqpwId; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-221ca677834so1258655fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710169273; x=1710774073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtQnc20NM3lOSEAeqOet44nWy2uDKmS2BQOyyOWHdiQ=;
        b=PqbqpwIditKItjCUFztHNTD7MR5WZV5cdSP1ZE1qKEx27wLxJE46l9ErFy2L9cZOaX
         gN0UD87daDoHPF0V4zytTLrk3qCk7TX2K6XTwvew48TNdsZCB7+eA+0GRGuKq4NpYAZl
         gu6koDnn0Ag+CLtT+TdHMtWXfCQYDEoDlLLC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169273; x=1710774073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtQnc20NM3lOSEAeqOet44nWy2uDKmS2BQOyyOWHdiQ=;
        b=Wet6skEDczthlxtgGWQWMP9GWD8F8m0LGf7PGNHXdw+wk+kyohyu84o2oo9DyhdeVH
         x/bxBC7WPvdH+9Lrp82jDFW90AgO4kZCvDvaFUNItktQ4TrZDAVAEg2lt/LmXvDnMQ0Q
         kT2Y73CA6luCN5jwWJcC15gR1wlXqEBBv0qKQHZe3KjEJTuJUa6Dz1yiBW1WOFb+I8qs
         PuBcTJb7q6v3o/ipUQp9hraCSZA4lflBuaRoR8wC63MwCclxusEfFSFbvpEJCMwqxbJt
         GxBZmUrqleN3OUnn5dAPQ0dmO/swGc/nXJPJKqBC9Autn4EVyUwqK6SxghVE+7OUZyp/
         swbg==
X-Forwarded-Encrypted: i=1; AJvYcCV5sBUDrpRiY0VQWQZP+il/YaiPvosKIJxrjEvIb/U2rSJ0jeHYXdiKRSJvNizfvvb7Mm4SbpAHR8XhpBp5cjUOflqlaZIMjQzbB8zy
X-Gm-Message-State: AOJu0YztdjeL1XF+Q1qvQNHyZnWpXvznuPbfBLSkwjKz7QwxVbKBiggB
	6jVV+7W3fno/8U9rzOKy2dESOd9YTzGRsLoXMGPpQlqw2d/ZO6VQJjYpPu0a/n0=
X-Google-Smtp-Source: AGHT+IHIAV7NYU1n8YWtuy70v1lVgGgS+NmFecGnQAq823xnfbVno7Q2jaNStfoWtEJ0Ez8V3kYUiQ==
X-Received: by 2002:a05:6870:168a:b0:21e:e476:9170 with SMTP id j10-20020a056870168a00b0021ee4769170mr853729oae.43.1710169272940;
        Mon, 11 Mar 2024 08:01:12 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id v24-20020ae9e318000000b00788357d6759sm2767749qkf.11.2024.03.11.08.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 08:01:11 -0700 (PDT)
Message-ID: <ffc5019a-b593-4dd9-b4e1-4f7755040f23@joelfernandes.org>
Date: Mon, 11 Mar 2024 11:01:09 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
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
 <0965542e-80a7-4837-b14e-903c635aa828@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <0965542e-80a7-4837-b14e-903c635aa828@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/2024 11:56 PM, Paul E. McKenney wrote:
> On Sun, Mar 10, 2024 at 08:48:28PM -0400, Joel Fernandes wrote:
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
> 
> It is part of the discussion of the first version of this patch series,
> if I recall correctly.
> 
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
> 
> Because such systems are built with CONFIG_PREEMPT_DYNAMIC=n.
> 
> You could argue that we should just build with CONFIG_PREEMPT_AUTO=n,
> but the long-term goal of eliminating cond_resched() will make that
> ineffective.

I see what you mean. We/I could also highlight some of the differences in RCU
between DYNAMIC vs AUTO.

> 
>>> Note well that non-preemptible RCU explicitly disables preemption across
>>> all RCU readers.
>>
>> Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
>> being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
>> preemption in preempt=none. So the "Don't preempt the kernel" behavior has
>> changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
>> CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on
>> the way. It is like saying, you want an option for CONFIG_PREEMPT_RCU to be set
>> to =n for CONFIG_PREEMPT=y kernels, sighting users who want a fully-preemptible
>> kernel but are worried about reader preemptions.
> 
> Such users can simply avoid building with either CONFIG_PREEMPT_NONE=y
> or with CONFIG_PREEMPT_VOLUNTARY=y.  They might also experiment with
> CONFIG_RCU_BOOST=y, and also with short timeouts until boosting.
> If that doesn't do what they need, we talk with them and either help
> them configure their kernels, make RCU do what they need, or help work
> out some other way for them to get their jobs done.

Makes sense.

>> That aside, as such, I do agree your point of view, that preemptible readers
>> presents a problem to folks using preempt=none in this series and we could
>> decide to keep CONFIG_PREEMPT_RCU optional for whoever wants it that way. I was
>> just saying that I want CONFIG_PREEMPT_AUTO's preempt=none mode to be somewhat
>> consistent with CONFIG_PREEMPT_DYNAMIC's preempt=none. Because I'm pretty sure a
>> week from now, no one will likely be able to tell the difference ;-). So IMHO
>> either CONFIG_PREEMPT_DYNAMIC should be changed to make CONFIG_PREEMPT_RCU
>> optional, or this series should be altered to force CONFIG_PREEMPT_RCU=y.
>>
>> Let me know if I missed something.
> 
> Why not key off of the value of CONFIG_PREEMPT_DYNAMIC?  That way,
> if both CONFIG_PREEMPT_AUTO=y and CONFIG_PREEMPT_DYNAMIC=y, RCU is
> always preemptible.  Then CONFIG_PREEMPT_DYNAMIC=y enables boot-time
> (and maybe even run-time) switching between preemption flavors, while
> CONFIG_PREEMPT_AUTO instead enables unconditional preemption of any
> region of code that has not explicitly disabled preemption (or irq or
> bh or whatever).

That could be done. But currently, these patches disable DYNAMIC if AUTO is
enabled in the config. I think the reason is the 2 features are incompatible.
i.e. DYNAMIC wants to override the preemption mode at boot time, where as AUTO
wants the scheduler to have a say in it using the need-resched LAZY bit.

> But one way or another, we really do need non-preemptible RCU in
> conjunction with CONFIG_PREEMPT_AUTO=y.

Ok, lets go with that. Thanks,

 - Joel


