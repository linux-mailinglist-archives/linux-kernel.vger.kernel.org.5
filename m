Return-Path: <linux-kernel+bounces-64650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC82854120
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100F61C2116E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5E1802B;
	Wed, 14 Feb 2024 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rHhx9KXj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5A1640B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873567; cv=none; b=dF6yhNUj+qE1OeYbK2zpTm1lgHdgqTn5aK+8kehGyms+uOfZffSdWYRVLwGjTjqg0d1U9U6SYheSx2jVS68q8N2/mzJxSUAFPjYoDy0PHABKhU9hX2B+uN24nzi2iVymB8cG+ojgjjKPY9o8gt/kGWAwWztepkfL7qns6dMH77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873567; c=relaxed/simple;
	bh=gwh91uqwmAirLkcNQc+1rfZOX8DINDUUH/ZSUcNqN1A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=AN51YfH5385lx7vEjy/fMf2qs0IqdVxn4gU7GvDP3AcaprAoYRwo8VSmUoL4U6cvFJfCDPAPTwpQkQWLnxxJJREctxzvs2FpWA8zTx3KP+C/olSXzewTQTOcCvS4tYMkjhSbL77JGHzqT6E2aqJCBFkGZO+Wlg6XKBt0seIzJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHhx9KXj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so6183953276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873560; x=1708478360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e807xeCx7hdQVwv6tFygI29Xq6MqW9OOPy3FcDEkdZE=;
        b=rHhx9KXjvE03YDUKlYU/MEXCTgbComHR0NG/gniZcY/Sdlc2pKI2CwJE8g2p0b7yLG
         e2b3R63DBqZfWymgTMUi56mNoIEAUo8NcnmVR2S93sLe8O8jjGk+CtZC2jEhMJGtZMhu
         QopkVXyaclA6aQpQzxJxu5vKKfHDPnBM1CUIQB6CbxOkCIeWKtjlWDlxZvGwgm7qILvV
         aXzWRZXCkV9NTNZ0LR5sxmC4S5TWR5lqJ48I6zbgL959rq2iZ7JODtZBjYBFARO6Di5P
         SyJaPH78U4sLaBIyhaeWoYvM69ZbEPufYAVr7b38OExEftWh0OxeY2yeRBhq1Ey2DWTY
         PbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873560; x=1708478360;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e807xeCx7hdQVwv6tFygI29Xq6MqW9OOPy3FcDEkdZE=;
        b=EUCDyc8oYiLLQtzrxROOIl4GIhUSIf/IbjdxA+/i2OK1YvU2EAAyMgmYbahig4M+ns
         GpsUAngshpnVFbNvKFUvfZcs3l46xomTgek/H7A0q3cf1+yy3ezUj7Pu0hqruB0+Jpfx
         KDNMyAp2c80RA4nw/9dcmF46VCtUHuWtl4f2wXNkHWMkWhn8/0zqaQ2ksp9nN7drjQpV
         MKlaYVQ35JGnCs/xmq0BZZPvZXJVKcCwc/cuPz3UisuoXCn1uIkiCzB5djWAEsXZo+sg
         J+2QQwAfiYIl+G2STko7zCnUuAB0uokUZI3b8j8p0nXacc29MT47Nbq9DyqeAcfMTJ0b
         jEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT0GiQOkvzyo87lRb6X0QEJHLuQbvpNijM7LQ/MtDkU4wUWG0VrWPRDC/tCM8bQw7jcKYK+blon07VNdqSqSNWFanVq7LuLkb3DH4t
X-Gm-Message-State: AOJu0Yw3lY5GUvvw85TvL5dzcDC77Ql8oWMH5vWrCQjeEOfiSSDjjLCf
	fCXYAiWt4CLlQMiogW+Zo4DVr5HBgM18MMpWFfAxM98djl12PC/RYETuuDc1/BPBkvVKc3EQvEz
	SNWeIdw==
X-Google-Smtp-Source: AGHT+IEViohm/DNiksRuifRTxDcjd4+oGhd6t1RT6ZeDvin2Jr/2BUSSvmdX90VHXDCvmlZsXaVqW9o2zgiz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:100f:b0:dc7:3189:4e75 with SMTP
 id w15-20020a056902100f00b00dc731894e75mr33434ybt.3.1707873560426; Tue, 13
 Feb 2024 17:19:20 -0800 (PST)
Date: Tue, 13 Feb 2024 17:18:08 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 19/30] perf vendor events intel: Update haswellx TMA
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

 - Swapped tma_info_core_ilp (becomes per SMT thread) and
   tma_info_pipeline_execute (per physical core).
 - Tuned thresholds for tma_fetch_bandwidth and
   tma_ports_utilized_3m.

The update came from:

https://github.com/intel/perfmon/pull/140
https://github.com/intel/perfmon/pull/138

Running the script:

https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/haswellx/hsx-metrics.json        | 224 +++++++++++-------
 .../arch/x86/haswellx/metricgroups.json       |   7 +-
 2 files changed, 139 insertions(+), 92 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 5f451948c893..21e2cb5e3178 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -286,12 +286,12 @@
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
-        "MetricThreshold": "tma_alu_op_utilization > 0.6",
+        "MetricThreshold": "tma_alu_op_utilization > 0.4",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_thread=
_slots",
+        "MetricExpr": "66 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_thread_=
slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -404,7 +404,7 @@
         "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
-        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 4 > 0.35)",
+        "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
     },
@@ -459,7 +459,7 @@
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
ated metrics: tma_dsb_switches, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
@@ -491,20 +491,20 @@
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
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
         "MetricExpr": "ICACHE.IFDATA_STALL / tma_info_thread_clks",
-        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
+        "MetricGroup": "BigFootprint;FetchLat;IcMiss;TopdownL3;tma_L3_grou=
p;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
-        "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * cpu@BR_MISP_EXEC.ALL_BRANCHES\\,umask\\=3D0xE4=
@)",
+        "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * BR_MISP_EXEC.INDIRECT)",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
@@ -529,7 +529,7 @@
         "MetricName": "tma_info_core_coreipc"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
         "MetricExpr": "(UOPS_EXECUTED.CORE / 2 / (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D1@ / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@) if=
 #SMT_on else UOPS_EXECUTED.CORE / (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ /=
 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@))",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
@@ -599,96 +599,139 @@
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricExpr": "tma_info_memory_l1d_cache_fill_bw",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw"
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricExpr": "tma_info_memory_l2_cache_fill_bw",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_core_l2_cache_fill_bw"
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricExpr": "tma_info_memory_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw_2t"
+    },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "tma_info_memory_latency_data_l2_mlp",
+        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_data_l2_mlp",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_core_l3_cache_fill_bw"
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / (duration_time * 1e3 /=
 1e3)",
+        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l1mpki"
     },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / (duration_time * 1e3 /=
 1e3)",
+        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "Backend;CacheMisses;Mem",
+        "MetricGroup": "Backend;CacheHits;Mem",
         "MetricName": "tma_info_memory_l2mpki"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_memory_l3mpki"
+        "BriefDescription": "",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_memory_load_miss_real_latency"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / (duration_time =
* 1e3 / 1e3)",
+        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "tma_info_memory_mlp",
-        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.=
ANY",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_l3mpki"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_memory_oro_data_l2_mlp"
+        "MetricName": "tma_info_memory_latency_data_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
+        "MetricExpr": "tma_info_memory_load_l2_miss_latency",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_memory_oro_load_l2_miss_latency"
+        "MetricName": "tma_info_memory_latency_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
+        "MetricExpr": "tma_info_memory_load_l2_mlp",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_memory_oro_load_l2_mlp"
+        "MetricName": "tma_info_memory_latency_load_l2_mlp"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t"
+        "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
+        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_load_l2_miss_latency",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t"
+        "BriefDescription": "Average Parallel L2 cache miss demand Loads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_load_l2_mlp",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "0",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
+    },
+    {
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_page_walks_utilization",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
@@ -704,21 +747,27 @@
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
         "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
     },
@@ -774,6 +823,12 @@
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_turbo_utilization"
     },
+    {
+        "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
+        "MetricExpr": "tma_info_system_socket_clks / 1e9 / duration_time",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_uncore_frequency"
+    },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
@@ -815,7 +870,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
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
@@ -824,7 +879,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
         "MetricExpr": "max((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.ST=
ALLS_LDM_PENDING) - CYCLE_ACTIVITY.STALLS_L1D_PENDING) / tma_info_thread_cl=
ks, 0)",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
+        "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT_PS;MEM_LOAD_UOPS_=
RETIRED.HIT_LFB_PS. Related metrics: tma_clears_resteers, tma_machine_clear=
s, tma_microcode_sequencer, tma_ms_switches, tma_ports_utilized_1",
@@ -833,7 +888,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_PENDING - CYCLE_ACTIVITY=
STALLS_L2_PENDING) / tma_info_thread_clks",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
+        "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_UOPS_RETIRED.L2_HIT_PS",
@@ -843,20 +898,20 @@
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
         "MetricConstraint": "NO_GROUP_EVENTS_SMT",
         "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS) * CYCLE_ACTIVITY.STALLS_L2_P=
ENDING / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
+        "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_LOAD_=
UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRE=
D.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RET=
IRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_L3_=
MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM + MEM_L=
OAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_FWD))) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metri=
cs: tma_mem_latency",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metric=
s: tma_mem_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -875,7 +930,7 @@
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
@@ -890,11 +945,10 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM * (=
1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOA=
D_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UO=
PS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_=
LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_R=
ETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
-        "MetricName": "tma_local_dram",
-        "MetricThreshold": "tma_local_dram > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "MetricName": "tma_local_mem",
+        "MetricThreshold": "tma_local_mem > 0.1 & (tma_mem_latency > 0.1 &=
 (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2)=
))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_L3=
_MISS_RETIRED.LOCAL_DRAM_PS",
         "ScaleUnit": "100%"
     },
@@ -920,21 +974,21 @@
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
ated metrics: tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_system_dram_bw_u=
se, tma_sq_full",
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
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_l3_hit_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_l3_hit_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -962,7 +1016,7 @@
         "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
-        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 4 > 0.35)",
+        "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
         "ScaleUnit": "100%"
     },
@@ -981,7 +1035,7 @@
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED_PORT.PORT_0. Related metrics: tma_fp_=
scalar, tma_fp_vector, tma_fp_vector_512b, tma_port_1, tma_port_5, tma_port=
_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED_PORT.PORT_0. Related metrics: tma_fp_=
scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vecto=
r_512b, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -990,7 +1044,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED_PORT.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vect=
or_512b, tma_port_0, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED_PORT.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vect=
or_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_5, tm=
a_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1026,16 +1080,16 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
         "MetricThreshold": "tma_port_5 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED.PORT_5. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_6, tma=
_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED.PORT_5. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simple=
 ALU)",
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple=
 ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_6. Related metrics: tma_fp_sc=
alar, tma_fp_vector, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_6. Related metrics: tma_fp_s=
calar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector=
_512b, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1081,7 +1135,7 @@
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. R=
elated metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_512b, tma_port_=
0, tma_port_1, tma_port_5, tma_port_6",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. R=
elated metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_ve=
ctor_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, tma_port=
_6",
         "ScaleUnit": "100%"
     },
     {
@@ -1089,7 +1143,7 @@
         "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / tma_info_core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
@@ -1104,11 +1158,10 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "310 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOT=
E_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_=
RETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
-        "MetricName": "tma_remote_dram",
-        "MetricThreshold": "tma_remote_dram > 0.1 & (tma_mem_latency > 0.1=
 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
+        "MetricName": "tma_remote_mem",
+        "MetricThreshold": "tma_remote_mem > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article. Sample=
 with: MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_PS",
         "ScaleUnit": "100%"
     },
@@ -1186,15 +1239,6 @@
         "MetricThreshold": "tma_store_op_utilization > 0.6",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
-        "MetricExpr": "INST_RETIRED.X87 * tma_info_thread_uoppi / UOPS_RET=
IRED.RETIRE_SLOTS",
-        "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
-        "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "Uncore operating frequency in GHz",
         "MetricExpr": "UNC_C_CLOCKTICKS / (#num_cores / #num_packages * #n=
um_packages) / 1e9 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/metricgroups.json
index f6a0258e3241..8c808347f6da 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json
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
@@ -24,7 +24,9 @@
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
@@ -94,6 +96,7 @@
     "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_=
utilization category",
+    "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
     "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
     "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
     "tma_microcode_sequencer_group": "Metrics contributing to tma_microcod=
e_sequencer category",
--=20
2.43.0.687.g38aa6559b0-goog


