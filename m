Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51A5789402
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 08:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjHZGWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 02:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHZGWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 02:22:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF92682
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 23:22:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d428d4956so23806527b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 23:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693030927; x=1693635727;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RFQVboYu+kktG1+tXeHnttxhbtZCnqVNF8qlf7e9WxE=;
        b=i6MGCuBUzrcwhd++Q/E3/0Gy73rr2OPrxc4zjgZyauZ7FZo3pLogzbHtM7/ZZdpIOA
         xi4tDGaHEkAxAQ68NQrhKoXGYyG7fc6IXVYaami/WZE7glh1LU2iAFLT92THq7eeFgVf
         R4p61ZDXqyDvxBWwQTSOgU21jbEImma8ZNXtppxUvHx6kyoQPwA8xgO3qp01kcLqTBH+
         oDSWTbw+S5vDBHE7KqiR4PYRjO9dKOJRv8Ey1gryhJhE4mlUp71+oH3WtKeUIJTxGV0y
         N62PjpMw0AplC/jKqLvpkGb3RN0dYPjQYu0pOVsjexJXMB0oo0rxMavqUMCkssAs0uPN
         WUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693030927; x=1693635727;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFQVboYu+kktG1+tXeHnttxhbtZCnqVNF8qlf7e9WxE=;
        b=kk1zHSMJpTKP5GvL9YZU/lcQgye+ASqgBAskeo6SuktvBLNBljZ6IlsRuAWsg2gYsy
         uHwA1ct8VBM9YAo9cU/YMGF7RpL3HS2ZpJu2fXeuWSbl3IlzU06Zy+MACgzzyeRukYDX
         b+i8Ywx7fNlnPup+bH9epdZJcgsyNVKgzn3JpJ+0vlYjmauQ8Jwjd3tinypESzrt8aFY
         WvWuozNUUrzzMiRRzlx1vMljNZbPXzpNCUuVFHlKvi1gt0wjuO2luk6ik4AkgksFGwSs
         ePUkgCrSpZpoikWWWpU32VahtMAKTPpSW73bOFPxpdxk9SC/FFIjp9RPOQa0MPXroc2o
         23/A==
X-Gm-Message-State: AOJu0Yz3nRKV5XttI2Vfo+WGS0tf/VQDXBwcnrA9GPGmqDW5noDMFVsP
        y1CGsdgaTqnCzKcFnaEF9z59+69dZhkJ
X-Google-Smtp-Source: AGHT+IFIuIPm5S9+xu52QjoN0JXjgPeVqacz7WzK9+rPznPBejkHS9yA6ingSsBJFeLX9cc6VJUAd3ALshqh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f44:ad7d:19a6:8de2])
 (user=irogers job=sendgmr) by 2002:a25:bc8a:0:b0:d78:2f4c:7df with SMTP id
 e10-20020a25bc8a000000b00d782f4c07dfmr295506ybk.12.1693030926800; Fri, 25 Aug
 2023 23:22:06 -0700 (PDT)
Date:   Fri, 25 Aug 2023 23:22:03 -0700
Message-Id: <20230826062203.1058041-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1] perf jevents: Use "default_core" for events with no Unit
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
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>
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

The json Unit field encodes the name of the PMU to match the events
to. When no name is given it has meant the "cpu" core PMU except for
tests. On ARM, Intel hybrid and s390 the core PMU is named differently
which means that using "cpu" for this case causes the events not to
get matched to the PMU. Introduce a new "default_core" string for this
case and in the pmu__name_match force all core PMUs to match this
name.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Fixes: 2e255b4f9f41 ("perf jevents: Group events by PMU")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py |  2 +-
 tools/perf/tests/pmu-events.c    | 19 ++++++++++---------
 tools/perf/util/pmu.c            |  7 ++++++-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 712f80d7d071..a7e88332276d 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -266,7 +266,7 @@ class JsonEvent:
     def unit_to_pmu(unit: str) -> Optional[str]:
       """Convert a JSON Unit to Linux PMU name."""
       if not unit:
-        return 'cpu'
+        return 'default_core'
       # Comment brought over from jevents.c:
       # it's not realistic to keep adding these, we need something more scalable ...
       table = {
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ce4da9b1d115..f5321fbdee79 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -44,7 +44,7 @@ struct perf_pmu_test_pmu {
 
 static const struct perf_pmu_test_event bp_l1_btb_correct = {
 	.event = {
-		.pmu = "cpu",
+		.pmu = "default_core",
 		.name = "bp_l1_btb_correct",
 		.event = "event=0x8a",
 		.desc = "L1 BTB Correction",
@@ -56,7 +56,7 @@ static const struct perf_pmu_test_event bp_l1_btb_correct = {
 
 static const struct perf_pmu_test_event bp_l2_btb_correct = {
 	.event = {
-		.pmu = "cpu",
+		.pmu = "default_core",
 		.name = "bp_l2_btb_correct",
 		.event = "event=0x8b",
 		.desc = "L2 BTB Correction",
@@ -68,7 +68,7 @@ static const struct perf_pmu_test_event bp_l2_btb_correct = {
 
 static const struct perf_pmu_test_event segment_reg_loads_any = {
 	.event = {
-		.pmu = "cpu",
+		.pmu = "default_core",
 		.name = "segment_reg_loads.any",
 		.event = "event=0x6,period=200000,umask=0x80",
 		.desc = "Number of segment register loads",
@@ -80,7 +80,7 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
 
 static const struct perf_pmu_test_event dispatch_blocked_any = {
 	.event = {
-		.pmu = "cpu",
+		.pmu = "default_core",
 		.name = "dispatch_blocked.any",
 		.event = "event=0x9,period=200000,umask=0x20",
 		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
@@ -92,7 +92,7 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
 
 static const struct perf_pmu_test_event eist_trans = {
 	.event = {
-		.pmu = "cpu",
+		.pmu = "default_core",
 		.name = "eist_trans",
 		.event = "event=0x3a,period=200000,umask=0x0",
 		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
@@ -104,7 +104,7 @@ static const struct perf_pmu_test_event eist_trans = {
 
 static const struct perf_pmu_test_event l3_cache_rd = {
 	.event = {
-		.pmu = "cpu",
+		.pmu = "default_core",
 		.name = "l3_cache_rd",
 		.event = "event=0x40",
 		.desc = "L3 cache access, read",
@@ -391,8 +391,8 @@ static int compare_alias_to_test_event(struct pmu_event_info *alias,
 		return -1;
 	}
 
-
-	if (!is_same(alias->pmu_name, test_event->event.pmu)) {
+	if (!is_same(alias->pmu_name, test_event->event.pmu) &&
+	    !is_same(alias->pmu_name, "default_core")) {
 		pr_debug("testing aliases PMU %s: mismatched pmu_name, %s vs %s\n",
 			  pmu_name, alias->pmu_name, test_event->event.pmu);
 		return -1;
@@ -409,7 +409,7 @@ static int test__pmu_event_table_core_callback(const struct pmu_event *pe,
 	struct perf_pmu_test_event const **test_event_table;
 	bool found = false;
 
-	if (strcmp(pe->pmu, "cpu"))
+	if (strcmp(pe->pmu, "default_core"))
 		test_event_table = &uncore_events[0];
 	else
 		test_event_table = &core_events[0];
@@ -543,6 +543,7 @@ static int __test_core_pmu_event_aliases(const char *pmu_name, int *count)
 	INIT_LIST_HEAD(&pmu->caps);
 	INIT_LIST_HEAD(&pmu->list);
 	pmu->name = strdup(pmu_name);
+	pmu->is_core = true;
 
 	pmu->events_table = table;
 	pmu_add_cpu_aliases_table(pmu, table);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 502fd58c3ea7..cde33e01959a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1747,7 +1747,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
 {
 	return !strcmp(pmu->name, pmu_name) ||
-		(pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->name));
+		(pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->name)) ||
+		/*
+		 * jevents and tests use default_core as a marker for any core
+		 * PMU as the PMU name varies across architectures.
+		 */
+	        (pmu->is_core && !strcmp(pmu_name, "default_core"));
 }
 
 bool perf_pmu__is_software(const struct perf_pmu *pmu)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

