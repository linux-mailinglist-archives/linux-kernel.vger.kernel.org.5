Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88F7C7549
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442066AbjJLR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442039AbjJLR5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:57:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E85AEE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:57:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so1020931276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133421; x=1697738221; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGZZkKhNq9JhzWRjca3M7jYSu+YUOulkgrRkrXoPM5M=;
        b=RfbCr3WkTW93Hl0hg8e8vr6OVtQf2LDulNPp0n5HwjPA70073Jo6Q1H7nYVZ8N/BsT
         0ku5q+fiMc4X2GZdege9jhPdOsLrJ7KefXsuslt+QqXyhaec5a6lMd7ilfR+KkFKEhMf
         yM3LD22vH18Fbe5AJFsNBhYBI7EtpiGgKkalRGiV3MXmJlqFA7VbQ9MHSi4A2AnhYyAt
         5di9ookNmiFkGChRiol/bEbIDaodwQpt39YfVej0Pf1Kguc6171vHnOQsoC9YWZMG7/Y
         SROA3mVS7ABZPbzpgf0APyjzTxa2UwjhMpCCksoEf+91in3eBn46k4m2KrNqbqzsCoUd
         vpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133421; x=1697738221;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGZZkKhNq9JhzWRjca3M7jYSu+YUOulkgrRkrXoPM5M=;
        b=GcrXv+3eG3yynrMjzXXv4iAwVBi9twatpocoy3Q5pKrFJB3FtYBZt22dweRHh5EjN9
         J0bNtkON0fG42sPm/9MoipzZESPTTfzOl6PSepQgdF3P3j+rrKK5zfpabf3uS5tfYAkN
         dpW2AGWaDjJomwaq9YJiewHfNCvauKZ38fzlj8qpJ7ahatYi2vbb3Ulq0s+QlIJONmm/
         HQtXH3P35baY1wtKMd/Y5XVuIM4UmJtS3CTtErhPRd6ct1TIqAWMoMsX+rOOSroE4Gsu
         uma6ZWNA4rVJbpouOUEuTCF6ziXDS6wLLgbq2SNtZcgZgQRQsbhBzIyoPxp0g8W9rgmK
         53Wg==
X-Gm-Message-State: AOJu0YybrjYkgX2KrUkFJINlHYDi/VZi6NdGlRy74UKYL41TlBnaiWH5
        8cgzcngTbfh34Spwe5YP33TcNqq4wjKh
X-Google-Smtp-Source: AGHT+IHTKgK+yuYh/bRPWkszxDVh6q8dnKyNPr4dauQPExJDguQIHt7Uvuk3TAG5uSLdYp/0Ozmpw0s8FfkJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a25:f609:0:b0:d7e:78db:d264 with SMTP id
 t9-20020a25f609000000b00d7e78dbd264mr468922ybd.5.1697133421379; Thu, 12 Oct
 2023 10:57:01 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:56:43 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-6-irogers@google.com>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 5/7] perf pmu: Const-ify perf_pmu__config_terms
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/pmu.c | 10 +++++-----
 tools/perf/util/pmu.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 861e485e0a70..8ef675ea7bdd 100644
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
@@ -1131,7 +1131,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 }
 
 static struct perf_pmu_format *
-pmu_find_format(struct list_head *formats, const char *name)
+pmu_find_format(const struct list_head *formats, const char *name)
 {
 	struct perf_pmu_format *format;
 
@@ -1229,7 +1229,7 @@ static int pmu_resolve_param_term(struct parse_events_term *term,
 	return -1;
 }
 
-static char *pmu_formats_string(struct list_head *formats)
+static char *pmu_formats_string(const struct list_head *formats)
 {
 	struct perf_pmu_format *format;
 	char *str = NULL;
@@ -1255,7 +1255,7 @@ static char *pmu_formats_string(struct list_head *formats)
  * Setup one of config[12] attr members based on the
  * user input data - term parameter.
  */
-static int pmu_config_term(struct perf_pmu *pmu,
+static int pmu_config_term(const struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_terms *head_terms,
@@ -1378,7 +1378,7 @@ static int pmu_config_term(struct perf_pmu *pmu,
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
2.42.0.655.g421f12c284-goog

