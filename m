Return-Path: <linux-kernel+bounces-35933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7008398E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD950B2B34E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D73129A8D;
	Tue, 23 Jan 2024 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8n9BBmN"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E0128382;
	Tue, 23 Jan 2024 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035878; cv=none; b=VFMC0l1EMo9Kova3Lb7+PVkSJLJxeFFHYNVD8Ti8Rr2Vnia1ZcZSPlwg1YO8+5Wpt+H+TP6GsgQlsRvpiwnI6F/ZZ8l0TSnOzR6iyKnJqUSEcnjwd7CvSLcpyB4DEPGg/lZ1DZUI8e21cfQwpoymK+Lh0SCOAB99KbTzXsgHbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035878; c=relaxed/simple;
	bh=Yex1IJqQ8z0Qfm1RLKP0nsQ0sLAj6quPmOvsbt09/Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlVUhYnThgQOniC50A4GvaHiaH33ZQj/QzPTo+ryYhtosh6BqSu9kUtPb7+0KAKP/IZzx8F8JN3n3ZNyWRA36o0Sue8JbDQFQ01cjNzhL8JQ9DSdP/LLUBPxBGb8LuXO7APNiW9BMCl/669jEZdAMUiI0fjK/sNEFb/YexRncUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8n9BBmN; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035876; x=1737571876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yex1IJqQ8z0Qfm1RLKP0nsQ0sLAj6quPmOvsbt09/Uk=;
  b=Z8n9BBmNFxrM+7MDSsBHZ9qK7NO0YGRbG2KTKReIwxbcjzVjSHZ/D0JY
   SsrICUw6SDFEpERPWeblWfLOIDRoJAfBJ9ZHxMzerLsr/sGbgyFmVk2Ex
   +AyX350LjUXWU/PSY7NgzJQkorIfuS5XdhWz3m0HlAWEOdeY9boGRucWk
   X0fIhCVEGI5kkQfGzDEwIbxVoLCpSi+RMFsRBquro7nse168p5cEldb66
   e/4DrVrczaFURc9mgl8nrE4jANmGiFSaH4A9kiJG8Udl8QTeCPX/rcMZj
   OJS3yHGd7HfNq14GzzxC1hmBQEiRA1IEUt+auKaXO6npO+8CWv1Ee/DjQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400487519"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400487519"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:51:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1764080"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 10:51:15 -0800
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
Subject: [PATCH V4 6/7] perf mem: Clean up perf_mem_events__record_args()
Date: Tue, 23 Jan 2024 10:50:35 -0800
Message-Id: <20240123185036.3461837-7-kan.liang@linux.intel.com>
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

The current code iterates all memory PMUs. It doesn't matter if the
system has only one memory PMU or multiple PMUs. The check of
perf_pmus__num_mem_pmus() is not required anymore.

The rec_tmp is not used in c2c and mem. Removing them as well.

Suggested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
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


