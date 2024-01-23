Return-Path: <linux-kernel+bounces-35932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C568398E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB531C26CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D211292F0;
	Tue, 23 Jan 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8oeeGO1"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE9128379;
	Tue, 23 Jan 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035877; cv=none; b=g5VKeEkvsBl8JwxIvsQ56aExG02mD/lbRPpyU0AfzXeIibOT7HvxBaMR9ISr/SW/xg8oCHlL7cDFx/QejLgnBMZsRnUJpYCHq7wnJeQhwAG32PSpNdamovGTIa6DrAbwXegnVdlElCVzG/DcLLPStU11CVPrUohFWnQCQBcPjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035877; c=relaxed/simple;
	bh=vaCOmk4EQLPYl6qart1/wxAgGY/EEo+ebr0uBg2VWyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bu9UtZ17JJSe404uQC9XNPHlTV3PqyeGm1Qg3nPlHs30R9xIOaR+yhWBHM4LLsHFC1SKowSnGekHJsWANtopT+cYMaCnH97EnVVx5jClzNf3aScCQmjiZD/C7bOPfK31zlpEi9Hhi1j4+gfJyJwV9OicswaOXYGTl0dBiRupWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8oeeGO1; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035875; x=1737571875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vaCOmk4EQLPYl6qart1/wxAgGY/EEo+ebr0uBg2VWyU=;
  b=d8oeeGO1ZdQOVBR5pOJoXcUfc6eYxwbl7auqJ6rw8to2Q/L8jCVQBJft
   v5NkKbF1622qk1OUH5DeZ73R/RlcOB1WZ2u13qHw2MHSzNGzKLnnDnixQ
   j+rlaErzGfhH7K8AnBY+uXpH4uO3omzEc4gQeTG7/WWTxL7zqA2plOBTk
   VoociU4yfLWiOi8uVqsDFUSU8DBDOLvdED9ov0/b7/RJSofMXawt4pdmE
   7GOq7/8Wft2KWQlASpyy47IYXbg24W+MPcqCvfkYAGwbGCFwkDEesNvcm
   9s8p3MJwyXxO9yX9tZ813nB0b8dZC0nzP5Fhp4RVOpyGhrOjdHBFwu9+Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400487506"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400487506"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1764068"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 10:51:15 -0800
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	john.g.garry@oracle.com,
	will@kernel.org,
	james.clark@arm.com,
	mike.leach@linaro.org,
	leo.yan@linaro.org,
	yuhaixin.yhx@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com,
	ravi.bangoria@amd.com,
	atrajeev@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 5/7] perf mem: Clean up is_mem_loads_aux_event()
Date: Tue, 23 Jan 2024 10:50:34 -0800
Message-Id: <20240123185036.3461837-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240123185036.3461837-1-kan.liang@linux.intel.com>
References: <20240123185036.3461837-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The aux_event can be retrieved from the perf_pmu now. Implement a
generic support.

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/mem-events.c | 23 ++++-------------------
 tools/perf/util/mem-events.c          | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b776d849fc64..62df03e91c7e 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util/pmu.h"
-#include "util/pmus.h"
-#include "util/env.h"
-#include "map_symbol.h"
-#include "mem-events.h"
 #include "linux/string.h"
-#include "env.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
+#include "mem-events.h"
+
 
 #define MEM_LOADS_AUX		0x8203
 
@@ -28,16 +26,3 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s//",		NULL,	false,	0),
 };
-
-bool is_mem_loads_aux_event(struct evsel *leader)
-{
-	struct perf_pmu *pmu = perf_pmus__find("cpu");
-
-	if (!pmu)
-		pmu = perf_pmus__find("cpu_core");
-
-	if (pmu && !perf_pmu__have_event(pmu, "mem-loads-aux"))
-		return false;
-
-	return leader->core.attr.config == MEM_LOADS_AUX;
-}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 32890848bb3d..7d7df3d0b2b9 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -107,9 +107,19 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
 	return NULL;
 }
 
-__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
+bool is_mem_loads_aux_event(struct evsel *leader)
 {
-	return false;
+	struct perf_pmu *pmu = leader->pmu;
+	struct perf_mem_event *e;
+
+	if (!pmu || !pmu->mem_events)
+		return false;
+
+	e = &pmu->mem_events[PERF_MEM_EVENTS__LOAD];
+	if (!e->aux_event)
+		return false;
+
+	return leader->core.attr.config == e->aux_event;
 }
 
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str)
-- 
2.35.1


