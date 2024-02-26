Return-Path: <linux-kernel+bounces-82282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF028681C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F03287E53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C19130AC5;
	Mon, 26 Feb 2024 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYwXQLkx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65481F94C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978527; cv=none; b=mpj2NFnwnIRJ7EAa93DVzSqH6aOt+4n5wacbaQEt3hCVFXRF1tYY0iPlgqjvtUjBCEkA3UNN3H1rDHgiS3tugpsrKOvT/tipmklnteXpuWOQDpudk1+5xTmnwK1n/kPAhIarUg225eDOUxGJ0IoZiMHn4cDMZim4uPbCjAGY3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978527; c=relaxed/simple;
	bh=NNiM3D/uuKlEcf27+1HPpmPCZhZ9boOWuiyiscV8lX8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=bDrrml0gOpjdX72ZjLoPgedVnI3rAf/EJm9A3LnpbRkDNBhhLhnTQKrX+D7sSTh+87Q9e52Zw6yIeQ3MPHiAtZRo5G+zUnLPpJMy3jWdMMU1u/uf2naQtdHfZb012dt3Ml685utOw4UuDIWfWR0erYeOdK5bqXuaWJs5ov0RsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYwXQLkx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so5662233276.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708978522; x=1709583322; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjvMMh1/RPX49toTuJH8e40Pdvy8Pa7opxy8T5kBAfs=;
        b=YYwXQLkxc86C45B9nShCBz2zWAa35uIzSR1NEFcMUkuT+XcObb4+dfCtDAm16/KFTC
         JdshRtof+S4gyu+S4LtOOhcE7KmgYnYn63iaRDzx9XnbPCN38qEkR2tlN8Gj/EnC+1er
         sKSqU7ksnAsUwbH6iemq93iwaUR7VaPk9B8Pi8P9yYpdlGEi7djmAD7Y7dsRZPpmyFlj
         M5UUOP1hui1Z70vk9ASPWNUcCRjDtSySFZpp67GLsfn9ZeAqdExrQlbuMjs2SYc/53L0
         RaS/ZdkaMkIOOa1WuiOmuPVb0JCvbnPMjMlmWXjuql6xzmPzMi2soeraaW5ZZ3N2Ge0U
         BscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708978522; x=1709583322;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjvMMh1/RPX49toTuJH8e40Pdvy8Pa7opxy8T5kBAfs=;
        b=Roh8Ney8idta8mJpfZ9pnGYNRdybcMAHHBngsp7RmeiWutpNt+mTr572qzOiuCe5TO
         wSH3wYKzaobynWj3sRI8wWUAqCPm2uNcAU2bsjUXNqX6u+uZwtnVHZAW1jKAsWZ9mHGe
         nsw7vaQgCvFwulS5kWAXnLHiNAe8m96xiJBxgLX11vtq/R8ccGdQKTCMywspsLq7bQcC
         hbmT/EQN1eIYf1YI/KUR86cFyIPZqLAb3aWVYU3MsVmM+DsaCKu8Y1mYIaQdxc7dNfD7
         6e+Su1Cby3yGofWXHBXAfDhUkQv9wNVlGPW2HbrOK+Jl3z7SikzbWfZrRupZg1H7GPDa
         Gf5w==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZvZx6d5lnj4RWL0ElFMTtjY/LY/g8LuJCoKXy6lJCAp3IA3iZNqL6WwTBLq5pXWM5IM+c0bbp1ixlfbbI2XmkTsIEZPQP5/MR91q
X-Gm-Message-State: AOJu0YwdKx2oyur44luFP2F/H/gJqMfigHhHF5ipibQ9aMlxzrWbEuR/
	RnhwcoRt6x4O9WELoSFMCbvkDEYswIQuNGGY5tBxxH1fJTN8KYn/RGGKYH8UJFRXu6mHeTTcUdy
	OAeT5TQ==
X-Google-Smtp-Source: AGHT+IE+emjy60hBbgDbHhq9WioYQLq3zd0RxFYNdOL0bVnjPK4zFyOfoPjjc+B5u9tbxY1FHDk1fE6eSGvD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:637a:6466:7021:bcc5])
 (user=irogers job=sendgmr) by 2002:a25:4f08:0:b0:dc7:68b5:4f21 with SMTP id
 d8-20020a254f08000000b00dc768b54f21mr66802ybb.9.1708978521983; Mon, 26 Feb
 2024 12:15:21 -0800 (PST)
Date: Mon, 26 Feb 2024 12:15:17 -0800
Message-Id: <20240226201517.3540187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v1] perf vendor events intel: Add umasks to PCU events.
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
like libpfm4 [1]. This applies the change from [2].

[1] https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/events/in=
tel_skx_unc_pcu_events.h#l30
[2] https://github.com/captain5050/perfmon/commit/661a229996493448095fb5541=
5ed568ceabc631b

Signed-off-by: Ian Rogers <irogers@google.com>
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
index 83d20130c217..9a0bc34c08e1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
@@ -396,6 +396,7 @@
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
@@ -404,6 +405,7 @@
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
@@ -412,6 +414,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
index 83d20130c217..9a0bc34c08e1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
@@ -396,6 +396,7 @@
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
@@ -404,6 +405,7 @@
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
@@ -412,6 +414,7 @@
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
index daebf1050acb..15097511cbd8 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
@@ -428,6 +428,7 @@
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
@@ -436,6 +437,7 @@
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
@@ -444,6 +446,7 @@
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
index 5df1ebfb89ea..4dac5810324b 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -516,6 +516,7 @@
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
@@ -524,6 +525,7 @@
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
@@ -532,6 +534,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index b3ee5d741015..a83e07dce947 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -235,6 +235,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
+        "UMask": "0x40",
         "Unit": "PCU"
     },
     {
@@ -243,6 +244,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
+        "UMask": "0x80",
         "Unit": "PCU"
     },
     {
@@ -251,6 +253,7 @@
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
         "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
+        "UMask": "0xc0",
         "Unit": "PCU"
     },
     {
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


