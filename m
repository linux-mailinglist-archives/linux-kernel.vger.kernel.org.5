Return-Path: <linux-kernel+bounces-102847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8E87B7B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839EC1F261EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90E42078;
	Thu, 14 Mar 2024 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wunVpgEW"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37713D982
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395998; cv=none; b=PKpDY/X+kPufTZXI4GrO/04C0jCpSwZ+4+ZX4C2JhDlR5glqjvvJ35OZ+YoKxwzW7yOdEuZf3h7180is643i2HixJGCSwmuJZrz+zXkprkfWyi+kPPXsxAQcTRP+9v7AFQpzrcN62lPGz5aB5zkYT/sN+mk9X/2A15LhSpXkpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395998; c=relaxed/simple;
	bh=EtOcDq2NMAnbcBBlUMbyBdHDOVr9dglo32PTwlIWv3o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GpcbXqR7XKLprQ8vWChdwvaGcbL3kOZM7Lcp5+DVdULDfsrCNehpqaKIKCwitYYqqAjvE1zCu4PLmEYe3UpyZ5dtu/Sy7LHfsxZA/OwOeW4YQEAFt3hBtLDFhicAVTdeCm/uu0y6JzXa9VBnVpnrbsimMinwLhl4dDGZJ1erm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wunVpgEW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a08eb0956so9977237b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395996; x=1711000796; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ab3oVKFyb7WmXtlReQGTt2ckvC2KNs0Fz6mOW8a1Ns=;
        b=wunVpgEWtzcYKh3uE8ej26ZQNU/NIovsPimVkkvvgd5Jz3rIT46th3eZh+KbIAxpeM
         ceS9phCvlKU50tF3Rfpk3JPUYLGyG46fTevhxAH1DLRUu3VWVvbJpQG8uo4GnjcBQoio
         xJ/vxBsCm0sjvD7af/GpDAitIjw4Au7NWuLhe206QujwlfnoGQVOA1Or4I4XvJK49qXc
         OIwZiUBS6WRADOeUh2eomHbgpti8BBPQDMXRGjUXHLxuLmfjaZgZW6qWCMTuzCSOxZGg
         cWEvR+lNMlvOMCbGytb2LDQ+9aUIHZmdGD8s6EfswB3X3AI/HcXTNdDbzGW7wkYmOk6u
         fnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395996; x=1711000796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ab3oVKFyb7WmXtlReQGTt2ckvC2KNs0Fz6mOW8a1Ns=;
        b=qDmKVB0xTBW18AgIFdePI+aRwglfNAU8xpsgvjm6fpKCtXtU78WCXm32RKcUjnxBV6
         EL79fcAvtJpCdnL8FcwkZ6p7+mqb9Uw4CdncppHAOBJMsgb427KjKwIVgctT08RHpjcz
         mk8sG1h3Ol7JnIbaCCvEqGV3TUJwIIAlanDQvqU25LzktXdR8COOBW0x/wHrnVCWTwJW
         leqDJ+AX5HL2WdVWiGNBQ6yc+GflBEukJ31aHvgbPksVJ3jO1/XiV5rp99otXgjoA+cv
         I6HRWPA7EMmkv6Qs4l5q8eQHXnuCVY/0g3yEP9JBQU8x+1lPpSVOmNiF+2m0PXqcGV8R
         b2uw==
X-Forwarded-Encrypted: i=1; AJvYcCVbepCnIOlcZhm6tme6TKNNKnxTiP2XW+F313leSge8yo3ZHLn7i0uglju+KhcgAmfHDpiRy9mtrBHpBzhcDVHACMB5KhaqUgqd4Z5N
X-Gm-Message-State: AOJu0YxxrNY/i8/vnojuiCBeqfjbjiGGzZ1C89YdkBM7IajgYVmPoMMO
	CpDeb8WRY4JsWUt1XAFOJOZNIcdU5f2QrB4OO5zpeflAwq8VkmYpHaicSG882I7uGlkZiFbdl08
	DzBKkBg==
X-Google-Smtp-Source: AGHT+IHkvYJkQtyDL36LoaqZSsrHz4Bkvp45OCVN90/foiDSZQ23PNnkVZLA/DGJYTkB+Z1kG/gkiaT5M/YD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:240e:b0:dc2:5273:53f9 with SMTP
 id dr14-20020a056902240e00b00dc2527353f9mr34374ybb.1.1710395995841; Wed, 13
 Mar 2024 22:59:55 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:08 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 09/20] perf jevents: Add L2 metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Give a breakdown of various L2 counters as metrics, including totals,
reads, hardware prefetcher, RFO, code and evictions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 158 +++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b181574c9486..9ef30e5d3e25 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -266,6 +266,163 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelL2() -> Optional[MetricGroup]:
+  try:
+    DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
+  except:
+    return None
+  try:
+    DC_MISS = Event("L2_RQSTS.DEMAND_DATA_RD_MISS")
+    l2_dmnd_miss = DC_MISS
+    l2_dmnd_rd_all = DC_MISS + DC_HIT
+  except:
+    DC_ALL = Event("L2_RQSTS.ALL_DEMAND_DATA_RD")
+    l2_dmnd_miss = DC_ALL - DC_HIT
+    l2_dmnd_rd_all = DC_ALL
+  l2_dmnd_mrate = d_ratio(l2_dmnd_miss, interval_sec)
+  l2_dmnd_rrate = d_ratio(l2_dmnd_rd_all, interval_sec)
+
+  DC_PFH = None
+  DC_PFM = None
+  l2_pf_all = None
+  l2_pf_mrate = None
+  l2_pf_rrate = None
+  try:
+    DC_PFH = Event("L2_RQSTS.PF_HIT")
+    DC_PFM = Event("L2_RQSTS.PF_MISS")
+    l2_pf_all = DC_PFH + DC_PFM
+    l2_pf_mrate = d_ratio(DC_PFM, interval_sec)
+    l2_pf_rrate = d_ratio(l2_pf_all, interval_sec)
+  except:
+    pass
+
+  DC_RFOH = Event("L2_RQSTS.RFO_HIT")
+  DC_RFOM = Event("L2_RQSTS.RFO_MISS")
+  l2_rfo_all = DC_RFOH + DC_RFOM
+  l2_rfo_mrate  = d_ratio(DC_RFOM, interval_sec)
+  l2_rfo_rrate  = d_ratio(l2_rfo_all, interval_sec)
+
+  DC_CH = Event("L2_RQSTS.CODE_RD_HIT")
+  DC_CM = Event("L2_RQSTS.CODE_RD_MISS")
+  DC_IN = Event("L2_LINES_IN.ALL")
+  DC_OUT_NS = None
+  DC_OUT_S = None
+  l2_lines_out = None
+  l2_out_rate = None
+  wbn = None
+  isd = None
+  try:
+    DC_OUT_NS = Event("L2_LINES_OUT.NON_SILENT",
+                      "L2_LINES_OUT.DEMAND_DIRTY",
+                      "L2_LINES_IN.S")
+    DC_OUT_S = Event("L2_LINES_OUT.SILENT",
+                     "L2_LINES_OUT.DEMAND_CLEAN",
+                     "L2_LINES_IN.I")
+    if DC_OUT_S.name == "L2_LINES_OUT.SILENT" and (
+        args.model.startswith("skylake") or
+        args.model == "cascadelakex"):
+      DC_OUT_S.name = "L2_LINES_OUT.SILENT/any/"
+    # bring is back to per-CPU
+    l2_s  = Select(DC_OUT_S / 2, Literal("#smt_on"), DC_OUT_S)
+    l2_ns = DC_OUT_NS
+    l2_lines_out = l2_s + l2_ns;
+    l2_out_rate = d_ratio(l2_lines_out, interval_sec);
+    nlr = max(l2_ns - DC_WB_U - DC_WB_D, 0)
+    wbn = d_ratio(nlr, interval_sec)
+    isd = d_ratio(l2_s, interval_sec)
+  except:
+    pass
+  DC_OUT_U = None
+  l2_pf_useless = None
+  l2_useless_rate = None
+  try:
+    DC_OUT_U = Event("L2_LINES_OUT.USELESS_HWPF")
+    l2_pf_useless = DC_OUT_U
+    l2_useless_rate = d_ratio(l2_pf_useless, interval_sec)
+  except:
+    pass
+  DC_WB_U = None
+  DC_WB_D = None
+  wbu = None
+  wbd = None
+  try:
+    DC_WB_U = Event("IDI_MISC.WB_UPGRADE")
+    DC_WB_D = Event("IDI_MISC.WB_DOWNGRADE")
+    wbu = d_ratio(DC_WB_U, interval_sec)
+    wbd = d_ratio(DC_WB_D, interval_sec)
+  except:
+    pass
+
+  l2_lines_in = DC_IN
+  l2_code_all = DC_CH + DC_CM
+  l2_code_rate = d_ratio(l2_code_all, interval_sec)
+  l2_code_miss_rate = d_ratio(DC_CM, interval_sec)
+  l2_in_rate = d_ratio(l2_lines_in, interval_sec)
+
+  return MetricGroup("l2", [
+    MetricGroup("l2_totals", [
+      Metric("l2_totals_in", "L2 cache total in per second",
+             l2_in_rate, "In/s"),
+      Metric("l2_totals_out", "L2 cache total out per second",
+             l2_out_rate, "Out/s") if l2_out_rate else None,
+    ]),
+    MetricGroup("l2_rd", [
+      Metric("l2_rd_hits", "L2 cache data read hits",
+             d_ratio(DC_HIT, l2_dmnd_rd_all), "100%"),
+      Metric("l2_rd_hits", "L2 cache data read hits",
+             d_ratio(l2_dmnd_miss, l2_dmnd_rd_all), "100%"),
+      Metric("l2_rd_requests", "L2 cache data read requests per second",
+             l2_dmnd_rrate, "requests/s"),
+      Metric("l2_rd_misses", "L2 cache data read misses per second",
+             l2_dmnd_mrate, "misses/s"),
+    ]),
+    MetricGroup("l2_hwpf", [
+      Metric("l2_hwpf_hits", "L2 cache hardware prefetcher hits",
+             d_ratio(DC_PFH, l2_pf_all), "100%"),
+      Metric("l2_hwpf_misses", "L2 cache hardware prefetcher misses",
+             d_ratio(DC_PFM, l2_pf_all), "100%"),
+      Metric("l2_hwpf_useless", "L2 cache hardware prefetcher useless prefetches per second",
+             l2_useless_rate, "100%") if l2_useless_rate else None,
+      Metric("l2_hwpf_requests", "L2 cache hardware prefetcher requests per second",
+             l2_pf_rrate, "100%"),
+      Metric("l2_hwpf_misses", "L2 cache hardware prefetcher misses per second",
+             l2_pf_mrate, "100%"),
+    ]) if DC_PFH else None,
+    MetricGroup("l2_rfo", [
+      Metric("l2_rfo_hits", "L2 cache request for ownership (RFO) hits",
+             d_ratio(DC_RFOH, l2_rfo_all), "100%"),
+      Metric("l2_rfo_misses", "L2 cache request for ownership (RFO) misses",
+             d_ratio(DC_RFOM, l2_rfo_all), "100%"),
+      Metric("l2_rfo_requests", "L2 cache request for ownership (RFO) requests per second",
+             l2_rfo_rrate, "requests/s"),
+      Metric("l2_rfo_misses", "L2 cache request for ownership (RFO) misses per second",
+             l2_rfo_mrate, "misses/s"),
+    ]),
+    MetricGroup("l2_code", [
+      Metric("l2_code_hits", "L2 cache code hits",
+             d_ratio(DC_CH, l2_code_all), "100%"),
+      Metric("l2_code_misses", "L2 cache code misses",
+             d_ratio(DC_CM, l2_code_all), "100%"),
+      Metric("l2_code_requests", "L2 cache code requests per second",
+             l2_code_rate, "requests/s"),
+      Metric("l2_code_misses", "L2 cache code misses per second",
+             l2_code_miss_rate, "misses/s"),
+    ]),
+    MetricGroup("l2_evict", [
+      MetricGroup("l2_evict_mef_lines", [
+        Metric("l2_evict_mef_lines_l3_hot_lru", "L2 evictions M/E/F lines L3 hot LRU per second",
+               wbu, "HotLRU/s") if wbu else None,
+        Metric("l2_evict_mef_lines_l3_norm_lru", "L2 evictions M/E/F lines L3 normal LRU per second",
+               wbn, "NormLRU/s") if wbn else None,
+        Metric("l2_evict_mef_lines_dropped", "L2 evictions M/E/F lines dropped per second",
+               wbd, "dropped/s") if wbd else None,
+        Metric("l2_evict_is_lines_dropped", "L2 evictions I/S lines dropped per second",
+               isd, "dropped/s") if isd else None,
+      ]),
+    ]),
+  ], description = "L2 data cache analysis")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -379,6 +536,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelL2(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.44.0.278.ge034bb2e1d-goog


