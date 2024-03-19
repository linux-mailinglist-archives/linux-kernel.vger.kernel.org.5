Return-Path: <linux-kernel+bounces-107259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16B87FA10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1798A1F21DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D9B54BD7;
	Tue, 19 Mar 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR2ReLWO"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAB54BDE;
	Tue, 19 Mar 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837648; cv=none; b=gfhw69tuxFDHO/VAxEUfr8WzzzgOWpjJmWDygQeEtzCFnGxds73AM7VhIXGY2VRuBJtdowI02+NJFhIUGR9k9XeZj9HII/bO76o0bPPxPnIZoz+fz9dVG5SVBflU7qbYvWpcRYCNCFeksltXn5uF6ccELvDQa5ZqtL+2pQuVqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837648; c=relaxed/simple;
	bh=gz71p/nJEsrx3+lgmCh98s5ZUOqm1PKXA1OmztzvK5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GW/I5YpKwLj0K61lEaLyhgZ2GartLJMeeTYa+rz10Oe6Jmr+Z7lvqx5kDszaaYSC1JrFjRQeSAppLzGs/eZ4prgwBhJZmSx+E46lpvbi9ioPAv1PstpScc96Y9b1hpSW1D9ado2Q5CRt4LmYh86RHbf8dMdjNmTm6EzIKiF6DVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR2ReLWO; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c35c4d8878so2350233b6e.1;
        Tue, 19 Mar 2024 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710837645; x=1711442445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTogkvYb3XenoZM2OZvH6TmhSvbc9quUpAWjq5+6IM4=;
        b=eR2ReLWOsNLh8OtHRnGCEepIl5B17sLpeWYUj3Gd+UAGG5Ee8e5kIIZph5aJQd8bZS
         ZntpUa8pmkhdlGBUwDhG3bVFeGQbtjPvOVUNURUwvdKlqM0s2V6O0Er4+0gJR34xJYSc
         46bVs9SUK5QxfjOihhT2K073m66hb2a/FHMtpOyk0LFqTuUIlwnkQwvMFapQQdkZt7zy
         Ede9cTJ2yBCPtJ+tGercqpl/Cs2+5n47qloKwb0b0B3iw35PQ6x+fCeTHSHqubQK+BpT
         xi4gPFT+pXCvwQJqLvrnPccB955i8Vc8Saxo2ml4Ywod5L7UudUZk0W1uFQB3RcvcSXp
         kueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710837645; x=1711442445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTogkvYb3XenoZM2OZvH6TmhSvbc9quUpAWjq5+6IM4=;
        b=m9/gF+QcQ3sQqPJMpZm3SVdcTU8Q1/f33xUuIZ7C5JX8XTbnnUcan/FvOOtv/Gi4Y/
         A91YyuBBrQ8hnoKh0XVlZMNHfr1dubosrMCvB90dmg5+1R7CDy8ukcl/znIMSe61m29P
         rhPiuzhaz5Zz/f0IQvcrj7UH0fkRhvuNLFn5Qxar1AOqq4SyIe4ysXkAu0C/CAY/kwB2
         7UJwFrspkTHN+r52wdn63EEOUGFvJ2dHvWbHrNERGi90ykX8lR5BAhLhzFo1/Emovv/O
         0TNVCxLpYj93ME0xtZu58/5oFvKZ5jkzVE2jGMQ1Py1hiCYIpfvNjD/5XgtfCtojFrcb
         Qmsw==
X-Forwarded-Encrypted: i=1; AJvYcCUGK4LMc98e2Armon3KOBsiPs55cIx6Cnxtx/Ms0tLbSd6WBqXinJvqBzFTSIGFyUyHpv3WnGdJVmHAAlh4IoAJedTNJ2qmr2btAPMiFDluL5QrBcSd4r3K5TVVEb5APRBeF7Bs32KQ1h7sKgnouQ==
X-Gm-Message-State: AOJu0YxDdT64+lGRreMqBxqtJkememXbx+/2yGtvStFqhFYP0tjoXX8D
	/dOg6aeJUctwq2IYggmzczXFZJ/qvMkIVl4e4BzdYkXt7NonFk28
X-Google-Smtp-Source: AGHT+IGBmjZiZPz6VdCudmFpGbwmjy7w+Akh4ps+k5oo3a0gYZ5sUXrI07e/t4tw/IgAykEyo9486g==
X-Received: by 2002:a05:6808:d4e:b0:3c3:977b:7c55 with SMTP id w14-20020a0568080d4e00b003c3977b7c55mr1192239oik.18.1710837645371;
        Tue, 19 Mar 2024 01:40:45 -0700 (PDT)
Received: from pc-mac.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7865a000000b006e6b5e65579sm9206749pfo.106.2024.03.19.01.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:40:45 -0700 (PDT)
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
Subject: [PATCH] perf evlist: Fix 'perf record -C xx' failed issue
Date: Tue, 19 Mar 2024 16:40:22 +0800
Message-Id: <20240319084022.2036296-1-spring.cxz@gmail.com>
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

Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
Reviewed-by: Chen Yang <yangchen11@lixiang.com>
---
 tools/perf/util/evlist.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 55a300a0977b..4dd0d0980606 100644
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
@@ -2508,18 +2508,27 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
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


