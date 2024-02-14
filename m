Return-Path: <linux-kernel+bounces-64632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D185410F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B221281D82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF78BE7;
	Wed, 14 Feb 2024 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1XwPSmS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7E2907
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873521; cv=none; b=Zjug1GjueYLpIHmBkxx6urJs4Hynz1xb/Gxcrl7JNII8Qj0f6sjpIZ+e5uY3PkRyGpekWGRZ+umeIE5eUnvN5p5VK9x/OK48LRCF7SSoo+R+hlJcev8sJQI+VqQfjl5RTGeorS1lkKtgfFs6Dd+bkajcUaBabJraO5O+nUR0L6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873521; c=relaxed/simple;
	bh=kCdq1/JnR1SeyKxIgPBGXeqPhBvbq9uecSmt9Ikr68U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Uscf1tPZslr7GAo8wfwDnQD8/c6IHF2vu63bztezv0vkSZlUb8AarNFlPXLPfgCbMPSGhfGQym/ADnCjwAb0cubStbB3Vl9CvqiLzt837n9PaZrLv+fC7GSiOD0obRP60qHu1R61YLvIT+6q//otQGI9n3ZNUDK/XeZjIyWiSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1XwPSmS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso9708906276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873519; x=1708478319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR+fs5zocBGZGwZPylA7Sb+OaeVH9KUIwRoduDArDzk=;
        b=K1XwPSmS1oBmU+74I6q6bsIZHOyL8Q2geU3MrplbOKKAElDn7/lZKpMW62P+yEAEks
         25cXpHi+VWFRcIPj8yk4ShB7g7062rT+Cf7BvuWD53nXW2Puz5/+FNM9NloS6cquOjHf
         pxtCsE0qPw6SpgHPeP/UPl6kusPZNXBrUGV0413UX0fo+k8msFYUTJepLDu3tKJAM/fN
         2xowfeWIMKhO/pjjRfpaHBAw6CFpmdjV2720QcNURnselDBxP2aRXgm364vqk/S/KE1X
         xWdpPKlV3EDA16Bbp8UY+ipYgwGgSqKiKfxS8/cm3IN+k+sGstFon0iDOP8NgK7JiIh5
         G1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873519; x=1708478319;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eR+fs5zocBGZGwZPylA7Sb+OaeVH9KUIwRoduDArDzk=;
        b=v08Yk226ut8xjUZMWwZzggVi9B6T08p9x/+BTXYOxCq8DUZ/GZFRjD7V0r27rFbD5N
         9YY6q53KkWdFIolPcS11Zsub8MWpTFGKcOrUNXmne73hlTUdiNi6GlYst5Wo8nZRiBCl
         fEUpDPz8Vvm6rsD+H/Ap3G5xJn3kwE+nd8O8F6zP0j2/sYPlx7LXM+yCeiFLzf6u2agR
         MHn+nBOyFDf3xQlVLHKU+h/KvM6uk5qG0MdNkeBMshUD2FBvCaA6sAYfNK7TmC1JXLjG
         8jOIawkPIxSubz4rEyIrmI7XFWlgLq/C6dFAtEXta0jKjGIK/EoN31zVjBK8krz18AHv
         isiw==
X-Forwarded-Encrypted: i=1; AJvYcCXjg8mtWIObeH0d4O2MHu8hKQI6Kk1jkakqoER2CunSV/MZbphcmWVOhFluI7cxYUoyWsxZqGUOD1tRg4n1n09z1rSHNAIMb0BjkkwY
X-Gm-Message-State: AOJu0Yw2WSrUGAmucVyZVNbYTK9391eL8W0H9kMQF0dOsNxJtSWXQV+I
	UhY6bUf5K8+qDhlZWGQbXD8fg7vErBU0c0yyR4P4bULqxBJTxBVOoKcMW3GrlBzSPh0486cGvl7
	8QrE5zA==
X-Google-Smtp-Source: AGHT+IE73XbcIZPmn9J2q33loyXlRE+pAe1VyrCxhokeUPB2Of9enKLxrBAiopB8IO8sd/KomFjJhVUzZQg9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1207:b0:dcc:50ca:e153 with SMTP
 id s7-20020a056902120700b00dcc50cae153mr205977ybu.7.1707873518824; Tue, 13
 Feb 2024 17:18:38 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:50 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 01/30] perf vendor events intel: Update alderlake events to v1.24
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

Update alderlake events to v1.24 released in:
https://github.com/intel/perfmon/commit/e627dd8d89e2d2110f1d499608dd6f37aae=
37a8c

Adds aliased events, improves documentation and fix some event fields.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/floating-point.json    | 30 +++++++++++++++++--
 .../pmu-events/arch/x86/alderlake/other.json  | 10 +++++++
 .../arch/x86/alderlake/pipeline.json          | 13 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index c8ba96c4a7f8..cd291943dc08 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -26,7 +26,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is ali=
as to FP_ARITH_DISPATCHED.V0]",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
         "SampleAfterValue": "2000003",
@@ -34,7 +34,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is ali=
as to FP_ARITH_DISPATCHED.V1]",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
         "SampleAfterValue": "2000003",
@@ -42,13 +42,37 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index 1db73e020215..5250a17d9cae 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -39,6 +39,16 @@
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
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
         "EventCode": "0xB7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index f9876bef16da..df6032e816d4 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -799,6 +799,7 @@
         "BriefDescription": "INST_RETIRED.MACRO_FUSED",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -807,6 +808,7 @@
         "BriefDescription": "Retired NOP instructions.",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
+        "PEBS": "1",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
@@ -825,6 +827,7 @@
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
@@ -1106,6 +1109,16 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL. [This event is alias to LBR_INSE=
RTS.ANY]",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PEBS": "1",
+        "PublicDescription": "Counts the number of LBR entries recorded. R=
equires LBRs to be enabled in IA32_LBR_CTL. This event is PDIR on GP0 and N=
PEBS on all other GPs [This event is alias to LBR_INSERTS.ANY]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
         "EventCode": "0xcc",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 4d1deed4437a..b4adaa1b5e9e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.23,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.24,alderlake,core
 GenuineIntel-6-BE,v1.23,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v28,broadwell,core
--=20
2.43.0.687.g38aa6559b0-goog


