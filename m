Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3BE785278
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjHWIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjHWIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C3D10D4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58daaa2ba65so71818157b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778124; x=1693382924;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jym/Q9Cr+MhizGwXbSqum8wmQGZbYfoo8L/RYHAVGYI=;
        b=p6rxfOIeIODcysFAWsHNOWrLMG4rt15KirX2sKKna3VSQWIqC6Bw1i7Ag6AUFqxDks
         YKs24ByI6lzYE0E+S0P4P/I7eOhR/Q4eU/rW3hK5r36OyRJW5T768FUpMlTIy+/aRbEA
         tNmnHqE7S8TlEolvBoBjILqvctFTM7xxNzlWMUz9j5OQW+8nyaFP4zV78bwhdmWjQqdj
         m2rs7x2mqAK8NxBM7MkBBmCvCmpgD2o1HEMk3rgKqovnMOeSWp82+hwbYE5DLqMnQoaR
         lXAMHrYuDnUHae1YabhaNOuyo14wKoZC46gEn5u5YtdBwVIJGYGgMJa8uZ4i1tAYhY8E
         +P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778124; x=1693382924;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jym/Q9Cr+MhizGwXbSqum8wmQGZbYfoo8L/RYHAVGYI=;
        b=kRTF5zgW0/riGvZ1lwDAecA1gN0I8sOrcIB2CFZjM1e8KdAfQo92TC5yXrS43XBj5I
         kMEDaHlqO++My0Ho4kXB32JjUNmYYssLW/n6IdMfVnoabHjofBUSQ2s7fxAICd5ieOZG
         JQaLYm34DpW/wOVgHTXC1BvAibndJln0n0LzuzcyCZuf9sM0kLthiHSavoIT6kq947Qz
         Ao1go1quauUbCzv1lUnVM1hMA8YpDdQNf/Oyve7FoFmnn+zKFfP1aGHBCZBBQkuLlFIW
         90udVEQ306Yn2AIIXEMvQGl3Zr3Poun2oe+NN9UG4es8ShKpFcyeJ6PUC7Zcfe8e+POD
         R3xg==
X-Gm-Message-State: AOJu0YwXLvo248mqwoz4JNF7dsqzcfCfI6Ol4o5W9Lghi1WOeAE3jj9A
        uSlwGCjkGO/wjNdD/pIgn0lqwLyFI7p/
X-Google-Smtp-Source: AGHT+IEVWyiF5BqffF0E5MhAlyi3ZQbkFU6BCWy7VFF+QeimKO9j+BK7Y5lEsP1+QOqf5PjAnIr7QUwHgF+Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a81:ae55:0:b0:589:a3d3:2f60 with SMTP id
 g21-20020a81ae55000000b00589a3d32f60mr153110ywk.8.1692778124461; Wed, 23 Aug
 2023 01:08:44 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:08 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-6-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 05/25] perf pmu: Avoid passing format list to perf_pmu__config_terms
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

Abstract the format list better, hiding it in the PMU, by changing
perf_pmu__config_terms the PMU rather than the format list in the
PMU. Change the PMU test to pass a dummy PMU for this
purpose. Changing the test allows perf_pmu__del_formats to become
static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 30 ++++--------
 tools/perf/tests/pmu.c              | 76 ++++++++++++++++-------------
 tools/perf/util/pmu.c               | 19 +++-----
 tools/perf/util/pmu.h               |  3 +-
 4 files changed, 61 insertions(+), 67 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 74b70fd379df..0da76f848cbc 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -60,8 +60,7 @@ struct intel_pt_recording {
 	size_t				priv_size;
 };
 
-static int intel_pt_parse_terms_with_default(const char *pmu_name,
-					     struct list_head *formats,
+static int intel_pt_parse_terms_with_default(struct perf_pmu *pmu,
 					     const char *str,
 					     u64 *config)
 {
@@ -80,8 +79,7 @@ static int intel_pt_parse_terms_with_default(const char *pmu_name,
 		goto out_free;
 
 	attr.config = *config;
-	err = perf_pmu__config_terms(pmu_name, formats, &attr, terms, true,
-				     NULL);
+	err = perf_pmu__config_terms(pmu, &attr, terms, /*zero=*/true, /*err=*/NULL);
 	if (err)
 		goto out_free;
 
@@ -91,12 +89,10 @@ static int intel_pt_parse_terms_with_default(const char *pmu_name,
 	return err;
 }
 
-static int intel_pt_parse_terms(const char *pmu_name, struct list_head *formats,
-				const char *str, u64 *config)
+static int intel_pt_parse_terms(struct perf_pmu *pmu, const char *str, u64 *config)
 {
 	*config = 0;
-	return intel_pt_parse_terms_with_default(pmu_name, formats, str,
-						 config);
+	return intel_pt_parse_terms_with_default(pmu, str, config);
 }
 
 static u64 intel_pt_masked_bits(u64 mask, u64 bits)
@@ -236,8 +232,7 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
 
 	pr_debug2("%s default config: %s\n", intel_pt_pmu->name, buf);
 
-	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format, buf,
-			     &config);
+	intel_pt_parse_terms(intel_pt_pmu, buf, &config);
 
 	close(dirfd);
 	return config;
@@ -348,16 +343,12 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	if (priv_size != ptr->priv_size)
 		return -EINVAL;
 
-	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
-			     "tsc", &tsc_bit);
-	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
-			     "noretcomp", &noretcomp_bit);
-	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
-			     "mtc", &mtc_bit);
+	intel_pt_parse_terms(intel_pt_pmu, "tsc", &tsc_bit);
+	intel_pt_parse_terms(intel_pt_pmu, "noretcomp", &noretcomp_bit);
+	intel_pt_parse_terms(intel_pt_pmu, "mtc", &mtc_bit);
 	mtc_freq_bits = perf_pmu__format_bits(&intel_pt_pmu->format,
 					      "mtc_period");
-	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
-			     "cyc", &cyc_bit);
+	intel_pt_parse_terms(intel_pt_pmu, "cyc", &cyc_bit);
 
 	intel_pt_tsc_ctc_ratio(&tsc_ctc_ratio_n, &tsc_ctc_ratio_d);
 
@@ -781,8 +772,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
 	}
 
-	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
-			     "tsc", &tsc_bit);
+	intel_pt_parse_terms(intel_pt_pmu, "tsc", &tsc_bit);
 
 	if (opts->full_auxtrace && (intel_pt_evsel->core.attr.config & tsc_bit))
 		have_timing_info = true;
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index a4452639a3d4..a4a43db76012 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/zalloc.h>
 
 /* Simulated format definitions. */
 static struct test_format {
@@ -141,48 +142,55 @@ static struct list_head *test_terms_list(void)
 static int test__pmu(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	char dir[PATH_MAX];
-	char *format = test_format_dir_get(dir, sizeof(dir));
-	LIST_HEAD(formats);
+	char *format;
 	struct list_head *terms = test_terms_list();
+	struct perf_event_attr attr;
+	struct perf_pmu *pmu;
+	int fd;
 	int ret;
 
-	if (!format)
-		return -EINVAL;
-
-	do {
-		struct perf_event_attr attr;
-		int fd;
-
-		memset(&attr, 0, sizeof(attr));
-
-		fd = open(format, O_DIRECTORY);
-		if (fd < 0) {
-			ret = fd;
-			break;
-		}
-		ret = perf_pmu__format_parse(fd, &formats);
-		if (ret)
-			break;
-
-		ret = perf_pmu__config_terms("perf-pmu-test", &formats, &attr,
-					     terms, false, NULL);
-		if (ret)
-			break;
+	pmu = zalloc(sizeof(*pmu));
+	if (!pmu)
+		return -ENOMEM;
 
-		ret = -EINVAL;
+	INIT_LIST_HEAD(&pmu->format);
+	INIT_LIST_HEAD(&pmu->aliases);
+	INIT_LIST_HEAD(&pmu->caps);
+	format = test_format_dir_get(dir, sizeof(dir));
+	if (!format) {
+		free(pmu);
+		return -EINVAL;
+	}
 
-		if (attr.config  != 0xc00000000002a823)
-			break;
-		if (attr.config1 != 0x8000400000000145)
-			break;
-		if (attr.config2 != 0x0400000020041d07)
-			break;
+	memset(&attr, 0, sizeof(attr));
 
-		ret = 0;
-	} while (0);
+	fd = open(format, O_DIRECTORY);
+	if (fd < 0) {
+		ret = fd;
+		goto out;
+	}
 
-	perf_pmu__del_formats(&formats);
+	pmu->name = strdup("perf-pmu-test");
+	ret = perf_pmu__format_parse(fd, &pmu->format);
+	if (ret)
+		goto out;
+
+	ret = perf_pmu__config_terms(pmu, &attr, terms, /*zero=*/false, /*err=*/NULL);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
+	if (attr.config  != 0xc00000000002a823)
+		goto out;
+	if (attr.config1 != 0x8000400000000145)
+		goto out;
+	if (attr.config2 != 0x0400000020041d07)
+		goto out;
+
+	ret = 0;
+out:
 	test_format_dir_put(format);
+	perf_pmu__delete(pmu);
 	return ret;
 }
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 40999e1fab8f..89573a8eaf0b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1135,8 +1135,7 @@ static char *pmu_formats_string(struct list_head *formats)
  * Setup one of config[12] attr members based on the
  * user input data - term parameter.
  */
-static int pmu_config_term(const char *pmu_name,
-			   struct list_head *formats,
+static int pmu_config_term(struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct list_head *head_terms,
@@ -1160,15 +1159,15 @@ static int pmu_config_term(const char *pmu_name,
 	if (parse_events__is_hardcoded_term(term))
 		return 0;
 
-	format = pmu_find_format(formats, term->config);
+	format = pmu_find_format(&pmu->format, term->config);
 	if (!format) {
-		char *pmu_term = pmu_formats_string(formats);
+		char *pmu_term = pmu_formats_string(&pmu->format);
 		char *unknown_term;
 		char *help_msg;
 
 		if (asprintf(&unknown_term,
 				"unknown term '%s' for pmu '%s'",
-				term->config, pmu_name) < 0)
+				term->config, pmu->name) < 0)
 			unknown_term = NULL;
 		help_msg = parse_events_formats_error_string(pmu_term);
 		if (err) {
@@ -1259,7 +1258,7 @@ static int pmu_config_term(const char *pmu_name,
 	return 0;
 }
 
-int perf_pmu__config_terms(const char *pmu_name, struct list_head *formats,
+int perf_pmu__config_terms(struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *err)
@@ -1267,8 +1266,7 @@ int perf_pmu__config_terms(const char *pmu_name, struct list_head *formats,
 	struct parse_events_term *term;
 
 	list_for_each_entry(term, head_terms, list) {
-		if (pmu_config_term(pmu_name, formats, attr, term, head_terms,
-				    zero, err))
+		if (pmu_config_term(pmu, attr, term, head_terms, zero, err))
 			return -EINVAL;
 	}
 
@@ -1286,8 +1284,7 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 {
 	bool zero = !!pmu->default_config;
 
-	return perf_pmu__config_terms(pmu->name, &pmu->format, attr,
-				      head_terms, zero, err);
+	return perf_pmu__config_terms(pmu, attr, head_terms, zero, err);
 }
 
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
@@ -1417,7 +1414,7 @@ int perf_pmu__new_format(struct list_head *list, char *name,
 	return 0;
 }
 
-void perf_pmu__del_formats(struct list_head *formats)
+static void perf_pmu__del_formats(struct list_head *formats)
 {
 	struct perf_pmu_format *fmt, *tmp;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5394c85d20b9..eb26c8bc079f 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -217,7 +217,7 @@ void pmu_add_sys_aliases(struct list_head *head, struct perf_pmu *pmu);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-int perf_pmu__config_terms(const char *pmu_name, struct list_head *formats,
+int perf_pmu__config_terms(struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *error);
@@ -231,7 +231,6 @@ struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
 int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
 int perf_pmu__format_parse(int dirfd, struct list_head *head);
-void perf_pmu__del_formats(struct list_head *formats);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 
 bool is_pmu_core(const char *name);
-- 
2.42.0.rc1.204.g551eb34607-goog

