Return-Path: <linux-kernel+bounces-85885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E359686BCA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A3288548
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D3535A6;
	Thu, 29 Feb 2024 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPBT0UwO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083384597B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165763; cv=none; b=ZRgbCwA1pB8cCDxi8D7zmvcURT70zR4RndZcw08HLVwKWFXWJ6Q0LhldGSVbeQZdFuUSO9XYATgs3oefqXwmANiKEcbKuB/EBnjqAb1B2zdJNz5JB0mVdNbOL/A9CE4nmzbvfwQRj5wfubQPf5Q3g+DwLmm4iIu2nqiRLgnPGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165763; c=relaxed/simple;
	bh=XBT9PFw4GJEI1QEQOFY5V3VQlW/6wsuXkDB+REWJty8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RDT4kgnrJqE3UQjTLQcHPgd+jtphlMPftCvY+ui3t7r1tStFZAreN8FESU8Ai5yge8LQInuHKMEP0KBOzkTmZ13ZhqOWsCzc74oIZSKMOXmuEvUy6r3fIjU4pvFiNtgcZs+t4aqtiISbSsJvbGRhfzO1e16bBoOKXN/pspQNJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SPBT0UwO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e613a1baso6366057b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165761; x=1709770561; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QW5aXCnWYkSdBtfKb1tyFWz2NLyYuSqZgMPUtXRmNrc=;
        b=SPBT0UwOP189pEkqlR+5OWkMnB4O0Ss2w7sWMWEJZ6qyKbyNSUqOXsy511kMeegK9R
         tc5QFK2L5/8cTHbUz/pXvP614sWZUkr1U3sUqmBfLht04/HyiBSGXSteqjnyId3uCFHf
         udTL0DBSqmLuYyPxO8DVxYQnuTO2HcBOmAYBeaHImVJA9RMwrsYYMob+PFBLcijP4WHD
         gOqL++/tyht52ctGb1yauHQZ/u0KdJMisQXuMtsjhqiyG9MyDW9rLkQKTVEBfWuuKFY0
         uwwo0mpCG3X29V7wStOlHzBTL7vQ5Zr7DvywYnPqbholNCqMSBmxlTPW4m7Dd6XlpgV6
         paNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165761; x=1709770561;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QW5aXCnWYkSdBtfKb1tyFWz2NLyYuSqZgMPUtXRmNrc=;
        b=SJ/HI+LUdaztVU+zEJLIAB+lZC7iCqdECD9FHLfNRt1sOv8xgMxZf1m72asrM1/GKF
         houWQpN4PN+gPDPU+TcEyXsfEZFPV3DTrexEJz1a5XxmnrrpK77PDVt2u7+hNP7SfVqX
         LWxUK1nOH5qfXE6UOrOZlgYvnZUYuQgOCvnHgsSQGDIZDvcgoN8RJOWT1qSf3UnDNyOX
         jKMwfPwrY6sgjQMp+FI/PuOf9e8CMrjmGUmc5tNHUVhkLQfzdFjmzJCqxVt4/2C8MoIy
         pdh0GeLHThPuJzHdPYfWUNVxqxrlAM4BHKc62DVHgQyk10bPxG73wYytqan7w9UsZskq
         WwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7A+MqGG0nueg7bjbr8wdOjRWLSBApKgXKG2YY7iIj+fOs8CRvA5g5WPNu28Zu+vGnBeF2bE/DsMZLljD13a264dWr/vReNpRMvUnp
X-Gm-Message-State: AOJu0Yx5XZGbZ/+bNlcrZ2d5RnRHi3LdMe7DzMFPbA6c7jI9UR3A8YaT
	gJvmhI5eQVe6k/6ch0K/yvpGTGMPzt8X8uRgLqQo7XIQvGvtaNlMrzj7BLOsFj5PdWzv9uPIffv
	KpG4vxw==
X-Google-Smtp-Source: AGHT+IGXgnGFuFWHs2KzZCZhHH9ebzxG0L0VV2N+xWxLcMGOn4XnhqLvnO9XTJhmR2ueISmAiBH7HzKNSOSy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:c9b:b0:609:247a:fd3c with SMTP id
 cm27-20020a05690c0c9b00b00609247afd3cmr159686ywb.2.1709165761129; Wed, 28 Feb
 2024 16:16:01 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:32 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 08/13] perf jevents: Add dtlb metric group for AMD
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

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 108 +++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 82aab39c2a50..be10acb40762 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,113 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdDtlb() -> Optional[MetricGroup]:
+  if zen_model >= 4:
+      return None
+
+  d_dat = Event("ls_dc_accesses") if zen_model <= 3 else None
+  d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
+  d_hcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if zen_model >= 2 else 0
+  d_h2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit")
+  d_h1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit")
+
+  d_m4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss")
+  d_mcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss") if zen_model >= 2 else 0
+  d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
+  d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
+
+  d_w0 = Event("ls_tablewalker.dc_type0") if zen_model <= 3 else None
+  d_w1 = Event("ls_tablewalker.dc_type1") if zen_model <= 3 else None
+  walks = d_w0 + d_w1
+  walks_r = d_ratio(walks, interval_sec)
+  ins_w = d_ratio(ins, walks)
+  l1 = d_dat
+  l1_r = d_ratio(l1, interval_sec)
+  l2_hits = d_h4k + d_hcoal + d_h2m + d_h1g
+  l2_miss = d_m4k + d_mcoal + d_m2m + d_m1g
+  l2_r = d_ratio(l2_hits + l2_miss, interval_sec)
+  l1_miss = l2_hits + l2_miss + walks
+  l1_hits = max(l1 - l1_miss, 0)
+  ins_l = d_ratio(ins, l1_miss)
+
+  return MetricGroup("dtlb", [
+      MetricGroup("dtlb_ov", [
+          Metric("dtlb_ov_insn_bt_l1_miss",
+                 "DTLB overview: instructions between l1 misses.", ins_l,
+                 "insns"),
+          Metric("dtlb_ov_insn_bt_walks",
+                 "DTLB overview: instructions between dtlb page table walks.",
+                 ins_w, "insns"),
+      ]),
+      MetricGroup("dtlb_l1", [
+          Metric("dtlb_l1_hits",
+                 "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_hits, l1), "100%"),
+          Metric("dtlb_l1_miss",
+                 "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_miss, l1), "100%"),
+          Metric("dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                 "insns/s"),
+      ]),
+      MetricGroup("dtlb_l2", [
+          Metric("dtlb_l2_hits",
+                 "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_miss",
+                 "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                 "insns/s"),
+          MetricGroup("dtlb_l2_4kb", [
+              Metric(
+                  "dtlb_l2_4kb_hits",
+                  "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                  "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+              Metric(
+                  "dtlb_l2_4kb_miss",
+                  "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                  "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+          ]),
+          MetricGroup("dtlb_l2_coalesced", [
+              Metric(
+                  "dtlb_l2_coal_hits",
+                  "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                  "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                    d_hcoal + d_mcoal), "100%"),
+              Metric(
+                  "dtlb_l2_coal_miss",
+                  "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                  "DTLB L2 coalesced accesses.",
+                  d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+          ]),
+          MetricGroup("dtlb_l2_2mb", [
+              Metric(
+                  "dtlb_l2_2mb_hits",
+                  "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                  "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+              Metric(
+                  "dtlb_l2_2mb_miss",
+                  "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                  "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+          ]),
+          MetricGroup("dtlb_l2_1g", [
+              Metric(
+                  "dtlb_l2_1g_hits",
+                  "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                  "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+              Metric(
+                  "dtlb_l2_1g_miss",
+                  "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                  "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+          ]),
+      ]),
+      MetricGroup("dtlb_walks", [
+          Metric("dtlb_walks_reqs", "DTLB page table walks per second.",
+                 walks_r, "walks/s"),
+      ]),
+  ], description="Data TLB metrics")
+
+
 def AmdItlb():
   l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
   l2m = Event("l2_itlb_misses")
@@ -362,6 +469,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdDtlb(),
     AmdItlb(),
     AmdHwpf(),
     AmdSwpf(),
-- 
2.44.0.278.ge034bb2e1d-goog


