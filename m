Return-Path: <linux-kernel+bounces-111449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B033E886C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FDB1F213EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0DD45033;
	Fri, 22 Mar 2024 13:04:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8952D78A;
	Fri, 22 Mar 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112674; cv=none; b=XieoSrNXLURkay3Ni0KhvvuLUJl6iVOGeW8sy9YCSdzJZKkK/p9LtR9l+Vxh1QTiSfS5E9aI1uKUDFRUWkcRBXnO7UOpTqSG+f5F1vXi79Tn6EfaeBwXBRTi+zE/71nKnIwVyGKssr5tfAcTYkiRxx6/MU0RaoNX3OrH2undZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112674; c=relaxed/simple;
	bh=36bOz8nNhZvOZ2vHdFujkr9NlYEM+bjWYl7mjNGjqPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYNU8PIvFFTI5k+gCiocnvHRz3C3rMy/P886vvChQEDz9LQXNk1aoAVTYDxu+0SutaNoH+UKH71UJwr3QsOeryyEB8W5J1WDIk4ooTOFOiaejc/YEAf2zzZ2Vc5Cb5Fbu0Fek4IYjjkCxQiEZIE58Ax3HCRa/yStCpAAX2TVoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 297911007;
	Fri, 22 Mar 2024 06:05:04 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B0F93F762;
	Fri, 22 Mar 2024 06:04:28 -0700 (PDT)
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
Subject: [PATCH v3 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Date: Fri, 22 Mar 2024 13:04:10 +0000
Message-ID: <20240322130414.70186-1-ben.gainey@arm.com>
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
 tools/perf/tests/attr/base-record             |  2 +-
 tools/perf/tests/attr/base-stat               |  2 +-
 tools/perf/tests/attr/system-wide-dummy       |  2 +-
 tools/perf/tests/attr/test-record-dummy-C0    |  2 +-
 .../test-record-group-sampling-inherit-stat   | 62 ++++++++++++++
 tools/perf/util/evsel.c                       | 82 ++++++++++++++++++-
 tools/perf/util/evsel.h                       |  1 +
 tools/perf/util/session.c                     | 11 ++-
 13 files changed, 305 insertions(+), 26 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling-inherit-stat

-- 
2.44.0


