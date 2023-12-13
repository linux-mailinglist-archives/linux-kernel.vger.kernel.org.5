Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E279811F76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442261AbjLMTwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjLMTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:52:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A0C1997;
        Wed, 13 Dec 2023 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497128; x=1734033128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SpAuD5FfbNjLNWDRd+6avwBRAD+LlWp7sWQNhiI/U6I=;
  b=XRgo6F3eZvEfqu6+yCMY5oxVj4y3BNq/yOipTFljulVgjDN8oGfcoEE5
   YYgW/lyHZ9Rt1dR79aEZoBlrREaFWytIEKWhAM44ZKKIAdvB8aWVHgaLR
   mWOTiIRSAmSty7bsRBjnu6aPq3oknALh7F/zjyyJrFXAT9e6s8OG8v91h
   8a/FAKMvmRs8ycTQuu16fcO7iYXLn1aIGKZQ4kL/lWbLyr9p/rfPxmYkb
   XKloEzkjTjcShoXS2rchnCW3Pz/f3mS6bNUCnG8fsBDmWDuK7rsTI38Z4
   no+edYAMI6nW3mGjNG+fUL1b9fI6/lEAHRKePLx7k0MvZXLdO/qwrggId
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8412884"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8412884"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917772552"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="917772552"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2023 11:52:05 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/7] perf mem: Add mem_events into the supported perf_pmu
Date:   Wed, 13 Dec 2023 11:51:48 -0800
Message-Id: <20231213195154.1085945-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231213195154.1085945-1-kan.liang@linux.intel.com>
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the mem_events, perf doesn't need to read sysfs for each PMU to
find the mem-events-supported PMU. The patch also makes it possible to
clean up the related __weak functions later.

The patch is only to add the mem_events into the perf_pmu for all ARCHs.
It will be used in the later cleanup patches.

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/arm/util/pmu.c          | 3 +++
 tools/perf/arch/arm64/util/mem-events.c | 7 ++++---
 tools/perf/arch/arm64/util/mem-events.h | 7 +++++++
 tools/perf/arch/s390/util/pmu.c         | 3 +++
 tools/perf/arch/x86/util/mem-events.c   | 4 ++--
 tools/perf/arch/x86/util/mem-events.h   | 9 +++++++++
 tools/perf/arch/x86/util/pmu.c          | 7 +++++++
 tools/perf/util/mem-events.c            | 2 +-
 tools/perf/util/mem-events.h            | 1 +
 tools/perf/util/pmu.c                   | 4 +++-
 tools/perf/util/pmu.h                   | 7 +++++++
 11 files changed, 47 insertions(+), 7 deletions(-)
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
diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/pmu.c
index 886c30e001fa..225d7dc2379c 100644
--- a/tools/perf/arch/s390/util/pmu.c
+++ b/tools/perf/arch/s390/util/pmu.c
@@ -19,4 +19,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 	    !strcmp(pmu->name, S390_PMUPAI_EXT) ||
 	    !strcmp(pmu->name, S390_PMUCPUM_CF))
 		pmu->selectable = true;
+
+	if (pmu->is_core)
+		pmu->mem_events = perf_mem_events;
 }
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

