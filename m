Return-Path: <linux-kernel+bounces-74161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3819085D099
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E0628734D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4E3A8CE;
	Wed, 21 Feb 2024 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fp/fwxhE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D113A1D4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497937; cv=none; b=NAeNNi9OvnOTvSOuq7bSUsjzYvL8wMwqlsaA4mO79qookXcGGu6tlQUgCO4wsuJly+A3DnDox4mPGEO5pW4EobiLK7JMG8572lpLfub2gyCHwTvxJmu6PA1fVq0ynJ+8YuB3HR1Y6ZDBW5hYM33xInFMwHJyAYpRueIHod7oTck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497937; c=relaxed/simple;
	bh=/6zujSE566bACQeKSvHvMpYeeTA8PlC2Y0AN3XU66zc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=FreJb8J9H8sPWU+HxOiJQI6TAQoTc+J+7FH/dJd7wQt+7dwDN6W2p3qaRP0hNTFWgxFL0PkEslyjmQo4N1G4ZVvJ2kUnsaEHDrk4M7GULFhRwYuH6q11RL+IQf6sYzBKD0FXHvc1ED7Vc+a2yKtfSWoKvFXKT60LKNGYX34fm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fp/fwxhE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so12781541276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708497935; x=1709102735; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/pI7AtchfWx5feeWTlX63xH7EqjzW5vpXnx4QlPqwg=;
        b=fp/fwxhEI01Fqx/jks8ALYZtPem7JIH9Lv2V8MUXGgo2PRCpRHXkjL7oo2/ddP2607
         5rSY3Tzh7RQBJoMduCexR5JFm3/nRVTnSOTVGZQnGsX+qKQ0NXy4hE8rDd5Pm6+oSVko
         Hd6mEHrewL9X8vOdVeMoTw+BBqojr9t5OhByVJNCcE3Epwbbm7yYhPYt50fFbsZyMgu3
         BZo3JZh5cYk3DwEyxhx62c7pbIhyy1HeaYviwkgbqPp1C0qVOvJNOLuPHlm6wiSBHTRl
         b/89ulYshwOkdgqQEG6YYxjucxivheF0wmbf0r7UrZS1DocBGB2TJMz/cHdwf3HXHqWH
         uGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497935; x=1709102735;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/pI7AtchfWx5feeWTlX63xH7EqjzW5vpXnx4QlPqwg=;
        b=llxBLECou/gZ+bttyp+e0qPP8a/BrXAzkDgtfg+UABh2eWtoRD8Q6UZB5RTfiUiyBA
         IpaVncSYRn++o/7KgFMCf/Dmh/6yunsEWWRiF0twpsJOHviDWLxAEBGXKo1z0VRkWoeq
         I6Uy5Vg8OxGMap4+EAHupoY9OQsi3LK46ZX1HwPmUNg8HGx3DXBJKZ7dbAF4wdKf75TK
         mX4TS4j5vz9TpNOQr3LQ7nna4+fxuubApqC5p811in3Fb2nzld1BLrUMVtFBfqYS+mkJ
         boltA7i6JFzHif3MGMle7q5hTy4hw2MBbYIttim0VM8gIV9QiFDNkiiJbfgrRe3a+MS+
         qwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM78OpTW5ZJj85ycmA8gkIMovy1jlsGZxNJnd8bOKeCBss+3aSwWJrgmIAfGKWrMK8yIzbMZUDl+xFVt1+g9MlSVL56HZnBCMhQeVp
X-Gm-Message-State: AOJu0YxweHgPckeE+WTv1g07ZIN+rcyfUDmZYju8k2uEzyrQwQBPGBot
	VjYqHaEXdQI2M+ft64LgzwxwYvsBoNOpJu9hk8du24SG7z3rBAHIFYtU7yz5fCw8gn6sRQHqjJB
	nFT393g==
X-Google-Smtp-Source: AGHT+IEwYgbJA0O1mFJMicyN/Dg0T7MX19vCpK193t3RzYHu3hebTrqejNfBSKs8JWdQ4ffOe+kV7ZVsQhYl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:1104:b0:dbd:b4e8:1565 with SMTP
 id o4-20020a056902110400b00dbdb4e81565mr5476893ybu.4.1708497935001; Tue, 20
 Feb 2024 22:45:35 -0800 (PST)
Date: Tue, 20 Feb 2024 22:45:26 -0800
In-Reply-To: <20240221064527.4157979-1-irogers@google.com>
Message-Id: <20240221064527.4157979-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221064527.4157979-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v3 3/3] perf stat: Fix metric-only aggregation index 1;115;0c
 Aggregation index was being computed using the evsel's cpumap which may have
 a different (typically the same or fewer) entries.
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Before:
```
$ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

       MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total
CPU0                            12.8                           0.0                          12.9                          12.7                           0.0                          12.6
CPU1

       1.007806367 seconds time elapsed
```

After:
```
$ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

       MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total
CPU0                            15.4                           0.0                          15.3                          15.0                           0.0                          14.9
CPU18                            0.0                           0.0                          13.5                           5.2                           0.0                          11.9

       1.007858736 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>                                  |
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ae37395f90c0..bfc1d705f437 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1137,11 +1137,16 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			u64 ena, run, val;
 			double uval;
 			struct perf_stat_evsel *ps = counter->stats;
-			int aggr_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
+			int aggr_idx = 0;
 
-			if (aggr_idx < 0)
+			if (!perf_cpu_map__has(evsel__cpus(counter), cpu))
 				continue;
 
+			cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+				if (config->aggr_map->map[aggr_idx].cpu.cpu == cpu.cpu)
+					break;
+			}
+
 			os->evsel = counter;
 			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-- 
2.44.0.rc1.240.g4c46232300-goog


