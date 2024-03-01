Return-Path: <linux-kernel+bounces-88968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE6886E8E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF47E1C23C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07F23D564;
	Fri,  1 Mar 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQVHdeWd"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895039AF3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319397; cv=none; b=uu3DuKlLrdiucMQtu1PUE+wzZ/hgo4YcQnTz+rHdDfy4H/gVGnVGOZgurEnriovycADDSxbEpJIPp3EhBHI82BT8DkETlSDihQ3h9do7LVxUxW2rtyPW38+x6jHR/wwVeL3Z/ayHE9ahGiGnZV1mzjNFDJJqg43M+X49FLe1kX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319397; c=relaxed/simple;
	bh=d6bcfgsUUelfZrIFFKTwcyB2obYk56t03Qv/7R3k+U4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U54oqjYh9RRXpXx0YNvGG0lCxEqTWab33yCnrtczDrypIdA1CjS41oYASXUGZkc+3sB7g7gkJarPskDc6ylKv0L9RZ7NwNnrHwN2BXjj9IlHL/ZXrtXvvCcpeZA4OJurUNkvaNB9fkEmQijprGgtzNGdSQwdrrahRra9Dd8WRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQVHdeWd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so40017987b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319395; x=1709924195; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ud2dHcNufn6h+i9hsSTaCNWNbOlP8ttf+JMwAMlMIZ4=;
        b=nQVHdeWdSVkcnIUSAD2sP2M2Xcjse6dKZY8AV56Li8fwbx1P0JmnOPVQYCjc1stAW/
         +5Zy7yiIeAM70eET/IeDhw+pAkvQEIydEyEStsZsF/8uN5bNFYpTnpFliFkPNX6iiC+d
         9vlynXLn9SpeQzikkuHYtbE7G1NlqlkqL6+nd+AFPZ5wOrFPe4A7ocebM8Y0NXqc0TSN
         Lp654envDzBKVsEwJFQ9MGnpiCwvvDOusfHsxZZy3zjwZyD0wrELkI+0cY2PCKQ7oYDL
         b9LYuW6LzQAanSPqvJOKUfntI6yUtfognyI9K74XGD6W3HVSDu1McD7ZoYGgWhXq+nhv
         3G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319395; x=1709924195;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud2dHcNufn6h+i9hsSTaCNWNbOlP8ttf+JMwAMlMIZ4=;
        b=qS77V8gYCiul+rDMJPwXCa58L7fspaxFTWJWK2LgV7/mnynazeIB5juEEn/E2j9WNr
         izKA/YmiVA7At5gxgBblhpgSuKQ371zKQIK8lfMU8RYgesMIqqeA4ftPRoeGjKG2Hvvc
         28d9UbhfF9UdXU8RPlHeUyKIBbzoJsER8T35rh2o24VEujwh97OgZGqt/ItKM5i7OuEr
         p6o4OmN5RxxRCorMj649ud3S48qjPTY8RWQL3k/GtfgoWCSEwQQOHuPJOSB+aKEWGhjW
         KjihQ/Y2nfgXwaDM8DnfhwJM4s6kMjEij8tUBMTBLznFhZiwANDzZ/zzJB+dpoSjhtp9
         bz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/aExCygAMZYj8JH8qaoqF/nhwPq8DXl6E+k7k2CRfGQZrH17j64XmfqnCIk0lml6+A0FlplEiglsVt5u9PsWeLPJc8HfLwLvP/Huf
X-Gm-Message-State: AOJu0YwwiC1kq9ybFSerFVtRz+3E7r2DqDhzUkVHzW+3GB9gczQCZI8o
	f9eW6hlzdIPktcuMZCRQbqSc9Wa0hSSxra4P7dadO+W4bDErEiT9mgNoLo9IgSQgoaceituZT9p
	Kqp4mnw==
X-Google-Smtp-Source: AGHT+IH/nnxqCGI7cy6WA5lXcgTbClOkwbOWXEp0A7wJJPXXcW9x2Y6Xra57UckGpU7kZigcNOJsZlakY2/f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:57d8:0:b0:609:51a3:b409 with SMTP id
 l207-20020a8157d8000000b0060951a3b409mr454389ywb.0.1709319395034; Fri, 01 Mar
 2024 10:56:35 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:48 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 09/20] perf jevents: Add L2 metrics for Intel
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
index 49b83bc28891..9f42b489a81e 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -272,6 +272,163 @@ def IntelBr():
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
@@ -364,6 +521,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelL2(),
     IntelPorts(),
     IntelSwpf(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog


