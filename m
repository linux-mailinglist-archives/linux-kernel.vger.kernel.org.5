Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA487C754A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441943AbjJLR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379691AbjJLR5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:57:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC4ED
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:57:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a4f6729d16so19867167b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133423; x=1697738223; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWpjgvY6Y26Eimtg00txsKN0n/IUHl2rx+ZiyTR9QgU=;
        b=01OirAI7Kqwl3hkIaX6EXZO1fYLqbzvm3N6WQtONnav9Hq/SAmtx3GZMMEtTONsrbB
         XSp96vuEmw3s0kGuQ4mjztC5JI9pxAClDPUNc7bIFf2TJkV0SMTqOxDZKyhm+lWgZ9l9
         BDOUrlzJaa7BSHGW8wSYfvAvrDnUFBnfWR8Z1qbvfEA5yiPARwdzjCzVaiuJBRFfWPDD
         JH+Qwv1UaO1/PFKto+YWN2OnnFOaQXjyJXKPXqHlnqzI36GjlSewl7rOIlyS96n8zIgN
         ipczdb9InLowA1jKpZA+Btm0zn25otbTCRkBE4WwGBa8+Ikb9qu2Z6eEgn7M2BSqbscI
         C4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133423; x=1697738223;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWpjgvY6Y26Eimtg00txsKN0n/IUHl2rx+ZiyTR9QgU=;
        b=W1WmPo/2a8JQ/SJOfh+vU6vU6nHQqMxE4n8tgzMPPcVgMMlBV/K7bp2FLKaXSpkfJ2
         DdLqk/cNxGMLQMabwmb3Uml5L6NPxKJviinBncmLNagAEdEdVZDWPTRD05R+BNJIsovc
         66ik3t22yC0azQzmTNWkSB1OhoHpdD1c/nKjslq59rNlvmxPtqgtFX8qbhtPbFDR8gD+
         yNt9zz3zHg4wmaLxH4RY9ZZZV73bh4QmXVN1yXC3iio4svWXnY6/fsjnepEcHFVi7rwS
         1M/XVer/PFuG34tA4ji4/3Zk4uZVk0IftdkPDramt3IY1/ra0euZwcHUBigqM0bMf3lk
         EFzw==
X-Gm-Message-State: AOJu0YxhxXga8LtXQcvR/s95DzTRY/yc6m6JFd2Jgu58FZ6hCgt0H8Zp
        43nvTFq/iFsjQkEN2tuuWpo1S74cEh+x
X-Google-Smtp-Source: AGHT+IE/sEVcjGwGGmZkF6IqM1j7PAPF1hcyhh38d5+Sy/MY8H4WVKC1/tU3vnJPIhx8VDYD3KM+PPxqwX1V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a25:e794:0:b0:d9a:40ed:8d26 with SMTP id
 e142-20020a25e794000000b00d9a40ed8d26mr200498ybh.0.1697133423623; Thu, 12 Oct
 2023 10:57:03 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:56:44 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-7-irogers@google.com>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 6/7] perf pmu-events: Remember the perf_events_map for a PMU
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
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

strcmp_cpuid_str performs regular expression comparisons and so per
CPUID linear searches over the perf_events_map are expensive. Add a
helper function called map_for_pmu that does the search but also
caches the map specific to a PMU. As the PMU may differ, also cache
the CPUID string so that PMUs with the same CPUID string don't require
the linear search and regular expression comparisons. This speeds
loading PMUs as the search is done once per PMU to find the
appropriate tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 109 ++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 39 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 96dc74c90b20..3c091ab75305 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -976,68 +976,99 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
-const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
+static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
 {
-        const struct pmu_events_table *table = NULL;
-        char *cpuid = perf_pmu__getcpuid(pmu);
+        static struct {
+                const struct pmu_events_map *map;
+                struct perf_pmu *pmu;
+        } last_result;
+        static struct {
+                const struct pmu_events_map *map;
+                char *cpuid;
+        } last_map_search;
+        static bool has_last_result, has_last_map_search;
+        const struct pmu_events_map *map = NULL;
+        char *cpuid = NULL;
         size_t i;
 
-        /* on some platforms which uses cpus map, cpuid can be NULL for
+        if (has_last_result && last_result.pmu == pmu)
+                return last_result.map;
+
+        cpuid = perf_pmu__getcpuid(pmu);
+
+        /*
+         * On some platforms which uses cpus map, cpuid can be NULL for
          * PMUs other than CORE PMUs.
          */
         if (!cpuid)
-                return NULL;
+                goto out_update_last_result;
+
+        if (has_last_map_search && !strcmp(last_map_search.cpuid, cpuid)) {
+                map = last_map_search.map;
+                free(cpuid);
+        } else {
+                i = 0;
+                for (;;) {
+                        map = &pmu_events_map[i++];
+
+                        if (!map->arch) {
+                                map = NULL;
+                                break;
+                        }
+
+                        if (!strcmp_cpuid_str(map->cpuid, cpuid))
+                                break;
+               }
+               free(last_map_search.cpuid);
+               last_map_search.cpuid = cpuid;
+               last_map_search.map = map;
+               has_last_map_search = true;
+        }
+out_update_last_result:
+        last_result.pmu = pmu;
+        last_result.map = map;
+        has_last_result = true;
+        return map;
+}
 
-        i = 0;
-        for (;;) {
-                const struct pmu_events_map *map = &pmu_events_map[i++];
-                if (!map->arch)
-                        break;
+const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
+{
+        const struct pmu_events_map *map = map_for_pmu(pmu);
 
-                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-                        table = &map->event_table;
-                        break;
-                }
-        }
-        free(cpuid);
-        if (!pmu || !table)
-                return table;
+        if (!map)
+                return NULL;
 
-        for (i = 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+        if (!pmu)
+                return &map->event_table;
+
+        for (size_t i = 0; i < map->event_table.num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &map->event_table.pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
 
                 if (pmu__name_match(pmu, pmu_name))
-                        return table;
+                         return &map->event_table;
         }
         return NULL;
 }
 
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
 {
-        const struct pmu_metrics_table *table = NULL;
-        char *cpuid = perf_pmu__getcpuid(pmu);
-        int i;
+        const struct pmu_events_map *map = map_for_pmu(pmu);
 
-        /* on some platforms which uses cpus map, cpuid can be NULL for
-         * PMUs other than CORE PMUs.
-         */
-        if (!cpuid)
+        if (!map)
                 return NULL;
 
-        i = 0;
-        for (;;) {
-                const struct pmu_events_map *map = &pmu_events_map[i++];
-                if (!map->arch)
-                        break;
+        if (!pmu)
+                return &map->metric_table;
 
-                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-                        table = &map->metric_table;
-                        break;
-                }
+        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+
+                if (pmu__name_match(pmu, pmu_name))
+                           return &map->metric_table;
         }
-        free(cpuid);
-        return table;
+        return NULL;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
-- 
2.42.0.655.g421f12c284-goog

