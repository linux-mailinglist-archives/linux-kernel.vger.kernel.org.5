Return-Path: <linux-kernel+bounces-64656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273F854129
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2432C1C22B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08A1B801;
	Wed, 14 Feb 2024 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjtlnxPW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716618E29
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873582; cv=none; b=M/Ph3GOms4J4wytstghnsQKdD9tA6OjfdtV5eKFh8nfvrgQZCwIBQpjttOSGl3hub0QBfslkPqWgUFDKPcuS/G8z8NcYsYVCNe6+Bwjcowv0z/tglizGGwNr3hk5KZWJRKx5eAUBeR8fSfQDtluswXMcogOg21F8nI1tOPFpaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873582; c=relaxed/simple;
	bh=hIxYX8TTyh0Dccr8/lAdDDGacxXs3uC2maK3OUwPAlI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=FQ4jgyfwnb1xpBwrkp7V6Y11EI1z/hNXaxtr+VZL8eUvQnTGUdeOMbzsORzkxP76fmQ6SEr26JhxNJgI2+I1ovB5TNkITsUuSa4QGtbOQ5+U7Gzgll0opYc2e4/YFYJcP/c7qZPL5Wl0i7tNrtTx412hRzfsCpnXa+VTNzdezsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjtlnxPW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60779e8f67fso23760357b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873577; x=1708478377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAYHo5Qb7wJrff1g1r5uREcpev2cMvAX0H2PzQKbSkQ=;
        b=XjtlnxPWHMUTh/PXYwm/T7DzhR1Y/kQeeNxTlwyINwnfIPoBcg5jp9BLm2C7JosBfq
         JvSUhsFB7ycC7f7EIuTyP//9+cmkp0E9U2TQsq5vhACFwjVZrRrzy6l0iMN+qxbc+la5
         R4g+VDYXHs3zWgmzGPTEiKnxHoo8Suf887JSuTR8IBwG0K5F8gijw/4cqdRthGmYtxJq
         zrQPEAr/qthcvql7IEI84HPIP+uXQERzLDQrTn2rv4b0YJWeBNR8NlwcNw8SGCRC2UuN
         gMJZTpEGAgS5+X4pg8+N+EGjWFXHP5wT/GBQycNah8F+4ZZEgarFkhmznJQ5R/6EEAHW
         2e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873577; x=1708478377;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zAYHo5Qb7wJrff1g1r5uREcpev2cMvAX0H2PzQKbSkQ=;
        b=IuruFzgAJRF6fLTUEOI7BEOK/3Hy80cigvybLIH4ttKJTyLacJYM3VXFr91U7Tw0zb
         5KlypKXBemSvnSfv+Ao9rZuuxhp5igYlFhMydRNv+ZDrALR1PuDDAvpI0h4zSGJIskpb
         eemSRsSSiYohZwBXtus+av3yN2ziGp6GMYLmUzJ4Y/Zob7LUUH5IsmahRzBoe1t0Nw/u
         5pb+5s93MJtBIRq2lPWWiHRpq0zrJAYoRlviALQ3wvvIu6T3UHCJB8tHzZ/2IK+Gh6Lg
         hjFMMAUvVpnUPOVzbZkL/aXSiTkg99OuhWdi00nXCrgM5oc1TJ8X01ea1cARTVqDqZ6w
         lWLA==
X-Forwarded-Encrypted: i=1; AJvYcCVEfM5h3AhC1oZCp+2YQPwI+rXd98aCaRaevFW17a4VtNBEmxUze7wq46mOehY8NUD0zI7vQu4O16mljXc1uxqamif9GYuPCYPFdO/5
X-Gm-Message-State: AOJu0YxvvjQNMQRYnatGjbj1dq+fsGKzyrewZo/mZWvgzuiasCuGIIeV
	/WY9cYLemtpiO8sTYOP239CCljbTLBJuLS32x0Zt8HGGAkv01pIAxxJkPUoln2I9ijwbrLhI9fY
	NzoLprg==
X-Google-Smtp-Source: AGHT+IELqdzCRQDyDz+1icKo/N2ZUmzmEV3VrcpkjAlYJoXCTgUYfDYlcuYV81jIedoMcQUvt/Ai+C0R398o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a0d:df83:0:b0:5e6:1070:44e0 with SMTP id
 i125-20020a0ddf83000000b005e6107044e0mr193581ywe.5.1707873576948; Tue, 13 Feb
 2024 17:19:36 -0800 (PST)
Date: Tue, 13 Feb 2024 17:18:15 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 26/30] perf vendor events intel: Update sandybridge TMA
 metrics to 4.7
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Top-Down Microarchitecture Analysis (TMA) metrics simplify
cycle-accounting using microarchitecture-abstracted metrics
organized in one hierarchy. This update is from version 4.5 to
4.7.

The update includes:

 - Add metrics tma_fp_vector_128b, tma_fp_vector_256b and
   tma_info_system_cpus_utilized.
 - Remove metrics tma_info_system_mem_parallel_requests,
   tma_info_system_core_frequency and
   tma_info_system_mem_request_latency.
 - Swapped tma_info_core_ilp (becomes per SMT thread) and
   tma_info_pipeline_execute (per physical core).
 - Tuned thresholds for tma_fetch_bandwidth.

The update came from:

https://github.com/intel/perfmon/pull/140
https://github.com/intel/perfmon/pull/138

Running the script:

https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/sandybridge/metricgroups.json    |  7 +-
 .../arch/x86/sandybridge/snb-metrics.json     | 71 +++++++++++--------
 2 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json b=
/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
index bebb85945d62..a2c27794c0d8 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
@@ -2,10 +2,10 @@
     "Backend": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Bad": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "BadSpec": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
-    "BigFoot": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "BigFootprint": "Grouping from Top-down Microarchitecture Analysis Met=
rics spreadsheet",
     "BrMispredicts": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Branches": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
-    "CacheMisses": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
+    "CacheHits": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
     "Compute": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Cor": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "DSB": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -23,7 +23,9 @@
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
+    "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "MemOffcore": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
     "MemoryBW": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MemoryBound": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
     "MemoryLat": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
@@ -88,6 +90,7 @@
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
+    "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
     "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
     "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
     "tma_microcode_sequencer_group": "Metrics contributing to tma_microcod=
e_sequencer category",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/=
tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index 8898b6fd0dea..ce836ebda542 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -163,7 +163,7 @@
         "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
         "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_thread_ipc / 4 > 0.35",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Rel=
ated metrics: tma_dsb_switches, tma_info_frontend_dsb_coverage, tma_lcp",
         "ScaleUnit": "100%"
@@ -193,7 +193,7 @@
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
         "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_512b, tm=
a_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -202,7 +202,25 @@
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
         "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE + FP_COMP_OPS_EX=
E.SSE_PACKED_DOUBLE) / UOPS_DISPATCHED.THREAD",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_128b",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
+        "MetricExpr": "(SIMD_FP_256.PACKED_DOUBLE + SIMD_FP_256.PACKED_SIN=
GLE) / UOPS_DISPATCHED.THREAD",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_256b",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -222,7 +240,7 @@
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .)",
         "ScaleUnit": "100%"
     },
     {
@@ -244,7 +262,7 @@
         "MetricName": "tma_info_core_flopc"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
         "MetricExpr": "UOPS_DISPATCHED.THREAD / (cpu@UOPS_DISPATCHED.CORE\=
\,cmask\\=3D1@ / 2 if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=3D1@)=
",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
@@ -271,21 +289,27 @@
         "MetricName": "tma_info_pipeline_retire"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
         "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
         "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_system_average_frequency"
+        "MetricName": "tma_info_system_core_frequency"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "BriefDescription": "Average CPU Utilization (percentage)",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
         "MetricGroup": "HPC;Summary",
         "MetricName": "tma_info_system_cpu_utilization"
     },
+    {
+        "BriefDescription": "Average number of utilized CPUs",
+        "MetricExpr": "#num_cpus_online * tma_info_system_cpu_utilization"=
,
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_cpus_utilized"
+    },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
         "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_mem_bandwidth"
     },
@@ -294,7 +318,7 @@
         "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
     },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
@@ -316,19 +340,6 @@
         "MetricName": "tma_info_system_kernel_utilization",
         "MetricThreshold": "tma_info_system_kernel_utilization > 0.05"
     },
-    {
-        "BriefDescription": "Average number of parallel requests to extern=
al memory",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_OCCUPANCY.C=
YCLES_WITH_ANY_REQUEST",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "tma_info_system_mem_parallel_requests",
-        "PublicDescription": "Average number of parallel requests to exter=
nal memory. Accounts for all requests"
-    },
-    {
-        "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_REQUESTS.AL=
L",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "tma_info_system_mem_request_latency"
-    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
@@ -388,7 +399,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "(12 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / tma_info_thread_clks",
-        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
+        "MetricGroup": "BigFootprint;FetchLat;MemoryTLB;TopdownL3;tma_L3_g=
roup;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: ITLB_M=
ISSES.WALK_COMPLETED",
@@ -398,7 +409,7 @@
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
         "MetricConstraint": "NO_GROUP_EVENTS_SMT",
         "MetricExpr": "MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + 7 * MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS) * CYCLE_ACTIVITY.STA=
LLS_L2_PENDING / tma_info_thread_clks",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
+        "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
@@ -420,7 +431,7 @@
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized software =
running on Intel Core/Xeon products. While this often indicates efficient X=
86 instructions were executed; high value does not necessarily mean better =
performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized code runn=
ing on Intel Core/Xeon products. While this often indicates efficient X86 i=
nstructions were executed; high value does not necessarily mean better perf=
ormance cannot be achieved. ([ICL+] Note this may undercount due to approxi=
mation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIS=
T",
         "ScaleUnit": "100%"
     },
     {
@@ -435,21 +446,21 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_info_system_dram_bw_use",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_info_system_dram_bw_use",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: ",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: ",
         "ScaleUnit": "100%"
     },
     {
--=20
2.43.0.687.g38aa6559b0-goog


