Return-Path: <linux-kernel+bounces-49090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F308465C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18A51C225F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7909DDD0;
	Fri,  2 Feb 2024 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezlwYCE9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68155C2D9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840731; cv=none; b=R7OiwtAEY8+IeE07aOZM3FhEnUhqW7oN5K2SBCvLooSbBLWi4iHO9eaBTT7sTE66fo6dcohbFghnC/c2rY1c11jkEjdch8alpL+VJ+1ZxVuzp9AcqEQZoUlkw1Eo3pc91huIumdg8t8Qm3Jnxj86Vz4wHi1sQPg2hKAHdjMYmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840731; c=relaxed/simple;
	bh=+dGqQcOQIiIKm4nZa/D+qKz6TWrGgBGYDyGjniDUOCI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=X1c4W2FxnNSeGM84e5lg4LezbVeQOdO/xLdagakfKV0n+Bv+5zMmf85Z4BTXfNwKyns42fx0Ld8QfRbJG1pW2irKxUhhS/9tMgVVYOH1v1oYvrH9TK/xHVRmzDp8n9XzzCGQyHdvPZ4/hPt0MNYfMuoHgofSrUqRtvzgrdlIBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ezlwYCE9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60424617790so14621387b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706840728; x=1707445528; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eE8QPd1iYx3LHUzisH1HrCND1yAXDK1EtvXVhual9UM=;
        b=ezlwYCE9t6t1TrxsZ0UaWrChQKObdDSkzmUaS4H1JVsE2pBMW/diNYMo9xkG1/SMDS
         Fe4QUBKxQDLN6AMgR5q1NjsaNJ91zJjhZbK6uLHKkDc8ObUp7ozBKbvd/msiHW0Euyxw
         frf8woe9Q5Vz1CDla1eZK32VOfIa/06lxgDuFLmAFwG7FJ8eCZtuAysR+Vxwygvo1V2f
         MmbjndJ9uFLxF+TiXr+vpEv7u0L0rdl+CinBKmMMJnErfvHPaOAOE7LYi30a6qVGpu/r
         cSJrFiYtowgimvReBmTHPz9HwPahUhPjTvAyoODHJJ60vfKdQN0Sq9dBJPe7iIihieAG
         5Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706840728; x=1707445528;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eE8QPd1iYx3LHUzisH1HrCND1yAXDK1EtvXVhual9UM=;
        b=sWMRF0TYvatnluJ5axFwnYl5BK73JxiXhz1qdMPT53gxAOzbWpCip4fanwexkRUlT7
         IqXYZAuLR3rQNnQA8z1q62VFhesZCqCUk3huWMD5o1yoQxcCSpoIeN5xuvNBqpquQd1B
         xJRGmGIFaPq/nQ3cOTrrv/RX3rE1Y0W+WWZaJx126SzXKnWN98Zf1WtWtyPF9xdN23uc
         6fkDVbwaET/XkYY5FVZP8GQ0/nSSeo9kEzm8nZ7Sx29wCnJ6pnRhDsTBivCEaY7T0ovY
         snfGM+4h0vmYq8JFtDSOGWHRTXAuyMq89K3w6PSYhFpGXMJDIoK69oyUuXL5x8c9OEGu
         3j1A==
X-Gm-Message-State: AOJu0YzMXJtRvGMn1MFPux5PE4lEXONQ/RGAwEa8goTn1aO3s0NR854j
	VYILyFw03XuGL8jNTseJaeIfV/rITt2BfqCI/NfluGLRjmCall5guuSRh/767O3bAIzJOsavz+2
	kMa4KhA==
X-Google-Smtp-Source: AGHT+IFyaEF/ETiRB987VcTkusZgZC8UkNBJPlVfzM/7ddIeVtovnYsKOR8cUeLzW5k2gM7M7l+i/9HBjC2G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:690c:f8d:b0:604:1eea:a39e with SMTP id
 df13-20020a05690c0f8d00b006041eeaa39emr554346ywb.3.1706840728429; Thu, 01 Feb
 2024 18:25:28 -0800 (PST)
Date: Thu,  1 Feb 2024 18:25:12 -0800
In-Reply-To: <20240202022512.467636-1-irogers@google.com>
Message-Id: <20240202022512.467636-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202022512.467636-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 3/3] perf stat: Fix metric-only aggregation index
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


