Return-Path: <linux-kernel+bounces-102822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E587B792
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC521F2236C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC8B17BD4;
	Thu, 14 Mar 2024 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eK6XCDbo"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA211C94
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395938; cv=none; b=rod/zjKZ+U41u8wXjWva9QJfdxorNbP1RLdBD72zOCHRFgpN63wAlKfhTA4u5Mh78OfUKlt4kxgiI1bNseMokw/cQnreixP/YHWqB1y8oxC67soaKd+x/Qw+nYqI4gt2/OuPCabbmTX5BNUF1JQz8WG3emnqjXzzVG/bCd+4h3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395938; c=relaxed/simple;
	bh=TvRZPjew8/CPgNR1zc4nGB4ze/mcB2Jah94Ua4LIrDA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nkHjrJgBGx1j6XfDE8nuOTTomn8snEVgoQykKVjfCOUuEaFpK2fHFnhW7Dv8TDaZNi+Qg5w4cRuZ21i2n++i2tU+Y4wF0fIs5USzAKSbYFlellhjI81bZnNaFnCbiZqcolPUC55cR5HnRD5mtcNaASSQMe4HD/Qr1+b2XU+v+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eK6XCDbo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so981878276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395936; x=1711000736; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rxi4fggPixiVFuhVXSoHQicrKYgfFvqkEeqWtSPSm6Y=;
        b=eK6XCDbo6nejD30dAtdZoBZ6Wtq5PQZcIhOe24TVQs4Yxhl7C3pHZ9KdAiP6yn39eH
         6cBC6/vh8Q3AuHnVAjgCyYpuwVp8+nmsaXvuEfpMKbiAAYvhXTR8HRf7UssBon2VkYWK
         WRHZdi+AXdZzUp6/9jAAv8H4E1De4i1uCzN7pAwiRda2D7Yvtgw6kmuvBpQz1KRvI95a
         Ud7k75uqhxjeXqASmEE9pmGjbeTUjRIhQN/398Zoyps4C6Z8nbw/eAQYwZYJ9YhHOTh1
         MAI2JNk1z9Wh+MgICyYvYyZ/RARMpqm3diHR5e3dPqlD29UIOBZlxhpl4+V69TIstYmy
         +WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395936; x=1711000736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rxi4fggPixiVFuhVXSoHQicrKYgfFvqkEeqWtSPSm6Y=;
        b=Fov5IJ2ZWwR9ZTuIo2nz+JzmW12cdm7Dk4iEDIyxhGiFlkMs2ghhAX2DjsLXEdhe1Q
         fdc6Y6BMEBiFdt2uwVRvgQnSGjzk5bmX1+YwFOSYYlwEOh5Nj0U4dkXCusD/15miByWX
         2tlPInPCHAhFvTCGkxcZj+x9EzmtyViq39/T6xD4qrW/egO2r+Tg5065LGzN5MvTVEY3
         eMwft5H5aUtv5osj+1yKV2XjHxmm3d7uZ9Vzmhl1L7tBGuTRYASWw95dSQBx8N4HXDsk
         fAwRndbTp9M/z09xUV7NBP3JcBxWZ6ZLswz1dlWIaLCeBUHzSOfFNj4G5aOP4zltSO3D
         M+EA==
X-Forwarded-Encrypted: i=1; AJvYcCWTYrXOOeYjDilfwr9Xn78MeCLF8Z1513v0aTMywoUOhCFw9hWqD8qcp8k9lcsU+s3c4cD6VChQwGAlKdChreoo8QsA20sKbIbddjkO
X-Gm-Message-State: AOJu0YyxrRuRT2sVgAFy47DFkxbC9TKn+KbJgmgWIi/5/+v614758b1X
	ZWFfteIpJJ4Mow6+IER6RREBOtQT8T6HKgXIM8Mt0epAzMA5pVhZbb/CM3v7VQg5UMv9CyhUWm5
	aYOrNMQ==
X-Google-Smtp-Source: AGHT+IGPmfRPG1o7K6/hSQPRpIO4pPp4foG2pF0la5o/tucMPboxCnzp1c+2tet24X1PfQJd6ag1r4AFNKcE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:72e:b0:dc6:e8a7:fdba with SMTP id
 l14-20020a056902072e00b00dc6e8a7fdbamr253985ybt.4.1710395936161; Wed, 13 Mar
 2024 22:58:56 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:32 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 05/12] perf jevents: Add software prefetch (swpf) metric
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
 tools/perf/pmu-events/amd_metrics.py | 96 ++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 90545d4862a6..9551b44dbbaf 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,101 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdSwpf() -> Optional[MetricGroup]:
+  """Returns a MetricGroup representing AMD software prefetch metrics."""
+  global _zen_model
+  if _zen_model <= 1:
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
@@ -183,6 +278,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdSwpf(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.44.0.278.ge034bb2e1d-goog


