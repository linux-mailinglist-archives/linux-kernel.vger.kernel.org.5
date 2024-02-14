Return-Path: <linux-kernel+bounces-64639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5539854115
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB5FB2902A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64633111BC;
	Wed, 14 Feb 2024 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="F2H2wo7H"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFB10A34
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873537; cv=none; b=IcrNu1GnlQvHzgwEcuWWhL24NBQnPNniXqo1LrAIGFHj8CcCO1YfbcKX4mMItEwzcEf2tDC7KxaJAhsQ7m3wMyQoAxIQA/zJ24qhRgIehnrFsEE+vSoCSHNjLPlfZAxzx8oR+XbL1aXo4aiJiwvg3piSCbk6FkrdSe+yMJ2Ebpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873537; c=relaxed/simple;
	bh=ayfr5joTeANILDLS/d/YtZoT/7vqg3z9rXfD9HNG/0s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=GRErBnzlggpGcaRwiik95cNkuljXeWYO7DHL7LipKiihNMwKgmPGAuNuY4wtn7IhhYC2udskJTD8rYttS9G7hMr91gLPZ+51OP5xeDZsz+z0bD7D6MQ3vj2Gh52TEKUK26fGp8H6dmQwRsopINGGILXwQgG2fSKcFO9jhQJARJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2H2wo7H; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so2829988276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873534; x=1708478334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxamQLahk52YUGqgk1aiYcvedhc+wnvad4WwzmxIdxQ=;
        b=F2H2wo7HXLj5Ni9D39yYnKHlP1ddaqrKWHxnwGOG2xK0Btlm6FRkIJwy+QiQtPJ5FD
         4QT0TTYKflIk66t2hIufhEt80DRkB20/kfWROcexrxrkS8hKfGNFOQCX2GWhp+rwjIuN
         pvqGsFbVnfzFEeE7L9se83nkl2aEI5IpRQbDkQ9CIIioOurU2wKtWIdyv6XsbKiCqinc
         DDlE9IOUOClraxAd7RsXsIdfqr45A2MidQx19G6qPMP2Fqq/A7/ryXAWKJVdQGN6Q3i7
         zvpGk3udzpnmDBhsV6+aGain2s7ZbMM2U/Sa82HDi5sY+BiSvGpKI1z02jaRZXsyCQ4/
         3eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873534; x=1708478334;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yxamQLahk52YUGqgk1aiYcvedhc+wnvad4WwzmxIdxQ=;
        b=sEXurtLGdghqav0efjhU6v8CqlW1hwFjQWOU2DN0NPzg6yQXyqUjC81jj0WcmiVOmt
         8NE+6xop2ZJqAxMCnzMYITnPA+JaIeFN8OP1vUhIRJuddUlH6BZ/KxIWklTZ+6ofbmEP
         bhFPLyF5cCb7wOZ4eLisOf1MWMIkIDtSjvZ6CLK7YezargkyBHvg0jKM+GxxO9MlRYwD
         bkhQSsWhHgTEKESeYEnjWKhFhY4c2PugJTfhsApaL8HNS7O3Wh6SqxGSj63PUWRLDUda
         VuEUOME8aByDTR0zTXiWy5gtNwtYm6VFJbhoJUuS7aI7Y4Bscx5l9+sgKKPwWJrzvlqS
         h7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVujWG1PugP5bAqrTKU5R5+Ec4Yx//ZHraa6JBHV9g1fA5nR+OoEIsWIA5mgPFNlzyXY0oGmGIj7GogYtOlqvGrLTKivbLYnZiBENPv
X-Gm-Message-State: AOJu0YxPIhXwjh0hZeSQZcQ3N2BD1F+mxkWGt9X/rU/3Ro/Hpest46Nx
	lHNtpecW9RlncaUoHJr5nYMVwHMW6fIIADgjO+IDYzXM3eDAYnpf0dHZ+wSbbmJ4DJXREFaNPnE
	0hcjiiA==
X-Google-Smtp-Source: AGHT+IHi0Uyf+vY0mzPtHaALRBqeg5g1PuXdksw2W+bOEegXwiYnklKqObZlongrKYg5AnFuPyYljNALOTCl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:150d:b0:dc6:e1ed:bd1a with SMTP
 id q13-20020a056902150d00b00dc6e1edbd1amr266157ybu.2.1707873534708; Tue, 13
 Feb 2024 17:18:54 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:57 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 08/30] perf vendor events intel: Update meteorlake events
 to v1.07
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

Update meteorlake events to v1.07 released in:
https://github.com/intel/perfmon/commit/62517223080e46bfa9a905a1195c7febae7=
fdb3e

Umask changed on atom mem_bound events. Adds atom events
ARITH.FPDIV_ACTIVE, FP_FLOPS_RETIRED.ALL, FP_FLOPS_RETIRED.DP,
FP_FLOPS_RETIRED.FP32, ARITH.DIV_ACTIVE, BR_INST_RETIRED.COND,
BR_INST_RETIRED.COND_TAKEN, BR_INST_RETIRED.INDIRECT,
BR_INST_RETIRED.INDIRECT_CALL, BR_INST_RETIRED.IND_CALL,
BR_INST_RETIRED.NEAR_RETURN, DTLB_LOAD_MISSES.WALK_COMPLETED_4K,
DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M,
DTLB_STORE_MISSES.WALK_COMPLETED_4K, ITLB_MISSES.WALK_COMPLETED_4K,
and alias events.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  8 +-
 .../arch/x86/meteorlake/floating-point.json   | 86 ++++++++++++++++++-
 .../pmu-events/arch/x86/meteorlake/other.json | 10 +++
 .../arch/x86/meteorlake/pipeline.json         | 76 ++++++++++++++++
 .../arch/x86/meteorlake/virtual-memory.json   | 36 ++++++++
 6 files changed, 210 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 953e13a136a4..09145aaa0d8e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.00,lunarlake,core
-GenuineIntel-6-A[AC],v1.06,meteorlake,core
+GenuineIntel-6-A[AC],v1.07,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.01,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index 5fef87502d4b..47861a6dd8e9 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -319,7 +319,7 @@
         "EventCode": "0x35",
         "EventName": "MEM_BOUND_STALLS_IFETCH.ALL",
         "SampleAfterValue": "1000003",
-        "UMask": "0x6f",
+        "UMask": "0x7f",
         "Unit": "cpu_atom"
     },
     {
@@ -344,7 +344,7 @@
         "EventCode": "0x35",
         "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS",
         "SampleAfterValue": "1000003",
-        "UMask": "0x68",
+        "UMask": "0x78",
         "Unit": "cpu_atom"
     },
     {
@@ -352,7 +352,7 @@
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS_LOAD.ALL",
         "SampleAfterValue": "1000003",
-        "UMask": "0x6f",
+        "UMask": "0x7f",
         "Unit": "cpu_atom"
     },
     {
@@ -377,7 +377,7 @@
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS",
         "SampleAfterValue": "1000003",
-        "UMask": "0x68",
+        "UMask": "0x78",
         "Unit": "cpu_atom"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
index f66506ee37ef..30e604d2120f 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
@@ -1,4 +1,13 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point dividers are active.",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts the cycles the floating poi=
nt divider is busy.",
         "CounterMask": "1",
@@ -26,7 +35,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is ali=
as to FP_ARITH_DISPATCHED.V0]",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
         "SampleAfterValue": "2000003",
@@ -34,7 +43,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is ali=
as to FP_ARITH_DISPATCHED.V1]",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
         "SampleAfterValue": "2000003",
@@ -42,13 +51,37 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5 [This event is ali=
as to FP_ARITH_DISPATCHED.V2]",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V0 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_0]",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V1 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_1]",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V2 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_5]",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V2",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
         "EventCode": "0xc7",
@@ -130,6 +163,53 @@
         "UMask": "0xfc",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of all types of floating po=
int operations per uop with all default weighting",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to FP_FLOPS_RETIRED.FP64]",
+        "Deprecated": "1",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.DP",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s that produce 32 bit single precision results [This event is alias to FP_F=
LOPS_RETIRED.SP]",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.FP32",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s that produce 64 bit double precision results [This event is alias to FP_F=
LOPS_RETIRED.DP]",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.FP64",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to FP_FLOPS_RETIRED.FP32]",
+        "Deprecated": "1",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.SP",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
         "EventCode": "0xc3",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index d55e792c0c43..7effc1f271e7 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -7,6 +7,16 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to MISC_RETIRED.LBR_INSERTS]",
+        "Deprecated": "1",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "EventCode": "0x2A,0x2B",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index deaa7aba93f7..24bbfcebd2be 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -1,4 +1,13 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles when any of the d=
ividers are active.",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
         "CounterMask": "1",
@@ -45,6 +54,15 @@
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Conditional branch instructions retired.",
         "EventCode": "0xc4",
@@ -65,6 +83,15 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken conditional branch instructions retired=
",
         "EventCode": "0xc4",
@@ -94,6 +121,15 @@
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
         "EventCode": "0xc4",
@@ -104,6 +140,25 @@
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.IND_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
         "EventCode": "0xc4",
@@ -123,6 +178,15 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Return instructions retired.",
         "EventCode": "0xc4",
@@ -671,6 +735,7 @@
         "BriefDescription": "INST_RETIRED.MACRO_FUSED",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -679,6 +744,7 @@
         "BriefDescription": "Retired NOP instructions.",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
+        "PEBS": "1",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
@@ -697,6 +763,7 @@
         "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
+        "PEBS": "1",
         "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
@@ -979,6 +1046,15 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of Last Branch Record (LBR)=
 entries. Requires LBRs to be enabled and configured in IA32_LBR_CTL. [This=
 event is alias to LBR_INSERTS.ANY]",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
         "EventCode": "0xa2",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
index 056c2a885a32..55798e64c58a 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
@@ -70,6 +70,15 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 4K page.",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 4K pages. I=
ncludes page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
         "EventCode": "0x12",
@@ -150,6 +159,15 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 2M or 4M page.",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includes page walks=
 that page fault.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
         "EventCode": "0x13",
@@ -159,6 +177,15 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 4K page.",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 4K pages.  Includes page walks that =
page fault.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
         "EventCode": "0x13",
@@ -257,6 +284,15 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 4K page.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 4K pages.  Includes pag=
e walks that page fault.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
         "EventCode": "0x11",
--=20
2.43.0.687.g38aa6559b0-goog


