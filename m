Return-Path: <linux-kernel+bounces-109673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CDF881C43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9931C212BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C93B2A4;
	Thu, 21 Mar 2024 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JCBlOrzn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0446551
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000842; cv=none; b=Qjr8z8yQPDUlQwqVLbh7nS8vVse7lTojNnA6UNwL1MClRi8NmR3o9ZXpxdAU7lPyywMHYWjrNjbCUm9BxvrC4Jy1Z7m2l2Ft30dijL/22saYdhKdt+Og7VrmfIxDgcraZUW2FLXd5RCJJ6RTwpEGcfoBDqZPbhOB/HI9xhit3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000842; c=relaxed/simple;
	bh=xUxXmJtj7FVVv4SJQtVcLWR1VWSUqj14rVzHpXxnvUE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Snp55hCYdgekudXoDVmTsPAV7gBbS403SsIx3Aa7kFA4zYs8hC0VsVliMIgZe4xfeoxWfQzOBfHe3cl1i7bVcUzOgxn0GZKFdYN2oWeRR4auQTVpa50MjY/hTL8y9OTSGxkdA1owDYMzOV8NTeu8yoaQvBHan+QUN7mh5+PxKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCBlOrzn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a4ee41269so11458757b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000838; x=1711605638; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWdw1TIJbsWclnQhlh6F738bkypXx+6WHX0OyhPi4ys=;
        b=JCBlOrzneY0GPXpRM6R/5gPYE3uAEG5enpTB4c2YJpQoddZGX4GobL3LlRargoKbDb
         w8iZNomI2hnvnIGXA2AWL37/cG8Ms6ToGIG9TN3goin7vFjBQt2XX4OxnXePwoTazg3d
         KvsGrPoAOHBuzxCPeVtOydI2VzJXJQGCtm722Pcl8OVQvTbEJ9HrOYW6dfCDuHWbX4fy
         vITlFhGXm+b0QL2og+aBh+BpdgLKOA5FZyvKUZhu0+uf0vZKQa8A6+96YgyN8nTKnrpx
         qIa46DS4tueNW1UlR97K2drptmF88yd9AV7OztEbYrthGBTeJdqrwzN4hKMvriRsJOJS
         9fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000838; x=1711605638;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NWdw1TIJbsWclnQhlh6F738bkypXx+6WHX0OyhPi4ys=;
        b=puIIBVvXHOldGJpu0tvmfOYzEUVE5xEuOHYiz2QYUAQh0eSLPUAZtqvSl8a909PpJ7
         AltYv7znlYllzXOIV4V+RZinQi0s4G5/kyz7WAcl8kvt+y8rNjVter86byZ+kOeM7+sI
         q1zWPHZNUB2VD770aFwaK4kfiFKC7Eq6Zc4IMSNGm0TbcWPpaIl+CpB28ZBfIiXmBnfZ
         vAnn7xt00rqavUAWrGID6CUWwbsMEwc+budL9N6xLnELILQ6f9ZiUR34EFdGNjo6gk5w
         BB6vyMtMXwrX5Pb54248WVFa2fSyfTQ7O0ohiGUk6l35Ker2yKlOBTbqzMo59iswiArO
         Ugdg==
X-Forwarded-Encrypted: i=1; AJvYcCWjIHEK1HLwXjCtuYAQhStLEUaLxbUCn7EtFU3i7uND2YJc7Ov11++KM3VwOhS2diwLb66bBvJtLfNh+p+Eb1slLfoUNJOtmToOT0GL
X-Gm-Message-State: AOJu0Yx5NTSVXfeoDN9YVcH2Is00NKIdmk/nFlpi3yAX+xBiOm3ncJOu
	Mtn/LHp6qikfAnDw+a/dJ6swPp39bBZ2l18qd5OUt+UfXtb7uH4pWimzS14Yf+M2tN8syUa4OOe
	Iy77LRQ==
X-Google-Smtp-Source: AGHT+IGRjA4wQJnh/1ZtJ+PUfWok7OnUtftZVPP+k0aZ3PMXc0avq5ofgvlk9k2nLeNz6buadL1PZrXLO2o/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2412:b0:dcd:25be:aefb with SMTP
 id dr18-20020a056902241200b00dcd25beaefbmr2073301ybb.13.1711000837934; Wed,
 20 Mar 2024 23:00:37 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:10 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 06/12] perf vendor events intel: Update meteorlake to 1.08
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

Update events from 1.07 to 1.08 as released in:
https://github.com/intel/perfmon/commit/f0f8f3e163d9eb84e6ce8e2108a22cb43b2=
527e5

Various description updates. Adds topdown, offcore and uncore events
OCR.DEMAND_DATA_RD.L3_HIT, OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD,
OCR.DEMAND_RFO.L3_HIT, OCR.DEMAND_DATA_RD.L3_MISS,
OCR.DEMAND_RFO.L3_MISS, OCR.DEMAND_DATA_RD.ANY_RESPONSE,
OCR.DEMAND_DATA_RD.DRAM, OCR.DEMAND_RFO.ANY_RESPONSE,
OCR.DEMAND_RFO.DRAM, TOPDOWN_BAD_SPECULATION.ALL_P,
TOPDOWN_BE_BOUND.ALL_P, TOPDOWN_FE_BOUND.ALL_P,
TOPDOWN_RETIRING.ALL_P, UNC_ARB_DAT_OCCUPANCY.RD and
UNC_HAC_ARB_COH_TRK_REQUESTS.ALL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 30 +++++++++++++
 .../arch/x86/meteorlake/frontend.json         |  4 +-
 .../arch/x86/meteorlake/memory.json           | 20 +++++++++
 .../pmu-events/arch/x86/meteorlake/other.json | 42 +++++++++++++++++-
 .../arch/x86/meteorlake/pipeline.json         | 44 ++++++++++++++++---
 .../x86/meteorlake/uncore-interconnect.json   | 22 ++++++++--
 7 files changed, 150 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 710f8dfefeed..fedaacbe981a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.01,lunarlake,core
-GenuineIntel-6-A[AC],v1.07,meteorlake,core
+GenuineIntel-6-A[AC],v1.08,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.02,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index 47861a6dd8e9..af7acb15f661 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -966,6 +966,16 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
         "EventCode": "0xB7",
@@ -986,6 +996,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
         "EventCode": "0xB7",
@@ -1006,6 +1026,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
         "EventCode": "0xB7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 9da8689eda81..f3b7b211afb5 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -378,7 +378,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -455,7 +455,7 @@
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
uction decode limitations.\nThe count may be distributed among unhalted log=
ical processors (hyper-threads) who share the same physical core, in proces=
sors that support Intel Hyper-Threading Technology. Software can use this e=
vent as the numerator for the Frontend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations. The count may be distributed among unhalted logi=
cal processors (hyper-threads) who share the same physical core, in process=
ors that support Intel Hyper-Threading Technology. Software can use this ev=
ent as the numerator for the Frontend Bound metric (or top-level category) =
of the Top-down Microarchitecture Analysis method.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/=
perf/pmu-events/arch/x86/meteorlake/memory.json
index a5b83293f157..617d0e255fd5 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -296,6 +296,16 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "EventCode": "0x2A,0x2B",
@@ -306,6 +316,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
         "EventCode": "0x2A,0x2B",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index 7effc1f271e7..0bc2cb2eabb3 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -17,6 +17,16 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "EventCode": "0x2A,0x2B",
@@ -27,6 +37,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
         "EventCode": "0x2A,0x2B",
@@ -37,6 +57,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
         "EventCode": "0x2A,0x2B",
@@ -47,6 +77,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "EventCode": "0xB7",
@@ -97,7 +137,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state. For Tremont, UMWAIT and TPAUSE will onl=
y put the CPU into C0.1 activity state (not C0.2 activity state)",
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
         "EventCode": "0x75",
         "EventName": "SERIALIZATION.C01_MS_SCB",
         "SampleAfterValue": "200003",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 24bbfcebd2be..5ff4a7a32250 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -1067,7 +1067,7 @@
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions.\nThe count is distributed among unhalted l=
ogical processors (hyper-threads) who share the same physical core, in proc=
essors that support Intel Hyper-Threading Technology. Software can use this=
 event as the numerator for the Backend Bound metric (or top-level category=
) of the Top-down Microarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions. The count is distributed among unhalted lo=
gical processors (hyper-threads) who share the same physical core, in proce=
ssors that support Intel Hyper-Threading Technology. Software can use this =
event as the numerator for the Backend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
         "SampleAfterValue": "10000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1116,10 +1116,18 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
ALL_P]",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear."=
,
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear. =
[This event is alias to TOPDOWN_BAD_SPECULATION.ALL_P]",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
ALL]",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL_P",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear. =
[This event is alias to TOPDOWN_BAD_SPECULATION.ALL]",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
@@ -1156,7 +1164,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls",
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL_P]=
",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003",
@@ -1170,6 +1178,13 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL]",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
         "EventCode": "0x74",
@@ -1211,12 +1226,19 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls",
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls [This event is alias to TOPDOWN_FE_BOUND.ALL_=
P]",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls [This event is alias to TOPDOWN_FE_BOUND.ALL]=
",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BAClear",
         "EventCode": "0x71",
@@ -1299,13 +1321,21 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL",
+        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL [This event is alias to TOPDOWN_RETIRING.AL=
L_P]",
         "EventCode": "0x72",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL [This event is alias to TOPDOWN_RETIRING.AL=
L]",
+        "EventCode": "0x72",
+        "EventName": "TOPDOWN_RETIRING.ALL_P",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of non dec-by-all uops decoded by deco=
der",
         "EventCode": "0x76",
@@ -1591,7 +1621,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/meteorlake/uncore-interconnect.json
index 08b5c7574cfc..901d8510f90f 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/uncore-interconnect.json
@@ -1,4 +1,20 @@
 [
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop,  etc.",
+        "EventCode": "0x84",
+        "EventName": "UNC_HAC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HAC_ARB"
+    },
     {
         "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches",
         "EventCode": "0x81",
@@ -9,7 +25,7 @@
     },
     {
         "BriefDescription": "Number of all CMI transactions",
-        "EventCode": "0x8a",
+        "EventCode": "0x8A",
         "EventName": "UNC_HAC_ARB_TRANSACTIONS.ALL",
         "PerPkg": "1",
         "UMask": "0x1",
@@ -17,7 +33,7 @@
     },
     {
         "BriefDescription": "Number of all CMI reads",
-        "EventCode": "0x8a",
+        "EventCode": "0x8A",
         "EventName": "UNC_HAC_ARB_TRANSACTIONS.READS",
         "PerPkg": "1",
         "UMask": "0x2",
@@ -25,7 +41,7 @@
     },
     {
         "BriefDescription": "Number of all CMI writes not including Mflush=
",
-        "EventCode": "0x8a",
+        "EventCode": "0x8A",
         "EventName": "UNC_HAC_ARB_TRANSACTIONS.WRITES",
         "PerPkg": "1",
         "UMask": "0x4",
--=20
2.44.0.396.g6e790dbe36-goog


