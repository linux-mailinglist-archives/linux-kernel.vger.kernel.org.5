Return-Path: <linux-kernel+bounces-109679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78BC881C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667F72818ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639A73F8D6;
	Thu, 21 Mar 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="StKOGDH3"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E877F21
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000858; cv=none; b=BVNrwQWQH7Lod5E1BI7u33erq7219l9l2MAfTEEv8n5FV2aOjzgmLnftIHj8wsnF5wgFE3x2+bcQN7E6Bu+q71RXoCj/OPLgjq8CRufJ+qz29fIUDWp+p8z87pf0wzfjW+I6KoZoeJwZybqtl/LWRQYWRUQEYl7JohjmtpsdW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000858; c=relaxed/simple;
	bh=3nn5y+8XdDJmH3RXSINpW7+b19bFmPx0CBUYkYxjovc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KGCzaagxMyo0T7d0+pEaom2Wwlr10P2cruqkV2paYbE6BvIHjqgt+k0C0Z9Jr5t3C0WTShQSI8HGv8VGZDyGOGUdD5pQupBWv92O+0pAoQuV0x3bW4dAzNrJrYhy5LebLTsZBPN1jl/23MlxgD2xSyaLQDr85PErsfKRZCzykfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StKOGDH3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a55cd262aso10355067b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000853; x=1711605653; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZD0xcXjwyyCXXNFMU4Pcp7UhP1iXWjjU857afMrCzHk=;
        b=StKOGDH3mtDHJguKwF0khj4vD1wVCN5rFcXDqdsJYeKt3djt++3rVbKMQr06zBhyZt
         iQWRzIbbFk36ntRH1YwdgHDekMcrNgocfIudcjvyufouq9QVRXWtpnzNR6Av9dirk3et
         +MDHsLF7Mb6+wOj+n4hbYOrp4zJk4UXG8d2fLwBj7VOb5Eu7DXcbSMbkaz6hqkuxuB64
         cZ1I1+eEyACsX8xHD999eCNXcHnOPAIFitsGf/0ggeDj3+JtbYE5bqDdzTd0kirtMaat
         BfpfJTi7p2HacKD4rSttrI0Qkxr/CFocswthPLpQE4bmlc86aY2bll1jrh6f+VVj/QpW
         WxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000853; x=1711605653;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZD0xcXjwyyCXXNFMU4Pcp7UhP1iXWjjU857afMrCzHk=;
        b=R5kIhKpG5JkLPtJDbklD5pPo1bpXCAmaU40tCrzwxQ0wAo8vGaTDW/U+yCfZlAnTLW
         t9vkGH/rfzBSu0S35WlhZ0Dki+SLBvwGpuC2dkTJ05+gPxOF1Yunr5F4mkC2C6fCfuJw
         uroog3Cv5Eyzlsh2s+RgsP4qIGsJKra2zg/8Ldvd2f4te8EzVBAW2PLNH823ReOrHxJR
         3pjAGU/A6dBaXRzUiZYa6n+pIRH8mx4ul7PnIzMj+0TAijgw5k0B3aYXhS+PY9WH5Etu
         9e2KCksTH0kjuH/4GB4QH+d+rDdIZzuiXcP3YOxNCcJKOJoHvSURF1oRnIEM9jurUHX/
         PYSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6G5RSXPbjlLRfhHqqDBdVOlee44UGFwzC+scYH29NNkPnNPB3MF1c6CybHaYAA1LSWNZgnYlg8JqfgRRjXMG++KGqmj6OmDwSreZk
X-Gm-Message-State: AOJu0YxMBvdml2GZEE9TxIOiZ9IpLas4ZXKwMrJMnuhL66HNbLgftoL5
	G4MsNJqHpGoGtFJdGqkp4ofjLZkP55fEmlAZAFh/I25F7ceHIL1P106/g8xogt1WGgNxdnyazmU
	rf0nAmA==
X-Google-Smtp-Source: AGHT+IGfQsjwN50QAy4WPPapnwGkuqrR5ev8C5YAmc8qAFa1repG49+XrDJKlB3bxHWHr3cYan8yy8ezZKzQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2848:b0:dcd:b431:7f5b with SMTP
 id ee8-20020a056902284800b00dcdb4317f5bmr2015658ybb.0.1711000853014; Wed, 20
 Mar 2024 23:00:53 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:16 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 12/12] perf vendor events intel: Remove info metrics
 erroneously in TopdownL1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bug affected server metrics only. This doesn't impact default metrics
but if the TopdownL1 metric group is specified. Passes on the fix in:
https://github.com/intel/perfmon/commit/b09f0a3953234ec592b4a872b87764c78da=
05d8b

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellx/bdx-metrics.json      |  35 +++---
 .../arch/x86/cascadelakex/clx-metrics.json    |  85 +++++--------
 .../arch/x86/haswellx/hsx-metrics.json        |  35 +++---
 .../arch/x86/icelakex/icx-metrics.json        |  95 ++++++--------
 .../arch/x86/sapphirerapids/spr-metrics.json  | 119 +++++++-----------
 .../arch/x86/skylakex/skx-metrics.json        |  85 +++++--------
 6 files changed, 181 insertions(+), 273 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index f2d378c9d68f..0aed533da882 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -732,9 +732,8 @@
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
         "MetricExpr": "tma_info_memory_latency_data_l2_mlp",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_data_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_data_l2_mlp"
     },
     {
         "BriefDescription": "",
@@ -745,9 +744,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
@@ -764,9 +762,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
@@ -807,9 +804,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / (duration_time =
* 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
@@ -838,16 +834,14 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_miss_latency",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_load_l2_mlp"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
@@ -867,9 +861,8 @@
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "tma_info_memory_tlb_page_walks_utilization",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_page_walks_utilization",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_page_walks_utilization"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b=
/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 7f88b156f73b..297046818efe 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -670,23 +670,20 @@
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
         "MetricExpr": "(100 * (1 - tma_core_bound / (((EXE_ACTIVITY.EXE_BO=
UND_0_PORTS + tma_core_bound * RS_EVENTS.EMPTY_CYCLES) / CPU_CLK_UNHALTED.T=
HREAD * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / CPU=
_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD + (EXE_ACTIVITY.1_PORTS_UTIL=
 + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD if =
ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_=
MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_POR=
TS_UTIL) / CPU_CLK_UNHALTED.THREAD) if tma_core_bound < (((EXE_ACTIVITY.EXE=
_BOUND_0_PORTS + tma_core_bound * RS_EVENTS.EMPTY_CYCLES) / CPU_CLK_UNHALTE=
D.THREAD * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / =
CPU_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD + (EXE_ACTIVITY.1_PORTS_U=
TIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD =
if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STAL=
LS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_=
PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) else 1) if tma_info_system_smt_2t_ut=
ilization > 0.5 else 0)",
-        "MetricGroup": "Cor;SMT;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_core_bound_likely",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_core_bound_likely"
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck.",
         "MetricExpr": "100 * (100 * (tma_fetch_latency * (DSB2MITE_SWITCHE=
S.PENALTY_CYCLES / CPU_CLK_UNHALTED.THREAD) / ((ICACHE_16B.IFDATA_STALL + 2=
 * cpu@ICACHE_16B.IFDATA_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@) / CPU_CLK_U=
NHALTED.THREAD + ICACHE_TAG.STALLS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CL=
EAR_RESTEER_CYCLES / CPU_CLK_UNHALTED.THREAD + 9 * BACLEARS.ANY / CPU_CLK_U=
NHALTED.THREAD) + min(2 * IDQ.MS_SWITCHES / CPU_CLK_UNHALTED.THREAD, 1) + D=
ECODE.LCP / CPU_CLK_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CP=
U_CLK_UNHALTED.THREAD) + tma_fetch_bandwidth * tma_mite / (tma_mite + tma_d=
sb)))",
-        "MetricGroup": "DSBmiss;Fed;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_dsb_misses",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_botlnk_dsb_misses"
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck.",
         "MetricExpr": "100 * (100 * (tma_fetch_latency * ((ICACHE_16B.IFDA=
TA_STALL + 2 * cpu@ICACHE_16B.IFDATA_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@)=
 / CPU_CLK_UNHALTED.THREAD) / ((ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16=
B.IFDATA_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@) / CPU_CLK_UNHALTED.THREAD +=
 ICACHE_TAG.STALLS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CLEAR_RESTEER_CYCL=
ES / CPU_CLK_UNHALTED.THREAD + 9 * BACLEARS.ANY / CPU_CLK_UNHALTED.THREAD) =
+ min(2 * IDQ.MS_SWITCHES / CPU_CLK_UNHALTED.THREAD, 1) + DECODE.LCP / CPU_=
CLK_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_CLK_UNHALTED.T=
HREAD)))",
-        "MetricGroup": "Fed;FetchLat;IcMiss;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_ic_misses",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_botlnk_ic_misses"
     },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
@@ -1045,9 +1042,8 @@
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
         "MetricExpr": "tma_info_memory_tlb_code_stlb_mpki",
-        "MetricGroup": "Fed;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_code_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_code_stlb_mpki"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
@@ -1088,9 +1084,8 @@
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
         "MetricExpr": "tma_info_memory_latency_data_l2_mlp",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_data_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_data_l2_mlp"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
@@ -1107,9 +1102,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
@@ -1132,23 +1126,20 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
         "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki"
     },
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
         "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_evictions_silent_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_l2_evictions_silent_pki"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
@@ -1189,9 +1180,8 @@
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
         "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / (duratio=
n_time * 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_access_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_l3_cache_access_bw_2t"
     },
     {
         "BriefDescription": "",
@@ -1202,9 +1192,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / (duration_time =
* 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
@@ -1233,16 +1222,14 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_miss_latency",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_load_l2_mlp"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
@@ -1253,9 +1240,8 @@
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "tma_info_memory_tlb_load_stlb_mpki",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_load_stlb_mpki"
     },
     {
         "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
@@ -1273,16 +1259,14 @@
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "tma_info_memory_tlb_page_walks_utilization",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_page_walks_utilization",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_page_walks_utilization"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
         "MetricExpr": "tma_info_memory_tlb_store_stlb_mpki",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_store_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_store_stlb_mpki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
@@ -1313,9 +1297,8 @@
     {
         "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
         "MetricExpr": "1e3 * MEM_LOAD_MISC_RETIRED.UC / INST_RETIRED.ANY",
-        "MetricGroup": "Mem;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_uc_load_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_uc_load_pki"
     },
     {
         "BriefDescription": "",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 21e2cb5e3178..83d50d80a148 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -618,9 +618,8 @@
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
         "MetricExpr": "tma_info_memory_latency_data_l2_mlp",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_data_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_data_l2_mlp"
     },
     {
         "BriefDescription": "",
@@ -631,9 +630,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
@@ -650,9 +648,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
@@ -669,9 +666,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / (duration_time =
* 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
@@ -700,16 +696,14 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_miss_latency",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_load_l2_mlp"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
@@ -729,9 +723,8 @@
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "tma_info_memory_tlb_page_walks_utilization",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_page_walks_utilization",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_page_walks_utilization"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index c015b8277dc7..769ba12bef87 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -667,23 +667,20 @@
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
         "MetricExpr": "(100 * (1 - max(0, topdown\\-be\\-bound / (topdown\=
\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-b=
ound) + 5 * INT_MISC.CLEARS_COUNT / slots - (CYCLE_ACTIVITY.STALLS_MEM_ANY =
+ EXE_ACTIVITY.BOUND_ON_STORES) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIV=
ITY.1_PORTS_UTIL + topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-b=
ad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * EXE_ACTIVITY.2_POR=
TS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES) * (topdown\\-be\\-bound / (topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound) + 5 * INT_MISC.CLEARS_COUNT / slots)) / (((cpu@EXE_ACTIVITY.3_PORTS_=
UTIL\\,umask\\=3D0x80@ + max(0, topdown\\-be\\-bound / (topdown\\-fe\\-boun=
d + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 *=
 INT_MISC.CLEARS_COUNT / slots - (CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS=
_UTIL + topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec +=
 topdown\\-retiring + topdown\\-be\\-bound) * EXE_ACTIVITY.2_PORTS_UTIL) + =
EXE_ACTIVITY.BOUND_ON_STORES) * (topdown\\-be\\-bound / (topdown\\-fe\\-bou=
nd + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 =
* INT_MISC.CLEARS_COUNT / slots)) * RS_EVENTS.EMPTY_CYCLES) / CPU_CLK_UNHAL=
TED.THREAD * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) =
/ CPU_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD + (EXE_ACTIVITY.1_PORTS=
_UTIL + topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec +=
 topdown\\-retiring + topdown\\-be\\-bound) * EXE_ACTIVITY.2_PORTS_UTIL)) /=
 CPU_CLK_UNHALTED.THREAD if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TO=
TAL - CYCLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + topdo=
wn\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-re=
tiring + topdown\\-be\\-bound) * EXE_ACTIVITY.2_PORTS_UTIL) / CPU_CLK_UNHAL=
TED.THREAD) if max(0, topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * INT_MISC.=
CLEARS_COUNT / slots - (CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_=
ON_STORES) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + to=
pdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\=
-retiring + topdown\\-be\\-bound) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVI=
TY.BOUND_ON_STORES) * (topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdo=
wn\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * INT_MISC=
CLEARS_COUNT / slots)) < (((cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80=
@ + max(0, topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-s=
pec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * INT_MISC.CLEARS_COUN=
T / slots - (CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES) =
/ (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + topdown\\-ret=
iring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring +=
 topdown\\-be\\-bound) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON=
_STORES) * (topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-=
spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * INT_MISC.CLEARS_COU=
NT / slots)) * RS_EVENTS.EMPTY_CYCLES) / CPU_CLK_UNHALTED.THREAD * (CYCLE_A=
CTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / CPU_CLK_UNHALTED.TH=
READ * CPU_CLK_UNHALTED.THREAD + (EXE_ACTIVITY.1_PORTS_UTIL + topdown\\-ret=
iring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring +=
 topdown\\-be\\-bound) * EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THR=
EAD if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.=
STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + topdown\\-retiring / (topd=
own\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be=
\\-bound) * EXE_ACTIVITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) else 1) i=
f tma_info_system_smt_2t_utilization > 0.5 else 0)",
-        "MetricGroup": "Cor;SMT;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_core_bound_likely",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_core_bound_likely"
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck.",
         "MetricExpr": "100 * (100 * ((5 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_=
UOPS_DELIV.CORE - INT_MISC.UOP_DROPPING) / slots * (DSB2MITE_SWITCHES.PENAL=
TY_CYCLES / CPU_CLK_UNHALTED.THREAD) / (ICACHE_DATA.STALLS / CPU_CLK_UNHALT=
ED.THREAD + ICACHE_TAG.STALLS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CLEAR_R=
ESTEER_CYCLES / CPU_CLK_UNHALTED.THREAD + 10 * BACLEARS.ANY / CPU_CLK_UNHAL=
TED.THREAD) + min(3 * IDQ.MS_SWITCHES / CPU_CLK_UNHALTED.THREAD, 1) + DECOD=
E.LCP / CPU_CLK_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_CL=
K_UNHALTED.THREAD) + max(0, topdown\\-fe\\-bound / (topdown\\-fe\\-bound + =
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MIS=
C.UOP_DROPPING / slots - (5 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CO=
RE - INT_MISC.UOP_DROPPING) / slots) * ((IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYC=
LES_OK) / (CPU_CLK_UNHALTED.DISTRIBUTED if #SMT_on else CPU_CLK_UNHALTED.TH=
READ) / 2) / ((IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / (CPU_CLK_UNHALTE=
D.DISTRIBUTED if #SMT_on else CPU_CLK_UNHALTED.THREAD) / 2 + (IDQ.DSB_CYCLE=
S_ANY - IDQ.DSB_CYCLES_OK) / (CPU_CLK_UNHALTED.DISTRIBUTED if #SMT_on else =
CPU_CLK_UNHALTED.THREAD) / 2)))",
-        "MetricGroup": "DSBmiss;Fed;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_dsb_misses",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_botlnk_dsb_misses"
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck.",
         "MetricExpr": "100 * (100 * ((5 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_=
UOPS_DELIV.CORE - INT_MISC.UOP_DROPPING) / slots * (ICACHE_DATA.STALLS / CP=
U_CLK_UNHALTED.THREAD) / (ICACHE_DATA.STALLS / CPU_CLK_UNHALTED.THREAD + IC=
ACHE_TAG.STALLS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CLEAR_RESTEER_CYCLES =
/ CPU_CLK_UNHALTED.THREAD + 10 * BACLEARS.ANY / CPU_CLK_UNHALTED.THREAD) + =
min(3 * IDQ.MS_SWITCHES / CPU_CLK_UNHALTED.THREAD, 1) + DECODE.LCP / CPU_CL=
K_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_CLK_UNHALTED.THR=
EAD)))",
-        "MetricGroup": "Fed;FetchLat;IcMiss;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_ic_misses",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_botlnk_ic_misses"
     },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
@@ -1045,16 +1042,14 @@
     {
         "BriefDescription": "\"Bus lock\" per kilo instruction",
         "MetricExpr": "tma_info_memory_mix_bus_lock_pki",
-        "MetricGroup": "Mem;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_bus_lock_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_bus_lock_pki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
         "MetricExpr": "tma_info_memory_tlb_code_stlb_mpki",
-        "MetricGroup": "Fed;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_code_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_code_stlb_mpki"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
@@ -1095,9 +1090,8 @@
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
         "MetricExpr": "tma_info_memory_latency_data_l2_mlp",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_data_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_data_l2_mlp"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
@@ -1114,9 +1108,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
@@ -1139,23 +1132,20 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
         "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki"
     },
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
         "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_evictions_silent_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_l2_evictions_silent_pki"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
@@ -1190,9 +1180,8 @@
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
         "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / (duratio=
n_time * 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_access_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_l3_cache_access_bw_2t"
     },
     {
         "BriefDescription": "",
@@ -1203,9 +1192,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / (duration_time =
* 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
@@ -1240,23 +1228,20 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_miss_latency",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_load_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
         "MetricExpr": "cpu@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,u=
mask\\=3D0x10@ / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l3_miss_latency",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_load_l3_miss_latency"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
@@ -1267,9 +1252,8 @@
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "tma_info_memory_tlb_load_stlb_mpki",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_load_stlb_mpki"
     },
     {
         "BriefDescription": "\"Bus lock\" per kilo instruction",
@@ -1293,16 +1277,14 @@
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (2 * (CPU_CLK_UNHALTED.DISTRIBUT=
ED if #SMT_on else CPU_CLK_UNHALTED.THREAD))",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_page_walks_utilization",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_page_walks_utilization"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
         "MetricExpr": "tma_info_memory_tlb_store_stlb_mpki",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_store_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_store_stlb_mpki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
@@ -1332,9 +1314,8 @@
     {
         "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
         "MetricExpr": "1e3 * MEM_LOAD_MISC_RETIRED.UC / INST_RETIRED.ANY",
-        "MetricGroup": "Mem;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_uc_load_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_uc_load_pki"
     },
     {
         "BriefDescription": "",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 6f0e6360e989..f8c0eac8b828 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -727,23 +727,20 @@
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
         "MetricExpr": "(100 * (1 - max(0, topdown\\-be\\-bound / (topdown\=
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
-        "MetricGroup": "Cor;SMT;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_core_bound_likely",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_core_bound_likely"
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck.",
         "MetricExpr": "100 * (100 * ((topdown\\-fetch\\-lat / (topdown\\-f=
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
-        "MetricGroup": "DSBmiss;Fed;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_dsb_misses",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_botlnk_dsb_misses"
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck.",
         "MetricExpr": "100 * (100 * ((topdown\\-fetch\\-lat / (topdown\\-f=
e\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-boun=
d) - INT_MISC.UOP_DROPPING / slots) * (ICACHE_DATA.STALLS / CPU_CLK_UNHALTE=
D.THREAD) / (ICACHE_DATA.STALLS / CPU_CLK_UNHALTED.THREAD + ICACHE_TAG.STAL=
LS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNH=
ALTED.THREAD + INT_MISC.UNKNOWN_BRANCH_CYCLES / CPU_CLK_UNHALTED.THREAD) + =
min(3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge\\=3D0x1@ / (UOPS_RETIRED=
SLOTS / UOPS_ISSUED.ANY) / CPU_CLK_UNHALTED.THREAD, 1) + DECODE.LCP / CPU_=
CLK_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_CLK_UNHALTED.T=
HREAD)))",
-        "MetricGroup": "Fed;FetchLat;IcMiss;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_ic_misses",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_botlnk_ic_misses"
     },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
@@ -1113,16 +1110,14 @@
     {
         "BriefDescription": "\"Bus lock\" per kilo instruction",
         "MetricExpr": "tma_info_memory_mix_bus_lock_pki",
-        "MetricGroup": "Mem;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_bus_lock_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_bus_lock_pki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
         "MetricExpr": "tma_info_memory_tlb_code_stlb_mpki",
-        "MetricGroup": "Fed;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_code_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_code_stlb_mpki"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
@@ -1163,9 +1158,8 @@
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
         "MetricExpr": "tma_info_memory_latency_data_l2_mlp",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_data_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_data_l2_mlp"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
@@ -1182,9 +1176,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
@@ -1207,23 +1200,20 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
         "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki"
     },
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
         "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_evictions_silent_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_l2_evictions_silent_pki"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
@@ -1264,9 +1254,8 @@
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
         "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / (duratio=
n_time * 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_access_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_l3_cache_access_bw_2t"
     },
     {
         "BriefDescription": "",
@@ -1277,9 +1266,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / (duration_time =
* 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
@@ -1314,23 +1302,20 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_miss_latency",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_load_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD=
 / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l3_miss_latency",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_load_l3_miss_latency"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
@@ -1341,9 +1326,8 @@
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "tma_info_memory_tlb_load_stlb_mpki",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_load_stlb_mpki"
     },
     {
         "BriefDescription": "\"Bus lock\" per kilo instruction",
@@ -1385,53 +1369,46 @@
     {
         "BriefDescription": "Off-core accesses per kilo instruction for mo=
dified write requests",
         "MetricExpr": "1e3 * OCR.MODIFIED_WRITE.ANY_RESPONSE / INST_RETIRE=
D.ANY",
-        "MetricGroup": "Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_offcore_mwrite_any_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Offcore",
+        "MetricName": "tma_info_memory_offcore_mwrite_any_pki"
     },
     {
         "BriefDescription": "Off-core accesses per kilo instruction for re=
ads-to-core requests (speculative; including in-core HW prefetches)",
         "MetricExpr": "1e3 * OCR.READS_TO_CORE.ANY_RESPONSE / INST_RETIRED=
ANY",
-        "MetricGroup": "CacheHits;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_offcore_read_any_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "CacheHits;Offcore",
+        "MetricName": "tma_info_memory_offcore_read_any_pki"
     },
     {
         "BriefDescription": "L3 cache misses per kilo instruction for read=
s-to-core requests (speculative; including in-core HW prefetches)",
         "MetricExpr": "1e3 * OCR.READS_TO_CORE.L3_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_offcore_read_l3m_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Offcore",
+        "MetricName": "tma_info_memory_offcore_read_l3m_pki"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * (CPU_CLK_UNHALTED.DISTRIBUT=
ED if #SMT_on else CPU_CLK_UNHALTED.THREAD))",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_page_walks_utilization",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_page_walks_utilization"
     },
     {
         "BriefDescription": "Average DRAM BW for Reads-to-Core (R2C) cover=
ing for memory attached to local- and remote-socket",
         "MetricExpr": "64 * OCR.READS_TO_CORE.DRAM / 1e9 / (duration_time =
* 1e3 / 1e3)",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;TopdownL1;tma_L1_group",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_r2c_dram_bw",
-        "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW."
     },
     {
         "BriefDescription": "Average L3-cache miss BW for Reads-to-Core (R=
2C)",
         "MetricExpr": "64 * OCR.READS_TO_CORE.L3_MISS / 1e9 / (duration_ti=
me * 1e3 / 1e3)",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;TopdownL1;tma_L1_group",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_r2c_l3m_bw",
-        "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW."
     },
     {
         "BriefDescription": "Average Off-core access BW for Reads-to-Core =
(R2C)",
         "MetricExpr": "64 * OCR.READS_TO_CORE.ANY_RESPONSE / 1e9 / (durati=
on_time * 1e3 / 1e3)",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;TopdownL1;tma_L1_group",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_r2c_offcore_bw",
-        "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches."
     },
     {
@@ -1458,9 +1435,8 @@
     {
         "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
         "MetricExpr": "tma_info_memory_tlb_store_stlb_mpki",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_store_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_store_stlb_mpki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
@@ -1490,9 +1466,8 @@
     {
         "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
         "MetricExpr": "1e3 * MEM_LOAD_MISC_RETIRED.UC / INST_RETIRED.ANY",
-        "MetricGroup": "Mem;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_uc_load_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_uc_load_pki"
     },
     {
         "BriefDescription": "",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 025e836a1c80..8126f952a30c 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -652,23 +652,20 @@
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
         "MetricExpr": "(100 * (1 - tma_core_bound / (((EXE_ACTIVITY.EXE_BO=
UND_0_PORTS + tma_core_bound * RS_EVENTS.EMPTY_CYCLES) / CPU_CLK_UNHALTED.T=
HREAD * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / CPU=
_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD + (EXE_ACTIVITY.1_PORTS_UTIL=
 + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD if =
ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_=
MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_POR=
TS_UTIL) / CPU_CLK_UNHALTED.THREAD) if tma_core_bound < (((EXE_ACTIVITY.EXE=
_BOUND_0_PORTS + tma_core_bound * RS_EVENTS.EMPTY_CYCLES) / CPU_CLK_UNHALTE=
D.THREAD * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / =
CPU_CLK_UNHALTED.THREAD * CPU_CLK_UNHALTED.THREAD + (EXE_ACTIVITY.1_PORTS_U=
TIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD =
if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STAL=
LS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_=
PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) else 1) if tma_info_system_smt_2t_ut=
ilization > 0.5 else 0)",
-        "MetricGroup": "Cor;SMT;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_core_bound_likely",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_core_bound_likely"
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck.",
         "MetricExpr": "100 * (100 * (tma_fetch_latency * (DSB2MITE_SWITCHE=
S.PENALTY_CYCLES / CPU_CLK_UNHALTED.THREAD) / ((ICACHE_16B.IFDATA_STALL + 2=
 * cpu@ICACHE_16B.IFDATA_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@) / CPU_CLK_U=
NHALTED.THREAD + ICACHE_TAG.STALLS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CL=
EAR_RESTEER_CYCLES / CPU_CLK_UNHALTED.THREAD + 9 * BACLEARS.ANY / CPU_CLK_U=
NHALTED.THREAD) + min(2 * IDQ.MS_SWITCHES / CPU_CLK_UNHALTED.THREAD, 1) + D=
ECODE.LCP / CPU_CLK_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CP=
U_CLK_UNHALTED.THREAD) + tma_fetch_bandwidth * tma_mite / (tma_mite + tma_d=
sb)))",
-        "MetricGroup": "DSBmiss;Fed;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_dsb_misses",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_botlnk_dsb_misses"
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck.",
         "MetricExpr": "100 * (100 * (tma_fetch_latency * ((ICACHE_16B.IFDA=
TA_STALL + 2 * cpu@ICACHE_16B.IFDATA_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@)=
 / CPU_CLK_UNHALTED.THREAD) / ((ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16=
B.IFDATA_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@) / CPU_CLK_UNHALTED.THREAD +=
 ICACHE_TAG.STALLS / CPU_CLK_UNHALTED.THREAD + (INT_MISC.CLEAR_RESTEER_CYCL=
ES / CPU_CLK_UNHALTED.THREAD + 9 * BACLEARS.ANY / CPU_CLK_UNHALTED.THREAD) =
+ min(2 * IDQ.MS_SWITCHES / CPU_CLK_UNHALTED.THREAD, 1) + DECODE.LCP / CPU_=
CLK_UNHALTED.THREAD + DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_CLK_UNHALTED.T=
HREAD)))",
-        "MetricGroup": "Fed;FetchLat;IcMiss;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_botlnk_ic_misses",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_botlnk_ic_misses"
     },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
@@ -1021,9 +1018,8 @@
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
         "MetricExpr": "tma_info_memory_tlb_code_stlb_mpki",
-        "MetricGroup": "Fed;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_code_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_code_stlb_mpki"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
@@ -1064,9 +1060,8 @@
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
         "MetricExpr": "tma_info_memory_latency_data_l2_mlp",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_data_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_data_l2_mlp"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
@@ -1083,9 +1078,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
@@ -1108,23 +1102,20 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / (duration_time * 1e3 /=
 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
         "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_l2_evictions_nonsilent_pki"
     },
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
         "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "L2Evicts;Mem;Server;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l2_evictions_silent_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_l2_evictions_silent_pki"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
@@ -1165,9 +1156,8 @@
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
         "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / (duratio=
n_time * 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_access_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_l3_cache_access_bw_2t"
     },
     {
         "BriefDescription": "",
@@ -1178,9 +1168,8 @@
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / (duration_time =
* 1e3 / 1e3)",
-        "MetricGroup": "Mem;MemoryBW;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw_2t"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
@@ -1209,16 +1198,14 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_miss_latency",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_l2_mlp",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_load_l2_mlp"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
@@ -1229,9 +1216,8 @@
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "tma_info_memory_tlb_load_stlb_mpki",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_load_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_load_stlb_mpki"
     },
     {
         "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
@@ -1249,16 +1235,14 @@
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "tma_info_memory_tlb_page_walks_utilization",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_page_walks_utilization",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_page_walks_utilization"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
         "MetricExpr": "tma_info_memory_tlb_store_stlb_mpki",
-        "MetricGroup": "Mem;MemoryTLB;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_store_stlb_mpki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_store_stlb_mpki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
@@ -1289,9 +1273,8 @@
     {
         "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
         "MetricExpr": "1e3 * MEM_LOAD_MISC_RETIRED.UC / INST_RETIRED.ANY",
-        "MetricGroup": "Mem;TopdownL1;tma_L1_group",
-        "MetricName": "tma_info_memory_uc_load_pki",
-        "MetricgroupNoGroup": "TopdownL1"
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_uc_load_pki"
     },
     {
         "BriefDescription": "",
--=20
2.44.0.396.g6e790dbe36-goog


