Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AEA811F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjLMTxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjLMTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:53:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E4D68;
        Wed, 13 Dec 2023 11:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497166; x=1734033166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3r6W+znWevT5zm8hTkKoHcQtnIrf5IlOIeTi31U9+ic=;
  b=gLFmTrC+/MA7Lsoe5yXIVGJpqhpSJ4elHE4INGah4ungTjNqAjJwYr19
   EHn96zjf/f3sYYXObKLeA/0RPq/lzouTRHDLnChEdZoysxCs5ClZdk8Oo
   RPwFRUKcIdsxYMZJsY7fUYuehRZosmDJ3S+SX1AFhSbARIJTAqhDI0AY9
   +i8sfswH1qGK8gGK43EAVpSrsORyqgR86heFb7I+pG/ECru6DSAbtbTw6
   G+0xozuyhH36KrXGHUF3UULxdmsG22WQ0ZUwL2oXWpTkozkxs8FGoyCM6
   uA4b9R0sJPIt65rVo3gFfHjVK9IfxqNdrM8lQKSr5YFfIHerG0CT4hxIA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8412963"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8412963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917772584"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="917772584"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2023 11:52:09 -0800
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
Subject: [PATCH V3 7/7] perf mem: Clean up perf_pmus__num_mem_pmus()
Date:   Wed, 13 Dec 2023 11:51:54 -0800
Message-Id: <20231213195154.1085945-8-kan.liang@linux.intel.com>
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

The number of mem PMUs can be calculated by searching the
perf_pmus__scan_mem().

Remove the ARCH specific perf_pmus__num_mem_pmus()

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

