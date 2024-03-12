Return-Path: <linux-kernel+bounces-99689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B4878BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BC21C210C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303DD186A;
	Tue, 12 Mar 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wfdkeZUd"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0A365
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202127; cv=none; b=BgHMFkFHQUXjccEgJkNy09wyUveqy34QRjFoty6sBfZtTPEs22eA4/u6MK26jh0Auvtttf83mK7wGLAttiXAgGe57kWBHg+JqIXJRc4hIsgkzY+OjMWTX1eso0zbtE1uxD8eAdh40sDf2X5DOLXAFF55ZpkuUxk6Eo3GIwSJeJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202127; c=relaxed/simple;
	bh=sPJUPRkLLWUupASgHgwysbM0Te+sEh1Wss66TMfuj80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsXFGStf4R7bMOvuCfDSU7Xi668iM8+9VjQSiLv3aS27u6DoUTEY5zCeJrlSAlyLKjzRwlp5sPPGW+DN61E/XWq8533s6N1gFim004GF5eXj45vu3jdpYuYUD/1sD4591lCYbr+AWHQBW8n7KVPex5wDJ+AWy554H+PllBSw0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=wfdkeZUd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-788598094c4so139978885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710202124; x=1710806924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiGJ1zCalVle/3oiAR/5bP+S2NxnWCPmGdeUzwSDRpg=;
        b=wfdkeZUdirdShH3Gqiy9bGUru0wRGvhf+CffuEupafHcXztNLLFPKNYJ9Kgg3VnwwN
         n2zokoAJiEA5fOZ7IDbxOA2MZc4RZREI4s/r1OBh66wfnFx7YvkXRXCcepD8neVYobKq
         39dZT1athUrhd/o498C4mN4XZ2QQwTnpWHYDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710202124; x=1710806924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiGJ1zCalVle/3oiAR/5bP+S2NxnWCPmGdeUzwSDRpg=;
        b=MlLIldeckfiotrAH6yBK0PwVHT6rbMYzilmBGTyGkqH3m215/lB7v1Va2I56zhslX+
         1/ZvW/SwFV6iSCzIhf/9G0cedem1A6IQnoCDfDnIKIXg0GlWAfCTyGIjVzrSW8waKpXl
         TOLpht+gmXvvCzmDjxv/I+M+k87GW8K6bMDYlV4cMj1ByQxmiuOiIYEd3MDnnp14f6ke
         O9bUqlUxLsdHk3T0xxtTHS7Byqa4z8AQAiwsiyOvh3m9Ce0OGstWbIGEF+/jUsaDax8G
         WF7UnZd7N3dH9Ud69kbglrSCsOku/CY7YS+iQ//fpgeK07ympChdxVbfOhVcppQ3jbF2
         FBrw==
X-Forwarded-Encrypted: i=1; AJvYcCVEL+2OYJ0xI6zxx9TKFZjUdzqaIP8z615Kel0qCElg/rdWsFLlYPIWiy1zGg1B2YgZgxAKvoo5AYli+faoJWX9flVixfo2csH+mkAV
X-Gm-Message-State: AOJu0YypdrgR/fpYurWItzcreTrZh0wgNt3g4tAwd+eRfMmc2X7c2XtC
	HD9Q/7uh05RE4ycrualk4E50sJGuF4nfpcKVmJHQM8momicBE2IUV2QxWg1vcSw=
X-Google-Smtp-Source: AGHT+IGZT8pUuF369a7nLXopiLZPd2brRhJyNdKEebXGd4x5mdtO8++2jbGP037ZIbIsgy5MZDLoFg==
X-Received: by 2002:a05:620a:1d90:b0:788:70fc:3a22 with SMTP id pj16-20020a05620a1d9000b0078870fc3a22mr2082211qkn.10.1710202123830;
        Mon, 11 Mar 2024 17:08:43 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id dp1-20020a05620a2b4100b007881a59042dsm3166339qkb.66.2024.03.11.17.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:08:43 -0700 (PDT)
Message-ID: <5b78a338-cb82-4ac4-8004-77a3eb150604@joelfernandes.org>
Date: Mon, 11 Mar 2024 20:08:39 -0400
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
To: Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
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
 <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
 <87wmq8pop1.ffs@tglx>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <87wmq8pop1.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Thomas,
Thanks for your reply! I replied below.

On 3/11/2024 3:12 PM, Thomas Gleixner wrote:
> On Mon, Mar 11 2024 at 11:25, Joel Fernandes wrote:
>> On 3/11/2024 1:18 AM, Ankur Arora wrote:
>>>> Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
>>>> being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
>>>> preemption in preempt=none. So the "Don't preempt the kernel" behavior has
>>>> changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
>>>> CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on
>>>
>>> I think that's a view from too close to the implementation. Someone
>>> using the kernel is not necessarily concered with whether tasks are
>>> preempted or not. They are concerned with throughput and latency.
>>
>> No, we are not only talking about that (throughput/latency). We are also talking
>> about the issue related to RCU reader-preemption causing OOM (well and that
>> could hurt both throughput and latency as well).
> 
> That happens only when PREEMPT_RCU=y. For PREEMPT_RCU=n the read side
> critical sections still have preemption disabled.

Sorry, let me clarify. And please forgive my noise but it is just a point of
view. CONFIG_PREEMPT_AUTO always preempts sooner or later, even for
preempt=none. A point of view could be, if you are preempting anyway (like
CONFIG_PREEMPT=y), then why bother with disabling CONFIG_PREEMPT_RCU or even
give it as an option. After all, with CONFIG_PREEMPT=y, you cannot do
CONFIG_PREEMPT_RCU=n.  It is just a point of view, while we are still discussing
this patch series ahead of its potential merge.

>> With CONFIG_PREEMPT_AUTO=y, you now preempt in the preempt=none mode. Something
>> very different from the classical CONFIG_PREEMPT_NONE=y.
> 
> In PREEMPT_RCU=y and preempt=none mode this happens only when really
> required, i.e. when the task does not schedule out or returns to user
> space on time, or when a higher scheduling class task gets runnable. For
> the latter the jury is still out whether this should be done or just
> lazily defered like the SCHED_OTHER preemption requests.
> 
> In any case for that to matter this forced preemption would need to
> preempt a RCU read side critical section and then keep the preempted
> task away from the CPU for a long time.
> 
> That's very different from the unconditional kernel preemption model which
> preempt=full provides and only marginally different from the existing
> PREEMPT_NONE model. I know there might be dragons, but I'm not convinced
> yet that this is an actual problem.

Sure it is less aggressive than a full preemption, still a preemption
nonetheless, so its quirky in the regard of whether or not RCU preemption is
provided as an option (as I mentioned as a point-of-view above).

> OTOH, doesn't PREEMPT_RCU=y have mechanism to mitigate that already?

It does. But that sounds more in favor of forcing PREEMPT_RCU=y for AUTO since
such mitigation will help those concerns that AUTO users would need
PREEMPT_RCU=y (?).

>> Essentially this means preemption is now more aggressive from the point of view
>> of a preempt=none user. I was suggesting that, a point of view could be RCU
>> should always support preepmtiblity (don't give PREEEMPT_RCU=n option) because
>> AUTO *does preempt* unlike classic CONFIG_PREEMPT_NONE. Otherwise it is
>> inconsistent -- say with CONFIG_PREEMPT=y (another *preemption mode*) which
>> forces CONFIG_PREEMPT_RCU. However to Paul's point, we need to worry about those
>> users who are concerned with running out of memory due to reader
>> preemption.
> 
> What's wrong with the combination of PREEMPT_AUTO=y and PREEMPT_RCU=n?
> Paul and me agreed long ago that this needs to be supported.

There's nothing wrong with it. Its just a bit quirky (again just a point of
view), that for a configuration that causes preemption (similar to
CONFIG_PREEMPT=y), that PREEMPT_RCU can be disabled. After all, again with
CONFIG_PREEMPT=y, PREEMPT_RCU cannot be currently disabled.

>> In that vain, maybe we should also support CONFIG_PREEMPT_RCU=n for
>> CONFIG_PREEMPT=y as well. There are plenty of popular systems with relatively
>> low memory that need low latency (like some low-end devices / laptops
>> :-)).
> 
> I'm not sure whether that's useful as the goal is to get rid of all the
> CONFIG_PREEMPT_FOO options, no?

I think I may have lost you here, how does forcing or not forcing
CONFIG_PREEMPT_RCU relate to getting rid of CONFIG options? There's no new
CONFIG options added one way or the other.

> I'd rather spend brain cycles on figuring out whether RCU can be flipped
> over between PREEMPT_RCU=n/y at boot or obviously run-time.

Yes I agree with that actually, and I see Paul provided some detailed thoughts
in a reply to you in your quest to get him to write a novel as you put it ;-). I
am Ok with our providing preemptible-RCU as an option with AUTO and it could be
documented well that this is possible. I am fully on board also with the
sentiment of getting rid of the zoo of CONFIG_PREEMPT options!

thanks,

-  Joel

