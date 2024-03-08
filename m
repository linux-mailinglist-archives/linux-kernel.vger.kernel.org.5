Return-Path: <linux-kernel+bounces-96380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22396875B72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC66282CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829A36D;
	Fri,  8 Mar 2024 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Hyh3bylB"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4172163
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856943; cv=none; b=qf2dQqRENA5a/wJvawnrulHtLINSodO1JKIX8f025EfEYcufJ23kju4osTbaA/pS9soy5c8a54C1zsK/zKc4l37aMloTfaQ8Vx5ab75vRhsmYlyNK04JX9yTjYZjoB4P5eWUm49RgRHaHz3wl62inEihcuV+r/TOD0sTWeJyEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856943; c=relaxed/simple;
	bh=xJPLGsVemfosgv0QRjqqWnuk2pS+67uug1PLq8NcP0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qddIlZpOooLTkyMS+WEtHWcmGXulu7KLi4epy0HVhTcCMrvIhlBsH/gyn1/NQmtQuMIZ1fD/CLCBnqSWlW0K1KEMohlvwnGejmGjUYI6Rde93L1bWhWRt2J3+1EAxN5HI0kRUtN7v4sPmc7+n4yl/q28l94d4Iy5oVv43RjCwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Hyh3bylB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-788455430easo114650885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709856940; x=1710461740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2g3WO5+msuqPwUongZ64JdfNkP/yMHqkJk39jhbAg0w=;
        b=Hyh3bylByHGpyfTQdi50/juVl13sCyrVMl5es/cMjZ7DXzk2QEmUJOGryQEJik1GeK
         YQoeKFOsRn0XMcCsFYTtnW46JyyAAR4dtMzf4QaTMxcGBd3cCoHnxFHHT71srDTBLwpz
         5SOwrjR9U5ixfZ5Swo95LU3SiBH2zrpAvn4uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709856940; x=1710461740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g3WO5+msuqPwUongZ64JdfNkP/yMHqkJk39jhbAg0w=;
        b=ZwU/0ame0IcayJ75rzJmxNKiioorHtSW/QuEOaMlwWmjW2HTfb77p4RiBL33XTOc0y
         sUS9//RjoxS5MfUZ5cqqYSufbYlmVMwn/dCEFoFtiTyRmPg3S3nMPs1mhWJWdcJW7yzr
         HaRPpbLbciH7u0MtYEycB0iQEr2Y9Qlbw8/6MywqY449OqLfibEVCSFEE/SERHwWNEDY
         HKpze2oaNsb5UH/apryLBIE4mUSmMoBwVwZ6QwsFRToNgUzBGxaydInWnQCDdPV4gQ8M
         Qs455xa9S+dGjefv8H2Ailerc7u7YbZfjM/HthoYP1gJfQdPCjtcsmV7wzYmwnBseblP
         YZLA==
X-Forwarded-Encrypted: i=1; AJvYcCWivkVAgwBdkbZcwIfeF+ga/bDkDu4JQNP74I41Jn2l0SD3ltBbHaniHlE1nMqmJTRqrDvE+J2BAV+xXBJhbh4Z3SuRjCrxz66PvxPK
X-Gm-Message-State: AOJu0Yx0EzskWN8cYskCzFVnV06qkyO0r34K8emFzYQtmX+UPDUbA6Or
	EagSqwgddLGxstQkHyDWiegu8mxu+o9WmVM+EpsljeJl4YMBcQKBkWS0QtXrvm0=
X-Google-Smtp-Source: AGHT+IHHdRbs0FV8IXyoGTMlW835kfuS0MJp/ft3ciJVpmmJQxHbZXbr7CWn0W7Vj+FB61Qny0BzUA==
X-Received: by 2002:a05:620a:178b:b0:788:3ec4:bb2a with SMTP id ay11-20020a05620a178b00b007883ec4bb2amr5359066qkb.1.1709856940334;
        Thu, 07 Mar 2024 16:15:40 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id o13-20020ae9f50d000000b00788269e5d5fsm4926037qkg.94.2024.03.07.16.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 16:15:39 -0800 (PST)
Message-ID: <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
Date: Thu, 7 Mar 2024 19:15:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
Content-Language: en-US
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
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/2024 2:01 PM, Paul E. McKenney wrote:
> On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
>> Hi Ankur,
>>
>> On 3/5/2024 3:11 AM, Ankur Arora wrote:
>>>
>>> Joel Fernandes <joel@joelfernandes.org> writes:
>>>
>> [..]
>>>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
>>>> 'voluntary' business because
>>>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
>>>> is not about the old voluntary.
>>>
>>> What do you think about folding the higher scheduling class preemption logic
>>> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
>>> deadline task needs to be done for correctness.
>>>
>>> (That'll get rid of the current preempt=voluntary model, at least until
>>> there's a separate use for it.)
>>
>> Yes I am all in support for that. Its less confusing for the user as well, and
>> scheduling higher priority class at the next tick for preempt=none sounds good
>> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
>> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
>> that is more aggressive, it could be added in the future.
> 
> This would be something that happens only after removing cond_resched()
> might_sleep() functionality from might_sleep(), correct?

Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
he seems to be suggesting preempting instantly for higher scheduling CLASSES
even for preempt=none mode, without having to wait till the next
scheduling-clock interrupt. Not sure if that makes sense to me, I was asking not
to treat "higher class" any differently than "higher priority" for preempt=none.

And if SCHED_DEADLINE has a problem with that, then it already happens so with
CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
more than the treatment given to higher priority within same class. Ankur/Juri?

Re: cond_resched(), I did not follow you Paul, why does removing the proposed
preempt=voluntary mode (i.e. dropping this patch) have to happen only after
cond_resched()/might_sleep() modifications?

thanks,

 - Joel









