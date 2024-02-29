Return-Path: <linux-kernel+bounces-85909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD05586BCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EC41C21B24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9128E5F478;
	Thu, 29 Feb 2024 00:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOrbWy3X"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3A1DFC6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165943; cv=none; b=Vj2ViQ+4YbW9DoeF8UUu1JN4KX8E3pKkMY6fmQOA1/KdCf0LOBdRnSqylI7S8O1xQ9sYeWcGKdYuKJYWEOQQZKJEzA231JkQZMRu7P7Ctuset6FG9OTq4TNv38uJFzi0V3gLBH5XMQWY4SRUvHqdoB3+dT5RMCR8WS7RshJbwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165943; c=relaxed/simple;
	bh=fOe0QR0t4OQ65kB5h4f3RSwkpTEtB27EsEiIpAN0gXA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QQ5IgUMSpIE4bkCzB0SIATkwsTyPiHXjUjZnzzPuAbVaAVVJC58YFoSmYDmSzEiOjKPTy20U8kTZ7SnxIs7N1Dqg/mcMlhLOwfi3TwSIBQYasmv/+dw8ShhR97AkdQ5lA6jE/0Mirz25Yt2/nwoV77qfvWaLZrFefBvvqu5nXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOrbWy3X; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so584811276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165941; x=1709770741; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzyPImOsBkhbJpUz/fKV9tFh3RhaMmxr7x9cFs/2Ci0=;
        b=eOrbWy3XkobnNHUpheVs5/38HAuJR8zepnCXhE/r4dM258Hh/x4RN+U8NGZ1KIUGqa
         +xM0gwnlsHBPBcGpQR8lP9RoQpkEXSXTXOySo1U+0yBZ+WZfbLGREJtZ2GM5isW8KPqa
         6Yoz3BCNwnMWjOChFYnQaC4mjqAum9Wz4UBVXIn58OpigW9jEV04Cij68ggi3TsUYt0A
         s+3Cg3TxSQwRDilCbMwft/uK50FIuf2iDnqFx+k1nAZv3WOi4rSy9BVu5fP66tFnZsAu
         lnRQxMTaGJ391NtjU0LNbp+NntkxH0TPG9huEv9oMASKbeDN6O3KHzH5gPq7ZKRR7smE
         K8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165941; x=1709770741;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzyPImOsBkhbJpUz/fKV9tFh3RhaMmxr7x9cFs/2Ci0=;
        b=HVbp+lFhHQ1nhCDDa9CVm8kl+PlS1N9LmO+ocFT+y9Mrg0B0Tcs+dYAiVYjjMegnAX
         vFe1etF8yRLUtffhtfhluICDb4U7BaN3dQGy7Geok11k7XPneRzKv8HmfnuJ/ANcYDq1
         NVZ+6wyttm0Zn4dGKjwa6duWGgN2M1f/cTIi8vg6r20JuoWdvPmjob8hk20LwwLXItKw
         0E479t1HAofL9fFYhXxGQVuuEW5eppUpITeG/MQAtWCt7BZmAz/6AtITPL+BdWxi+5LA
         ZFNJoXKzqIlnamoibJ91dFlYrqXNtVpcSpFxbanwCb7VfJjZY4z0fIaGf2PMX7uKfMu7
         kc+w==
X-Forwarded-Encrypted: i=1; AJvYcCUFvXquzxzkSryw2jiWsV9vMRCO5YBc5GAm+v/QyzDgvNMuCF75ELR/QKHJtZ67X1UI8OWLOg8lbhbsdqYlllhGANu2+F8MaEVruk0M
X-Gm-Message-State: AOJu0YzTZIDmqD3RCv4HX/kfR25tmzaNcX/UYto6XmDos8AKaf976w4b
	24/oler8+hDPEl8t8xsAjdfKv5OHhgHKIbWukZplsBiM+ShH/3sKgQFVzZMyRyk4gzn0kD3TNyP
	4X0aW1g==
X-Google-Smtp-Source: AGHT+IEVS8gW8zIntOpNBjyl59fNAzTOBz14U9enaTIw+HW7zVKv/3puDP01JMib5kEznj873PCq4xWf+k8O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:d45:b0:dc7:5c0d:f177 with SMTP id
 cs5-20020a0569020d4500b00dc75c0df177mr193731ybb.6.1709165941515; Wed, 28 Feb
 2024 16:19:01 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:01 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 16/20] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
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
index 8d02be83b491..82fd23cf5500 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
@@ -876,6 +902,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreMem(),
     UncoreMemBw(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


