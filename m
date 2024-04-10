Return-Path: <linux-kernel+bounces-138335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B2589EFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C752286EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8BB15921E;
	Wed, 10 Apr 2024 10:35:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB501581E5;
	Wed, 10 Apr 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745331; cv=none; b=chuf4Z7FDo2XtthYOXWnYyzdvtIGFzvQmzByaUtylPyuk+MlMPhQgGD1ndQXyUOt/ukzhCYW6DrTRFwmWogr7XI0dtviEjLC7Fkwf9xFlDZkEtc/o9MxOTQ20PilIpw7ld1WIYKT0RrSmyWubUspedA+XF4AlcKGeBodqM8S7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745331; c=relaxed/simple;
	bh=KeD4xL0gB/xCATWdOFUs5Nts/UM0E+U+CU8Lg6aBHO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0hJ19PvPGVy4KJKFKSLA1/WxoImQjpLOYs1r9MHbysVd7oc8IBMAqFKUCGNBo/2z8ODVpa/n3J8Calwy2ZJiA/wszsaDkq+mumrqDn0LkDxNOPw2zbd5Rmlo+BgXLF7PWhjEc0siGS5m7GcBQnLQtKp+WFh4nwcXDDyPzP9/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA457139F;
	Wed, 10 Apr 2024 03:35:59 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6538A3F6C4;
	Wed, 10 Apr 2024 03:35:27 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Spoorthy S <spoorts2@in.ibm.com>,
	Leo Yan <leo.yan@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] perf tests: Apply attributes to all events in object code reading test
Date: Wed, 10 Apr 2024 11:34:53 +0100
Message-Id: <20240410103458.813656-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410103458.813656-1-james.clark@arm.com>
References: <20240410103458.813656-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_PMU_CAP_EXTENDED_HW_TYPE results in multiple events being opened on
heterogeneous systems. Currently this test only sets its required
attributes on the first event. Not disabling enable_on_exec on the other
events causes the test to fail because the forked objdump processes are
sampled. No tracking event is opened so Perf only knows about its own
mappings causing the objdump samples to give the following error:

  $ perf test -vvv "object code reading"

  Reading object code for memory address: 0xffff9aaa55ec
  thread__find_map failed
  ---- end(-1) ----
  24: Object code reading              : FAILED!

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/code-reading.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 7a3a7bbbec71..29d2f3ee4e10 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -637,11 +637,11 @@ static int do_test_code_reading(bool try_kcore)
 
 		evlist__config(evlist, &opts, NULL);
 
-		evsel = evlist__first(evlist);
-
-		evsel->core.attr.comm = 1;
-		evsel->core.attr.disabled = 1;
-		evsel->core.attr.enable_on_exec = 0;
+		evlist__for_each_entry(evlist, evsel) {
+			evsel->core.attr.comm = 1;
+			evsel->core.attr.disabled = 1;
+			evsel->core.attr.enable_on_exec = 0;
+		}
 
 		ret = evlist__open(evlist);
 		if (ret < 0) {
-- 
2.34.1


