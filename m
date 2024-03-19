Return-Path: <linux-kernel+bounces-107291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294EF87FA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979871F21F14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7D7C6E9;
	Tue, 19 Mar 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOYuo7xg"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C7E65190;
	Tue, 19 Mar 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839686; cv=none; b=eh7f68tgkRuCOWWKDZplR2xINKyXxdzgyrdojN+3syFxucMjezEx1gzTzZPDhNvTsM6t4KA2GCgPrG2Os5d+F51FSyfSgnOkow9YM9UurW15mg2nxwV+MGgyY8j6Vs+TtBhQLxhyuPNVQsC9k6fqOrybLEuQC0a5n2kpQDlEcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839686; c=relaxed/simple;
	bh=oKHnxYKGFHqY7x5YC9ZamueUL9Sj4sEs0Sa6AGcm8aM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GTNNXzD7m+qM0j5hwfquqjfz1oRXGm03RKgeI5ynu0LXVgKM4ObSL0YcNL4Bhz092gGi2J2n4XRbA8GRI3kYOSOHbhC+ybtnYBiTspfZsJlBpEL5R7UFvc0Th/kkwbpgkxNyPbIj/FqWmoDm3RudJtiHe3df9qjbGK/1cr4s9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOYuo7xg; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a496fde460so1566481eaf.1;
        Tue, 19 Mar 2024 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710839683; x=1711444483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUlrU16CKjVYBjCaxlOI7ucHlYaMstrvh4yuHwavQzA=;
        b=OOYuo7xgBOxHV/QdSQCatZkkxkhelgDmfFzbpWo6tixfD4KSeDh/8a6/RM8IZc5vqM
         I6ELQc8LXR+2GIEbW2qLaQrwql1HTxhZgPQwL/Wjmv42nVexdQ/L9tYvi6Sra3gC17bt
         RN364lWX1Yka+vfbabZGME1j+MVTtGLqLF9CysjFg7ZN+JcX+qVqk/NvDUWOSy5g8Mqv
         7WcmkAmHm8bgDA8c90otkc6kqx6GLPQbJ8AlFEU0WuRiFobLFDqf/SBpx/skDVE3BKsv
         4uNRbH059VeRG3ocIdsnCEGFmwPPTKKn866cNu/hHU7avIp4zqXjZ8kl55uy60CVFICD
         CyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710839683; x=1711444483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUlrU16CKjVYBjCaxlOI7ucHlYaMstrvh4yuHwavQzA=;
        b=tWuOei+YehC+/UeQDoE/K88GYqpGhdMCt2gFGxQmHEeuQmJU6iesQEfzUU6tJ68mpe
         A8jrdeP0INffC0TtVP/Z+uwjqA4r/bpWR3N4UyvfmMvdi7L3n5JHRCWgQ7xCsyajr8pm
         2/5imOvEuTqmxBHSh378qAP5BvkOLWP/J9jB1oxofpF5z56/4d57hzL0z4RGgmblc+IQ
         /PhlQaVMIMbxj5SDbLHhyIlCoid+A+RBKUYGRQwn8hvqgAr2i7PN11Gg/4aeIuGv4Szv
         xcQkGUCVgXWEm1o7UGztYBW5PVh/5mhlNTwnYdPzFWwRWgFaMCGnb3RNOBF7J2o23fTM
         HPng==
X-Forwarded-Encrypted: i=1; AJvYcCVNg96d9JCbGimW7ueglrKgTEVjdHEPaAACW5oYvp6Iszhn5zdc24qc6cUAnvu++yu0etr4B3HET1yxNzf2/hZtz7SXLnPoKpLHCKcbTHMpHXlH/ly4GHKCGPwqpKvm8uBBTPEZJ4K3FMCUAqintw==
X-Gm-Message-State: AOJu0YxGvpoSdM7MDMkdSz8TnzIiN6HwngIWEwjazMm7Hu/Xt8RmTHP9
	psGEDjknSFGT0nf8MznWlfPnDAaYoaBH0edG6sM+JnT7AXWUrD63
X-Google-Smtp-Source: AGHT+IF6ELn2l7Ncvy+BMZFxMSCUj511v3BuDr4pqJEkEQYzato7N/0c32U686IrQJVamhGfxjkW5Q==
X-Received: by 2002:a05:6820:16a4:b0:5a1:b49b:f5c5 with SMTP id bc36-20020a05682016a400b005a1b49bf5c5mr13610234oob.9.1710839683614;
        Tue, 19 Mar 2024 02:14:43 -0700 (PDT)
Received: from pc-mac.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id n9-20020a63ee49000000b005dc4f9cecdcsm8662051pgk.86.2024.03.19.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:14:43 -0700 (PDT)
From: Chunxin Zang <spring.cxz@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com
Cc: yangchen11@lixiang.com,
	zhouchunhua@lixiang.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zangchunxin@lixiang.com,
	Chunxin Zang <spring.cxz@gmail.com>
Subject: [PATCH v2] perf evlist: Fix 'perf record -C xx' failed issue
Date: Tue, 19 Mar 2024 17:14:29 +0800
Message-Id: <20240319091429.2056555-1-spring.cxz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpu has 8 performance-cores and 8 efficient-cores on my pc.
0-15 are performance-cores
16-23 are 8 efficient-cores

When I run "perf record -C xxx", the command fails if xxx all belong to
performance cores or efficient cores

The results are as follows

  # perf record -C 12
  WARNING: A requested CPU in '12' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
  /bin/dmesg | grep -i perf may provide additional information.

  # perf record -C 14-17
  WARNING: A requested CPU in '14-17' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
  WARNING: A requested CPU in '14-17' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
  ^C[ perf record: Woken up 1 times to write data ]

The reason is that the cpu_map of 'cpu_atom'-evsel is empty, causing
the sys_perf_event_open() result to fail.

Changes in v2:
- fix memory leak about 'intersect'

Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
Reviewed-by: Chen Yang <yangchen11@lixiang.com>
---
 tools/perf/util/evlist.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 55a300a0977b..babbde29341f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2499,7 +2499,7 @@ void evlist__check_mem_load_aux(struct evlist *evlist)
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list)
 {
 	struct perf_cpu_map *user_requested_cpus;
-	struct evsel *pos;
+	struct evsel *pos, *tmp;
 
 	if (!cpu_list)
 		return;
@@ -2508,18 +2508,28 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 	if (!user_requested_cpus)
 		return;
 
-	evlist__for_each_entry(evlist, pos) {
+	evlist__for_each_entry_safe(evlist, tmp, pos) {
 		struct perf_cpu_map *intersect, *to_test;
 		const struct perf_pmu *pmu = evsel__find_pmu(pos);
 
 		to_test = pmu && pmu->is_core ? pmu->cpus : cpu_map__online();
 		intersect = perf_cpu_map__intersect(to_test, user_requested_cpus);
-		if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
-			char buf[128];
+		if (!intersect) {
+			evlist__remove(evlist, pos);
+			evsel__delete(pos);
+			perf_cpu_map__put(intersect);
+			continue;
+		}
+
+		if (!perf_cpu_map__is_subset(user_requested_cpus, intersect)) {
+			char buf_test[128];
+			char buf_intersect[128];
 
-			cpu_map__snprint(to_test, buf, sizeof(buf));
-			pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
-				cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
+			cpu_map__snprint(to_test, buf_test, sizeof(buf_test));
+			cpu_map__snprint(intersect, buf_intersect, sizeof(buf_intersect));
+			pr_warning("WARNING: A requested CPU '%s' in '%s' is not supported by "
+				   "PMU '%s' (CPUs %s) for event '%s'\n", buf_intersect, cpu_list,
+				   pmu ? pmu->name : "cpu", buf_test, evsel__name(pos));
 		}
 		perf_cpu_map__put(intersect);
 	}
-- 
2.34.1


