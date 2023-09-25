Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC17ACFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjIYF6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIYF6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:58:36 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421BDA;
        Sun, 24 Sep 2023 22:58:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vsl7J1V_1695621503;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vsl7J1V_1695621503)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 13:58:24 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v10 1/7] perf pmu: "Compat" supports regular expression matching identifiers
Date:   Mon, 25 Sep 2023 13:57:18 +0800
Message-Id: <1695621444-56530-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jevent "Compat" is used for uncore PMU alias or metric definitions.

The same PMU driver has different PMU identifiers due to different
hardware versions and types, but they may have some common PMU event.
Since a Compat value can only match one identifier, when adding the
same event alias to PMUs with different identifiers, each identifier
needs to be defined once, which is not streamlined enough.

So let "Compat" support using regular expression to match identifiers
for uncore PMU alias. For example, if the "Compat" value is set to
"43401|43c01", it would be able to match PMU identifiers such as "43401"
or "43c01", which correspond to CMN600_r0p0 or CMN700_r0p0.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/util/pmu.c | 27 +++++++++++++++++++++++++--
 tools/perf/util/pmu.h |  1 +
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e215985..a5bb9a8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -28,6 +28,7 @@
 #include "strbuf.h"
 #include "fncache.h"
 #include "util/evsel_config.h"
+#include <regex.h>
 
 struct perf_pmu perf_pmu__fake = {
 	.name = "fake",
@@ -875,6 +876,28 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	return res;
 }
 
+bool pmu_uncore_identifier_match(const char *compat, const char *id)
+{
+	regex_t re;
+	regmatch_t pmatch[1];
+	int match;
+
+	if (regcomp(&re, compat, REG_EXTENDED) != 0) {
+		/* Warn unable to generate match particular string. */
+		pr_info("Invalid regular expression %s\n", compat);
+		return false;
+	}
+
+	match = !regexec(&re, id, 1, pmatch, 0);
+	if (match) {
+		/* Ensure a full match. */
+		match = pmatch[0].rm_so == 0 && (size_t)pmatch[0].rm_eo == strlen(id);
+	}
+	regfree(&re);
+
+	return match;
+}
+
 static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 					const struct pmu_events_table *table __maybe_unused,
 					void *vdata)
@@ -915,8 +938,8 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 	if (!pe->compat || !pe->pmu)
 		return 0;
 
-	if (!strcmp(pmu->id, pe->compat) &&
-	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
+	if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
+			pmu_uncore_identifier_match(pe->compat, pmu->id)) {
 		perf_pmu__new_alias(pmu,
 				pe->name,
 				pe->desc,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index bd5d804..fc155ce 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -240,6 +240,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
 char *perf_pmu__getcpuid(struct perf_pmu *pmu);
 const struct pmu_events_table *pmu_events_table__find(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
+bool pmu_uncore_identifier_match(const char *compat, const char *id);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
-- 
1.8.3.1

