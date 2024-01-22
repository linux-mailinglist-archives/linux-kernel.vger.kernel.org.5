Return-Path: <linux-kernel+bounces-33637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C63BF836C87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A30D1F261B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D424612FA;
	Mon, 22 Jan 2024 15:55:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305CB3D3A2;
	Mon, 22 Jan 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938936; cv=none; b=nhpJ6u0LM2aqh1S6VTsM86Up0g3ycLnjbyOlOtWsczrZxkW4bmGvaKaEbm4cB7Wr0U6vhEueeHRIREvuCEuMmaMQdqUbeuq9Et9susA8dcTCIgMCs2IWkdviL7izhd4//Vgo2O7rjBlRO2Tawh12od5d3oc1RT1XAHaz4lbucGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938936; c=relaxed/simple;
	bh=kUXfghoiFBjltNJTwIw7DiTy00z9/3VXv1D/1k0n6CI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jx7b3xjgxxiUZUxrDwnhyZ+iWOWOAbFCBbEkK5VXlkCssZdNJ+ic/LkTbM+Y2s16A/EcyntEUH4J67RwSURJmY361jk77ZprN77Lq/TPAbcDtbZ9QOtSDs1nZJ8pJ11fAbAUoL1vFHj7HvkA56YlVRJ9uNUamSA58P3jISUOs1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 573CD1FB;
	Mon, 22 Jan 2024 07:56:19 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 337963F5A1;
	Mon, 22 Jan 2024 07:55:31 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Changbin Du <changbin.du@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Fix session topology test on heterogeneous systems
Date: Mon, 22 Jan 2024 15:54:35 +0000
Message-Id: <20240122155436.185089-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test currently fails with this message when evlist__new_default()
opens more than one event:

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
expects that any file that has more than one event has the session ID
flag set. Perf record already sets the flag in a similar way when there
is more than one event, so add the same logic to evlist__new_default().

evlist__new_default() is only currently used in tests, so I don't
expect this change to have any other side effects.

The session topology test has been failing on Arm big.LITTLE platforms
since commit 251aa040244a ("perf parse-events: Wildcard most
"numeric" events") when evlist__new_default() started opening multiple
events for 'cycles'.

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/evlist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 95f25e9fb994..56db37fac6f6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -95,6 +95,7 @@ struct evlist *evlist__new_default(void)
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
 	int err;
+	struct evsel *evsel;
 
 	if (!evlist)
 		return NULL;
@@ -106,6 +107,10 @@ struct evlist *evlist__new_default(void)
 		evlist = NULL;
 	}
 
+	if (evlist->core.nr_entries > 1)
+		evlist__for_each_entry(evlist, evsel)
+			evsel__set_sample_id(evsel, false);
+
 	return evlist;
 }
 
-- 
2.34.1


