Return-Path: <linux-kernel+bounces-35931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023AA8398E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861D11F2ABCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617F1292E2;
	Tue, 23 Jan 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhvk5Nz+"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28D85C6B;
	Tue, 23 Jan 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035876; cv=none; b=DXPAFOkKqDpjgC6bg8DuqI6dl2++m+/WT7J2/wWfHYsgC5g+5wf6wmfvs2B4Y22+BQ4CKkpgV0UAa9U+6iVItoOp21ZK3EWcyDK1ghYZI3BZgK+v4BtJf1BAGQv+dhUjQvchrM7IIiKfs36EBvVOVxvmxF9MYcuE1lsbrG4DSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035876; c=relaxed/simple;
	bh=WBpmbQn2o+wuAH6Q6mTO5VuFIQZP/+Zpmvqpk8Y/oh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Osyc/a7OqPIz+9KcSZz2jfdJNzwtmvBXMbDJGuIYObuCdFfA75y6vtpBBtk2dG8JHwj0ucjKtIMut0d86qVL6kWSpbR0+7y4F8tWAkpMEo7nBpHf1+rj0Y2g8CKmswE+slzD4eCuqPmO8mBGnXvy+v3x4w4V7vzvvHsVzyysuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhvk5Nz+; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035874; x=1737571874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WBpmbQn2o+wuAH6Q6mTO5VuFIQZP/+Zpmvqpk8Y/oh4=;
  b=bhvk5Nz+Yhz57BvfRkHr6BOxW6VITExST+gPbuqPNhL9cSUN9tqVl3Ta
   jVjENyh1LRgyLoYvy1czAzyE/TLYY3X4Q8GZ2sUMCmQ47T/UbfORlydof
   rPoGMj3tFERuEYEIZneL3eOwSrzuwoBnwboQTSEZx84uHmYjcffstJwoJ
   XpZLCwmzWx4cl+pkvZFwIp7pw7N3MAhlxW/r6wZFmoUKNb2aTQDhUYawX
   MhSluzqmZOfjb2R4EwwTldCbAMB6AGoEvv9TDJIHjFXWHDnNom9gXRlzz
   OZ3EL246K4tJ9lPufy4ZQHCGUUki6Nv3ZRQf1sb10a+11V+8fDdABSXL+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400487493"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400487493"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1764055"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 10:51:14 -0800
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
Subject: [PATCH V4 4/7] perf mem: Clean up perf_mem_event__supported()
Date: Tue, 23 Jan 2024 10:50:33 -0800
Message-Id: <20240123185036.3461837-5-kan.liang@linux.intel.com>
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
Tested-by: Leo Yan <leo.yan@linaro.org>
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
index 9140cdb1bbfb..765d4a054b0a 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -3,10 +3,10 @@
 #include "util/mem-events.h"
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


