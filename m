Return-Path: <linux-kernel+bounces-85912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974786BCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB71328412B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF164604A9;
	Thu, 29 Feb 2024 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3GFQFwW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BE5FDD2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165951; cv=none; b=WrZR0CbFbPqhT4bOe30HgDpxvAfSoEy3XXewyAl2VMxfCCKBjhRz/utBRojSTxOv0D3fQuAj/Y5AmhCmxye5e6J4HP4gFsi8q/3UEbLZnvnZxGoLLKQymwznlPhUi491P/YHVXFuRk9H4Y8keXFu7Pqn2qWyxpGRrLeiyxbxZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165951; c=relaxed/simple;
	bh=HvG8OnmJueim0ZQLofUBNhtsvwoXfQ3M1FY1SvPuynk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZbWxyQqY7GasjzLyKzOGXJfaOTkwUbLFY1KL6iTg6BJyP0UCKgBWprfIZuw1jil7Kim1hzLL5fZP5b8fb8F0W6zyao2ugtlcu0nkQrWysnBkuibIJ9bquYCnSMM5CnOoSclBVqYJtGcUqpBZ7XwVQQGdsDF/qQvS/uRJiMuPevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3GFQFwW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso610999276.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165948; x=1709770748; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHwxTyOi6lmXZYsarPu6rddsGOcfVBFqWW+pqTf9FsI=;
        b=K3GFQFwWUFhHg/zkvGJJzIun8kqC3Nc0wqzXQcHcj2+t+4ZUiNutdvhw7JGy4cfvD3
         fbPU/21uS8E7WUPOR9npb+qU2HXzQm2BtfjM+6oSTlHzhPpRZDlcaCxQh0Xz/RAWLb6t
         LFmorF+AV9G9Gem6cmdRZx61ELb0oVAMrVbdKrR38ZPX+Bgrj2SysjrIbouZBnh/4Nir
         L6vQRaYhsbMkaFdkUqRxDwgJVMa1is6rm2HaTqtZ52wwUaI9r7CW7pDRb+0+6PZlHrUF
         4tdtdq4WgTLRn5NBfFEbanci4Ye8kngqbwwnoS4NH1qZi62VQVbI0rKeYEAb5cK6bFQ8
         aEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165948; x=1709770748;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHwxTyOi6lmXZYsarPu6rddsGOcfVBFqWW+pqTf9FsI=;
        b=cGoutDEZDrsQuS2xr7Ae1McGH6tkgjsFIpz0/TIaBSYKe1hoS5HHnD0LAT/jucjHL2
         ikG9p7Eg3zq17jnxdmrN7EBDLGREsmwCxKldv+bhhNzAuaCYTSkD76X8DyQtFFXNsGqV
         0gXdDDJCvMoTFrBFHvzZZmOeJsrgFvFOJKb4FLDb+pzo1cz0eXU1Tq7hIKXuguOhY7Uo
         9bumfDrgadlrcllGX6ZN5X6xYK6beXBUiTx6N+ghjE8l0m0ZzCGVAMH/eHihSb8NIK4p
         fQe7QhvHzDwROtMvwOGDnssULuJh4SjA+tPt58ufU7rl2t86ftSFw8rQUQAKrilvhI/7
         jvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsB2kisiQuYVKWt15OArV7aItd3H/6uecthkzvDotHzKI542p9pjUZp8mcNBwzqF14niDkjdSO87xdFa9YV3IDVcle0L+VMM4m24Lq
X-Gm-Message-State: AOJu0Yx/KK3+eJigRRsRY+245hQq90IRnj+cVj97qnj53GiO4WmdfVus
	YEdpzvp0GksxdVpxI8o/caRYrccOjBmAZAn1pOtwGYKmsjPtro2FilW6D+ohu78n80oXHkuEVwi
	mJPyBhQ==
X-Google-Smtp-Source: AGHT+IGA9u4F4RCaI4adGFIEbdpQrOjBAp1oseTxb1WUFsbrGJFI3nZyotig/Kf2Y8KNJ828vlGhi7YBkPkE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a5b:441:0:b0:dcc:79ab:e522 with SMTP id
 s1-20020a5b0441000000b00dcc79abe522mr42703ybp.11.1709165948642; Wed, 28 Feb
 2024 16:19:08 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:04 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 19/20] perf jevents: Add local/remote miss latency metrics
 for Intel
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

Derive from CBOX/CHA occupancy and inserts the average latency as is
provided in Intel's uncore performance monitoring reference.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 1b9f7cd3b789..cdeb58e17c5e 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -617,6 +617,64 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMissLat() -> Optional[MetricGroup]:
+  try:
+    ticks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+    data_rd_loc_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL",
+                            "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                            "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
+                            "UNC_C_TOR_OCCUPANCY.MISS_OPCODE")
+    data_rd_loc_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
+                            "UNC_CHA_TOR_INSERTS.IA_MISS",
+                            "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
+                            "UNC_C_TOR_INSERTS.MISS_OPCODE")
+    data_rd_rem_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE",
+                            "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                            "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
+                            "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE")
+    data_rd_rem_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
+                            "UNC_CHA_TOR_INSERTS.IA_MISS",
+                            "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
+                            "UNC_C_TOR_INSERTS.NID_MISS_OPCODE")
+  except:
+    return None
+
+  if (data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE" or
+      data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_OPCODE"):
+    data_rd = 0x182
+    for e in [data_rd_loc_occ, data_rd_loc_ins, data_rd_rem_occ, data_rd_rem_ins]:
+      e.name += f"/filter_opc={hex(data_rd)}/"
+  elif data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS":
+    # Demand Data Read - Full cache-line read requests from core for
+    # lines to be cached in S or E, typically for data
+    demand_data_rd = 0x202
+    #  LLC Prefetch Data - Uncore will first look up the line in the
+    #  LLC; for a cache hit, the LRU will be updated, on a miss, the
+    #  DRd will be initiated
+    llc_prefetch_data = 0x25a
+    local_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                    f"filter_opc1={hex(llc_prefetch_data)},"
+                    "filter_loc,filter_nm,filter_not_nm/")
+    remote_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                     f"filter_opc1={hex(llc_prefetch_data)},"
+                     "filter_rem,filter_nm,filter_not_nm/")
+    for e in [data_rd_loc_occ, data_rd_loc_ins]:
+      e.name += local_filter
+    for e in [data_rd_rem_occ, data_rd_rem_ins]:
+      e.name += remote_filter
+  else:
+    assert data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL", data_rd_loc_occ
+
+  loc_lat = interval_sec * 1e9 * data_rd_loc_occ / (ticks * data_rd_loc_ins)
+  rem_lat = interval_sec * 1e9 * data_rd_rem_occ / (ticks * data_rd_rem_ins)
+  return MetricGroup("miss_lat", [
+      Metric("miss_lat_loc", "Local to a socket miss latency in nanoseconds",
+             loc_lat, "ns"),
+      Metric("miss_lat_rem", "Remote to a socket miss latency in nanoseconds",
+             rem_lat, "ns"),
+  ])
+
+
 def IntelMlp() -> Optional[Metric]:
   try:
     l1d = Event("L1D_PEND_MISS.PENDING")
@@ -960,6 +1018,7 @@ all_metrics = MetricGroup("", [
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
+    IntelMissLat(),
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
-- 
2.44.0.278.ge034bb2e1d-goog


