Return-Path: <linux-kernel+bounces-58129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4EA84E1BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D2B298FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A67691B;
	Thu,  8 Feb 2024 13:11:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535A762E2;
	Thu,  8 Feb 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397876; cv=none; b=uKyA8CxCjjSAcmun9zve4+zXh0E1+t5R9y6qWfRWF05ArBt77c77sYYKsQvmkFgWXwQAh0926bBfeb3ZIlYdvmLh6teNkNOUVtfNy9NrpMcIzhX4S2XqNTMbQB/Rio8fHUOPYrWCfeDzXtvo/pxCDkB0pOnp/ahFSpL+Hk+5d74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397876; c=relaxed/simple;
	bh=mjugEGPZ/9rXzehutbCHuWqGzgqqqVqeOkObNnV6wFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTA0eUtxyLPS+bp3nYsQ8R3aj/hTjifFZMSozrbxFmHSNvOpHrtcAel34nkL6uLSW/yc+tk/fWLJ4+b10PBqTUQqtTLpT0tnKOtc8vYpQdODNBWih7E8uq+OmDXlqV/kIYqMg7XddkC3F0tvk15F9zhZ5u05FlLlAPHpvSZArKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA7991FB;
	Thu,  8 Feb 2024 05:11:54 -0800 (PST)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C59663F5A1;
	Thu,  8 Feb 2024 05:11:10 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@arm.com,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v2 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Date: Thu,  8 Feb 2024 13:10:46 +0000
Message-ID: <20240208131050.2406183-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
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


Changes since v1:
 - Rebase on v6.8-rc1
 - Fixed value written into sample after child exists.
 - Modified handling of switch-out so that context with these events take the
   slow path, so that the per-event/per-thread PMU state is correctly switched.
 - Modified perf tools to support this mode of operation.


Ben Gainey (4):
  perf: Support PERF_SAMPLE_READ with inherit_stat
  tools/perf: Track where perf_sample_ids need per-thread periods
  tools/perf: Correctly calculate sample period for inherited
    SAMPLE_READ values
  tools/perf: Allow inherit + inherit_stat + PERF_SAMPLE_READ when
    opening events

 include/linux/perf_event.h              |  1 +
 kernel/events/core.c                    | 53 +++++++++++++++++--------
 tools/lib/perf/evlist.c                 |  1 +
 tools/lib/perf/evsel.c                  | 48 ++++++++++++++++++++++
 tools/lib/perf/include/internal/evsel.h | 48 +++++++++++++++++++++-
 tools/perf/util/evsel.c                 | 15 ++++++-
 tools/perf/util/evsel.h                 |  1 +
 tools/perf/util/session.c               | 11 +++--
 8 files changed, 154 insertions(+), 24 deletions(-)

-- 
2.43.0


