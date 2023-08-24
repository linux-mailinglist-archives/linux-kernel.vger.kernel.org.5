Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F0786693
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjHXEOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbjHXEOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036CE10F8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:04 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68bec4380edso684194b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850444; x=1693455244;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ku/PeRxKaif+dkdteyruZlpIYwvGD2n5K2YcrlXrw2Y=;
        b=tJaB+f3U3NDQihRCgujIS/E+HcUmmfCazkrt8v7cXpvYqp+B/jOtJdaI40vNmv2x1b
         ESvfh3C+qKP98m4ezaJkauMbTLYfNckoDKPnipiY7yMatx2OIrQhDOBj87YsHICvh36P
         bejc+Q6+RgvhLNUFWe6IJDAYOXzAzuord4VNne+xfnUcVS9bcriE1FKNQYJQCF4RgFsK
         YnMXq2kv5dwu2fTZAywoor7KyFkNm/H0KRyCTKH5ja8zj9u6tEFx1WUHEMahK3gLfvBD
         OKkHfQEv5gByGfKzN5LWxWGFQq7inJ9vaB8G9vDdtya36lK/+yxWZBYQpfWO8YD9xFTU
         OqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850444; x=1693455244;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ku/PeRxKaif+dkdteyruZlpIYwvGD2n5K2YcrlXrw2Y=;
        b=lyMuhrfjSQVR+SZ/1xoBR5CqPP8s+89jt1t3MxtljqCJj1hp/SgUyEfG9SLNGRuJAw
         i1+JC4rtp2DHSJqjWedb6eb0d5By8L87mltX57JsxxYf0036XF9PhNcXZ1nXdM2mHZ8H
         8mBH2zhjiGrXrko9Wvh/efA1g1AHXPs7XOqMjznFWgAx9pxot2rWHZbmyVVy5dheWvuS
         zKv6xyXxlV0P7Q34SOnfBbGwtVbG4QtXA70MGciBasOh4yI+FJ0heq5FcAE46xN0UZdj
         GTkRD6FDfgKH6sq+TjV4+R7ysTU0KK98/XUfcoTEJfmeAvOhCVarKW3OlB9PUPl4pfqK
         OCMw==
X-Gm-Message-State: AOJu0Yw0fJrEB0YxCMB2MS59r/t6Ww7GRg+/A2d88MQz9Awsh30Y+0Cq
        9pKnv6MKRoiEg187xdXGKP8uWzoySHwD
X-Google-Smtp-Source: AGHT+IHOGhZ77r+ppBYQE2gKe2KzEGzY2KEBeQYg80WYkmpW9p1SGvNmvEGaS0gILNjRMxbz55ij0Afi7sAF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a05:6a00:27ab:b0:68a:5e6f:9975 with SMTP
 id bd43-20020a056a0027ab00b0068a5e6f9975mr2216084pfb.1.1692850444397; Wed, 23
 Aug 2023 21:14:04 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:21 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-10-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 09/18] perf pmu: Parse sysfs events directly from a file
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

Rather than read a sysfs events file into a 256 byte char buffer, pass
the FILE* directly to the lex/yacc parser. This avoids there being a
maximum events file size. While changing the API, constify some
arguments to remove unnecessary casts. Allocating the read buffer
decreases the performance of pmu-scan by around 3%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c |  2 +-
 tools/perf/tests/parse-events.c     |  2 +-
 tools/perf/util/parse-events.c      | 18 +++++++----
 tools/perf/util/parse-events.h      |  3 +-
 tools/perf/util/pmu.c               | 48 ++++++++++-------------------
 5 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 27944c15ac14..31807791589e 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -74,7 +74,7 @@ static int intel_pt_parse_terms_with_default(struct perf_pmu *pmu,
 
 	INIT_LIST_HEAD(terms);
 
-	err = parse_events_terms(terms, str);
+	err = parse_events_terms(terms, str, /*input=*/ NULL);
 	if (err)
 		goto out_free;
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 658fb9599d95..d86076d575ed 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2472,7 +2472,7 @@ static int test_term(const struct terms_test *t)
 
 	INIT_LIST_HEAD(&terms);
 
-	ret = parse_events_terms(&terms, t->str);
+	ret = parse_events_terms(&terms, t->str, /*input=*/ NULL);
 	if (ret) {
 		pr_debug("failed to parse terms '%s', err %d\n",
 			 t->str , ret);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 781747bedc3e..c71e135d7335 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1715,6 +1715,7 @@ int parse_events_name(struct list_head *list, const char *name)
 }
 
 static int parse_events__scanner(const char *str,
+				 FILE *input,
 				 struct parse_events_state *parse_state)
 {
 	YY_BUFFER_STATE buffer;
@@ -1725,7 +1726,10 @@ static int parse_events__scanner(const char *str,
 	if (ret)
 		return ret;
 
-	buffer = parse_events__scan_string(str, scanner);
+	if (str)
+		buffer = parse_events__scan_string(str, scanner);
+	else
+	        parse_events_set_in(input, scanner);
 
 #ifdef PARSER_DEBUG
 	parse_events_debug = 1;
@@ -1733,8 +1737,10 @@ static int parse_events__scanner(const char *str,
 #endif
 	ret = parse_events_parse(parse_state, scanner);
 
-	parse_events__flush_buffer(buffer, scanner);
-	parse_events__delete_buffer(buffer, scanner);
+	if (str) {
+		parse_events__flush_buffer(buffer, scanner);
+		parse_events__delete_buffer(buffer, scanner);
+	}
 	parse_events_lex_destroy(scanner);
 	return ret;
 }
@@ -1742,7 +1748,7 @@ static int parse_events__scanner(const char *str,
 /*
  * parse event config string, return a list of event terms.
  */
-int parse_events_terms(struct list_head *terms, const char *str)
+int parse_events_terms(struct list_head *terms, const char *str, FILE *input)
 {
 	struct parse_events_state parse_state = {
 		.terms  = NULL,
@@ -1750,7 +1756,7 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, &parse_state);
+	ret = parse_events__scanner(str, input, &parse_state);
 
 	if (!ret) {
 		list_splice(parse_state.terms, terms);
@@ -2001,7 +2007,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	};
 	int ret, ret2;
 
-	ret = parse_events__scanner(str, &parse_state);
+	ret = parse_events__scanner(str, /*input=*/ NULL, &parse_state);
 
 	if (!ret && list_empty(&parse_state.list)) {
 		WARN_ONCE(true, "WARNING: event parser found nothing\n");
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 411f69b2ac3a..c7f779420723 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include <linux/types.h>
 #include <linux/perf_event.h>
+#include <stdio.h>
 #include <string.h>
 
 struct evsel;
@@ -42,7 +43,7 @@ static inline int parse_events(struct evlist *evlist, const char *str,
 
 int parse_event(struct evlist *evlist, const char *str);
 
-int parse_events_terms(struct list_head *terms, const char *str);
+int parse_events_terms(struct list_head *terms, const char *str, FILE *input);
 int parse_filter(const struct option *opt, const char *str, int unset);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9ba9ac3d3d96..263c63eabc2e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -280,7 +280,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
 	return ret;
 }
 
-static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, int dirfd, char *name)
+static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, int dirfd, const char *name)
 {
 	struct stat st;
 	ssize_t sret;
@@ -312,7 +312,7 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, int dirfd, char *
 	return ret;
 }
 
-static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, int dirfd, char *name)
+static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, int dirfd, const char *name)
 {
 	char path[PATH_MAX];
 	ssize_t sret;
@@ -343,7 +343,7 @@ static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, int dirfd, char *n
 }
 
 static int
-perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, int dirfd, char *name)
+perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, int dirfd, const char *name)
 {
 	char path[PATH_MAX];
 	int fd;
@@ -361,7 +361,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, int dirfd, char *name)
 }
 
 static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
-				    int dirfd, char *name)
+				    int dirfd, const char *name)
 {
 	char path[PATH_MAX];
 	int fd;
@@ -454,8 +454,9 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 	return false;
 }
 
-static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char *name,
-				 char *desc, char *val, const struct pmu_event *pe)
+static int perf_pmu__new_alias(struct list_head *list, int dirfd, const char *name,
+				const char *desc, const char *val, FILE *val_fd,
+				const struct pmu_event *pe)
 {
 	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
@@ -484,7 +485,7 @@ static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char *name,
 	alias->snapshot = false;
 	alias->deprecated = deprecated;
 
-	ret = parse_events_terms(&alias->terms, val);
+	ret = parse_events_terms(&alias->terms, val, val_fd);
 	if (ret) {
 		pr_err("Cannot parse alias %s: %d\n", val, ret);
 		free(alias);
@@ -541,23 +542,6 @@ static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char *name,
 	return 0;
 }
 
-static int perf_pmu__new_alias(struct list_head *list, int dirfd, char *name, FILE *file)
-{
-	char buf[256];
-	int ret;
-
-	ret = fread(buf, 1, sizeof(buf), file);
-	if (ret == 0)
-		return -EINVAL;
-
-	buf[ret] = 0;
-
-	/* Remove trailing newline from sysfs file */
-	strim(buf);
-
-	return __perf_pmu__new_alias(list, dirfd, name, NULL, buf, NULL);
-}
-
 static inline bool pmu_alias_info_file(char *name)
 {
 	size_t len;
@@ -613,7 +597,8 @@ static int pmu_aliases_parse(int dirfd, struct list_head *head)
 			continue;
 		}
 
-		if (perf_pmu__new_alias(head, dirfd, name, file) < 0)
+		if (perf_pmu__new_alias(head, dirfd, name, /*desc=*/ NULL,
+					/*val=*/ NULL, file, /*pe=*/ NULL) < 0)
 			pr_debug("Cannot set up %s\n", name);
 		fclose(file);
 	}
@@ -866,7 +851,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 	struct list_head *head = vdata;
 
 	/* need type casts to override 'const' */
-	__perf_pmu__new_alias(head, -1, (char *)pe->name, (char *)pe->desc, (char *)pe->event, pe);
+	perf_pmu__new_alias(head, -1, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
 	return 0;
 }
 
@@ -907,11 +892,12 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 
 	if (!strcmp(pmu->id, pe->compat) &&
 	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
-		__perf_pmu__new_alias(idata->head, -1,
-				      (char *)pe->name,
-				      (char *)pe->desc,
-				      (char *)pe->event,
-				      pe);
+		perf_pmu__new_alias(idata->head, -1,
+				pe->name,
+				pe->desc,
+				pe->event,
+				/*val_fd=*/ NULL,
+				pe);
 	}
 
 	return 0;
-- 
2.42.0.rc1.204.g551eb34607-goog

