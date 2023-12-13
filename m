Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B06811F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjLMTx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442527AbjLMTxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:53:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97762188;
        Wed, 13 Dec 2023 11:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497147; x=1734033147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+r6jgbLFvIcWvI4qWiCgNJQ8zB50pDocw0Vw9E2kfy8=;
  b=frGjTwSl/LvYOFqIQqHj3erl5sesRF9XeKHSfOuowXSvr8mylGDwGd7F
   RfG72cvlbKHKXtyMCOqnLZrkjNWLmQvuzjz4/D9mgUtDiVfmTDKs3mOun
   qlT/ebobn5zX1SqDVvEfO6fN2LE1tPpnzVwCjl62qUL4qdj7ML/x0H9jO
   O+LhVKES98LuCNLtuZuxJGc9yt3vGcLqpw8skRZ4kgH2FxmaThYmlvWm/
   G34oJMuVdrFysY/MNrgT0OCEPq9jAXvbraewV+za1tG5ecTYCrcgoKmQt
   2MMQKYC+4ZlTgAvuTz0ZNkLd1Y4MTn6cbU2BNbWPvyN+DdOz8Rz4vsVFB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8412923"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8412923"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917772569"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="917772569"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2023 11:52:06 -0800
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
Subject: [PATCH V3 4/7] perf mem: Clean up perf_mem_event__supported()
Date:   Wed, 13 Dec 2023 11:51:51 -0800
Message-Id: <20231213195154.1085945-5-kan.liang@linux.intel.com>
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

For some ARCHs, e.g., ARM and AMD, to get the availability of the
mem-events, perf checks the existence of a specific PMU. For the other
ARCHs, e.g., Intel and Power, perf has to check the existence of some
specific events.

The current perf only iterates the mem-events-supported PMUs. It's not
required to check the existence of a specific PMU anymore.

Rename sysfs_name to event_name, which stores the specific mem-events.
Perf only needs to check those events for the availability of the
mem-events.

Rename perf_mem_event__supported to perf_pmu__mem_events_supported.

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/arm64/util/mem-events.c   |  8 ++++----
 tools/perf/arch/powerpc/util/mem-events.c |  8 ++++----
 tools/perf/arch/x86/util/mem-events.c     | 20 ++++++++++----------
 tools/perf/util/mem-events.c              | 22 ++++++++++++----------
 tools/perf/util/mem-events.h              |  2 +-
 5 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index 96460c46640a..9f8da7937255 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -3,10 +3,10 @@
 #include "util/mem-events.h"
 #include "mem-events.h"
 
-#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
+#define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
-	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0",	true,	0),
-	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0",	false,	0),
-	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0",	true,	0),
+	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	NULL,	true,	0),
+	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			NULL,	false,	0),
+	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	NULL,	true,	0),
 };
diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
index b7883e38950f..72a6ac2b52f5 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -2,10 +2,10 @@
 #include "map_symbol.h"
 #include "mem-events.h"
 
-#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
+#define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"%s/mem-loads/",	"cpu/events/mem-loads",		false,	0),
-	E("ldlat-stores",	"%s/mem-stores/",	"cpu/events/mem-stores",	false,	0),
-	E(NULL,			NULL,			NULL,				false,	0),
+	E("ldlat-loads",	"%s/mem-loads/",	"mem-loads",	false,	0),
+	E("ldlat-stores",	"%s/mem-stores/",	"mem-stores",	false,	0),
+	E(NULL,			NULL,			NULL,		false,	0),
 };
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index f0e66a0151a0..b776d849fc64 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -9,24 +9,24 @@
 
 #define MEM_LOADS_AUX		0x8203
 
-#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
+#define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads",	true,	0),
-	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores",	false,	0),
-	E(NULL,			NULL,				NULL,			false,	0),
+	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"mem-loads",	true,	0),
+	E("ldlat-stores",	"%s/mem-stores/P",		"mem-stores",	false,	0),
+	E(NULL,			NULL,				NULL,		false,	0),
 };
 
 struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P",	"%s/events/mem-loads",	true,	MEM_LOADS_AUX),
-	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores",	false,	0),
-	E(NULL,			NULL,				NULL,			false,	0),
+	E("ldlat-loads",	"{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P",	"mem-loads",	true,	MEM_LOADS_AUX),
+	E("ldlat-stores",	"%s/mem-stores/P",		"mem-stores",	false,	0),
+	E(NULL,			NULL,				NULL,		false,	0),
 };
 
 struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
-	E(NULL,		NULL,		NULL,		false,	0),
-	E(NULL,		NULL,		NULL,		false,	0),
-	E("mem-ldst",	"%s//",		"ibs_op",	false,	0),
+	E(NULL,		NULL,		NULL,	false,	0),
+	E(NULL,		NULL,		NULL,	false,	0),
+	E("mem-ldst",	"%s//",		NULL,	false,	0),
 };
 
 bool is_mem_loads_aux_event(struct evsel *leader)
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 51e53e33df03..32890848bb3d 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -17,12 +17,12 @@
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
-#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
+#define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads",		true,	0),
-	E("ldlat-stores",	"%s/mem-stores/P",		"cpu/events/mem-stores",	false,	0),
-	E(NULL,			NULL,				NULL,				false,	0),
+	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"mem-loads",	true,	0),
+	E("ldlat-stores",	"%s/mem-stores/P",		"mem-stores",	false,	0),
+	E(NULL,			NULL,				NULL,		false,	0),
 };
 #undef E
 
@@ -151,15 +151,17 @@ int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str)
 	return -1;
 }
 
-static bool perf_mem_event__supported(const char *mnt, struct perf_pmu *pmu,
+static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu,
 				      struct perf_mem_event *e)
 {
-	char sysfs_name[100];
 	char path[PATH_MAX];
 	struct stat st;
 
-	scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
-	scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
+	if (!e->event_name)
+		return true;
+
+	scnprintf(path, PATH_MAX, "%s/devices/%s/events/%s", mnt, pmu->name, e->event_name);
+
 	return !stat(path, &st);
 }
 
@@ -182,7 +184,7 @@ int perf_pmu__mem_events_init(struct perf_pmu *pmu)
 		if (!e->tag)
 			continue;
 
-		e->supported |= perf_mem_event__supported(mnt, pmu, e);
+		e->supported |= perf_pmu__mem_events_supported(mnt, pmu, e);
 		if (e->supported)
 			found = true;
 	}
@@ -234,7 +236,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 			} else {
 				const char *s = perf_pmu__mem_events_name(j, pmu);
 
-				if (!perf_mem_event__supported(mnt, pmu, e))
+				if (!perf_pmu__mem_events_supported(mnt, pmu, e))
 					continue;
 
 				rec_argv[i++] = "-e";
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 79d342768d12..f817a507b106 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -18,7 +18,7 @@ struct perf_mem_event {
 	u32		aux_event;
 	const char	*tag;
 	const char	*name;
-	const char	*sysfs_name;
+	const char	*event_name;
 };
 
 struct mem_info {
-- 
2.35.1

