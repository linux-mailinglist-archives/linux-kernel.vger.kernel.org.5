Return-Path: <linux-kernel+bounces-137787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5A589E7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030C7282E84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA64710E3;
	Wed, 10 Apr 2024 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaXN0y7b"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F411388
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712711630; cv=none; b=flsToIfyXqi9PDz7D1EsksPSizxK8hNL8R/k2VvbreZROYNW9ixoklFlyirz9NBG4JaZ9ZrQK+lHrnxr7qFaFAUplYuXW07SlomyB6PfmYDNX+3RzeaH7MIisTCCCCkiynC00bFlpND1sEqbEdOqemfgO7ZV/b/k+5N6NUClzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712711630; c=relaxed/simple;
	bh=M65fNwSwh9BiHq0mV3DNrUCgN4AR1tOb0IGVZ7OHmRM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=c6Z99zT5l1tMpBLXQ6AgELFwBfw40gZLHKhWjNpY4Hoq4Kr2xO18in6D0T7cM5gIWBd8RCOz/ufqVxBm6AELMdqsLAn5f45VprMgdQhsju8R6Zu8IxbEcIvif/4FTJIBjYuVlwxiQhgsU/vlw+Lw6hbKfko1QMmqcwUDSLkFbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaXN0y7b; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so10505968276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712711627; x=1713316427; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4xie8uj9BDUohl4DePeQplLYd8kg2wj+kRcizQZi2K0=;
        b=jaXN0y7bsyPwi1Nww/SfFCmeugTSX1r9stnqc3zbqdZsVHk7peZvCENoHXygadcpa9
         JvXKdhbMBYcWoIaGJtm11UX5J1ipQxMNiIQQxYgbjwYIoHzNbGc/eGIRPIRUQWsknmwY
         hbcfUyHsGTbISpzXk9FFoKfoQUFrHU7miXV+xXkX/7kqy1WlQDJ9MaXyrAs6B0nBYgVt
         aDI55LmpQ9UZvIldSYAdMYkkV58YBBY1xu8Xgwqema+ygXMmRu2wX3BL4b8H1tU2yHaF
         CbKdfIL5DcDhsq+pUFsbVF34h8qzNHBteH4Bpyksz4L7KJxEB2OzwI8jr1Y/dq4lQbX7
         8FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712711627; x=1713316427;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xie8uj9BDUohl4DePeQplLYd8kg2wj+kRcizQZi2K0=;
        b=Mtjd5z5PXrVTbGEiVuxqMwPjrXIkxj95mxB8HGCsUqsF02TQ4uyqaeGpRGJ/dH/1ad
         YGd+m1IXFZ/a1gfB3940l1opu/s9wg4rOI1RdhDF3lOk2SaQXIqCudK+Yw2jOAMNmKal
         2vyNphl0yWssC3j3158WkZ2zd6ANAMPMeeXfYRHvGsTnSsA6aC+jbke+XV5Fjb1TBNWC
         41qq1z9Kukb3mQwSVOCnuLtsmsPGH8ef3D1FF5sNsFRgWANh0s0AWOlrAzN82b9dsu43
         VX/0vWWdFCOgdG+TleALKA5XvXuvak/04XreBTKEyi4AYubxHeXuCoZ6qZPOr/wtmyZw
         LUWA==
X-Forwarded-Encrypted: i=1; AJvYcCXC3XLZbzgudhuYX4raCyYovxWK7ep+LLaS/uKG5ADJ/cjXMAGwnxshm0PQaSFMv3BwkxsVX9A6VfzJaIpxMl/pB8GRxSc0OzKnBPl3
X-Gm-Message-State: AOJu0Yyr9bnzr0OSmLqiGJ7TVlIsGRL0gsa+A8LXfpVVwyphIhywZdLQ
	4y2HayvN9u32DQKipnw88JWzTAypJtYyOd2ksfXQMp7OWs4qiYjoBtKrklKz1YOBisonKtaEJCV
	gD3cujA==
X-Google-Smtp-Source: AGHT+IFXnwJ2Ug+QEhcW0ZJoGPfOLzsOTd8PV/DiPVs5SLQPV0sIwoyzSuuw/OBefxW9OQGegwA4OAImf+Tk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:1242:b0:dcd:3172:7265 with SMTP
 id t2-20020a056902124200b00dcd31727265mr404933ybu.8.1712711627256; Tue, 09
 Apr 2024 18:13:47 -0700 (PDT)
Date: Tue,  9 Apr 2024 18:13:12 -0700
Message-Id: <20240410011313.2556848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v2 1/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Bharat Bhushan <bbhushan2@marvell.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
the previous PMU sorting/merging code assumes uncore PMU names start
with uncore_ and have a decimal suffix. Because of the previous
assumption it isn't possible to wildcard the mrvl_ddr_pmu.

Modify pmu_name_len_no_suffix but also remove the suffix number out
argument, this is because we don't know if a suffix number of say 10
is in hexadecimal or decimal. As the only use of the suffix number is
in comparisons, it is safe there to compare the values as hexadecimal.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  |  2 +-
 tools/perf/util/pmus.c | 51 ++++++++++++++++++++++--------------------
 tools/perf/util/pmus.h |  7 +++++-
 3 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f39cbbc1a7ec..b0cca5841f90 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1657,7 +1657,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 {
 	struct parse_events_term *term;
 	int pmu_name_len = skip_duplicate_pmus
-		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
+		? pmu_name_len_no_suffix(pmu->name)
 		: (int)strlen(pmu->name);
 	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
 
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 16505071d362..b4ddcd0ade26 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -39,31 +39,44 @@ static bool read_sysfs_all_pmus;
 
 static void pmu_read_sysfs(bool core_only);
 
-int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+int pmu_name_len_no_suffix(const char *str)
 {
 	int orig_len, len;
 
 	orig_len = len = strlen(str);
 
-	/* Non-uncore PMUs have their full length, for example, i915. */
-	if (!strstarts(str, "uncore_"))
-		return len;
-
 	/*
 	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
 	 * the full length.
 	 */
-	while (len > 0 && isdigit(str[len - 1]))
+	while (len > 0 && isxdigit(str[len - 1]))
 		len--;
 
-	if (len > 0 && len != orig_len && str[len - 1] == '_') {
-		if (num)
-			*num = strtoul(&str[len], NULL, 10);
+	if (len > 0 && len != orig_len && str[len - 1] == '_')
 		return len - 1;
-	}
+
 	return orig_len;
 }
 
+int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
+{
+	unsigned long lhs_num = 0, rhs_num = 0;
+	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
+	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
+	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
+			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
+
+	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
+		return ret;
+
+	if (lhs_pmu_name_len + 1 < (int)strlen(lhs_pmu_name))
+		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
+	if (rhs_pmu_name_len + 1 < (int)strlen(rhs_pmu_name))
+		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
+
+	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+}
+
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
@@ -164,20 +177,10 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 static int pmus_cmp(void *priv __maybe_unused,
 		    const struct list_head *lhs, const struct list_head *rhs)
 {
-	unsigned long lhs_num = 0, rhs_num = 0;
 	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
 	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
-	const char *lhs_pmu_name = lhs_pmu->name ?: "";
-	const char *rhs_pmu_name = rhs_pmu->name ?: "";
-	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
-	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
-	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
-			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
 
-	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
-		return ret;
-
-	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+	return pmu_name_cmp(lhs_pmu->name ?: "", rhs_pmu->name ?: "");
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -297,11 +300,11 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		pmu_read_sysfs(/*core_only=*/false);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	} else
-		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", NULL);
+		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 	if (use_core_pmus) {
 		list_for_each_entry_continue(pmu, &core_pmus, list) {
-			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 			if (last_pmu_name_len == pmu_name_len &&
 			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
@@ -313,7 +316,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
 	list_for_each_entry_continue(pmu, &other_pmus, list) {
-		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 		if (last_pmu_name_len == pmu_name_len &&
 		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 94d2a08d894b..624c2d53fc30 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -2,10 +2,15 @@
 #ifndef __PMUS_H
 #define __PMUS_H
 
+#include <stdbool.h>
+#include <linux/list.h>
+
 struct perf_pmu;
 struct print_callbacks;
 
-int pmu_name_len_no_suffix(const char *str, unsigned long *num);
+int pmu_name_len_no_suffix(const char *str);
+/* Exposed for testing only. */
+int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
 
 void perf_pmus__destroy(void);
 
-- 
2.44.0.478.gd926399ef9-goog


