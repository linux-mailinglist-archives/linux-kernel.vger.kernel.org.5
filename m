Return-Path: <linux-kernel+bounces-111791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008B988710D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319F81C212BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403C5D479;
	Fri, 22 Mar 2024 16:42:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E85674C;
	Fri, 22 Mar 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125770; cv=none; b=j2vDgKb2b5DPLIs2qOelhVuetO0MzGuFYOZFI99nfPyRTtnvnMDv8xopINOwyy1uXg7MLz59LcHa8cfVg4ietXMXUsKWKRjGB86bEAmf14thZleoHY/Qf1tWdOyJ+Hk7XF7+syPZMzCZbv5SMD+XndhOxclEVITjvtO8BqgLMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125770; c=relaxed/simple;
	bh=hEsqfxJIR2reToPP0pC1oNrl0WbP9UJr+qXgdqGojAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSCaz7mK2PKwSa4isdCRBYvC49qaCiMWyOV1xsfmNwX4Fks+WMCiNHsDjHo4/KdJAyhlw+9+AEwEjd9xQ7LLOmphm8qB79+t54HISBAqfl6YFMfqU5XhFeOlNABoSfhPzwmLwVvz/OM2P5/9zya0fHStJRPKbVtrVzBrZtGQTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C36F8FEC;
	Fri, 22 Mar 2024 09:43:21 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D24E43F762;
	Fri, 22 Mar 2024 09:42:45 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v4 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Date: Fri, 22 Mar 2024 16:42:33 +0000
Message-ID: <20240322164237.203358-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows events to use PERF_SAMPLE READ with inherit so long 
as both inherit_stat and PERF_SAMPLE_TID are set.

Currently it is not possible to use PERF_SAMPLE_READ with inherit. This 
restriction assumes the user is interested in collecting aggregate 
statistics as per `perf stat`. It prevents a user from collecting 
per-thread samples using counter groups from a multi-threaded or 
multi-process application, as with `perf record -e '{....}:S'`. Instead 
users must use system-wide mode, or forgo the ability to sample counter 
groups. System-wide mode is often problematic as it requires specific 
permissions (no CAP_PERFMON / root access), or may lead to capture of 
significant amounts of extra data from other processes running on the 
system. 

Perf already supports the ability to collect per-thread counts with 
`inherit` via the `inherit_stat` flag. This patch changes 
`perf_event_alloc` relaxing the restriction to combine `inherit` with 
`PERF_SAMPLE_READ` so that the combination will be allowed so long as 
`inherit_stat` and `PERF_SAMPLE_TID` are enabled.

In this configuration stream ids (such as may appear in the read_format 
field of a PERF_RECORD_SAMPLE) are no longer globally unique, rather 
the pair of (stream id, tid) uniquely identify each event. Tools that 
rely on this, for example to calculate a delta between samples, would 
need updating to take this into account. Previously valid event 
configurations (system-wide, no-inherit and so on) where each stream id 
is the identifier are unaffected.


Changes since v3:
 - Cleaned up perf test data changes incorrectly included into this
   series from elsewhere.

Changes since v2:
 - Rebase on v6.8
 - Respond to James Clarke's feedback; fixup some typos and move some
   repeated checks into a helper macro.
 - Cleaned up checkpatch lints.
 - Updated perf test; fixed evsel handling so that existing tests pass
   and added new tests to cover the new behaviour.

Changes since v1:
 - Rebase on v6.8-rc1
 - Fixed value written into sample after child exists.
 - Modified handling of switch-out so that context with these events
   take the slow path, so that the per-event/per-thread PMU state is
   correctly switched.
 - Modified perf tools to support this mode of operation.

Ben Gainey (4):
  perf: Support PERF_SAMPLE_READ with inherit_stat
  tools/perf: Track where perf_sample_ids need per-thread periods
  tools/perf: Correctly calculate sample period for inherited
    SAMPLE_READ values
  tools/perf: Allow inherit + inherit_stat + PERF_SAMPLE_READ when
    opening events

 include/linux/perf_event.h                    |  1 +
 kernel/events/core.c                          | 62 ++++++++++----
 tools/lib/perf/evlist.c                       |  1 +
 tools/lib/perf/evsel.c                        | 48 +++++++++++
 tools/lib/perf/include/internal/evsel.h       | 55 ++++++++++++-
 .../test-record-group-sampling-inherit-stat   | 62 ++++++++++++++
 tools/perf/util/evsel.c                       | 82 ++++++++++++++++++-
 tools/perf/util/evsel.h                       |  1 +
 tools/perf/util/session.c                     | 11 ++-
 9 files changed, 301 insertions(+), 22 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling-inherit-stat

-- 
2.44.0


