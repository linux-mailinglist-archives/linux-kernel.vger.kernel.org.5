Return-Path: <linux-kernel+bounces-85882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0565086BC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FBF1C214B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914BF42A91;
	Thu, 29 Feb 2024 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXCkv7Gq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE338F97
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165756; cv=none; b=mzqu+DzwDY+mumyuJ9pUGJ+Wuq1fW7+93bVRQXQk/3pLadpwytxB13Gc9BkrEtQ4tfOt1vkSjkvd0p+Jw+BFH2zeeUL3uIZ8GU8raODY14iIiARGeEI+Vei9GPBlpLUXs97cldkhDVoJqQxoIA8QsgJk5iYHhGMvt+okEme04ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165756; c=relaxed/simple;
	bh=+avI6OXSebapAM2pF6TaSl95UtS1MYUkS9EvCqrF/LU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JSrUCLn/rJRCGVsWJNgWLuxB/30Ixspj3CAgnwoKHJyGO1jba1RkpZxrbT6bPfyf/ieoOFHxL0fErMhLRB7GE2HrAcYLT8sTBXhWqYy/vUkkgOWxuMRVeanrOx+5B2hX+k4ecaxcYEnxAaPzo5bRRZaavWedTQBc9+03STDjEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXCkv7Gq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6087ffdac8cso5032977b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165754; x=1709770554; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcc/qUxyeEjzpXo98Okf44ySOQGx/p2IAM001Az25yY=;
        b=zXCkv7GqQ7CeFtzE+jD4qIVcNbHuzq/Z+4gyLc1ocsHbWafSu4WXtTgXto4j1hPp3E
         vQ7EDv0ov2d9MWC5JNkZ6gbzlIPACBRk4715FLXGXO0ZLtmMSeQu608SpLnaQ9gU9zmd
         mN0s7yAvkwxoM9AHn1GOApy8mD/G15lsUurvaj7qKpCWjkwmwZgBoSg2BArArIE2+VbY
         7zBFXWJ2VoobY6NcjDxEKEWbroxifxoQqedE05Q0DABzwzcm02eLsZSd8/3IaEVx1HWj
         f/Llslt1umtEsJAc8pyPoDPrp/PR9Mid8wMOsu0qnnUTgQUJe+9+YtC78SeOV227GVia
         Z/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165754; x=1709770554;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcc/qUxyeEjzpXo98Okf44ySOQGx/p2IAM001Az25yY=;
        b=tkVgd986hx3t4sHc3TvWkUBhiQbG0pCMYRT6r0hyIALAFC4Akaqf+4pNRy8XlJ+aLu
         xO8voIx+5fQ5n126U6tjYDwkcWRypPcajhgVtUDVoi/52DoaoA4nhducr1nGqKpd2Oqp
         7OGrM1A8R+HMOjpa4JENce5iShDyFfdz9Ht87GMpbAC+lSAUhz6rUmWFbqvw1Lk9ia4g
         j469D0Rf91KtYhaFVmvvygGg/Kb+1xPYzgfqAsEv98LdhJTthh/E8AvkDSYrdJ4aCgVh
         NIoDbnxiXWDSpwkWDUFbaveKIMXvqWzVeFD4Lw944QL+m3m+c+2pkgVNYWnEj7pQGLYb
         vjew==
X-Forwarded-Encrypted: i=1; AJvYcCWXlIV12qDKmAAl+65dOdvcZ3IGdQK6ZJ/dDAHasxu5XtKGP/RxjxjsiOi5RXX/dnL8/0Z98V8cvOA/IoIml3KG8G5yIvCxTlHdkpZW
X-Gm-Message-State: AOJu0YyZxYS9topEdGV4eIeJiWJfIutcfkz/IrjfoCiRWBKV/Pwr3DZ6
	qSugnJBsU1OY8Iq/Lc8H3MJkdaqNVha4KEw59kJjT3okEt3YQkJ06+bhL0vTbxuCgVsdHxbKMRm
	Jwwg9SQ==
X-Google-Smtp-Source: AGHT+IEK4PK6C7Un3eLuWMOG+gIOFWEqQPmc0uiPTLLyaklEbszRbRs9q1K2fGy5POzA60BpJ2/W5HoZiN1W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dc6:e5e9:f3af with SMTP
 id w10-20020a056902100a00b00dc6e5e9f3afmr192114ybt.9.1709165754237; Wed, 28
 Feb 2024 16:15:54 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:29 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 05/13] perf jevents: Add software prefetch (swpf) metric
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


