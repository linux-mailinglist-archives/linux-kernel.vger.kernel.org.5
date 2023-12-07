Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD86809135
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443669AbjLGTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGTXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:23:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C81706;
        Thu,  7 Dec 2023 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701977038; x=1733513038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rlii+eXynCIygNUvlU86rAOSJdeE1GFsl8ZeqwnFvZs=;
  b=MqtPlmn2/zEQIPykyJKmZ9N6KuhqWt0BUulCGClyGePR07cvLRV/Kyq9
   4wGB/jdS0G2lNttkyAhmo0TWNp35XDNdlyGJVnxK6AMQ4VrMf21q7jff1
   eWNf/nW2oWs4f9yJMZTS3ViUwR+XVyZz77U3B8ry5lDiloOEux8sDuvIM
   1EqMeifVuLOdy7MSL1YvsgiDcxTDRhbQvrime5Wk2JcJTvoKwzyQcFB2H
   eaIByOnWR4zD/I4rTyr1JNs8Np5yoSaMRSKJhhOST17R5IwbOiY9GwDR6
   Y2t+Fc4l5gWW3zho24nvCowedx6Yng/tQ1xC75hUx3EEKYbj2u6JmzFNO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="425431742"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="425431742"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721589159"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721589159"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2023 11:23:56 -0800
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
Subject: [PATCH V2 2/5] perf mem: Clean up perf_mem_events__ptr()
Date:   Thu,  7 Dec 2023 11:23:35 -0800
Message-Id: <20231207192338.400336-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231207192338.400336-1-kan.liang@linux.intel.com>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The mem_events can be retrieved from the struct perf_pmu now. An ARCH
specific perf_mem_events__ptr() is not required anymore. Remove all of
them.

The Intel hybrid has multiple mem-events-supported PMUs. But they share
the same mem_events. Other ARCHs only support one mem-events-supported
PMU. In the configuration, it's good enough to only configure the
mem_events for one PMU. Add perf_mem_events_find_pmu() which returns the
first mem-events-supported PMU.

In the perf_mem_events__init(), the perf_pmus__scan() is not required
anymore. It avoids checking the sysfs for every PMU on the system.

Make the perf_mem_events__record_args() more generic. Remove the
perf_mem_events__print_unsupport_hybrid().

Since pmu is added as a new parameter, rename perf_mem_events__ptr() to
perf_pmu__mem_events_ptr(). Several other functions also do a similar
rename.

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/arm64/util/mem-events.c |  10 +--
 tools/perf/arch/x86/util/mem-events.c   |  18 ++---
 tools/perf/builtin-c2c.c                |  28 +++++--
 tools/perf/builtin-mem.c                |  28 +++++--
 tools/perf/util/mem-events.c            | 103 ++++++++++++------------
 tools/perf/util/mem-events.h            |   9 ++-
 6 files changed, 104 insertions(+), 92 deletions(-)

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index aaa4804922b4..2602e8688727 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -12,17 +12,9 @@ struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
 
 static char mem_ev_name[100];
 
-struct perf_mem_event *perf_mem_events__ptr(int i)
-{
-	if (i >= PERF_MEM_EVENTS__MAX)
-		return NULL;
-
-	return &perf_mem_events_arm[i];
-}
-
 const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
 {
-	struct perf_mem_event *e = perf_mem_events__ptr(i);
+	struct perf_mem_event *e = &perf_mem_events_arm[i];
 
 	if (i >= PERF_MEM_EVENTS__MAX)
 		return NULL;
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 2b81d229982c..5fb41d50118d 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -28,17 +28,6 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E("mem-ldst",	"ibs_op//",	"ibs_op"),
 };
 
-struct perf_mem_event *perf_mem_events__ptr(int i)
-{
-	if (i >= PERF_MEM_EVENTS__MAX)
-		return NULL;
-
-	if (x86__is_amd_cpu())
-		return &perf_mem_events_amd[i];
-
-	return &perf_mem_events_intel[i];
-}
-
 bool is_mem_loads_aux_event(struct evsel *leader)
 {
 	struct perf_pmu *pmu = perf_pmus__find("cpu");
@@ -54,7 +43,12 @@ bool is_mem_loads_aux_event(struct evsel *leader)
 
 const char *perf_mem_events__name(int i, const char *pmu_name)
 {
-	struct perf_mem_event *e = perf_mem_events__ptr(i);
+	struct perf_mem_event *e;
+
+	if (x86__is_amd_cpu())
+		e = &perf_mem_events_amd[i];
+	else
+		e = &perf_mem_events_intel[i];
 
 	if (!e)
 		return NULL;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a4cf9de7a7b5..e5b7dc7a80e3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3215,12 +3215,19 @@ static int parse_record_events(const struct option *opt,
 			       const char *str, int unset __maybe_unused)
 {
 	bool *event_set = (bool *) opt->value;
+	struct perf_pmu *pmu;
+
+	pmu = perf_mem_events_find_pmu();
+	if (!pmu) {
+		pr_err("failed: there is no PMU that supports perf c2c\n");
+		exit(-1);
+	}
 
 	if (!strcmp(str, "list")) {
-		perf_mem_events__list();
+		perf_pmu__mem_events_list(pmu);
 		exit(0);
 	}
-	if (perf_mem_events__parse(str))
+	if (perf_pmu__mem_events_parse(pmu, str))
 		exit(-1);
 
 	*event_set = true;
@@ -3245,6 +3252,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	bool all_user = false, all_kernel = false;
 	bool event_set = false;
 	struct perf_mem_event *e;
+	struct perf_pmu *pmu;
 	struct option options[] = {
 	OPT_CALLBACK('e', "event", &event_set, "event",
 		     "event selector. Use 'perf c2c record -e list' to list available events",
@@ -3256,7 +3264,13 @@ static int perf_c2c__record(int argc, const char **argv)
 	OPT_END()
 	};
 
-	if (perf_mem_events__init()) {
+	pmu = perf_mem_events_find_pmu();
+	if (!pmu) {
+		pr_err("failed: no PMU supports the memory events\n");
+		return -1;
+	}
+
+	if (perf_pmu__mem_events_init(pmu)) {
 		pr_err("failed: memory events not supported\n");
 		return -1;
 	}
@@ -3280,7 +3294,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "record";
 
 	if (!event_set) {
-		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
+		e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD_STORE);
 		/*
 		 * The load and store operations are required, use the event
 		 * PERF_MEM_EVENTS__LOAD_STORE if it is supported.
@@ -3289,15 +3303,15 @@ static int perf_c2c__record(int argc, const char **argv)
 			e->record = true;
 			rec_argv[i++] = "-W";
 		} else {
-			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
 			e->record = true;
 
-			e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__STORE);
 			e->record = true;
 		}
 	}
 
-	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
 	if (e->record)
 		rec_argv[i++] = "-W";
 
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 51499c20da01..ef64bae77ca7 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -43,12 +43,19 @@ static int parse_record_events(const struct option *opt,
 			       const char *str, int unset __maybe_unused)
 {
 	struct perf_mem *mem = *(struct perf_mem **)opt->value;
+	struct perf_pmu *pmu;
+
+	pmu = perf_mem_events_find_pmu();
+	if (!pmu) {
+		pr_err("failed: there is no PMU that supports perf mem\n");
+		exit(-1);
+	}
 
 	if (!strcmp(str, "list")) {
-		perf_mem_events__list();
+		perf_pmu__mem_events_list(pmu);
 		exit(0);
 	}
-	if (perf_mem_events__parse(str))
+	if (perf_pmu__mem_events_parse(pmu, str))
 		exit(-1);
 
 	mem->operation = 0;
@@ -72,6 +79,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	int ret;
 	bool all_user = false, all_kernel = false;
 	struct perf_mem_event *e;
+	struct perf_pmu *pmu;
 	struct option options[] = {
 	OPT_CALLBACK('e', "event", &mem, "event",
 		     "event selector. use 'perf mem record -e list' to list available events",
@@ -84,7 +92,13 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	OPT_END()
 	};
 
-	if (perf_mem_events__init()) {
+	pmu = perf_mem_events_find_pmu();
+	if (!pmu) {
+		pr_err("failed: no PMU supports the memory events\n");
+		return -1;
+	}
+
+	if (perf_pmu__mem_events_init(pmu)) {
 		pr_err("failed: memory events not supported\n");
 		return -1;
 	}
@@ -113,7 +127,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 	rec_argv[i++] = "record";
 
-	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
+	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD_STORE);
 
 	/*
 	 * The load and store operations are required, use the event
@@ -126,17 +140,17 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		rec_argv[i++] = "-W";
 	} else {
 		if (mem->operation & MEM_OPERATION_LOAD) {
-			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
 			e->record = true;
 		}
 
 		if (mem->operation & MEM_OPERATION_STORE) {
-			e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__STORE);
 			e->record = true;
 		}
 	}
 
-	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
 	if (e->record)
 		rec_argv[i++] = "-W";
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0a8f415f5efe..27a33dc44964 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -29,17 +29,42 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
 
-struct perf_mem_event * __weak perf_mem_events__ptr(int i)
+struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i)
 {
-	if (i >= PERF_MEM_EVENTS__MAX)
+	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
 		return NULL;
 
-	return &perf_mem_events[i];
+	return &pmu->mem_events[i];
+}
+
+static struct perf_pmu *perf_pmus__scan_mem(struct perf_pmu *pmu)
+{
+	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+		if (pmu->mem_events)
+			return pmu;
+	}
+	return NULL;
+}
+
+struct perf_pmu *perf_mem_events_find_pmu(void)
+{
+	/*
+	 * The current perf mem doesn't support per-PMU configuration.
+	 * The exact same configuration is applied to all the
+	 * mem_events supported PMUs.
+	 * Return the first mem_events supported PMU.
+	 *
+	 * Notes: The only case which may support multiple mem_events
+	 * supported PMUs is Intel hybrid. The exact same mem_events
+	 * is shared among the PMUs. Only configure the first PMU
+	 * is good enough as well.
+	 */
+	return perf_pmus__scan_mem(NULL);
 }
 
 const char * __weak perf_mem_events__name(int i, const char *pmu_name  __maybe_unused)
 {
-	struct perf_mem_event *e = perf_mem_events__ptr(i);
+	struct perf_mem_event *e = &perf_mem_events[i];
 
 	if (!e)
 		return NULL;
@@ -61,7 +86,7 @@ __weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
 	return false;
 }
 
-int perf_mem_events__parse(const char *str)
+int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str)
 {
 	char *tok, *saveptr = NULL;
 	bool found = false;
@@ -79,7 +104,7 @@ int perf_mem_events__parse(const char *str)
 
 	while (tok) {
 		for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-			struct perf_mem_event *e = perf_mem_events__ptr(j);
+			struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
 
 			if (!e->tag)
 				continue;
@@ -112,7 +137,7 @@ static bool perf_mem_event__supported(const char *mnt, struct perf_pmu *pmu,
 	return !stat(path, &st);
 }
 
-int perf_mem_events__init(void)
+int perf_pmu__mem_events_init(struct perf_pmu *pmu)
 {
 	const char *mnt = sysfs__mount();
 	bool found = false;
@@ -122,8 +147,7 @@ int perf_mem_events__init(void)
 		return -ENOENT;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		struct perf_mem_event *e = perf_mem_events__ptr(j);
-		struct perf_pmu *pmu = NULL;
+		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
 
 		/*
 		 * If the event entry isn't valid, skip initialization
@@ -132,29 +156,20 @@ int perf_mem_events__init(void)
 		if (!e->tag)
 			continue;
 
-		/*
-		 * Scan all PMUs not just core ones, since perf mem/c2c on
-		 * platforms like AMD uses IBS OP PMU which is independent
-		 * of core PMU.
-		 */
-		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-			e->supported |= perf_mem_event__supported(mnt, pmu, e);
-			if (e->supported) {
-				found = true;
-				break;
-			}
-		}
+		e->supported |= perf_mem_event__supported(mnt, pmu, e);
+		if (e->supported)
+			found = true;
 	}
 
 	return found ? 0 : -ENOENT;
 }
 
-void perf_mem_events__list(void)
+void perf_pmu__mem_events_list(struct perf_pmu *pmu)
 {
 	int j;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		struct perf_mem_event *e = perf_mem_events__ptr(j);
+		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
 
 		fprintf(stderr, "%-*s%-*s%s",
 			e->tag ? 13 : 0,
@@ -165,50 +180,32 @@ void perf_mem_events__list(void)
 	}
 }
 
-static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
-						    int idx)
-{
-	const char *mnt = sysfs__mount();
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		if (!perf_mem_event__supported(mnt, pmu, e)) {
-			pr_err("failed: event '%s' not supported\n",
-			       perf_mem_events__name(idx, pmu->name));
-		}
-	}
-}
-
 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 				 char **rec_tmp, int *tmp_nr)
 {
 	const char *mnt = sysfs__mount();
+	struct perf_pmu *pmu = NULL;
 	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
 
-	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		e = perf_mem_events__ptr(j);
-		if (!e->record)
-			continue;
 
-		if (perf_pmus__num_mem_pmus() == 1) {
-			if (!e->supported) {
-				pr_err("failed: event '%s' not supported\n",
-				       perf_mem_events__name(j, NULL));
-				return -1;
-			}
+	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
+		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+			e = perf_pmu__mem_events_ptr(pmu, j);
 
-			rec_argv[i++] = "-e";
-			rec_argv[i++] = perf_mem_events__name(j, NULL);
-		} else {
-			struct perf_pmu *pmu = NULL;
+			if (!e->record)
+				continue;
 
 			if (!e->supported) {
-				perf_mem_events__print_unsupport_hybrid(e, j);
+				pr_err("failed: event '%s' not supported\n",
+					perf_mem_events__name(j, pmu->name));
 				return -1;
 			}
 
-			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+			if (perf_pmus__num_mem_pmus() == 1) {
+				rec_argv[i++] = "-e";
+				rec_argv[i++] = perf_mem_events__name(j, NULL);
+			} else {
 				const char *s = perf_mem_events__name(j, pmu->name);
 
 				if (!perf_mem_event__supported(mnt, pmu, e))
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 8c5694b2d0b0..0ad301a2e424 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -36,14 +36,15 @@ enum {
 extern unsigned int perf_mem_events__loads_ldlat;
 extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 
-int perf_mem_events__parse(const char *str);
-int perf_mem_events__init(void);
+int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
+int perf_pmu__mem_events_init(struct perf_pmu *pmu);
 
 const char *perf_mem_events__name(int i, const char *pmu_name);
-struct perf_mem_event *perf_mem_events__ptr(int i);
+struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
+struct perf_pmu *perf_mem_events_find_pmu(void);
 bool is_mem_loads_aux_event(struct evsel *leader);
 
-void perf_mem_events__list(void);
+void perf_pmu__mem_events_list(struct perf_pmu *pmu);
 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 				 char **rec_tmp, int *tmp_nr);
 
-- 
2.35.1

