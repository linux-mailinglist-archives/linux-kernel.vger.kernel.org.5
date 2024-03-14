Return-Path: <linux-kernel+bounces-102858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1387B7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EEF282593
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDAF1798C;
	Thu, 14 Mar 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARbU8Q+8"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDDB53816
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396012; cv=none; b=VE/51nex+Lym6CM+CssCdwS6gY5z0frTTd996weSlHMNCsssxEZFgbIItXf3F2lrl06FdNuhWZwKMnDVXeVJjxdFalKZ4nrOn2hDQUVrzawqaNzzOziTpDsOGImm7ZGrKSzbOPdB6UeYvz/5PqAvgcI1GVFf2Iz+RfFzgZ10jIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396012; c=relaxed/simple;
	bh=5vGBa7vsebiJJB1YfqifUQF3HSZMEk4GQJ7s/+b0FVE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pTD2hKlorU31UxE3CIMUyivVW6hLP7Cj9KuRxpDb6gxZk6dZpp8UJulI8mM6gmbXEo949XMcSaqte+96K4a2h7yS9f3u0fwGO6C2EqW2mMa9z4ns5JuFK2nC8K5QdJErP71BJPPyZ33kqS1+6HF6WwfY6EMEfLG+r3qq8USzdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ARbU8Q+8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a54004e9fso12942467b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396010; x=1711000810; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UsYsa6L3dXtrvFFa4GSQJpZwL142VFZWkHKOYixoWY=;
        b=ARbU8Q+8c0ERc8UNPh5ZSZI5gEBou4JK7QYqNrwZk+BVh+TBljwcik5DnXNolfI1QG
         8aV2kZIW/swGnQBn3K0mbhzHFvQwBN3lmkmm9x/RegsBm96vQlZ82neZcSOAm//GvmIj
         zcywAmeEPGi9gnt37KD3BQkbr7IR8pAWb26O6SAGWHGdkqodKTsoRXc7xGW9cP0H7Xhn
         IEpGIt/JFiKl6ZbNTWvN7YHeMCXgtdD5deBfN4prBfj9zqhv0vlt7Mk7SIuqb9FSBSr/
         89xPHjP6QurLjFRN4DgaCQTe8Nus0ItZYNVJoAB3ZKpe8JGWJ9f1baWyYVPE7rpDfTVs
         SR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396010; x=1711000810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UsYsa6L3dXtrvFFa4GSQJpZwL142VFZWkHKOYixoWY=;
        b=ZO+n798SMz6rNgUS9XHG3e0wRg72TAarZnkT3YnkauvSPpgzibXfxWpYmZRoF4jknn
         tkrnfdMAciWGVmme1/fUiCOVB0iQtx9mk0bYBS0/l6TaJ0p6BwSfttm6ds+itBXill/z
         0+e0avI/dTiJ8HIGcztySQmawA/c8cQOvuZsID5qNymSWJh8nUHTPdG50BEprQQ9v73Y
         CrnONrklKbQIHOmUDlK1q7xWoQROzfQH6VSJkR8sawK530Myo84ja5nZO9vHNMX1mvil
         vHozv6zhns/P40toIjH0i6ffvhFvWIdsYnne5ygt+Q3MRxLVLBuGDEi3o7ZY6p3ixbCH
         8b5g==
X-Forwarded-Encrypted: i=1; AJvYcCVzG8yUuEju5iSnCXH2bHww27iWHaiHj4ljWwhGvHfKBw5gFj8m/0dNbxSyO7TK+UPakxvQHnVFHv+mdQJRz6Ui7HJFIrl7enE+OIqP
X-Gm-Message-State: AOJu0YzzW5rPUVjqviXkWEg3TgyacmJem+GCX23VqqLTLv9DF3YSKWhV
	UyReap+Fn/B1QVh0yLFjKrP0QOK7A09yfFSaBEdnDIWACRe1l5VKWjeoLMOIfGu9pDaZCfxhfBT
	F6lz1sA==
X-Google-Smtp-Source: AGHT+IHhFvrJVYOJ6LQNqV+t6Bz4uTYsc3YEBzeF1eZBLfIWr9zJ5KYTkmxypQYWYjRd/Zk6lXr4R8vUi6w3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:48c1:0:b0:60a:48d:c563 with SMTP id
 v184-20020a8148c1000000b0060a048dc563mr212977ywa.5.1710396010579; Wed, 13 Mar
 2024 23:00:10 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:15 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 16/20] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index c7f536d3d4ed..254a4e73d926 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -777,6 +777,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMem() -> Optional[MetricGroup]:
+  try:
+    loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
+    rem_rds = Event("UNC_CHA_REQUESTS.READS_REMOTE", "UNC_H_REQUESTS.READS_REMOTE")
+    loc_wrs = Event("UNC_CHA_REQUESTS.WRITES_LOCAL", "UNC_H_REQUESTS.WRITES_LOCAL")
+    rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE", "UNC_H_REQUESTS.WRITES_REMOTE")
+  except:
+    return None
+
+  scale = 64 / 1_000_000
+  return MetricGroup("mem", [
+      MetricGroup("mem_local", [
+          Metric("mem_local_read", "Local memory read bandwidth not including directory updates",
+                 d_ratio(loc_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_local_write", "Local memory write bandwidth not including directory updates",
+                 d_ratio(loc_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+      MetricGroup("mem_remote", [
+          Metric("mem_remote_read", "Remote memory read bandwidth not including directory updates",
+                 d_ratio(rem_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_remote_write", "Remote memory write bandwidth not including directory updates",
+                 d_ratio(rem_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+  ], description = "Memory Bandwidth breakdown local vs. remote (remote requests in). directory updates not included")
+
+
 def UncoreMemBw() -> Optional[MetricGroup]:
   mem_events = []
   try:
@@ -874,6 +900,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreMem(),
       UncoreMemBw(),
   ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


