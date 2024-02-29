Return-Path: <linux-kernel+bounces-85905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC286BCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C931C20CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4DD5BAE3;
	Thu, 29 Feb 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwXLDHV5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D575B676
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165934; cv=none; b=SpBAbDVN59R5oJBV7h/3B02aIrW4WIGZUid0Q1uCvarBM3kX8N/js7Vj0nz8RTXwXUvpYZOtt2bRS83iXMPQpgDrGjS7qzhMyNK6h0cTsL8idw0voYOQWah7p8+uchP8ZpliJlRWQ5aulb9ASb9d/VQZzdt7ZXrKowCu35uqBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165934; c=relaxed/simple;
	bh=RoQ1W/NshIyvCHXY6NTFpS7T0JU0YBtNXF8QOlBoiBc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pZOm/EPcgDeGlQa7IcVNNeTfeXE5WageAbk8XX7oadgck6+WY+kOnJFT6fhP7nPDMg8eOFA8V4L1oBhRmeB51yusdMA3/i7bvf6lg0yeFfcY1T/RvFxsbm95ufn9HyGUXQM+Lizvz+DokZBmShM+4HO1mJseqO9ZiurjpwIkSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwXLDHV5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608d6ffc64eso5259657b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165931; x=1709770731; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9n/LydSsWhh8X4HCatLjTPGCEDU519H/3lA2USzD/Q=;
        b=LwXLDHV5wo+aNP90JaDftPEmq+JdDTH2jn2MGmqR83KNvvHElTfITFzrJqu+03mQ8S
         5Y9grskiB3qpV3v9ACr7T4H4b8vZ33NZBliYBzAaK7Drx/DNt2et+srvhsu5fS7doyiF
         wHhVDBOxtMbTWfzEgHqGON8E4zrCqI02sr4zeN1YTMzEXD+fLM1cJGQzKR2r6VD9gYDg
         er8/lJaS3naax0noTEqeoBnYqml8gQD/Htja1IWjiW/mqy6bw/EVxk6cSmqFN18fuJhk
         z9vumwAj655vbcYkBMO6r8pNqqbKEF0XFl2UfDb/npQ+RiPRcutv55TEmVP7InKCmZuw
         rBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165931; x=1709770731;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9n/LydSsWhh8X4HCatLjTPGCEDU519H/3lA2USzD/Q=;
        b=rLLzDBcQ3Qgsmn8ho2S1Wk9I63MKXqsuBitFRuEMqfcFmBCMoLqYE7Lrf1UfFCHRgB
         H80VlAdgn64STZIY3vIOJeXH5IbCSAcOdfzqPUkAUpWqg9lJia3cCEwikdJzWMRSbhWC
         rNS7Hlyz09AU2MS4ejXRiIQOVXizAzejYgIcRq9p2FjQovDEn67J8rGTui3KPZehU0pg
         VYJNOTDChw516z0iGAv0IZD9GvEdBzfWrun86o42eN9vBYp8/AQC4b4UJnFgB6T6oIE2
         fyRiZyG/sCq/UzMxyk6nVy+80uG1JtGU92g0267S8HFMdzTA1sg0ohdu0LxH2Dt4ItMw
         VCjA==
X-Forwarded-Encrypted: i=1; AJvYcCXClC6T4kvksvcw78V3cEiU6WWrtXNlVICohq9ozO1PHxyX9vJCHKE77o9NOI/MeqEqa1e2QchD+JJuDvnu46YlmeT2WZwUu82o3JpO
X-Gm-Message-State: AOJu0YxdybGn9kmWdfLTBQtedJFW2vYFiElaDsQVu09NlgWmIvRIgFyi
	SbO9K0tHAppmGl4zvUBOUU7jq2mJFZchmvi69dSBJksq1qwfi9nlfhWfhDRqWqpWVFq8RTldQCF
	v8ByLJA==
X-Google-Smtp-Source: AGHT+IGf/B2F4EB7a0HT+qONfUI7nOsQgAhAuVA9WeKqrfWQtvYurTpZFcr7X3hmWfQfblLZrtVTI9pSmfCc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:49c6:0:b0:609:5bd8:de84 with SMTP id
 w189-20020a8149c6000000b006095bd8de84mr54268ywa.0.1709165931456; Wed, 28 Feb
 2024 16:18:51 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:57 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 12/20] perf jevents: Add FPU metrics for Intel
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

Metrics break down of floating point operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 6ee708e84863..dae44d296861 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -325,6 +325,95 @@ def IntelCtxSw() -> MetricGroup:
                                     "retired & core cycles between context switches"))
 
 
+def IntelFpu() -> Optional[MetricGroup]:
+  cyc = Event("cycles")
+  try:
+    s_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+                 "SIMD_INST_RETIRED.SCALAR_SINGLE")
+  except:
+    return None
+  d_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+               "SIMD_INST_RETIRED.SCALAR_DOUBLE")
+  s_128 = Event("FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+                "SIMD_INST_RETIRED.PACKED_SINGLE")
+
+  flop = s_64 + d_64 + 4 * s_128
+
+  d_128 = None
+  s_256 = None
+  d_256 = None
+  s_512 = None
+  d_512 = None
+  try:
+    d_128 = Event("FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE")
+    flop += 2 * d_128
+    s_256 = Event("FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE")
+    flop += 8 * s_256
+    d_256 = Event("FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE")
+    flop += 4 * d_256
+    s_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE")
+    flop += 16 * s_512
+    d_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE")
+    flop += 8 * d_512
+  except:
+    pass
+
+  f_assist = Event("ASSISTS.FP", "FP_ASSIST.ANY", "FP_ASSIST.S")
+  if f_assist in [
+      "ASSISTS.FP",
+      "FP_ASSIST.S",
+  ]:
+    f_assist += "/cmask=1/"
+
+  flop_r = d_ratio(flop, interval_sec)
+  flop_c = d_ratio(flop, cyc)
+  nmi_constraint = MetricConstraint.GROUPED_EVENTS
+  if f_assist.name == "ASSISTS.FP": # Icelake+
+    nmi_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+  def FpuMetrics(group: str, fl: Optional[Event], mult: int, desc: str) -> Optional[MetricGroup]:
+    if not fl:
+      return None
+
+    f = fl * mult
+    fl_r = d_ratio(f, interval_sec)
+    r_s = d_ratio(fl, interval_sec)
+    return MetricGroup(group, [
+        Metric(f"{group}_of_total", desc + " floating point operations per second",
+               d_ratio(f, flop), "100%"),
+        Metric(f"{group}_flops", desc + " floating point operations per second",
+               fl_r, "flops/s"),
+        Metric(f"{group}_ops", desc + " operations per second",
+               r_s, "ops/s"),
+    ])
+
+  return MetricGroup("fpu", [
+      MetricGroup("fpu_total", [
+          Metric("fpu_total_flops", "Floating point operations per second",
+                 flop_r, "flops/s"),
+          Metric("fpu_total_flopc", "Floating point operations per cycle",
+                 flop_c, "flops/cycle", constraint=nmi_constraint),
+      ]),
+      MetricGroup("fpu_64", [
+          FpuMetrics("fpu_64_single", s_64, 1, "64-bit single"),
+          FpuMetrics("fpu_64_double", d_64, 1, "64-bit double"),
+      ]),
+      MetricGroup("fpu_128", [
+          FpuMetrics("fpu_128_single", s_128, 4, "128-bit packed single"),
+          FpuMetrics("fpu_128_double", d_128, 2, "128-bit packed double"),
+      ]),
+      MetricGroup("fpu_256", [
+          FpuMetrics("fpu_256_single", s_256, 8, "128-bit packed single"),
+          FpuMetrics("fpu_256_double", d_256, 4, "128-bit packed double"),
+      ]),
+      MetricGroup("fpu_512", [
+          FpuMetrics("fpu_512_single", s_512, 16, "128-bit packed single"),
+          FpuMetrics("fpu_512_double", d_512, 8, "128-bit packed double"),
+      ]),
+      Metric("fpu_assists", "FP assists as a percentage of cycles",
+             d_ratio(f_assist, cyc), "100%"),
+  ])
+
+
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -687,6 +776,7 @@ all_metrics = MetricGroup("", [
     Tsx(),
     IntelBr(),
     IntelCtxSw(),
+    IntelFpu(),
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog


