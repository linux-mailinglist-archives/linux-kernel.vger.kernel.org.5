Return-Path: <linux-kernel+bounces-143084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F398A33E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F13D1F22CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB4D148FE8;
	Fri, 12 Apr 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rCHtAbCw"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9153811;
	Fri, 12 Apr 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939343; cv=none; b=LN2hHbTxqosScJSuYWtTEfXOKqT6pLHox+xNRk7ERzGq0srWgBYzeXG9c5wLCTtKHAT7pmJDOM843GgR6ry4/j9b9NQS69JZNtjamsUza9B7T7oDeUF9xj0OdxV/1XbMAbPhZqOOtjwplT4j++BIJd4ih3U3u9yetxIQV8bSV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939343; c=relaxed/simple;
	bh=Nw76s36euEpvCv3rVMgFKiDKHwOrD8yGqXcaYuU/bQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ+knEVh7O23ZlS4NvdVj5mKnFyDRlomntfpXc46gt8Xd7v05zgn7HteJbH3SC4ED3NpTn3K4tYKlpvjK0/h7NngPv0iZ52pHUbmb6wH+4diWvWeiCfL8OwrV79Kict1BsUyzdlDLd1EgH/fcsEGu640cYtRQEnIbJNfnJJFeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rCHtAbCw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B1FE20EBE27;
	Fri, 12 Apr 2024 09:28:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B1FE20EBE27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712939336;
	bh=aPNAajPgfa9tLlbi4R+vTG3tD1EMXPgxv/2aSoOWXiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCHtAbCw94qufrUR+oDW0j7orn9yDy95q/+KzGcXHgvCdFkT8odTWCYYEqR3Xr71Q
	 bQpRy1gVabzD6DDvkPbmutCYQpgXPFRnHU4Ep1i5dW6CWdBtDKTA5OCnStkcHXuB1g
	 0RgMJe948AXGBvFi0KmgZi+0GjyReGjB2bUzpwOY=
Date: Fri, 12 Apr 2024 09:28:48 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, primiano@google.com, aahringo@redhat.com,
	dcook@linux.microsoft.com
Subject: Re: [RFC PATCH 0/4] perf: Correlating user process data to samples
Message-ID: <20240412162848.GA467-beaub@linux.microsoft.com>
References: <20240412001732.475-1-beaub@linux.microsoft.com>
 <CAP-5=fVVQ5RGqEQo596to_3BYZ6vNFC_DR1nnunH_-Bb6bdpVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVVQ5RGqEQo596to_3BYZ6vNFC_DR1nnunH_-Bb6bdpVg@mail.gmail.com>

On Thu, Apr 11, 2024 at 09:52:22PM -0700, Ian Rogers wrote:
> On Thu, Apr 11, 2024 at 5:17 PM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> >
> > In the Open Telemetry profiling SIG [1], we are trying to find a way to
> > grab a tracing association quickly on a per-sample basis. The team at
> > Elastic has a bespoke way to do this [2], however, I'd like to see a
> > more general way to achieve this. The folks I've been talking with seem
> > open to the idea of just having a TLS value for this we could capture
> 
> Presumably TLS == Thread Local Storage.
> 

Yes, the initial idea is to use thread local storage (TLS). It seems to
be the fastest option to save a per-thread value that changes at a fast
rate.

> > upon each sample. We could then just state, Open Telemetry SDKs should
> > have a TLS value for span correlation. However, we need a way to sample
> > the TLS or other value(s) when a sampling event is generated. This is
> > supported today on Windows via EventActivityIdControl() [3]. Since
> > Open Telemetry works on both Windows and Linux, ideally we can do
> > something as efficient for Linux based workloads.
> >
> > This series is to explore how it would be best possible to collect
> > supporting data from a user process when a profile sample is collected.
> > Having a value stored in TLS makes a lot of sense for this however
> > there are other ways to explore. Whatever is chosen, kernel samples
> > taken in process context should be able to get this supporting data.
> > In these patches on X64 the fsbase and gsbase are used for this.
> >
> > An option to explore suggested by Mathieu Desnoyers is to utilize rseq
> > for processes to register a value location that can be included when
> > profiling if desired. This would allow a tighter contract between user
> > processes and a profiler.  It would allow better labeling/categorizing
> > the correlation values.
> 
> It is hard to understand this idea. Are you saying stash a cookie in
> TLS for samples to capture to indicate an activity? Restartable
> sequences are about preemption on a CPU not of a thread, so at least
> my intuition is that they feel different. You could stash information
> like this today by changing the thread name which generates comm
> events. I've wondered about having similar information in some form of
> reserved for profiling stack slot, for example, to stash a pointer to
> the name of a function being interpreted. Snapshotting all of a stack
> is bad performance wise and for security. A stack slot would be able
> to deal with nesting.
> 

You are getting the idea. A slot or tag for a thread would be great! I'm
not a fan of overriding the thread comm name (as that already has a
use). TLS would be fine, if we could also pass an offset + size + type.

Maybe a stack slot that just points to parts of TLS? That way you could
have a set of slots that don't require much memory and selectively copy
them out of TLS (or where ever those slots point to in user memory).

When I was talking to Mathieu about this, it seems that rseq already had
a place to potentially put these slots. I'm unsure though how the per
thread aspects would work.

Mathieu, can you post your ideas here about that?

> > An idea flow would look like this:
> > User Task               Profile
> > do_work();              sample() -> IP + No activity
> > ...
> > set_activity(123);
> > ...
> > do_work();              sample() -> IP + activity (123)
> > ...
> > set_activity(124);
> > ...
> > do_work();              sample() -> IP + activity (124)
> >
> > Ideally, the set_activity() method would not be a syscall. It needs to
> > be very cheap as this should not bottleneck work. Ideally this is just
> > a memcpy of 16-20 bytes as it is on Windows via EventActivityIdControl()
> > using EVENT_ACTIVITY_CTRL_SET_ID.
> >
> > For those not aware, Open Telemetry allows collecting data from multiple
> > machines and show where time was spent. The tracing context is already
> > available for logs, but not for profiling samples. The idea is to show
> > where slowdowns occur and have profile samples to explain why they
> > slowed down. This must be possible without having to track context
> > switches to do this correlation. This is because the profiling rates
> > are typically 20hz - 1Khz, while the context switching rates are much
> > higher. We do not want to have to consume high context switch rates
> > just to know a correlation for a 20hz signal. Often these 20hz signals
> > are always enabled in some environments.
> >
> > Regardless if TLS, rseq, or other source is used I believe we will need
> > a way for perf_events to include it within a sample. The changes in this
> > series show how it could be done with TLS. There is some factoring work
> > under perf to make it easier to add more dump types using the existing
> > ABI. This is mostly to make the patches clearer, certainly the refactor
> > parts could get dropped and we could have duplicated/specialized paths.
> 
> fs and gs may be used for more than just the C runtime's TLS. For
> example, they may be used by emulators or managed runtimes. I'm not
> clear why this specific case couldn't be handled through BPF.
> 

Agree about the fs/gs possibly being used for other things. If we had a
stack slot we could avoid the confusion and have tighter couplings.

You can do this in eBPF (see [2]). However, it's very clunky and depends
on specific SDKs per-language/runtime. We ourselves don't run our profilers
with anything other than CAP_PERFMON, and also have environments without
BPF enabled due to various reasons. It'd be great if we could get this data
directly from perf. At the very least, I'd love to get a standardized
way to attribute thread values accessible to other performance systems
(like eBPF and perf).

Thanks,
-Beau

> Thanks,
> Ian
> 
> > 1. https://opentelemetry.io/blog/2024/profiling/
> > 2. https://www.elastic.co/blog/continuous-profiling-distributed-tracing-correlation
> > 3. https://learn.microsoft.com/en-us/windows/win32/api/evntprov/nf-evntprov-eventactivityidcontrol
> >
> > Beau Belgrave (4):
> >   perf/core: Introduce perf_prepare_dump_data()
> >   perf: Introduce PERF_SAMPLE_TLS_USER sample type
> >   perf/core: Factor perf_output_sample_udump()
> >   perf/x86/core: Add tls dump support
> >
> >  arch/Kconfig                      |   7 ++
> >  arch/x86/Kconfig                  |   1 +
> >  arch/x86/events/core.c            |  14 +++
> >  arch/x86/include/asm/perf_event.h |   5 +
> >  include/linux/perf_event.h        |   7 ++
> >  include/uapi/linux/perf_event.h   |   5 +-
> >  kernel/events/core.c              | 166 +++++++++++++++++++++++-------
> >  kernel/events/internal.h          |  16 +++
> >  8 files changed, 180 insertions(+), 41 deletions(-)
> >
> >
> > base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> > --
> > 2.34.1
> >

