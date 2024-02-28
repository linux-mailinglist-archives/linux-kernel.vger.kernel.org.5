Return-Path: <linux-kernel+bounces-85410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82786B585
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9125CB25B29
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D615A495;
	Wed, 28 Feb 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoktejPe"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE411159587
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139936; cv=none; b=XW/KUflXBYyw9nfD0FnPguj6atguRomvJ963FLAoCzBG9pBJbDBXZo9hHmcYZvrPQgey4DCJ+vdC86Khmjauu/ipGplyTewY5aUhW5GimtdTOfx4dlbxmzUw/dj1PyHWjf0zJbjNPH4Oc27UQDKPHq/ROYUh24hUipKo869KjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139936; c=relaxed/simple;
	bh=CGNVl1yntelS93SRa2FQ4R4t6gT7zArzOIYeRfoGSSA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=rEd/rKFQU07QF89wf0nPhYwlnPathFDlGCs2Nw8jouN3OXMJZe+ZfD6bQxRBPfkedD+5Wm94wBGVWXDKG0ziLs0E25i7qkyEEh89U/w/WFgn0KRZbn0vYOrR9s3fiO02Lk5EbNBqi8G6u/ME6fFg5ega0etqHQiWL2IRHOI4xUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoktejPe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6092bf785d7so34201587b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709139934; x=1709744734; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rlBY/OoodbzJWhTdRz6v+xLO0aRj/YC+4a2jI2PqTas=;
        b=BoktejPePBAu/W66UCse9lsR8wSU0A1am13OeMCCaKrIG+LwvDUxulvPVBvfOZTI/F
         Yb3WfOosqmlgzF6Pc/cNj6BLnbhkhTT39oOPOye2Xrn+s96FSSEedjdvNpwu8pe3eUPV
         XtGE/yKEuR9nM4okrr1G3D1bBdJhGgpM9yzhjv+8V9EVKjpjlP3VPg6GMuFkHwlB83cb
         oav7TkuTH/MvmBBh4lgIOzeU4R0sMcBGWaopx+oaf4iN6p6MJ0pbgxcNPEzvU1ODaAoQ
         1hQFaasg/ZN0Dk66ciJNEn9i9fQ9KFIkS6aj5CELpKkPS6W/eEUIWWmv4C8LDnNbo8rt
         flEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139934; x=1709744734;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlBY/OoodbzJWhTdRz6v+xLO0aRj/YC+4a2jI2PqTas=;
        b=RmFMzWE6GW8RcZP+8RI4ijhyBYxEptM6XexSCh/CwmDXN1NAkUnHsCFgrSVl1zp7Zd
         QtGHFb8D9dW3KrdCBkuV6d2bAqQuoo+OsV9zjnhOnqALzxUy2dTho+UMDQntRMAc9YMZ
         74oyz+cGFLC+U11Eoi/cSPepCexMxzVLKATf67e7Qpc2oAh73XP4/grBsOHVIne4zRd+
         J7kUCnPDSrkmNoYTUqTdvUT6ytjC/IGZ4JTYsRdoHf0zoiBR21oIGhnhGo6MHtl36k/j
         eo6mpbxOXiz6PP9eN9VfC0TuWIIuyBCtdNEwg9bLYYKDZdCeYXfLFo/RWKCDq7X5/3d8
         ncRw==
X-Forwarded-Encrypted: i=1; AJvYcCV6rNOKVxyaNS/3O7hVh65/Juj4RGzJ58iv47fle4cvEFJ4ue454JmNlob/b8PWa0TZARtpz6fcaIq7dm3cUFuteLwKebWhE4i8ZXoP
X-Gm-Message-State: AOJu0YzY8qDjQB8B6B0SSHh+YorhNbIkz1ibNvzv+/wZTjajUF1xEuKS
	MiKI4DpUGGPFBVl9IOdGv1qD3NAttAZBmQZqprhltIcPKqgt4I1LES2fZ8vYeP5+lyTVGiZX0j5
	VbdhjHw==
X-Google-Smtp-Source: AGHT+IHxor78JFy4AzL6UV+OeplFnDykbvcR6TtFwAIxwl0Ue4USuowIYzhe50M6eNIVQBoWXYwJqUI6cWS4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a0d:d54f:0:b0:609:3834:e0f4 with SMTP id
 x76-20020a0dd54f000000b006093834e0f4mr836786ywd.7.1709139933744; Wed, 28 Feb
 2024 09:05:33 -0800 (PST)
Date: Wed, 28 Feb 2024 09:05:29 -0800
Message-Id: <20240228170529.4035675-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2] perf vendor events intel: Add umasks/occ_sel to PCU events.
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

UMasks were being dropped leading to all PCU
UNC_P_POWER_STATE_OCCUPANCY events having the same encoding. Don't
drop the umask trying to be consistent with other sources of events
like libpfm4 [1]. Older models need to use occ_sel rather than umask,
correct these values too. This applies the change from [2].

[1] https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/events/in=
tel_skx_unc_pcu_events.h#l30
[2] https://github.com/captain5050/perfmon/commit/cbd4aee81023e5bfa09677b1c=
e170ff69e9c423d

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2 corrects BDW-DE, BDX, HSX and JKT to not use umask but occ_sel.
---
 tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json  | 3 +++
 tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json   | 3 +++
 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json | 3 +++
 tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json     | 3 +++
 tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json     | 3 +++
 tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json      | 3 +++
 tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json     | 3 +++
 tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json     | 3 +++
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json   | 3 +++
 9 files changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
index 83d20130c217..320aaab53a0b 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
@@ -394,6 +394,7 @@
         "BriefDescription": "Number of cores in C-State; C0 and C1",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "Filter": "occ_sel=3D1",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
@@ -402,6 +403,7 @@
         "BriefDescription": "Number of cores in C-State; C3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "Filter": "occ_sel=3D2",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
@@ -410,6 +412,7 @@
         "BriefDescription": "Number of cores in C-State; C6 and C7",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "Filter": "occ_sel=3D3",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
index 83d20130c217..320aaab53a0b 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
@@ -394,6 +394,7 @@
         "BriefDescription": "Number of cores in C-State; C0 and C1",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "Filter": "occ_sel=3D1",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
@@ -402,6 +403,7 @@
         "BriefDescription": "Number of cores in C-State; C3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "Filter": "occ_sel=3D2",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
@@ -410,6 +412,7 @@
         "BriefDescription": "Number of cores in C-State; C6 and C7",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "Filter": "occ_sel=3D3",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
index c6254af7a468..ceef46046488 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
@@ -144,6 +144,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
+        "UMask": "0x40",
         "Unit": "PCU"
     },
     {
@@ -152,6 +153,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
+        "UMask": "0x80",
         "Unit": "PCU"
     },
     {
@@ -160,6 +162,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
+        "UMask": "0xc0",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-power.json
index daebf1050acb..c391325ee36b 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
@@ -426,6 +426,7 @@
         "BriefDescription": "Number of cores in C-State; C0 and C1",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "Filter": "occ_sel=3D1",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
@@ -434,6 +435,7 @@
         "BriefDescription": "Number of cores in C-State; C3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "Filter": "occ_sel=3D2",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
@@ -442,6 +444,7 @@
         "BriefDescription": "Number of cores in C-State; C6 and C7",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "Filter": "occ_sel=3D3",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/uncore-power.json
index ee4dac6fc797..920cab6ffe37 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
@@ -151,6 +151,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C-State : C0 and C1 : Thi=
s is an occupancy event that tracks the number of cores that are in the cho=
sen C-State.  It can be used by itself to get the average number of cores i=
n that C-state with thresholding to generate histograms, or with other PCU =
events and occupancy triggering to capture other details.",
+        "UMask": "0x40",
         "Unit": "PCU"
     },
     {
@@ -159,6 +160,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C-State : C3 : This is an=
 occupancy event that tracks the number of cores that are in the chosen C-S=
tate.  It can be used by itself to get the average number of cores in that =
C-state with thresholding to generate histograms, or with other PCU events =
and occupancy triggering to capture other details.",
+        "UMask": "0x80",
         "Unit": "PCU"
     },
     {
@@ -167,6 +169,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C-State : C6 and C7 : Thi=
s is an occupancy event that tracks the number of cores that are in the cho=
sen C-State.  It can be used by itself to get the average number of cores i=
n that C-state with thresholding to generate histograms, or with other PCU =
events and occupancy triggering to capture other details.",
+        "UMask": "0xc0",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index 5df1ebfb89ea..ad6c531a9e38 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -514,6 +514,7 @@
         "BriefDescription": "Number of cores in C-State; C0 and C1",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "Filter": "occ_sel=3D1",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
@@ -522,6 +523,7 @@
         "BriefDescription": "Number of cores in C-State; C3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "Filter": "occ_sel=3D2",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
@@ -530,6 +532,7 @@
         "BriefDescription": "Number of cores in C-State; C6 and C7",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "Filter": "occ_sel=3D3",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index b3ee5d741015..6f98fc1728e6 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -233,6 +233,7 @@
         "BriefDescription": "Number of cores in C0",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "Filter": "occ_sel=3D1",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
@@ -241,6 +242,7 @@
         "BriefDescription": "Number of cores in C0",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "Filter": "occ_sel=3D2",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
@@ -249,6 +251,7 @@
         "BriefDescription": "Number of cores in C0",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "Filter": "occ_sel=3D3",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-power.json
index c6254af7a468..ceef46046488 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
@@ -144,6 +144,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
+        "UMask": "0x40",
         "Unit": "PCU"
     },
     {
@@ -152,6 +153,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
+        "UMask": "0x80",
         "Unit": "PCU"
     },
     {
@@ -160,6 +162,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
+        "UMask": "0xc0",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
index a61ffca2dfea..dcf268467db9 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
@@ -150,6 +150,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C-State : C0 and C1 : Thi=
s is an occupancy event that tracks the number of cores that are in the cho=
sen C-State.  It can be used by itself to get the average number of cores i=
n that C-state with thresholding to generate histograms, or with other PCU =
events and occupancy triggering to capture other details.",
+        "UMask": "0x40",
         "Unit": "PCU"
     },
     {
@@ -158,6 +159,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C-State : C3 : This is an=
 occupancy event that tracks the number of cores that are in the chosen C-S=
tate.  It can be used by itself to get the average number of cores in that =
C-state with thresholding to generate histograms, or with other PCU events =
and occupancy triggering to capture other details.",
+        "UMask": "0x80",
         "Unit": "PCU"
     },
     {
@@ -166,6 +168,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C-State : C6 and C7 : Thi=
s is an occupancy event that tracks the number of cores that are in the cho=
sen C-State.  It can be used by itself to get the average number of cores i=
n that C-state with thresholding to generate histograms, or with other PCU =
events and occupancy triggering to capture other details.",
+        "UMask": "0xc0",
         "Unit": "PCU"
     },
     {
--=20
2.44.0.rc1.240.g4c46232300-goog


