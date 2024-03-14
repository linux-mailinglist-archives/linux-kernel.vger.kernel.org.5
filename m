Return-Path: <linux-kernel+bounces-102813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09F87B77D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BE21C22429
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D6FBE9;
	Thu, 14 Mar 2024 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJ5iXPXa"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF67DDA7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395895; cv=none; b=NwB5mOtkvEJBVBdXhAP19OIPZ46lccauciJefcSz726jPMuqnNV7xgdzWNKIabt3MnMHPH1PItK/NdOqtczz2hg4zhdMvNdAXt2FrOOWjI0RJOwPDkQ6Vuzf9SHdj+U28o5Lnk+ouHInJjVLFg7JSgd5w/UWnXEnxw3wFabu6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395895; c=relaxed/simple;
	bh=J8c3hNr6ruoz5XF3jYzn1BDO5TPhHNE8Eor5HEpI1xs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IGFPT052CkUGqWcVdoDbCZCVXNZMPaKrpQR2ODIr6fRV/VnLXgwEDcvZ0+xyNUjxmwQBZVATIY77fpSzxlV20K7V23MBoM36AMZWFqUb5/rKboRj9lc/uOIPJPXAdL6Mi155khZpnqPT7f4dD0YS5P1uIR3HQR45scJV+W0AqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJ5iXPXa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a4ee41269so12823667b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395893; x=1711000693; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4xMUfC0yVX3RZLMSaoScPLONrLiQi/UPeKp03ItMxo=;
        b=VJ5iXPXahB997xvI20jraOfsPwcLBE3CDSJUNRfVdYpS4aDYD7RVwxsLJUzW/oaS4G
         aRrKLGVw8Xg1RwEQ2pcaveYGzopjXCiLXKdEyg4kKDpb08hoY4LKYq+9hRZHTesJGEvs
         qi4rgmib55l1BgB+RgDPVQYNjWw4t40ALd0ULLja2u8uDPiK+hHXnowAZEII5+4/faHT
         uRzbVdLk3T2UR8Mk9DQxPLpGHJ0KxzeO7XYLAYiw+Cvd46lJ6QQy6tqNOaogrl4ZDRzj
         VhV3GDhjVy+A7qq4OYZNP5UERdjP5e50aj8ZEBpklg0Toqe1pPZjPreXkJ+5vVFWczoN
         yQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395893; x=1711000693;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4xMUfC0yVX3RZLMSaoScPLONrLiQi/UPeKp03ItMxo=;
        b=bTcoQLg5KcTWi20dh8NXTm7U76lnLDO526O3CqLbdwzCpOesdrTjoNO4eiQg0MIHVC
         IX9izPTQS/DPiR4bCAx6widzbKx8ZBRr6MCGSRpvNJUPzWKtoSyhjYu9y0wObbvXqxuA
         mZcW336sF+lZbC/Xd+BmavhiLurvbGfV7F6yD7nFaD6CftdT3Bde5M+0elhgwUDxNZen
         1+7dRTN/szplymHRpIYVrom6w8ZL1wozZh5FhITLBoaUGZEyK3xeT7kphkB7hjCujS2g
         O0pghEf0XXKAS5SENapPOKOSDJ4J9XlUiExL+2orJYeGDfaNuOzfshB2T1X9/8gdetzY
         qvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU7bZ8W3yBvg+GXhArr1LM6ny/cFCiloCK3bDadRPM0CqKzrrBiT4I05NmLm3EyWgSjaMKJZIpI3G9Vl7pH9HfavJt/0YIje7zSqEY
X-Gm-Message-State: AOJu0Yz/eTQzM4srh0eo6KUEyHqGEbpcJPClllwQ2rkoj5YksYUYHsql
	cJZyAx2FDHKyoxF9pkkKhz61593BNHlsdSS0CvBtwLve1/uniOxfXU5r6nsBjgmryDyDe+rtj9R
	tdhthOg==
X-Google-Smtp-Source: AGHT+IG1tm1Wge0ONNQT7YtnwCb7OpfFwUGvz2jurXDZp7mXDjgn2/749EdcZ7YYWev0NzsMEBnHQGL0Tjn/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2783:b0:dc7:48ce:d17f with SMTP
 id eb3-20020a056902278300b00dc748ced17fmr252399ybb.10.1710395892856; Wed, 13
 Mar 2024 22:58:12 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:00 -0700
In-Reply-To: <20240314055801.1973422-1-irogers@google.com>
Message-Id: <20240314055801.1973422-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055801.1973422-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 1/2] perf jevents: Add collection of topdown like metrics
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
index c9aa2d827a82..53615ffa8d96 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,14 +1,151 @@
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
 
 # Global command line arguments.
 _args = None
 
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
+  pmu_name = f'armv8_{_args.model.replace("-", "_")}'
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
 def main() -> None:
   global _args
 
@@ -29,7 +166,9 @@ def main() -> None:
   )
   _args = parser.parse_args()
 
-  all_metrics = MetricGroup("",[])
+  all_metrics = MetricGroup("",[
+      Arm64Topdown(),
+  ])
 
   directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
   LoadEvents(directory)
-- 
2.44.0.278.ge034bb2e1d-goog


