Return-Path: <linux-kernel+bounces-85883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C7D86BCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D081288E40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA86433B3;
	Thu, 29 Feb 2024 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDzozVH/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5D42054
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165758; cv=none; b=BMs9ZSBtdPx8PLw7ORgVb3yRKOOtygf3z0FcN7igA8XRACwEXZ0dyXdic59U3UONgEePlWfbs1Y/d8vu8e3edrkR9g+0q7BItosJB5PWwcCKagGjpeaRBPR6pWywWyR6I0jkM4dicAe1a16sE6XRWXNQzykioIOrxChiS8/QBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165758; c=relaxed/simple;
	bh=5rPQbQbgB4a9rwpPs3GZO8lIicUTIgfjGCJZshFzKwg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XzflOeSDGdk2E2qhejoYkWiEixL5h+ux1e5s4B9+flVdEfc6ex2XYnaS2/BkvgieUBfbwzrxOGffAmFXBAVPh3olNGeylae5EascRIjanHT9bdgc0sMqpXTurCTZLcI167q0EHYdo+vQg2q6ADvN7SBp9+v3UTgFVUX+wac+chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDzozVH/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60957e0b914so6065867b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165756; x=1709770556; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbbMwVexzgBT1fsV6th5WqgIzFECec7b7GQZlOqA780=;
        b=YDzozVH/Jah8I1SlVaJCYSs6zJpYfc5oEEdA/gzpxXANV2ChywCMF7cOjKqBlzMns7
         1hdk1Odpgpx0OMsz3sl6Lt2jsIbyCwAX4wKetSO0SoYa7fGwyDL9+GkPnyEylf9K5LfJ
         UH+yxsc6aNSV7hVLIGoXGXEYpYusVIVsMbo8Gf7y8cD4+XkgVHhn8uSoyB8VktNa7xYZ
         d+NmJ/yzt29JdjM2es6xqU8Bgnshijtc0Uo4SjtHYfz2NwLQKL1uB80ObYe/s745A7zd
         zZlcdevzDp2UzRJXZJlF/r2exmY2jJUNp7lpl2MHztoUvSWdPkTUSgxOVbDpIMkZMkxx
         E0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165756; x=1709770556;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbbMwVexzgBT1fsV6th5WqgIzFECec7b7GQZlOqA780=;
        b=Nxjl+gobvAuA2gYt0/OxPVtA7DlSP8fpjzaDsjK2PaVFCln1Zsno5BheT000i9WOPd
         31B1dsVTgjM+Bf2eARC2pfRJI4wobq1KOuBJ03c+dMlevVG6Z02dd5deW7l84lIXhp70
         wE9Xe2R/oW5PyprxF2t975/r6gJQK0buj7x1VyL2J2UJXbk19CrHYscv16t1Aui1umv+
         H/dBYgVH2hdPh9FzxWsHcCbv6qe1u8XjrwIgnqRAcceV8pa5haFWm1KhD7Zj/qCgkE0g
         ZYhrV9kKEl1Y7G+y1YXSigvWlXsSHBna6wtTmowzsdCzJmZS8sCsRP4A6cEWvImu9zXL
         OLIA==
X-Forwarded-Encrypted: i=1; AJvYcCU8JjhOH/BrdXFBBEo+CTkDIc7JrLv2QII2vi4jRNwuSdoRH4zrDNQU2VxaSev1oMnyiwRcZPkMGjx7MZ6yjNxilu7hD1bFc/7lSURx
X-Gm-Message-State: AOJu0YzOSIbqH48j43AEC7wYnPX6q54wouzAw6/0ztYSOU3NVJFQfaPH
	jteq4OwEdN7u6ZFM/ggDNjerLLtUflfurwVb8dHSPv4KM75S/qJx8d2cWzBqacF67aD7NQbdO0X
	5/U9OMw==
X-Google-Smtp-Source: AGHT+IFpvjWMxldxQybdcKWY/ZYyAAXRj1AiQRCleXUFxDcx5Z0ijU8jsfoj6v5FA4PraFhvXSceJt/nDerq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:3507:b0:608:e67f:4387 with SMTP
 id fq7-20020a05690c350700b00608e67f4387mr136175ywb.7.1709165756654; Wed, 28
 Feb 2024 16:15:56 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:30 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 06/13] perf jevents: Add hardware prefetch (hwpf) metric
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

Add metrics that give the utility of hardware prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 61 ++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 52451bcb4bbf..dda904998269 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,66 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdHwpf():
+  """Returns a MetricGroup representing AMD hardware prefetch metrics."""
+  if zen_model <= 1:
+      return None
+
+  hwp_ld = Event("ls_dispatch.ld_dispatch")
+  hwp_l2 = Event("ls_hw_pf_dc_fills.local_l2",
+                 "ls_hw_pf_dc_fills.lcl_l2",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2")
+  hwp_lc = Event("ls_hw_pf_dc_fills.local_ccx",
+                 "ls_hw_pf_dc_fills.int_cache",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache")
+  hwp_lm = Event("ls_hw_pf_dc_fills.dram_io_near",
+                 "ls_hw_pf_dc_fills.mem_io_local",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram")
+  hwp_rc = Event("ls_hw_pf_dc_fills.far_cache",
+                 "ls_hw_pf_dc_fills.ext_cache_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache")
+  hwp_rm = Event("ls_hw_pf_dc_fills.dram_io_far",
+                 "ls_hw_pf_dc_fills.mem_io_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+  loc_pf = hwp_l2 + hwp_lc + hwp_lm
+  rem_pf = hwp_rc + hwp_rm
+  all_pf = loc_pf + rem_pf
+
+  r1 = d_ratio(ins, all_pf)
+  r2 = d_ratio(hwp_ld, all_pf)
+  r3 = d_ratio(all_pf, interval_sec)
+
+  overview = MetricGroup("hwpf_overview", [
+      Metric("hwpf_ov_insn_bt_hwpf", "Insn between HWPF", r1, "insns"),
+      Metric("hwpf_ov_loads_bt_hwpf", "Loads between HWPF", r2, "loads"),
+      Metric("hwpf_ov_rate", "HWPF per second", r3, "hwpf/s"),
+  ])
+  r1 = d_ratio(hwp_l2, all_pf)
+  r2 = d_ratio(hwp_lc, all_pf)
+  r3 = d_ratio(hwp_lm, all_pf)
+  data_src_local = MetricGroup("hwpf_data_src_local", [
+      Metric("hwpf_data_src_local_l2", "Data source local l2", r1, "100%"),
+      Metric("hwpf_data_src_local_ccx_l3_loc_ccx",
+             "Data source local ccx l3 loc ccx", r2, "100%"),
+      Metric("hwpf_data_src_local_memory_or_io",
+             "Data source local memory or IO", r3, "100%"),
+  ])
+
+  r1 = d_ratio(hwp_rc, all_pf)
+  r2 = d_ratio(hwp_rm, all_pf)
+  data_src_remote = MetricGroup("hwpf_data_src_remote", [
+      Metric("hwpf_data_src_remote_cache", "Data source remote cache", r1,
+             "100%"),
+      Metric("hwpf_data_src_remote_memory_or_io",
+             "Data source remote memory or IO", r2, "100%"),
+  ])
+
+  data_src = MetricGroup("hwpf_data_src", [data_src_local, data_src_remote])
+  return MetricGroup("hwpf", [overview, data_src],
+                     description="Hardware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdSwpf() -> Optional[MetricGroup]:
   """Returns a MetricGroup representing AMD software prefetch metrics."""
   if zen_model <= 1:
@@ -256,6 +316,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
     Idle(),
-- 
2.44.0.278.ge034bb2e1d-goog


