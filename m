Return-Path: <linux-kernel+bounces-64658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED085412C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBA11F24246
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095C1CAAA;
	Wed, 14 Feb 2024 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="4e2PYl8F"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9AB199C2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873592; cv=none; b=VEh6hmteRdztysZdPL1kIyh0xPpLUqsiUHlAU2ddDHCZI3gInbHfoVay42IuiDsEvWIlHLxF9ccSwLywneZzzli4gGOyPduRpXnXZI2thsRcXiE8QcQ3F+11gMll76QMJLckfMW/YB/CpL8JId+pzCsrPvPBUK2PhtOY/WZr37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873592; c=relaxed/simple;
	bh=Ft3kSKI6j9P735deVS4qNhofEGLSkuk9I1PkqrNCots=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=kScqkhRvDTNWxzg6MryaDQpnD+D/9/U62rIa+pRQMQvVie7jiP05FFxvFaO+ixcPmhycTKr0+3W9v74agRjPcmHKwrxF12+6yXi8rP7bYJkAmjDcqIrxnbYgEaQppPdCGkk8XNY1VbUunbdI4V0U9nyXP8w+lc51fHFTbSyVa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4e2PYl8F; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60665b5fabcso24298927b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873579; x=1708478379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WPVrUjet36XaKhOuri1b/q4jC4IYB4/jN6zhn5+rGk=;
        b=4e2PYl8F7qDiwShKVF3yd9K7VPSJE0lnu0VXu5drQM0SGZjWVYHWYF2QxCKfcIlFa/
         ABZAzSg7C+Q1VN8bSTCH0oie46b5VZ3/N58mHV0Ah6yphYEP8R9kIMuKO/Bn/JXS5Uga
         1UbKQuHnsranBa9Uo3w7JXp4C9s6YZula6UXRFxgLzKD73XcEmgtRhrAvKLe2O+sASjE
         rmLht0p5NPQOypjl9W2ZwRLUgWfJarqvyjbZosSD+A5LRIAnbmnF25MhqgFC4wW2qWJK
         8MbzDKdi+gX02XU+gjSoirZDLfaGmKweUgt+Zpz0vUBJ+7ci1cSsmbCAHmyJrsFHhIYZ
         XF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873579; x=1708478379;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1WPVrUjet36XaKhOuri1b/q4jC4IYB4/jN6zhn5+rGk=;
        b=NJ/h52gZLlYtLmctkWwx8UrLSegVQyYvVCeUPcz0ASHm1ulWigj1vdFaU4HtEuYkRL
         v5dzwMv2NczVizeQ1m3M9O+W0xQAJOFZRGDs9jX8dXUWOv//R57SRgxUlDFXOAWLK6K0
         wgA2dtTlhTVrwZnY1qXsYm0iUthdG505thXbNXhgN688sBZUpbeYWrr5n02mtJcA5cOP
         56Wd+DlWofmkiJsvewS3eJ3raEsPKc4maWcjFf+0raTW18iSqwoym9sD/6GXLRE8ev1X
         cpk7Kphnh0a6fIgq+NVjNUp56tr91Be5sSV0zxudX/KmQNUes0yIYNQ5ca44lV7criWp
         GOKA==
X-Forwarded-Encrypted: i=1; AJvYcCX5yXOsx6+z8bHqYVYXAkFWKWgeBWjisdXPu1JM4rnGVN76M92FYpUQBnvQQOmrjceH7MeO+862ApA9fI3YRWUXB49syD07SsTJFWtp
X-Gm-Message-State: AOJu0Yy8fihivGNtmJ8diArhAPQF630V0CsSH1p9zo0kbff5jfOxWA61
	JD9r34N3DSIUsv27s+DrVriKWYG5mhFK5e0WsiATWEpXDlYCVCiNvqdmsdnQWOFfyag+ZYba8MX
	pNZAANQ==
X-Google-Smtp-Source: AGHT+IFnk4/hpZoR1AIXL+hicxATsf++nwIQ+psGEaCNe6Zz5dEWAL3CKJvJt4KHitC7/uB1yEAT0PY7BFHf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a81:6c92:0:b0:5ff:5389:526c with SMTP id
 h140-20020a816c92000000b005ff5389526cmr195759ywc.2.1707873579374; Tue, 13 Feb
 2024 17:19:39 -0800 (PST)
Date: Tue, 13 Feb 2024 17:18:16 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 27/30] perf vendor events intel: Update sapphirerapids TMA
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
 .../arch/x86/sapphirerapids/metricgroups.json |  12 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  | 773 +++++++++++++-----
 2 files changed, 564 insertions(+), 221 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
index e6f7934320bf..81e5ca1c3078 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
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
@@ -27,7 +28,9 @@
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
@@ -68,6 +71,7 @@
     "tma_assists_group": "Metrics contributing to tma_assists category",
     "tma_backend_bound_group": "Metrics contributing to tma_backend_bound =
category",
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
+    "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_mi=
spredicts category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
     "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
@@ -81,9 +85,9 @@
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
@@ -103,11 +107,13 @@
     "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_=
utilization category",
+    "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
     "tma_mem_bandwidth_group": "Metrics contributing to tma_mem_bandwidth =
category",
     "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
     "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
     "tma_microcode_sequencer_group": "Metrics contributing to tma_microcod=
e_sequencer category",
     "tma_mite_group": "Metrics contributing to tma_mite category",
+    "tma_other_light_ops_group": "Metrics contributing to tma_other_light_=
ops category",
     "tma_ports_utilization_group": "Metrics contributing to tma_ports_util=
ization category",
     "tma_ports_utilized_0_group": "Metrics contributing to tma_ports_utili=
zed_0 category",
     "tma_ports_utilized_3m_group": "Metrics contributing to tma_ports_util=
ized_3m category",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 56e54babcc26..6f0e6360e989 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -84,6 +84,24 @@
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "Percentage of inbound full cacheline writes i=
nitiated by end device controllers that miss the L3 cache.",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM / UNC_CHA_TOR_INSE=
RTS.IO_ITOM",
+        "MetricName": "io_percent_of_inbound_full_writes_that_miss_l3",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of inbound partial cacheline write=
s initiated by end device controllers that miss the L3 cache.",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_MISS_RFO) / (UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_RFO)",
+        "MetricName": "io_percent_of_inbound_partial_writes_that_miss_l3",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of inbound reads initiated by end =
device controllers that miss the L3 cache.",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR / UNC_CHA_TOR_=
INSERTS.IO_PCIRDCUR",
+        "MetricName": "io_percent_of_inbound_reads_that_miss_l3",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
@@ -310,20 +328,20 @@
         "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * tma_info_core_co=
re_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
-        "MetricThreshold": "tma_alu_op_utilization > 0.6",
+        "MetricThreshold": "tma_alu_op_utilization > 0.4",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the Advanced Matrix Extensions (AMX) execution engine was busy with tile =
(arithmetic) operations",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the Advanced Matrix eXtensions (AMX) execution engine was busy with tile =
(arithmetic) operations",
         "MetricExpr": "EXE.AMX_BUSY / tma_info_core_core_clks",
-        "MetricGroup": "Compute;HPC;Server;TopdownL5;tma_L5_group;tma_port=
s_utilized_0_group",
+        "MetricGroup": "Compute;HPC;Server;TopdownL3;tma_L3_group;tma_core=
_bound_group",
         "MetricName": "tma_amx_busy",
-        "MetricThreshold": "tma_amx_busy > 0.5 & (tma_ports_utilized_0 > 0=
2 & (tma_ports_utilization > 0.15 & (tma_core_bound > 0.1 & tma_backend_bo=
und > 0.2)))",
+        "MetricThreshold": "tma_amx_busy > 0.5 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * cpu@ASSISTS.ANY\\,umask\\=3D0x1B@ / tma_info_=
thread_slots",
+        "MetricExpr": "78 * ASSISTS.ANY / tma_info_thread_slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -380,6 +398,22 @@
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings).",
+        "MetricExpr": "CPU_CLK_UNHALTED.C01 / tma_info_thread_clks",
+        "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
+        "MetricName": "tma_c01_wait",
+        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings).",
+        "MetricExpr": "CPU_CLK_UNHALTED.C02 / tma_info_thread_clks",
+        "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
+        "MetricName": "tma_c02_wait",
+        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
@@ -400,7 +434,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "(76 * tma_info_system_average_frequency * (MEM_LOAD=
_L3_HIT_RETIRED.XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEM=
AND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FW=
D))) + 75.5 * tma_info_system_average_frequency * MEM_LOAD_L3_HIT_RETIRED.X=
SNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / =
tma_info_thread_clks",
+        "MetricExpr": "(76 * tma_info_system_core_frequency * (MEM_LOAD_L3=
_HIT_RETIRED.XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND=
_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))=
) + 75.5 * tma_info_system_core_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MI=
SS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_in=
fo_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -420,7 +454,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "75.5 * tma_info_system_average_frequency * (MEM_LOA=
D_L3_HIT_RETIRED.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.=
DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + =
OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "75.5 * tma_info_system_core_frequency * (MEM_LOAD_L=
3_HIT_RETIRED.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEM=
AND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR=
DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT=
 / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -432,7 +466,7 @@
         "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
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
         "ScaleUnit": "100%"
     },
@@ -459,7 +493,7 @@
         "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_core_clks / 2",
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
         "ScaleUnit": "100%"
     },
@@ -478,7 +512,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -487,12 +521,12 @@
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "80 * tma_info_system_average_frequency * OCR.DEMAND=
_RFO.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
+        "MetricExpr": "80 * tma_info_system_core_frequency * OCR.DEMAND_RF=
O.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -505,7 +539,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -514,7 +548,7 @@
         "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
         "MetricGroup": "Default;FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_gr=
oup;tma_frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_thread_ipc / 6 > 0.35",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
@@ -539,18 +573,9 @@
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions. Related metrics: tma_decoder0_alone",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) matrix uops fraction the CPU has retired (aggregated across all =
supported FP datatypes in AMX engine)",
-        "MetricExpr": "cpu@AMX_OPS_RETIRED.BF16\\,cmask\\=3D1@ / (tma_reti=
ring * tma_info_thread_slots)",
-        "MetricGroup": "Compute;Flops;HPC;Pipeline;Server;TopdownL4;tma_L4=
_group;tma_fp_arith_group",
-        "MetricName": "tma_fp_amx",
-        "MetricThreshold": "tma_fp_amx > 0.1 & (tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6)",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) matrix uops fraction the CPU has retired (aggregated across all=
 supported FP datatypes in AMX engine). Refer to AMX_Busy and GFLOPs metric=
s for actual AMX utilization and FP performance, resp.",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector + tma_f=
p_amx",
+        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
         "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
@@ -568,7 +593,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + FP_ARITH_INST_RETIRED2.SCALAR) / (tma_retiring * tma_info_thread=
_slots)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIR=
ED2.SCALAR) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
         "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -577,7 +602,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,uma=
sk\\=3D0x3c@ + FP_ARITH_INST_RETIRED2.VECTOR) / (tma_retiring * tma_info_th=
read_slots)",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,uma=
sk\\=3D0xfc@ + FP_ARITH_INST_RETIRED2.VECTOR) / (tma_retiring * tma_info_th=
read_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
         "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -625,10 +650,10 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
         "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * tma_info_thread_slots)",
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
         "ScaleUnit": "100%"
     },
     {
@@ -639,13 +664,13 @@
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2;Default",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
         "MetricExpr": "ICACHE_DATA.STALLS / tma_info_thread_clks",
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
@@ -653,7 +678,7 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_thread_sl=
ots / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "tma_info_bottleneck_mispredictions * tma_info_threa=
d_slots / BR_MISP_RETIRED.ALL_BRANCHES / 100",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
         "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers"
@@ -693,6 +718,33 @@
         "MetricName": "tma_info_bad_spec_ipmispredict",
         "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
     },
+    {
+        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing mispredicts and nukes)",
+        "MetricExpr": "INT_MISC.CLEARS_COUNT / (BR_MISP_RETIRED.ALL_BRANCH=
ES + MACHINE_CLEARS.COUNT)",
+        "MetricGroup": "BrMispredicts",
+        "MetricName": "tma_info_bad_spec_spec_clears_ratio"
+    },
+    {
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricExpr": "(100 * (1 - max(0, topdown\\-be\\-bound / (topdown\=
\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-b=
ound) - topdown\\-mem\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spe=
c + topdown\\-retiring + topdown\\-be\\-bound)) / (((cpu@EXE_ACTIVITY.3_POR=
TS_UTIL\\,umask\\=3D0x80@ + cpu@RS.EMPTY\\,umask\\=3D0x1@) / CPU_CLK_UNHALT=
ED.THREAD * (CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS) / C=
PU_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD + (EXE_ACTIVITY.1_PORTS_UT=
IL + topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + to=
pdown\\-retiring + topdown\\-be\\-bound) * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\,=
umask\\=3D0xc@)) / CPU_CLK_UNHALTED.THREAD if ARITH.DIV_ACTIVE < CYCLE_ACTI=
VITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_=
UTIL + topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + =
topdown\\-retiring + topdown\\-be\\-bound) * cpu@EXE_ACTIVITY.2_PORTS_UTIL\=
\,umask\\=3D0xc@) / CPU_CLK_UNHALTED.THREAD) if max(0, topdown\\-be\\-bound=
 / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topd=
own\\-be\\-bound) - topdown\\-mem\\-bound / (topdown\\-fe\\-bound + topdown=
\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)) < (((cpu@EXE_AC=
TIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ + cpu@RS.EMPTY\\,umask\\=3D0x1@) / CP=
U_CLK_UNHALTED.THREAD * (CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_O=
N_LOADS) / CPU_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD + (EXE_ACTIVIT=
Y.1_PORTS_UTIL + topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad=
\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * cpu@EXE_ACTIVITY.2_P=
ORTS_UTIL\\,umask\\=3D0xc@)) / CPU_CLK_UNHALTED.THREAD if ARITH.DIV_ACTIVE =
< CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIV=
ITY.1_PORTS_UTIL + topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-b=
ad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * cpu@EXE_ACTIVITY.2=
_PORTS_UTIL\\,umask\\=3D0xc@) / CPU_CLK_UNHALTED.THREAD) else 1) if tma_inf=
o_system_smt_2t_utilization > 0.5 else 0) + 0 * slots",
+        "MetricGroup": "Cor;SMT;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_botlnk_core_bound_likely",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck.",
+        "MetricExpr": "100 * (100 * ((topdown\\-fetch\\-lat / (topdown\\-f=
e\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-boun=
d) - INT_MISC.UOP_DROPPING / slots) * (DSB2MITE_SWITCHES.PENALTY_CYCLES / C=
PU_CLK_UNHALTED.THREAD) / (ICACHE_DATA.STALLS / CPU_CLK_UNHALTED.THREAD + I=
CACHE_TAG.STALLS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CLEAR_RESTEER_CYCLES=
 / CPU_CLK_UNHALTED.THREAD + INT_MISC.UNKNOWN_BRANCH_CYCLES / CPU_CLK_UNHAL=
TED.THREAD) + min(3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge\\=3D0x1@ /=
 (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / CPU_CLK_UNHALTED.THREAD, 1) + DEC=
ODE.LCP / CPU_CLK_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_=
CLK_UNHALTED.THREAD) + max(0, topdown\\-fe\\-bound / (topdown\\-fe\\-bound =
+ topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_M=
ISC.UOP_DROPPING / slots - (topdown\\-fetch\\-lat / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MI=
SC.UOP_DROPPING / slots)) * ((IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / (=
CPU_CLK_UNHALTED.DISTRIBUTED if #SMT_on else CPU_CLK_UNHALTED.THREAD) / 2) =
/ ((IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / (CPU_CLK_UNHALTED.DISTRIBUT=
ED if #SMT_on else CPU_CLK_UNHALTED.THREAD) / 2 + (IDQ.DSB_CYCLES_ANY - IDQ=
DSB_CYCLES_OK) / (CPU_CLK_UNHALTED.DISTRIBUTED if #SMT_on else CPU_CLK_UNH=
ALTED.THREAD) / 2)))",
+        "MetricGroup": "DSBmiss;Fed;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_botlnk_dsb_misses",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck.",
+        "MetricExpr": "100 * (100 * ((topdown\\-fetch\\-lat / (topdown\\-f=
e\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-boun=
d) - INT_MISC.UOP_DROPPING / slots) * (ICACHE_DATA.STALLS / CPU_CLK_UNHALTE=
D.THREAD) / (ICACHE_DATA.STALLS / CPU_CLK_UNHALTED.THREAD + ICACHE_TAG.STAL=
LS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNH=
ALTED.THREAD + INT_MISC.UNKNOWN_BRANCH_CYCLES / CPU_CLK_UNHALTED.THREAD) + =
min(3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge\\=3D0x1@ / (UOPS_RETIRED=
SLOTS / UOPS_ISSUED.ANY) / CPU_CLK_UNHALTED.THREAD, 1) + DECODE.LCP / CPU_=
CLK_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_CLK_UNHALTED.T=
HREAD)))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_botlnk_ic_misses",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
         "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
@@ -716,61 +768,98 @@
         "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
         "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
     },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the baseline operations not covered by Branching_Overhead nor Irregular_O=
verhead.",
+        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + BR_INST_RETIRED.NEAR_CALL) / tma_info_thread_slots - tma_microcode_seque=
ncer / (tma_few_uops_instructions + tma_microcode_sequencer) * (tma_assists=
 / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Ret",
+        "MetricName": "tma_info_bottleneck_base_non_br",
+        "MetricThreshold": "tma_info_bottleneck_base_non_br > 20"
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
-        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
-        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_bottleneck_branching_overhead"
+        "MetricThreshold": "tma_info_bottleneck_big_code > 20"
     },
     {
         "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / tma_info_thread_slots)",
-        "MetricGroup": "Ret;tma_issueBC",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + BR_INST_RETI=
RED.NEAR_CALL) / tma_info_thread_slots)",
+        "MetricGroup": "Ret",
         "MetricName": "tma_info_bottleneck_branching_overhead",
-        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 10",
-        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_bottleneck_big_code"
+        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)=
) + tma_memory_bound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma=
_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_sq_full=
 / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq=
_full)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_l1_bound=
 + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_f=
b_full / (tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads =
+ tma_store_fwd_blk)))",
+        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
+        "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth > 2=
0",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) =
+ tma_memory_bound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l=
2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_l3_hit_la=
tency / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency + t=
ma_sq_full)) + tma_memory_bound * tma_l2_bound / (tma_dram_bound + tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound) + tma=
_memory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_=
bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_store_laten=
cy / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_lat=
ency + tma_streaming_stores)))",
+        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_info_bottleneck_cache_memory_latency",
+        "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 20"=
,
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
+    },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_amx_busy=
 + tma_divider + tma_ports_utilization + tma_serializing_operation) + tma_c=
ore_bound * tma_amx_busy / (tma_amx_busy + tma_divider + tma_ports_utilizat=
ion + tma_serializing_operation) + tma_core_bound * (tma_ports_utilization =
/ (tma_amx_busy + tma_divider + tma_ports_utilization + tma_serializing_ope=
ration)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_utili=
zed_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "Cor;tma_issueComp",
+        "MetricName": "tma_info_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_info_bottleneck_compute_bound_est > 20",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: "
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
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - I=
NST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetc=
h_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_resteers +=
 tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredicts)=
 / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_branches))=
 / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_m=
isses + tma_lcp + tma_ms_switches))) - tma_info_bottleneck_big_code",
         "MetricGroup": "Fed;FetchBW;Frontend",
         "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"
     },
     {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) =
+ tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_pmm_bound + tma_store_bound) * (tma_sq_full / (tma_contested_acces=
ses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_b=
ound + tma_store_bound) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma=
_lock_latency + tma_split_loads + tma_store_fwd_blk))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_bottleneck_memory_bandwidth",
-        "MetricThreshold": "tma_info_bottleneck_memory_bandwidth > 20",
-        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_system_d=
ram_bw_use, tma_mem_bandwidth, tma_sq_full"
+        "BriefDescription": "Total pipeline cost of irregular execution (e=
g",
+        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS_R=
ETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_switches + tma_bra=
nch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_other_=
mispredicts / tma_branch_mispredicts) / (tma_clears_resteers + tma_mispredi=
cts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma_dsb_swit=
ches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) + =
10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_mispredic=
ts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes / tma_ot=
her_nukes + tma_core_bound * (tma_serializing_operation + cpu@RS.EMPTY\\,um=
ask\\=3D1@ / tma_info_thread_clks * tma_ports_utilized_0) / (tma_amx_busy +=
 tma_divider + tma_ports_utilization + tma_serializing_operation) + tma_mic=
rocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * =
(tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Bad;Cor;Ret;tma_issueMS",
+        "MetricName": "tma_info_bottleneck_irregular_overhead",
+        "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
+        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches"
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_pmm_bound + tma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_dt=
lb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_=
blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + t=
ma_l3_bound + tma_pmm_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtl=
b_store + tma_false_sharing + tma_split_stores + tma_store_latency + tma_st=
reaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_memory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bo=
und + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tm=
a_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma=
_store_latency + tma_streaming_stores)))",
         "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_info_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store, tma_info_bottleneck_memory_synchronization"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + =
tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_pmm_bound + tma_store_bound) * (tma_l3_hit_latency / (tma_contested_=
accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_l2_b=
ound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_p=
mm_bound + tma_store_bound))",
-        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_bottleneck_memory_latency",
-        "MetricThreshold": "tma_info_bottleneck_memory_latency > 20",
-        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency"
+        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) *=
 tma_remote_cache / (tma_local_mem + tma_remote_cache + tma_remote_mem) + t=
ma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_pmm_bound + tma_store_bound) * (tma_contested_accesses + tma_data_sha=
ring) / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency + t=
ma_sq_full) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bou=
nd + tma_l3_bound + tma_pmm_bound + tma_store_bound) * tma_false_sharing / =
(tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency =
+ tma_streaming_stores - tma_store_latency)) + tma_machine_clears * (1 - tm=
a_other_nukes / tma_other_nukes))",
+        "MetricGroup": "Mem;Offcore;tma_issueTLB",
+        "MetricName": "tma_info_bottleneck_memory_synchronization",
+        "MetricThreshold": "tma_info_bottleneck_memory_synchronization > 1=
0",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_me=
mory_data_tlbs"
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
spec_branch_misprediction_cost, tma_mispredicts_resteers"
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
ry-related stalls."
+    },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
         "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
@@ -803,7 +892,7 @@
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "MetricExpr": "(CPU_CLK_UNHALTED.DISTRIBUTED if #SMT_on else tma_i=
nfo_thread_clks)",
         "MetricGroup": "SMT",
         "MetricName": "tma_info_core_core_clks"
     },
@@ -813,9 +902,15 @@
         "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
         "MetricName": "tma_info_core_coreipc"
     },
+    {
+        "BriefDescription": "uops Executed per Cycle",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / tma_info_thread_clks",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_core_epc"
+    },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + FP_ARITH_INST_RETIRED2.SCALAR_HALF + 2 * (FP_ARITH_INST_RETIRED.=
128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF) + 4 * cpu@=
FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * (FP_ARITH_=
INST_RETIRED2.128B_PACKED_HALF + cpu@FP_ARITH_INST_RETIRED.256B_PACKED_SING=
LE\\,umask\\=3D0x60@) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_=
ARITH_INST_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512B_P=
ACKED_HALF + 4 * AMX_OPS_RETIRED.BF16",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / t=
ma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc"
     },
@@ -827,8 +922,8 @@
         "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
     },
@@ -883,6 +978,13 @@
         "MetricGroup": "IcMiss",
         "MetricName": "tma_info_frontend_l2mpki_code_all"
     },
+    {
+        "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / cpu@INT_MISC.UNKNO=
WN_BRANCH_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_unknown_branch_cost",
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node."
+    },
     {
         "BriefDescription": "Branch instructions per taken branch.",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
@@ -898,27 +1000,11 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + FP_ARITH_INST_RETIRED2.SCALAR + (cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0x3c@ + FP_ARITH_INST_RETIRED2.=
VECTOR))",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
FP_ARITH_INST_RETIRED2.SCALAR + (cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUB=
LE\\,umask\\=3D0xfc@ + FP_ARITH_INST_RETIRED2.VECTOR))",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
-    },
-    {
-        "BriefDescription": "Instructions per FP Arithmetic AMX operation =
(lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.BF16",
-        "MetricGroup": "Flops;FpVector;InsType;Server",
-        "MetricName": "tma_info_inst_mix_iparith_amx_f16",
-        "MetricThreshold": "tma_info_inst_mix_iparith_amx_f16 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AMX operation=
 (lower number means higher occurrence rate). Operations factored per matri=
ces' sizes of the AMX instructions."
-    },
-    {
-        "BriefDescription": "Instructions per Integer Arithmetic AMX opera=
tion (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.INT8",
-        "MetricGroup": "InsType;IntVector;Server",
-        "MetricName": "tma_info_inst_mix_iparith_amx_int8",
-        "MetricThreshold": "tma_info_inst_mix_iparith_amx_int8 < 10",
-        "PublicDescription": "Instructions per Integer Arithmetic AMX oper=
ation (lower number means higher occurrence rate). Operations factored per =
matrices' sizes of the AMX instructions."
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
@@ -926,7 +1012,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
@@ -934,7 +1020,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
@@ -942,7 +1028,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx512",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
@@ -950,7 +1036,15 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Half-Pr=
ecision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED2.SCALAR",
+        "MetricGroup": "Flops;FpScalar;InsType;Server",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_hp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_hp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Half-P=
recision instruction (lower number means higher occurrence rate). Values < =
1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
@@ -958,7 +1052,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
@@ -976,7 +1070,7 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_flopc",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_=
FLOPS + 8 * FP_ARITH_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B=
_PACKED_SINGLE)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_ipflop",
         "MetricThreshold": "tma_info_inst_mix_ipflop < 10"
@@ -988,6 +1082,12 @@
         "MetricName": "tma_info_inst_mix_ipload",
         "MetricThreshold": "tma_info_inst_mix_ipload < 3"
     },
+    {
+        "BriefDescription": "Instructions per PAUSE (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / CPU_CLK_UNHALTED.P=
AUSE_INST",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_inst_mix_ippause"
+    },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
@@ -1010,17 +1110,31 @@
         "MetricThreshold": "tma_info_inst_mix_iptb < 13",
         "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_lcp"
     },
+    {
+        "BriefDescription": "\"Bus lock\" per kilo instruction",
+        "MetricExpr": "tma_info_memory_mix_bus_lock_pki",
+        "MetricGroup": "Mem;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_bus_lock_pki",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "tma_info_memory_tlb_code_stlb_mpki",
+        "MetricGroup": "Fed;MemoryTLB;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_code_stlb_mpki",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
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
         "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
@@ -1036,76 +1150,231 @@
     },
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricExpr": "tma_info_memory_l3_cache_access_bw",
         "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_memory_core_l3_cache_access_bw"
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw_2t"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricExpr": "tma_info_memory_l3_cache_fill_bw",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_core_l3_cache_fill_bw"
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw_2t"
+    },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "tma_info_memory_latency_data_l2_mlp",
+        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_data_l2_mlp",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_fb_hpki"
     },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
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
+    },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l1mpki"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l1mpki_load"
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
+    {
+        "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
+        "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
+        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
+        "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
+        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_l2_evictions_silent_pki",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
         "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2hpki_all"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2hpki_load"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Backend;CacheMisses;Mem",
+        "MetricGroup": "Backend;CacheHits;Mem",
         "MetricName": "tma_info_memory_l2mpki"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem;Offcore",
+        "MetricGroup": "CacheHits;Mem;Offcore",
         "MetricName": "tma_info_memory_l2mpki_all"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2mpki_load"
     },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_l3_cache_access_bw"
+    },
+    {
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / (duratio=
n_time * 1e3 / 1e3)",
+        "MetricGroup": "Mem;MemoryBW;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_l3_cache_access_bw_2t",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / (duration_time =
* 1e3 / 1e3)",
+        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
+        "MetricGroup": "Mem",
         "MetricName": "tma_info_memory_l3mpki"
     },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD / OFFCORE_REQU=
ESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_latency_data_l2_mlp"
+    },
+    {
+        "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
+        "MetricExpr": "tma_info_memory_load_l2_miss_latency",
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l2_miss_latency"
+    },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss demand Loads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l2_mlp"
+    },
+    {
+        "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
+        "MetricExpr": "tma_info_memory_load_l3_miss_latency",
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l3_miss_latency"
+    },
+    {
+        "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
+        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_load_l2_miss_latency",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss demand Loads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
+        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_load_l2_mlp",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD=
 / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_load_l3_miss_latency",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_=
ANY",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
         "MetricName": "tma_info_memory_load_miss_real_latency"
     },
+    {
+        "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
+        "MetricExpr": "tma_info_memory_tlb_load_stlb_mpki",
+        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_load_stlb_mpki",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "\"Bus lock\" per kilo instruction",
+        "MetricExpr": "1e3 * SQ_MISC.BUS_LOCK / INST_RETIRED.ANY",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_mix_bus_lock_pki"
+    },
+    {
+        "BriefDescription": "Off-core accesses per kilo instruction for mo=
dified write requests",
+        "MetricExpr": "1e3 * OCR.MODIFIED_WRITE.ANY_RESPONSE / tma_info_in=
st_mix_instructions",
+        "MetricGroup": "Offcore",
+        "MetricName": "tma_info_memory_mix_offcore_mwrite_any_pki"
+    },
+    {
+        "BriefDescription": "Off-core accesses per kilo instruction for re=
ads-to-core requests (speculative; including in-core HW prefetches)",
+        "MetricExpr": "1e3 * OCR.READS_TO_CORE.ANY_RESPONSE / tma_info_ins=
t_mix_instructions",
+        "MetricGroup": "CacheHits;Offcore",
+        "MetricName": "tma_info_memory_mix_offcore_read_any_pki"
+    },
+    {
+        "BriefDescription": "L3 cache misses per kilo instruction for read=
s-to-core requests (speculative; including in-core HW prefetches)",
+        "MetricExpr": "1e3 * OCR.READS_TO_CORE.L3_MISS / tma_info_inst_mix=
_instructions",
+        "MetricGroup": "Offcore",
+        "MetricName": "tma_info_memory_mix_offcore_read_l3m_pki"
+    },
+    {
+        "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
+        "MetricExpr": "tma_info_memory_uc_load_pki",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_mix_uc_load_pki"
+    },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
@@ -1114,52 +1383,84 @@
         "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
     },
     {
-        "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_memory_oro_data_l2_mlp"
+        "BriefDescription": "Off-core accesses per kilo instruction for mo=
dified write requests",
+        "MetricExpr": "1e3 * OCR.MODIFIED_WRITE.ANY_RESPONSE / INST_RETIRE=
D.ANY",
+        "MetricGroup": "Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_offcore_mwrite_any_pki",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
-        "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_memory_oro_load_l2_miss_latency"
+        "BriefDescription": "Off-core accesses per kilo instruction for re=
ads-to-core requests (speculative; including in-core HW prefetches)",
+        "MetricExpr": "1e3 * OCR.READS_TO_CORE.ANY_RESPONSE / INST_RETIRED=
ANY",
+        "MetricGroup": "CacheHits;Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_offcore_read_any_pki",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
-        "BriefDescription": "Average Parallel L2 cache miss demand Loads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_memory_oro_load_l2_mlp"
+        "BriefDescription": "L3 cache misses per kilo instruction for read=
s-to-core requests (speculative; including in-core HW prefetches)",
+        "MetricExpr": "1e3 * OCR.READS_TO_CORE.L3_MISS / INST_RETIRED.ANY"=
,
+        "MetricGroup": "Offcore;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_offcore_read_l3m_pki",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
-        "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD=
 / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_memory_oro_load_l3_miss_latency"
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * (CPU_CLK_UNHALTED.DISTRIBUT=
ED if #SMT_on else CPU_CLK_UNHALTED.THREAD))",
+        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_page_walks_utilization",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t"
+        "BriefDescription": "Average DRAM BW for Reads-to-Core (R2C) cover=
ing for memory attached to local- and remote-socket",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.DRAM / 1e9 / (duration_time =
* 1e3 / 1e3)",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_r2c_dram_bw",
+        "MetricgroupNoGroup": "TopdownL1",
+        "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW."
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t"
+        "BriefDescription": "Average L3-cache miss BW for Reads-to-Core (R=
2C)",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.L3_MISS / 1e9 / (duration_ti=
me * 1e3 / 1e3)",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_r2c_l3m_bw",
+        "MetricgroupNoGroup": "TopdownL1",
+        "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW."
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l3_cache_access_bw",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t"
+        "BriefDescription": "Average Off-core access BW for Reads-to-Core =
(R2C)",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.ANY_RESPONSE / 1e9 / (durati=
on_time * 1e3 / 1e3)",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_r2c_offcore_bw",
+        "MetricgroupNoGroup": "TopdownL1",
+        "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches."
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t"
+        "BriefDescription": "Average DRAM BW for Reads-to-Core (R2C) cover=
ing for memory attached to local- and remote-socket",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.DRAM / 1e9 / duration_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_memory_soc_r2c_dram_bw",
+        "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW."
+    },
+    {
+        "BriefDescription": "Average L3-cache miss BW for Reads-to-Core (R=
2C)",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.L3_MISS / 1e9 / duration_tim=
e",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_memory_soc_r2c_l3m_bw",
+        "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW."
+    },
+    {
+        "BriefDescription": "Average Off-core access BW for Reads-to-Core =
(R2C)",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.ANY_RESPONSE / 1e9 / duratio=
n_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_memory_soc_r2c_offcore_bw",
+        "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches."
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "tma_info_memory_tlb_store_stlb_mpki",
+        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_store_stlb_mpki",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
@@ -1187,15 +1488,22 @@
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
+        "MetricExpr": "1e3 * MEM_LOAD_MISC_RETIRED.UC / INST_RETIRED.ANY",
+        "MetricGroup": "Mem;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_memory_uc_load_pki",
+        "MetricgroupNoGroup": "TopdownL1"
+    },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
     },
     {
         "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
-        "MetricExpr": "INST_RETIRED.ANY / cpu@ASSISTS.ANY\\,umask\\=3D0x1B=
@",
-        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricExpr": "INST_RETIRED.ANY / ASSISTS.ANY",
+        "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
         "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)"
@@ -1209,41 +1517,62 @@
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
         "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
+        "MetricGroup": "MicroSeq;Pipeline;Ret",
         "MetricName": "tma_info_pipeline_strings_cycles",
         "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "BriefDescription": "Fraction of cycles the processor is waiting y=
et unhalted; covering legacy PAUSE instruction, as well as C0.1 / C0.2 powe=
r-performance optimized states",
+        "MetricExpr": "CPU_CLK_UNHALTED.C0_WAIT / tma_info_thread_clks",
+        "MetricGroup": "C0Wait",
+        "MetricName": "tma_info_system_c0_wait",
+        "MetricThreshold": "tma_info_system_c0_wait > 0.05"
+    },
+    {
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
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_memory_bandwidth, tma_mem_bandwidth, tma_sq_full"
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_cache_memory_bandwidth, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "tma_info_core_flopc / duration_time",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / 1=
e9 / duration_time",
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
-        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e9 / durati=
on_time",
-        "MetricGroup": "IoBW;Mem;Server;SoC",
-        "MetricName": "tma_info_system_io_write_bw"
+        "MetricGroup": "IoBW;MemOffcore;Server;SoC",
+        "MetricName": "tma_info_system_io_read_bw",
+        "PublicDescription": "Average IO (network or disk) Bandwidth Use f=
or Reads [GB / sec]. Bandwidth of IO reads that are initiated by end device=
 controllers that are requesting memory from the CPU"
+    },
+    {
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERTS.=
IO_ITOMCACHENEAR) * 64 / 1e9 / duration_time",
+        "MetricGroup": "IoBW;MemOffcore;Server;SoC",
+        "MetricName": "tma_info_system_io_write_bw",
+        "PublicDescription": "Average IO (network or disk) Bandwidth Use f=
or Writes [GB / sec]. Bandwidth of IO writes that are initiated by end devi=
ce controllers that are writing memory to the CPU"
     },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
@@ -1268,7 +1597,7 @@
     {
         "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]",
         "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / uncore_cha_0@event\\=3D0x1@",
-        "MetricGroup": "Mem;MemoryLat;Server;SoC",
+        "MetricGroup": "MemOffcore;MemoryLat;Server;SoC",
         "MetricName": "tma_info_system_mem_dram_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
     },
@@ -1282,7 +1611,7 @@
     {
         "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]",
         "MetricExpr": "(1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC=
_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / uncore_cha_0@event\\=3D0x1@ if #has_pme=
m > 0 else 0)",
-        "MetricGroup": "Mem;MemoryLat;Server;SoC",
+        "MetricGroup": "MemOffcore;MemoryLat;Server;SoC",
         "MetricName": "tma_info_system_mem_pmm_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L=
2 data-read prefetches"
     },
@@ -1297,13 +1626,13 @@
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
         "MetricExpr": "(64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
-        "MetricGroup": "Mem;MemoryBW;Server;SoC",
+        "MetricGroup": "MemOffcore;MemoryBW;Server;SoC",
         "MetricName": "tma_info_system_pmm_read_bw"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
         "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
-        "MetricGroup": "Mem;MemoryBW;Server;SoC",
+        "MetricGroup": "MemOffcore;MemoryBW;Server;SoC",
         "MetricName": "tma_info_system_pmm_write_bw"
     },
     {
@@ -1318,18 +1647,18 @@
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_socket_clks"
     },
-    {
-        "BriefDescription": "Tera Integer (matrix) Operations Per Second",
-        "MetricExpr": "8 * AMX_OPS_RETIRED.INT8 / 1e12 / duration_time",
-        "MetricGroup": "Cor;HPC;IntVector;Server",
-        "MetricName": "tma_info_system_tiops"
-    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
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
         "BriefDescription": "Cross-socket Ultra Path Interconnect (UPI) da=
ta transmit bandwidth for data only [MB / sec]",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 64 / 9 / 1e6",
@@ -1387,18 +1716,9 @@
         "MetricName": "tma_info_thread_uptb",
         "MetricThreshold": "tma_info_thread_uptb < 9"
     },
-    {
-        "BriefDescription": "This metric approximates arithmetic Integer (=
Int) matrix uops fraction the CPU has retired (aggregated across all suppor=
ted Int datatypes in AMX engine)",
-        "MetricExpr": "cpu@AMX_OPS_RETIRED.INT8\\,cmask\\=3D1@ / (tma_reti=
ring * tma_info_thread_slots)",
-        "MetricGroup": "Compute;HPC;IntVector;Pipeline;Server;TopdownL4;tm=
a_L4_group;tma_int_operations_group",
-        "MetricName": "tma_int_amx",
-        "MetricThreshold": "tma_int_amx > 0.1 & (tma_int_operations > 0.1 =
& tma_light_operations > 0.6)",
-        "PublicDescription": "This metric approximates arithmetic Integer =
(Int) matrix uops fraction the CPU has retired (aggregated across all suppo=
rted Int datatypes in AMX engine). Refer to AMX_Busy and TIOPs metrics for =
actual AMX utilization and Int performance, resp.",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
-        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b + tma_shu=
ffles + tma_int_amx",
+        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_int_operations",
         "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
@@ -1415,18 +1735,18 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
+        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fraction=
 the CPU has retired",
         "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * tma_info_thread_slots)",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
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
@@ -1435,7 +1755,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
         "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
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
@@ -1444,7 +1764,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / tma_info_thread_clks",
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
@@ -1453,19 +1773,19 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
         "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "33 * tma_info_system_average_frequency * MEM_LOAD_R=
ETIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2=
) / tma_info_thread_clks",
+        "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
+        "MetricExpr": "33 * tma_info_system_core_frequency * (MEM_LOAD_RET=
IRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2))=
 / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1485,7 +1805,7 @@
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2;Default",
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
@@ -1515,10 +1835,10 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "71 * tma_info_system_average_frequency * MEM_LOAD_L=
3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED=
L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "71 * tma_info_system_core_frequency * MEM_LOAD_L3_M=
ISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1=
_MISS / 2) / tma_info_thread_clks",
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
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM_PS",
         "ScaleUnit": "100%"
     },
@@ -1551,21 +1871,21 @@
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
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
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
_info_bottleneck_memory_latency, tma_l3_hit_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_info_bottleneck_cache_memory_latency, tma_l3_hit_la=
tency",
         "ScaleUnit": "100%"
     },
     {
@@ -1583,9 +1903,9 @@
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1602,7 +1922,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1619,32 +1939,32 @@
         "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_in=
fo_core_core_clks / 2",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
         "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ / (tm=
a_retiring * tma_info_thread_slots / UOPS_ISSUED.ANY) / tma_info_thread_clk=
s",
+        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ / (UO=
PS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
         "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - INST_RETIRED.MACRO_FUSED) / (tma_retiring * tma_info_thread_slots)",
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
@@ -1653,21 +1973,37 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
         "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_thread_slots)",
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
         "ScaleUnit": "100%"
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
         "PublicDescription": "This metric represents the remaining light u=
ops fraction the CPU has executed - remaining means not covered by other si=
bling nodes. May undercount due to FMA double counting",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
+        "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_other_mispredicts",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
+        "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
+        "MetricGroup": "Machine_Clears;TopdownL3;tma_L3_group;tma_machine_=
clears_group",
+        "MetricName": "tma_other_nukes",
+        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
         "MetricExpr": "99 * ASSISTS.PAGE_FAULT / tma_info_thread_slots",
@@ -1679,7 +2015,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
-        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LO=
AD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_L=
OAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_pmem > 0 else 0) + 33 * (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) if #has_pmem > 0 else 0))) if #has_pmem > 0 else 0)) * (MEMOR=
Y_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clks) if 1e6 * (MEM_LOAD_L3_MIS=
S_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOAD_RETIRED.L1_MI=
SS else 0) if #has_pmem > 0 else 0)",
+        "MetricExpr": "(((1 - (19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM =
* (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LOA=
D_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM *=
 (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD=
_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMO=
TE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 33 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE=
_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) * (MEMO=
RY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clks) if 1e6 * (MEM_LOAD_L3_MI=
SS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOAD_RETIRED.L1_M=
ISS else 0) if #has_pmem > 0 else 0)",
         "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
         "MetricName": "tma_pmm_bound",
         "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1705,17 +2041,17 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simple=
 ALU)",
         "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_core_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ +=
 tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BO=
UND_ON_LOADS) + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu@EXE_ACTIVIT=
Y.2_PORTS_UTIL\\,umask\\=3D0xc@)) / tma_info_thread_clks if ARITH.DIV_ACTIV=
E < CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS else (EXE_ACT=
IVITY.1_PORTS_UTIL + tma_retiring * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=
=3D0xc@) / tma_info_thread_clks)",
+        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\,um=
ask\\=3D0xc@)) / tma_info_thread_clks if ARITH.DIV_ACTIVE < CYCLE_ACTIVITY.=
STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_UTIL =
+ tma_retiring * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / tma_info=
_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -1724,7 +2060,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / t=
ma_info_thread_clks + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TO=
TAL - EXE_ACTIVITY.BOUND_ON_LOADS) / tma_info_thread_clks",
+        "MetricExpr": "(cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ + =
cpu@RS.EMPTY\\,umask\\=3D1@) / tma_info_thread_clks * (CYCLE_ACTIVITY.STALL=
S_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1756,13 +2092,13 @@
         "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
-        "MetricExpr": "(135.5 * tma_info_system_average_frequency * MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_HITM + 135.5 * tma_info_system_average_frequency =
* MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(135.5 * tma_info_system_core_frequency * MEM_LOAD_=
L3_MISS_RETIRED.REMOTE_HITM + 135.5 * tma_info_system_core_frequency * MEM_=
LOAD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_=
RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
         "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
@@ -1771,10 +2107,10 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "149 * tma_info_system_average_frequency * MEM_LOAD_=
L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "149 * tma_info_system_core_frequency * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
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
 with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS",
         "ScaleUnit": "100%"
     },
@@ -1791,28 +2127,29 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks",
-        "MetricGroup": "PortsUtil;TopdownL5;tma_L5_group;tma_issueSO;tma_p=
orts_utilized_0_group",
+        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks +=
 tma_c02_wait",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Shuffle (cross \"vecto=
r lane\" data transfers) uops fraction the CPU has retired.",
-        "MetricExpr": "INT_VEC_RETIRED.SHUFFLES / (tma_retiring * tma_info=
_thread_slots)",
-        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_int_operat=
ions_group",
-        "MetricName": "tma_shuffles",
-        "MetricThreshold": "tma_shuffles > 0.1 & (tma_int_operations > 0.1=
 & tma_light_operations > 0.6)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring Shuffle operations of 256-bit vector size (FP or Int=
eger)",
+        "MetricExpr": "tma_light_operations * INT_VEC_RETIRED.SHUFFLES / (=
tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_ligh=
t_ops_group",
+        "MetricName": "tma_shuffles_256b",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & (tma_other_light_ops=
 > 0.3 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
@@ -1840,7 +2177,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1907,10 +2244,10 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
         "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_thread_cl=
ks",
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
         "ScaleUnit": "100%"
     },
     {
--=20
2.43.0.687.g38aa6559b0-goog


