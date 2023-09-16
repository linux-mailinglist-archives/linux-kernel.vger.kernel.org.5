Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1F7A2E02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 07:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjIPFOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 01:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjIPFOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 01:14:41 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C31BCA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 22:14:35 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-576925c8921so4159258eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 22:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694841274; x=1695446074; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tXRHlI9ZNBzJbKyCCf208PmLY3dd58UGrNzpu6NmY0=;
        b=NiQG10C8k1juBa9jxoLwOchuucPwNOvNFGx7J3o7Y1LJpkTVHp09+Xu7HGZnpi1rei
         xn4pK6554HZvwpJInsCBGK1eD+05ygLiWYtwUXNKxiQPE6U40tyPbemihioJyNaPDJcc
         gTD9WLk4EYYBZ2KpqmtVPrWYCMmhIckr2NxPRPBnXIwdolSfOANaT8tvGVivplSTeYKP
         gY8tOeSyuX5j+LhmiJ6T/uU5c7ohqDxe9qPHWC8WHVa6eNUQLWCDi8HGBA09NC/3lxKx
         2oZeWuME//0Ngb1eFXIut/woNO4JFNL3ofGrYQa7nhHtNrZreLuC5WpM7t6wl/Qrb5GI
         01mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694841274; x=1695446074;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tXRHlI9ZNBzJbKyCCf208PmLY3dd58UGrNzpu6NmY0=;
        b=hztxTwFshxIim/8h/vVfCrqYbpe9YQeOgiF9Y/gEVSjBAZUlQWzpryzQzD7RNGUWoQ
         LcZC75OyK2ds7sJEF0jG0cWKfXCxF+MAVJnfo4aSYPStjS7eB6cplsc/QsHbdSlo4dYx
         DMjBUDfaNWgHUSjyrEP2gFo+D07RoqMItGD6VW60AyXJFCZdHIPRt3OChXJkd4gs1fC7
         guEBSpTu0sdnGShLGemlVFiYC5cysV1Lcd05mkxNarjsTPcb0fmqU7efimw1yTmZUrEF
         7YrUNcmX6qHcQYpL1sH8FYRAU51lC40QrqdmXX5whe4sq4JqNOX4UzkZw0Kflwy4+iCS
         rRNg==
X-Gm-Message-State: AOJu0YxdEabk6Z3qWuIcKQ/ZDzMzsYXL39Tna/9UF6xzqe6qkJCBxCwX
        XWMDtKGyiK4a1ovd0zyZs9OpQVJNag0z
X-Google-Smtp-Source: AGHT+IHR9OdEbydME9iJBJUyTI1j0yW4Mp+g3xizv9xOlxgWrGnKb+Ry9J023mWmE+A0LJFbxJwhyN0RG1cZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:de72:1a43:1938:6165])
 (user=irogers job=sendgmr) by 2002:a4a:3749:0:b0:571:2c40:e2a5 with SMTP id
 r70-20020a4a3749000000b005712c40e2a5mr1441863oor.0.1694841274663; Fri, 15 Sep
 2023 22:14:34 -0700 (PDT)
Date:   Fri, 15 Sep 2023 22:13:07 -0700
Message-Id: <20230916051310.1124098-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 1/4] perf vendor events intel: Keep json in sync
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream is using the spelling "inflight" rather than
"in-flight". Update to keep in sync.
Fix typo on ivybridge.
Bonnell version is v5 with typo fixes.
Westmereex typo fix and version bump.

Update created using:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/haswell/memory.json           | 2 +-
 tools/perf/pmu-events/arch/x86/haswellx/memory.json          | 2 +-
 tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv                   | 4 ++--
 tools/perf/pmu-events/arch/x86/westmereex/pipeline.json      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/per=
f/pmu-events/arch/x86/haswell/memory.json
index df44c28efeeb..2fc25e22a42a 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -62,7 +62,7 @@
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data in-flight in the pipeline.  Machine clears can have a significant perf=
ormance impact if they are happening frequently.",
+        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/pe=
rf/pmu-events/arch/x86/haswellx/memory.json
index d66e465ce41a..2d212cf59e92 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
@@ -62,7 +62,7 @@
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data in-flight in the pipeline.  Machine clears can have a significant perf=
ormance impact if they are happening frequently.",
+        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json b=
/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
index 87c958213c7a..89c6d47cc077 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
@@ -73,7 +73,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULsand IMULs, FDIVs=
, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish =
an FADD used in the middle of a transcendental flow from a s",
+        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULs and IMULs, FDIV=
s, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish=
 an FADD used in the middle of a transcendental flow from a s",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.X87",
         "PublicDescription": "Counts number of X87 uops executed.",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 57ba7e814563..51c64ac2b9f7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.21,alderlake,core
 GenuineIntel-6-BE,v1.21,alderlaken,core
-GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
+GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v28,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
@@ -35,7 +35,7 @@ GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.13,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
-GenuineIntel-6-2F,v3,westmereex,core
+GenuineIntel-6-2F,v4,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/westmereex/pipeline.json
index 1c61d18a4b5f..026236558d05 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
@@ -45,7 +45,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "BriefDescription": "Early Branch Prediction Unit clears",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.EARLY",
         "SampleAfterValue": "2000000",
--=20
2.42.0.459.ge4e396fd5e-goog

