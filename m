Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51475E078
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGWIWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 04:22:32 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB99710D1;
        Sun, 23 Jul 2023 01:22:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vnzn8Vl_1690100542;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vnzn8Vl_1690100542)
          by smtp.aliyun-inc.com;
          Sun, 23 Jul 2023 16:22:23 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v4 1/4] perf metric: Event "Compat" value supports matching multiple identifiers
Date:   Sun, 23 Jul 2023 16:21:50 +0800
Message-Id: <1690100513-61165-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
 tools/perf/util/metricgroup.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f3559be..c910df0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -456,6 +456,31 @@ struct metricgroup_iter_data {
 	void *data;
 };
 
+static bool match_pmu_identifier(const char *id, const char *compat)
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
 static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 				       const struct pmu_metrics_table *table,
 				       void *data)
@@ -468,7 +493,7 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 
 	while ((pmu = perf_pmu__scan(pmu))) {
 
-		if (!pmu->id || strcmp(pmu->id, pm->compat))
+		if (!pmu->id || !match_pmu_identifier(pmu->id, pm->compat))
 			continue;
 
 		return d->fn(pm, table, d->data);
-- 
1.8.3.1

