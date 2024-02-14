Return-Path: <linux-kernel+bounces-64640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526F854116
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7CD1C2863E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37021171A;
	Wed, 14 Feb 2024 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usAlYD+k"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328D111A4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873540; cv=none; b=FLyDcaIUct4lhKifjxCxcuQx4e+yti7W6tCOoQdjfTXioW84b6ZJml97NoaS3YO+Nwmcc/sb+LHSJMhlhq1j+e9xla8hoMvLp5HT9TJ4Vb5NdBxB3T88MwvO1YqCBgOisCVsqD2MOJG9WkImWbXGIdKVCuKTonmX8NtzKhy9q/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873540; c=relaxed/simple;
	bh=RHI6z42Zh5d8W3cRQXQqriHAWaY+WIFJ7/pAR7QTFqk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Q377W4pGQtpMY2SzGOEsbUcz9n7PEr1jBRKaRgt0nHGSS3jDcHh5NKM/f11E3M/Haei7UM0X1trP6VZ+gBDPNGJ/fIbHaQToq9e0fuB1UwfHnHk37pbs9IiF6LZK5lGpkhwM/5UbYits+pQXshSiS0+cAMDA0d8IWuoS0R83Uxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usAlYD+k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so6183649276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873537; x=1708478337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqMG7Ig9b2SfPVPlsM/7MDC+R0Aj67PbG962+6WBmz0=;
        b=usAlYD+k2+VvMgJ7cae9BNvWJSGR2VAPRbCQFxjqaD7bZ/jla9P9o2W60uRAahn1S9
         t0PsMAMEdkvQ3ebYGa/twTA/l25wDSxHq1jE2nl38y6RCzPbGPcS+sNz93MY20Oj8TmX
         TaWZjfMr1++6VF2UDVdKYDu/VgzY/NwiEvtS48DKE3fKgBNFRw6b/RQYpWz9BT0QHSNF
         eTOlsx9TPa58oR1TK4aIFrt84kWO8tqaW9Fdo71oivz00AMtyNsrAQBKBZCgL++U83Oy
         EeCRZeVaSjR+FEz7iWFQGaqGZ9Wi1ntOGRHStFvX/90yi0JaxlRhhNJkl0m/TkDJupPs
         bsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873537; x=1708478337;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yqMG7Ig9b2SfPVPlsM/7MDC+R0Aj67PbG962+6WBmz0=;
        b=rtopVu7KLY7nTMwxQoZ8W3pyZqhuiCV4EB0nLdM8v6obHPyoqAT4u80ZNczxMsu0AU
         8Tp/9NYhfQJqY55xO6z+lH76PHUG3SPPFBBq/wkzasRxH8vF0oSUwsudS+jq9C48METD
         RXOI4rFg5tJ6CEQORXMHFfsXj3ALayqNMIvf4Y7xr3oUQX4yDzBJetZGlD4Q60eA7pLp
         za3tVC4tlxNn7070NMb5w5h2I1OePZzcXpjxic2n1Y3SzdbKId+gvv76ggDiBchy7d4d
         4bAWclT/Xvoo+Yzk11eePKHh5PKTaBfm1dH1YbsLXB84XR9jrWaxWBc9UQrcNL0ZDbtz
         jQTw==
X-Forwarded-Encrypted: i=1; AJvYcCWaOM7J2t3xjHsoMF31Zuoa6aQjRHmNVEBZrvpL3OFW9T6xWXB1eG9FTuUPUH/70VNOH1ptzG6GRgQs2m7FIqG6sC9LqiStVAd6s/8N
X-Gm-Message-State: AOJu0YxwW6eseJPzChVvYzaCwU1FvxTOemstBtFeqQ5fO9Ornk5rZ3RY
	i0ULUKblJRGyxTQThS4VHoEQ4oyadBW9JXWXHG9A8Jnsu9AWAWg7PXLSaZ2Pm5d1zohkG/Dr0fx
	Ir2dVGg==
X-Google-Smtp-Source: AGHT+IFfiu9PGWO8iWx9awY+c/iA7wRH6gb0i5ccxp9fiVpalNjA9+Bu6fhnJuFR5tXOrF3/jOOBtYViO6fD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a25:ac18:0:b0:dc6:ebd4:cca2 with SMTP id
 w24-20020a25ac18000000b00dc6ebd4cca2mr33135ybi.11.1707873537303; Tue, 13 Feb
 2024 17:18:57 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:58 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 09/30] perf vendor events intel: Update rocketlake events
 to v1.02
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

Update alderlake events to v1.02 released in:
https://github.com/intel/perfmon/commit/4931178d1ede1099a3e4ac7e04ed9f073e0=
3d219

Improves documentation and removes TOPDOWN.BR_MISPREDICT_SLOTS.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv             |  2 +-
 tools/perf/pmu-events/arch/x86/rocketlake/memory.json  |  1 +
 tools/perf/pmu-events/arch/x86/rocketlake/other.json   |  2 +-
 .../perf/pmu-events/arch/x86/rocketlake/pipeline.json  | 10 +---------
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 09145aaa0d8e..be9f342b3206 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,7 +24,7 @@ GenuineIntel-6-BD,v1.00,lunarlake,core
 GenuineIntel-6-A[AC],v1.07,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-GenuineIntel-6-A7,v1.01,rocketlake,core
+GenuineIntel-6-A7,v1.02,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.17,sapphirerapids,core
 GenuineIntel-6-AF,v1.00,sierraforest,core
diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/memory.json b/tools/=
perf/pmu-events/arch/x86/rocketlake/memory.json
index e8d2ec1c029b..f84763220549 100644
--- a/tools/perf/pmu-events/arch/x86/rocketlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/rocketlake/memory.json
@@ -259,6 +259,7 @@
         "BriefDescription": "Number of times an RTM execution aborted.",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
+        "PEBS": "1",
         "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/other.json b/tools/p=
erf/pmu-events/arch/x86/rocketlake/other.json
index cfb590632918..4fdc87339555 100644
--- a/tools/perf/pmu-events/arch/x86/rocketlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/rocketlake/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/rocketlake/pipeline.json
index 375b78044f14..c7313fd4fdf4 100644
--- a/tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json
@@ -529,7 +529,7 @@
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
@@ -552,14 +552,6 @@
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
--=20
2.43.0.687.g38aa6559b0-goog


