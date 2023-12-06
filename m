Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADEF807934
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379521AbjLFUNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442872AbjLFUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:13:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BC3D47;
        Wed,  6 Dec 2023 12:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701893615; x=1733429615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5x40I8ig7vpMobv4oy8YoykaQ1KVI1NUCMksf5v/Ic0=;
  b=IZIS0aVVULqA1q5kD8PlGBrcOVjz4/IiKCzhd3hQuVy6NSQbMyl99Rjg
   Nxtu7MLp2erJROUnlDRwTob24dnVMWcN5UVbGATYE6FLiMY64nzAMlSMr
   kSt7RbgFwTL34B0kpAo6p34+8zNXpAyl2wDsAQilIN6HoEscKTwB9Kt/a
   TiLR50Ps3b4ShPkFx0YSqVktt2ts0VVzIUo9KYpAHhn1eUb5yLj7Pu0tl
   J28mYdInfrKUnaR7JAiwTMUw3JQi4L/MkiJN1Oc0AE9nu2QE1sJHvACVo
   Qw2pl+Gj/ZKKeej7pyckzLGf9g+wDXTqDYlPZp78Mne7dyvfJCrdq366C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458445576"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="458445576"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944766678"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944766678"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2023 12:13:32 -0800
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
Subject: [PATCH 4/6] perf mem: Clean up perf_mem_event__supported()
Date:   Wed,  6 Dec 2023 12:13:22 -0800
Message-Id: <20231206201324.184059-5-kan.liang@linux.intel.com>
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

For some ARCHs, e.g., ARM and AMD, to get the availability of the
mem-events, perf checks the existence of a specific PMU. For the other
ARCHs, e.g., Intel and Power, perf has to check the existence of some
specific events.

The current perf only iterates the mem-events-supported PMUs. It's not
required to check the existence of a specific PMU anymore.

Rename sysfs_name to event_name, which stores the specific mem-events.
Perf only needs to check those events for the availability of the
mem-events.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/arm64/util/mem-events.c   |  8 ++++----
 tools/perf/arch/powerpc/util/mem-events.c |  8 ++++----
 tools/perf/arch/x86/util/mem-events.c     | 20 ++++++++++----------
 tools/perf/util/mem-events.c              | 16 +++++++++-------
 tools/perf/util/mem-events.h              |  2 +-
 5 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index eb2ef84f0fc8..590dddd6b0ab 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -2,10 +2,10 @@
 #include "map_symbol.h"
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
index 3a60cbcd6d8e..9ea9e9a868c4 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -17,12 +17,12 @@
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
-#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
+#define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"%s/mem-loads/,ldlat=%u/P",	"cpu/events/mem-loads",		true,	0),
-	E("ldlat-stores",	"%s/mem-stores/P",		"cpu/events/mem-stores",	false,	0),
-	E(NULL,			NULL,				NULL,				false,	0),
+	E("ldlat-loads",	"%s/mem-loads/,ldlat=%u/P",	"mem-loads",	true,	0),
+	E("ldlat-stores",	"%s/mem-stores/P",		"mem-stores",	false,	0),
+	E(NULL,			NULL,				NULL,		false,	0),
 };
 #undef E
 
@@ -150,12 +150,14 @@ int perf_mem_events__parse(struct perf_pmu *pmu, const char *str)
 static bool perf_mem_event__supported(const char *mnt, struct perf_pmu *pmu,
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
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index d257cf67d6d9..d2875d731da8 100644
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

