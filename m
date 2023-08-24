Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308E6786689
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbjHXEN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbjHXENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:13:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D7D10C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58daaa2ba65so81975777b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850421; x=1693455221;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3FkZtk24eVZPBJL4lg4GGb1/7Xpt8aSUak5SLWJZY8=;
        b=jxbq6n1Y/JCOGfr3UmCU8NPdmHhY1AMklvN2ablxD/gVypqFbfrU2Wmz9JSoVqx274
         08qCNC/fWLrfwHjAhM7qM2mks8Xn3oSEWSQVRoMIpkNIQjLdjCj6ywYlqRtq9RZ1Neb6
         CZkyH9qe+9eBk8CYbT6BX7XRjlA+8l33dkaJUcjtGFkQ7jgA9bgSNB1oDfwUZ2dnZHy7
         bcCnWu2OVGTEzBUexqKnx29Nb9UPjRivs/H6amKP6Iz5QWsjDZwopAT5gdA0yywaSz0m
         PCz8m8efa9GDsxNBOGjXGLGz6t1fZ4j0242wHPVpOkbfOLJMi63Fyo6ZFoNw7cD/BMPs
         LRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850421; x=1693455221;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3FkZtk24eVZPBJL4lg4GGb1/7Xpt8aSUak5SLWJZY8=;
        b=NMxw9GWwrITFEuuqTU1NrsoqllPCgMOxMGxy6yCuiPRF2P71sdUM/LA3YTc3uERFu6
         lyIE0ACtMMWtZFSBmr8nl1Bf6epl1lrblleYv61PIiUlqm589nWYDjs/G6gKTBqHF9eD
         gs8SBI/cfMWVMHeAIwtW3rSTfNL+JMPNCW1p/cDvkHcGl2UApjnYU/u7n+XmNsANEjzQ
         xLPkeQvbswPS8/1oQURu1rnXsJ+BHoW5q67nnw8TMSCby+OV0K/WM6+bWPjN6GHCAXiX
         sVtS9f37Dr3juy9YmTOQLuimbQYuEBrPVCl2Ty3fb+afwOxLaPYeXC10lsXO9j2kQKfb
         0SzQ==
X-Gm-Message-State: AOJu0YzcqScfptky6Y75abHJD9fXxDpLwrimmOla2f5pdFtuccSB7VZg
        h7EaVVT+94TPHbwF/ERQYudqy11XrHeW
X-Google-Smtp-Source: AGHT+IFELTbtRvGgeXP4JpFZSHqQbtQQqwBD1lLrRLrS2eUkBS3uzkr0/Aw9SNiqXJDafDgnqi+QQmZ6i9nc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a81:af16:0:b0:57a:793:7fb0 with SMTP id
 n22-20020a81af16000000b0057a07937fb0mr215495ywh.3.1692850421082; Wed, 23 Aug
 2023 21:13:41 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:13 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-2-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 01/18] perf pmu: Make the loading of formats lazy
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs format files are loaded eagerly in a PMU. Add a flag so that
we create the format but only load the contents when necessary.

Reduce the size of the value in struct perf_pmu_format and avoid holes
so there is no additional space requirement.

For "perf stat -e cycles true" this reduces the number of openat calls
from 648 to 573 (about 12%). The benchmark pmu scan speed is improved
by roughly 5%.

Before: $ perf bench internals pmu-scan
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 1061.100 usec (+- 9.965 usec)
  Average PMU scanning took: 4725.300 usec (+- 260.599 usec)

After: $ perf bench internals pmu-scan
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 989.170 usec (+- 6.873 usec)
  Average PMU scanning took: 4520.960 usec (+- 251.272 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c |   2 +-
 tools/perf/util/pmu.c  | 144 +++++++++++++++++++++++++++--------------
 tools/perf/util/pmu.h  |   5 +-
 tools/perf/util/pmu.y  |  20 ++----
 4 files changed, 106 insertions(+), 65 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 2c1c349a42e2..c204ed1f1a8b 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -171,7 +171,7 @@ static int test__pmu(struct test_suite *test __maybe_unused, int subtest __maybe
 	}
 
 	pmu->name = strdup("perf-pmu-test");
-	ret = perf_pmu__format_parse(pmu, fd);
+	ret = perf_pmu__format_parse(pmu, fd, /*eager_load=*/true);
 	if (ret)
 		goto out;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 42f3249994ab..3cfd3e58da23 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -40,6 +40,10 @@ struct perf_pmu perf_pmu__fake;
  * value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will be set.
  */
 struct perf_pmu_format {
+	/** @list: Element on list within struct perf_pmu. */
+	struct list_head list;
+	/** @bits: Which config bits are set by this format value. */
+	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
 	/** @name: The modifier/file name. */
 	char *name;
 	/**
@@ -47,18 +51,79 @@ struct perf_pmu_format {
 	 * are from PERF_PMU_FORMAT_VALUE_CONFIG to
 	 * PERF_PMU_FORMAT_VALUE_CONFIG_END.
 	 */
-	int value;
-	/** @bits: Which config bits are set by this format value. */
-	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
-	/** @list: Element on list within struct perf_pmu. */
-	struct list_head list;
+	u16 value;
+	/** @loaded: Has the contents been loaded/parsed. */
+	bool loaded;
 };
 
+static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
+{
+	struct perf_pmu_format *format;
+
+	format = zalloc(sizeof(*format));
+	if (!format)
+		return NULL;
+
+	format->name = strdup(name);
+	if (!format->name) {
+		free(format);
+		return NULL;
+	}
+	list_add_tail(&format->list, list);
+	return format;
+}
+
+/* Called at the end of parsing a format. */
+void perf_pmu_format__set_value(void *vformat, int config, unsigned long *bits)
+{
+	struct perf_pmu_format *format = vformat;
+
+	format->value = config;
+	memcpy(format->bits, bits, sizeof(format->bits));
+}
+
+static void __perf_pmu_format__load(struct perf_pmu_format *format, FILE *file)
+{
+	void *scanner;
+	int ret;
+
+	ret = perf_pmu_lex_init(&scanner);
+	if (ret)
+		return;
+
+	perf_pmu_set_in(file, scanner);
+	ret = perf_pmu_parse(format, scanner);
+	perf_pmu_lex_destroy(scanner);
+	format->loaded = true;
+}
+
+static void perf_pmu_format__load(struct perf_pmu *pmu, struct perf_pmu_format *format)
+{
+	char path[PATH_MAX];
+	FILE *file = NULL;
+
+	if (format->loaded)
+		return;
+
+	if (!perf_pmu__pathname_scnprintf(path, sizeof(path), pmu->name, "format"))
+		return;
+
+	assert(strlen(path) + strlen(format->name) + 2 < sizeof(path));
+	strcat(path, "/");
+	strcat(path, format->name);
+
+	file = fopen(path, "r");
+	if (!file)
+		return;
+	__perf_pmu_format__load(format, file);
+	fclose(file);
+}
+
 /*
  * Parse & process all the sysfs attributes located under
  * the directory specified in 'dir' parameter.
  */
-int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd)
+int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
 {
 	struct dirent *evt_ent;
 	DIR *format_dir;
@@ -68,37 +133,35 @@ int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd)
 	if (!format_dir)
 		return -EINVAL;
 
-	while (!ret && (evt_ent = readdir(format_dir))) {
+	while ((evt_ent = readdir(format_dir)) != NULL) {
+		struct perf_pmu_format *format;
 		char *name = evt_ent->d_name;
-		int fd;
-		void *scanner;
-		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
 
-
-		ret = -EINVAL;
-		fd = openat(dirfd, name, O_RDONLY);
-		if (fd < 0)
-			break;
-
-		file = fdopen(fd, "r");
-		if (!file) {
-			close(fd);
+		format = perf_pmu__new_format(&pmu->format, name);
+		if (!format) {
+			ret = -ENOMEM;
 			break;
 		}
 
-		ret = perf_pmu_lex_init(&scanner);
-		if (ret) {
+		if (eager_load) {
+			FILE *file;
+			int fd = openat(dirfd, name, O_RDONLY);
+
+			if (fd < 0) {
+				ret = -errno;
+				break;
+			}
+			file = fdopen(fd, "r");
+			if (!file) {
+				close(fd);
+				break;
+			}
+			__perf_pmu_format__load(format, file);
 			fclose(file);
-			break;
 		}
-
-		perf_pmu_set_in(file, scanner);
-		ret = perf_pmu_parse(&pmu->format, name, scanner);
-		perf_pmu_lex_destroy(scanner);
-		fclose(file);
 	}
 
 	closedir(format_dir);
@@ -119,7 +182,7 @@ static int pmu_format(struct perf_pmu *pmu, int dirfd, const char *name)
 		return 0;
 
 	/* it'll close the fd */
-	if (perf_pmu__format_parse(pmu, fd))
+	if (perf_pmu__format_parse(pmu, fd, /*eager_load=*/false))
 		return -1;
 
 	return 0;
@@ -962,13 +1025,15 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 	if (pmu == &perf_pmu__fake)
 		return;
 
-	list_for_each_entry(format, &pmu->format, list)
+	list_for_each_entry(format, &pmu->format, list) {
+		perf_pmu_format__load(pmu, format);
 		if (format->value >= PERF_PMU_FORMAT_VALUE_CONFIG_END) {
 			pr_warning("WARNING: '%s' format '%s' requires 'perf_event_attr::config%d'"
 				   "which is not supported by this version of perf!\n",
 				   pmu->name, format->name, format->value);
 			return;
 		}
+	}
 }
 
 bool evsel__is_aux_event(const struct evsel *evsel)
@@ -1041,6 +1106,7 @@ int perf_pmu__format_type(struct perf_pmu *pmu, const char *name)
 	if (!format)
 		return -1;
 
+	perf_pmu_format__load(pmu, format);
 	return format->value;
 }
 
@@ -1177,7 +1243,7 @@ static int pmu_config_term(struct perf_pmu *pmu,
 		free(pmu_term);
 		return -EINVAL;
 	}
-
+	perf_pmu_format__load(pmu, format);
 	switch (format->value) {
 	case PERF_PMU_FORMAT_VALUE_CONFIG:
 		vp = &attr->config;
@@ -1403,24 +1469,6 @@ struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu, const char *ev
 
 	return NULL;
 }
-
-int perf_pmu__new_format(struct list_head *list, char *name,
-			 int config, unsigned long *bits)
-{
-	struct perf_pmu_format *format;
-
-	format = zalloc(sizeof(*format));
-	if (!format)
-		return -ENOMEM;
-
-	format->name = strdup(name);
-	format->value = config;
-	memcpy(format->bits, bits, sizeof(format->bits));
-
-	list_add_tail(&format->list, list);
-	return 0;
-}
-
 static void perf_pmu__del_formats(struct list_head *formats)
 {
 	struct perf_pmu_format *fmt, *tmp;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index c4268053c979..675c9b97f7bf 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -227,9 +227,8 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
 struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu, const char *event);
 
-int perf_pmu__new_format(struct list_head *list, char *name,
-			 int config, unsigned long *bits);
-int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd);
+int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load);
+void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 
 bool is_pmu_core(const char *name);
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index d861a5bfa3bd..600c8c158c8e 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -1,6 +1,5 @@
 %define api.pure full
-%parse-param {struct list_head *format}
-%parse-param {char *name}
+%parse-param {void *format}
 %parse-param {void *scanner}
 %lex-param {void* scanner}
 
@@ -21,7 +20,7 @@ do { \
                 YYABORT; \
 } while (0)
 
-static void perf_pmu_error(struct list_head *list, char *name, void *scanner, char const *msg);
+static void perf_pmu_error(void *format, void *scanner, const char *msg);
 
 static void perf_pmu__set_format(unsigned long *bits, long from, long to)
 {
@@ -59,16 +58,12 @@ format_term
 format_term:
 PP_CONFIG ':' bits
 {
-	ABORT_ON(perf_pmu__new_format(format, name,
-				      PERF_PMU_FORMAT_VALUE_CONFIG,
-				      $3));
+	perf_pmu_format__set_value(format, PERF_PMU_FORMAT_VALUE_CONFIG, $3);
 }
 |
 PP_CONFIG PP_VALUE ':' bits
 {
-	ABORT_ON(perf_pmu__new_format(format, name,
-				      $2,
-				      $4));
+	perf_pmu_format__set_value(format, $2, $4);
 }
 
 bits:
@@ -95,9 +90,8 @@ PP_VALUE
 
 %%
 
-static void perf_pmu_error(struct list_head *list __maybe_unused,
-		    char *name __maybe_unused,
-		    void *scanner __maybe_unused,
-		    char const *msg __maybe_unused)
+static void perf_pmu_error(void *format __maybe_unused,
+			   void *scanner __maybe_unused,
+			   const char *msg __maybe_unused)
 {
 }
-- 
2.42.0.rc1.204.g551eb34607-goog

