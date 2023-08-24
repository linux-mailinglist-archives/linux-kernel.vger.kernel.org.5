Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ACA786696
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbjHXEOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbjHXEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545441709
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58daaa2ba65so81977167b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850433; x=1693455233;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ya/35txba4PAMPm8mMBnt/qSzsiHQTJEwaXtI6KarCw=;
        b=3VJfTM8kygD1T1PhmetM3PcBE1gQOcO3+ThUAN3fhGzT28M9PgychNxNpP8peY3l/g
         k9+S2Se3TL+up6K3bfFmxk1xOnuF1cgcM2yIFbQvyrLPjU8Ft0xRNjCskCm0lsM288DD
         ACZrScqJDpli5CCdWIHkT1NdEb/pj6wefraP7EBz5lTS3s24jmfIAGCARmB6Q1uYIL2J
         deXcbqUmoSWMIDh83MmYyXKLdpouS5M2bMGZqtEIRfHnfE6+mhzycoAS7dAA1WCN9LkB
         Tsrb5E1MJTU1BKSMcQuOyF7txVS9AK2kogzSobXJyFlhzxLCuQbeP4sJpc758bYbmEt0
         A6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850433; x=1693455233;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya/35txba4PAMPm8mMBnt/qSzsiHQTJEwaXtI6KarCw=;
        b=DFVwrl580P4IVSsLm8Fq0ZiY26lmRg7UsLiThRIEgl5L/Fax686w3f8Q5Wq6yEbLxf
         jLGuh9jW42dtvj0TIKsBxLX9oJFlIyx7ZITI/n3P7IJxfoRXWiSrLa72IMerKU48RYEz
         DBzVflEuHam09uI15rbTeUh4UBlRD4H5qTiMg4JW9ZjckIEmOTWDX9IeePqqIspufkOl
         jyr6gtElTlhwO4yXP+7S6ibJ6ZWFb6vMG06oQgLW4jNRG+5lfhv6o1iCcV8tXIp9fX1m
         JvcrGleWdRMnTown44U2ZLQOEnOO2W+yKoSzEM0p7Vxi6LifO7Hc1IkRuFLX68yHpznY
         JksQ==
X-Gm-Message-State: AOJu0YwPvAaZH3nCCs7bt0zFGlKC6nMX7Ag2CQEHZ0eSYAdcybbRYlER
        yH0uLQLmRbYtLzSWPut+hXlUis3dhmYB
X-Google-Smtp-Source: AGHT+IE7hk7aF5+o9K3xOuDaJwbkY2h6VIkgNVR7fuUCCjnbEaQYcnKDvLAmGG0IIa2nrQLjSHBXq2VjRk1S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a81:ad43:0:b0:576:af04:3495 with SMTP id
 l3-20020a81ad43000000b00576af043495mr201866ywk.9.1692850433482; Wed, 23 Aug
 2023 21:13:53 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:17 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-6-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 05/18] perf parse-events: Improve error message for double setting
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index d91367155e29..0c82bbeea7d6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1443,17 +1443,33 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 
 
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
@@ -1472,7 +1488,7 @@ static int check_info_data(struct perf_pmu_alias *alias,
  * defined for the alias
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
-			  struct perf_pmu_info *info)
+			  struct perf_pmu_info *info, struct parse_events_error *err)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1493,10 +1509,14 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
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

