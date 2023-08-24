Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81604786694
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbjHXEOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbjHXEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D098B171F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59204757627so53062907b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850439; x=1693455239;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZewI3nPpImqbFJqNAvX0ZQHNd9oa0t1rOfrNdK6f64=;
        b=s6czWNqa6SS0Dx6G/QxxsR/83VjVVuFMvCQY7Qtx2OPqx+fCQ5MTYJ/GHGaxYFuFlx
         peHgarO4gV3dOEYTL1LwKetnL72ezJIbll3TbQ2zeaWXizmAFpFkqYKLdGYiBJAtvCMg
         qUF/wIWhnNPDOUxteSx/TH/AuF/AmYCVKMyYj9jHH+YjU1LMpk4qEx4cgjiSDJE+Jr1t
         +G/Z2l5drDPsDLwS/DlHaRkwy5IFXotVLgXbGm+JF5q3Ub8oUZCQkJS+P93C+zxyczdq
         TI5XavO62wF+stP1CMkk4lw/38zCGL4/Ydl6h4ZAWA89QtOVfRxQNxLZGifkNzIGmkHA
         SfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850439; x=1693455239;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZewI3nPpImqbFJqNAvX0ZQHNd9oa0t1rOfrNdK6f64=;
        b=SsUD7Kt6ViXu+5gvL8s+Jw9tr5T6GdBfE3/5mVMVUimj1wo/MAdmhqQrKl6Y9PnCSS
         RdLm7dVUk7NkFM9/0MK+zpzaPobgtXGYLBiqCk2OqjmIheC2uehebI8q9SjMuwxkQbRO
         W0+CNt8aUsEUdDfJe5UfBLeVx1Dq/zMXSMfIF86KRRJkeKyg2otVfvwOT1wnjOhhPV7q
         h5Leut2SEmU63H6X+leNmiaF4Jlha3SiNRE6AKq/lYpsuXh+GJVyK+x35Xt6updV/+8k
         mEst7RkSYp6rWvIpBnzKB1wNXhkxr7sPyGVnfzPdENoX23pWt/xynQNPIR448MOzfIhT
         CJ8w==
X-Gm-Message-State: AOJu0Yw2qe2sfDt1UJiym0qmXd7xtSDy6Nyb22HEqHfTDg2dMfiU9sli
        tIkNqKV+tBwefTcHOFBOGZuQ5NgTgEa6
X-Google-Smtp-Source: AGHT+IEfdGl2oTHV/ZWECik+jy5EjUwahwoDcJYpBY96quefyzLUIaPWFY5kuZB9wop7VGom14iuNFslqqcQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a05:6902:290:b0:d48:c04:f256 with SMTP id
 v16-20020a056902029000b00d480c04f256mr195838ybh.11.1692850438995; Wed, 23 Aug
 2023 21:13:58 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:19 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-8-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 07/18] perf pmu-events: Reduce processed events by passing PMU
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the PMU to pmu_events_table__for_each_event so that entries that
don't match don't need to be processed by callback. If a NULL PMU is
passed then all PMUs are processed. perf bench internals pmu-scan
"Average PMU scanning" performance is reduced by about 5% on an Intel
tigerlake.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 15 ++++++----
 tools/perf/pmu-events/jevents.py         | 18 ++++++++----
 tools/perf/pmu-events/pmu-events.h       |  4 ++-
 tools/perf/tests/pmu-events.c            |  6 ++--
 tools/perf/util/pmu.c                    | 35 +++++++-----------------
 tools/perf/util/pmu.h                    |  1 +
 6 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 807f2e55c17c..2d6f748280ac 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -266,12 +266,16 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	},
 };
 
-int pmu_events_table__for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
-				    void *data)
+int pmu_events_table__for_each_event(const struct pmu_events_table *table, struct perf_pmu *pmu,
+				     pmu_event_iter_fn fn, void *data)
 {
 	for (const struct pmu_event *pe = &table->entries[0]; pe->name; pe++) {
-		int ret = fn(pe, table, data);
+		int ret;
 
+                if (pmu && !pmu__name_match(pmu, pe->pmu))
+                        continue;
+
+		ret = fn(pe, table, data);
 		if (ret)
 			return ret;
 	}
@@ -371,7 +375,8 @@ const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
 	for (const struct pmu_events_map *tables = &pmu_events_map[0]; tables->arch; tables++) {
-		int ret = pmu_events_table__for_each_event(&tables->event_table, fn, data);
+		int ret = pmu_events_table__for_each_event(&tables->event_table,
+							   /*pmu=*/ NULL, fn, data);
 
 		if (ret)
 			return ret;
@@ -408,7 +413,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
 	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
 	     tables->name;
 	     tables++) {
-		int ret = pmu_events_table__for_each_event(&tables->table, fn, data);
+		int ret = pmu_events_table__for_each_event(&tables->table, /*pmu=*/ NULL, fn, data);
 
 		if (ret)
 			return ret;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 1ad20140114c..396af53e0e45 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -826,14 +826,20 @@ static int pmu_events_table__for_each_event_pmu(const struct pmu_events_table *t
  }
 
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
+                                    struct perf_pmu *pmu,
                                     pmu_event_iter_fn fn,
                                     void *data)
 {
         for (size_t i = 0; i < table->num_pmus; i++) {
-                int ret = pmu_events_table__for_each_event_pmu(table, &table->pmus[i],
-                                                               fn, data);
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+                int ret;
 
-                if (ret)
+                if (pmu && !pmu__name_match(pmu, pmu_name))
+                        continue;
+
+                ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
+                if (pmu || ret)
                         return ret;
         }
         return 0;
@@ -955,7 +961,8 @@ int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
              tables->arch;
              tables++) {
-                int ret = pmu_events_table__for_each_event(&tables->event_table, fn, data);
+                int ret = pmu_events_table__for_each_event(&tables->event_table,
+                                                           /*pmu=*/ NULL, fn, data);
 
                 if (ret)
                         return ret;
@@ -992,7 +999,8 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
              tables->name;
              tables++) {
-                int ret = pmu_events_table__for_each_event(&tables->event_table, fn, data);
+                int ret = pmu_events_table__for_each_event(&tables->event_table,
+                                                           /*pmu=*/ NULL, fn, data);
 
                 if (ret)
                         return ret;
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 6557381b7de1..c0303ba42e97 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -77,7 +77,9 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metric *pm,
 				  const struct pmu_metrics_table *table,
 				  void *data);
 
-int pmu_events_table__for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
+int pmu_events_table__for_each_event(const struct pmu_events_table *table,
+				    struct perf_pmu *pmu,
+				    pmu_event_iter_fn fn,
 				    void *data);
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 0b6efabc3d20..92d1f6f0e666 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -483,12 +483,14 @@ static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 	if (!table || !sys_event_table)
 		return -1;
 
-	err = pmu_events_table__for_each_event(table, test__pmu_event_table_core_callback,
+	err = pmu_events_table__for_each_event(table, /*pmu=*/ NULL,
+					      test__pmu_event_table_core_callback,
 					      &map_events);
 	if (err)
 		return err;
 
-	err = pmu_events_table__for_each_event(sys_event_table, test__pmu_event_table_sys_callback,
+	err = pmu_events_table__for_each_event(sys_event_table, /*pmu=*/ NULL,
+					      test__pmu_event_table_sys_callback,
 					      &map_events);
 	if (err)
 		return err;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0c82bbeea7d6..9ba9ac3d3d96 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -859,28 +859,14 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	return res;
 }
 
-struct pmu_add_cpu_aliases_map_data {
-	/* List being added to. */
-	struct list_head *head;
-	/* If a pmu_event lacks a given PMU the default used. */
-	char *default_pmu_name;
-	/* The PMU that we're searching for events for. */
-	struct perf_pmu *pmu;
-};
-
 static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 					const struct pmu_events_table *table __maybe_unused,
 					void *vdata)
 {
-	struct pmu_add_cpu_aliases_map_data *data = vdata;
-	const char *pname = pe->pmu ?: data->default_pmu_name;
+	struct list_head *head = vdata;
 
-	if (!strcmp(pname, data->pmu->name) ||
-	    (data->pmu->is_uncore && pmu_uncore_alias_match(pname, data->pmu->name))) {
-		/* need type casts to override 'const' */
-		__perf_pmu__new_alias(data->head, -1, (char *)pe->name, (char *)pe->desc,
-				      (char *)pe->event, pe);
-	}
+	/* need type casts to override 'const' */
+	__perf_pmu__new_alias(head, -1, (char *)pe->name, (char *)pe->desc, (char *)pe->event, pe);
 	return 0;
 }
 
@@ -890,14 +876,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
  */
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_table *table)
 {
-	struct pmu_add_cpu_aliases_map_data data = {
-		.head = &pmu->aliases,
-		.default_pmu_name = perf_pmus__default_pmu_name(),
-		.pmu = pmu,
-	};
-
-	pmu_events_table__for_each_event(table, pmu_add_cpu_aliases_map_callback, &data);
-	free(data.default_pmu_name);
+	pmu_events_table__for_each_event(table, pmu, pmu_add_cpu_aliases_map_callback, &pmu->aliases);
 }
 
 static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
@@ -1713,6 +1692,12 @@ int perf_pmu__for_each_event(const struct perf_pmu *pmu, void *state, pmu_event_
 	return ret;
 }
 
+bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
+{
+	return !strcmp(pmu->name, pmu_name) ||
+		(pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->name));
+}
+
 bool perf_pmu__is_software(const struct perf_pmu *pmu)
 {
 	if (pmu->is_core || pmu->is_uncore || pmu->auxtrace)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 03211de345c1..2b1730152bc0 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -198,6 +198,7 @@ bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name);
 size_t perf_pmu__num_events(const struct perf_pmu *pmu);
 int perf_pmu__for_each_event(const struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name);
 
 /**
  * perf_pmu_is_software - is the PMU a software PMU as in it uses the
-- 
2.42.0.rc1.204.g551eb34607-goog

