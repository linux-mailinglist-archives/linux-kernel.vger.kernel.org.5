Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D848B811F80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442594AbjLMTxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379389AbjLMTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:53:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28452D63;
        Wed, 13 Dec 2023 11:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497165; x=1734033165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwcMWELte6aNw2HK3dLsvtM1ULUIBD915KLrOBIIDv4=;
  b=J4wjhkRNBz8fmZLoe80vVB3kn70bLcwUrnVUCgFXXlJRWYNNrODOZUpW
   NqaPQJ7CyrKWWOJyrkA7c6N5HDGedsd4PjUp+3dbUDjkLkykyqAkeY0ai
   ouFGUKIq71vUPIwzVMVdhUduX96aQ0FKg/AG0UBXWCR7m5Oddy3WaOyIB
   TMg/48vy8ka0EeDwO5WNuxyA0VUqfns1jQqeGDqVde2wzCpevTr8D9qBm
   BODba0Krs8HoKflrznL4So9JIXRXdpaVTjgHxd54qiQV842UgU62SNAI2
   g/BnA31lY+pSdjkqzM6Z5YgI7PfWZH7pUvtVxytQVTHlI0+OQ3UFVy1lA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8412949"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8412949"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917772581"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="917772581"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2023 11:52:08 -0800
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
Subject: [PATCH V3 6/7] perf mem: Clean up perf_mem_events__record_args()
Date:   Wed, 13 Dec 2023 11:51:53 -0800
Message-Id: <20231213195154.1085945-7-kan.liang@linux.intel.com>
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

The current code iterates all memory PMUs. It doesn't matter if the
system has only one memory PMU or multiple PMUs. The check of
perf_pmus__num_mem_pmus() is not required anymore.

The rec_tmp is not used in c2c and mem. Removing them as well.

Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-c2c.c     | 15 ++-------------
 tools/perf/builtin-mem.c     | 18 ++----------------
 tools/perf/util/mem-events.c | 34 ++++++++++++----------------------
 tools/perf/util/mem-events.h |  3 +--
 4 files changed, 17 insertions(+), 53 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 838481505e08..3bcb903b6b38 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3245,9 +3245,8 @@ static const char * const *record_mem_usage = __usage_record;
 
 static int perf_c2c__record(int argc, const char **argv)
 {
-	int rec_argc, i = 0, j, rec_tmp_nr = 0;
+	int rec_argc, i = 0, j;
 	const char **rec_argv;
-	char **rec_tmp;
 	int ret;
 	bool all_user = false, all_kernel = false;
 	bool event_set = false;
@@ -3285,12 +3284,6 @@ static int perf_c2c__record(int argc, const char **argv)
 	if (!rec_argv)
 		return -1;
 
-	rec_tmp = calloc(rec_argc + 1, sizeof(char *));
-	if (!rec_tmp) {
-		free(rec_argv);
-		return -1;
-	}
-
 	rec_argv[i++] = "record";
 
 	if (!event_set) {
@@ -3319,7 +3312,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "--phys-data";
 	rec_argv[i++] = "--sample-cpu";
 
-	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &rec_tmp_nr);
+	ret = perf_mem_events__record_args(rec_argv, &i);
 	if (ret)
 		goto out;
 
@@ -3346,10 +3339,6 @@ static int perf_c2c__record(int argc, const char **argv)
 
 	ret = cmd_record(i, rec_argv);
 out:
-	for (i = 0; i < rec_tmp_nr; i++)
-		free(rec_tmp[i]);
-
-	free(rec_tmp);
 	free(rec_argv);
 	return ret;
 }
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index ef64bae77ca7..1d92e309c97c 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -72,10 +72,9 @@ static const char * const *record_mem_usage = __usage;
 
 static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 {
-	int rec_argc, i = 0, j, tmp_nr = 0;
+	int rec_argc, i = 0, j;
 	int start, end;
 	const char **rec_argv;
-	char **rec_tmp;
 	int ret;
 	bool all_user = false, all_kernel = false;
 	struct perf_mem_event *e;
@@ -116,15 +115,6 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (!rec_argv)
 		return -1;
 
-	/*
-	 * Save the allocated event name strings.
-	 */
-	rec_tmp = calloc(rec_argc + 1, sizeof(char *));
-	if (!rec_tmp) {
-		free(rec_argv);
-		return -1;
-	}
-
 	rec_argv[i++] = "record";
 
 	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD_STORE);
@@ -163,7 +153,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		rec_argv[i++] = "--data-page-size";
 
 	start = i;
-	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &tmp_nr);
+	ret = perf_mem_events__record_args(rec_argv, &i);
 	if (ret)
 		goto out;
 	end = i;
@@ -193,10 +183,6 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 	ret = cmd_record(i, rec_argv);
 out:
-	for (i = 0; i < tmp_nr; i++)
-		free(rec_tmp[i]);
-
-	free(rec_tmp);
 	free(rec_argv);
 	return ret;
 }
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 7d7df3d0b2b9..a20611b4fb1b 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -218,14 +218,14 @@ void perf_pmu__mem_events_list(struct perf_pmu *pmu)
 	}
 }
 
-int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
-				 char **rec_tmp, int *tmp_nr)
+int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 {
 	const char *mnt = sysfs__mount();
 	struct perf_pmu *pmu = NULL;
-	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
-
+	int i = *argv_nr;
+	const char *s;
+	char *copy;
 
 	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
 		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
@@ -240,30 +240,20 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 				return -1;
 			}
 
-			if (perf_pmus__num_mem_pmus() == 1) {
-				rec_argv[i++] = "-e";
-				rec_argv[i++] = perf_pmu__mem_events_name(j, pmu);
-			} else {
-				const char *s = perf_pmu__mem_events_name(j, pmu);
-
-				if (!perf_pmu__mem_events_supported(mnt, pmu, e))
-					continue;
+			s = perf_pmu__mem_events_name(j, pmu);
+			if (!s || !perf_pmu__mem_events_supported(mnt, pmu, e))
+				continue;
 
-				rec_argv[i++] = "-e";
-				if (s) {
-					char *copy = strdup(s);
-					if (!copy)
-						return -1;
+			copy = strdup(s);
+			if (!copy)
+				return -1;
 
-					rec_argv[i++] = copy;
-					rec_tmp[k++] = copy;
-				}
-			}
+			rec_argv[i++] = "-e";
+			rec_argv[i++] = copy;
 		}
 	}
 
 	*argv_nr = i;
-	*tmp_nr = k;
 	return 0;
 }
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index f817a507b106..c97cd3caa766 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -46,8 +46,7 @@ struct perf_pmu *perf_mem_events_find_pmu(void);
 bool is_mem_loads_aux_event(struct evsel *leader);
 
 void perf_pmu__mem_events_list(struct perf_pmu *pmu);
-int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
-				 char **rec_tmp, int *tmp_nr);
+int perf_mem_events__record_args(const char **rec_argv, int *argv_nr);
 
 int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
-- 
2.35.1

