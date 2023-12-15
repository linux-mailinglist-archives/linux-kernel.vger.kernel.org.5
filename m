Return-Path: <linux-kernel+bounces-1524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBCF814FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880CA1C23D00
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FBF30133;
	Fri, 15 Dec 2023 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xNPEa4WB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E03FB1A;
	Fri, 15 Dec 2023 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1702664707;
	bh=8pPkSg7S8q66WlYRj2KvGV3oLWL1XOnV3HYHrzVW4Kk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xNPEa4WB8PBvgLT8QYmtc303UO/pA+OM68GS4Fa8SAbRhp7LHDeemUkWWwEA2kSUw
	 jG9n8DRjlKIH+5gFnxIEqFhKPyR8ikJjhwC/CekPVcRmwAtXQeuvIFvP0bgEafsyPy
	 V9UI6RW3IhzZ13dsEvVKaJNXfRkqck+gIuTWTXe87ooikzVSWd+dCWj+0IDmp8KRsE
	 feXgwP/gCibF12nhej6EFS9oubZVd0VYluL05PbEHsjynzvZlBmRHC4P/QRbMBr6pd
	 Us0BGQZtYKh5MCHQh9nCtgnU1Jd95ZNo8tdteuXajYNR7CPeglR2u6MVnvmk7rYkHg
	 agtrgeDd1sT8Q==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SsHh35CVQzH3B;
	Fri, 15 Dec 2023 13:25:07 -0500 (EST)
Message-ID: <f1a75239-341e-4611-a48d-88e10407dcd4@efficios.com>
Date: Fri, 15 Dec 2023 13:25:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <20231215102633.7a24cb77@rorschach.local.home>
 <21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
 <20231215120417.567d5ea4@rorschach.local.home>
 <fbf8991a-ce83-462c-b87a-b60c6635d223@efficios.com>
 <20231215123458.63f57238@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231215123458.63f57238@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-15 12:34, Steven Rostedt wrote:
> On Fri, 15 Dec 2023 12:24:14 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2023-12-15 12:04, Steven Rostedt wrote:
>>> On Fri, 15 Dec 2023 10:53:39 -0500
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> [...]
>>>>
>>>> So rather than stacking tons of "on/off" switches for filter
>>>> features, how about you let users express the mechanism they
>>>> want to use for filtering with a string instead ? e.g.
>>>>
>>>> filter-method="temp-buffer"
>>>> filter-method="ring-buffer"
>>>> filter-method="input-arguments"
>>>
>>> If I add other ways to filter, it will be a separate file to control
>>> that, but all options are on/off switches. Even if I add other
>>> functionality to the way buffers are created, this will still have the
>>> same functionality to turn the entire thing on or off.
>>
>> I'll be clearer then: I think this is a bad ABI. In your reply, you justify
>> this bad ABI by implementation motivations.
> 
> What's wrong with a way to stop the copying ?

I am not against exposing an ABI that allows userspace to alter the
filter behavior. I disagree on the way you plan to expose the ABI.

Exposing this option as an ABI in this way exposes too much internal
ring buffer implementation details to userspace.

It exposes the following details which IMHO should be hidden or
configurable in a way that allows moving to a whole new mechanism
which will have significantly different characteristics in the
future:

It exposes that:

- filtering uses a copy to a temporary buffer, and
- that this copy is enabled by default.

Once exposed, those design constraints become immutable due to ABI.

> 
> The option is just a way to say "I don't want to do the copy into the
> buffer, I want to go directly into it"

My main concern is how this concept, once exposed to userspace,
becomes not only an internal implementation detail, but a fundamental
part of the design which cannot ever go away without breaking the ABI
or making parts of the ABI irrelevant.

I can make a parallel with the scheduler: this is as if the sched
feature knobs (which are there only for development/debugging purposes)
would all be exposed as userspace ABI. This would seriously
limit the evolution of the scheduler design in the future. I see this
as the same problem at the ring buffer level.

> 
>>
>> I don't care about the implementation, I care about the ABI, and
>> I feel that your reply is not addressing my concern at all.
> 
> Maybe I don't understand your concern.
> 
> It's an on/off switch (like all options are). This is just a way to say
> "I want to indirect copying of the event before filtering or not".

Not all tracefs options are booleans. The "current_tracer" file ABI
exposes a string input/output parameter. I would recommend the same
for the equivalent of a "current_filter" file.

> 
> The "input-argument" part above may never happen. What's different
> between tracefs and LTTng, is that all events are created by the
> subsystem not by me. You don't use the TRACE_EVENT() macro, but you
> need to manually create each event you care about yourself. It's more
> of a burden but you also then have the luxury of hooking to the input
> portion. That is not exposed, and that is by design. As that could
> possibly make all tracepoints an ABI, and you'll have people like
> peterz nacking any new tracepoint in the scheduler. He doesn't allow
> trace events anymore because of that exposure.

I'm not arguing for moving to the input-argument scheme, I just used
this as an hypothetical example to show why we should not expose
internal implementation details to userspace which will prevent future
evolution only for the sake of having debugging knobs.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


