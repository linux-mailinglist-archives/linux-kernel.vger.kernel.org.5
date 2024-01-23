Return-Path: <linux-kernel+bounces-35934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849A8398E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD66628F73E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B8F12A14E;
	Tue, 23 Jan 2024 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0ijxKZ+"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E705012839F;
	Tue, 23 Jan 2024 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035878; cv=none; b=j/QqgNKF7yhNtxYNisqQc5agr8x2ADtVSmRmcbJv5TL9BTv0Y0XO826nnRchyxv6+AVW6NvAaMUMS7z0dLJU3/bq+sSJ4aQR1OfbLKcANap8Aa/QgEJRFvDMwKwmu5BCVL6NVTnB14O2vJWnyaf7IT1iZa2FaI7KS2jO/TCklNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035878; c=relaxed/simple;
	bh=nSDXmDpIUCfqz1C9u2rQFplZpafkH1Vmp8Cu8FIf17g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+qQEQuhhmlqj3NXbpqZ1ctsu3m+D3I/ZJrGBKh+UZySEYq3R2vGZxyOO1mMlR0VNJ9EZ7LR2WSsAunnvsWyW0LYr11XSTVh/UVpWik9p+zc9qKSkex+6mhDGFKSW8VR0SVwh4R1eIz8vwh30xwTnDpUpeuwTQl+ubkkAB9kdXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0ijxKZ+; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035877; x=1737571877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nSDXmDpIUCfqz1C9u2rQFplZpafkH1Vmp8Cu8FIf17g=;
  b=B0ijxKZ+3rArlUG+PpnStCLPiq9fYxI/ke5rXfohjS/1tow8PLVr7Q9M
   My+Av7hRbTK+K2j/8U4A7pwcJLltG0wsvMVO0AvLiUM3RPstxn/r3xWMU
   j1zKfZTsoKgMO7MHmQWpdhC/iiVPMh3Zyr8yVda+uafBnCB1JvUPwiqnM
   /LSspsIrnwdojPfEteyzQZcLSeZSuxiBgtxi0vVedCrnw9gk97Djw81EK
   gYyZq79nXhF4KQdCpphu/vmpKmaDVxn0ZpImxR3NNaKz9vChW95UQeR7e
   Tal3gB66N3H1GXUGsb0xVpb30tH7cFXdFgwYdI6rCuojMzw56OhfJayFs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400487532"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400487532"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:51:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1764096"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 10:51:16 -0800
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
Subject: [PATCH V4 7/7] perf mem: Clean up perf_pmus__num_mem_pmus()
Date: Tue, 23 Jan 2024 10:50:36 -0800
Message-Id: <20240123185036.3461837-8-kan.liang@linux.intel.com>
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

The number of mem PMUs can be calculated by searching the
perf_pmus__scan_mem().

Remove the ARCH specific perf_pmus__num_mem_pmus()

Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/pmu.c | 10 ----------
 tools/perf/builtin-c2c.c       |  2 +-
 tools/perf/builtin-mem.c       |  2 +-
 tools/perf/util/mem-events.c   | 14 ++++++++++++++
 tools/perf/util/mem-events.h   |  1 +
 tools/perf/util/pmus.c         |  6 ------
 tools/perf/util/pmus.h         |  1 -
 7 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 0f49ff13cfe2..c3d89d6ba1bf 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -42,13 +42,3 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 			pmu->mem_events = perf_mem_events_intel;
 	}
 }
-
-int perf_pmus__num_mem_pmus(void)
-{
-	/* AMD uses IBS OP pmu and not a core PMU for perf mem/c2c */
-	if (x86__is_amd_cpu())
-		return 1;
-
-	/* Intel uses core pmus for perf mem/c2c */
-	return perf_pmus__num_core_pmus();
-}
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3bcb903b6b38..16b40f5d43db 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3278,7 +3278,7 @@ static int perf_c2c__record(int argc, const char **argv)
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	/* Max number of arguments multiplied by number of PMUs that can support them. */
-	rec_argc = argc + 11 * perf_pmus__num_mem_pmus();
+	rec_argc = argc + 11 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
 
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 1d92e309c97c..5b851e64e4a1 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -106,7 +106,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	/* Max number of arguments multiplied by number of PMUs that can support them. */
-	rec_argc = argc + 9 * perf_pmus__num_mem_pmus();
+	rec_argc = argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
 
 	if (mem->cpu_list)
 		rec_argc += 2;
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index a20611b4fb1b..637cbd4a7bfb 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -62,6 +62,20 @@ struct perf_pmu *perf_mem_events_find_pmu(void)
 	return perf_pmus__scan_mem(NULL);
 }
 
+/**
+ * perf_pmu__mem_events_num_mem_pmus - Get the number of mem PMUs since the given pmu
+ * @pmu: Start pmu. If it's NULL, search the entire PMU list.
+ */
+int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu)
+{
+	int num = 0;
+
+	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL)
+		num++;
+
+	return num;
+}
+
 static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
 {
 	struct perf_mem_event *e;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index c97cd3caa766..15d5f0320d27 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -43,6 +43,7 @@ int perf_pmu__mem_events_init(struct perf_pmu *pmu);
 
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
 struct perf_pmu *perf_mem_events_find_pmu(void);
+int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu);
 bool is_mem_loads_aux_event(struct evsel *leader);
 
 void perf_pmu__mem_events_list(struct perf_pmu *pmu);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index ce4931461741..16505071d362 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -345,12 +345,6 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 	return NULL;
 }
 
-int __weak perf_pmus__num_mem_pmus(void)
-{
-	/* All core PMUs are for mem events. */
-	return perf_pmus__num_core_pmus();
-}
-
 /** Struct for ordering events as output in perf list. */
 struct sevent {
 	/** PMU for event. */
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 4c67153ac257..94d2a08d894b 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -17,7 +17,6 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
-int perf_pmus__num_mem_pmus(void);
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool perf_pmus__have_event(const char *pname, const char *name);
 int perf_pmus__num_core_pmus(void);
-- 
2.35.1


