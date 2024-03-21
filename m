Return-Path: <linux-kernel+bounces-109670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31F881C40
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECFD1F22368
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897EC405EC;
	Thu, 21 Mar 2024 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="xHM5bXYu"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AB3D961
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000833; cv=none; b=bnR3jJYVUZ1BLUlZgsZ+4OTPFhgNTCi9AFReh5dzN6BVUHfolwsr059Js/TXduq6cyo1oJbcbaqlgoMEnqDRpJ6SiCPxab51O73hKQ32K7F3V/HEN8F6gWKog90RqiTWCbaoClH8otSICYVeXB4lissO1eQD5xsPpYFc40ZG50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000833; c=relaxed/simple;
	bh=b+7RrbVDfD1wv8mqd+Fe26jyrKveVzTWetI4bC9tOvc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ah6yfgubgjr1Q6i2fBjSzyPDH6bG5vlOLFohuUy+jcU+3Krhss+ZCXLPfOjUrlNTwj9fJI/6wJgxVP+Kf1ZBICNO/qxdee+oIM73KlJ1FKKm+ZiaYBDyQUdIzGmI7P75KDD7df6uoG6HdUMP2YZLaVNrx8FhhTCxBDopTfRvGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHM5bXYu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so700567276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000830; x=1711605630; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aq5QHB0Bma/gpqnZwoZL+nXfSxp7CToAwLY7zcNQ7BA=;
        b=xHM5bXYuJBXyTDKbS3VaMAqHCqo8UN2HL21gn9vt02e/H57TQn7lBolMuhIn4muWY3
         lRM/uYrmPzr6Ja6rmiHmnyBioZDo/GSpn4xoHpXaTJNjFlYCvDlbKpdRqMLXvoEkFgYc
         Qb3vQ5YudXLMbIlOeOkKESO1oelM95tVY32YiU2bq97lU30nCuB3/Y/02aCz4mF2wrVq
         ta8dWwb0S4lyTwe1/GpVpK+FrtL8s4yXJc+4s2W2DzVD7eheg3AXbzNSjOZ57GIGYGjO
         wGrxNyyFpQQb4IzkNxweddkUbseIVIor7o00HJF1Def2wyeyInY9b8EDUcOCMSEf80GH
         +kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000830; x=1711605630;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aq5QHB0Bma/gpqnZwoZL+nXfSxp7CToAwLY7zcNQ7BA=;
        b=DaL6pj0bmCFukb3L8m4+OIkwIwZXrPaOtc57P06FuHIXGAxk10sKcTSDgMAId3VOG3
         SF15IWgV3zZW1GhWE4RD/WqFgPkE3cQc4DoVMAjbT46O0zVzliHkTVqfhQbblbMl8BTV
         yTsd1txxTo/CZoiM1fs7PT+s8aQK3ofUqxEJAJxmPWIoCk4WaNhKGX7Wgd61Y+kDZdIg
         cxK+hWzBTfWub77WBjdPLUSZNxl1RYhq+tUyO1fH4LLmSaVMBEOuYAO6vSOhoMt/juVF
         TmqZNqfk0JrVpuMskKqaXGgY8kmjh3lhNErPDT9Zemy+ANhLWALrbUN5Mqpi+U2SMaDB
         J5aw==
X-Forwarded-Encrypted: i=1; AJvYcCWx1SSFWRKfWKmeU28dq67PFZ8pF70oxzCpEXe33HP+kZTmaFaI10zkURw2NcoBfeFhjG/k6V06zsApx0Jr1UjESwBL75cL1Spb0feY
X-Gm-Message-State: AOJu0YwMIZhr+pVCn9Pi6BlPJUolRkwPvG4ZKrZz/EaYwuG6A3A7Ekx/
	KP2tN0diAITo3R67Z+jwkGMTOqflNTvUQAZ1I/UunmzASYb/O0yu4uAnl4fky8uPJwgAN62BCi2
	GoTI9uA==
X-Google-Smtp-Source: AGHT+IFGpsaXg6OyBmvyWZMl9nd726SjWYZ8fw/8neentyGEL1EcmB8iV+x8KBlbLLkHkxnVrJSrD0HFX3by
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2843:b0:dc7:82ba:ba6e with SMTP
 id ee3-20020a056902284300b00dc782baba6emr1120181ybb.7.1711000830276; Wed, 20
 Mar 2024 23:00:30 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:07 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 03/12] perf vendor events intel: Update grandridge to 1.02
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

Update events from 1.01 to 1.02 as released in:
https://github.com/intel/perfmon/commit/b2a81e803add1ba0af68a442c975683d226=
d868c

Fixes spelling and descriptions. Adds topdown events and uncore cache
UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT,
UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT,
UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/grandridge/pipeline.json         | 43 ++++++++++++++++---
 .../arch/x86/grandridge/uncore-cache.json     | 28 +++++++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 3 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/pipeline.json
index daa0639bb1ca..90292dc03d33 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
@@ -249,10 +249,17 @@
         "UMask": "0x1"
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
+        "SampleAfterValue": "1000003"
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
         "SampleAfterValue": "1000003"
     },
     {
@@ -284,7 +291,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls",
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL_P]=
",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003"
@@ -296,6 +303,12 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL]",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
         "EventCode": "0x74",
@@ -317,6 +330,13 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to iq/jeu scoreboards or ms scb",
         "EventCode": "0x74",
@@ -325,11 +345,17 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls",
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls [This event is alias to TOPDOWN_FE_BOUND.ALL_=
P]",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls [This event is alias to TOPDOWN_FE_BOUND.ALL]=
",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BAClear",
         "EventCode": "0x71",
@@ -402,12 +428,19 @@
         "UMask": "0x4"
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
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL [This event is alias to TOPDOWN_RETIRING.AL=
L]",
+        "EventCode": "0x72",
+        "EventName": "TOPDOWN_RETIRING.ALL_P",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003"
+    },
     {
         "BriefDescription": "Counts the number of uops issued by the front=
 end every cycle.",
         "EventCode": "0x0e",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
index 74dfd9272cef..36614429dd72 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
@@ -5,7 +5,6 @@
         "EventName": "UNC_CHACMS_CLOCKTICKS",
         "PerPkg": "1",
         "PortMask": "0x000",
-        "PublicDescription": "UNC_CHACMS_CLOCKTICKS",
         "Unit": "CHACMS"
     },
     {
@@ -1216,6 +1215,15 @@
         "UMask": "0xc88fff01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores"=
,
+        "UMask": "0xc827ff01",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that miss the cache",
         "EventCode": "0x36",
@@ -1252,6 +1260,15 @@
         "UMask": "0xc88ffd01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores =
that hit the LLC",
+        "UMask": "0xc827fd01",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that hit the cache",
         "EventCode": "0x36",
@@ -1405,6 +1422,15 @@
         "UMask": "0xc88efe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt issued by iA Cores t=
hat missed the LLC",
+        "UMask": "0xc827fe01",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that miss the cache",
         "EventCode": "0x36",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 85b89b1098cf..650c28574576 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -10,7 +10,7 @@ GenuineIntel-6-9[6C],v1.04,elkhartlake,core
 GenuineIntel-6-CF,v1.06,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.01,grandridge,core
+GenuineIntel-6-B6,v1.02,grandridge,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v35,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
--=20
2.44.0.396.g6e790dbe36-goog


