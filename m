Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398F378552A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjHWKPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjHWIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:10:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9DE5D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-591138c0978so44186507b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778152; x=1693382952;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thiR0red1e/TKgvXPJgbac9qLA8eyvIz0R2RRqFEpHo=;
        b=XFUd9593BS1mAF6tiAGLbyXxPCSXxxxdjfNyfOYhijHjpeRcmzdiwAxB33DlKG+yNh
         PweK+NrBxYkJjUjZzi3y+/Ga1msXD2Id0hFG/Tw2x19I8qM0NCcKz4ZhNZW2L+2WRQJD
         5o5H5fuMczruUtj0vjmBpewVES4knxsQxsSnCGv2IyZ5tmJU1nHPWaMf9hV04q31ckiu
         CznQDyUiCBc2l/Fkp8bhGgQIllS4ROlBJayBFaFWd7tmq/EsRaIsQSdmHTHqO8huqO5C
         9BQrSmUn1L98iyPRGe3a16/lQUlWuegbVaDOKKcl3dF/jOyi59aKfFUQ0m1t+ZnAP33O
         aNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778152; x=1693382952;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thiR0red1e/TKgvXPJgbac9qLA8eyvIz0R2RRqFEpHo=;
        b=bDXID0UWkJVzirrOVKUMx7rdRqajFRskJ/t/Y0erpdxgj4Y+PNpFyCug6aILFNgrwE
         boqEJt4MUle39uT3QJ0PjnmCzogxlwx7e9dDw1Eauj6qF3OIX3i4v0LtEDuiq1zVUcEP
         GxAT3Tm1k8aF2uZ1WuGC+gu0IMOmDZHVIHDiYWa5toTTOzEYnGeUpWXA2j+rfZ3M4ppN
         WNUeGY4u6fK9AqDUKnz60+BZWGYiVOcmsg7Egr75QtGZOd8ktCRsOdh99mDuw9eHUZ9Z
         BN9ZvBw049flIuBnGjrljlEZBJ72fWfFrCHJHWAhygjtxJwL6qMl8lvbRug7W8ZeMbSk
         20Ug==
X-Gm-Message-State: AOJu0YyAil7nVn9cli8Wqw0s4kpo3jm94uDVr+1o5UZoIvSEsVAPhhEj
        j7qhBKw28WSdsNyVUxzNXfJqdVtRvbpR
X-Google-Smtp-Source: AGHT+IE8MQVpauvtosSVTTVSAyjLiGbK63QXSjLEmXyjtzfEsdupSKb4Iedwyu+OPz6HeNQoyeTezcF9ZHQS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a81:ac5a:0:b0:586:4fbc:4367 with SMTP id
 z26-20020a81ac5a000000b005864fbc4367mr157506ywj.10.1692778151937; Wed, 23 Aug
 2023 01:09:11 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:19 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-17-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 16/25] perf pmu-events: Add pmu_events_table__find_event
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jevents stores events sorted by name. Add a find function that will
binary search event names avoiding the need to linearly search through
events. Add a test in tests/pmu-events.c. If the PMU or event aren't
found -1000 is returned. If the event is found but no callback
function given, 0 is returned. This allows the find function also act
as a test for existence.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 16 ++++++
 tools/perf/pmu-events/jevents.py         | 64 ++++++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h       |  5 ++
 tools/perf/tests/pmu-events.c            |  5 ++
 4 files changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 2d6f748280ac..ef18d403f25f 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -282,6 +282,22 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table, struc
 	return 0;
 }
 
+int pmu_events_table__find_event(const struct pmu_events_table *table,
+                                 struct perf_pmu *pmu,
+                                 const char *name,
+                                 pmu_event_iter_fn fn,
+                                 void *data)
+{
+	for (const struct pmu_event *pe = &table->entries[0]; pe->name; pe++) {
+                if (pmu && !pmu__name_match(pmu, pe->pmu))
+                        continue;
+
+		if (!strcasecmp(pe->name, name))
+			return fn(pe, table, data);
+	}
+        return -1000;
+}
+
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				      void *data)
 {
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 396af53e0e45..991fcf6cca64 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -825,6 +825,49 @@ static int pmu_events_table__for_each_event_pmu(const struct pmu_events_table *t
         return 0;
  }
 
+static int pmu_events_table__find_event_pmu(const struct pmu_events_table *table,
+                                            const struct pmu_table_entry *pmu,
+                                            const char *name,
+                                            pmu_event_iter_fn fn,
+                                            void *data)
+{
+        struct pmu_event pe = {
+                .pmu = &big_c_string[pmu->pmu_name.offset],
+        };
+        int low = 0, high = pmu->num_entries - 1;
+
+        while (low <= high) {
+                int cmp, mid = (low + high) / 2;
+
+                decompress_event(pmu->entries[mid].offset, &pe);
+
+                if (!pe.name && !name)
+                        goto do_call;
+
+                if (!pe.name && name) {
+                        low = mid + 1;
+                        continue;
+                }
+                if (pe.name && !name) {
+                        high = mid - 1;
+                        continue;
+                }
+
+                cmp = strcasecmp(pe.name, name);
+                if (cmp < 0) {
+                        low = mid + 1;
+                        continue;
+                }
+                if (cmp > 0) {
+                        high = mid - 1;
+                        continue;
+                }
+  do_call:
+                return fn ? fn(&pe, table, data) : 0;
+        }
+        return -1000;
+}
+
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     struct perf_pmu *pmu,
                                     pmu_event_iter_fn fn,
@@ -845,6 +888,27 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
         return 0;
 }
 
+int pmu_events_table__find_event(const struct pmu_events_table *table,
+                                 struct perf_pmu *pmu,
+                                 const char *name,
+                                 pmu_event_iter_fn fn,
+                                 void *data)
+{
+        for (size_t i = 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+                int ret;
+
+                if (!pmu__name_match(pmu, pmu_name))
+                        continue;
+
+                ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
+                if (ret != -1000)
+                        return ret;
+        }
+        return -1000;
+}
+
 static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics_table *table,
                                                 const struct pmu_table_entry *pmu,
                                                 pmu_metric_iter_fn fn,
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c0303ba42e97..9882b7125761 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -81,6 +81,11 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
 				    void *data);
+int pmu_events_table__find_event(const struct pmu_events_table *table,
+                                 struct perf_pmu *pmu,
+                                 const char *name,
+                                 pmu_event_iter_fn fn,
+				 void *data);
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 92d1f6f0e666..34f0de182fa9 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -546,6 +546,11 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 
 	pmu_add_cpu_aliases_table(pmu, table);
 
+	res = pmu_events_table__find_event(table, pmu, "bp_l1_btb_correct", NULL, NULL);
+	if (res != 0) {
+		pr_debug("Missing test event in test architecture");
+		return res;
+	}
 	for (; *test_event_table; test_event_table++) {
 		struct perf_pmu_test_event test_event = **test_event_table;
 		struct pmu_event const *event = &test_event.event;
-- 
2.42.0.rc1.204.g551eb34607-goog

