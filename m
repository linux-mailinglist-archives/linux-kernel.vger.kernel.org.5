Return-Path: <linux-kernel+bounces-102850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D4C87B7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B69281518
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E1168B9;
	Thu, 14 Mar 2024 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVJOyGMf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DFD3FBA0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396000; cv=none; b=OvIJIHZAfINf/SDy+R/0Da0sl+PirX87mxSLCF0iOImrt3E3AGd2xPN0Fb/09z9ObYbKaZTe5PHSqy9kc8MKFt1mS9l2cGhLSE8BN+34dD+miV8LQxWz1pVLuX2cyQEYM0SJ4AbFT7V/QmLQ45IuHbuVLRMBUQuMMuZiiVgyzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396000; c=relaxed/simple;
	bh=xtWp/os77FuNv6nPjjXYL4rEIzSmfCuzd+IK8xkj2yE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JWsnJ2WP9OocumdRQcq7X2WIsrLWp/HodCTAB/LhHmA49tQQYU9MvcUdjRgd2LG6pnVKQh7YwW/3zr0IoQrUAdO2wX6TRiEiSREE6t4DzyJx7JjGm2pPqXAOoTNPG2F+C7x+deQTkAgY19p/D0ejuX0Pn682uSSqWwfk9h79npQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVJOyGMf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so97702276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395998; x=1711000798; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2fqg3EeqdVKSD6hHFpARrgrIQYOAIUvUSGX0zthwymQ=;
        b=tVJOyGMf8bD8yTeti1L+a0XeRJjll11lkbRs9h4xTfg76mNkdLCktnfRNP23i/6zeu
         IT7qDYDm0RP6FEgutf6m6/XtvtkGp2DjnW3p5NGAI0BtQHY7du2+NHpngZLKhQw56oJB
         +n+04bUS1SJTr/hLqCnyRRG6enGYTEFTG1Uh81OaxNvld4rP6KaBjdt9LqLuALoJQTTN
         tBKmHJgLAZ1Ea4zYh+39ALNGvdjz4tIz6LC2MRH7StDIgwt/Xe78l/bV1zbJezWy2lz1
         8YZessk789ac5io7gn3j3YDQJjEWprlUFE2ZrYFLfPI+Rd26qtn312hsS9FvZpau+UBu
         uIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395998; x=1711000798;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fqg3EeqdVKSD6hHFpARrgrIQYOAIUvUSGX0zthwymQ=;
        b=TdgkcZIi7vmMV056MKV0Qk6WFS11Hi8JsMvd9sUFgV1ZersYgJ8yf2WB2XbJ0wNBZe
         oQu/EN1CKQuUERGKT3TI12E464RQuN1BUFK6ql11FI1J6b0MVwxVqSnmyGU8uPxpbdkn
         F7QxRm7XNJELcl34HicQ9F76x1rGPRJOf3G9jXYDuQD8liqS3GT9OC0tsADMJdVvTaiU
         RQyB4C3B/LVvnDzX+Qe1aVd1nnR/spFugc6Q/kfzkts+kZb2SWZBilMCOl3zEoYVeswM
         PvSSUJhp3/cFAYgv0sBsDdvm4Gs71nl13tF6xo01Qy+wH5uwWIfn3yA4OhSSMGgfZUgC
         fygQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0mjuyJtNC5USRVzrmxwUEK/LCyQ+h56HCQAikzF7Xs3QTMWPcGtkM07Xi5MeyF0RzOgNmLEO4ykB4TM1MnkQ9T03WdCOqKIkZ/bGl
X-Gm-Message-State: AOJu0YwLEEuHol6POfnoxkZ8jz91JkNOkPpDpgVKL/VzBnoohNMFSuF2
	Pg0dJrw0G2u8yPOaHVU+bRWrhWDZyD6iFqfjvv+rpwe+N73jFb2PnmiawAZZjnU/tabenNA50OC
	yzMKqBA==
X-Google-Smtp-Source: AGHT+IHUMcZuKn2Q0djcMQG4CWwtVgxjzUZW8HhN3F/IZn5XjFbhraj9iGU9PFaTm8wkVBScuQOWVBUsRENB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc6:44d4:bee0 with SMTP
 id w4-20020a056902100400b00dc644d4bee0mr27738ybt.7.1710395997689; Wed, 13 Mar
 2024 22:59:57 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:09 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 10/20] perf jevents: Add load store breakdown metrics ldst
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
index 9ef30e5d3e25..4ac419212b3d 100755
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
@@ -508,6 +508,89 @@ def IntelSwpf() -> Optional[MetricGroup]:
   ], description="Sofware prefetch instruction breakdown")
 
 
+def IntelLdSt() -> Optional[MetricGroup]:
+  if _args.model in [
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
 def main() -> None:
   global _args
 
@@ -537,6 +620,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelL2(),
+      IntelLdSt(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.44.0.278.ge034bb2e1d-goog


