Return-Path: <linux-kernel+bounces-162990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281668B6313
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E5A28391E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F513F432;
	Mon, 29 Apr 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yWRrFGv9"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B9142918
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420968; cv=none; b=d6JmvD/FyUv3S0nRta6IPMfWlvfoa5S1NiwLUrgK4Ivp4ErGfKNcUBgNNBZaOVO/d1zGYQPTvSEi0PXTXVzGIFDDS1LMIvb4f44K0jOCKU2V0m5nj3HUlltVL8ISd4Ryg/AwKb2eiTxz/G9HMUUmZZZy+hiPD6ouaJQ4dZpiwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420968; c=relaxed/simple;
	bh=bL+CEVIuMHM6/EZqz8M8ze1hB99CYHuHVp10aMF6Yrc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=XaERvyFQvYVlvk8QKKpDwE5k9cYs7f9UhzovpTfensqNX4aK0QxZF2CtSCcLgh4wkrgju9D70ej4ce6J1/JbDm20SXOfKgZ6gn3IxOPGTrT/EhaPmgxaSXxFH4x6//WKwGSBlpM1UEh7/QSPow4OzyIWE3ixed8ZCpCCNf9ewIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yWRrFGv9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso8256367276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420965; x=1715025765; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZc68CqXR23Y4cUvZ/vVDOpzr1zCrNIUIjTcFw/Q9Gc=;
        b=yWRrFGv9QB7iJ+/wrFMjwruEMbfGT1Yz9TQe7ZSG6NVrOzR/KrNEwIj668XJ5OopgR
         JS7cty+3xYkpCzLwmB6ea3BNHeo8n+Z6o6QNqNGIxLVzzM9Vsp9X/FaP5TfDXo+wS5dO
         4tmb2XKHICQiEQhLpAlis5NUoCxpZUBfDetGQ7jm+NGYJrhbGVNvczkdbJQ2qI5iIKMG
         qy0frO8gJ+rsiBpct9frtOxM9lKzJpMOW4JFGspGfFG3PqOrwIsykxILi3fyXTGFPKne
         RGFFcxhU43cqoXb5ule1iiz1ScNKigsyQC9sasDAb8lN7EVxKHPmz8O8nrz0Bn1foh5N
         /k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420965; x=1715025765;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZc68CqXR23Y4cUvZ/vVDOpzr1zCrNIUIjTcFw/Q9Gc=;
        b=qeKAZ1FqdAbDNl/iW59ZADwHt95VSc+kbH9Gpc/LmYv6YA20+lQD+XbNyyHOyEJtzv
         zYls4h3+grGeC/MS00TnS6w2uZHns0pv0tdJlYuSsqkCkP9bb7Py/R9fek23LKz5J7yd
         aIOB2BwPBfoZU/QgyQOpou3/h4q2qAw7qcxoRdd+zVT8+BVdW8K5iJLIfg5alejgGniU
         L7Gju7B5GTjSyb/iDxkdySi16xEwJIYhkURDNzhpETgGRNY67fEdSvPYmyDHGx5zo7y/
         muJ3gbQSNuxXQe8NaL36xcYlx18OBZ2nhDlmDnPwt8jwxPrUyhkFWMGTqxbQzcFaffpQ
         Ym2A==
X-Forwarded-Encrypted: i=1; AJvYcCVSN4HekLaa5jmDZwaHrHUj+mqv6GAiK7d+kpCBj+3rqmxtVmkKJboF6LQZ16V/tXbyG+BEjymgf/tkHYWB+ZOMfbMc/QD43zBmacY0
X-Gm-Message-State: AOJu0YzjiwoqOxam3wZa0wyUivhxILO0NrSvGiqY3wPBZJAQ/UoFxHbw
	2aGxj2dXZqdlrJIzNymmRul4KU/BXey9xH6XQPJYS5Cmfo9kIoBr7m2ItZj97Vtx6e1wwscI67q
	szImQTA==
X-Google-Smtp-Source: AGHT+IGjW9AtZ8NnggWp3/16TUrBowzkO+iTko+o5HexhD5829WU76shCjPvrXbYhhZ1cQ56teCkG91SSgfS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:de5:60b6:fb9 with SMTP id
 t4-20020a056902124400b00de560b60fb9mr781099ybu.1.1714420965108; Mon, 29 Apr
 2024 13:02:45 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:22 -0700
In-Reply-To: <20240429200225.1271876-1-irogers@google.com>
Message-Id: <20240429200225.1271876-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429200225.1271876-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 3/6] perf test pmu: Refactor format test and exposed test APIs
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
---
 tools/perf/tests/pmu.c         | 313 +++++++++++++++------------------
 tools/perf/util/parse-events.c |   2 +-
 tools/perf/util/parse-events.h |   2 +-
 tools/perf/util/pmu.c          |  11 +-
 tools/perf/util/pmu.h          |   4 +-
 tools/perf/util/pmus.c         |  16 +-
 tools/perf/util/pmus.h         |   2 +
 7 files changed, 171 insertions(+), 179 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 8f18127d876a..6b2d9adcc583 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -2,203 +2,180 @@
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
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/stat.h>
 
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
+/* Fake PMUs created in temp directory. */
+static LIST_HEAD(test_pmus);
 
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
-
-		fclose(file);
-	}
-
-	return dir;
-}
-
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
+	write(file, "9999\n", 5);
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
2.44.0.769.g3c40516874-goog


