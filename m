Return-Path: <linux-kernel+bounces-85900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3244486BCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD9A1F224E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270456B9D;
	Thu, 29 Feb 2024 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPoGWhhT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A685336D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165925; cv=none; b=A/g4RGbv5jMp7J+dtrz6bZaC5aoTsyimZxgTmiLqaF4dUYSUHUc0vcSO3EUoswoP2JE98lLjIqRJSSRGo3fyEaoHgBq8asMqisU9MraeFcolcvT52m5tFzFTbxPLB6DXl/oUJvMYgNDOS0GOoc78tJokZY+yLF4qmo8EogL+ff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165925; c=relaxed/simple;
	bh=9tPk+vGpstow6zqoysIPvqeqHhBpWkNTO2bW3Gn7ZAs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FcXEz4ragBodQcIVuTonql4ZhQ/5ySN8XSNHbi49dWsbJnxQfilfFy+2/5kYcCXTPkJV+aDO3Bo1I9JPYWIDev5/a3DDWh7XOgtyTsh4GqZCgUlY0ZBKeNh4cRmtI0c2Xmu8bhHNKghCbLgqyoqS6YP6IKfpFl6tc30b9el9lIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPoGWhhT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so650566276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165922; x=1709770722; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hg+O4OOMu1UeLWG+Ohq6wGldowYOme6w15H8KRpykG4=;
        b=aPoGWhhT0UjaRvKgpwnlvnfKB3THcXfB7DYWfkRgTgKei1Ypm5Wmaa1gdPo+wNCKw7
         VdWsz+7erQA4JyGn70bWoPYwxbCHBC3IN9MSapqPq4naGvaOfjVh9iO69qfLnmzrCKHf
         5n9N5og14kskqwtcloU+mMm809uvYg+qNQc4Xvw+g4RUaBYYGAK2JxgwmlZepj6uYMDE
         ZwHivQG2YtEX2orzU6FUVMlMMSa173oZO9fT6fxZ+rLvq38s/UOHdhYSTuWHxkGTMXjT
         O6o97Kcsuq7pXcVp/o9bavI06IAJnMWCiCnbdlC0g612PquAvVqgxd1kO3+67X/FfVGC
         uhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165922; x=1709770722;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hg+O4OOMu1UeLWG+Ohq6wGldowYOme6w15H8KRpykG4=;
        b=dOlEgSKKsmT3JIelsT4+sXtrZJsLTBVyw6LZpKyVJzuegBevFsHMsbM54z0PIqm4Fj
         5oCuWpCCD+tqxgAWaYPymaocvx3vZcq+UwwBq+v+A/uAglMuM5dATX7dwM/uQKmwzUE6
         83mbYEOjyjjg+9wM0dZqKeEt6ea0fxRN+E4fhgQLkA2N9eiZF8FPmgGIgqpnz/dCN/l6
         Z7bSDundPHb8o0FdlGHYjSeVLCx2/H9DI/rkL+U5iMwxZKS9hjzhcSW1Eqx2/yJmz9vR
         /ldznNGowq3GYokU7ZUVxdFL+bzSZYclkxu1uzhOU+wHjCU1Qfh/XsvrZoTHV7Rm1fiL
         9soA==
X-Forwarded-Encrypted: i=1; AJvYcCWCOATqTWuuZuPtx9qtv9/dO0HAdXDYlPHzVH6oufj9DCLhR+6R/zDC9qFVLCC7qljyyfvqrUhkyd6er3WqW+Yyb2tztX6ZAfOsYXAw
X-Gm-Message-State: AOJu0YwrtAn/AwgBaOpphzC7Ww7Wmo5Zl1O8+E8KdlGKPYPmvI61lWCj
	BMriGnLBB8/9hCSfpqinstq8uaJ6Fj0gynkrPnalU3CtGwR5umSWxVux3MEnAI0J6cEbEIRBkIf
	v8yBZgA==
X-Google-Smtp-Source: AGHT+IHZTLAZCpcHID0LocymT4ALBiZpAWnzQMEtuy0UWRkiO/2NxkVy1wPL5J26IY+cVJZPazuaYoGssb/M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:120f:b0:dc6:cd85:bcd7 with SMTP
 id s15-20020a056902120f00b00dc6cd85bcd7mr213546ybu.3.1709165922485; Wed, 28
 Feb 2024 16:18:42 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:53 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 08/20] perf jevents: Add L2 metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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

Give a breakdown of various L2 counters as metrics, including totals,
reads, hardware prefetcher, RFO, code and evictions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 158 +++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 63d46ee1dca9..d22a1abca8d9 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -271,6 +271,163 @@ def IntelBr():
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
   pipeline_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
                                    f"/arch/x86/{args.model}/pipeline.json"))
@@ -363,6 +520,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelL2(),
     IntelPorts(),
     IntelSwpf(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog


