Return-Path: <linux-kernel+bounces-166948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1248BA261
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CF91C22E50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D91C233F;
	Thu,  2 May 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xl8Wz12R"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EE1C0DF9
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685723; cv=none; b=BTBRGIsUJCxRU7da6dCN6yK5Jc8wkzll/0Dfs/Cu4hFq5iBykm/POsj+YKuuHYbBAAN3d1PEfPmno4mkYKDMWyy/zvLtt6YZ2TqoBU1/NfGsiE6LVa6bgqjsDkVmj+Ys2pe4/GdOACco57NFTWDE1+gTB+lx2obuxnBhCOCKqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685723; c=relaxed/simple;
	bh=LzaODOpcY1x8MkLGsXtF6i/yozt96RkuIzwffZUTjTI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=mFAivuwPcAPcI4W1Y0260TQv4uQXG8wL5fWT5MP7KSh8FQJqLT83apCJxdMm/lRASibFuoKlLGClPrKgkQ9ApWh+n1Nj3dpPOkXDhuXJxt0tf71+6hzt9QLrBQkqOzrX9oHy349cc8rvs/X+grNq1mf5W1RXLT6y5EEJ7ru9Vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xl8Wz12R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c1f7169so17497687b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685721; x=1715290521; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7T7WZEjBuFkXStQU5evNsW0vwkcSQvyjHQCUzxlSFc=;
        b=xl8Wz12Rcp13Q/R9K3ZKDgHeMG3daNhNNtmMFlP4T3x3Fl0JoynsVvlrzL/Ng2vT02
         Fq05Ipow1LywJHw1lqChpQsD+gnu/PQVLdNS8iM0kMVebrXmsjVdj9xVD4crQkbnyJzm
         42OQGvom/Tlc82ZEJMn7mGtlF3HINOYzsEmwjq86micgsAZPV7VQTr1fKQazwInatBHE
         L17NS99R8M2+Yu1Zxwqkuc3keA9JwAMZCA36SvJCuiOQ7s78sly/wrYDrvFN8oeEEQDL
         g3JGgteJ190moI1a5vdfC8N8tO2QHZpxKAWmkyx8itBpz/zWD6Fa78d9H3S6rxfxtAWX
         4umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685721; x=1715290521;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7T7WZEjBuFkXStQU5evNsW0vwkcSQvyjHQCUzxlSFc=;
        b=aNMyv/R3FUN5gcUzH/wFqCnoARxiY904IccEUIHq/Q6yGyhuyIfzjvIa8+RA7mNOao
         OTKBaHveGts3WTNMYEZG6KktCrNZ11oOd8KkfTek3XuP97FsheGC52oK4yZbUv1PU+Sn
         9wXmryP9jV5MZWGj18vm7qhXDXwSvkpqrPix7c/ctz972UGzYlvfJ7le9NGdk2bQThCM
         dQ8CeH3Lf8KdYPuNQLXk1/uJYVbq6LDubDZ3kNFBiUHO5ZHn+ARXeQyhvAlYgjyeJZpm
         vj6/GL0Ye01wOcyywPlx3YXnqa86yDU39Ff4r7A+s2pOEaWx/ejDhTCT6K7R0ZuFOoY3
         VPNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuLxdYkpD69uh+ghefCKZ3I5BRmdf8CjJlKlq/zjIrdUbtIWni/gUTJWoaH+DeFGKEvPoojI6bHCzBvlIN8mKJTPQn01/CdpA8OTIe
X-Gm-Message-State: AOJu0YyVpwUKWEGZbaEbAGJ+Y0lLXX+kOwC5x+JiCpDmmyZEn7SXsj8K
	jFH0Efg6YMMDOVjDZS63ELmU/lqK3uuJlrqUD+XEFtpG7wBdj1Bv3QLQSFh7uKPaEbr0sozJxst
	1FQ6udA==
X-Google-Smtp-Source: AGHT+IE96253la+W5w82RGrU9iiMHjmCN4kCK9hxJ4G+nZztuN23VK1xyUEq3B6SHLIS30WBMQYFp2AOkzVP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a05:6902:1505:b0:de5:9ecc:46b6 with SMTP
 id q5-20020a056902150500b00de59ecc46b6mr318413ybu.6.1714685721504; Thu, 02
 May 2024 14:35:21 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:06 -0700
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Message-Id: <20240502213507.2339733-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 5/6] perf test pmu: Test all sysfs PMU event names are the
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/pmu.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 071cfc51b52c..06cc0e46cb28 100644
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
@@ -251,9 +256,94 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
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
2.45.0.rc1.225.g2a3ae87e7f-goog


