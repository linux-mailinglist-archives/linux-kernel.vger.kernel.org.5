Return-Path: <linux-kernel+bounces-36735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12D783A5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106161C238D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37181802B;
	Wed, 24 Jan 2024 09:44:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0B317C6D;
	Wed, 24 Jan 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089474; cv=none; b=Ln37KZr8pBuvQ04zyZoiXH0c1quQ5mUG7ipnZc5VsPyvbvMg8pxIaJg9WAJVuErM/emZAxfP2cHmwmkQja0APFeLRQUnI8URbSgzYZYbqD/p8diVc+k40nNDtQvKHgNetV0BsKA7njJLH1QUZ3ROkqvUVdolHZbkdMEjzg0EP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089474; c=relaxed/simple;
	bh=lX0vTjJ1fC6yUMtsgabQ+KnmlSLeYfNY+C91khWlpzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F286JCnlAiOenmZ4S2F3+IhQ/YUguM+bkm8I/gRvNHgv1tu2MWf7NA1m25mS0sg2YPs+gphcOSgKBM51dCDXY041UcDc1hD9aRfgze2NjJUXYhlQU5RpmV0uTLKZRYyvrKNELwZb0PM/2Ab/teSu3wbXNpc05ntRiDi5EAuxuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FB641FB;
	Wed, 24 Jan 2024 01:45:16 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47DCE3F762;
	Wed, 24 Jan 2024 01:44:29 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Changbin Du <changbin.du@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf evlist: Fix evlist__new_default() for > 1 core PMU
Date: Wed, 24 Jan 2024 09:43:57 +0000
Message-Id: <20240124094358.489372-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
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
 tools/perf/util/evlist.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Changes since v3:

  * Return early if parsing fails, don't try to set the sample id.

Changes since v2:

  * Undo the fact that v2 was accidentally based on v1 instead of
    perf-tools

Changes since v1:

  * Reduce scope of evsel variable
  * Add argument label
  * Change summary to be less specific about the failing test
  * Add the closes: tag

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 95f25e9fb994..55a300a0977b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -103,7 +103,14 @@ struct evlist *evlist__new_default(void)
 	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
 	if (err) {
 		evlist__delete(evlist);
-		evlist = NULL;
+		return NULL;
+	}
+
+	if (evlist->core.nr_entries > 1) {
+		struct evsel *evsel;
+
+		evlist__for_each_entry(evlist, evsel)
+			evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
 	}
 
 	return evlist;
-- 
2.34.1


