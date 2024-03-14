Return-Path: <linux-kernel+bounces-102823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954887B793
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD15B2205C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D2D17C7B;
	Thu, 14 Mar 2024 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCUOzZEI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668117BC9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395940; cv=none; b=YYhvWiFa2KhpnEHQdxX0fZMvYHmblNKZ5QHNEz2kR3eoWUWvYabM/Fpgnt0FiqKrvJqJA5SDF0KJs2dgIRbVj/iJkxsnlzBLJkZd8e0WPbytJ4NYiMPfT87+NFY6Kod/eGaYQWNTV7ItXfEbbMv+tMRcJw0WG/WKtKzdBExM2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395940; c=relaxed/simple;
	bh=WOWe+5ZwJjFtAMO5LixHT9n3OypFjRwiFMl5aR4Ng6M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=L66/l8AwMehWCgzlWmMqlWCpJPMTLwxz+PNQWHTR0ZdvPVsMM2oeN4Y/sEh2RgLFv1JXT8k9h9kRFTwwQ+bp19tW999yaLYXat4g+46Zi7+uJee4IymccZdhhcQ3zjJao3m86njjNB6nd2tJ1PTEG8A/P0R5ot9Rlob9yq69s00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCUOzZEI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso751561276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395938; x=1711000738; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6qdDgoIQxn8fAzaUEAV7cPE0zy3zkq2eTruom8IDPQ=;
        b=SCUOzZEIdO8gDjkgOpgAJOUpsl1206R4nxH31TmYCH3fL/Xbp7URZAvuZEFzyouVvW
         LKOn4JEZ+hv+yp9iQbNkZmGgIjpcwRT60brAXUVRZcP7+9v8DKxDhsIMRD+9LBm5PPGZ
         5Cr8XDY7/42QqROTJFHsxisFhmcDYBx7WIL7FwYpULwILyBNGjHGpgzSzlYCrwyme5oW
         HHMsz+FwVo0enu9zYl0d6/BUHVvtUci0T+RREjoDJk9sUouL9/vxexO5p6kWRRoFMbQY
         ONhNQjEPno0e0q0TU3K4eXQO6qIpnRJi5GJ+CwogBk0ni0EZzvgviNdFJ7rSDpUGPtYD
         Md8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395938; x=1711000738;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6qdDgoIQxn8fAzaUEAV7cPE0zy3zkq2eTruom8IDPQ=;
        b=Zqv7oDuSDzNXSjoQnTSH3urS/glUuCNhOcc5Q/7KaeyInxzVSCskuEG19A8wHDB/bb
         qSC8+A/QbiNPXOian5jqV9MRu+uQLElnYTQvXZ2MtUS++kfj5ERwRVri/G/JmFjnkCMA
         oXbLL/Pm7dvwq/e/AtgXWQ97keM13qpZL1oJTR0CAq3EbnD77dwG14UJvsfgLEZmg7X+
         n4VcvxkgbVZ1hJ70yQFZNkbmyGkJ1cgbwfrf2y+lydrtjEab5JboYCbprVCKX750F0WZ
         IltRhyjNY8rbe/4xpmRO29ruPHtLBZPacUJdpJHKX7DJww9qOJosGVJrStB3dku5I3jh
         6EEA==
X-Forwarded-Encrypted: i=1; AJvYcCUnqmVJ9wE+UpTLQUOCGACjlitN60AxWyFFYb6S9JZzR7iustzBAjjVDI6qq6nFW0grb8zW/KG14PuOA4zlX7Akx1Sj1tKTWigmIlTc
X-Gm-Message-State: AOJu0Yz7rpFWfd4jjvDgQyrMDTwLA7PH7t1AcaZQYw8Wzwbe2Bsa5aLs
	kLTOZDhkaOE6w6gK6clkL/PPK5M95gO2bx4jUbATGmU1tJ9tmwflC8DwFc+lwN5GE8bsTYxcBkl
	VBpOQ2w==
X-Google-Smtp-Source: AGHT+IFwr9ZZkG4/Fh7fUI8lDx9QV/iU/l1lXRZYsYunk9OLcTNKwFWK1vfmVkvaph3bP0KvJ/sxfqbBwcRZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2603:b0:dcc:54d0:85e0 with SMTP
 id dw3-20020a056902260300b00dcc54d085e0mr256664ybb.11.1710395938388; Wed, 13
 Mar 2024 22:58:58 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:33 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 06/12] perf jevents: Add hardware prefetch (hwpf) metric
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
 tools/perf/pmu-events/amd_metrics.py | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 9551b44dbbaf..5c91e97ae6c4 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,67 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdHwpf():
+  """Returns a MetricGroup representing AMD hardware prefetch metrics."""
+  global _zen_model
+  if _zen_model <= 1:
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
   global _zen_model
@@ -278,6 +339,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
       Idle(),
-- 
2.44.0.278.ge034bb2e1d-goog


