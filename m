Return-Path: <linux-kernel+bounces-141748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A587C8A22E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14581C22E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF81DDAA;
	Fri, 12 Apr 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fa4D8Gq5"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E3161;
	Fri, 12 Apr 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881073; cv=none; b=R5bI1Kn6SVt0Q7n6rULHBvMPl7xZPi51AkNjAOySVGtTWLPUPuL8HHjj/PrDnJSzqrJgw6zkSCoKpG32xCX4arBJa51+MfYIV2wBkzoa/EzsvO8PqEZSVzbGMjKFZV6LSlJfVNQb4nHIW6NlVbmfRmlXp77uyDTRIyxBgS6WDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881073; c=relaxed/simple;
	bh=DTkKtlAWf9eZANoDsVjxIB/a9kELTR3q5gy+PbPy7a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IAWu1PtJvnjV2E0oZP6eSyQdUqGhwtpyAj4wRC2j1qgIqx+OaWTjJlO9nAtCh5zmEymW0L6ARjF5UyoqVGUxJF5JVN5X/bknVDDivUp2Z7WGLSPbbABjg9wrHdrH02a6UNirGpeSo6Qlu8Z/8xqpn50fXllpCw4K9y2ko5HEEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fa4D8Gq5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.125])
	by linux.microsoft.com (Postfix) with ESMTPSA id 35E6220EC320;
	Thu, 11 Apr 2024 17:17:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35E6220EC320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712881070;
	bh=ohaBFCxKwM2w9anQtabwDeHmM+q2b/tliDpfFTTctww=;
	h=From:To:Cc:Subject:Date:From;
	b=fa4D8Gq5TxOMmlXkz5nlY53rrOMUKSHZ6AelVdhsFr5Tg2U2hq8XayHeCtJ6migLu
	 +ELxtYu/rVldteRy4s5f42oLvRDhC2Tv9Ivv5KzVMuGL2DMkN/W/yob27q4i4urH9T
	 bnykiCISePlCyod64FzgjmkudJjivpegQ6rLsJk8=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	primiano@google.com,
	aahringo@redhat.com,
	dcook@linux.microsoft.com
Subject: [RFC PATCH 0/4] perf: Correlating user process data to samples
Date: Fri, 12 Apr 2024 00:17:28 +0000
Message-Id: <20240412001732.475-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the Open Telemetry profiling SIG [1], we are trying to find a way to
grab a tracing association quickly on a per-sample basis. The team at
Elastic has a bespoke way to do this [2], however, I'd like to see a
more general way to achieve this. The folks I've been talking with seem
open to the idea of just having a TLS value for this we could capture
upon each sample. We could then just state, Open Telemetry SDKs should
have a TLS value for span correlation. However, we need a way to sample
the TLS or other value(s) when a sampling event is generated. This is
supported today on Windows via EventActivityIdControl() [3]. Since
Open Telemetry works on both Windows and Linux, ideally we can do
something as efficient for Linux based workloads.

This series is to explore how it would be best possible to collect
supporting data from a user process when a profile sample is collected.
Having a value stored in TLS makes a lot of sense for this however
there are other ways to explore. Whatever is chosen, kernel samples
taken in process context should be able to get this supporting data.
In these patches on X64 the fsbase and gsbase are used for this.

An option to explore suggested by Mathieu Desnoyers is to utilize rseq
for processes to register a value location that can be included when
profiling if desired. This would allow a tighter contract between user
processes and a profiler.  It would allow better labeling/categorizing
the correlation values.

An idea flow would look like this:
User Task		Profile
do_work();		sample() -> IP + No activity
..
set_activity(123);
..
do_work();		sample() -> IP + activity (123)
..
set_activity(124);
..
do_work();		sample() -> IP + activity (124)

Ideally, the set_activity() method would not be a syscall. It needs to
be very cheap as this should not bottleneck work. Ideally this is just
a memcpy of 16-20 bytes as it is on Windows via EventActivityIdControl()
using EVENT_ACTIVITY_CTRL_SET_ID.

For those not aware, Open Telemetry allows collecting data from multiple
machines and show where time was spent. The tracing context is already
available for logs, but not for profiling samples. The idea is to show
where slowdowns occur and have profile samples to explain why they
slowed down. This must be possible without having to track context
switches to do this correlation. This is because the profiling rates
are typically 20hz - 1Khz, while the context switching rates are much
higher. We do not want to have to consume high context switch rates
just to know a correlation for a 20hz signal. Often these 20hz signals
are always enabled in some environments.

Regardless if TLS, rseq, or other source is used I believe we will need
a way for perf_events to include it within a sample. The changes in this
series show how it could be done with TLS. There is some factoring work
under perf to make it easier to add more dump types using the existing
ABI. This is mostly to make the patches clearer, certainly the refactor
parts could get dropped and we could have duplicated/specialized paths.

1. https://opentelemetry.io/blog/2024/profiling/
2. https://www.elastic.co/blog/continuous-profiling-distributed-tracing-correlation
3. https://learn.microsoft.com/en-us/windows/win32/api/evntprov/nf-evntprov-eventactivityidcontrol

Beau Belgrave (4):
  perf/core: Introduce perf_prepare_dump_data()
  perf: Introduce PERF_SAMPLE_TLS_USER sample type
  perf/core: Factor perf_output_sample_udump()
  perf/x86/core: Add tls dump support

 arch/Kconfig                      |   7 ++
 arch/x86/Kconfig                  |   1 +
 arch/x86/events/core.c            |  14 +++
 arch/x86/include/asm/perf_event.h |   5 +
 include/linux/perf_event.h        |   7 ++
 include/uapi/linux/perf_event.h   |   5 +-
 kernel/events/core.c              | 166 +++++++++++++++++++++++-------
 kernel/events/internal.h          |  16 +++
 8 files changed, 180 insertions(+), 41 deletions(-)


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.34.1


