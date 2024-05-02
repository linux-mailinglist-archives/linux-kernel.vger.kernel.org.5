Return-Path: <linux-kernel+bounces-166947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0168BA25F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A211F251E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59571C2302;
	Thu,  2 May 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9TeswoT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B5181BB5
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685721; cv=none; b=h6w9OR1KcBLkRzVJVYT64WeKWKHvHhUgnhY21H3rXbBfht7pKiMq0wchqKIeyDBI3yLzSIlw1/+UWUTwthTcmqQrBwqdPK9iwUijyMz+fJoUFPFEHLWY83yu6osnowgfXsWly5Pa6j44LlRCKZ3mTpOnQDfNwEnBeqfy5iw22Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685721; c=relaxed/simple;
	bh=X1QsoG0vLLHMD6bYIGg+5REMFKVWWB6D6zVlb4tr+OU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=XMFj3c6i0ja8adUlbDm8d0S2vEgXnru0+X1j3MxbFbVOb73AJGoyV9B1qJySLlnmUS73xk598cs2VmrZVfd78yheDqfx0i/77KIGuv50EA+PynMvYVYbMVHo02sEEBqFV9gdXgyI3rex8iZp9opBLwpc6FDCHl72y9ucq+/h+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9TeswoT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so13163175276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685719; x=1715290519; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcJ4dsH8uWA+9WkKKoxf0bqU8/vdoA/sy+ZzRXrUB+k=;
        b=s9TeswoTIF+tYNSr+NLvoqeNSQTBjUTnG3/G8QNBB0z+vvKBWJkTFLvT6+fhA8qtvb
         HAyldA2mSAPNjYSFZ6T+J2qLPIB3lvWsG0IlGKmnqYcF6ES19xdLGje0N/Z60K6ChQdS
         BWc1/b/GL0BUwMUhIzgmWdzjE+/AKme7fQVRmQWrCmeJIO9+GsjUlGqddBJalb94SsSc
         4sGamKvMJBi2C1PbN0Kdrm0baywbz4eQR7VuP3+8DEzBqxsQzSSV+0WwxeLcIIB1hf41
         mE17a9dCebWQtrSGq6YHDle4QkFNjZscdJU5xQXquqntvm2a5ba+/sT3vZZuZF4e0S7r
         ZUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685719; x=1715290519;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcJ4dsH8uWA+9WkKKoxf0bqU8/vdoA/sy+ZzRXrUB+k=;
        b=vR8+WaNqhP0veSC07AVJKTnIDmUWFrVhzuRrE/Dk8rq4J+gdg82ErZAgmcaSyx27Tk
         43CRE1wNP9izXrX68LA1roLiRN3+AGz+jalA1PiJ5kUnRoGhpraEm3fWLxXixPezswYW
         OOPwJqzj8MNNlWOsRTZoXw8/L3KJqS27SMFQnbvH5RDK68/69SkuyRXHp8TqjxNCPdYN
         /6V+TCTdOo3cHLeavUicYU6f6rFH4qatsNE8STgst8hl3FwquQVTjCtUo6J7xG6VS3KY
         Sxkh7rTy0mgrWxH7LMrQ9yTmZ7DaszbSVT4STE4SOAMtnyXYW+/WO19nmWWygDELRPAA
         j1MA==
X-Forwarded-Encrypted: i=1; AJvYcCV2W2t7GJxOa02JMRY++fn3FQtvjywP5aTCAfnNEhSnW9sQ/TEiBYV3jeti5MvLysgudE7FhNEebOELXCGArVNJ74V8fUk5xHHwT/Fs
X-Gm-Message-State: AOJu0YxBi/yhWJXSek8j5FxyPakD58iWUZAAQJo1S7pGFjQKEnaS9Vif
	7qyNJ2ZROOycZkXxeDMhPtPlFMd4cnvseFUKWAnzdJdfIqSfd3iGovG38akL4PHPOmxEuwlX793
	RbM4ZaA==
X-Google-Smtp-Source: AGHT+IEIkMwDF/cN1AEdH7g/G9QzA/amSuozpCAl+dsFpzt4DY7+TlBgmiW83jmEoBeSdl1e7SJTkhQjgFqA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a05:6902:1082:b0:dce:5218:c89b with SMTP
 id v2-20020a056902108200b00dce5218c89bmr157125ybu.5.1714685719171; Thu, 02
 May 2024 14:35:19 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:05 -0700
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Message-Id: <20240502213507.2339733-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 4/6] perf test pmu: Add an eagerly loaded event test
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

Allow events/aliases to be eagerly loaded for a PMU. Factor out the
pmu_aliases_parse to allow this. Parse a test event and check it
configures the attribute as expected. There is overlap with the
parse-events tests, but this test is done with a PMU created in a temp
directory and doesn't rely on PMUs in sysfs.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/pmu.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 69 ++++++++++++++++++++++++++------------
 2 files changed, 124 insertions(+), 21 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 424ebdb0f09d..071cfc51b52c 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "evlist.h"
+#include "evsel.h"
 #include "parse-events.h"
 #include "pmu.h"
 #include "tests.h"
@@ -54,6 +56,9 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		{ "krava22", "config2:8,18,48,58\n", },
 		{ "krava23", "config2:28-29,38\n", },
 	};
+	const char *test_event = "krava01=15,krava02=170,krava03=1,krava11=27,krava12=1,"
+		"krava13=2,krava21=119,krava22=11,krava23=2\n";
+
 	char name[PATH_MAX];
 	int dirfd, file;
 	struct perf_pmu *pmu = NULL;
@@ -116,6 +121,24 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		close(file);
 	}
 
+	/* Create test event. */
+	if (mkdirat(dirfd, "perf-pmu-test/events", 0755) < 0) {
+		pr_err("Failed to mkdir PMU events directory\n");
+		goto err_out;
+	}
+	file = openat(dirfd, "perf-pmu-test/events/test-event", O_WRONLY | O_CREAT, 0600);
+	if (!file) {
+		pr_err("Failed to open for writing file \"type\"\n");
+		goto err_out;
+	}
+	len = strlen(test_event);
+	if (write(file, test_event, len) < len) {
+		close(file);
+		pr_err("Failed to write to 'test-event' file\n");
+		goto err_out;
+	}
+	close(file);
+
 	/* Make the PMU reading the files created above. */
 	pmu = perf_pmus__add_test_pmu(dirfd, "perf-pmu-test");
 	if (!pmu)
@@ -176,8 +199,61 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
+static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	char dir[PATH_MAX];
+	struct parse_events_error err;
+	struct evlist *evlist;
+	struct evsel *evsel;
+	struct perf_event_attr *attr;
+	int ret = TEST_FAIL;
+	struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
+	const char *event = "perf-pmu-test/test-event/";
+
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	evlist = evlist__new();
+	if (evlist == NULL) {
+		pr_err("Failed allocation");
+		goto err_out;
+	}
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, event, &err);
+	if (ret) {
+		pr_debug("failed to parse event '%s', err %d\n", event, ret);
+		parse_events_error__print(&err, event);
+		if (parse_events_error__contains(&err, "can't access trace events"))
+			ret = TEST_SKIP;
+		goto err_out;
+	}
+	evsel = evlist__first(evlist);
+	attr = &evsel->core.attr;
+	if (attr->config  != 0xc00000000002a823) {
+		pr_err("Unexpected config value %llx\n", attr->config);
+		goto err_out;
+	}
+	if (attr->config1 != 0x8000400000000145) {
+		pr_err("Unexpected config1 value %llx\n", attr->config1);
+		goto err_out;
+	}
+	if (attr->config2 != 0x0400000020041d07) {
+		pr_err("Unexpected config2 value %llx\n", attr->config2);
+		goto err_out;
+	}
+
+	ret = TEST_OK;
+err_out:
+	parse_events_error__exit(&err);
+	evlist__delete(evlist);
+	test_pmu_put(dir, pmu);
+	return ret;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
+	TEST_CASE("Parsing with PMU event", pmu_events),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index fbbc535ed93f..7849be4bfea1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -597,33 +597,18 @@ static inline bool pmu_alias_info_file(const char *name)
  * Reading the pmu event aliases definition, which should be located at:
  * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
  */
-static int pmu_aliases_parse(struct perf_pmu *pmu)
+static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 {
-	char path[PATH_MAX];
 	struct dirent *evt_ent;
 	DIR *event_dir;
-	size_t len;
-	int fd, dir_fd;
 
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
-
-	dir_fd = open(path, O_DIRECTORY);
-	if (dir_fd == -1) {
-		pmu->sysfs_aliases_loaded = true;
-		return 0;
-	}
-
-	event_dir = fdopendir(dir_fd);
-	if (!event_dir){
-		close (dir_fd);
+	event_dir = fdopendir(events_dir_fd);
+	if (!event_dir)
 		return -EINVAL;
-	}
 
 	while ((evt_ent = readdir(event_dir))) {
 		char *name = evt_ent->d_name;
+		int fd;
 		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
@@ -635,7 +620,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		if (pmu_alias_info_file(name))
 			continue;
 
-		fd = openat(dir_fd, name, O_RDONLY);
+		fd = openat(events_dir_fd, name, O_RDONLY);
 		if (fd == -1) {
 			pr_debug("Cannot open %s\n", name);
 			continue;
@@ -653,11 +638,50 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 	}
 
 	closedir(event_dir);
-	close (dir_fd);
 	pmu->sysfs_aliases_loaded = true;
 	return 0;
 }
 
+static int pmu_aliases_parse(struct perf_pmu *pmu)
+{
+	char path[PATH_MAX];
+	size_t len;
+	int events_dir_fd, ret;
+
+	if (pmu->sysfs_aliases_loaded)
+		return 0;
+
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return 0;
+	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
+
+	events_dir_fd = open(path, O_DIRECTORY);
+	if (events_dir_fd == -1) {
+		pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+	ret = __pmu_aliases_parse(pmu, events_dir_fd);
+	close(events_dir_fd);
+	return ret;
+}
+
+static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
+{
+	char path[FILENAME_MAX + 7];
+	int ret, events_dir_fd;
+
+	scnprintf(path, sizeof(path), "%s/events", pmu->name);
+	events_dir_fd = openat(sysfs_fd, path, O_DIRECTORY, 0);
+	if (events_dir_fd == -1) {
+		pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+	ret = __pmu_aliases_parse(pmu, events_dir_fd);
+	close(events_dir_fd);
+	return ret;
+}
+
 static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
 {
 	struct parse_events_term *term, *cloned;
@@ -1042,6 +1066,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 
 	perf_pmu__arch_init(pmu);
 
+	if (eager_load)
+		pmu_aliases_parse_eager(pmu, dirfd);
+
 	return pmu;
 err:
 	zfree(&pmu->name);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


