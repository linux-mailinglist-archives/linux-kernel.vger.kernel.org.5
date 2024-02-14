Return-Path: <linux-kernel+bounces-64644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80985411D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E851C22D42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7B14004;
	Wed, 14 Feb 2024 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tRa9S6wZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50812B6A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873552; cv=none; b=aibcP3SpuYioypcmHvfc+nq/GbqSez66+MzDY8sneRRoF52OfUXu44xlwHSSXI6DiH83W6XMf7RmG6UdtqoAObONTsOoZ4TepGAuIAo+L96Dm7pffe7698U6ej2gMm0wZ0R/Wtnm6ng+rC9fKnuyQPBSyDQe/+E23meyGZ8tMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873552; c=relaxed/simple;
	bh=dwPnXHYz2OF4MCTcXxhHhD8LjB88T4cz4vA58QNv1cM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=VhkzRA1WQ6bNJ/3/ZeKnqtGMXtvAcoUjYUs02ZxxyCcpZllZkVOrQNr3mrLehPCSvutGNL5ijOW+3eW7Wi/7+6ER8F+twLJWJ74Yetl9ENuZbSjP2R28omVQNttI4FAOe0iEXheqwrU272hs4tOJybC4qEiojhZr8klSBfJJ2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRa9S6wZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60665b5fabcso24293037b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873546; x=1708478346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUvs+bmTx0S6t1DWNKCoEbep76zBX8/tKIp6f3Ktwq0=;
        b=tRa9S6wZffo0FXxb2PmF9no9KjFgSFcvOY6QKzhYA/6+KdsKoKLJWACbUJZ6EawazO
         hZ2E2P6xvI3WOTu4rK58L+aYVHQxrhmH5Vr9VwOJC0uW/F8XIu3taezDXpbW81f1o7z0
         gTlwElIl+Sblpg2Kb5Ot/DrsKkE7+fGJK5/RjqsVfIJl879LUrtGV3763RXckUc0dKCD
         qeBUcA6KDXATkCH4SN5FnaEjZCP/M32lgZYO2rQIuz8beJFrCqaTOQF8L2UTOPa6bwmg
         A+MI7KaEmWX3zXAYZniBTRGxVmXzqVaI9/y4grc9/dJoFviMCA3+XRg4xLYQ7ZjasZDD
         Opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873546; x=1708478346;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yUvs+bmTx0S6t1DWNKCoEbep76zBX8/tKIp6f3Ktwq0=;
        b=KQQH+jzWqav4iuNKK9BILVD+QumcMpC+PLD69jk0T9bJUsIhUCrdRLkDQMWG+VJt1S
         3BEijA/J7DkQfa4jHcz0BsgEhRQnRdTsc5aKPen+Fx9vOTANdfVWVqo6V2a4GFqC0m78
         GN/Kv8kIkxupqAyht+QjUkN9hhMAN/+6nstzXioIGe/mcAqglvM+jQFVJtJVQgoeFDmv
         1vb4CP6tyNatjum63AUd/fbAkbTgpRzgOeNuawADm6MkrxLF59f4bl1605gMJyYDCutu
         t6/lkygUMHYZhImCsGMIpXo4zS1lCoUr1vqYeYl5JUqGTkjXUov+PSvER5A6skrUInsi
         JLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG3wKJ+Dy67s1L4sV5PR/XH4iwLmi3LyZnlah5YE1/kNYYe9/mkn4W7kBskRmcqSzikpL2bifRv6uLVa52uiy4ATdpExWQXTSdsuFC
X-Gm-Message-State: AOJu0YyFGA8VhHnz3X2fst8H5yLfx1TTftaKiOz39qhOp6ohpYdX1atJ
	SE39kG53qJNmDVixmOY6YjE6lVBkDremoqVmWo7Ca01m9L128F7xW+OV/cmA5NtWALVd+YiURZy
	YwyQzqw==
X-Google-Smtp-Source: AGHT+IF5dG3vvIpsTRUnTxtmLodeSgxLQAb3hi/5PWQPKJz7x1eBSf25nmmItNldiXSoUt4uOUJKvl8NsQFH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a81:8396:0:b0:604:a2f4:4741 with SMTP id
 t144-20020a818396000000b00604a2f44741mr196045ywf.1.1707873546439; Tue, 13 Feb
 2024 17:19:06 -0800 (PST)
Date: Tue, 13 Feb 2024 17:18:02 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 13/30] perf vendor events intel: Update alderlake TMA
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

 - tma_info_bottleneck* metrics, an abstraction or summarization of
   the 100+ TMA tree nodes into 12-entry familiar performance metrics.
 - tma_c01_wait and tma_c02_wait metrics measure power-performance
   states.
 - Reduce number of events (multiplexing) for tma_info_system_gflops,
   tma_info_core_flopc, tma_info_inst_mix_ipflop and tma_ports_utilized_0.
 - Fixes for tma_info_bottleneck_mispredictions and
   tma_info_bad_spec_branch_misprediction_cost.
 - New tma_info_inst_mix_ippause metric.
 - tma_serializing_operation is raised to level 3.
 - Swapped tma_info_core_ilp (becomes per SMT thread) and
   tma_info_pipeline_execute (per physical core).
 - tma_nop_instructions and tma_shuffles_256b are lowered to level 4
   under tma_other_light_ops_group.
 - Reduced number of events when SMT is off.
 - Tuned thresholds for tma_info_bottleneck_branching_overhead,
   tma_fetch_bandwidth and tma_ports_utilized_3m.

The update came from:

https://github.com/intel/perfmon/pull/140
https://github.com/intel/perfmon/pull/138

Running the script:

https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 459 +++++++++++-------
 .../arch/x86/alderlake/metricgroups.json      |  11 +-
 2 files changed, 302 insertions(+), 168 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index bbfa3883e533..b72c0e2cb946 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -811,13 +811,13 @@
         "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_D=
ISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DIS=
PATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
-        "MetricThreshold": "tma_alu_op_utilization > 0.6",
+        "MetricThreshold": "tma_alu_op_utilization > 0.4",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * cpu_core@ASSISTS.ANY\\,umask\\=3D0x1B@ / tma_=
info_thread_slots",
+        "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ / tma_info_thread_slots"=
,
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -879,6 +879,24 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings).",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C01@ / tma_info_thread_cl=
ks",
+        "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
+        "MetricName": "tma_c01_wait",
+        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings).",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C02@ / tma_info_thread_cl=
ks",
+        "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
+        "MetricName": "tma_c02_wait",
+        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
@@ -901,7 +919,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "(25 * tma_info_system_average_frequency * (cpu_core=
@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SN=
OOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.=
DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_system_average=
_frequency * cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@M=
EM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_inf=
o_thread_clks",
+        "MetricExpr": "(25 * tma_info_system_core_frequency * (cpu_core@ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP=
_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEM=
AND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_system_core_frequ=
ency * cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@MEM_LOA=
D_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thre=
ad_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -922,7 +940,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "24 * tma_info_system_average_frequency * (cpu_core@=
MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSN=
P_FWD@ * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OC=
R.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SN=
OOP_HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@ME=
M_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
+        "MetricExpr": "24 * tma_info_system_core_frequency * (cpu_core@MEM=
_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_F=
WD@ * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP=
_HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_L=
OAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -935,7 +953,7 @@
         "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cp=
u_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2"=
,
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc=
 / 6 > 0.35))",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & t=
ma_fetch_bandwidth > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -965,7 +983,7 @@
         "MetricExpr": "(cpu_core@IDQ.DSB_CYCLES_ANY@ - cpu_core@IDQ.DSB_CY=
CLES_OK@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
-        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 6 > 0.35)",
+        "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -986,7 +1004,7 @@
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_me=
mory_synchronization",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -996,13 +1014,13 @@
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_memory_synchroniz=
ation",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "28 * tma_info_system_average_frequency * cpu_core@O=
CR.DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
+        "MetricExpr": "28 * tma_info_system_core_frequency * cpu_core@OCR.=
DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1016,7 +1034,7 @@
         "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_memory_bandwidth, t=
ma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_laten=
cy, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1025,7 +1043,7 @@
         "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
         "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_thread_ipc / 6 > 0.35",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
@@ -1127,10 +1145,10 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_thread_slots)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricGroup": "Branches;Pipeline;TopdownL3;tma_L3_group;tma_light=
_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JC=
C are commonly used examples.",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1141,14 +1159,14 @@
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEA=
VY",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .). Sample with: UOPS=
_RETIRED.HEAVY",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
         "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks=
",
-        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
+        "MetricGroup": "BigFootprint;FetchLat;IcMiss;TopdownL3;tma_L3_grou=
p;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
@@ -1157,7 +1175,7 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_thread_sl=
ots / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "tma_info_bottleneck_mispredictions * tma_info_threa=
d_slots / cpu_core@BR_MISP_RETIRED.ALL_BRANCHES@ / 100",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
         "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers",
@@ -1181,7 +1199,7 @@
     },
     {
         "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL\\,umask\\=3D=
0x80@ / BR_MISP_RETIRED.INDIRECT",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_MISP_RETIRED.INDIRE=
CT",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3",
@@ -1203,6 +1221,13 @@
         "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing mispredicts and nukes)",
+        "MetricExpr": "cpu_core@INT_MISC.CLEARS_COUNT@ / (cpu_core@BR_MISP=
_RETIRED.ALL_BRANCHES@ + cpu_core@MACHINE_CLEARS.COUNT@)",
+        "MetricGroup": "BrMispredicts",
+        "MetricName": "tma_info_bad_spec_spec_clears_ratio",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
         "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
@@ -1229,68 +1254,110 @@
         "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: ",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the baseline operations not covered by Branching_Overhead nor Irregular_O=
verhead.",
+        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + cpu_core@BR_INST_RETIRED.NEAR_CALL@) / tma_info_thread_slots -=
 tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_seque=
ncer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Ret",
+        "MetricName": "tma_info_bottleneck_base_non_br",
+        "MetricThreshold": "tma_info_bottleneck_base_non_br > 20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB;tma_issueBC"=
,
+        "MetricGroup": "BigFootprint;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "tma_info_bottleneck_big_code",
         "MetricThreshold": "tma_info_bottleneck_big_code > 20",
-        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_bottleneck_branching_overhead",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.COND@ + 3 * cpu_co=
re@BR_INST_RETIRED.NEAR_CALL@ + (cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu=
_core@BR_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@=
)) / tma_info_thread_slots)",
-        "MetricGroup": "Ret;tma_issueBC",
+        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + cp=
u_core@BR_INST_RETIRED.NEAR_CALL@) / tma_info_thread_slots)",
+        "MetricGroup": "Ret",
         "MetricName": "tma_info_bottleneck_branching_overhead",
-        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 10",
-        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_bottleneck_big_code",
+        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_lock=
_latency + tma_split_loads + tma_store_fwd_blk)))",
+        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
+        "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth > 2=
0",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency + tma_streaming_stores)))",
+        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_info_bottleneck_cache_memory_latency",
+        "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 20"=
,
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "Cor;tma_issueComp",
+        "MetricName": "tma_info_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_info_bottleneck_compute_bound_est > 20",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: ",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
-        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottlen=
eck_big_code",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_cl=
ears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_bran=
ch_mispredicts) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unk=
nown_branches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_miss=
es + tma_itlb_misses + tma_lcp + tma_ms_switches))) - tma_info_bottleneck_b=
ig_code",
         "MetricGroup": "Fed;FetchBW;Frontend",
         "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"=
,
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_dt=
lb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_=
blk))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_bottleneck_memory_bandwidth",
-        "MetricThreshold": "tma_info_bottleneck_memory_bandwidth > 20",
-        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_system_d=
ram_bw_use, tma_mem_bandwidth, tma_sq_full",
+        "BriefDescription": "Total pipeline cost of irregular execution (e=
g",
+        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_swi=
tches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_restee=
rs * tma_other_mispredicts / tma_branch_mispredicts) / (tma_clears_resteers=
 + tma_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers=
 + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_m=
s_switches)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other=
_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cp=
u_core@RS.EMPTY\\,umask\\=3D1@ / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Bad;Cor;Ret;tma_issueMS",
+        "MetricName": "tma_info_bottleneck_irregular_overhead",
+        "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
+        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_fb=
_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_stor=
e_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_me=
mory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bou=
nd + tma_l3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store +=
 tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_s=
tores)))",
         "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_info_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store, tma_info_bottleneck_memory_synchronization",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
-        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_bottleneck_memory_latency",
-        "MetricThreshold": "tma_info_bottleneck_memory_latency > 20",
-        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency",
+        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency + tma_streaming_stores - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricGroup": "Mem;Offcore;tma_issueTLB",
+        "MetricName": "tma_info_bottleneck_memory_synchronization",
+        "MetricThreshold": "tma_info_bottleneck_memory_synchronization > 1=
0",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_me=
mory_data_tlbs",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
         "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bottleneck_mispredictions",
         "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
         "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
(apart from those listed in the Info.Bottlenecks metrics class)",
+        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bott=
leneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_info=
_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_laten=
cy + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sync=
hronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck_i=
rregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bottl=
eneck_base_non_br)",
+        "MetricGroup": "Cor;Offcore",
+        "MetricName": "tma_info_bottleneck_other_bottlenecks",
+        "MetricThreshold": "tma_info_bottleneck_other_bottlenecks > 20",
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 (apart from those listed in the Info.Bottlenecks metrics class). Examples =
include data-dependencies (Core Bound when Low ILP) and other unlisted memo=
ry-related stalls.",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
         "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@BR_=
INST_RETIRED.NEAR_RETURN@) / BR_INST_RETIRED.ALL_BRANCHES",
@@ -1328,7 +1395,7 @@
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.DISTRIBUTED@",
+        "MetricExpr": "(cpu_core@CPU_CLK_UNHALTED.DISTRIBUTED@ if #SMT_on =
else tma_info_thread_clks)",
         "MetricGroup": "SMT",
         "MetricName": "tma_info_core_core_clks",
         "Unit": "cpu_core"
@@ -1340,9 +1407,16 @@
         "MetricName": "tma_info_core_coreipc",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "uops Executed per Cycle",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / tma_info_thread_cl=
ks",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_core_epc",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / tma_info_core_core_clks",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ tma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc",
         "Unit": "cpu_core"
@@ -1356,8 +1430,8 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.CORE_CYC=
LES_GE_1@)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp",
         "Unit": "cpu_core"
@@ -1428,6 +1502,14 @@
         "MetricName": "tma_info_frontend_lsd_coverage",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
+        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_core=
@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_unknown_branch_cost",
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node.",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Branch instructions per taken branch.",
         "MetricExpr": "cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ / BR_INST_RE=
TIRED.NEAR_TAKEN",
@@ -1449,7 +1531,7 @@
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW.",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW.",
         "Unit": "cpu_core"
     },
     {
@@ -1458,7 +1540,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting.",
         "Unit": "cpu_core"
     },
     {
@@ -1467,7 +1549,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting.",
         "Unit": "cpu_core"
     },
     {
@@ -1476,7 +1558,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting.",
         "Unit": "cpu_core"
     },
     {
@@ -1485,7 +1567,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting.",
         "Unit": "cpu_core"
     },
     {
@@ -1506,7 +1588,7 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.SCALAR_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + =
2 * cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_A=
RITH_INST_RETIRED.128B_PACKED_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B=
_PACKED_DOUBLE@) + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@)"=
,
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.SCALAR@ + 2 * cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ =
+ 4 * cpu_core@FP_ARITH_INST_RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_=
RETIRED.256B_PACKED_SINGLE@)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_ipflop",
         "MetricThreshold": "tma_info_inst_mix_ipflop < 10",
@@ -1520,6 +1602,13 @@
         "MetricThreshold": "tma_info_inst_mix_ipload < 3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Instructions per PAUSE (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / CPU_CLK_UNHALTED.P=
AUSE_INST",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_inst_mix_ippause",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / MEM_INST_RETIRED.ALL_S=
TORES",
@@ -1547,164 +1636,178 @@
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_tim=
e",
+        "MetricExpr": "tma_info_memory_l1d_cache_fill_bw",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw",
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw_2t",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_tim=
e",
+        "MetricExpr": "tma_info_memory_l2_cache_fill_bw",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_core_l2_cache_fill_bw",
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw_2t",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ duration_time",
+        "MetricExpr": "tma_info_memory_l3_cache_access_bw",
         "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_memory_core_l3_cache_access_bw",
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw_2t",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / durat=
ion_time",
+        "MetricExpr": "tma_info_memory_l3_cache_fill_bw",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_core_l3_cache_fill_bw",
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw_2t",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
         "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / INST_RETI=
RED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_fb_hpki",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_tim=
e",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / INST_RET=
IRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l1mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
         "MetricExpr": "1e3 * cpu_core@L2_RQSTS.ALL_DEMAND_DATA_RD@ / INST_=
RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l1mpki_load",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_tim=
e",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
         "MetricExpr": "1e3 * (cpu_core@L2_RQSTS.REFERENCES@ - cpu_core@L2_=
RQSTS.MISS@) / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2hpki_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_HIT@ / INST_=
RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2hpki_load",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L2_MISS@ / INST_RET=
IRED.ANY",
-        "MetricGroup": "Backend;CacheMisses;Mem",
+        "MetricGroup": "Backend;CacheHits;Mem",
         "MetricName": "tma_info_memory_l2mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1e3 * cpu_core@L2_RQSTS.MISS@ / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem;Offcore",
+        "MetricGroup": "CacheHits;Mem;Offcore",
         "MetricName": "tma_info_memory_l2mpki_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_MISS@ / INST=
_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2mpki_load",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / INST_RET=
IRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_memory_l3mpki",
+        "BriefDescription": "",
+        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ duration_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_l3_cache_access_bw",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / MEM_LOAD_COMPLETE=
D.L1_MISS_ANY",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_memory_load_miss_real_latency",
+        "BriefDescription": "",
+        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / durat=
ion_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
-        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / L1D_PEND_MISS.PEN=
DING_CYCLES",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "tma_info_memory_mlp",
-        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / INST_RET=
IRED.ANY",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_l3mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD@ =
/ OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DATA_RD@ / OF=
FCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_memory_oro_data_l2_mlp",
+        "MetricName": "tma_info_memory_latency_data_l2_mlp",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_memory_oro_load_l2_miss_latency",
+        "MetricName": "tma_info_memory_latency_load_l2_miss_latency",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_memory_oro_load_l2_mlp",
+        "MetricName": "tma_info_memory_latency_load_l2_mlp",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
         "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAN=
D_DATA_RD@ / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_memory_oro_load_l3_miss_latency",
+        "MetricName": "tma_info_memory_latency_load_l3_miss_latency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / MEM_LOAD_COMPLETE=
D.L1_MISS_ANY",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t",
+        "BriefDescription": "\"Bus lock\" per kilo instruction",
+        "MetricExpr": "1e3 * cpu_core@SQ_MISC.BUS_LOCK@ / INST_RETIRED.ANY=
",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_mix_bus_lock_pki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l3_cache_access_bw",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t",
+        "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_MISC_RETIRED.UC@ / INST_RET=
IRED.ANY",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_mix_uc_load_pki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / L1D_PEND_MISS.PEN=
DING_CYCLES",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
         "Unit": "cpu_core"
     },
     {
@@ -1737,16 +1840,16 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D1@",
+        "BriefDescription": "",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@ASSISTS.ANY\\=
,umask\\=3D0x1B@",
-        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / ASSISTS.ANY",
+        "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
         "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)",
@@ -1762,39 +1865,54 @@
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
         "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
+        "MetricGroup": "MicroSeq;Pipeline;Ret",
         "MetricName": "tma_info_pipeline_strings_cycles",
         "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "BriefDescription": "Fraction of cycles the processor is waiting y=
et unhalted; covering legacy PAUSE instruction, as well as C0.1 / C0.2 powe=
r-performance optimized states",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C0_WAIT@ / tma_info_threa=
d_clks",
+        "MetricGroup": "C0Wait",
+        "MetricName": "tma_info_system_c0_wait",
+        "MetricThreshold": "tma_info_system_c0_wait > 0.05",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
         "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
         "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_system_average_frequency",
+        "MetricName": "tma_info_system_core_frequency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "BriefDescription": "Average CPU Utilization (percentage)",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
         "MetricGroup": "HPC;Summary",
         "MetricName": "tma_info_system_cpu_utilization",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Average number of utilized CPUs",
+        "MetricExpr": "#num_cpus_online * tma_info_system_cpu_utilization"=
,
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_cpus_utilized",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
         "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_memory_bandwidth, tma_mem_bandwidth, tma_sq_full",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_cache_memory_bandwidth, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / 1e9 / duration_time",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ 1e9 / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine.",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width",
         "Unit": "cpu_core"
     },
     {
@@ -1837,14 +1955,6 @@
         "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(UNC_ARB_TRK_OCCUPANCY.ALL + UNC_ARB_DAT_OCCUPANCY.=
RD) / UNC_ARB_TRK_REQUESTS.ALL",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "tma_info_system_mem_request_latency",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - cpu_core@CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE@ /=
 cpu_core@CPU_CLK_UNHALTED.REF_DISTRIBUTED@ if #SMT_on else 0)",
@@ -1927,7 +2037,7 @@
     },
     {
         "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
-        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b + tma_shu=
ffles",
+        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_int_operations",
         "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
@@ -1946,19 +2056,19 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
+        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fraction=
 the CPU has retired",
         "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT_V=
EC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring *=
 tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_256b",
         "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
-        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma=
_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clks"=
,
-        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
+        "MetricGroup": "BigFootprint;FetchLat;MemoryTLB;TopdownL3;tma_L3_g=
roup;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
@@ -1968,7 +2078,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
         "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_thread_clks, 0)",
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
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS. Related metrics: tma_clears_resteers, tma_machine_clears, tma_micr=
ocode_sequencer, tma_ms_switches, tma_ports_utilized_1",
@@ -1978,7 +2088,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_thread_clks",
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
th: MEM_LOAD_RETIRED.L2_HIT_PS",
@@ -1988,7 +2098,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_thread_clks",
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
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
@@ -1996,12 +2106,12 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "9 * tma_info_system_average_frequency * cpu_core@ME=
M_LOAD_RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@=
MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
+        "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
+        "MetricExpr": "9 * tma_info_system_core_frequency * (cpu_core@MEM_=
LOAD_RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@ME=
M_LOAD_RETIRED.L1_MISS@ / 2)) / tma_info_thread_clks",
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
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: t=
ma_info_bottleneck_memory_latency, tma_mem_latency",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_info_bottleneck_cache_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2022,7 +2132,7 @@
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2069,7 +2179,7 @@
         "MetricExpr": "(cpu_core@LSD.CYCLES_ACTIVE@ - cpu_core@LSD.CYCLES_=
OK@) / tma_info_core_core_clks / 2",
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
-        "MetricThreshold": "tma_lsd > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 6 > 0.35)",
+        "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2086,22 +2196,22 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clk=
s",
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
ated metrics: tma_fb_full, tma_info_bottleneck_memory_bandwidth, tma_info_s=
ystem_dram_bw_use, tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_bottleneck_cache=
_memory_bandwidth, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - tm=
a_mem_bandwidth",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_info_bottleneck_memory_latency, tma_l3_hit_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_info_bottleneck_cache_memory_latency, tma_l3_hit_la=
tency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2120,9 +2230,9 @@
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_thre=
ad_clks",
-        "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
-        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 =
& (tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
+        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2141,7 +2251,7 @@
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_clears_reste=
ers, tma_l1_bound, tma_machine_clears, tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_clears_reste=
ers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tma_machine_clea=
rs, tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2160,35 +2270,35 @@
         "MetricExpr": "(cpu_core@IDQ.MITE_CYCLES_ANY@ - cpu_core@IDQ.MITE_=
CYCLES_OK@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
-        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 6 > 0.35)",
+        "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
         "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
-        "PublicDescription": "The Mixing_Vectors metric gives the percenta=
ge of injected blend uops out of all uops issued. Usually a Mixing_Vectors =
over 5% is worth investigating. Read more in Appendix B1 of the Optimizatio=
ns Guide for this topic. Related metrics: tma_ms_switches",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (tma_retiring * tma_info_thread_slots / cpu_core@UOPS_ISSUED.ANY@) / tma_=
info_thread_clks",
+        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tma_info_thr=
ead_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_clears_resteers, tma_l1_bound, tma_machine_clears, tma_microcode_sequence=
r, tma_mixing_vectors, tma_serializing_operation",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_clears_resteers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tm=
a_machine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializ=
ing_operation",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
         "MetricExpr": "tma_light_operations * (cpu_core@BR_INST_RETIRED.AL=
L_BRANCHES@ - cpu_core@INST_RETIRED.MACRO_FUSED@) / (tma_retiring * tma_inf=
o_thread_slots)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricGroup": "Branches;Pipeline;TopdownL3;tma_L3_group;tma_light=
_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
@@ -2198,16 +2308,16 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_thread_slots)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricGroup": "Pipeline;TopdownL4;tma_L4_group;tma_other_light_op=
s_group",
         "MetricName": "tma_nop_instructions",
-        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_light_operati=
ons > 0.6",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
-        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches + tma_nop_instructions))",
+        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches))",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_other_light_ops",
         "MetricThreshold": "tma_other_light_ops > 0.3 & tma_light_operatio=
ns > 0.6",
@@ -2215,6 +2325,24 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
+        "MetricExpr": "max(tma_branch_mispredicts * (1 - cpu_core@BR_MISP_=
RETIRED.ALL_BRANCHES@ / (cpu_core@INT_MISC.CLEARS_COUNT@ - cpu_core@MACHINE=
_CLEARS.COUNT@)), 0.0001)",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_other_mispredicts",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
+        "MetricExpr": "max(tma_machine_clears * (1 - cpu_core@MACHINE_CLEA=
RS.MEMORY_ORDERING@ / cpu_core@MACHINE_CLEARS.COUNT@), 0.0001)",
+        "MetricGroup": "Machine_Clears;TopdownL3;tma_L3_group;tma_machine_=
clears_group",
+        "MetricName": "tma_other_nukes",
+        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
         "MetricExpr": "99 * cpu_core@ASSISTS.PAGE_FAULT@ / tma_info_thread=
_slots",
@@ -2246,18 +2374,18 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simple=
 ALU)",
         "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_6@ / tma_info_core_co=
re_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple=
 ALU). Sample with: UOPS_DISPATCHED.PORT_6. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b,=
 tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port=
_5, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_6. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_por=
t_5, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x=
80@ + tma_serializing_operation * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - =
cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) + (cpu_core@EXE_ACTIVITY.1_PORTS_UTI=
L@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@)) /=
 tma_info_thread_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_core@CYCLE_ACTIVI=
TY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ else (cpu_core@EXE=
_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL=
\\,umask\\=3D0xc@) / tma_info_thread_clks)",
+        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (cp=
u_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_=
PORTS_UTIL\\,umask\\=3D0xc@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_=
ACTIVE@ < cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOU=
ND_ON_LOADS@ else (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu=
_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -2267,7 +2395,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80=
@ / tma_info_thread_clks + tma_serializing_operation * (cpu_core@CYCLE_ACTI=
VITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) / tma_info_thre=
ad_clks",
+        "MetricExpr": "(cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x8=
0@ + cpu_core@RS.EMPTY\\,umask\\=3D1@) / tma_info_thread_clks * (cpu_core@C=
YCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) / tma_=
info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -2302,7 +2430,7 @@
         "MetricExpr": "cpu_core@UOPS_EXECUTED.CYCLES_GE_3@ / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2321,20 +2449,21 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "cpu_core@RESOURCE_STALLS.SCOREBOARD@ / tma_info_thr=
ead_clks",
-        "MetricGroup": "PortsUtil;TopdownL5;tma_L5_group;tma_issueSO;tma_p=
orts_utilized_0_group",
+        "MetricExpr": "cpu_core@RESOURCE_STALLS.SCOREBOARD@ / tma_info_thr=
ead_clks + tma_c02_wait",
+        "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup;tma_issueSO",
         "MetricName": "tma_serializing_operation",
-        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_ports_u=
tilized_0 > 0.2 & (tma_ports_utilization > 0.15 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)))",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents Shuffle (cross \"vecto=
r lane\" data transfers) uops fraction the CPU has retired.",
-        "MetricExpr": "cpu_core@INT_VEC_RETIRED.SHUFFLES@ / (tma_retiring =
* tma_info_thread_slots)",
-        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_int_operat=
ions_group",
-        "MetricName": "tma_shuffles",
-        "MetricThreshold": "tma_shuffles > 0.1 & (tma_int_operations > 0.1=
 & tma_light_operations > 0.6)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring Shuffle operations of 256-bit vector size (FP or Int=
eger)",
+        "MetricExpr": "tma_light_operations * cpu_core@INT_VEC_RETIRED.SHU=
FFLES@ / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_ligh=
t_ops_group",
+        "MetricName": "tma_shuffles_256b",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & (tma_other_light_ops=
 > 0.3 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2342,9 +2471,9 @@
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.PAUSE@ / tma_info_thread_=
clks",
-        "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
-        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 & =
(tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
+        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2375,7 +2504,7 @@
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_memory_bandwidth, tma_info_system_dram_bw_use, tma_me=
m_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_cache_memory_bandwidth, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2450,10 +2579,10 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
         "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / tma_info=
_thread_clks",
-        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
+        "MetricGroup": "BigFootprint;FetchLat;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group",
         "MetricName": "tma_unknown_branches",
         "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit). Sample with: FRONTEND_RE=
TIRED.UNKNOWN_BRANCH",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
index 516eb0f93f02..7a03835f262c 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
@@ -2,10 +2,11 @@
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
+    "C0Wait": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
+    "CacheHits": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
     "CodeGen": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Compute": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Cor": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -26,7 +27,9 @@
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
@@ -69,6 +72,7 @@
     "tma_backend_bound_group": "Metrics contributing to tma_backend_bound =
category",
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
     "tma_base_group": "Metrics contributing to tma_base category",
+    "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_mi=
spredicts category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
     "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
@@ -82,9 +86,9 @@
     "tma_heavy_operations_group": "Metrics contributing to tma_heavy_opera=
tions category",
     "tma_int_operations_group": "Metrics contributing to tma_int_operation=
s category",
     "tma_issue2P": "Metrics related by the issue $issue2P",
-    "tma_issueBC": "Metrics related by the issue $issueBC",
     "tma_issueBM": "Metrics related by the issue $issueBM",
     "tma_issueBW": "Metrics related by the issue $issueBW",
+    "tma_issueComp": "Metrics related by the issue $issueComp",
     "tma_issueD0": "Metrics related by the issue $issueD0",
     "tma_issueFB": "Metrics related by the issue $issueFB",
     "tma_issueFL": "Metrics related by the issue $issueFL",
@@ -111,6 +115,7 @@
     "tma_microcode_sequencer_group": "Metrics contributing to tma_microcod=
e_sequencer category",
     "tma_mite_group": "Metrics contributing to tma_mite category",
     "tma_nuke_group": "Metrics contributing to tma_nuke category",
+    "tma_other_light_ops_group": "Metrics contributing to tma_other_light_=
ops category",
     "tma_ports_utilization_group": "Metrics contributing to tma_ports_util=
ization category",
     "tma_ports_utilized_0_group": "Metrics contributing to tma_ports_utili=
zed_0 category",
     "tma_ports_utilized_3m_group": "Metrics contributing to tma_ports_util=
ized_3m category",
--=20
2.43.0.687.g38aa6559b0-goog


