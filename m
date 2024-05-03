Return-Path: <linux-kernel+bounces-167647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F023F8BACB4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3C4B20C38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C9153518;
	Fri,  3 May 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Am26v1GM"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B7F9EB
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740050; cv=none; b=Q22iJk45MVre+EnozmC68nOHNvs6dqhBUGbNWb/FatkHOeFjNE9n04TYNDWbODwLXlMFuLdxhrvbMyo5rC/5fWZH8gAzKzrg8z6QLuq78ldKU/L49cdPxvQY7DnEaWjIwvgzXNTMSboXbhqYWCPZRKggid3DVY97gz9i9+cBpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740050; c=relaxed/simple;
	bh=L3pjM0L4rV6XPqTfk9qjTehijQ26iKFLr7SuET11yHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPzUOm5eoiS5RwCWtOYbfbQNqTMmetxEwgG9kcZ4CN7hm37/qsVqqSBChi9jMCNTBsnj/LW2dTRFkRYq2/wy36TebLdnYjVKDaeb7JkFQjE9RmIjNPYMVl0HlRlB3H1uLolTfVeAUPG8apFMvnQzQtYBjAMHVS4csLHixb6S6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Am26v1GM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso5393166b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714740046; x=1715344846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYwSNDI9QgFV+fd05nUh9/SdEfqos7OFNMtSW+S8lRs=;
        b=Am26v1GMVZWnTWOOKeoh+uq73P2UrVjrFE5vUjdpyrck/Y5dArdZC46i78tbp+lRiX
         bCPpy0odWzUQfH7G9qj/Tjoscq8N/lkFGfM4U9cI4IxUtJ0Wb1njuDzkEbwJwWihTj10
         KFO4khqDqxeqK2SW0o/llWxG+0q/pTRD8QCGjJPzqxHhG6Q1pGrLypZrmLam0PbJ5kB5
         sBhKGEtzGJBqapHgXeiuPNUfTpYCN5S0M/Oa7fwbnsef1TT4qmsIdF5sma9UqMJzBx3x
         1cydgKhq+nVcw5CDVS18zpHt7TzR3F7rHKb0u9PbNYrWSAxUkFkeqjUy1wXoDS+6VXKl
         e6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740046; x=1715344846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYwSNDI9QgFV+fd05nUh9/SdEfqos7OFNMtSW+S8lRs=;
        b=sKivCPxLaVL+TpA8emXuadgoutnsT4hv/REZcDP/JCdl4k8DI/FVdgCShzJeyg0SCf
         frL25Cs4CvfcBBXilnBA5ieVTs0bmNtl8f0yBITREUpLMcm+1CXOKcmknGmUhweHUa/L
         Nddo4UoEb6B5v5lmUmbkseoiiPXgGeEI7pwbaZXMB5ul1YzqzqRGI7okcXFD/nfYbI/d
         /rrmYdiuJBjgqWH6lFaEGLhd332BONX9gqTnlq1vjEMh0phPX5iJ90z9Df8aN2Fq9YEW
         hFg9nKTu7qg7J6YWo+QXDyXPUyoOizQ22r4CyvEXfhn2asll6XcBonyqhzKiSOUCIVxF
         Xa/g==
X-Forwarded-Encrypted: i=1; AJvYcCX79PKjkI/w3U2eARyd4r2M7BmgE6ApeGw+1AAvd5zztteytGmWf1EO8CBtDTlIv69KQtzHFH5Fm0EgHW6TVMC6BpuJYSnmJDbA+NNc
X-Gm-Message-State: AOJu0YzhwTOXpeZrmwaHynuZFd9bu1rq8ePuxg08Rmc5AYEXFBPBWpIK
	8eSiJYyDeHP/DlTSjQ5h/pRXelL+rTQpO7dMo3UZNfmNGbLRxnUtJQfNWh+ey8MEoN9K9nz6CbJ
	nw3lab6+tuWxH5FH+0p6a/Th3WGLIf7kcsccxmw==
X-Google-Smtp-Source: AGHT+IFryEDRWu+bcUZI//BoyKSedi7LKHRkuYMa36RWP3/43wK/TONQNCJDn3kMk2kEWxukIvBvLHPZTVJTjYKqYok=
X-Received: by 2002:a05:6a20:9703:b0:1ad:ab1:9a03 with SMTP id
 hr3-20020a056a20970300b001ad0ab19a03mr2171735pzc.25.1714740046457; Fri, 03
 May 2024 05:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-1-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 3 May 2024 13:40:34 +0100
Message-ID: <CAJ9a7Vi7P3kBG5x_JC6AxDL-AvPc5=48eEC0gH3CHceVtSNmOQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] coresight: Use per-sink trace ID maps for Perf sessions
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com, 
	scclevenger@os.amperecomputing.com, coresight@lists.linaro.org, 
	suzuki.poulose@arm.com, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

Hi James

On Mon, 29 Apr 2024 at 16:23, James Clark <james.clark@arm.com> wrote:
>
> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> as long as there are fewer than that many ETMs connected to each sink.
>
> Each sink owns its own trace ID map, and any Perf session connecting to
> that sink will allocate from it, even if the sink is currently in use by
> other users. This is similar to the existing behavior where the dynamic
> trace IDs are constant as long as there is any concurrent Perf session
> active. It's not completely optimal because slightly more IDs will be
> used than necessary, but the optimal solution involves tracking the PIDs
> of each session and allocating ID maps based on the session owner. This
> is difficult to do with the combination of per-thread and per-cpu modes
> and some scheduling issues. The complexity of this isn't likely to worth
> it because even with multiple users they'd just see a difference in the
> ordering of ID allocations rather than hitting any limits (unless the
> hardware does have too many ETMs connected to one sink).
>
> Per-thread mode works but only until there are any overlapping IDs, at
> which point Perf will error out. Both per-thread mode and sysfs mode are
> left to future changes, but both can be added on top of this initial
> implementation and only sysfs mode requires further driver changes.
>
> The HW_ID version field hasn't been bumped in order to not break Perf
> which already has an error condition for other values of that field.
> Instead a new minor version has been added which signifies that there
> are new fields but the old fields are backwards compatible.
>

Looking at this overall - would it not be better to introduce the
concept of a "sink ID" to allow the detection of multiple sources into
the single sink that is now done by emitting multiple AUX_HWID packets
with the CPU+ID extra data?
This sink ID could be part of the sink csdev struct - or even the
id_map struct - a simple count of sinks as the per sink maps are
created would be sufficient. If this sink ID replaced the CPU+ID extra
data in the HWID packets, then each packet could be emitted just once,
and perf can then collate based on the sink id.

Moreover, once we are ready to address the per-thread issues - then
the overlap would not matter. Generate OpenCSD decode trees per sink
ID, add docoders to the tree per Trace ID. Thus if a buffer has data
from sink 1 trace id 5, ans sink 2, trace ID 5, then pick the right
decoder for the combo.

Finally in systems with ETE+TRBE were there is no use of trace IDs, a
sink ID of 0x0 could potentially indicate that 1:1 relationship.

Regards

Mike

>
> James Clark (17):
>   perf cs-etm: Print error for new PERF_RECORD_AUX_OUTPUT_HW_ID versions
>   perf auxtrace: Allow number of queues to be specified
>   perf: cs-etm: Create decoders after both AUX and HW_ID search passes
>   perf: cs-etm: Allocate queues for all CPUs
>   perf: cs-etm: Move traceid_list to each queue
>   perf: cs-etm: Create decoders based on the trace ID mappings
>   perf: cs-etm: Support version 0.1 of HW_ID packets
>   coresight: Remove unused stubs
>   coresight: Clarify comments around the PID of the sink owner
>   coresight: Move struct coresight_trace_id_map to common header
>   coresight: Expose map argument in trace ID API
>   coresight: Make CPU id map a property of a trace ID map
>   coresight: Pass trace ID map into source enable
>   coresight: Use per-sink trace ID maps for Perf sessions
>   coresight: Remove pending trace ID release mechanism
>   coresight: Re-emit trace IDs when the sink changes in per-thread mode
>   coresight: Emit HW_IDs for all ETMs that are using the sink
>
>  drivers/hwtracing/coresight/coresight-core.c  |  10 +
>  drivers/hwtracing/coresight/coresight-dummy.c |   3 +-
>  .../hwtracing/coresight/coresight-etm-perf.c  |  82 ++-
>  .../hwtracing/coresight/coresight-etm-perf.h  |  20 +-
>  .../coresight/coresight-etm3x-core.c          |  14 +-
>  .../coresight/coresight-etm4x-core.c          |  14 +-
>  drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
>  drivers/hwtracing/coresight/coresight-sysfs.c |   3 +-
>  .../hwtracing/coresight/coresight-tmc-etr.c   |   5 +-
>  drivers/hwtracing/coresight/coresight-tmc.h   |   5 +-
>  drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
>  .../hwtracing/coresight/coresight-trace-id.c  | 107 +--
>  .../hwtracing/coresight/coresight-trace-id.h  |  57 +-
>  include/linux/coresight-pmu.h                 |  17 +-
>  include/linux/coresight.h                     |  20 +-
>  tools/include/linux/coresight-pmu.h           |  17 +-
>  tools/perf/util/auxtrace.c                    |   9 +-
>  tools/perf/util/auxtrace.h                    |   1 +
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  28 +-
>  tools/perf/util/cs-etm.c                      | 617 ++++++++++++------
>  tools/perf/util/cs-etm.h                      |   2 +-
>  21 files changed, 633 insertions(+), 404 deletions(-)
>
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

