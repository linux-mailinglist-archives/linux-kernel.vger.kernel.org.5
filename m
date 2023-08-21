Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E86782591
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjHUIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjHUIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:36:33 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC44B5;
        Mon, 21 Aug 2023 01:36:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VqEq8BB_1692606986;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VqEq8BB_1692606986)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 16:36:27 +0800
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
Subject: [PATCH v7 1/8] perf pmu: "Compat" supports matching multiple identifiers
Date:   Mon, 21 Aug 2023 16:36:10 +0800
Message-Id: <1692606977-92009-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
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

So let "Compat" supports matching multiple identifiers for uncore PMU
alias. For example, the Compat value {43401;436*} can match the PMU
identifier "43401", that is, CMN600_r0p0, and the PMU identifier with
the prefix "436", that is, all CMN650, where "*" is a wildcard.
Tokens in Unit field are delimited by ';' with no spaces.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++++++++++++++--
 tools/perf/util/pmu.h |  1 +
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ad209c8..6402423 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -776,6 +776,35 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	return res;
 }
 
+bool pmu_uncore_identifier_match(const char *id, const char *compat)
+{
+	char *tmp = NULL, *tok, *str;
+	bool res;
+	int n;
+
+	/*
+	 * The strdup() call is necessary here because "compat" is a const str*
+	 * type and cannot be used as an argument to strtok_r().
+	 */
+	str = strdup(compat);
+	if (!str)
+		return false;
+
+	tok = strtok_r(str, ";", &tmp);
+	for (; tok; tok = strtok_r(NULL, ";", &tmp)) {
+		n = strlen(tok);
+		if ((tok[n - 1] == '*' && !strncmp(id, tok, n - 1)) ||
+		    !strcmp(id, tok)) {
+			res = true;
+			goto out;
+		}
+	}
+	res = false;
+out:
+	free(str);
+	return res;
+}
+
 struct pmu_add_cpu_aliases_map_data {
 	struct list_head *head;
 	const char *name;
@@ -847,8 +876,8 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 	if (!pe->compat || !pe->pmu)
 		return 0;
 
-	if (!strcmp(pmu->id, pe->compat) &&
-	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
+	if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
+	    pmu_uncore_identifier_match(pmu->id, pe->compat)) {
 		__perf_pmu__new_alias(idata->head, -1,
 				      (char *)pe->name,
 				      (char *)pe->desc,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b9a02de..9d4385d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -241,6 +241,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
 char *perf_pmu__getcpuid(struct perf_pmu *pmu);
 const struct pmu_events_table *pmu_events_table__find(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
+bool pmu_uncore_identifier_match(const char *id, const char *compat);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
-- 
1.8.3.1

