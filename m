Return-Path: <linux-kernel+bounces-31556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF7833005
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C051C1F21E37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9628257314;
	Fri, 19 Jan 2024 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="m9VX2ryS"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45C1E498;
	Fri, 19 Jan 2024 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697787; cv=none; b=nE8aJffjsEH06TinOYLQO1rLzG+ldDx8MGOvH+iNgh0WSGbgh6SW9TXGb82NHYIaoxPsbfr0JTHa92vyIwh2Pn8CxqciuFclRi7t1WENtBgJXolP0HpeuQkTuki6MuSvYa3796u/6TJXk8wYU20vTPbbBQyRYZp7Rpt6U0Ljil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697787; c=relaxed/simple;
	bh=muiy5JFaVef6TBO8rX0XRJL32UzwlIuJnjxRIfVC5hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2crBIjBZCBqDaXr3nUcjrZeqb/9Mj8YiuiGh8uMWwvR8a91s+uHJbKatqrLtQFJkmujNmpM9Hc07gtIyJJpvh9u6sT8FFp170m7JBlHqosnE6ixLkzavGynn5yA402xPXWHG2LNxRjTUoXQZFQ4q5T3X+ePFelEmmS7cozD9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=m9VX2ryS; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1705697782;
	bh=muiy5JFaVef6TBO8rX0XRJL32UzwlIuJnjxRIfVC5hk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m9VX2rySbl+NQBI6UlFPdkUL3FKfio8RPM9AZxstIGBscu0QhC0qJoaRxKeWswLE+
	 un+SD/tOx44WKA4TflB4DqEFqhSdXnrR6flMmadWRkDmJvJ1Y/cDXgMxJp9QzPojI0
	 TskuF9OlFhoW+GfiIjtbae+s6s4BBIGXpFYfvB2y1/LfkcBfZ+DhJlhHUzhNDziMJG
	 60hoOKSsaA+m0uw5TLpI1IhWAIEEUwytxj2QBxchNAFMmHujUXlq22QeGTT90EcBSi
	 JHMwSC8EtziUmgfodpgcS/gIz6RftkWRV5MmsOzIFDgW/jLXW39Kz5KfAU7lUaa7zF
	 tWGVNQmt93gZw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TGsNQ1mjCzTZP;
	Fri, 19 Jan 2024 15:56:22 -0500 (EST)
Message-ID: <cd3f37cc-31ba-4eb4-8d67-852d05570e7b@efficios.com>
Date: Fri, 19 Jan 2024 15:56:21 -0500
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240119103754.154dc009@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-01-19 10:37, Steven Rostedt wrote:
> On Fri, 19 Jan 2024 09:40:27 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-01-18 18:12, Steven Rostedt wrote:
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>

[...]

>>> Although, it does not get rid of the double time stamps (before_stamp and
>>> write_stamp), using cmpxchg() does get rid of the more complex case when
>>> an interrupting event occurs between getting the timestamps and reserving
>>> the data, as when that happens, it just tries again instead of dealing
>>> with it.
>>
>> I understand that the reason why you need the before/after stamps and their
>> associated complexity is because the Ftrace ring buffer ABI encodes event
>> timestamps as delta from the previous event within the buffer as a mean of
>> compressing the timestamp fields. If the delta cannot be represented in a
>> given number of bits, then it inserts a 64-bit timestamp (not sure if that
>> one is absolute or a delta from previous event).
> 
> There's both. An extended timestamp, which is added when the delta is too
> big, and that too is just a delta from the previous event. And there is the
> absolute timestamp as well. I could always just use the absolute one. That
> event came much later.

OK

> 
>>
>> This timestamp encoding as delta between events introduce a strong
>> inter-dependency between consecutive (nested) events, and is the reason
>> why you are stuck with all this timestamp before/after complexity.
>>
>> The Common Trace Format specifies (and LTTng implements) a different way
>> to achieve the same ring buffer space-savings achieved with timestamp deltas
>> while keeping the timestamps semantically absolute from a given reference,
>> hence without all the before/after timestamp complexity. You can see the
>> clock value decoding procedure in the CTF2 SPEC RC9 [1] document. The basic
> 
> That points to this:
> 
> ---------------------8<-------------------------
> 6.3. Clock value update procedure
> To update DEF_CLK_VAL from an unsigned integer field F having the unsigned integer value V and the class C:
> 
> Let L be an unsigned integer initialized to, depending on the type property of C:
> 
> "fixed-length-unsigned-integer"
> The value of the length property of C.
> 
> "variable-length-unsigned-integer"
> S ×7, where S is the number of bytes which F occupies with the data stream.
> 
> Let MASK be an unsigned integer initialized to 2L − 1.
> 
> Let H be an unsigned integer initialized to DEF_CLK_VAL & ~MASK, where “&” is the bitwise AND operator and “~” is the bitwise NOT operator.
> 
> Let CUR be an unsigned integer initialized to DEF_CLK_VAL & MASK, where “&” is the bitwise AND operator.
> 
> Set DEF_CLK_VAL to:
> 
> If V ≥ CUR
> H + V
> 
> Else
> H + MASK + 1 + V
> --------------------->8-------------------------
> 
> There's a lot of missing context there, so I don't see how it relates.

This explains how the "current time" is reconstructed by a trace reader
when loading an event header timestamp field. But for the sake of this
discussion we can focus on the less formal explanation of how the tracer
generates this timestamp encoding provided below.

>> idea on the producer side is to record the low-order bits of the current
>> timestamp in the event header (truncating the higher order bits), and
>> fall back on a full 64-bit value if the number of low-order bits overflows
>> from the previous timestamp is more than 1, or if it is impossible to figure
>> out precisely the timestamp of the previous event due to a race. This achieves
>> the same space savings as delta timestamp encoding without introducing the
>> strong event inter-dependency.
> 
> So when an overflow happens, you just insert a timestamp, and then events
> after that is based on that?

No. Let's use an example to show how it works.

For reference, LTTng uses 5-bit for event ID and 27-bit for timestamps
in the compact event header representation. But for the sake of making this
discussion easier, let's assume a tracer would use 16-bit for timestamps in the
compact representation.

Let's say we have the following ktime_get() values (monotonic timestamp value) for
a sequence of events:

                                   Timestamp (Hex)    Encoding in the trace

Packet header timestamp begin     0x12345678         64-bit: 0x12345678

Event 1                           0x12345678         16-bit: 0x5678
    (When decoded, same value as previous timestamp, no overflow)
Event 2                           0x12347777         16-bit: 0x7777
    (When decoded, going from "0x5678" to "0x7777" does not overflow 16-bit)
Event 3                           0x12350000         16-bit: 0x0000
    (When decoded, going from "0x7777" to "0x0000" overflow 16-bit exactly once
     which allows the trace reader to reconstruct timestamp 0x12350000 from the
     previous timestamp and the 16-bit timestamp encoding.)
Event 4                           0x12370000         64-bit: 0x12370000
    (Encoding over 16-bit not possible because going from 0x12350000 to
     0x12370000 would overflow 16-bit twice, which cannot be detected
     by a trace reader. Therefore use the full 64-bit timestamp in the
     "large" event header representation.)

> 
>>
>> The fact that Ftrace exposes this ring buffer binary layout as a user-space
>> ABI makes it tricky to move to the Common Trace Format timestamp encoding.
>> There are clearly huge simplifications that could be made by moving to this
>> scheme though. Is there any way to introduce a different timestamp encoding
>> scheme as an extension to the Ftrace ring buffer ABI ? This would allow us to
>> introduce this simpler scheme and gradually phase out the more complex delta
>> encoding when no users are left.
> 
> I'm not sure if there's a path forward. The infrastructure can easily swap
> in and out a new implementation. That is, there's not much dependency on
> the way the ring buffer works outside the ring buffer itself.
> 
> If we were to change the layout, it would likely require a new interface
> file to read. The trace_pipe_raw is the only file that exposes the current
> ring buffer. We could create a trace_out_raw or some other named file that
> has a completely different API and it wouldn't break any existing API.

Or introduce "trace_pipe_raw2" or some kind of versioned file names as new
ABIs.

> Although, if we want to change the "default" way, it may need some other
> knobs or something, which wouldn't be hard.

The delta-timestamp-encoding would have to stay there for a while as long
as users have not switched over to trace_pipe_raw2. Then when it's really
gone, the trace_pipe_raw could either go away or return an error when
opened.

> Now I have to ask, what's the motivation for this. The code isn't that
> complex anymore. Yes it still has the before/after timestamps, but the
> most complexity in that code was due to what happens in the race of
> updating the reserved data. But that's no longer the case with the
> cmpxchg(). If you look at this patch, that entire else statement was
> deleted. And that deleted code was what made me sick to my stomach ;-)
> Good riddance!

The motivation for this would be to further simplify the implementation
of __rb_reserve_next(), rb_add_timestamp(), and rb_try_to_discard(), and
remove a few useless loads, stores, and conditional branches on the fast-path
of __rb_reserve_next(). This would turn the before/after timestamp
stores/loads/comparisons into a simple "last timestamp" field and a comparison
of the current timestamp against the "last timestamp" value to figure out
whether the compact representation can be used.

I don't know whether it's worth the trouble or not, it's really up to you. :)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


