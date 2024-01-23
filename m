Return-Path: <linux-kernel+bounces-35928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A2E8398E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98B41C2475D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA47612837C;
	Tue, 23 Jan 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COQc5zGn"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1E481DC;
	Tue, 23 Jan 2024 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035874; cv=none; b=Ivjl7d/7czV0VrLsYM4KpeYTXAml2Gd9u11jcIX6hIWaKbjh/bOcgr0FzCFmSQk1bhHlqDXXuzFDTmXHIF1UohHwu/J6mQt7NgNsGosqXFdRe3vnCOMrb02VNl6SvjWlur1rz3Mjs/jboFByFB9DD1/35425nnBZDjZFw1MQADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035874; c=relaxed/simple;
	bh=bczC8A0hQ/gAAjL9hVQx1yHdULUKlfb9gniprw4vb0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szmUQpRfGrcgi2pWs+FVxKW0fSuyzIaMgjt17EbVnrI0ewVCbKyP+q7n0rC9kb8lUFBTnq0jqEdSzvAskXGgb1dfqWsQDtNerJ4+cO8O75DI9mXXEyDphz4zq4vSjNjkkPHQDNO1dS6oELoVu6zos4hou3NvXhZmAUSm5CWSHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COQc5zGn; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035872; x=1737571872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bczC8A0hQ/gAAjL9hVQx1yHdULUKlfb9gniprw4vb0U=;
  b=COQc5zGnLoEG33B9d1SChRgyS25T//OiXNew8xcPh0lPrZ5YFDxMJ993
   gFD9fPt+JxEgPXoKa3/k0hm7E3bXnH06SNsUC0sLkhJdX1X/jZRyoLoO6
   ltntCWh/mW0W0HcuQG6P41AciS4NRDi3h11J/nqjmpxhmGeSx2xuQdJkf
   ErzsoVFvx66pTkCGkf6gyXV3HMf6x98rOcOX0IbRO5RuRuYooGoFNK0VL
   Dg2q31SzrZxS1jG+GszNUdefzDdX54jnyx78nfMMVI0akelFSE7CuQodA
   nmuc+DDpjU1XjUlh77YUML1Mk/ySCAc+SGHiGdJih6JUv0qqWuTgde11w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400487447"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400487447"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:51:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1764016"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 10:51:11 -0800
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
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH V4 1/7] perf mem: Add mem_events into the supported perf_pmu
Date: Tue, 23 Jan 2024 10:50:30 -0800
Message-Id: <20240123185036.3461837-2-kan.liang@linux.intel.com>
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

With the mem_events, perf doesn't need to read sysfs for each PMU to
find the mem-events-supported PMU. The patch also makes it possible to
clean up the related __weak functions later.

The patch is only to add the mem_events into the perf_pmu for all ARCHs.
It will be used in the later cleanup patches.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Kajol Jain <kjain@linux.ibm.com>
Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/arm/util/pmu.c          | 3 +++
 tools/perf/arch/arm64/util/mem-events.c | 7 ++++---
 tools/perf/arch/arm64/util/mem-events.h | 7 +++++++
 tools/perf/arch/x86/util/mem-events.c   | 4 ++--
 tools/perf/arch/x86/util/mem-events.h   | 9 +++++++++
 tools/perf/arch/x86/util/pmu.c          | 7 +++++++
 tools/perf/util/mem-events.c            | 2 +-
 tools/perf/util/mem-events.h            | 1 +
 tools/perf/util/pmu.c                   | 4 +++-
 tools/perf/util/pmu.h                   | 7 +++++++
 10 files changed, 44 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.h
 create mode 100644 tools/perf/arch/x86/util/mem-events.h

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 7f3af3b97f3b..8b7cb68ba1a8 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -13,6 +13,7 @@
 #include "hisi-ptt.h"
 #include "../../../util/pmu.h"
 #include "../../../util/cs-etm.h"
+#include "../../arm64/util/mem-events.h"
 
 void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 {
@@ -26,6 +27,8 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 		pmu->selectable = true;
 		pmu->is_uncore = false;
 		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
+		if (!strcmp(pmu->name, "arm_spe_0"))
+			pmu->mem_events = perf_mem_events_arm;
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
 #endif
diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index 3bcc5c7035c2..edf8207f7812 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "map_symbol.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
 #include "mem-events.h"
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
-static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
 	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
 	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
 	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
@@ -17,7 +18,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
 	if (i >= PERF_MEM_EVENTS__MAX)
 		return NULL;
 
-	return &perf_mem_events[i];
+	return &perf_mem_events_arm[i];
 }
 
 const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
diff --git a/tools/perf/arch/arm64/util/mem-events.h b/tools/perf/arch/arm64/util/mem-events.h
new file mode 100644
index 000000000000..5fc50be4be38
--- /dev/null
+++ b/tools/perf/arch/arm64/util/mem-events.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARM64_MEM_EVENTS_H
+#define _ARM64_MEM_EVENTS_H
+
+extern struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX];
+
+#endif /* _ARM64_MEM_EVENTS_H */
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 191b372f9a2d..2b81d229982c 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -16,13 +16,13 @@ static char mem_stores_name[100];
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
-static struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
+struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
 	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
 	E(NULL,			NULL,				NULL),
 };
 
-static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
+struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL),
 	E(NULL,		NULL,		NULL),
 	E("mem-ldst",	"ibs_op//",	"ibs_op"),
diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
new file mode 100644
index 000000000000..3959e427f482
--- /dev/null
+++ b/tools/perf/arch/x86/util/mem-events.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_MEM_EVENTS_H
+#define _X86_MEM_EVENTS_H
+
+extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
+
+extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
+
+#endif /* _X86_MEM_EVENTS_H */
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 469555ae9b3c..cd22e80e5657 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -15,6 +15,7 @@
 #include "../../../util/pmu.h"
 #include "../../../util/fncache.h"
 #include "../../../util/pmus.h"
+#include "mem-events.h"
 #include "env.h"
 
 void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
@@ -30,6 +31,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 		pmu->selectable = true;
 	}
 #endif
+
+	if (x86__is_amd_cpu()) {
+		if (!strcmp(pmu->name, "ibs_op"))
+			pmu->mem_events = perf_mem_events_amd;
+	} else if (pmu->is_core)
+		pmu->mem_events = perf_mem_events_intel;
 }
 
 int perf_pmus__num_mem_pmus(void)
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 3a2e3687878c..0a8f415f5efe 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -19,7 +19,7 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
-static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
 	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
 	E(NULL,			NULL,				NULL),
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index b40ad6ea93fc..8c5694b2d0b0 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -34,6 +34,7 @@ enum {
 };
 
 extern unsigned int perf_mem_events__loads_ldlat;
+extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 
 int perf_mem_events__parse(const char *str);
 int perf_mem_events__init(void);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3c9609944a2f..3d4373b8ab63 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -986,8 +986,10 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
 }
 
 void __weak
-perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
+perf_pmu__arch_init(struct perf_pmu *pmu)
 {
+	if (pmu->is_core)
+		pmu->mem_events = perf_mem_events;
 }
 
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 424c3fee0949..e35d985206db 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -10,6 +10,8 @@
 #include <stdio.h>
 #include "parse-events.h"
 #include "pmu-events/pmu-events.h"
+#include "map_symbol.h"
+#include "mem-events.h"
 
 struct evsel_config_term;
 struct perf_cpu_map;
@@ -162,6 +164,11 @@ struct perf_pmu {
 		 */
 		bool exclude_guest;
 	} missing_features;
+
+	/**
+	 * @mem_events: List of the supported mem events
+	 */
+	struct perf_mem_event *mem_events;
 };
 
 /** @perf_pmu__fake: A special global PMU used for testing. */
-- 
2.35.1


