Return-Path: <linux-kernel+bounces-109672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C114881C41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BBEB21B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C29481AB;
	Thu, 21 Mar 2024 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gdDVC9uS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C638F99
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000838; cv=none; b=ey5BoNKQMs/gLl0xCd9W73IW4ztUMmKVe7Z1IYEZliZFrg0WsWpp7dWUVp2EZM8KWJHKHPgwQY7brUUz26xbtmUGxIse8v4HoYxt3xNpY8Jk4imfecWt1K1rsgqtMfKtakLeBfMTj19J03lxwEQScsszA3g3ZbCJ+bwpkp3lGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000838; c=relaxed/simple;
	bh=det9PcC+mVi5S8Kv8QfNpnqQ1MilneMnCmhVO7eDTTE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DX/nFY1vTWo84OnaK99NwKqjdzKyoO1Z909cFmUTwiIenb6ktshVkazncBc+AWeo1slZ55J8dyIsvPjrq5sxRUVDb5RWKU9Tx13rrSvqXV21yUZQHmrtQhEjvbdA0WxFmDozVLwNkokDpZazc7Djhc5ZBEVV4eHWr8A1E6+v3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdDVC9uS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a605154d0so8632067b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000835; x=1711605635; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxl3++oKzQIFeEcU427phXc16l4FwUyoqNoBlLyyCwA=;
        b=gdDVC9uSOsEqbPXAZ/ppeINoDV+cYlXZ7S0AuGUB6NMC4ogyA5woVbsgui78qG/igS
         KsizSXrmFdKSy6N056RuLqBSqlbgmHjQC9ZXfPfdEbAQ9nmLKmBwybGZaPcJsy6utsBq
         JgMtEzT9l+xZ6cQUJHNHGaIWVvAvbaQ1GW/6+LAMr6tf92zIrfJmb/J0H4Md6nbmBK0g
         fQboJa4cS9/S5ZQqiJa7mtkIXc8DXn4bGFFmyufMEAaWmjRvviilY84zHNAL127GjizG
         nFV/yySV4k6ZvzYViiuyxxpML9ZsoNGFrp66zdp021De3ein77VgjI7GLUdFqoBZSKT0
         N1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000835; x=1711605635;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fxl3++oKzQIFeEcU427phXc16l4FwUyoqNoBlLyyCwA=;
        b=kXeyAXMLomyQvRf1llFEqUBQRKwJfolQheVQX6e/2TjFsNLNwTt6yXSAybFJr4P/Jp
         F9ABYxgQ3cpxsijC45GdFkHlT9qxMjnC86o/Iyc2GenggHoilfXWiq9Y2V5ybPo1Brmt
         zA3SDBf09oUSseoQC+NTJQ9JWbtPqrU4FEuE4ElnuTNOvF2TpewUKEVlBVgjXkydBV50
         RHfYuQ1Ptp85MDfrJhNW848uSu8BFIkGUeOCuJzKw/t4ibeLPPaVzATtjVt3kFAi0EXi
         Kw2f2x+B8ZWQ8bzJi/Vjbx5CRJkU7wEPfRDizLSG9bi+Cj7uyhZrIQFeY1CYBL873nEF
         EViA==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ty0+c3yfhz7M/msfPZOE809y2gPLwyKlvdKtNtr7MVLZ5lmmn7w4Lgi6sFrY8gkgz7MwGO5ZAKqmfXEFYgSzq5auc6QAgtokAkVo
X-Gm-Message-State: AOJu0YyJH9NLzgZoby3bZVW5+Q3EOSs3CmN2k/EKr2Yo/EhuvEJuQQfm
	fAuEy0CdrPVZZyE7rTws1bldYKQAp0hLn9oS7wnYmrL9e+ayt2DEZylH13fi6BftvX+61WpJ/UM
	wS6+V5A==
X-Google-Smtp-Source: AGHT+IEw00bJt9X2HyqC6RNPvChgCtM2Tz5+ma9UT2gH0uZKka8vSBIqKFnyUeetVa+HOTBMBSlyJI3uD+Cd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a0d:e6c7:0:b0:610:fb7b:da18 with SMTP id
 p190-20020a0de6c7000000b00610fb7bda18mr492310ywe.4.1711000835535; Wed, 20 Mar
 2024 23:00:35 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:09 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 05/12] perf vendor events intel: Update lunarlake to 1.01
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

Update events from 1.00 to 1.01 as released in:
https://github.com/intel/perfmon/commit/56ab8d837ac566d51a4d8748b6b4b817a22=
c9b84

Various encoding and description updates. Adds the events
CPU_CLK_UNHALTED.CORE, CPU_CLK_UNHALTED.CORE_P,
CPU_CLK_UNHALTED.REF_TSC_P, CPU_CLK_UNHALTED.THREAD,
MISC_RETIRED.LBR_INSERTS, TOPDOWN_BAD_SPECULATION.ALL_P,
TOPDOWN_BE_BOUND.ALL_P, TOPDOWN_FE_BOUND.ALL_P,
TOPDOWN_RETIRING.ALL_P.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json  |  24 ++--
 .../arch/x86/lunarlake/frontend.json          |   2 +-
 .../pmu-events/arch/x86/lunarlake/memory.json |   4 +-
 .../pmu-events/arch/x86/lunarlake/other.json  |   4 +-
 .../arch/x86/lunarlake/pipeline.json          | 109 +++++++++++++++---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 6 files changed, 113 insertions(+), 32 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/cache.json
index 1823149067b5..fb48be357c4e 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -31,7 +31,7 @@
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x4f",
         "Unit": "cpu_atom"
     },
@@ -94,7 +94,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -106,7 +106,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -118,7 +118,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -130,7 +130,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -142,7 +142,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -154,7 +154,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -166,7 +166,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -178,7 +178,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -190,7 +190,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -202,7 +202,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
@@ -212,7 +212,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
         "PEBS": "2",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0x6",
         "Unit": "cpu_atom"
     }
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/frontend.json
index 5e4ef81b43d6..3a24934e8d6e 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
@@ -19,7 +19,7 @@
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were no operation was delivered to the back-end pipeline due =
to instruction fetch limitations when the back-end could have accepted more=
 operations. Common examples include instruction cache misses or x86 instru=
ction decode limitations.",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations.\nSoftware can use this event as the numerator fo=
r the Frontend Bound metric (or top-level category) of the Top-down Microar=
chitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations. Software can use this event as the numerator for=
 the Frontend Bound metric (or top-level category) of the Top-down Microarc=
hitecture Analysis method.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/lunarlake/memory.json
index 51d70ba00bd4..9c188d80b7b9 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
@@ -155,7 +155,7 @@
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FBFC00001",
+        "MSRValue": "0xFE7F8000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -175,7 +175,7 @@
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FBFC00002",
+        "MSRValue": "0xFE7F8000002",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/other.json
index 69adaed5686d..377f717db6cc 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/other.json
@@ -24,7 +24,7 @@
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
+        "MSRValue": "0x1FBC000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -34,7 +34,7 @@
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
+        "MSRValue": "0x1E780000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index 2bde664fdc0f..2c9f85ec8c4a 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -38,10 +38,18 @@
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
         "EventName": "CPU_CLK_UNHALTED.CORE",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Core cycles when the core is not in a halt st=
ate.",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
 The core frequency may change from time to time due to transitions associa=
ted with Enhanced Intel SpeedStep Technology or TM2. For this reason this e=
vent may have a changing ratio with regards to time. When the core frequenc=
y is constant, this event can approximate elapsed time while the core was n=
ot in the halt state. It is counted on a dedicated fixed counter, leaving t=
he programmable counters available for other events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
         "EventCode": "0x3c",
@@ -49,10 +57,18 @@
         "SampleAfterValue": "2000003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
@@ -64,6 +80,15 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
         "EventCode": "0x3c",
@@ -74,9 +99,16 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Core cycles when the thread is not in a halt =
state.",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
+        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the programmable counters available for other events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -89,10 +121,10 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
+        "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
@@ -100,7 +132,7 @@
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
@@ -148,11 +180,29 @@
         "UMask": "0x82",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "LBR record is inserted",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions.\nSoftware can use this event as the numera=
tor for the Backend Bound metric (or top-level category) of the Top-down Mi=
croarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions. Software can use this event as the numerat=
or for the Backend Bound metric (or top-level category) of the Top-down Mic=
roarchitecture Analysis method.",
         "SampleAfterValue": "10000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -175,21 +225,35 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of issue slo=
ts that were not consumed by the backend because allocation is stalled due =
to a mispredicted jump or a machine clear.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
ALL_P]",
+        "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
-        "PublicDescription": "Fixed Counter: Counts the number of issue sl=
ots that were not consumed by the backend because allocation is stalled due=
 to a mispredicted jump or a machine clear.  Counts all issue slots blocked=
 during this recovery window including relevant microcode flows and while u=
ops are not yet available in the IQ. Also, includes the issue slots that we=
re consumed by the backend but were thrown away because they were younger t=
han the mispredict or machine clear.",
         "SampleAfterValue": "1000003",
-        "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
ALL]",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL_P",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL_P]=
",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL]",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN_BE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
@@ -198,18 +262,35 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.  Similar to UOPS_RETIRED.ALL",
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls",
+        "EventCode": "0x9c",
+        "EventName": "TOPDOWN_FE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x7",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of consumed retirement slot=
s.",
+        "EventCode": "0xc2",
+        "EventName": "TOPDOWN_RETIRING.ALL_P",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric.\nSoftware can use this event as the numerator for the Retirin=
g metric (or top-level category) of the Top-down Microarchitecture Analysis=
 method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric. Software can use this event as the numerator for the Retiring=
 metric (or top-level category) of the Top-down Microarchitecture Analysis =
method.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index a219dc3bd1ef..710f8dfefeed 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -20,7 +20,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.00,lunarlake,core
+GenuineIntel-6-BD,v1.01,lunarlake,core
 GenuineIntel-6-A[AC],v1.07,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
--=20
2.44.0.396.g6e790dbe36-goog


