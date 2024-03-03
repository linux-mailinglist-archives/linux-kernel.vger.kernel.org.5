Return-Path: <linux-kernel+bounces-89882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23786F6D5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B82817F9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740079DA5;
	Sun,  3 Mar 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="InjnLcuv"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6D347C2
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709494350; cv=none; b=I6bd0DjS+Ls5LmWMqUxtTOEcU83PR3L9Gn3AGlqVzsye1e2jbXZc8yqYpquapRRfmAXhh59wBhn2zXlnjVgCGGjVu3SFpJBbguGKrsQv6X0LiA/KJv+sOI+Vztz1BIpb9oy3UjBEQ2t8optqqTeR258zz3+ZM32eJF+AIW0jWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709494350; c=relaxed/simple;
	bh=Axtjq9six5jY51ZdLk/bv6x/fYzaipGyGzikiUpQei4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCeMSHZJNUD24m1oj1M5VkU2Ftv8PI+Jq5D0LOMJvOwsF2AYyifU84Iu1KAG/DTyUGezINmrAkvwoQQvS1qNcuF3jI0qpX+6Xmgz+xuTbB29WXVTzkVzibjOudWQ9bFN6X+qEMWaeQ5eFf9IWx67yPaW5ymyO+/KiqHQkclV3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=InjnLcuv; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690508d70e3so15078806d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709494347; x=1710099147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoC9mHqhY8FAGCCMBbxHu1gMsJpQv3XjVxwr80ctaXA=;
        b=InjnLcuvd7NTVmtCs9AarqtVSe6xg8hp+xZT9YB5BS4dVdLWP5l9Xl81esbnNq0Ivi
         9/DQszKwuvfb54DkINF8t0iQfppTJ+01NqrlSpBHmNfM2qmLdES6hQhGO6OkFuuGQ7q6
         5X70kMvj03eoUVGGCuFgQJkBj1IC+2OTtLtUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709494347; x=1710099147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoC9mHqhY8FAGCCMBbxHu1gMsJpQv3XjVxwr80ctaXA=;
        b=DEjSbYxSKUFv3UgsN80sMgCn8eMsN9/3fIQEa46jFyCZoCBZd/dUJB+2DpVGaf1uNO
         NSAszYYyFBrogVxyooku6ElKGyVxu60qlOraJABsS3qY6RLJhjgBHJ4yShWp2Phr+FUG
         9XoOp5jQDUtD+MbHh/F8q57w5jPP1j3cjclOLHMm6KxF6dy+r2tV6D2v574sl16kCdk9
         k3YpnzMPeV0USieYlB2xSIKLe1ycgP4+A0nArd0vXXI1B8kr49FldtFAe2K8P6EFFew3
         mVOwDJbGN5QsHX1h8bvmAEaLHl2smolQ69ChjIJMR5+J1ctbWREGRfHoufTzzpVXMdpi
         mh7A==
X-Forwarded-Encrypted: i=1; AJvYcCUmqbB7T33dKzjPnc2IFn7nYX5NY/ayuIj9pISe1yY+nBhn7zDUj9Mh/qvckXT3sGvI8d8TFTUbLkEaAlGcQWax11yh8HLin9hcaj/C
X-Gm-Message-State: AOJu0YyeV1kAUxEywYulfOplNRFO0s51hQDt2wmoy5+FZbMzKHYNlQui
	pYWhD+cIIkmuBQVrQy90cjee5VxrCzVdghgyUQYCRnaSaMARQI8zOwjv6Ee/flw=
X-Google-Smtp-Source: AGHT+IEJDOI7zT9eHqzPVLTU09ytDZbgT2QqIFQC7ixVgY2LGg/GaP4f+Zf2A9QjXsCS22fx/QWuBg==
X-Received: by 2002:a05:6214:c8:b0:68f:4519:78ec with SMTP id f8-20020a05621400c800b0068f451978ecmr7059184qvs.60.1709494347598;
        Sun, 03 Mar 2024 11:32:27 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id om13-20020a0562143d8d00b0069049135a69sm4161634qvb.118.2024.03.03.11.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 11:32:26 -0800 (PST)
Message-ID: <198072f4-6d5f-435b-aab3-1351e3265f48@joelfernandes.org>
Date: Sun, 3 Mar 2024 14:32:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/30] Documentation: tracing: add TIF_NEED_RESCHED_LAZY
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
 paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, David.Laight@aculab.com,
 richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-30-ankur.a.arora@oracle.com>
 <20240221164334.6f8c69e8@gandalf.local.home>
 <65e265e3.050a0220.7044b.19ad@mx.google.com> <87v8652uud.fsf@oracle.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <87v8652uud.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/1/2024 10:09 PM, Ankur Arora wrote:
> 
> Joel Fernandes <joel@joelfernandes.org> writes:
> 
>> On Wed, Feb 21, 2024 at 04:43:34PM -0500, Steven Rostedt wrote:
>>> On Mon, 12 Feb 2024 21:55:53 -0800
>>> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>>
>>>> Document various combinations of resched flags.
>>>>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>>>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>>  Documentation/trace/ftrace.rst | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
>>>> index 7e7b8ec17934..7f20c0bae009 100644
>>>> --- a/Documentation/trace/ftrace.rst
>>>> +++ b/Documentation/trace/ftrace.rst
>>>> @@ -1036,8 +1036,12 @@ explains which is which.
>>>>  		be printed here.
>>>>
>>>>    need-resched:
>>>> -	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
>>>> +	- 'B' all three, TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
>>>> +	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED are set,
>>>> +	- 'L' both TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
>>>> +	- 'b' both TIF_NEED_RESCHED and TIF_NEED_RESCHED_LAZY are set,
>>>>  	- 'n' only TIF_NEED_RESCHED is set,
>>>> +	- 'l' only TIF_NEED_RESCHED_LAZY is set,
>>>>  	- 'p' only PREEMPT_NEED_RESCHED is set,
>>
>> One thing I was curious about in current code, under which situation will
>> "only PREEMPT_NEED_RESCHED is set" case happen? All the code paths I see set
>> the PREEMPT_NEED_RESCHED when then TIF has already been set. That kind of
>> makes sense, why enter the scheduler on preempt_enable() unless there was a
>> reason to, and TIF should have recorded that reason.
> 
> True. And, the only place where we clear PREEMPT_NEED_RESCHED is in
> __schedule() after clearing the TIF_NEED_RESCHED* flags.

Thanks for taking a look.

>> So in other words, if 'p' above cannot happen, then it could be removed as a
>> potential need-resched stat. If it can happen, I'd love to learn in which
>> case?
> 
> Yeah, AFAICT the only case we might see it alone is in case of a bug.

Thanks for confirming as well. Steve, are you Ok with a patch to remove 'p'? Or
you probably want to leave it alone in case something changes in the future? I'd
rather it be removed.

>> Also considering all users of set_tsk_need_resched() also call the
>> set_preempt_need_resched() shortly after, should we add a helper to squash
>> the 2 calls and simplify callers?
>>
> Just to explicitly lay out the reason for these being separate interfaces:
> set_tsk_need_resched() can be set from a remote CPU, while
> set_preempt_need_resched() (or its folding version) is only meant to be
> used on the local CPU.

Yes, agreed.

>> There are some "special cases" where only TIF flag need be set (such as setting
>> rescheduling from an interrupt or when rescheduling a remote CPU). For those,
>> they can directly call the set_tsk_need_resched() like they do now.
> 
> The remote case, as you say is always handled in the scheduler. So, maybe
> it is worth having a set_need_resched_local_cpu() which takes care of
> both of these things but more importantly makes clear the limits of this.
> 
> That said, these interfaces have very few users (just RCU, and the s390
> page fault handler) and both of these are fairly sophisticated users, so
> not sure yet another interface in this area is worth adding.
> 

Sounds good, though there are quite a few RCU users and I do remember in the
past, that during a code review I pointed out that both needed to be set. Not
just one. :) I wonder what Paul McKenney thinks about this as well ;-)

thanks,

 - Joel


