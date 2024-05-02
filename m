Return-Path: <linux-kernel+bounces-165955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5398D8B93C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF302841DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB0422EF0;
	Thu,  2 May 2024 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUfkcg6U"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D62135B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622505; cv=none; b=XmmXNEagX6P//VgDM2H0edG5NMyEiK8NPQk0wZPFDCows0wfQdh9YM1kT3tFzZUCB/qV+8r7nQkpSi/ADdAt+YcmhNcneV1sJ/YSRVfbDpi2bpGI1UFsliWkK6mEZG1XgsHxAXWyYxgPmkjS33wrVgUmfaCDZ11PRY6Y7qHEnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622505; c=relaxed/simple;
	bh=iUxzUsA824hpm1sIfELCborfXgMpM064szlvgEyGsAw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=V64tzybOPUH9b8mt3cm/3ZFiFREXBzgvdZ5KWg9MK3R7pHwZLIVTJuxNLEStHsV1HR5D6hE/X00otucI8bf0GHo75c2TBEHTP+BnEHeQ8S7SGoxMc42U62WhsKGPJYLVxS9Y4jqVjOr4aa92ST/cHrIuluJuBVds3U5K/aSEbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUfkcg6U; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54ccab44aso15392583276.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 21:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714622502; x=1715227302; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvcT6sTjs9yRF+sI2DXtTPhOJ6C0kmP7SfXTIs7MZwY=;
        b=sUfkcg6UNbAtyps8iYNKK+2Fn1HLddjODzdMlgzgXQndfIlt06yQ9BUf3Nyb3xwTAd
         Zt7qBntZFQpFclXDfUJPjr6KiUFkziql8w3xBKU80uAJ6wA0A3h1yZnJIvR5EKTcryq6
         GfyAWrL8MT5W5IyjroS/hGXIUH4j5bD302RPZaCeAPH8Sq0IVozJH0deTZ9dtvSrowcZ
         scNbag7gv7HnAIiy5LeQYmvlM3RGLrfgZu3eivhxLPmVrW2YUGQm83JxdXEZwbyrTVoP
         F/V7y1ZLO9eMaw4lIpAHub2cRFUFVKYrxwJffBNvdu1RDTPUw7jqmewRCncY+Cg/ZTY+
         gJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622502; x=1715227302;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvcT6sTjs9yRF+sI2DXtTPhOJ6C0kmP7SfXTIs7MZwY=;
        b=pszwBPdhET9QdCwLGlOBItTO8QoBaTVYyg7CEWK4rFHYLm+wml48lEV77IY2LXhYOa
         kGc0rS7lQnuCMvG4SqF2S/YBs+GA49r84rCWxJYNL3QRZ5yblmDdS+TkYLUOjZ/GelUo
         91cSDkDL2p2C+roNpj0gWuHV6Uwcgan1JYmzpKTsImIC42pwcNg3451FrXfNCe+hwjZv
         Qe0ixzFtXycF5xC1Ylo2s+8czI6tENLjVzlaPOoitPuG/+O5q3MYYFrcq6oXkaOZPrxZ
         mXnRenpFgPy/poX3l5J4K8kiFfkHydGnffaMIcfcW9doQDC8Vr5T7UhtwYpNoWMnOVjy
         FChQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvgXVFOEY+wVxNL6JTPSfn73fKuI4VXAGhgyL4uaTx2+e9XWahFM3KFHwMt3GeM5BHltgo4NmRQRGnsGpG4cYtX7io3TDXcqjisgIE
X-Gm-Message-State: AOJu0YwHrf8YNpfe+UclGg4dtFwB9cwJGJ8NMLqPZ9f+tf3SWcM72Gxr
	uRgRp3QsUghoIaZJpB82kwj3jf7kBFNIkxuLGtKObf01UYv1vcLZfsLzEOOoqLvln+IzGpsUW/N
	5nW6QAg==
X-Google-Smtp-Source: AGHT+IHuvDPgdMYMqU1KAVIzctXRTwXejg5EogKa/A5SRYyv5g/TLtdTh7pUBzRwY753FJB0LEUBz3q6R/iX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:53b9:bbda:1daa:17d3])
 (user=irogers job=sendgmr) by 2002:a05:6902:102a:b0:de8:ac4a:1bce with SMTP
 id x10-20020a056902102a00b00de8ac4a1bcemr252339ybt.13.1714622502619; Wed, 01
 May 2024 21:01:42 -0700 (PDT)
Date: Wed,  1 May 2024 21:01:11 -0700
In-Reply-To: <20240502040112.2111157-1-irogers@google.com>
Message-Id: <20240502040112.2111157-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502040112.2111157-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v4 5/6] perf test pmu: Test all sysfs PMU event names are the
 same case
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

Being either lower or upper case means event name probes can avoid
scanning the directory doing case insensitive comparisons, just the
lower or upper case version of the name can be checked for
existence. For the majority of PMUs event names are all lower case,
upper case names are present on S390.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 6e18a4c447ce..bcbe58fb7d66 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -5,12 +5,17 @@
 #include "pmu.h"
 #include "tests.h"
 #include "debug.h"
+#include "fncache.h"
+#include <api/fs/fs.h>
+#include <ctype.h>
+#include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 
 /* Fake PMUs created in temp directory. */
 static LIST_HEAD(test_pmus);
@@ -252,9 +257,94 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
+static bool permitted_event_name(const char *name)
+{
+	bool has_lower = false, has_upper = false;
+
+	for (size_t i = 0; i < strlen(name); i++) {
+		char c = name[i];
+
+		if (islower(c)) {
+			if (has_upper)
+				return false;
+			has_lower = true;
+			continue;
+		}
+		if (isupper(c)) {
+			if (has_lower)
+				return false;
+			has_upper = true;
+			continue;
+		}
+		if (!isdigit(c) && c != '.' && c != '_' && c != '-')
+			return false;
+	}
+	return true;
+}
+
+static int test__pmu_event_names(struct test_suite *test __maybe_unused,
+				 int subtest __maybe_unused)
+{
+	char path[PATH_MAX];
+	DIR *pmu_dir, *event_dir;
+	struct dirent *pmu_dent, *event_dent;
+	const char *sysfs = sysfs__mountpoint();
+	int ret = TEST_OK;
+
+	if (!sysfs) {
+		pr_err("Sysfs not mounted\n");
+		return TEST_FAIL;
+	}
+
+	snprintf(path, sizeof(path), "%s/bus/event_source/devices/", sysfs);
+	pmu_dir = opendir(path);
+	if (!pmu_dir) {
+		pr_err("Error opening \"%s\"\n", path);
+		return TEST_FAIL;
+	}
+	while ((pmu_dent = readdir(pmu_dir))) {
+		if (!strcmp(pmu_dent->d_name, ".") ||
+		    !strcmp(pmu_dent->d_name, ".."))
+			continue;
+
+		snprintf(path, sizeof(path), "%s/bus/event_source/devices/%s/type",
+			 sysfs, pmu_dent->d_name);
+
+		/* Does it look like a PMU? */
+		if (!file_available(path))
+			continue;
+
+		/* Process events. */
+		snprintf(path, sizeof(path), "%s/bus/event_source/devices/%s/events",
+			 sysfs, pmu_dent->d_name);
+
+		event_dir = opendir(path);
+		if (!event_dir) {
+			pr_debug("Skipping as no event directory \"%s\"\n", path);
+			continue;
+		}
+		while ((event_dent = readdir(event_dir))) {
+			const char *event_name = event_dent->d_name;
+
+			if (!strcmp(event_name, ".") || !strcmp(event_name, ".."))
+				continue;
+
+			if (!permitted_event_name(event_name)) {
+				pr_err("Invalid sysfs event name: %s/%s\n",
+					pmu_dent->d_name, event_name);
+				ret = TEST_FAIL;
+			}
+		}
+		closedir(event_dir);
+	}
+	closedir(pmu_dir);
+	return ret;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
 	TEST_CASE("Parsing with PMU event", pmu_events),
+	TEST_CASE("PMU event names", pmu_event_names),
 	{	.name = NULL, }
 };
 
-- 
2.45.0.rc0.197.gbae5840b3b-goog


