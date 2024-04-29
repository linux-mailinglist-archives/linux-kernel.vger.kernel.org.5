Return-Path: <linux-kernel+bounces-162991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED18B6314
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E42F1F22B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8A145B1B;
	Mon, 29 Apr 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RZeqV08"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2931442F1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420971; cv=none; b=q6zdVsAtzo4JUE2mbRcbWQn0k4fhmrBsFrB5TJMf8PbJxkXoyM51veBKmXE/i3PGTlk7hOOpj3SP31i9rlbc0NCJXcQp6K/au+0CR3XO/5WWI9HU/DE21nzrqIpp2kO0ZE2VfXZgCzksVAbx+OFahksQGlQtXjIY+y4+BgWlG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420971; c=relaxed/simple;
	bh=aRErZOQOc1AuWz2ngvFgWDEadxLuk0Lya9jNtJdY5UI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=jB3SGndFRoqHO/RQcy57Eu+fBiKAgMxpHDHGc6dF6PYAGFaIEZBI4TAXN/EEvfB1iDUbWcOivxB7u9IjjHD3c/Nvjkbqeqcj/5+S7Ii2xLDZTEdHrFayodpPMrskyEdcKQiE7NJSteeaVXi7YzVBdiTb41oXUW7P8CmOaqRsu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RZeqV08; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be25000a4so12527817b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420967; x=1715025767; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0Izv2KGLy9LH7rwwW2cK7zl7UVJXq8kwesOPOZwgM4=;
        b=1RZeqV08XEnWpeEX1zsKERylGvZkCE8veSbijs0ITQpTSiKJBumn2Tvw+Ria/v6U8g
         A+7kZooTT9gFItLBqv6laTnAuZXRqGT/JisUrtnJlzDvX3HVua9aIuZM30NEqFHQ2l/C
         E72dIPjZiJYfQgmYkB8gI+EL3dVrzYsT1R8b+kycW8ydfTHlpxnGHOyPsoZVTCYwc1PI
         BW7RSthGfYPbZOBmm3vTbuXWCKHdKY0xGInCdlBQ80WNNNyC/wja2uPcVrYRSUy1MSyZ
         srwe2Tbc/E/fWCbtxfy9Tbm1dHNHIY9/1KYnSz6MYZR90QLXCv9SVBPg0qZuDig+JcY9
         63zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420967; x=1715025767;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0Izv2KGLy9LH7rwwW2cK7zl7UVJXq8kwesOPOZwgM4=;
        b=NyxjyeevBc/D32i4ybWxe9Z6B5SzenGqdPYiKTLzigqxdxzNrubuTE4phf9pkHFUzK
         WpBLOSz7ZnKdwnpMDIT/Yz8GAKbZQVrBLWhjsnXy38/9Ds8X/cQi6zTTJNauAkQoMRzO
         nh3fdDLSIwumogbViHdeO38gmMyulELJMFeQB8R8cxqJSRFtfeIuAdQrCLxFB8Sr6lat
         QkiXLMa0WQzUm9eAa9TRlTEM0GcVUYqVyiJzLtv7wZZZJ4IeblOFn0xdC9MF0CyGJ2HW
         E0EJJtzIeAD/SWfrU0h8jkINuljkTXt6YTuE2hlfVPvCmC9t84wbC+aMkNbRDVL3pUxT
         05rA==
X-Forwarded-Encrypted: i=1; AJvYcCWP6m+CkTNH97NWLalhO09Xk2jwNuJjvn4OrEFfzpNptY96N0RY414pRDFhV0cUNAyfTpawJIfceIxQb93XXTxL2eLPKaCJY1hrOtrM
X-Gm-Message-State: AOJu0Yz+R6OVn98VM0ogACeqv2lKKufAzfU7VmKXIZdJZ0ZR3LK8BDH4
	3pMju48fzlKtMHPUM+Cl/o3ks+K319jzzDY8/R3OzNuUW1cgLAf2M94W4S4cyduXo5FSotzO3k9
	orJ44Fw==
X-Google-Smtp-Source: AGHT+IGJMWLhWjMUa+hrqLexBexqYaIaHFiZOg/MUs3BtautY0bZ2mhRPL1HoHDX/iYWdBtGJmueejTcFCAZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a81:840a:0:b0:61b:e2e7:e127 with SMTP id
 u10-20020a81840a000000b0061be2e7e127mr349026ywf.1.1714420967496; Mon, 29 Apr
 2024 13:02:47 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:23 -0700
In-Reply-To: <20240429200225.1271876-1-irogers@google.com>
Message-Id: <20240429200225.1271876-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429200225.1271876-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 4/6] perf test pmu: Add an eagerly loaded event test
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
---
 tools/perf/tests/pmu.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 69 ++++++++++++++++++++++++++++------------
 2 files changed, 120 insertions(+), 21 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 6b2d9adcc583..f4e9a39534cb 100644
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
@@ -110,6 +115,19 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
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
+	write(file, test_event, strlen(test_event));
+	close(file);
+
 	/* Make the PMU reading the files created above. */
 	pmu = perf_pmus__add_test_pmu(dirfd, "perf-pmu-test");
 	if (!pmu)
@@ -170,8 +188,62 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
+static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	char dir[PATH_MAX];
+	struct parse_events_error err;
+	struct evlist *evlist;
+	struct evsel *evsel;
+	struct perf_event_attr *attr;
+	int ret;
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
+		ret = TEST_FAIL;
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
2.44.0.769.g3c40516874-goog


