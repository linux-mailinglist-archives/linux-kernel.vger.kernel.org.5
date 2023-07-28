Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BC766401
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjG1GRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjG1GRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:17:37 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13230272C;
        Thu, 27 Jul 2023 23:17:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VoOxEHt_1690525049;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VoOxEHt_1690525049)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 14:17:30 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v5 1/5] perf metric: Event "Compat" value supports matching multiple identifiers
Date:   Fri, 28 Jul 2023 14:17:16 +0800
Message-Id: <1690525040-77423-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jevent "Compat" is used for uncore PMU alias or metric definitions.

The same PMU driver has different PMU identifiers due to different hardware
versions and types, but they may have some common PMU event/metric. Since a
Compat value can only match one identifier, when adding the same event
alias and metric to PMUs with different identifiers, each identifier needs
to be defined once, which is not streamlined enough.

So let "Compat" value supports matching multiple identifiers. For example,
the Compat value {abcde;123*} can match the PMU identifier "abcde" and the
the PMU identifier with the prefix "123", where "*" is a wildcard.
Tokens in Unit field are delimited by ';' with no spaces.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/util/metricgroup.c |  2 +-
 tools/perf/util/pmu.c         | 27 ++++++++++++++++++++++++++-
 tools/perf/util/pmu.h         |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 5e9c657..ff81bc5 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -477,7 +477,7 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 
 	while ((pmu = perf_pmu__scan(pmu))) {
 
-		if (!pmu->id || strcmp(pmu->id, pm->compat))
+		if (!pmu->id || !pmu_uncore_identifier_match(pmu->id, pm->compat))
 			continue;
 
 		return d->fn(pm, table, d->data);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ad209c8..3ae249b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -776,6 +776,31 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	return res;
 }
 
+bool pmu_uncore_identifier_match(const char *id, const char *compat)
+{
+	char *tmp = NULL, *tok, *str;
+	bool res;
+	int n;
+
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
@@ -847,7 +872,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 	if (!pe->compat || !pe->pmu)
 		return 0;
 
-	if (!strcmp(pmu->id, pe->compat) &&
+	if (pmu_uncore_identifier_match(pmu->id, pe->compat) &&
 	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
 		__perf_pmu__new_alias(idata->head, -1,
 				      (char *)pe->name,
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

