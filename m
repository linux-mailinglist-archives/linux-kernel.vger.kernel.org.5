Return-Path: <linux-kernel+bounces-143205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F048A35C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE26D1F24B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8714EC60;
	Fri, 12 Apr 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hUOdDtcE"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379223778;
	Fri, 12 Apr 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946785; cv=none; b=PFEOGl+cv5kbNOXUGCNm46jpSDRto0jqGPCAeBtWnxV+xovVw1MK4Rqxq0mpG9yNr71TM2+R6rCQ5Wnsuus1NKgsv2cX3JjzfTC1e28Rp5c02gK/rcuOhTKSg3vzmHx+7OnnS9XZFLjqqLxRyfUYR9xEAas1ipehheN1qDFIuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946785; c=relaxed/simple;
	bh=6PZjSZxH3ze16qNj6YeC71CtMpEKbPJQmh6JdIimg3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEttxEDfWcnELRHXoODZcYdBmdo95a4pAUP+AggYufgb1eXJAQOpUK/6j0ikhHRTA0WwRBGg06CblIuZ97fNeHPT76D3qSHiDfbh+EG/xnnzgLYcfEcYXn53SkQIh136FMuu6osVI7Z9fvj5uHolw5yPbOCtOwJ1HGQpZtleFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hUOdDtcE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1712946776;
	bh=6PZjSZxH3ze16qNj6YeC71CtMpEKbPJQmh6JdIimg3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hUOdDtcErpwhHj+e9zu1sVwafgvSpe2+j477adeZZ7ojCHUe2DtHfqxMS+m/mfia4
	 /hPW6eJeIU397pCd2BIyi8uK9ttdUobUxxUj4S4Wsd8hlDRZlZrkCm99QumWWQ+EX3
	 vAeAvl0q2roNcFXo6T6y4p6Bnl0MCPBAIZnHC2s09eyFPIyJxJqRyMuaq81dIlf5gL
	 QNMcKxVFOyGvNAZTfg3/GUldp3rmaUM+gg3Fza/UWaXIZmQIqkt2Vjpbv13YWLmFVB
	 KaYzz+VjAmdoM7VQSTwuyDi0a0l8gKDIRShoceKZFnJDtBsO0h0DW8HvDVquSu46wk
	 +BvX927LIOLCg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VGQD75m7JzvNN;
	Fri, 12 Apr 2024 14:32:55 -0400 (EDT)
Message-ID: <8568ab4f-5015-4aef-b011-190e4eb519a5@efficios.com>
Date: Fri, 12 Apr 2024 14:32:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] perf: Correlating user process data to samples
To: Beau Belgrave <beaub@linux.microsoft.com>, Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, primiano@google.com, aahringo@redhat.com,
 dcook@linux.microsoft.com
References: <20240412001732.475-1-beaub@linux.microsoft.com>
 <CAP-5=fVVQ5RGqEQo596to_3BYZ6vNFC_DR1nnunH_-Bb6bdpVg@mail.gmail.com>
 <20240412162848.GA467-beaub@linux.microsoft.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240412162848.GA467-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-04-12 12:28, Beau Belgrave wrote:
> On Thu, Apr 11, 2024 at 09:52:22PM -0700, Ian Rogers wrote:
>> On Thu, Apr 11, 2024 at 5:17 PM Beau Belgrave <beaub@linux.microsoft.com> wrote:
>>>
>>> In the Open Telemetry profiling SIG [1], we are trying to find a way to
>>> grab a tracing association quickly on a per-sample basis. The team at
>>> Elastic has a bespoke way to do this [2], however, I'd like to see a
>>> more general way to achieve this. The folks I've been talking with seem
>>> open to the idea of just having a TLS value for this we could capture
>>
>> Presumably TLS == Thread Local Storage.
>>
> 
> Yes, the initial idea is to use thread local storage (TLS). It seems to
> be the fastest option to save a per-thread value that changes at a fast
> rate.
> 
>>> upon each sample. We could then just state, Open Telemetry SDKs should
>>> have a TLS value for span correlation. However, we need a way to sample
>>> the TLS or other value(s) when a sampling event is generated. This is
>>> supported today on Windows via EventActivityIdControl() [3]. Since
>>> Open Telemetry works on both Windows and Linux, ideally we can do
>>> something as efficient for Linux based workloads.
>>>
>>> This series is to explore how it would be best possible to collect
>>> supporting data from a user process when a profile sample is collected.
>>> Having a value stored in TLS makes a lot of sense for this however
>>> there are other ways to explore. Whatever is chosen, kernel samples
>>> taken in process context should be able to get this supporting data.
>>> In these patches on X64 the fsbase and gsbase are used for this.
>>>
>>> An option to explore suggested by Mathieu Desnoyers is to utilize rseq
>>> for processes to register a value location that can be included when
>>> profiling if desired. This would allow a tighter contract between user
>>> processes and a profiler.  It would allow better labeling/categorizing
>>> the correlation values.
>>
>> It is hard to understand this idea. Are you saying stash a cookie in
>> TLS for samples to capture to indicate an activity? Restartable
>> sequences are about preemption on a CPU not of a thread, so at least
>> my intuition is that they feel different. You could stash information
>> like this today by changing the thread name which generates comm
>> events. I've wondered about having similar information in some form of
>> reserved for profiling stack slot, for example, to stash a pointer to
>> the name of a function being interpreted. Snapshotting all of a stack
>> is bad performance wise and for security. A stack slot would be able
>> to deal with nesting.
>>
> 
> You are getting the idea. A slot or tag for a thread would be great! I'm
> not a fan of overriding the thread comm name (as that already has a
> use). TLS would be fine, if we could also pass an offset + size + type.
> 
> Maybe a stack slot that just points to parts of TLS? That way you could
> have a set of slots that don't require much memory and selectively copy
> them out of TLS (or where ever those slots point to in user memory).
> 
> When I was talking to Mathieu about this, it seems that rseq already had
> a place to potentially put these slots. I'm unsure though how the per
> thread aspects would work.
> 
> Mathieu, can you post your ideas here about that?

Sure. I'll try to summarize my thoughts here. By all means, let me
know if I'm missing important pieces of the puzzle.

First of all, here is my understanding of what information we want to
share between userspace and kernel.

A 128-bit activity ID identifies "uniquely" (as far as a 128-bit random
UUID allows) a portion of the dependency chain involved in doing some
work (e.g. answer a HTTP request) across one or many participating hosts.

Activity IDs have a parent/child relationship: a parent activity ID can
create children activity IDs.

For instance, if one host has the service "dispatch", another host
has a "web server", and a third host has a SQL database, we should
be able to follow the chain of activities needed to answer a web
query by following those activity IDs, linking them together
through parent/child relationships. This usually requires the
communication protocols to convey those activity IDs across hosts.

The reason why this information must be provided from userspace is
because it's userspace that knows where to find those activity IDs
within its application-layer communication protocols.

With tracing, taking a full trace of the activity ID spans begin/end
from all hosts allow reconstructing the activity IDs parent/child
relationships, so we typically only need to extract information about
activity ID span begin/end with parent/child info to a tracer.

Using activity IDs from a kernel profiler is trickier, because
we do not have access to the complete span begin/end trace to
reconstruct the activity ID parent/child relationship. This is
where I suspect we'd want to introduce a notion of "activity ID
stack", so a profiler could reconstruct the currently active
stack of activity IDs for the current thread by walking that
stack.

This profiling could be triggered either from an interrupt
(sampling use-case), which would then walk the user-space data
on return-to-userspace as noted by Peter, or it could also be
triggered from a system call return to userspace. This latter
option would make it possible to correlate system calls with
their associated activity ID stacks.

The basic scenario is simple enough: a thread pushes a new
current activity ID (starts a span), possibly nests other
spans, and ends them. It all happens neatly within a single
thread.

More advanced scenarios require more thoughts:

- non-blocking communication, where a thread can hop between
   different requests. Technically, it should be able to swap
   its current activity ID stack as it swaps handled requests.

- green threads (userspace scheduler): the userspace scheduler
   should be able to swap the activity ID stack of the current
   thread when swapping between user level threads.

- task "posting" (e.g. work queues types of work dispatch):
   the activity ID stacks should probably be handed over with
   the work item, and set as current activity ID stack by the
   worker thread.

- exceptions should be able to restore the activity ID stack
   from a previously saved state.

- Interpreters, JITs. Not sure about the constraints there, we
   may need support from the runtimes.

Those activity IDs are frequently updated, so going through a
system call each time would be a non-starter. This is where
thinking in terms of sharing a per-thread data structure
(populated by user-space, read by the kernel) becomes relevant.

A few words about how the rseq(2) system call could help: the
main building block of rseq is a per-thread "struct rseq" ABI,
which is registered by libc on thread creation, and is guaranteed
to be accessible at an offset from the thread pointer in
userspace, and can be accessed using the task struct "rseq" pointer
from the kernel (in contexts that can handle page faults).

Since Linux v6.3 the rseq structure becomes extensible, and we're
working with GNU libc to add support for this extension scheme [1].
So even though the primary use-case for rseq was to enable per-cpu
data structures in user-space, it can be used for other purposes
where shared per-thread data is needed between kernel and userspace.

We could envision adding a new field to struct rseq which would contain
the top level pointer to the current "activity ID stack". The layout
of this stack would have to be defined as a kernel ABI. We'd want
to support push/pop of activity IDs from that stack, as well as
moving all of or portions of the activity ID stack somewhere else,
as well as saving/recovering the stack from a saved state to accommodate
the "advanced" scenarios described above (and probably other scenarios
I'm missing).

rseq(2) could also play a role in letting the kernel expose a seed to
be used for generation of random activity IDs through yet another new
struct rseq field if this happens to be relevant. It could either be
a seed, or just a generation counter to be used to check whether the
seed needs to be regenerated after sleep/hibernate/fork/clone [2].

I'm hoping all this makes some sense, or at least highlights holes
in my understanding. Feedback is welcome!

Thanks,

Mathieu

[1] https://sourceware.org/pipermail/libc-alpha/2024-March/155587.html
[2] https://sourceware.org/pipermail/libc-alpha/2024-March/155577.html

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


