Return-Path: <linux-kernel+bounces-166945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C188BA25E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D421C22C13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0531C0DC5;
	Thu,  2 May 2024 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xsBetYns"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16451A38C7
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685719; cv=none; b=WWlzxc0yhwh8Ul1Id3HkkuDFIPDdi6KTA1i9JlzYWVz/XO27KIEiRCnSJP/OOxAm3DO1LrEnXhqNelCCYTWuJ76UR4Xh6TTaoem4psrkKEZ3oRirewUTvQHaK4+9EOIX+P5CG2NzTBanhbkySFZrcTwpWAvAhbYLG/EI4T6Xs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685719; c=relaxed/simple;
	bh=Sefgb1dIMIUu5Y3bIt15Ku+/ZrLmHFLxlJ/4mRLQQXs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BblDRQKX2J9VzP4lS2jzaGrERPta1fSn7vsKN3b26UH/FOTyoJp9IOyPHWmqGHwNOdMOVIebzN48p83wB+kQ2C0e6bnJFUPbq8v+v/MUX3/Ekpk6uOkAvYzZBGHUiyOm8p8vcQ3EsUDx1/xAR4XaFAra585b9E5q1dUyZlLuG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xsBetYns; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso12875031276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685717; x=1715290517; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeBoV5zeEIYf5sTMbzFl5y0Yw10CZZTQHT5jBZAFh80=;
        b=xsBetYns7OKH1QER07INTKTNzOE+QDwCGBNUGsN/EPAWyKmG+Xl6+b0gsCp0Ec3NGn
         0w/KZ4e3AbbHE+Tc8KWytYY4t//zNFMEqMQWVRB/nLuzc2QZMZrPcW9ur9a3gd4zeBNd
         4EdmodRKhsUKEkfaq6FDj7fe/ZPPYDpHosd5R3pAQzbiYcMxfeEBINvDo+ylXw6ODjw8
         BHatXAtveK0YvVBD8wtu4Y6svL04FfMORsY0eg7C0dToq7MP9Gab1W/Nqyv8K+NZpuQr
         G167n2a4LbqwKBeprMNTr9s0tSETPVMPLvnIl8uj6wdGJJG56sRa5lQErgGjF5yUoMOE
         dh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685717; x=1715290517;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeBoV5zeEIYf5sTMbzFl5y0Yw10CZZTQHT5jBZAFh80=;
        b=dex90wn3h+hrLuEa0lkJxsetSo41SbshgStgSJJC7/fDt8VVgvZYnjSciHy8Ws3vjZ
         CNO5OetDd5Ob1w4SemuNYprgR3JMacsku1gseOzN7KzZywLQ2fRe1LmhTcWEGnVBb27T
         dj6Yr28t6vkvtu9xBkt5PKbguCuXaVHMZaBv0dkv/RX0PNkXFpLhwYePljbObU+JscrY
         DZLTG/Y3i5kCaTZD+700LMasgTVLGXBXpnw/0VQXb3dwZx6aBEN/cxp51WEZIJXd+5Ax
         +YKgIrzmgt2h4XhuBGiVFJGdYpaPOmlbFyW2RgHRcEajD8zd0k+MtmahnPF8G7Hsfudx
         2ORA==
X-Forwarded-Encrypted: i=1; AJvYcCWkjmYhsNID6fvXH5d+lZIobTs891RXRZH6z9U+eUdYRuH4i9J/RR02BcRu/luM9TzlWT+pePQj1xWBFRnzfv/v4VbpYCahconDYR9o
X-Gm-Message-State: AOJu0Yy95VHY4SVMfCGj8cXss3PT/2XD+8tFFMDf/wR7p8yVHUVTZ6TA
	/2OoWie9a83RKE67b5UCmYJBZhF4NsbF+cbidxL4C/Ej9ra5koelCw2RdRrbAsScvtodTrtJPT5
	NCQWehA==
X-Google-Smtp-Source: AGHT+IFVm+N4vOCBELoibMwAWsexRiPO+CQ7Q3lw7ee3vrpAhMdFcogtWwY5bE4+1b3flh1CjOH5AyqZVf/x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c1:b0:de5:3003:4b7d with SMTP
 id w1-20020a05690210c100b00de530034b7dmr304699ybu.0.1714685716802; Thu, 02
 May 2024 14:35:16 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:04 -0700
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Message-Id: <20240502213507.2339733-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 3/6] perf test pmu: Refactor format test and exposed test APIs
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In tests/pmu.c, make a common utility that creates a PMU in mkdtemp
directory and uses regular PMU parsing logic to load that PMU. Formats
must still be eagerly loaded as by default the PMU code assumes
devices are going to be in sysfs. In util/pmu.[ch], hide
perf_pmu__format_parse but add the eager argument to perf_pmu__lookup
called by perf_pmus__add_test_pmu. Later patches will eagerly load
other non-sysfs files when eager loading is enabled.

In tests/pmu.c, rather than manually constructing a list of term
arguments, just use the term parsing code from a string.

Add more comments and debug logging.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/pmu.c         | 319 ++++++++++++++++-----------------
 tools/perf/util/parse-events.c |   2 +-
 tools/perf/util/parse-events.h |   2 +-
 tools/perf/util/pmu.c          |  11 +-
 tools/perf/util/pmu.h          |   4 +-
 tools/perf/util/pmus.c         |  16 +-
 tools/perf/util/pmus.h         |   2 +
 7 files changed, 177 insertions(+), 179 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 8f18127d876a..424ebdb0f09d 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -2,203 +2,186 @@
 #include "parse-events.h"
 #include "pmu.h"
 #include "tests.h"
+#include "debug.h"
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
-#include <linux/kernel.h>
-#include <linux/limits.h>
-#include <linux/zalloc.h>
-
-/* Simulated format definitions. */
-static struct test_format {
-	const char *name;
-	const char *value;
-} test_formats[] = {
-	{ "krava01", "config:0-1,62-63\n", },
-	{ "krava02", "config:10-17\n", },
-	{ "krava03", "config:5\n", },
-	{ "krava11", "config1:0,2,4,6,8,20-28\n", },
-	{ "krava12", "config1:63\n", },
-	{ "krava13", "config1:45-47\n", },
-	{ "krava21", "config2:0-3,10-13,20-23,30-33,40-43,50-53,60-63\n", },
-	{ "krava22", "config2:8,18,48,58\n", },
-	{ "krava23", "config2:28-29,38\n", },
-};
-
-/* Simulated users input. */
-static struct parse_events_term test_terms[] = {
-	{
-		.config    = "krava01",
-		.val.num   = 15,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-	{
-		.config    = "krava02",
-		.val.num   = 170,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-	{
-		.config    = "krava03",
-		.val.num   = 1,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-	{
-		.config    = "krava11",
-		.val.num   = 27,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-	{
-		.config    = "krava12",
-		.val.num   = 1,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-	{
-		.config    = "krava13",
-		.val.num   = 2,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-	{
-		.config    = "krava21",
-		.val.num   = 119,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-	{
-		.config    = "krava22",
-		.val.num   = 11,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-	{
-		.config    = "krava23",
-		.val.num   = 2,
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-	},
-};
-
-/*
- * Prepare format directory data, exported by kernel
- * at /sys/bus/event_source/devices/<dev>/format.
- */
-static char *test_format_dir_get(char *dir, size_t sz)
-{
-	unsigned int i;
-
-	snprintf(dir, sz, "/tmp/perf-pmu-test-format-XXXXXX");
-	if (!mkdtemp(dir))
-		return NULL;
-
-	for (i = 0; i < ARRAY_SIZE(test_formats); i++) {
-		char name[PATH_MAX];
-		struct test_format *format = &test_formats[i];
-		FILE *file;
-
-		scnprintf(name, PATH_MAX, "%s/%s", dir, format->name);
-
-		file = fopen(name, "w");
-		if (!file)
-			return NULL;
-
-		if (1 != fwrite(format->value, strlen(format->value), 1, file))
-			break;
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/stat.h>
 
-		fclose(file);
-	}
-
-	return dir;
-}
+/* Fake PMUs created in temp directory. */
+static LIST_HEAD(test_pmus);
 
-/* Cleanup format directory. */
-static int test_format_dir_put(char *dir)
+/* Cleanup test PMU directory. */
+static int test_pmu_put(const char *dir, struct perf_pmu *pmu)
 {
 	char buf[PATH_MAX + 20];
+	int ret;
 
-	snprintf(buf, sizeof(buf), "rm -f %s/*\n", dir);
-	if (system(buf))
-		return -1;
+	if (scnprintf(buf, sizeof(buf), "rm -fr %s", dir) < 0) {
+		pr_err("Failure to set up buffer for \"%s\"\n", dir);
+		return -EINVAL;
+	}
+	ret = system(buf);
+	if (ret)
+		pr_err("Failure to \"%s\"\n", buf);
 
-	snprintf(buf, sizeof(buf), "rmdir %s\n", dir);
-	return system(buf);
+	list_del(&pmu->list);
+	perf_pmu__delete(pmu);
+	return ret;
 }
 
-static void add_test_terms(struct parse_events_terms *terms)
+/*
+ * Prepare test PMU directory data, normally exported by kernel at
+ * /sys/bus/event_source/devices/<pmu>/. Give as input a buffer to hold the file
+ * path, the result is PMU loaded using that directory.
+ */
+static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 {
-	unsigned int i;
+	/* Simulated format definitions. */
+	const struct test_format {
+		const char *name;
+		const char *value;
+	} test_formats[] = {
+		{ "krava01", "config:0-1,62-63\n", },
+		{ "krava02", "config:10-17\n", },
+		{ "krava03", "config:5\n", },
+		{ "krava11", "config1:0,2,4,6,8,20-28\n", },
+		{ "krava12", "config1:63\n", },
+		{ "krava13", "config1:45-47\n", },
+		{ "krava21", "config2:0-3,10-13,20-23,30-33,40-43,50-53,60-63\n", },
+		{ "krava22", "config2:8,18,48,58\n", },
+		{ "krava23", "config2:28-29,38\n", },
+	};
+	char name[PATH_MAX];
+	int dirfd, file;
+	struct perf_pmu *pmu = NULL;
+	ssize_t len;
+
+	/* Create equivalent of sysfs mount point. */
+	scnprintf(dir, sz, "/tmp/perf-pmu-test-XXXXXX");
+	if (!mkdtemp(dir)) {
+		pr_err("mkdtemp failed\n");
+		dir[0] = '\0';
+		return NULL;
+	}
+	dirfd = open(dir, O_DIRECTORY);
+	if (dirfd < 0) {
+		pr_err("Failed to open test directory \"%s\"\n", dir);
+		goto err_out;
+	}
 
-	for (i = 0; i < ARRAY_SIZE(test_terms); i++) {
-		struct parse_events_term *clone;
+	/* Create the test PMU directory and give it a perf_event_attr type number. */
+	if (mkdirat(dirfd, "perf-pmu-test", 0755) < 0) {
+		pr_err("Failed to mkdir PMU directory\n");
+		goto err_out;
+	}
+	file = openat(dirfd, "perf-pmu-test/type", O_WRONLY | O_CREAT, 0600);
+	if (!file) {
+		pr_err("Failed to open for writing file \"type\"\n");
+		goto err_out;
+	}
+	len = strlen("9999");
+	if (write(file, "9999\n", len) < len) {
+		close(file);
+		pr_err("Failed to write to 'type' file\n");
+		goto err_out;
+	}
+	close(file);
 
-		parse_events_term__clone(&clone, &test_terms[i]);
-		list_add_tail(&clone->list, &terms->terms);
+	/* Create format directory and files. */
+	if (mkdirat(dirfd, "perf-pmu-test/format", 0755) < 0) {
+		pr_err("Failed to mkdir PMU format directory\n)");
+		goto err_out;
 	}
+	for (size_t i = 0; i < ARRAY_SIZE(test_formats); i++) {
+		const struct test_format *format = &test_formats[i];
+
+		if (scnprintf(name, PATH_MAX, "perf-pmu-test/format/%s", format->name) < 0) {
+			pr_err("Failure to set up path for \"%s\"\n", format->name);
+			goto err_out;
+		}
+		file = openat(dirfd, name, O_WRONLY | O_CREAT, 0600);
+		if (!file) {
+			pr_err("Failed to open for writing file \"%s\"\n", name);
+			goto err_out;
+		}
+
+		if (write(file, format->value, strlen(format->value)) < 0) {
+			pr_err("Failed to write to file \"%s\"\n", name);
+			close(file);
+			goto err_out;
+		}
+		close(file);
+	}
+
+	/* Make the PMU reading the files created above. */
+	pmu = perf_pmus__add_test_pmu(dirfd, "perf-pmu-test");
+	if (!pmu)
+		pr_err("Test PMU creation failed\n");
+
+err_out:
+	if (!pmu)
+		test_pmu_put(dir, pmu);
+	if (dirfd >= 0)
+		close(dirfd);
+	return pmu;
 }
 
-static int test__pmu(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	char dir[PATH_MAX];
-	char *format;
-	struct parse_events_terms terms;
 	struct perf_event_attr attr;
-	struct perf_pmu *pmu;
-	int fd;
-	int ret;
+	struct parse_events_terms terms;
+	int ret = TEST_FAIL;
+	struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
 
-	parse_events_terms__init(&terms);
-	add_test_terms(&terms);
-	pmu = zalloc(sizeof(*pmu));
-	if (!pmu) {
-		parse_events_terms__exit(&terms);
-		return -ENOMEM;
-	}
+	if (!pmu)
+		return TEST_FAIL;
 
-	INIT_LIST_HEAD(&pmu->format);
-	INIT_LIST_HEAD(&pmu->aliases);
-	INIT_LIST_HEAD(&pmu->caps);
-	format = test_format_dir_get(dir, sizeof(dir));
-	if (!format) {
-		free(pmu);
-		parse_events_terms__exit(&terms);
-		return -EINVAL;
+	parse_events_terms__init(&terms);
+	if (parse_events_terms(&terms,
+				"krava01=15,krava02=170,krava03=1,krava11=27,krava12=1,"
+				"krava13=2,krava21=119,krava22=11,krava23=2",
+				NULL)) {
+		pr_err("Term parsing failed\n");
+		goto err_out;
 	}
 
 	memset(&attr, 0, sizeof(attr));
-
-	fd = open(format, O_DIRECTORY);
-	if (fd < 0) {
-		ret = fd;
-		goto out;
+	ret = perf_pmu__config_terms(pmu, &attr, &terms, /*zero=*/false, /*err=*/NULL);
+	if (ret) {
+		pr_err("perf_pmu__config_terms failed");
+		goto err_out;
 	}
 
-	pmu->name = strdup("perf-pmu-test");
-	ret = perf_pmu__format_parse(pmu, fd, /*eager_load=*/true);
-	if (ret)
-		goto out;
+	if (attr.config  != 0xc00000000002a823) {
+		pr_err("Unexpected config value %llx\n", attr.config);
+		goto err_out;
+	}
+	if (attr.config1 != 0x8000400000000145) {
+		pr_err("Unexpected config1 value %llx\n", attr.config1);
+		goto err_out;
+	}
+	if (attr.config2 != 0x0400000020041d07) {
+		pr_err("Unexpected config2 value %llx\n", attr.config2);
+		goto err_out;
+	}
 
-	ret = perf_pmu__config_terms(pmu, &attr, &terms, /*zero=*/false, /*err=*/NULL);
-	if (ret)
-		goto out;
-
-	ret = -EINVAL;
-	if (attr.config  != 0xc00000000002a823)
-		goto out;
-	if (attr.config1 != 0x8000400000000145)
-		goto out;
-	if (attr.config2 != 0x0400000020041d07)
-		goto out;
-
-	ret = 0;
-out:
-	test_format_dir_put(format);
-	perf_pmu__delete(pmu);
+	ret = TEST_OK;
+err_out:
 	parse_events_terms__exit(&terms);
+	test_pmu_put(dir, pmu);
 	return ret;
 }
 
-DEFINE_SUITE("Parse perf pmu format", pmu);
+static struct test_case tests__pmu[] = {
+	TEST_CASE("Parsing with PMU format directory", pmu_format),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__pmu = {
+	.desc = "Sysfs PMU tests",
+	.test_cases = tests__pmu,
+};
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0f308b4db2b9..2b9ede311c31 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2585,7 +2585,7 @@ int parse_events_term__term(struct parse_events_term **term,
 }
 
 int parse_events_term__clone(struct parse_events_term **new,
-			     struct parse_events_term *term)
+			     const struct parse_events_term *term)
 {
 	char *str;
 	struct parse_events_term temp = *term;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5695308efab9..e7ac1f13376d 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -178,7 +178,7 @@ int parse_events_term__term(struct parse_events_term **term,
 			    enum parse_events__term_type term_rhs,
 			    void *loc_term, void *loc_val);
 int parse_events_term__clone(struct parse_events_term **new,
-			     struct parse_events_term *term);
+			     const struct parse_events_term *term);
 void parse_events_term__delete(struct parse_events_term *term);
 
 void parse_events_terms__delete(struct parse_events_terms *terms);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 74dd5bd49d9a..fbbc535ed93f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -182,7 +182,7 @@ static void perf_pmu_format__load(const struct perf_pmu *pmu, struct perf_pmu_fo
  * Parse & process all the sysfs attributes located under
  * the directory specified in 'dir' parameter.
  */
-int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
+static int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
 {
 	struct dirent *evt_ent;
 	DIR *format_dir;
@@ -232,7 +232,7 @@ int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
  * located at:
  * /sys/bus/event_source/devices/<dev>/format as sysfs group attributes.
  */
-static int pmu_format(struct perf_pmu *pmu, int dirfd, const char *name)
+static int pmu_format(struct perf_pmu *pmu, int dirfd, const char *name, bool eager_load)
 {
 	int fd;
 
@@ -241,7 +241,7 @@ static int pmu_format(struct perf_pmu *pmu, int dirfd, const char *name)
 		return 0;
 
 	/* it'll close the fd */
-	if (perf_pmu__format_parse(pmu, fd, /*eager_load=*/false))
+	if (perf_pmu__format_parse(pmu, fd, eager_load))
 		return -1;
 
 	return 0;
@@ -994,7 +994,8 @@ perf_pmu__arch_init(struct perf_pmu *pmu)
 		pmu->mem_events = perf_mem_events;
 }
 
-struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name)
+struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name,
+				  bool eager_load)
 {
 	struct perf_pmu *pmu;
 	__u32 type;
@@ -1023,7 +1024,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * type value and format definitions. Load both right
 	 * now.
 	 */
-	if (pmu_format(pmu, dirfd, name))
+	if (pmu_format(pmu, dirfd, name, eager_load))
 		goto err;
 
 	pmu->is_core = is_pmu_core(name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 93d03bd3ecbe..561716aa2b25 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -214,7 +214,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 			  struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
-int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load);
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb);
@@ -272,7 +271,8 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 int perf_pmu__event_source_devices_fd(void);
 int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
 
-struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
+struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name,
+				  bool eager_load);
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 2fd369e45832..b9b4c5eb5002 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -124,7 +124,8 @@ struct perf_pmu *perf_pmus__find(const char *name)
 		return NULL;
 
 	dirfd = perf_pmu__event_source_devices_fd();
-	pmu = perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
+	pmu = perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name,
+			       /*eager_load=*/false);
 	close(dirfd);
 
 	if (!pmu) {
@@ -159,7 +160,8 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	if (core_pmu && read_sysfs_core_pmus)
 		return NULL;
 
-	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
+	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name,
+				/*eager_load=*/false);
 }
 
 static int pmus_cmp(void *priv __maybe_unused,
@@ -696,3 +698,13 @@ struct perf_pmu *perf_pmus__find_core_pmu(void)
 {
 	return perf_pmus__scan_core(NULL);
 }
+
+struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
+{
+	/*
+	 * Some PMU functions read from the sysfs mount point, so care is
+	 * needed, hence passing the eager_load flag to load things like the
+	 * format files.
+	 */
+	return perf_pmu__lookup(&other_pmus, test_sysfs_dirfd, name, /*eager_load=*/true);
+}
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index eec599d8aebd..9d4ded80b8e9 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -24,4 +24,6 @@ int perf_pmus__num_core_pmus(void);
 bool perf_pmus__supports_extended_type(void);
 char *perf_pmus__default_pmu_name(void);
 
+struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name);
+
 #endif /* __PMUS_H */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


