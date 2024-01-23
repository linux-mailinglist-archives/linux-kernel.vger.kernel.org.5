Return-Path: <linux-kernel+bounces-35088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B1838BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB28284041
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19DF5BAE3;
	Tue, 23 Jan 2024 10:27:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC65C5E0;
	Tue, 23 Jan 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005660; cv=none; b=a1c1Hqigh79kiLydpUA8yOsST90MqJuLEFg9DOQiHKzugqGcT3ZHd76MuyQmMw44d8a25NMFH43bUpI6J9p//5WfjvYm4OQZ04WsFGlFcVZiMnbJq0qtD0ZJOpNt4wzG7ZGof/GD4dUFc+HLkNjUV5WN90u+xWGi1oQho/ZZyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005660; c=relaxed/simple;
	bh=WHiIvVOL1WIlDzJWq+Wu1bVs6mBOGVTd3NVo6oCnJbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayLEICAnNgkCY1xc9W9PN/OTy47VwR4s3uwJUb2nch0hHwZ92n+2AclKarLJvNnaTfH8ktp+GsEamr7E/+frp7Ps4qOy8ufyl4D4RzfrGC7/cSMiDaandaZ1nBbH3dTtbhAuZKrzs3g+5D9cJheZuosb4LJqMWG8ajOjZJJW+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E10731FB;
	Tue, 23 Jan 2024 02:28:22 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 745813F5A1;
	Tue, 23 Jan 2024 02:27:35 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	kan.liang@linux.intel.com
Cc: mark.rutland@arm.com,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf evlist: Fix evlist__new_default() for > 1 core PMU
Date: Tue, 23 Jan 2024 10:27:27 +0000
Message-Id: <20240123102728.239147-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122155436.185089-1-james.clark@arm.com>
References: <20240122155436.185089-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'Session topology' test currently fails with this message when
evlist__new_default() opens more than one event:

  32: Session topology                                                :
  --- start ---
  templ file: /tmp/perf-test-vv5YzZ
  Using CPUID 0x00000000410fd070
  Opening: unknown-hardware:HG
  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    config                           0xb00000000
    disabled                         1
  ------------------------------------------------------------
  sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 4
  Opening: unknown-hardware:HG
  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    config                           0xa00000000
    disabled                         1
  ------------------------------------------------------------
  sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
  non matching sample_type
  FAILED tests/topology.c:73 can't get session
  ---- end ----
  Session topology: FAILED!

This is because when re-opening the file and parsing the header, Perf
expects that any file that has more than one event has the sample ID
flag set. Perf record already sets the flag in a similar way when there
is more than one event, so add the same logic to evlist__new_default().

evlist__new_default() is only currently used in tests, so I don't
expect this change to have any other side effects. The other tests that
use it don't save and re-open the file so don't hit this issue.

The session topology test has been failing on Arm big.LITTLE platforms
since commit 251aa040244a ("perf parse-events: Wildcard most
"numeric" events") when evlist__new_default() started opening multiple
events for 'cycles'.

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Closes: https://lore.kernel.org/lkml/CAP-5=fWVQ-7ijjK3-w1q+k2WYVNHbAcejb-xY0ptbjRw476VKA@mail.gmail.com/
Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/evlist.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Changes since v1:

  * Reduce scope of evsel variable
  * Add argument label
  * Change summary to be less specific about the failing test
  * Add the closes: tag

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 56db37fac6f6..979a6053a84d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -95,7 +95,6 @@ struct evlist *evlist__new_default(void)
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
 	int err;
-	struct evsel *evsel;
 
 	if (!evlist)
 		return NULL;
@@ -107,9 +106,12 @@ struct evlist *evlist__new_default(void)
 		evlist = NULL;
 	}
 
-	if (evlist->core.nr_entries > 1)
+	if (evlist->core.nr_entries > 1) {
+		struct evsel *evsel;
+
 		evlist__for_each_entry(evlist, evsel)
-			evsel__set_sample_id(evsel, false);
+			evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
+	}
 
 	return evlist;
 }
-- 
2.34.1


