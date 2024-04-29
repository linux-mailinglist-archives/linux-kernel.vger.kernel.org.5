Return-Path: <linux-kernel+bounces-162567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D308B5D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C15B2859E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22381AC1;
	Mon, 29 Apr 2024 15:23:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC299745C5;
	Mon, 29 Apr 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404219; cv=none; b=ubjW7wZmNfGPSm9ETZ7Qa/K90kpzbT5VMsVKcfQ30gzFA0ni6YcMI93wgGCytQuSh0qKq1gq9T4PhHsFhy9iioLHVQQezGXGv9cF5OF/IQZVsRD6xJuyGqGiTmyevQN9hOKw6SUcDuNcT5ut2OAUkoATkZhLNqnWYX9YOR+SmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404219; c=relaxed/simple;
	bh=T97eXiCoo8c2wzSk/75hX1LVypK0OF869Y6KpZyXIaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hOppTAivQoQXZTh6w2JACBn8XLNPNbytXqQDYhu29gifxyAjYSrFqW3XRyCichF2sT8UUmj547VDLzd9dcQysEzvSZGnWLy2zHoS6piRFisY8ZQ1w6HS0bNWnaP1lJbL56Ot35bLzjhVcUwI7irkPQOUo4Dx4IO+wo+8DGg9Efc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AD4F2F4;
	Mon, 29 Apr 2024 08:24:02 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9B823F793;
	Mon, 29 Apr 2024 08:23:32 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@linaro.org
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/17] coresight: Use per-sink trace ID maps for Perf sessions
Date: Mon, 29 Apr 2024 16:21:45 +0100
Message-Id: <20240429152207.479221-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
as long as there are fewer than that many ETMs connected to each sink.

Each sink owns its own trace ID map, and any Perf session connecting to
that sink will allocate from it, even if the sink is currently in use by
other users. This is similar to the existing behavior where the dynamic
trace IDs are constant as long as there is any concurrent Perf session
active. It's not completely optimal because slightly more IDs will be
used than necessary, but the optimal solution involves tracking the PIDs
of each session and allocating ID maps based on the session owner. This
is difficult to do with the combination of per-thread and per-cpu modes
and some scheduling issues. The complexity of this isn't likely to worth
it because even with multiple users they'd just see a difference in the
ordering of ID allocations rather than hitting any limits (unless the
hardware does have too many ETMs connected to one sink).

Per-thread mode works but only until there are any overlapping IDs, at
which point Perf will error out. Both per-thread mode and sysfs mode are
left to future changes, but both can be added on top of this initial
implementation and only sysfs mode requires further driver changes.

The HW_ID version field hasn't been bumped in order to not break Perf
which already has an error condition for other values of that field.
Instead a new minor version has been added which signifies that there
are new fields but the old fields are backwards compatible.


James Clark (17):
  perf cs-etm: Print error for new PERF_RECORD_AUX_OUTPUT_HW_ID versions
  perf auxtrace: Allow number of queues to be specified
  perf: cs-etm: Create decoders after both AUX and HW_ID search passes
  perf: cs-etm: Allocate queues for all CPUs
  perf: cs-etm: Move traceid_list to each queue
  perf: cs-etm: Create decoders based on the trace ID mappings
  perf: cs-etm: Support version 0.1 of HW_ID packets
  coresight: Remove unused stubs
  coresight: Clarify comments around the PID of the sink owner
  coresight: Move struct coresight_trace_id_map to common header
  coresight: Expose map argument in trace ID API
  coresight: Make CPU id map a property of a trace ID map
  coresight: Pass trace ID map into source enable
  coresight: Use per-sink trace ID maps for Perf sessions
  coresight: Remove pending trace ID release mechanism
  coresight: Re-emit trace IDs when the sink changes in per-thread mode
  coresight: Emit HW_IDs for all ETMs that are using the sink

 drivers/hwtracing/coresight/coresight-core.c  |  10 +
 drivers/hwtracing/coresight/coresight-dummy.c |   3 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |  82 ++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  20 +-
 .../coresight/coresight-etm3x-core.c          |  14 +-
 .../coresight/coresight-etm4x-core.c          |  14 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |   3 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |   5 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |   5 +-
 drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
 .../hwtracing/coresight/coresight-trace-id.c  | 107 +--
 .../hwtracing/coresight/coresight-trace-id.h  |  57 +-
 include/linux/coresight-pmu.h                 |  17 +-
 include/linux/coresight.h                     |  20 +-
 tools/include/linux/coresight-pmu.h           |  17 +-
 tools/perf/util/auxtrace.c                    |   9 +-
 tools/perf/util/auxtrace.h                    |   1 +
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  28 +-
 tools/perf/util/cs-etm.c                      | 617 ++++++++++++------
 tools/perf/util/cs-etm.h                      |   2 +-
 21 files changed, 633 insertions(+), 404 deletions(-)

-- 
2.34.1


