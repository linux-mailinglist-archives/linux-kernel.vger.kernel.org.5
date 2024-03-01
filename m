Return-Path: <linux-kernel+bounces-88942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFB986E8B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4031C22315
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC963BB43;
	Fri,  1 Mar 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awb4jSZ3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D643B194
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318880; cv=none; b=TCmk6zjdxR4oxuJlf02Pk47LT3t+Am11tEBU/rDmtPH2SdLWwGOHF4WAA86aJvqieURqnP7A+V7MmDDUMTSrYN1MAnRpE/UKeomQSlUMklUUfya26Q64S/P6AmyrNlaoHl8QesBDR4QJy1BeaS2iX93DXhEZ6Yu5KapNTR0v6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318880; c=relaxed/simple;
	bh=+avI6OXSebapAM2pF6TaSl95UtS1MYUkS9EvCqrF/LU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=t6OLIM/MgRevY7k+gI4qQ7MwyNnjAvaVxQ9ntAX+OfX2SC4+3dyPy45ut484XDPrzGw5KV1wqk7L8eyxdDv8Buk7QvXdH2yHix2/ES7czuOluF7YgBW4aT5ItF1HBqdsNJERRgSoHu90tED+e57w4ZS3hfZDbe1XlTwVhzPVLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awb4jSZ3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso3600397276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318878; x=1709923678; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcc/qUxyeEjzpXo98Okf44ySOQGx/p2IAM001Az25yY=;
        b=awb4jSZ3qKGejA5dbO4I1dDLUhX2A4dEiNDwODlpM2rsclpB9N1Wpnrv5uNhGfjmrL
         C+MhNWFWMF5Ch6eQNVjLfBouAUUNisEgzmwmV8bniLCz6c4I3WD+vTC8KsSdMK8qBN8n
         blESTGOeek7w9oCKIw2RRNbrJQUy5Oxr4Z8kE0d0eVX+HLXfAJs3U4T7p4A/a84y2cho
         9wyvqV0hoTU4A19+WjGl5RJJEr/TF5dZi06UUyYqM8nswmGAYOHbSu8XCiovpGtp5gxR
         dkgendH7iG1ufBofpsT0ChkSksRS0AFUVKaSKJYK1ETe9cH0wQfZC3HeAjxWsL1ZFCTe
         hdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318878; x=1709923678;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcc/qUxyeEjzpXo98Okf44ySOQGx/p2IAM001Az25yY=;
        b=IR5n5lIttG4oYBP+zARRTs3ykWsrtiKf34R6Qj95ZmBov2aaJUNXBUZYw/fQfH/HOX
         BwtPm5N3A2/gebYzrbnseSYYluuDREn+ZIi//ri/1/FuvzCUMsh2EogClZAj5mqmzKxP
         /bCe/hP0kSewXI+1y0TWlNrmPoez03mKvRXzRiIatsYmTJ4dgjDj2wTGol7G/8GxWAaT
         dLVvzFGLMaJFL1HbmN8I85TWCoA4a/xza//k++Fzp4h6/cetpItOMx2FHojM77rfntou
         5sjITi93WPwUE+Pugy21fkxSjrO1zQW+J2x9A43jOh2vSW9t0ProYWhhlGc6iFppkEvz
         VYzA==
X-Forwarded-Encrypted: i=1; AJvYcCVf6VZGpVs5/4ScQzgBSknsq/S4iYCRZHZCpl/81dRkmKQxXW+c6K9UpQ1Kwu1HhTi+X+vBsd2j+AUYXZ6OWmA/Pm+/gE+BYFlgkbSn
X-Gm-Message-State: AOJu0YwlRLAfo52GRHsRrXqoSR3rjdtK5e2CDAcB99VYNlrys35HZDnX
	0MGlHFgpeIweLJ2hn6O55RxkeYCrfQZjUmhNzpIiedk/ZWUn3NC3JA1UuDhO2HL87VCDM7EKB9V
	dEdvVfw==
X-Google-Smtp-Source: AGHT+IE6DAkO4+RnVsXtpYKXgmaTECxjtmB3IX/p1VUna1oQEg1kmhUMcj19BksK+jU5OOqpTbzVIlbZgo1m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:188f:b0:dc6:b768:2994 with SMTP
 id cj15-20020a056902188f00b00dc6b7682994mr108005ybb.0.1709318878023; Fri, 01
 Mar 2024 10:47:58 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:30 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 05/12] perf jevents: Add software prefetch (swpf) metric
 group for AMD
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

Add metrics that give the utility of software prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 95 ++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index f8d5ba2861ee..52451bcb4bbf 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,100 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdSwpf() -> Optional[MetricGroup]:
+  """Returns a MetricGroup representing AMD software prefetch metrics."""
+  if zen_model <= 1:
+      return None
+
+  swp_ld = Event("ls_dispatch.ld_dispatch")
+  swp_t0 = Event("ls_pref_instr_disp.prefetch")
+  swp_w = Event("ls_pref_instr_disp.prefetch_w") # Missing on Zen1
+  swp_nt = Event("ls_pref_instr_disp.prefetch_nta")
+  swp_mab = Event("ls_inef_sw_pref.mab_mch_cnt")
+  swp_l2 = Event("ls_sw_pf_dc_fills.local_l2",
+                 "ls_sw_pf_dc_fills.lcl_l2",
+                 "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2")
+  swp_lc = Event("ls_sw_pf_dc_fills.local_ccx",
+                 "ls_sw_pf_dc_fills.int_cache",
+                 "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache")
+  swp_lm = Event("ls_sw_pf_dc_fills.dram_io_near",
+                 "ls_sw_pf_dc_fills.mem_io_local",
+                 "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram")
+  swp_rc = Event("ls_sw_pf_dc_fills.far_cache",
+                 "ls_sw_pf_dc_fills.ext_cache_remote",
+                 "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache")
+  swp_rm = Event("ls_sw_pf_dc_fills.dram_io_far",
+                 "ls_sw_pf_dc_fills.mem_io_remote",
+                 "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+  # All the swpf that were satisfied beyond L1D are good.
+  all_pf = swp_t0 + swp_w + swp_nt
+  good_pf = swp_l2 + swp_lc + swp_lm + swp_rc + swp_rm
+  bad_pf = max(all_pf - good_pf, 0)
+
+  loc_pf = swp_l2 + swp_lc + swp_lm
+  rem_pf = swp_rc + swp_rm
+
+  req_pend = max(0, bad_pf - swp_mab)
+
+  r1 = d_ratio(ins, all_pf)
+  r2 = d_ratio(swp_ld, all_pf)
+  r3 = d_ratio(swp_t0, interval_sec)
+  r4 = d_ratio(swp_w, interval_sec)
+  r5 = d_ratio(swp_nt, interval_sec)
+  overview = MetricGroup("swpf_overview", [
+      Metric("swpf_ov_insn_bt_swpf", "Insn between SWPF", r1, "insns"),
+      Metric("swpf_ov_loads_bt_swpf", "Loads between SWPF", r2, "loads"),
+      Metric("swpf_ov_rate_prefetch_t0_t1_t2", "Rate prefetch TO_T1_T2", r3,
+             "insns/sec"),
+      Metric("swpf_ov_rate_prefetch_w", "Rate prefetch W", r4, "insns/sec"),
+      Metric("swpf_ov_rate_preftech_nta", "Rate prefetch NTA", r5, "insns/sec"),
+  ])
+
+  r1 = d_ratio(swp_mab, all_pf)
+  r2 = d_ratio(req_pend, all_pf)
+  usefulness_bad = MetricGroup("swpf_usefulness_bad", [
+      Metric("swpf_use_bad_hit_l1", "Usefulness bad hit L1", r1, "100%"),
+      Metric("swpf_use_bad_req_pend", "Usefulness bad req pending", r2, "100%"),
+  ])
+
+  r1 = d_ratio(good_pf, all_pf)
+  usefulness_good = MetricGroup("swpf_usefulness_good", [
+      Metric("swpf_use_good_other_src", "Usefulness good other src", r1,
+             "100%"),
+  ])
+
+  usefulness = MetricGroup("swpf_usefulness", [
+      usefulness_bad,
+      usefulness_good,
+  ])
+
+  r1 = d_ratio(swp_l2, good_pf)
+  r2 = d_ratio(swp_lc, good_pf)
+  r3 = d_ratio(swp_lm, good_pf)
+  data_src_local = MetricGroup("swpf_data_src_local", [
+      Metric("swpf_data_src_local_l2", "Data source local l2", r1, "100%"),
+      Metric("swpf_data_src_local_ccx_l3_loc_ccx",
+             "Data source local ccx l3 loc ccx", r2, "100%"),
+      Metric("swpf_data_src_local_memory_or_io",
+             "Data source local memory or IO", r3, "100%"),
+  ])
+
+  r1 = d_ratio(swp_rc, good_pf)
+  r2 = d_ratio(swp_rm, good_pf)
+  data_src_remote = MetricGroup("swpf_data_src_remote", [
+      Metric("swpf_data_src_remote_cache", "Data source remote cache", r1,
+             "100%"),
+      Metric("swpf_data_src_remote_memory_or_io",
+             "Data source remote memory or IO", r2, "100%"),
+  ])
+
+  data_src = MetricGroup("swpf_data_src", [data_src_local, data_src_remote])
+
+  return MetricGroup("swpf", [overview, usefulness, data_src],
+                     description="Sofware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -162,6 +256,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdSwpf(),
     AmdUpc(),
     Idle(),
     Rapl(),
-- 
2.44.0.278.ge034bb2e1d-goog


