Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A143E7BC422
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbjJGCOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjJGCOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:14:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE36111
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:14:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8153284d6eso3729991276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644841; x=1697249641; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nlT7Ayc6FK2ENh5HApqpyv4FDoAbHTS/CAmbKpgFgU=;
        b=KVt12koF9lOZAI4EXiciPQ4EuRna0sLnyltatR2YMMKhwQEeVEA18EGT2GtRpTDURy
         oM+iqas1pxCdAC6QRhFCe7zAxO/AXftg1pX2PczCTYOyeVO7Wbz7S3JNpXWPmVHefxfT
         j2YCWQSEMbKFkz0ai3b7qINURgbw+OrulMx7rHCwJMzge6/v30pOq2JYwo8SksJI5yiU
         kE391MoYlPVZxkjv7+45FB3F33bY5mvtyOZzeZg9tsB0FQN1+4iGjW2lv90ujPRBJPAd
         5rLq+7G8dG/IUtUkLeeeT5yvEsg1CQ9hOBN/usMjo8GR8OIjPB0FR7zwzH3GzCPDvxN3
         9dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644841; x=1697249641;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nlT7Ayc6FK2ENh5HApqpyv4FDoAbHTS/CAmbKpgFgU=;
        b=YJxJ9B2pcZNdxNXuVPKR4VI8V9c1gB0iS1ssfUraN3I4FsUSww7SBDUrFA+ZC3NyuU
         qoBGpB5kbFHGuLWOnDJ17DwZakmDYbMeIgpyv4WKBa4vMNK9JuCGbAiwoQGUO8PIwbdS
         ZR97NqnovCM15227GSrQnAW0Ved6hiJvzQP/NvR55AhYtJi2Uz1PcznNdT6mh6X3jOUj
         4Z6bUp3eu2JQYZ30t+/UBlzoXwEyzCpATXMoqSs5k5iTVh7mmLoOBOO68nZy+fPx4jV7
         dkp3M9uZvwgM+u9MXYLi0aA34UsjO1GecwuLds1SY0KQMjchyKCvien1x8pwwGXkn2Go
         eALw==
X-Gm-Message-State: AOJu0YxZ/ocIKnd7/NmiYksLgRDbOm836NOz376OLnRsZ8g5T5vo6cG+
        Ql/LNb/nPJ2PdzQDxkKs1ACKI8XZVPQ2
X-Google-Smtp-Source: AGHT+IHKgnAs25/YJ43kvuHhiiWC2cjxg2u8JYxG3dDXPATXMZW8zvYw7dr0dQFaibX0XwBeXqVh6XfAHREW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a05:6902:180e:b0:d77:984e:c770 with SMTP
 id cf14-20020a056902180e00b00d77984ec770mr169264ybb.5.1696644841134; Fri, 06
 Oct 2023 19:14:01 -0700 (PDT)
Date:   Fri,  6 Oct 2023 19:13:25 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-7-irogers@google.com>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 6/7] perf pmu-events: Remember the events and metrics table
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

strcmp_cpuid_str performs regular expression comparisons. Avoid
repeated computation of the table by remembering the table in a
static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index fd009752b427..8d8d5088c53c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -978,28 +978,32 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
-        const struct pmu_events_table *table = NULL;
-        char *cpuid = perf_pmu__getcpuid(pmu);
+        static const struct pmu_events_table *table;
         size_t i;
 
-        /* on some platforms which uses cpus map, cpuid can be NULL for
-         * PMUs other than CORE PMUs.
-         */
-        if (!cpuid)
-                return NULL;
-
-        i = 0;
-        for (;;) {
-                const struct pmu_events_map *map = &pmu_events_map[i++];
-                if (!map->arch)
-                        break;
-
-                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-                        table = &map->event_table;
-                        break;
+        if (!table) {
+                char *cpuid = perf_pmu__getcpuid(pmu);
+
+                /*
+                 * On some platforms which uses cpus map, cpuid can be NULL for
+                 * PMUs other than CORE PMUs.
+                 */
+                if (!cpuid)
+                        return NULL;
+
+                i = 0;
+                for (;;) {
+                        const struct pmu_events_map *map = &pmu_events_map[i++];
+                        if (!map->arch)
+                                break;
+
+                        if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
+                                table = &map->event_table;
+                                break;
+                        }
                 }
+                free(cpuid);
         }
-        free(cpuid);
         if (!pmu)
                 return table;
 
@@ -1015,13 +1019,17 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
 {
-        const struct pmu_metrics_table *table = NULL;
-        char *cpuid = perf_pmu__getcpuid(pmu);
+        static const struct pmu_metrics_table *table;
+        char *cpuid;
         int i;
 
+        if (table)
+                return table;
+
         /* on some platforms which uses cpus map, cpuid can be NULL for
          * PMUs other than CORE PMUs.
          */
+        cpuid = perf_pmu__getcpuid(pmu);
         if (!cpuid)
                 return NULL;
 
-- 
2.42.0.609.gbb76f46606-goog

