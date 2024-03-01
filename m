Return-Path: <linux-kernel+bounces-88969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F221B86E8E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F407284E15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222B3D986;
	Fri,  1 Mar 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRS310NL"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367263A268
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319399; cv=none; b=qjy57a4few9jyK90kumMwXOwJXnGstBn96B3f+wvfVNqFDtaCTofdbkuQ2yj2xCZxBfMRclgkrDJ6xDkrO3xnBfMmG8piMJGP/A/dI7MxJwPpsarFAiXosFMEOdqrq/F9ebOgbZDzMw3skuFW81qwztACuoUn5P9u7c7lGxv48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319399; c=relaxed/simple;
	bh=k1J00uEpMiU2X474jyjwVg/k5P8F66t0UkVBIUUJqo4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LepFR8ngimCbhJwJdMR9BUkoU8jQChLQWPK/UD8UtkO6J6rnI7y3LIF18zhBZg5GrKm7h8q1GVzgnLo4f6J+P+rsxTC1HyuradobufJOdB19d29SLgko995hTL1ur70lpMlY98WpdpQB0kKDVoF74IEi4DGU3ofZJied/pPPgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRS310NL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6087ffdac8cso38105907b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319397; x=1709924197; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bLt2tsDqrZIDuuzvN847pO8hmc3HFfJgCu/uhjrOeM=;
        b=zRS310NLrNJ2W1snef+pGWF6jWs/UcoW5ws11DEexHK0E6hDNPJP5havwXBGzzkruH
         iwWFuCj6KpNKavm/GI/EAi8ZDi7+igmL4BxhNrIkqvbk2QlQ63GuDa33ZoEgKIYuHGub
         RFlRreK0nkSOx9l3qr76HN6xrs8MpF3CRC0hAnuIJl6P9GMJQC1LVQi1JoPPMorgbDuC
         BlE+G+sjhWphvo+QIMKUCCHHjKsg2Y1rqez98v7YPQOq9UrFgPwvI7jH0rn8tVhyGP+z
         gORclFSzXDXnThl0GosqMbBmFCM0BDjQlnKH8qTP2/Zrg5wu7e+PFluVRDXImJdqx79y
         2DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319397; x=1709924197;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bLt2tsDqrZIDuuzvN847pO8hmc3HFfJgCu/uhjrOeM=;
        b=TTWxixJc9WddW/3i5t+qeyfCtBZNNYFQPre0R9SDodHCAABPV6asPz4euuXGESS551
         qTzZ/ngy1oGjYLhlah11VRjeIEa7WQuL1S8aE21534Oo8thhsD0Pt79Y+SMY7ltLcRPD
         ZGlQiDol5UER0a2vIP6u/2QMX6U7qsPQqPg06flaTpp52jMLn1SE+7mZLUjG5oBAaZYE
         TTbIB4g5kJWYPvKotiA7o00Nm33xv/cUCYBKOuWGbdzWUibXRZmtu39GZu0mj69y914T
         2jsL7NFPTjqqru1BnYTtqufsmLrKPt4k6bTC7eg+wK8qL004EC7hG+Nau/ERAoidjzny
         p0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWPqYcWbxf58okgf+iTeDqBgXqCeWGF46LPOgl9kIRiti45QsllsGScJoCAZDw/Vgk/mcZ4C9YzsDdmOMkjqCmOG6mvuBtAtkr8fBfM
X-Gm-Message-State: AOJu0YxKvIEWkqPM2ntPs9T1296hPd4uIggJUWLNF4tis88NN9JV6D4j
	JzHa9qKrWbjSOv7u9IgiWdRLlE8HG8Uy6gk6+S+Aly8Cph2lDRYyBlGwaCd8TdNoJo/UHNaPYOV
	KQucDOg==
X-Google-Smtp-Source: AGHT+IHwyRBJirzqk8uMFTrQMDM0GgTTLbJhm8emnlvGpOsyNImTLygP+QzB4U2tZuzbYUFKAO/WbN+MMQ8c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:c9d:b0:607:cd11:5464 with SMTP id
 cm29-20020a05690c0c9d00b00607cd115464mr604520ywb.9.1709319397235; Fri, 01 Mar
 2024 10:56:37 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:49 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 10/20] perf jevents: Add load store breakdown metrics ldst
 for Intel
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

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 86 +++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 9f42b489a81e..061914834cff 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
-                    Metric, MetricGroup, MetricRef, Select)
+                    Metric, MetricConstraint, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -515,6 +515,89 @@ def IntelSwpf() -> Optional[MetricGroup]:
   ], description="Sofware prefetch instruction breakdown")
 
 
+def IntelLdSt() -> Optional[MetricGroup]:
+  if args.model in [
+      "bonnell",
+      "nehalemep",
+      "nehalemex",
+      "westmereep-dp",
+      "westmereep-sp",
+      "westmereex",
+  ]:
+    return None
+  LDST_LD = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+  LDST_ST = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+  LDST_LDC1 = Event(f"{LDST_LD.name}/cmask=1/")
+  LDST_STC1 = Event(f"{LDST_ST.name}/cmask=1/")
+  LDST_LDC2 = Event(f"{LDST_LD.name}/cmask=2/")
+  LDST_STC2 = Event(f"{LDST_ST.name}/cmask=2/")
+  LDST_LDC3 = Event(f"{LDST_LD.name}/cmask=3/")
+  LDST_STC3 = Event(f"{LDST_ST.name}/cmask=3/")
+  ins = Event("instructions")
+  LDST_CYC = Event("CPU_CLK_UNHALTED.THREAD",
+                   "CPU_CLK_UNHALTED.CORE_P",
+                   "CPU_CLK_UNHALTED.THREAD_P")
+  LDST_PRE = None
+  try:
+    LDST_PRE = Event("LOAD_HIT_PREFETCH.SWPF", "LOAD_HIT_PRE.SW_PF")
+  except:
+    pass
+  LDST_AT = None
+  try:
+    LDST_AT = Event("MEM_INST_RETIRED.LOCK_LOADS")
+  except:
+    pass
+  cyc  = LDST_CYC
+
+  ld_rate = d_ratio(LDST_LD, interval_sec)
+  st_rate = d_ratio(LDST_ST, interval_sec)
+  pf_rate = d_ratio(LDST_PRE, interval_sec) if LDST_PRE else None
+  at_rate = d_ratio(LDST_AT, interval_sec) if LDST_AT else None
+
+  ldst_ret_constraint = MetricConstraint.GROUPED_EVENTS
+  if LDST_LD.name == "MEM_UOPS_RETIRED.ALL_LOADS":
+    ldst_ret_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+
+  return MetricGroup("ldst", [
+      MetricGroup("ldst_total", [
+          Metric("ldst_total_loads", "Load/store instructions total loads",
+                 ld_rate, "loads"),
+          Metric("ldst_total_stores", "Load/store instructions total stores",
+                 st_rate, "stores"),
+      ]),
+      MetricGroup("ldst_prcnt", [
+          Metric("ldst_prcnt_loads", "Percent of all instructions that are loads",
+                 d_ratio(LDST_LD, ins), "100%"),
+          Metric("ldst_prcnt_stores", "Percent of all instructions that are stores",
+                 d_ratio(LDST_ST, ins), "100%"),
+      ]),
+      MetricGroup("ldst_ret_lds", [
+          Metric("ldst_ret_lds_1", "Retired loads in 1 cycle",
+                 d_ratio(max(LDST_LDC1 - LDST_LDC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_lds_2", "Retired loads in 2 cycles",
+                 d_ratio(max(LDST_LDC2 - LDST_LDC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_lds_3", "Retired loads in 3 or more cycles",
+                 d_ratio(LDST_LDC3, cyc), "100%"),
+      ]),
+      MetricGroup("ldst_ret_sts", [
+          Metric("ldst_ret_sts_1", "Retired stores in 1 cycle",
+                 d_ratio(max(LDST_STC1 - LDST_STC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_sts_2", "Retired stores in 2 cycles",
+                 d_ratio(max(LDST_STC2 - LDST_STC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_sts_3", "Retired stores in 3 more cycles",
+                 d_ratio(LDST_STC3, cyc), "100%"),
+      ]),
+      Metric("ldst_ld_hit_swpf", "Load hit software prefetches per second",
+             pf_rate, "swpf/s") if pf_rate else None,
+      Metric("ldst_atomic_lds", "Atomic loads per second",
+             at_rate, "loads/s") if at_rate else None,
+  ], description = "Breakdown of load/store instructions")
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
@@ -522,6 +605,7 @@ all_metrics = MetricGroup("", [
     Tsx(),
     IntelBr(),
     IntelL2(),
+    IntelLdSt(),
     IntelPorts(),
     IntelSwpf(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog


