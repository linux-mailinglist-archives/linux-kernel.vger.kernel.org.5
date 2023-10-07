Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9A7BC421
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjJGCOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjJGCOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:14:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C1C100
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:13:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso3888528276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 19:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644839; x=1697249639; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLkv57fF17zqRfpQp8SmIixiH1bpbCUPMZ8JZj8EM2M=;
        b=XxnTRAx7E6ffCQwPnXQtUjxD3n/quOBWFowClBnMNVB8xFJmrZkGoqUMRWh4YjX0lc
         5fa2hX0oXn0rLgfRVB9OkliYXPdgsoFv5cdlHlRa2oCzOpa/iJV1KjhSa9kSRJHL0+YH
         uMVAqUmzMFdErRvDpXBF/o81g2y3QRAhh8i25ugp9/lMmw+dLXu+xgIjztFJBEF3tz2d
         s+0l7x/ZmGjhWHuBuE5lfAiPvg/dyzf9kplzthdsoGcVPZBIlOFRD48JdFjfZuLLsVFR
         /QgqSmo495FbSXdq5Q085/1PtCdKwSNHUD22dRk6s9NjIBLbkIgzzaorQoL0ubdFpPxn
         MF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644839; x=1697249639;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLkv57fF17zqRfpQp8SmIixiH1bpbCUPMZ8JZj8EM2M=;
        b=KbVKEfuHMC1s497atEuHAtY15gwDXL6pVg5b7SeNYsmiqhGtfKb60BetNXwPTXzHh4
         s+C87WHK7G4c6nenRUq+o5gB0eY3IZl0WgCDJP9jInhWzhWC0UEncY2NBwxmHLe/4zsR
         hvSAa/wJJmMnYlK6gPqa9UbcWtp6sBNncGWwYzXmqHfc0nskZqOaqs31tkSj20AyMRPe
         8T6A+tPb45VLRhVRGm6vH8X+8vjs4mxenx0pTY/+UMxlOXopXTuq0qk2HYMbXIMNnC12
         bMUQIb3IFT+BZl6H7EgEd2+daXgraLKgvZN08PaV+QH1y3hbe5qcRqfGbmtRFqeNxZGL
         RiNA==
X-Gm-Message-State: AOJu0Yy5sqrRPdD7fPTI6sJvftibk5M3mwHsdRf4gxQQuqb7XdjCaTAS
        vaCFMkQW73VHkc/EZcYmawli7LQo/KmK
X-Google-Smtp-Source: AGHT+IFr63rp55RKJkbeuU4YrN+J9/EmAeZNALLBr+pqjB3TOHVhYPLvtNbiiLUo+VeXGDG6Gu0mRui9MaHH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a05:6902:990:b0:d89:4382:6d14 with SMTP id
 bv16-20020a056902099000b00d8943826d14mr156266ybb.6.1696644838851; Fri, 06 Oct
 2023 19:13:58 -0700 (PDT)
Date:   Fri,  6 Oct 2023 19:13:24 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-6-irogers@google.com>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 5/7] perf pmu: Const-ify perf_pmu__config_terms
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

Add const to related APIs, this is so they can be used to default
initialize a perf_event_attr from a const pmu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 10 +++++-----
 tools/perf/util/pmu.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e11901c923d7..eb17f00bd0d2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -156,7 +156,7 @@ static void __perf_pmu_format__load(struct perf_pmu_format *format, FILE *file)
 	format->loaded = true;
 }
 
-static void perf_pmu_format__load(struct perf_pmu *pmu, struct perf_pmu_format *format)
+static void perf_pmu_format__load(const struct perf_pmu *pmu, struct perf_pmu_format *format)
 {
 	char path[PATH_MAX];
 	FILE *file = NULL;
@@ -1132,7 +1132,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 }
 
 static struct perf_pmu_format *
-pmu_find_format(struct list_head *formats, const char *name)
+pmu_find_format(const struct list_head *formats, const char *name)
 {
 	struct perf_pmu_format *format;
 
@@ -1230,7 +1230,7 @@ static int pmu_resolve_param_term(struct parse_events_term *term,
 	return -1;
 }
 
-static char *pmu_formats_string(struct list_head *formats)
+static char *pmu_formats_string(const struct list_head *formats)
 {
 	struct perf_pmu_format *format;
 	char *str = NULL;
@@ -1256,7 +1256,7 @@ static char *pmu_formats_string(struct list_head *formats)
  * Setup one of config[12] attr members based on the
  * user input data - term parameter.
  */
-static int pmu_config_term(struct perf_pmu *pmu,
+static int pmu_config_term(const struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_terms *head_terms,
@@ -1379,7 +1379,7 @@ static int pmu_config_term(struct perf_pmu *pmu,
 	return 0;
 }
 
-int perf_pmu__config_terms(struct perf_pmu *pmu,
+int perf_pmu__config_terms(const struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_terms *terms,
 			   bool zero, struct parse_events_error *err)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 24af7297b522..5a05131aa4ce 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -193,7 +193,7 @@ void pmu_add_sys_aliases(struct perf_pmu *pmu);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct parse_events_terms *head_terms,
 		     struct parse_events_error *error);
-int perf_pmu__config_terms(struct perf_pmu *pmu,
+int perf_pmu__config_terms(const struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_terms *terms,
 			   bool zero, struct parse_events_error *error);
-- 
2.42.0.609.gbb76f46606-goog

