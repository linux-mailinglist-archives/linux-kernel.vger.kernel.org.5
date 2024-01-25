Return-Path: <linux-kernel+bounces-39298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3A883CE58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA952289713
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C5113A24F;
	Thu, 25 Jan 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rl3c/U5h"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3551F60A;
	Thu, 25 Jan 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217530; cv=none; b=th4nHpoNSvyn/SRIcSVJ4fDnNZhXAgeakHptQMLYzT/O5dwi+j4y3u8baomXV+LfNo0BDtCT7XXsFtiZpC0b+5fKV9JRFsuHxJA8sewGw06yD3LixXlJJ94BJc/+i273QkjH7++C/5cE7kFjjxY0kDT42Sb60gRkpEIqw+t5+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217530; c=relaxed/simple;
	bh=7A6T2n0aDnhcce+dO+8Wvx7QMAxrKD6pFzB7Wi0Hv4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hChGQC277gQ3xW03IUTBlj1eb07z0cwCUDvdMIt7xZMTr3mwgdLStZq/neXesxLsi4Sl1rXASdT6r9+O3FhIioU9fp0Vi4uLKPSpuDbDtBtijQqV3S8swLT8jY/X8UBFqNanfwDbV8aDOXXzBkNdMexFHO8jlNxP+HXsLBb1+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rl3c/U5h; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706217517;
	bh=7A6T2n0aDnhcce+dO+8Wvx7QMAxrKD6pFzB7Wi0Hv4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rl3c/U5hL0eP2xGIYusX+iBHqq6uiQW2fTir+xNDuDk+vfXQ3fH8b1Q9kBVbF5enZ
	 P72LHkwBrSf5suOAFtmHI7IqyLc9MhqqJKpfJhACf7Uv1eayWQt/sBHsj5WdFreaTM
	 tI8jQKqR2nYDBh+y4UujKPR2PwAzrq6QVG431tRogHZY+jFnXsPxemREo35TykekXx
	 ghdfNmrPL2m7shN9tyISxeL2RRjduDUBs2QVmTLj8I2TDfQqSGR2zd4VsLMzIY4QVK
	 73HsmVM0cvAr8fSILRSVZ2q/CooThqu1aO0OzyjxiFJ6BIbEUJHqkt+g3KppyoV9UB
	 1a8Ujgbtg+rag==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TLYbK4pyZzVMl;
	Thu, 25 Jan 2024 16:18:37 -0500 (EST)
Message-ID: <88e9a728-9c9a-42d5-bba4-b9f3fbe61d53@efficios.com>
Date: Thu, 25 Jan 2024 16:18:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Simplify reservation with try_cmpxchg() loop
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Philippe Proulx <pproulx@efficios.com>
References: <20240118181206.4977da2f@gandalf.local.home>
 <504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
 <20240119103754.154dc009@gandalf.local.home>
 <cd3f37cc-31ba-4eb4-8d67-852d05570e7b@efficios.com>
 <20240119164252.54ccb654@gandalf.local.home>
 <5d323a65-8a04-4c73-8702-58869982a269@efficios.com>
 <20240120084713.6eb7aa52@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240120084713.6eb7aa52@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-20 08:47, Steven Rostedt wrote:
> On Fri, 19 Jan 2024 20:49:36 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>>> Let's say we have the following ktime_get() values (monotonic timestamp value) for
>>>> a sequence of events:
>>>>
>>>>                                      Timestamp (Hex)    Encoding in the trace
>>>>
>>>> Packet header timestamp begin     0x12345678         64-bit: 0x12345678
>>>>
>>>> Event 1                           0x12345678         16-bit: 0x5678
>>>>       (When decoded, same value as previous timestamp, no overflow)
>>>> Event 2                           0x12347777         16-bit: 0x7777
>>>>       (When decoded, going from "0x5678" to "0x7777" does not overflow 16-bit)
>>>> Event 3                           0x12350000         16-bit: 0x0000
>>>>       (When decoded, going from "0x7777" to "0x0000" overflow 16-bit exactly once
>>>>        which allows the trace reader to reconstruct timestamp 0x12350000 from the
>>>>        previous timestamp and the 16-bit timestamp encoding.)
>>>> Event 4                           0x12370000         64-bit: 0x12370000
>>>>       (Encoding over 16-bit not possible because going from 0x12350000 to
>>>>        0x12370000 would overflow 16-bit twice, which cannot be detected
>>>>        by a trace reader. Therefore use the full 64-bit timestamp in the
>>>>        "large" event header representation.)
>>>
>>> I think that's basically what I said, but you are just looking at it
>>> differently ;-) Or should I say, you are using bits for optimization.
>>
>> Based on your explanation below, we are really talking about different things
>> here. Let me try to reply to your explanation to try to show where what I am
>> doing completely differs from what you have in mind. This will help explain
>> how I handle 16-bit overflow as well.
>>
>>> The events are based off of the last injected timestamp.
>>
>> Incorrect. There is no "injected timestamp". There is only a concept
>> of the "current timestamp" as we either write to or read from the
>> event stream. I will take the point of view of the trace reader for
>> the rest of the discussion.
>>
>>> The above example,
>>> starts with an timestamp injection into the packet header: 0x12345678, with
>>> the lsb 16bits ignore.
>>
>> Wrong again. The 16 least significant bits are not ignored. The "current timestamp"
>> is really 0x12345678 when the packet header is read.
> 
> In the packet header you have 0x12345678 in the first event you have
> 0x5678 how does that get you the timestamp? If that event had 0x8888,
> when the reader reads this packet, it would take the header 0x12345678
> chop off (ignore) the 5678, and add the 8888, right?

We need to consider not only what happens when the 16 low bits increase, but
also what happens when they end up with a value smaller than the previous
16 low bits.

As a summary from our video meeting discussion:

There are 3 cases we care about here:

packet header timestamp: 0x12345678

followed by either:

A) first event delta from packet header timestamp is 0: 16-bit value 0x5678

B) first event delta from packet header timestamp is <= 0xFFFF:
    B.1) 16-bit value example 0x5699 (no 16-bit overflow from previous value)
    B.2) 16-bit value example 0x2222 (exactly one 16-bit overflow from previous value)

C) first event delta from packet header timestamp is larger than 0xFFFF, which would
    cause the low-order 16 bits to have more than one 16-bit overflow from the previous
    value. The tracer detects this and uses a full 64-bit timestamp instead of the compact
    16 bits.

[...]


> 
>>
>>>
>>> But how do you detect the overflow? That last timestamps to know if
>>> the tsc overflowed or not needs to be saved and compared. I would
>>> assume you have a similar race that I have.
>>
>> Yes, I save a "last timestamp" per buffer, but the race does not
>> matter because of the order in which it is saved wrt local cmpxchg
>> updating the reserved position.
>>
>> The algorithm looks like:
>>
>> do {
>>     - read current reserved position (old pos)
>>     - read time
>>     - compute new reserved position (new pos)
>> } while (cmpxchg(reserved pos, old pos, new pos) != old pos);
>>
>> [A]
>>
>> save_last_tsc()
> 
> So the last_tsc that is saved is from the timestamp read before the
> cmpxchg.

Yes.

> 
>>
>> If interrupted at [A] by another trace producer, it will compare with
>> an older "last tsc" than the tsc of the event physically located just
>> before the nested event. This stale "last tsc" has a value which is
>> necessarily lower than the one we would be saving with the
>> save_last_tsc immediately afterwards, which means in the worse case
>> we end up using a full 64-bit timestamp when in fact we could use a
>> more compact representation. But this race is rare and therefore it
>> does not matter for size.
> 
> That's equivalent to me "injecting" an absolute value for the same race.

Yes.

> 
>>
>> The fact that I only need this last_tsc value for the sake of
>> optimization, and not for computation of a time delta from a previous
>> injected timestamp, makes it possible to handle the race gracefully
>> without requiring anything more than a single last_tsc value per
>> buffer and a single comparison for 16-bit overflow.
> 
> If you have:
> 
>> do {
>>     - read current reserved position (old pos)
>>     - read time
>>     - compute new reserved position (new pos)
>> } while (cmpxchg(reserved pos, old pos, new pos) != old pos);
>>
>> [A]
> 
> And here you have an interrupt that runs for several minutes (yeah bad
> code ;-) And it does the same thing
> 
> do {
>     - read current reserved position (old pos)
>     - read time
>     - compute new reserved position (new pos)
> } while (cmpxchg(reserved pos, old pos, new pos) != old pos);
> 
> save_last_tsc()
> 
> But that last_tsc from before the cmpxchg is much later than the one it
> interrupted.
> 
> 
>>
>> save_last_tsc()
> 
> Ah, so if you put the clock back here, it will just cause the next
> event to inject a full timestamp again because the delta is too big.

Yes.

> 
> This is how you are able to avoid the "before/after" logic I have, as
> the race is automatically detected. The least significant bits of the
> timestamp is ignored for the event delta calculation.

Not quite, as I explained at the beginning of this email. All bits from the
previous timestamp, including its low bits, are useful to know how many
overflows happened since the last tsc.

> And if a race
> happens where the interrupting event saves a later timestamp and comes
> back here, if the interrupted event writes the older timestamp, it just
> causes that delta calculation to overflow again and you inject another
> 64bit timestamp into the buffer.

This part is correct: in the race you describe, we end up with the
possibility of bringing the last_tsc backwards, which can only cause
the tracer to use the full 64-bit timestamp when in fact it could use
the compact representation. But it's rare and should not matter in
practice.

And by the way this algorithm is designed to work with preemption/migration
enabled as well, not just interrupts. So the race can come from a thread
running concurrently on another CPU and it should work as well.

[...]

> 
> Going through a transition of changing it could end up being just as
> complex. I'm not sure the complexity in that transition is better than
> the complexity of the current code, as this code has been there for 15
> years, and I know of at least 2 other projects that depend on this
> format as is.

I agree with you that it's not clear-cut whether introducing this change
would be a benefit at this stage considering the extra complexity of
extending the ABI while keeping backward compatibility.

But it's something we can keep in mind if we ever have to do major ABI
extensions for other reasons.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


