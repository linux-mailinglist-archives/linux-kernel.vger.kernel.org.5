Return-Path: <linux-kernel+bounces-85887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC5A86BCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED50286643
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7298956B78;
	Thu, 29 Feb 2024 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRywBCjv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B254FA0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165768; cv=none; b=IQaCx6L7P4B7vkdpDNQJDNQTBMYjPjyF5qCJYHEJCEwz3gmxv344Q40V22GkY+pgK6IJwXelllP4oJE1DsJ0w8uBlSLC+ql12/Z9D8C5jQHuKyFAN8Acw4iNf7/0c9fSxuOMv7TDxxBgaR9IJ1kl7oKdv0KhlAM30a8rLZXiSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165768; c=relaxed/simple;
	bh=D/pwwQ6dXV1q6dCmwwHAP89kxtCQNH4Hvs09U28fH3I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q1jvF69/JQ42jGiayRuGg/dK9cAfv+9ptIU7uDpZUJsaM0le1lwvIfR8cUR+kzX+0S6F/qsQJ6Xp5in5EikqlObWPrSjbNJrhN5Bi/M2LBd2tCmtOFPbOp/doyIidcvhk6YYnM2QXFWX0e8TlafAQ55Tv+2ySXgtYswULIfhbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRywBCjv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso695632276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165766; x=1709770566; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riQkIrg8TOM4HvcpMUBBinltQ/7KCgNPQM/xCcL0170=;
        b=hRywBCjvzfJZQOkn13J2PPQ2wZr8CbjfKRuR27Xw0UmfDORncBjZyHz9+f2frDNmJ6
         mOFj8fmQXzCiOqAnTytXUq6ALHqALr2TaaSkmZAeGJY2MQP4KeYO7ie/b5MQ9rq5pCBv
         L5yXbv27K7YcrEOV6+ZlUuV5UOTcIZGG8wMAHW858OMrIh4T84YeoMN0vLkGPLe4iHdw
         flpm0cdTst7Qc7ruI5sH2GnFis/vSMDasXeCSLGE5f4y7N+mex1/hIm4D1fDt5IYfg7L
         7lOoXvQH6sjOw7ksqTY0OdETl925SKVRyZjN8zqj7eiMGcPGijsCjaLTfiya5AUwuYIS
         tTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165766; x=1709770566;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riQkIrg8TOM4HvcpMUBBinltQ/7KCgNPQM/xCcL0170=;
        b=QOCuu9NAEOb2LZiIqYgNhKbFB4y8T3OjsI19g1Y0Sf16jsWTTlyJARaGtoQAJQ6QPy
         G8usP6RKsmtrgoMvuKrMy+TSfEMeW86gNRM2Kah5M99A9f26UCQ0L6g5rLQDKQchs8Ut
         Q568FfBDzAkONiIsfvEiG/CXr6mWuYNdTqBFuRcwGHCIrU4zSAbm3QQoiGMzRONh/Z/w
         jU5IApyaz7ur33lO/n4UNKBNfrXzGCpU88LJNQAU/Kl5Ju5+bAQivLo+LSYbsxBoXTfl
         2jHOdjRUTszrrOuWah6ZyWdwcUOVjyCw164x4mLHo3YAk2CFoGSScjt8891MeJAhR9Ix
         HJLg==
X-Forwarded-Encrypted: i=1; AJvYcCXrV7IZo5O134r1NwIk3nmLiDSxg3sFUVtLBhZfyuI/c2j41hnKaoXH4NwqjeNPFIaynCyNfFDhGhV7f7c+Z2m5HtlOp62TBbdBfuJ3
X-Gm-Message-State: AOJu0YxKbNZTG3rr/rR13g9pyyroBy+4p2+iTWpHFzYM3MevtRqk4f4R
	ppvpJoJzrYgZ5wkTth2ViV7bJNjwMJJk0TBN+mNsp1vIlynkJqqXEGAw5ZA7Ds3+E7NSzEh0MUt
	5ltb6lw==
X-Google-Smtp-Source: AGHT+IEqtMZCfxMSvox8V4nqHhkgVxXr5mj38dIUlzjcsrQxskTLGbitOmZ8bJEduB0W0nBj4TnAA5VqRz4g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a25:abc5:0:b0:dc6:eea0:1578 with SMTP id
 v63-20020a25abc5000000b00dc6eea01578mr195854ybi.13.1709165766077; Wed, 28 Feb
 2024 16:16:06 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:34 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 10/13] perf jevents: Add load store breakdown metrics ldst
 for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index f4a4ece551ef..6b182a9bbfe5 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -278,6 +278,80 @@ def AmdItlb():
   ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+  ldst_ld = Event("ls_dispatch.ld_dispatch")
+  ldst_st = Event("ls_dispatch.store_dispatch")
+  ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+  ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+  ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+  ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+  ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+  ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+  ldst_cyc = Event("ls_not_halted_cyc")
+
+  ld_rate = d_ratio(ldst_ld, interval_sec)
+  st_rate = d_ratio(ldst_st, interval_sec)
+
+  ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+  ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+  ld_v3 = ldst_ldc3
+
+  st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+  st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+  st_v3 = ldst_stc3
+
+  return MetricGroup("ldst", [
+      MetricGroup("ldst_total", [
+          Metric("ldst_total_ld", "Number of loads dispatched per second.",
+                 ld_rate, "insns/sec"),
+          Metric("ldst_total_st", "Number of stores dispatched per second.",
+                 st_rate, "insns/sec"),
+      ]),
+      MetricGroup("ldst_percent_insn", [
+          Metric("ldst_percent_insn_ld",
+                 "Load instructions as a percentage of all instructions.",
+                 d_ratio(ldst_ld, ins), "100%"),
+          Metric("ldst_percent_insn_st",
+                 "Store instructions as a percentage of all instructions.",
+                 d_ratio(ldst_st, ins), "100%"),
+      ]),
+      MetricGroup("ldst_ret_loads_per_cycle", [
+          Metric(
+              "ldst_ret_loads_per_cycle_1",
+              "Load instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_loads_per_cycle_2",
+              "Load instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_loads_per_cycle_3",
+              "Load instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("ldst_ret_stores_per_cycle", [
+          Metric(
+              "ldst_ret_stores_per_cycle_1",
+              "Store instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_stores_per_cycle_2",
+              "Store instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_stores_per_cycle_3",
+              "Store instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("ldst_insn_bt", [
+          Metric("ldst_insn_bt_ld", "Number of instructions between loads.",
+                 d_ratio(ins, ldst_ld), "insns"),
+          Metric("ldst_insn_bt_st", "Number of instructions between stores.",
+                 d_ratio(ins, ldst_st), "insns"),
+      ])
+  ], description="Breakdown of load/store instructions")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   if zen_model <= 1:
@@ -488,6 +562,7 @@ all_metrics = MetricGroup("", [
     AmdBr(),
     AmdDtlb(),
     AmdItlb(),
+    AmdLdSt(),
     AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
-- 
2.44.0.278.ge034bb2e1d-goog


