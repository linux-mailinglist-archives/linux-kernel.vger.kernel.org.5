Return-Path: <linux-kernel+bounces-64637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05A854114
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171201F28138
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621510A35;
	Wed, 14 Feb 2024 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdM/dEQf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DCFBFD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873535; cv=none; b=YtDCMr1enAABgevncNxE6QXPjt3REPTCQa5Szf/E3IKW69dDfsxNLDm3j780zxFMQ2/v4P675vF53f9GR3ljWm5G32OkoQwPdFm2Im47wDlctylyCXWPWxYwWLQmZXo5MWYgwmiD+q9xB9vPG1dlFxpWQ+cpn4SU6CPuQMslGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873535; c=relaxed/simple;
	bh=uIW5926euxSClNgLwOOE3S3ASDUyyd+u+xzLETiO+QQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=TaWQ8p6/F3WBjY/u03vtnlQTWDZBwkq4g/+vgMmK3wdsyT3aCy1m2XSZu6GOpc2yk+FJTMEDhI70r57NPCUeljJo/XIGcEYnARDunhx836bQU3iZfvsqvLw0S4W8KbVCG9h/2I8k8co0AMaCLYIlnEgWMIk8r7DAA8/aO2LpFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdM/dEQf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso7869574276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873532; x=1708478332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+z+qLiW7RyPe7mVik6F8hhmYqDxILH4Pd/J/NiEmYE=;
        b=LdM/dEQf71hsdzgBsk85WcA3OV3jnmDi1uoQnqqklhFOWMU7/pS4Tt4nvS+iYDuk4p
         ZtdvS7C0n3WJwTqP+Pz0Uw0W4N9jn1vxccvDfV0Nn4nEdm+VJ8myaJ3PhP3KDUHblmpW
         /IhuuehNaRtDkev7L1rNiH/+nxcrfqw5S39H2KFo6FI9tyWKIeO6WvhkWskU4V2Bs7Pl
         HGS4mEiW2Vma2XCkhVbUQXrNrZs1un+25FMPUzURDRWIXIGPPVRj8gBQ0LvmXBwk37N5
         6BWqJ/69D2serq9ccy+92NnqfPwFonwIm1DVFhO1Q4H3AegAPUyoG15zhdbE4OA+gdi8
         RU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873532; x=1708478332;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7+z+qLiW7RyPe7mVik6F8hhmYqDxILH4Pd/J/NiEmYE=;
        b=hz59J+uqHr/FVmwlrrSYCY2WRUFfrgjuhnKpZeeAgDsstdBXPHfP+q60LEMcwb7Xa3
         9tgYHjOnxRF1XxWgD87quk6InH2dZcOWVlKrSgH6FwuocLM7ByotafqykJ8sBT3dKpck
         9lmyJpIdkh0vhWNLKiEdvcAgC4bIfE1Si2Wiw6a3972Yo8uKwZMlO9Zvwp/QIVxx9BzZ
         Rf65On09k/NaFvLeLntqtAdQ/hn/oNZVt8tgQ62q00nEdRcu4h20wtfJx2ExMN/A9RWi
         8jYoNj7M1n0vXymz2GR7F1hzBIqz43eudSfn/n6AehuqfD7hdp6iS3KbHI7HjX5VkMoF
         kVuA==
X-Forwarded-Encrypted: i=1; AJvYcCWoT2TbbW2AwrjD+syGF0TYKKqqq6rJ5HRRfEsC06hsyrXGL4Pv5GlUFP2/1sBJrvdQdwIVM/hP5g5REPSJY727q+zeASlyVi9SgVQz
X-Gm-Message-State: AOJu0YyTR4dlDyP1zcBf9m+DZFRQoOnZvjMidMPkHUNnRS0y8V4e0TIi
	jPYMRij9N8PGBDxXC9K3tNeX0mDbWNMi4TL4CTWO+7q3ZcHiIQ4c1gLMhiOW0iUmLxPJ30K568g
	fEJ/RDg==
X-Google-Smtp-Source: AGHT+IGp2dMy/9qKaWYQ0k2nZdGVQKNtOm74ORmTTplytfKJvBA31H1BOGiRROjUNqvnhXdaa/docslQ82Hv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1885:b0:dc6:207e:e8b1 with SMTP
 id cj5-20020a056902188500b00dc6207ee8b1mr271997ybb.2.1707873532309; Tue, 13
 Feb 2024 17:18:52 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:56 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 07/30] perf vendor events intel: Update icelake events to v1.21
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

Update icelake events to v1.21 released in:
https://github.com/intel/perfmon/commit/54f1246b0496112c1d2b2a49e4859c85caa=
3dbf4

Improves descriptions, removes TOPDOWN.BR_MISPREDICT_SLOTS.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/icelake/memory.json   |  1 +
 tools/perf/pmu-events/arch/x86/icelake/other.json    |  2 +-
 tools/perf/pmu-events/arch/x86/icelake/pipeline.json | 10 +---------
 tools/perf/pmu-events/arch/x86/mapfile.csv           |  2 +-
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/memory.json b/tools/per=
f/pmu-events/arch/x86/icelake/memory.json
index e8d2ec1c029b..f84763220549 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/memory.json
@@ -259,6 +259,7 @@
         "BriefDescription": "Number of times an RTM execution aborted.",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
+        "PEBS": "1",
         "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf=
/pmu-events/arch/x86/icelake/other.json
index cfb590632918..4fdc87339555 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/icelake/pipeline.json
index 375b78044f14..c7313fd4fdf4 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 932d7c094e41..953e13a136a4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -14,7 +14,7 @@ GenuineIntel-6-B6,v1.01,grandridge,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v35,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
-GenuineIntel-6-7[DE],v1.19,icelake,core
+GenuineIntel-6-7[DE],v1.21,icelake,core
 GenuineIntel-6-6[AC],v1.23,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
--=20
2.43.0.687.g38aa6559b0-goog


