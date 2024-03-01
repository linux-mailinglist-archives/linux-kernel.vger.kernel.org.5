Return-Path: <linux-kernel+bounces-88951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DDF86E8BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D85D1F25422
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D093BB31;
	Fri,  1 Mar 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H883z8KS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEA39FF2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318994; cv=none; b=FpnovMOKxIpuZg6e9XMHu1Ta4Q427M1mti8VzVzJVJZuu4xUnSrxgriuk3kuWEzKM7rhujxO7Zq68M68pfdH0Tf3aLczbAp5aJi/TiKxGKokX5AUrDMkd/mi3LKj69MEDuFyiEUVzqGlEr8zqs+0AE3IHlBP1GS8HTlir65VZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318994; c=relaxed/simple;
	bh=2ERunsHO0HMaUms4KBACjWVsThU416l3Oxd77ww5Cx0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=vA45kMBLS1OfZuWT4egX3ekyzPGMI4ovEhbtr0fIfD4AkSNr3EwB3vp/cFdckFLmalkKRtroqmz113omVUaixB5dvhlwnc16sAY/WSAnGR2WjJxnnqy4bjKiwNBQk8J9rE0NEpMMGjClmf0JnbTywLwyj9PTMNSl/pGplSlVpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H883z8KS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4104028276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318991; x=1709923791; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EjZ0ceRnqQlXX4BCEd3HoI0KPye9/6m0/wti2JUYDk=;
        b=H883z8KSjBtADZXfpgQDGDjqDrm9FWmkhCdwRh69XyFob3Fn24la13XUOOkvfyXt+a
         NzvWA5X3e2mX1uRaoutDDKuLHm/gkWdJwefITQyHuLEllhxJZ7qN5v+3dYH3ZtrXCm+o
         sgkQSQNtUSakJQ9+tC7ETDD4QbtOe3fkT42mD1jD8aUuFDBmT9XMN7taRDJUuOmGaXjX
         jHuT1AzVMsJ44K79jkPM/nbM0Z3HvyvIN1jid6Cbzvu92yzKv6X94FpyNnwT705zhRvh
         X6PAQigUmNehM/ypCwR8ZyqzOcUyHzwqttAXQUz9F5QgoXRRhyKUU3pMxr02k9RIipvq
         HnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318991; x=1709923791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EjZ0ceRnqQlXX4BCEd3HoI0KPye9/6m0/wti2JUYDk=;
        b=u8kMli0VluNghKCl7Pkfa5LfoBIbaNbeZzQiIbZ0NctqXKbsVNgxhwm848kcZaLNTu
         Gtj9dBm8F1Vgwt/aFxINfT8RUl4R77JSIg0OefWm7EVDgvWsYx6G6PtSI9ceT1cuLHmo
         I2b2DJOsE3uSr+67HLgOmpIHfuLhSRItEC0mG9tgUKK3IT2VBbupXYE1zpTuLJ29AIjY
         K2SY6uw+L02F5ifP3kQ03cd68BqoqqA4B31b9Swjns0ppBa2/cwUhPHpwSbQ0hEieyD3
         7SCG/3BrYhXc6SwCtAm4eXbPvduEa9L+ltR7ucnHFEk0S8Fzdh6IbKxkEMaKKX2eASG4
         N2+w==
X-Forwarded-Encrypted: i=1; AJvYcCV/S6RwK3Oa4VB4BKgf438f6FTl/tOB4Jm86dGn/LMhMiRhTCIBlUdWGx8PmNZJ1U6HN3Nhs3CVhRSQ2UuqYfE14el0AKAjiG3pTYuu
X-Gm-Message-State: AOJu0YzSzm5LtmiClzbYepqhCOJmPeHHu3L06wfqr0O63IICBt9xgSQT
	GLGv+ChkkVI1jpjeRrS6zjaEGraXKeUyVl5SKD1Ib3+Wf6wBsCL491kzD6qVYmM0baeO+afKHCW
	bLdQHGA==
X-Google-Smtp-Source: AGHT+IG8JEXFF9978LatunnwkVIhj6OAPjqRyRG+w+is3ik30NBpeC3dfmCO6JKqk09Redgj4J1Sef6X7IH6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:df54:0:b0:dc6:53c3:bcbd with SMTP id
 w81-20020a25df54000000b00dc653c3bcbdmr538678ybg.7.1709318991586; Fri, 01 Mar
 2024 10:49:51 -0800 (PST)
Date: Fri,  1 Mar 2024 10:49:41 -0800
In-Reply-To: <20240301184942.2660478-1-irogers@google.com>
Message-Id: <20240301184942.2660478-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184942.2660478-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 1/2] perf jevents: Add collection of topdown like metrics
 for arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics are created using legacy, common and recommended events. As
events may be missing a TryEvent function will give None if an event
is missing. To workaround missing JSON events for cortex-a53, sysfs
encodings are used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arm64_metrics.py | 145 ++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index 7cd0ebc0bd80..0dcf5236ea1f 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,10 +1,11 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup)
 import argparse
 import json
 import os
+from typing import Optional
 
 parser = argparse.ArgumentParser(description="ARM perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
@@ -15,7 +16,145 @@ args = parser.parse_args()
 directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/arm64/{args.vendor}/{args.model}/"
 LoadEvents(directory)
 
-all_metrics = MetricGroup("",[])
+def Arm64Topdown() -> MetricGroup:
+  """Returns a MetricGroup representing ARM64 topdown like metrics."""
+  def TryEvent(name: str) -> Optional[Event]:
+    # Skip an event if not in the json files.
+    try:
+      return Event(name)
+    except:
+      return None
+  # ARM models like a53 lack JSON for INST_RETIRED but have the
+  # architetural standard event in sysfs. Use the PMU name to identify
+  # the sysfs event.
+  pmu_name = f'armv8_{args.model.replace("-", "_")}'
+  ins = Event("instructions")
+  ins_ret = Event("INST_RETIRED", f"{pmu_name}/inst_retired/")
+  cycles = Event("cycles")
+  stall_fe = TryEvent("STALL_FRONTEND")
+  stall_be = TryEvent("STALL_BACKEND")
+  br_ret = TryEvent("BR_RETIRED")
+  br_mp_ret = TryEvent("BR_MIS_PRED_RETIRED")
+  dtlb_walk = TryEvent("DTLB_WALK")
+  itlb_walk = TryEvent("ITLB_WALK")
+  l1d_tlb = TryEvent("L1D_TLB")
+  l1i_tlb = TryEvent("L1I_TLB")
+  l1d_refill = Event("L1D_CACHE_REFILL", f"{pmu_name}/l1d_cache_refill/")
+  l2d_refill = Event("L2D_CACHE_REFILL", f"{pmu_name}/l2d_cache_refill/")
+  l1i_refill = Event("L1I_CACHE_REFILL", f"{pmu_name}/l1i_cache_refill/")
+  l1d_access = Event("L1D_CACHE", f"{pmu_name}/l1d_cache/")
+  l2d_access = Event("L2D_CACHE", f"{pmu_name}/l2d_cache/")
+  llc_access = TryEvent("LL_CACHE_RD")
+  l1i_access = Event("L1I_CACHE", f"{pmu_name}/l1i_cache/")
+  llc_miss_rd = TryEvent("LL_CACHE_MISS_RD")
+  ase_spec = TryEvent("ASE_SPEC")
+  ld_spec = TryEvent("LD_SPEC")
+  st_spec = TryEvent("ST_SPEC")
+  vfp_spec = TryEvent("VFP_SPEC")
+  dp_spec = TryEvent("DP_SPEC")
+  br_immed_spec = TryEvent("BR_IMMED_SPEC")
+  br_indirect_spec = TryEvent("BR_INDIRECT_SPEC")
+  br_ret_spec = TryEvent("BR_RETURN_SPEC")
+  crypto_spec = TryEvent("CRYPTO_SPEC")
+  inst_spec = TryEvent("INST_SPEC")
+
+  return MetricGroup("topdown", [
+      MetricGroup("topdown_tl", [
+          Metric("topdown_tl_ipc", "Instructions per cycle", d_ratio(
+              ins, cycles), "insn/cycle"),
+          Metric("topdown_tl_stall_fe_rate", "Frontend stalls to all cycles",
+                 d_ratio(stall_fe, cycles), "100%") if stall_fe else None,
+          Metric("topdown_tl_stall_be_rate", "Backend stalls to all cycles",
+                 d_ratio(stall_be, cycles), "100%") if stall_be else None,
+      ]),
+      MetricGroup("topdown_fe_bound", [
+          MetricGroup("topdown_fe_br", [
+              Metric("topdown_fe_br_mp_per_insn",
+                     "Branch mispredicts per instruction retired",
+                     d_ratio(br_mp_ret, ins_ret), "br/insn") if br_mp_ret else None,
+              Metric("topdown_fe_br_ins_rate",
+                     "Branches per instruction retired", d_ratio(
+                         br_ret, ins_ret), "100%") if br_ret else None,
+              Metric("topdown_fe_br_mispredict",
+                     "Branch mispredicts per branch instruction",
+                     d_ratio(br_mp_ret, br_ret), "100%") if br_mp_ret else None,
+          ]),
+          MetricGroup("topdown_fe_itlb", [
+              Metric("topdown_fe_itlb_walks", "Itlb walks per insn",
+                     d_ratio(itlb_walk, ins_ret), "walk/insn"),
+              Metric("topdown_fe_itlb_walk_rate", "Itlb walks per l1i access",
+                     d_ratio(itlb_walk, l1i_tlb), "100%"),
+          ]) if itlb_walk else None,
+          MetricGroup("topdown_fe_icache", [
+              Metric("topdown_fe_icache_l1i_per_insn",
+                     "L1I cache refills per instruction",
+                     d_ratio(l1i_refill, ins_ret), "l1i/insn"),
+              Metric("topdown_fe_icache_l1i_miss_rate",
+                     "L1I cache refills per L1I cache access",
+                     d_ratio(l1i_refill, l1i_access), "100%"),
+          ]),
+      ]),
+      MetricGroup("topdown_be_bound", [
+          MetricGroup("topdown_be_dtlb", [
+              Metric("topdown_be_dtlb_walks", "Dtlb walks per instruction",
+                     d_ratio(dtlb_walk, ins_ret), "walk/insn"),
+              Metric("topdown_be_dtlb_walk_rate", "Dtlb walks per l1d access",
+                     d_ratio(dtlb_walk, l1d_tlb), "100%"),
+          ]) if dtlb_walk else None,
+          MetricGroup("topdown_be_mix", [
+              Metric("topdown_be_mix_ld", "Percentage of load instructions",
+                     d_ratio(ld_spec, inst_spec), "100%") if ld_spec else None,
+              Metric("topdown_be_mix_st", "Percentage of store instructions",
+                     d_ratio(st_spec, inst_spec), "100%") if st_spec else None,
+              Metric("topdown_be_mix_simd", "Percentage of SIMD instructions",
+                     d_ratio(ase_spec, inst_spec), "100%") if ase_spec else None,
+              Metric("topdown_be_mix_fp",
+                     "Percentage of floating point instructions",
+                     d_ratio(vfp_spec, inst_spec), "100%") if vfp_spec else None,
+              Metric("topdown_be_mix_dp",
+                     "Percentage of data processing instructions",
+                     d_ratio(dp_spec, inst_spec), "100%") if dp_spec else None,
+              Metric("topdown_be_mix_crypto",
+                     "Percentage of data processing instructions",
+                     d_ratio(crypto_spec, inst_spec), "100%") if crypto_spec else None,
+              Metric(
+                  "topdown_be_mix_br", "Percentage of branch instructions",
+                  d_ratio(br_immed_spec + br_indirect_spec + br_ret_spec,
+                          inst_spec), "100%") if br_immed_spec and br_indirect_spec and br_ret_spec else None,
+          ]) if inst_spec else None,
+          MetricGroup("topdown_be_dcache", [
+              MetricGroup("topdown_be_dcache_l1", [
+                  Metric("topdown_be_dcache_l1_per_insn",
+                         "L1D cache refills per instruction",
+                         d_ratio(l1d_refill, ins_ret), "refills/insn"),
+                  Metric("topdown_be_dcache_l1_miss_rate",
+                         "L1D cache refills per L1D cache access",
+                         d_ratio(l1d_refill, l1d_access), "100%")
+              ]),
+              MetricGroup("topdown_be_dcache_l2", [
+                  Metric("topdown_be_dcache_l2_per_insn",
+                         "L2D cache refills per instruction",
+                         d_ratio(l2d_refill, ins_ret), "refills/insn"),
+                  Metric("topdown_be_dcache_l2_miss_rate",
+                         "L2D cache refills per L2D cache access",
+                         d_ratio(l2d_refill, l2d_access), "100%")
+              ]),
+              MetricGroup("topdown_be_dcache_llc", [
+                  Metric("topdown_be_dcache_llc_per_insn",
+                         "Last level cache misses per instruction",
+                         d_ratio(llc_miss_rd, ins_ret), "miss/insn"),
+                  Metric("topdown_be_dcache_llc_miss_rate",
+                         "Last level cache misses per L2D cache access",
+                         d_ratio(llc_miss_rd, llc_access), "100%")
+              ]) if llc_miss_rd and llc_access else None,
+          ]),
+      ]),
+  ])
+
+
+all_metrics = MetricGroup("",[
+    Arm64Topdown(),
+])
 
 if args.metricgroups:
   print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.44.0.278.ge034bb2e1d-goog


