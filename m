Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BB807931
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442879AbjLFUNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379518AbjLFUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:13:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A483D51;
        Wed,  6 Dec 2023 12:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701893614; x=1733429614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hgxkrb/i5j4fmZuDpTPgn2mgEJgH4vr5qarhtSzu56M=;
  b=aAx8EBPK+yTF+xSI2X4sXXzmpc/QWvLR0WJDV9tnVdyTrqg1SuR7/H9U
   6ambCMdD4+fhQ+WIvp8IXYCYD6FFKDaE+vTv3KiSfFxDe1Lwd+7Im014c
   NFMuEOecsd/VjdgEHmq3INbCU//ODaYVHO63PKP9hC8PQuC/XkcD4k5Yx
   dS6bv+YphfbQh+At4mfoENCw2j2DCBfZ02bol2hDTij22vCIMgFJezy5/
   zcZOYZ7+GLR1XGIMJMSgQYI155Ezi2KK9inXWbWnEJB6i+Ywh/OOHFLU/
   NhkwCw6bfP9nrKCqE4Yq5+U+/TT+EtY1X0Dn/bNZlwkmw/1YoVdKisDhQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458445540"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="458445540"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944766667"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944766667"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2023 12:13:31 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/6] perf mem: Add mem_events into the supported perf_pmu
Date:   Wed,  6 Dec 2023 12:13:19 -0800
Message-Id: <20231206201324.184059-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231206201324.184059-1-kan.liang@linux.intel.com>
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/arm64/util/mem-events.c | 4 ++--
 tools/perf/arch/arm64/util/mem-events.h | 7 +++++++
 tools/perf/arch/arm64/util/pmu.c        | 6 ++++++
 tools/perf/arch/s390/util/pmu.c         | 3 +++
 tools/perf/arch/x86/util/mem-events.c   | 4 ++--
 tools/perf/arch/x86/util/mem-events.h   | 9 +++++++++
 tools/perf/arch/x86/util/pmu.c          | 7 +++++++
 tools/perf/util/mem-events.c            | 2 +-
 tools/perf/util/mem-events.h            | 1 +
 tools/perf/util/pmu.c                   | 4 +++-
 tools/perf/util/pmu.h                   | 7 +++++++
 11 files changed, 48 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.h
 create mode 100644 tools/perf/arch/x86/util/mem-events.h

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index 3bcc5c7035c2..aaa4804922b4 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -4,7 +4,7 @@
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
-static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
 	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
 	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
 	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
@@ -17,7 +17,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
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
diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 2a4eab2d160e..69673fcf4a61 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -8,6 +8,12 @@
 #include <api/fs/fs.h>
 #include <math.h>
 
+void perf_pmu__arch_init(struct perf_pmu *pmu)
+{
+	if (strcmp(pmu->name, "arm_spe_0"))
+		pmu->mem_events = perf_mem_events_arm;
+}
+
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
 	struct perf_pmu *pmu;
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
index 469555ae9b3c..7e69f4f2e363 100644
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
+		if (strcmp(pmu->name, "ibs_op"))
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

