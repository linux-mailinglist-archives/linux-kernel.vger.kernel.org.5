Return-Path: <linux-kernel+bounces-64642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF4854118
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E151C2123D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8578E12B6F;
	Wed, 14 Feb 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGzUa0Zy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F98F44
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873546; cv=none; b=jCycoQgiR7kFPTpWAfL9hlzcQdskWlm+61FS49Y68oMRBCNZiCQz2zJP2bmB87Q5CUe+EQnkFVZLKXSeg7hDDT3DLpJ2/IW4Gwgxo9ikSOquBDu4V4ihYsJiNGe7Uakl80SGVJyJr2w9DrrkELGXn1oCGMeBwYu7BikMbc9J4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873546; c=relaxed/simple;
	bh=t83PfB9gdLEBq/7KpFAz0pY/7w79V68PjRNGS4Qjc/g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=KlE7S0wmGtroM9hyR3Fb/7AVY8uGE4cFiePgn/otPBr5ygY5YBIKHS/0EZkPE5loYulh0Ksu+xKvKwmbPoRdf9Wr1Hj+fJhOEmqTACFIgORNJ7UEJlW0zoLBC9BJzShazoK/HKrd5Ofheo96W7UivbZCFqzU6OgFA3n4xn7aeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGzUa0Zy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604832bcbd0so108458917b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873544; x=1708478344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEcT3AhPilnHKsyp/DEJlesAcXMiiR+WL2DzzZMLJ4M=;
        b=vGzUa0Zy0hC6UjOc0bBZFuN1IyN9HLI4ERjaASEo01rVLsrS+TSIayYSOCX/Ac+GJk
         YMQE426hOwXtWQOAyOJImbMvUcHYxqfX98Y9VdSTWPUsBxfO9WKhThllvqY5iRjnLPzY
         fC78jzl6tHQMWEoAPnLsfTTCVSTRLBLgbLbxjylwfDzujILIyed09vu5L7rOHZ31jvmB
         kLTl1l3xO3FEdWBVNxzXHDY8zVPPi8QHTUFis2ywtC5qASKNM78x31re66LSlwISfnXI
         lyW2G1nfkmgUGArVYNsNByHMP6/MTQMJuqOWSmYqOfJdN0MvfIBS0pvrQTQnLmAdTdA4
         f4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873544; x=1708478344;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FEcT3AhPilnHKsyp/DEJlesAcXMiiR+WL2DzzZMLJ4M=;
        b=ak3wsrsV1shNhKI5qqva30wgw56ZAuEaBB2araiKpJoFpWwrgvUnOMrld9wqZHWBx3
         YODOsyKHnY6OEe7x3htvRo+lucgY05Wv4vZbHZSwuiuXbz5LW2MbwiHk2vsYv12XPt4V
         MQbhX1RkMS3S7sHNDeL3B2/j8+E9MgLI2AynUXy1X+CM3Q8IChmMmWHkYPeOl782fvbn
         tc1aIM0O58+QD0Hl/kpPUw/Gccp3gClDsta0uEUe6beH0M2IxP1fVH9mkDTISgRnHvJx
         aZvLY/Z4I5otFVzLOkUZSl86E8idzwu0eNbjLOfphb9D9OipplKecyWU4+a+7vQT4izX
         ZUug==
X-Forwarded-Encrypted: i=1; AJvYcCWCcbBzLycLh2lFaJ8WZboJrVMonozPtWogLwV8TK3Y18KF/btBz/QJvRyWKO6G7475pB8LdQs+YY/Q1s4DKlE188qyv4jWOjygsJPc
X-Gm-Message-State: AOJu0YwrWe+tV2MzUP+qbahGZD7SSSIucwIwsy9lkDreuUcZ5fpEH03V
	BwT2+lhDmGJs10EXUv9kemz06tjLMOBaWIA/351yGmnlbaqv5I/UfEaEv5rnuoTz/1du2W8zPN1
	S702xrA==
X-Google-Smtp-Source: AGHT+IGLB1i974D6+aTyzDQcW0rj883ULCk6AmqgfxQcsLuGwJbcwvw46AUO2ECouXDrIOL81GJa7xSwuobv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a81:4e15:0:b0:5f8:b9b8:b120 with SMTP id
 c21-20020a814e15000000b005f8b9b8b120mr263572ywb.2.1707873544166; Tue, 13 Feb
 2024 17:19:04 -0800 (PST)
Date: Tue, 13 Feb 2024 17:18:01 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 12/30] perf vendor events intel: Update tigerlake events to v1.15
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

Update alderlake events to v1.15 released in:
https://github.com/intel/perfmon/commit/282a6951fd9f025cff6c8c0ea16b1fcec78=
6a4cd

Documentation fixes, removal of TOPDOWN.BR_MISPREDICT_SLOTS,
deprecation of UNC_ARB_DAT_REQUESTS.RD, UNC_ARB_DAT_REQUESTS.RD and
UNC_ARB_IFA_OCCUPANCY.ALL.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv             |  2 +-
 tools/perf/pmu-events/arch/x86/tigerlake/other.json    |  2 +-
 tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json | 10 +---------
 .../arch/x86/tigerlake/uncore-interconnect.json        |  2 ++
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 96b86d3b60ce..5297d25f4e03 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -32,7 +32,7 @@ GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v58,skylake,core
 GenuineIntel-6-55-[01234],v1.32,skylakex,core
 GenuineIntel-6-86,v1.21,snowridgex,core
-GenuineIntel-6-8[CD],v1.13,tigerlake,core
+GenuineIntel-6-8[CD],v1.15,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
 GenuineIntel-6-2F,v4,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/tigerlake/other.json
index 55f3048bcfa6..117b18abcaaf 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
@@ -19,7 +19,7 @@
         "BriefDescription": "Core cycles where the core was running in a m=
anner where Turbo may be clipped to the AVX512 turbo schedule.",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
-        "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server microarcht=
ecture).  This includes high current AVX 512-bit instructions.",
+        "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server microarchi=
tecture).  This includes high current AVX 512-bit instructions.",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index 541bf1dd1679..4f85d53edec2 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
@@ -537,7 +537,7 @@
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread",
         "EventCode": "0x5e",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
-        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into stravation periods (e.g. branch mispredi=
ctions or i-cache misses)",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -560,14 +560,6 @@
         "SampleAfterValue": "10000003",
         "UMask": "0x2"
     },
-    {
-        "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
-        "EventCode": "0xa4",
-        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by branch mispredictions. This event estimates number=
 of operations that were issued but not retired from the speculative path a=
s well as the out-of-order engine recovery past a branch misprediction.",
-        "SampleAfterValue": "10000003",
-        "UMask": "0x8"
-    },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
         "EventName": "TOPDOWN.SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.j=
son b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json
index eed1b90a2779..48f23acc76c0 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json
@@ -25,6 +25,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "Deprecated": "1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_DAT_REQUESTS.RD",
         "PerPkg": "1",
@@ -33,6 +34,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_OCCUPANCY.ALL",
+        "Deprecated": "1",
         "EventCode": "0x85",
         "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
         "PerPkg": "1",
--=20
2.43.0.687.g38aa6559b0-goog


