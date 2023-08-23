Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398578552C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjHWKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHWIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:10:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30307170F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so10208571276.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778144; x=1693382944;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PD4Z1HSbPqI+PYDaeSuUcOyp8wCv3Hn6s79y+f2o9yA=;
        b=5Swm+ynQycOaHY2H3lvYnF5DCgbMCPp2Sv3OWE7qagiXgBCCe1boVE0WGq7nxQvXzj
         CNn4/Mi646rmZ5jdcfeOMnz+GzOD0RfaQplNuvosFY19OtuHo7JH5+Pq04S0x+QGfoOx
         /t8MT1BODTjIZnhFR0tnqucNCgXv3Jgfti30qWbWtnItV99BuNvd2QROwAFv/1tpd2fS
         hMriiLHHyevQS4UxahO9SboMcaXdyk3PQ888uvXfQZkEJvoDIcF0CrJI1q2KLudzmavK
         hAmsz7IFjIa8bltOi8moEOm6mZiloDrrYmYjgqUj+ExFzlL52mxHv5xKy77xXeYxoOAN
         qIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778144; x=1693382944;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD4Z1HSbPqI+PYDaeSuUcOyp8wCv3Hn6s79y+f2o9yA=;
        b=bywtLkK6vM7btBp+ylI7ShynBsUx1ybn2SHu20dHcuVlCN37Wx5iCxKOR0aPrkHyAq
         QvMWE1dpY/SGbpnc+QhBJjCIlG4aR/ubMAAzF2Hgrpf9RwhrAFRvpgDdwaQgfoQEYMFD
         tK+K/OrLwnGGqdSPrYrebSMkD6vrzJTZEfU/Blcfb6RADSyFEc/JKVd9cYnMbmv1e5FW
         Ogbp9iyLI+tGj63/lDtHkl5iwT2huGM/oc7mZ9jgrB9eR3+o7oFzcwtKqcfSbGpViUBv
         lo6g47CdqF2BTeBJJ3IqYNgVr+KGscIn5QeCdkmhmlJf90BTOL7/cbOEY55oOOpuJo2M
         P9CA==
X-Gm-Message-State: AOJu0YwYQniRyH7RHAsO4x7nM8KyrEBVCIWEDvnJwwY7r6UgPTzxtEAm
        4inN/qivuEQLM0IBs6Tf1x3+WOwbOeVL
X-Google-Smtp-Source: AGHT+IFnVPI8k6B5G+QH3e0Bj9Dymv4VB/FhRNCGu7sBVEICr0moxZQsYBAXUeR9HMtreYF/f10tZbQYtHKi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a05:6902:566:b0:d15:53b5:509f with SMTP id
 a6-20020a056902056600b00d1553b5509fmr185925ybt.2.1692778144480; Wed, 23 Aug
 2023 01:09:04 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:16 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-14-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 13/25] perf parse-events: Improve error message for double setting
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

Double setting information for an event would produce an error
message associated with the PMU rather than the term that was
double setting. Improve the error message to be on the term.

Before:
```
$ perf stat -e 'cpu/inst_retired.any,inst_retired.any/' true
event syntax error: 'cpu/inst_retired.any,inst_retired.any/'
                     \___ Bad event or PMU

Unabled to find PMU or event on a PMU of 'cpu'
Run 'perf list' for a list of valid events
```

After:
```
$ perf stat -e 'cpu/inst_retired.any,inst_retired.any/' true
event syntax error: '..etired.any,inst_retired.any/'
                                  \___ Bad event or PMU

Unabled to find PMU or event on a PMU of 'cpu'

Initial error:
event syntax error: '..etired.any,inst_retired.any/'
                                  \___ Attempt to set event's scale twice
Run 'perf list' for a list of valid events
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |  2 +-
 tools/perf/util/pmu.c          | 34 +++++++++++++++++++++++++++-------
 tools/perf/util/pmu.h          |  2 +-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7cad82a9f578..781747bedc3e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1348,7 +1348,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return evsel ? 0 : -ENOMEM;
 	}
 
-	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info))
+	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info, err))
 		return -EINVAL;
 
 	if (verbose > 1) {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 95872bee28ac..0036e41f6baf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1439,17 +1439,33 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 
 
 static int check_info_data(struct perf_pmu_alias *alias,
-			   struct perf_pmu_info *info)
+			   struct perf_pmu_info *info,
+			   struct parse_events_error *err,
+			   int column)
 {
 	/*
 	 * Only one term in event definition can
 	 * define unit, scale and snapshot, fail
 	 * if there's more than one.
 	 */
-	if ((info->unit && alias->unit[0]) ||
-	    (info->scale && alias->scale) ||
-	    (info->snapshot && alias->snapshot))
+	if (info->unit && alias->unit[0]) {
+		parse_events_error__handle(err, column,
+					strdup("Attempt to set event's unit twice"),
+					NULL);
+		return -EINVAL;
+	}
+	if (info->scale && alias->scale) {
+		parse_events_error__handle(err, column,
+					strdup("Attempt to set event's scale twice"),
+					NULL);
+		return -EINVAL;
+	}
+	if (info->snapshot && alias->snapshot) {
+		parse_events_error__handle(err, column,
+					strdup("Attempt to set event snapshot twice"),
+					NULL);
 		return -EINVAL;
+	}
 
 	if (alias->unit[0])
 		info->unit = alias->unit;
@@ -1468,7 +1484,7 @@ static int check_info_data(struct perf_pmu_alias *alias,
  * defined for the alias
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
-			  struct perf_pmu_info *info)
+			  struct perf_pmu_info *info, struct parse_events_error *err)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1489,10 +1505,14 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 		if (!alias)
 			continue;
 		ret = pmu_alias_terms(alias, &term->list);
-		if (ret)
+		if (ret) {
+			parse_events_error__handle(err, term->err_term,
+						strdup("Failure to duplicate terms"),
+						NULL);
 			return ret;
+		}
 
-		ret = check_info_data(alias, info);
+		ret = check_info_data(alias, info, err, term->err_term);
 		if (ret)
 			return ret;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f37e3d75094f..03211de345c1 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -185,7 +185,7 @@ int perf_pmu__config_terms(struct perf_pmu *pmu,
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
 int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
-			  struct perf_pmu_info *info);
+			  struct perf_pmu_info *info, struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
 int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load);
-- 
2.42.0.rc1.204.g551eb34607-goog

