Return-Path: <linux-kernel+bounces-35930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54E8398E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3850E1C2752B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633B1292E3;
	Tue, 23 Jan 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcRjeB7z"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028685C50;
	Tue, 23 Jan 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035876; cv=none; b=nl+UUhM0WzuS6mCZj9cdQBs3wNOihdUxCviw9lyeRIAu2gTaxOKLKQ4WuNlNDx8p8sKBDH1X3yqJAmGlYGSPa/v5AejsHEHqeM/H1+uRS2U03f5TRcO/ZceN7r/qKTAcY9lHFP9XeDHZCrjNIeVY7iF9/hm3q1KEnr55jDm1Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035876; c=relaxed/simple;
	bh=SJQlsbXUNb8AAy5zbcbaFRhiFxEkXOtw429KEg71IOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9NFkm4sy8bKKSnIvaFSEl3PCecVsK4izCABtwE9Z7bZt1poCgXfAaNMYJ8H9Slsq6eY2OOCDeolZth6uoFtWZiXxfgKA2O8X+M4qlvZYse7NueAYG/Lpcbqoh6Dvi3wpdqZAjEf2ljUQLQ9VC8Rbabk5rSJHCdIkfp4KjjYP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcRjeB7z; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035874; x=1737571874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJQlsbXUNb8AAy5zbcbaFRhiFxEkXOtw429KEg71IOc=;
  b=hcRjeB7zQJL0TPjsj6Ft6WGJbBd/ZcAngwhr1iET7Vz3eCHQPv02VGKm
   Z9590sAxKPKRSDGCqcXzPaKq2sb/poGMLw5p2WavVcci+UiUb2ubU9xAZ
   rtQq8sD9rBjR+neTCR/7xJur3t/95ifQI6mXFiJf+LJRi7YXpJ9ezbEhG
   aEdCfGAbqADgzdxIblP2WIFLwpNtYoolvc+3dKWHmx7gmo/KLF9vbyQoA
   v8TbH4DFffd9wUYoDr43CVzMS2lwOobWjcG0PPRYyrKDlqHMab0ax6PBK
   UksncVkHf6RdwdlucgCS/03Wmufi1GEe+2sTj9U0YyvhscfPEq3O0g1Xo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400487478"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400487478"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:51:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1764044"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 10:51:13 -0800
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
Subject: [PATCH V4 3/7] perf mem: Clean up perf_mem_events__name()
Date: Tue, 23 Jan 2024 10:50:32 -0800
Message-Id: <20240123185036.3461837-4-kan.liang@linux.intel.com>
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

Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
one.

The mem_load events may have a different format. Add ldlat and aux_event
in the struct perf_mem_event to indicate the format and the extra aux
event.

Add perf_mem_events_intel_aux[] to support the extra mem_load_aux event.

Rename perf_mem_events__name to perf_pmu__mem_events_name.

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/arm64/util/mem-events.c   | 26 ++-------
 tools/perf/arch/powerpc/util/Build        |  1 +
 tools/perf/arch/powerpc/util/mem-events.c | 16 +++---
 tools/perf/arch/powerpc/util/mem-events.h |  7 +++
 tools/perf/arch/powerpc/util/pmu.c        | 12 ++++
 tools/perf/arch/x86/util/mem-events.c     | 70 +++++------------------
 tools/perf/arch/x86/util/mem-events.h     |  1 +
 tools/perf/arch/x86/util/pmu.c            |  8 ++-
 tools/perf/util/mem-events.c              | 60 +++++++++++++------
 tools/perf/util/mem-events.h              |  3 +-
 10 files changed, 97 insertions(+), 107 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/pmu.c

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index d3e69a520c2b..96460c46640a 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -3,28 +3,10 @@
 #include "util/mem-events.h"
 #include "mem-events.h"
 
-#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
+#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
-	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
-	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
-	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
+	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0",	true,	0),
+	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0",	false,	0),
+	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0",	true,	0),
 };
-
-static char mem_ev_name[100];
-
-const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
-{
-	struct perf_mem_event *e = &perf_mem_events_arm[i];
-
-	if (i >= PERF_MEM_EVENTS__MAX)
-		return NULL;
-
-	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE)
-		scnprintf(mem_ev_name, sizeof(mem_ev_name),
-			  e->name, perf_mem_events__loads_ldlat);
-	else /* PERF_MEM_EVENTS__STORE */
-		scnprintf(mem_ev_name, sizeof(mem_ev_name), e->name);
-
-	return mem_ev_name;
-}
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 9889245c555c..1d323f3a3322 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -2,6 +2,7 @@ perf-y += header.o
 perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-y += perf_regs.o
 perf-y += mem-events.o
+perf-y += pmu.o
 perf-y += sym-handling.o
 perf-y += evsel.o
 perf-y += event.o
diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
index 78b986e5268d..9140cdb1bbfb 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "map_symbol.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
 #include "mem-events.h"
 
-/* PowerPC does not support 'ldlat' parameter. */
-const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
-{
-	if (i == PERF_MEM_EVENTS__LOAD)
-		return "cpu/mem-loads/";
+#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
 
-	return "cpu/mem-stores/";
-}
+struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX] = {
+	E("ldlat-loads",	"%s/mem-loads/",	"cpu/events/mem-loads",		false,	0),
+	E("ldlat-stores",	"%s/mem-stores/",	"cpu/events/mem-stores",	false,	0),
+	E(NULL,			NULL,			NULL,				false,	0),
+};
diff --git a/tools/perf/arch/powerpc/util/mem-events.h b/tools/perf/arch/powerpc/util/mem-events.h
new file mode 100644
index 000000000000..6acc3d1b6873
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/mem-events.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _POWER_MEM_EVENTS_H
+#define _POWER_MEM_EVENTS_H
+
+extern struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX];
+
+#endif /* _POWER_MEM_EVENTS_H */
diff --git a/tools/perf/arch/powerpc/util/pmu.c b/tools/perf/arch/powerpc/util/pmu.c
new file mode 100644
index 000000000000..554675deef7b
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/pmu.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <string.h>
+
+#include "../../../util/pmu.h"
+#include "mem-events.h"
+
+void perf_pmu__arch_init(struct perf_pmu *pmu)
+{
+	if (pmu->is_core)
+		pmu->mem_events = perf_mem_events_power;
+}
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 5fb41d50118d..f0e66a0151a0 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -7,25 +7,26 @@
 #include "linux/string.h"
 #include "env.h"
 
-static char mem_loads_name[100];
-static bool mem_loads_name__init;
-static char mem_stores_name[100];
-
 #define MEM_LOADS_AUX		0x8203
-#define MEM_LOADS_AUX_NAME     "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P"
 
-#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
+#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
-	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
-	E(NULL,			NULL,				NULL),
+	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads",	true,	0),
+	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores",	false,	0),
+	E(NULL,			NULL,				NULL,			false,	0),
+};
+
+struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
+	E("ldlat-loads",	"{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P",	"%s/events/mem-loads",	true,	MEM_LOADS_AUX),
+	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores",	false,	0),
+	E(NULL,			NULL,				NULL,			false,	0),
 };
 
 struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
-	E(NULL,		NULL,		NULL),
-	E(NULL,		NULL,		NULL),
-	E("mem-ldst",	"ibs_op//",	"ibs_op"),
+	E(NULL,		NULL,		NULL,		false,	0),
+	E(NULL,		NULL,		NULL,		false,	0),
+	E("mem-ldst",	"%s//",		"ibs_op",	false,	0),
 };
 
 bool is_mem_loads_aux_event(struct evsel *leader)
@@ -40,48 +41,3 @@ bool is_mem_loads_aux_event(struct evsel *leader)
 
 	return leader->core.attr.config == MEM_LOADS_AUX;
 }
-
-const char *perf_mem_events__name(int i, const char *pmu_name)
-{
-	struct perf_mem_event *e;
-
-	if (x86__is_amd_cpu())
-		e = &perf_mem_events_amd[i];
-	else
-		e = &perf_mem_events_intel[i];
-
-	if (!e)
-		return NULL;
-
-	if (i == PERF_MEM_EVENTS__LOAD) {
-		if (mem_loads_name__init && !pmu_name)
-			return mem_loads_name;
-
-		if (!pmu_name) {
-			mem_loads_name__init = true;
-			pmu_name = "cpu";
-		}
-
-		if (perf_pmus__have_event(pmu_name, "mem-loads-aux")) {
-			scnprintf(mem_loads_name, sizeof(mem_loads_name),
-				  MEM_LOADS_AUX_NAME, pmu_name, pmu_name,
-				  perf_mem_events__loads_ldlat);
-		} else {
-			scnprintf(mem_loads_name, sizeof(mem_loads_name),
-				  e->name, pmu_name,
-				  perf_mem_events__loads_ldlat);
-		}
-		return mem_loads_name;
-	}
-
-	if (i == PERF_MEM_EVENTS__STORE) {
-		if (!pmu_name)
-			pmu_name = "cpu";
-
-		scnprintf(mem_stores_name, sizeof(mem_stores_name),
-			  e->name, pmu_name);
-		return mem_stores_name;
-	}
-
-	return e->name;
-}
diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
index 3959e427f482..f55c8d3b7d59 100644
--- a/tools/perf/arch/x86/util/mem-events.h
+++ b/tools/perf/arch/x86/util/mem-events.h
@@ -3,6 +3,7 @@
 #define _X86_MEM_EVENTS_H
 
 extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
 
 extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
 
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index cd22e80e5657..0f49ff13cfe2 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -35,8 +35,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 	if (x86__is_amd_cpu()) {
 		if (!strcmp(pmu->name, "ibs_op"))
 			pmu->mem_events = perf_mem_events_amd;
-	} else if (pmu->is_core)
-		pmu->mem_events = perf_mem_events_intel;
+	} else if (pmu->is_core) {
+		if (perf_pmu__have_event(pmu, "mem-loads-aux"))
+			pmu->mem_events = perf_mem_events_intel_aux;
+		else
+			pmu->mem_events = perf_mem_events_intel;
+	}
 }
 
 int perf_pmus__num_mem_pmus(void)
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 27a33dc44964..51e53e33df03 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -17,17 +17,17 @@
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
-#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
+#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
-	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
-	E(NULL,			NULL,				NULL),
+	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads",		true,	0),
+	E("ldlat-stores",	"%s/mem-stores/P",		"cpu/events/mem-stores",	false,	0),
+	E(NULL,			NULL,				NULL,				false,	0),
 };
 #undef E
 
 static char mem_loads_name[100];
-static bool mem_loads_name__init;
+static char mem_stores_name[100];
 
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i)
 {
@@ -62,23 +62,49 @@ struct perf_pmu *perf_mem_events_find_pmu(void)
 	return perf_pmus__scan_mem(NULL);
 }
 
-const char * __weak perf_mem_events__name(int i, const char *pmu_name  __maybe_unused)
+static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
 {
-	struct perf_mem_event *e = &perf_mem_events[i];
+	struct perf_mem_event *e;
 
+	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
+		return NULL;
+
+	e = &pmu->mem_events[i];
 	if (!e)
 		return NULL;
 
-	if (i == PERF_MEM_EVENTS__LOAD) {
-		if (!mem_loads_name__init) {
-			mem_loads_name__init = true;
-			scnprintf(mem_loads_name, sizeof(mem_loads_name),
-				  e->name, perf_mem_events__loads_ldlat);
+	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
+		if (e->ldlat) {
+			if (!e->aux_event) {
+				/* ARM and Most of Intel */
+				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+					  e->name, pmu->name,
+					  perf_mem_events__loads_ldlat);
+			} else {
+				/* Intel with mem-loads-aux event */
+				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+					  e->name, pmu->name, pmu->name,
+					  perf_mem_events__loads_ldlat);
+			}
+		} else {
+			if (!e->aux_event) {
+				/* AMD and POWER */
+				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+					  e->name, pmu->name);
+			} else
+				return NULL;
 		}
+
 		return mem_loads_name;
 	}
 
-	return e->name;
+	if (i == PERF_MEM_EVENTS__STORE) {
+		scnprintf(mem_stores_name, sizeof(mem_stores_name),
+			  e->name, pmu->name);
+		return mem_stores_name;
+	}
+
+	return NULL;
 }
 
 __weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
@@ -175,7 +201,7 @@ void perf_pmu__mem_events_list(struct perf_pmu *pmu)
 			e->tag ? 13 : 0,
 			e->tag ? : "",
 			e->tag && verbose > 0 ? 25 : 0,
-			e->tag && verbose > 0 ? perf_mem_events__name(j, NULL) : "",
+			e->tag && verbose > 0 ? perf_pmu__mem_events_name(j, pmu) : "",
 			e->supported ? ": available\n" : "");
 	}
 }
@@ -198,15 +224,15 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 
 			if (!e->supported) {
 				pr_err("failed: event '%s' not supported\n",
-					perf_mem_events__name(j, pmu->name));
+					perf_pmu__mem_events_name(j, pmu));
 				return -1;
 			}
 
 			if (perf_pmus__num_mem_pmus() == 1) {
 				rec_argv[i++] = "-e";
-				rec_argv[i++] = perf_mem_events__name(j, NULL);
+				rec_argv[i++] = perf_pmu__mem_events_name(j, pmu);
 			} else {
-				const char *s = perf_mem_events__name(j, pmu->name);
+				const char *s = perf_pmu__mem_events_name(j, pmu);
 
 				if (!perf_mem_event__supported(mnt, pmu, e))
 					continue;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 0ad301a2e424..79d342768d12 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -14,6 +14,8 @@
 struct perf_mem_event {
 	bool		record;
 	bool		supported;
+	bool		ldlat;
+	u32		aux_event;
 	const char	*tag;
 	const char	*name;
 	const char	*sysfs_name;
@@ -39,7 +41,6 @@ extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
 int perf_pmu__mem_events_init(struct perf_pmu *pmu);
 
-const char *perf_mem_events__name(int i, const char *pmu_name);
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
 struct perf_pmu *perf_mem_events_find_pmu(void);
 bool is_mem_loads_aux_event(struct evsel *leader);
-- 
2.35.1


