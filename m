Return-Path: <linux-kernel+bounces-54302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7C84AD7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE18C1C239EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960AE7A72F;
	Tue,  6 Feb 2024 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zgc983nK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54878B44
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193932; cv=none; b=NpZcPDAkdmeFSDw/KZm7qRw0U9msQraGyBaCxCq0kfR2f61jVWxZa2xHH4tTmajxCPxRXNgStso3/nnDU8Bsqt4tXvgNX0uvLbETGWFZ/I9QGzBPYFv+lVm1WtMiW3xIcLAlkEbXhDGK9e9i53m8/ZZPaNJAZYIlf0bXdPJnirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193932; c=relaxed/simple;
	bh=+dGqQcOQIiIKm4nZa/D+qKz6TWrGgBGYDyGjniDUOCI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=H1ZHUnvkAoawcjGj9p9SU1WwCc/NEtYri9mm2a+EBVCP4puOB0XqG1sHRB8oHjjpIXfmD785cnS6U5Cs4VALRhu0SfW7fNdD0NaXErR9h6wwUkxYY56zNQiPvyZUITxITVpkMuJh47GtLI+6jbwh92ksn4vux7Q6umNv9u8WMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zgc983nK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047f0741e2so1352927b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707193930; x=1707798730; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eE8QPd1iYx3LHUzisH1HrCND1yAXDK1EtvXVhual9UM=;
        b=Zgc983nKC3l4U6De+l/eCtpfB4LN9AzpMN6CSuAdgUVpy3wZN1M2cmhRkGxltfEaTZ
         MvUBZwRaIEuNbg4jCFqDSCd40g6pW5+ptLfGGTSH0xg/Bdm+cqrKfJYmjdIhvxw2lgUk
         qrHOwhJFJUDRqIi8KX7reLElyqEzJB5LWOsG35c8Lj1JEcz2bVDwFpcMhFMcvU237iHK
         TDYOL1RjU9qoT/0JS+FlaM3Liu3c2jKU0ieLv5UjGHLXEFijmAdt9bNUnjyC4fdlnLUD
         foCV6586U43Z1Wn1RUGIUZqLUxWhuD+o8sSTGifhLvAbHUTm+HO3L/8J9ewVISv3ctNw
         mzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707193930; x=1707798730;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eE8QPd1iYx3LHUzisH1HrCND1yAXDK1EtvXVhual9UM=;
        b=Dphg+viR9MuoQWKuSV1GWxsg42XscDcqLl7biUDrQxBy7W62ttLTYD9ZRkdKuXETO3
         ZNwlKGqs5UBwt4Nj9ab4HSbzJjWJwQZD5jXbzmL2RI+NV9jwrJMi3mAck+z2WjoQu0xI
         7Og99eUv3Mi+KiGq3Tkyi4+u3jpawONXVZ9HH761FVce9y92zNCxjLZxIBgE2NyBShtq
         nwkDjXKfRFp3Go3p8083LsCehHg6kuC33moVXHJT8pBPIP6wOUFdayMZ/3b/vntp5GX5
         frEOefhT/cds+Y/mJ4e1CM3PlGcllzGynyOYvLo8SaXzIIefEzORmhjWqCfNep9BA0H6
         A9UQ==
X-Gm-Message-State: AOJu0YwG4L8/zPAxI4LUCG6u4mtAxqlfxtPnCoEbJs1hNTEVj4hKOJ7O
	GpIwpqpd6/gE0PF9cLM0KoCeb0AZfpkxSdvbOWAyZptY31GdZt6taBiU/eDl5Uu5falWmCmupRM
	Iz4fHwQ==
X-Google-Smtp-Source: AGHT+IFs8WVliW6lEpIOaQZTGS4k5cTnGBBP/qnkpPAdjSWSWu+uKXXHv+WwRmeGYmvINFcqL+zNEtpVjMne
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:690c:ed4:b0:5ff:796c:722e with SMTP id
 cs20-20020a05690c0ed400b005ff796c722emr94174ywb.1.1707193930365; Mon, 05 Feb
 2024 20:32:10 -0800 (PST)
Date: Mon,  5 Feb 2024 20:31:59 -0800
In-Reply-To: <20240206043159.2539981-1-irogers@google.com>
Message-Id: <20240206043159.2539981-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206043159.2539981-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 3/3] perf stat: Fix metric-only aggregation index
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

Aggregation index was being computed using the evsel's cpumap which
may have a different (typically the same or fewer) entries.

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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8c61f8627ebc..ce830c6afdf2 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1126,11 +1126,16 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
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
2.43.0.594.gd9cf4e227d-goog


