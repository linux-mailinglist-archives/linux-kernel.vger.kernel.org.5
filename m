Return-Path: <linux-kernel+bounces-109676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62186881C46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48C51F2237D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F269959;
	Thu, 21 Mar 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ymIyrUo"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1A57873
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000847; cv=none; b=rCBb7Vg2rCkOuKs2cAcj2bpIie84C1mgCAB0HNIlGY1PJKGEZeBTyMRs0B26oN+N/Dv2stblyQ67nUVTwdmI0N9yM672hwVE07kF818SuxRiLxCDt9cYa57ykyG2efVKjbVgETEl1iDVXJ8ViSnVRypzqL9I0aN1CpWLcWXB+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000847; c=relaxed/simple;
	bh=6m0KZRRJflU5tJ8OGjhibHJSv5U59NbYKp/Jo7HCkXA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fJ9jsMfweoNR/+6yyfeGjOzTcL2xtbyJxrkgDhPUHSYJjSbMfnRFa9AAllk/iWJpM/Ho8li0Uz0D5LZ3U7lv0WwzAsZozSjkzuahOo+gxe1srPc7YQhgMB6KcbScsTgjquyYStdUcBi0YwFYxAyrRg6lD9YpBoALiGIyjIHXZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ymIyrUo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso825811276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000845; x=1711605645; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRnFA9pfHXZ9RNQTcmi2ijnTiZS/iti8+cu2PF/551A=;
        b=3ymIyrUo2uKiiLvknycpL37ZKsczHYUdVJgMpp6G7QXODBdw4M80ZIoSqEcZK7IzTh
         1za8V7JgKwyQ7+LJzOpssWdXKAjvXxyxdQd8W576pNL7kLoMaCTy4di3XEJdiKJYIODZ
         mKugSmxuC02RtQ1TetxiX25Yw4/iqd8PTpYVvD8CqAIcLY18Y5phVNy+MsMLzBvLyBDy
         1/QwXr32itnfaTrZWQouWViVsOr6ryN1xHrWigcRTjCMSSZu/19qKOCoyYki2qNOmyaQ
         sLanOKeowoByClk64DmAQcrMwQ6dFo8iJNUKJo1OX9xumMSpyFzuDxzqIC7yN9jHiyyM
         5duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000845; x=1711605645;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zRnFA9pfHXZ9RNQTcmi2ijnTiZS/iti8+cu2PF/551A=;
        b=W6aQ76WI7i9F/z6OTCtw9oIKXrqCzL1LEUfEJCAeu+qdyuJnhFELppz7GMMv/Lq7vw
         cR689mr/3VZ5b5vM0PmkdHLjr0T2WYQVdDKwhUcDKi6aYiGyDZ5J6LJEL3+x7ucZXPYO
         IQwMujpXtZ9UYzze1vXF7yaKKhyeCTVJo3BbcXXcjk3g2opgfizUPoaTdk+bSNNmxNB/
         o4JODrlSVrEE5S7H9EGUsmGN8wLKT63nhGG3H8pyia7xiiBVyOeGAJ0Zax8Co4LMCbme
         PcjsTIPjhzYfq0mRBnIjzY5Rsdsb3PDCeikS7LXawvRethrc55f1eE2uBKvKSWUtTL/r
         P9kw==
X-Forwarded-Encrypted: i=1; AJvYcCWgQpTnYZ/QkI2XDavaROg8fy/fpwq8uIih2/XPuR0DIRj5ziDVsaLLcr7OZ6w0A4OA8lIOLZN526fRjsKN5Twxeq45wDmMQzu3x3h9
X-Gm-Message-State: AOJu0YzCJOGwR2DmwA8w8xrSfyFJ1+89WZWSWL0OfunEKRVQaGU5ac6L
	xTUu6zRf/uFtXkaVnEsDc/qMK8oK7GTSrBchO3ldDFJsNJyyaOxY7GXUuVMVGZm7SF+p8fQe5lv
	OltQLKg==
X-Google-Smtp-Source: AGHT+IH7dLwVAgKevoQ4rNxLbtZHJaCXA6L6vZg0WcTg8hlz2pjhVnbpYqXUMudcz+f+HPRyPvXAO94ks4CC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b85:b0:dbe:30cd:8fcb with SMTP
 id ei5-20020a0569021b8500b00dbe30cd8fcbmr1126034ybb.0.1711000844811; Wed, 20
 Mar 2024 23:00:44 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:13 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 09/12] perf vendor events intel: Update skylakex to 1.33
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

Update events from 1.32 to 1.33 as released in:
https://github.com/intel/perfmon/commit/3fe7390dd18496c35ec3a9cf17de0473fd5=
485cb

Various description updates. Adds the event
OFFCORE_RESPONSE.ALL_READS.L3_HIT.HIT_OTHER_CORE_FWD.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv         |  2 +-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |  9 +++++++++
 .../pmu-events/arch/x86/skylakex/frontend.json     | 10 +++++-----
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |  2 +-
 tools/perf/pmu-events/arch/x86/skylakex/other.json |  2 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |  2 +-
 .../arch/x86/skylakex/uncore-interconnect.json     | 14 +++++++-------
 .../pmu-events/arch/x86/skylakex/uncore-io.json    |  2 +-
 .../arch/x86/skylakex/virtual-memory.json          |  2 +-
 9 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index ac32377ab01a..e67e7906b2cf 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-8F,v1.20,sapphirerapids,core
 GenuineIntel-6-AF,v1.02,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v58,skylake,core
-GenuineIntel-6-55-[01234],v1.32,skylakex,core
+GenuineIntel-6-55-[01234],v1.33,skylakex,core
 GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.15,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/cache.json b/tools/per=
f/pmu-events/arch/x86/skylakex/cache.json
index d28d8822a51a..14229f4b29d8 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/cache.json
@@ -763,6 +763,15 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HIT_OTHER_C=
ORE_FWD hit in the L3 and the snoop to one of the sibling cores hits the li=
ne in E/S/F state and the line is forwarded.",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HIT_OTHER_CORE_FWD=
",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C07F7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs that have a=
ny response type.",
         "EventCode": "0xB7, 0xBB",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/frontend.json b/tools/=
perf/pmu-events/arch/x86/skylakex/frontend.json
index 095904c77001..d6f543471b24 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/frontend.json
@@ -19,7 +19,7 @@
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.COUNT",
-        "PublicDescription": "This event counts the number of the Decode S=
tream Buffer (DSB)-to-MITE switches including all misses because of missing=
 Decode Stream Buffer (DSB) cache and u-arch forced misses.\nNote: Invoking=
 MITE requires two or three cycles delay.",
+        "PublicDescription": "This event counts the number of the Decode S=
tream Buffer (DSB)-to-MITE switches including all misses because of missing=
 Decode Stream Buffer (DSB) cache and u-arch forced misses. Note: Invoking =
MITE requires two or three cycles delay.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -267,11 +267,11 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops [This event is alias to IDQ.DSB_CYCLES_OK]",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 or more Uops [This event is alias to IDQ.DSB_CYCLES_OK]",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
-        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ. [This event is alias =
to IDQ.DSB_CYCLES_OK]",
+        "PublicDescription": "Counts the number of cycles 4 or more uops w=
ere delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buff=
er (DSB) path. Count includes uops that may 'bypass' the IDQ. [This event i=
s alias to IDQ.DSB_CYCLES_OK]",
         "SampleAfterValue": "2000003",
         "UMask": "0x18"
     },
@@ -321,11 +321,11 @@
         "UMask": "0x18"
     },
     {
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops [This event is alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 or more Uops [This event is alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ. [This event is alias =
to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "PublicDescription": "Counts the number of cycles 4 or more uops w=
ere delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buff=
er (DSB) path. Count includes uops that may 'bypass' the IDQ. [This event i=
s alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
         "SampleAfterValue": "2000003",
         "UMask": "0x18"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/memory.json b/tools/pe=
rf/pmu-events/arch/x86/skylakex/memory.json
index 2b797dbc75fe..dba3cd6b3690 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/memory.json
@@ -864,7 +864,7 @@
         "BriefDescription": "Number of times an RTM execution aborted due =
to any reasons (multiple categories may count as one).",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PEBS": "1",
+        "PEBS": "2",
         "PublicDescription": "Number of times RTM abort was triggered.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/other.json b/tools/per=
f/pmu-events/arch/x86/skylakex/other.json
index cda8a7a45f0c..2511d722327a 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/other.json
@@ -19,7 +19,7 @@
         "BriefDescription": "Core cycles where the core was running in a m=
anner where Turbo may be clipped to the AVX512 turbo schedule.",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
-        "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server michroarch=
tecture).  This includes high current AVX 512-bit instructions.",
+        "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server microarchi=
tecture).  This includes high current AVX 512-bit instructions.",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/skylakex/pipeline.json
index 66d686cc933e..c50ddf5b40dd 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
@@ -396,7 +396,7 @@
         "Errata": "SKL091, SKL044",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBS": "1",
+        "PEBS": "2",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
index 3eece8a728b5..f32d4d9d283a 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
@@ -38,7 +38,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x80",
         "Unit": "IRP"
     },
@@ -47,7 +47,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x2",
         "Unit": "IRP"
     },
@@ -56,7 +56,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.DRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -65,7 +65,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x20",
         "Unit": "IRP"
     },
@@ -74,7 +74,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x1",
         "Unit": "IRP"
     },
@@ -101,7 +101,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -500,7 +500,7 @@
         "EventCode": "0x11",
         "EventName": "UNC_I_TRANSACTIONS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Trackes only write requests.=
  Each write request should have a prefetch, so there is no need to explici=
tly track these requests.  For writes that are tickled and have to retry, t=
he counter will be incremented for each retry.",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only write requests. =
 Each write request should have a prefetch, so there is no need to explicit=
ly track these requests.  For writes that are tickled and have to retry, th=
e counter will be incremented for each retry.",
         "UMask": "0x2",
         "Unit": "IRP"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json b/tools=
/perf/pmu-events/arch/x86/skylakex/uncore-io.json
index 2a3a709018bb..743c91f3d2f0 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json
@@ -34,7 +34,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_IIO_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "Counts clockticks of the 1GHz trafiic contro=
ller clock in the IIO unit.",
+        "PublicDescription": "Counts clockticks of the 1GHz traffic contro=
ller clock in the IIO unit.",
         "Unit": "IIO"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json b/=
tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
index f59405877ae8..73feadaf7674 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
@@ -205,7 +205,7 @@
         "BriefDescription": "Counts 1 per cycle for each PMH that is busy =
with a page walk for an instruction fetch request. EPT page walk duration a=
re excluded in Skylake.",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts 1 per cycle for each PMH (Page Miss H=
andler) that is busy with a page walk for an instruction fetch request. EPT=
 page walk duration are excluded in Skylake michroarchitecture.",
+        "PublicDescription": "Counts 1 per cycle for each PMH (Page Miss H=
andler) that is busy with a page walk for an instruction fetch request. EPT=
 page walk duration are excluded in Skylake microarchitecture.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
--=20
2.44.0.396.g6e790dbe36-goog


