Return-Path: <linux-kernel+bounces-102854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9BB87B7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F57283362
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637150A7E;
	Thu, 14 Mar 2024 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3tQSVuk7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E84D13B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396006; cv=none; b=lVgZrDSLAm2uy4CF9KZ5KDrwSwwmMxF7G/a+2aLvCR4FxI0Matzcuecdvc5M47EduWR5/sGL3NRz/asn8FKQqW3giz5GIh697fNADg5ROU2qRhfcX30ob8mYqzj9uv60/0uoILflvN7KNLpvF3kcJGz2GKXdImomQ+hmIEwLKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396006; c=relaxed/simple;
	bh=Zv59BcF9/FFOXnYymXzoUfqt6uVYuFUlqvpmq/ZLPyU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=m1875cCYyfguhslDBXhHXp47dXE6qYKGVG9hDVAagsZeKAy7l+f3hrMRU6zfinM+AoJif0hY7GeuGT48nIWwk3g+AHuw11GxWfUFEDnbGe80gjxOiWv39c+xtjGMgbNr7DnT+Wt2JRseRGsxw1jT7Vq7bBzhoBK06MnekhY8dbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3tQSVuk7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso2275231276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396004; x=1711000804; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wrp1xMdxyIWOSP8hDN276AUUBW2F4zIQGzyrmjQ0NGE=;
        b=3tQSVuk7v+A3ck5hoif+sLHNtUGbpifbSx+td9WjpWPrQ9N6CHfPUZTNz+k1WdWb7O
         2v6wQsgUTVwnK4k8Cl+dv9YK5I3MdTgOf07VgvE5wixO2PmLkI1G0QSRf5QEwLHK/MMP
         2RQ2s/dGQA4eCx0no20fLeh32yxhkO/PFqjxZ25ga3pottN8ereTlhnPqcbLkFkPyLTF
         dnS/EihoU7DEls4/CjLU1DlqMnCp1V9IhBWC+54i8twpzPvuG9fGBgaXNh95C73ffql8
         7her1DLxyQ1c7HBjeFaeFmdsO59houmkC93ClXQ7b8/RDe3gFFsI7rsDI0t4eoEMpPf2
         ioFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396004; x=1711000804;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrp1xMdxyIWOSP8hDN276AUUBW2F4zIQGzyrmjQ0NGE=;
        b=FP+LaLVqO2oqs0nN77iAmG89Jgs4+4RQM8vTBscztXZ/Kn24weOmctWHSrr6jfQyoB
         /CRON7XJ0JzmbK0ZMHNpqSVzB+3JTvTmvtIOTJOiP8S97iNDOuXAvZwcsUYxjM3djRwF
         9NZTJJN9Vzgs+QWTtZI8/KEdiZLFzYwh4Ebj/7tm9+hEiyXH12ALFSyELqJJ5Yvv+TXs
         2vjeZ5ry2Zt7RHqGDtMcvUvsE+WXBqGadZBWbBBmG/7bBNygK/rK98rnQdIgbKxqTaJF
         ZOyFSB6WHojH0aWBPcUlmQDE8Q73O6VujJ91iRhdvUmLXmF0KR/hTGz+eoP1AXJvF6Sq
         1OzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdDn2VzV4chY74PP+lHW/dhZJgAUnt13aW6DyWoGbXXauMl7l0wt1N81sxLdOlXRcy1sOLURLhjSQK30LaDqlgGM/bUQOt0Mfpky3t
X-Gm-Message-State: AOJu0YzvzYkU1bgdf4KuhL44Q4iVsSbFjwh1stW8y/HzaDL2YRL/j4K7
	Ql62D8Ojlg675TWsdDOdHw5/Z8fD/HkFYLM7McybQ8x6K6gEEpXNPanTVjv66MlfR4EhG6m4lRG
	cWyIfeg==
X-Google-Smtp-Source: AGHT+IFDJM+0l2op5SV6RAZkgs1N/ukCDz73rxkHFqK7G5dqyPkyfs4SefZFM+JjpIuo/No5WhR+xvC/m/oo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2311:b0:dbd:b4e8:1565 with SMTP
 id do17-20020a056902231100b00dbdb4e81565mr255527ybb.4.1710396004209; Wed, 13
 Mar 2024 23:00:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:12 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 13/20] perf jevents: Add FPU metrics for Intel
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

Metrics break down of floating point operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 387981d58320..da97a1781be7 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -320,6 +320,95 @@ def IntelCtxSw() -> MetricGroup:
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
@@ -703,6 +792,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelCtxSw(),
+      IntelFpu(),
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog


