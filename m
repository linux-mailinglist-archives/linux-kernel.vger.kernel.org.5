Return-Path: <linux-kernel+bounces-88965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B308686E8DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D325E1C23360
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D93A1B7;
	Fri,  1 Mar 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqfI9v9B"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB93C684
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319393; cv=none; b=J0FdlX65bNx3ym1ui/XO5wNJBGGKy4tZhdvBH8jQgBu1Pz7hPewksNTcCT038Maopj86RdmjAWMmoohBopf/d0McyoLvbz2A1ey/qGB225PtWyr3ggZmbPKQPyzK6OukNp5gfTzBLcW6vBzE577wuzo1XOxSG21V6JnRFV5pN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319393; c=relaxed/simple;
	bh=/54YRscTrPrGaSdpjdXFm+80xMNflZRfzwa7Hsf5/WI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nZogRHs4bMF/TJDstbGRywuSAwRPiaQi7ZGjQvk43IvAadQuGRoRJXB1Lz9AHkD8JULwKaRSfjxx9Wj+uAAKSpIush6qncvvGpWXSa1DNlit402Garf2xj8hJa/DxGEt2KJBiXdf2noHlf9D8mTgeIGmY+8PZybR7ROHHqbyZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqfI9v9B; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso3956982276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319390; x=1709924190; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCqcOkno42A4mj5+uGyBsE4UljIV8p5MIV2GTsxx0/Y=;
        b=gqfI9v9BFL/2xmUnHAgMklwRYAkkOxw7WWox+C8ZL5jiWe+qP1OzPDdClw5GDdYe2R
         BvYtI9mzixLN4Ao5s/T+850s8EyHWZb28uvQFJRM7DSZ0LdfJSLiBhRBvwdsZMft9nj3
         qGvyqmgseNt7HebVv/4hKeWKpomSJwj9FAfU07OJj2yLTr305e21jxLxxXAkGqJ3Lbw1
         7E8Apl5TzIrNxDjBsIs9g4vei07Q7bq+mqIcikLJFqE2xQmsJhwDXmbD0jrvM2KCiD2t
         y0n6gfu/FMN1ucMhREvfVC2ri6H0/4GNUjFB3fT1Tfy+AmEWcDw30XzshNabAotKcSW6
         Mlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319390; x=1709924190;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCqcOkno42A4mj5+uGyBsE4UljIV8p5MIV2GTsxx0/Y=;
        b=tlKytVTJglelYwF4dXKsg+VKKub8hoik21CEszNe/muInNRVRt2P24KCsWp6X2RvE5
         UP4kBCkMT+dWuLoeFPNOYk3CoL2cy4QPYOQ6BKCjpHVV/FbEemGDcJAoYf5jJeWXvR6F
         Y17qun/Aq/RjoKLHqz+AL8O/oA8JskQlTykzmFy6CANRtJBZ4WOdNMAHtMmrLTmtuAYq
         Dzhrpqzo4VJmy39DAkLfu+Vju/vowppZjE9C9l8rryr1Ro+LHeyN6ETdmSuwQuqHJHQu
         +3lSOC6Lx+HTnnAl6FmYwOshFVlbclkMBcj42JwMSg+Bn0C4akg7JEM2TUkOHW1dW+6J
         ANQA==
X-Forwarded-Encrypted: i=1; AJvYcCWWGV4DMIVJG2aVegWgNT4kjd4RJgHLd58Bf/HGk0aXHumwOTPN7F9nqPGtHaygpIOzEuDJAZ8HNx3uvAOppuoOmIcPLbksO8TG78Bh
X-Gm-Message-State: AOJu0YyWxqo4/xboqxNAa37i+Gu6GWtIPMI4aPfTXxOxQ4wx3Y5isWZy
	msqC0IT2PnqXBAwZVrWPeGLQ4adhymNZpTccCI4pnLUMLIJviY0UTpPqPmyr/ORxA4pOfgb6UXm
	oAhsEWg==
X-Google-Smtp-Source: AGHT+IEVKYqSb1RJP04tzj1IpHZ72wqswmtzlfQnV49UiPSHcWuectfxWge0I8mzChan/LCCgyQFrzFNe3Nf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:aea8:0:b0:dcd:ad52:6932 with SMTP id
 b40-20020a25aea8000000b00dcdad526932mr551687ybj.5.1709319390095; Fri, 01 Mar
 2024 10:56:30 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:46 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 07/20] perf jevents: Add software prefetch (swpf) metric
 group for Intel
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

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 562db0a1df79..6c42c8947652 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -266,12 +266,77 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+  ins = Event("instructions")
+  try:
+    s_ld = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+    s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+    s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+    s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+  except:
+    return None
+
+  all_sw = s_nta + s_t0 + s_t1 + s_w
+  swp_r = d_ratio(all_sw, interval_sec)
+  ins_r = d_ratio(ins, all_sw)
+  ld_r = d_ratio(s_ld, all_sw)
+
+  return MetricGroup("swpf", [
+      MetricGroup("swpf_totals", [
+          Metric("swpf_totals_exec", "Software prefetch instructions per second",
+                swp_r, "swpf/s"),
+          Metric("swpf_totals_insn_per_pf",
+                 "Average number of instructions between software prefetches",
+                 ins_r, "insn/swpf"),
+          Metric("swpf_totals_loads_per_pf",
+                 "Average number of loads between software prefetches",
+                 ld_r, "loads/swpf"),
+      ]),
+      MetricGroup("swpf_bkdwn", [
+          MetricGroup("swpf_bkdwn_nta", [
+              Metric("swpf_bkdwn_nta_per_swpf",
+                     "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                     d_ratio(s_nta, all_sw), "100%"),
+              Metric("swpf_bkdwn_nta_rate",
+                     "Software prefetch NTA instructions per second",
+                     d_ratio(s_nta, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t0", [
+              Metric("swpf_bkdwn_t0_per_swpf",
+                     "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t0, all_sw), "100%"),
+              Metric("swpf_bkdwn_t0_rate",
+                     "Software prefetch T0 instructions per second",
+                     d_ratio(s_t0, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t1_t2", [
+              Metric("swpf_bkdwn_t1_t2_per_swpf",
+                     "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t1, all_sw), "100%"),
+              Metric("swpf_bkdwn_t1_t2_rate",
+                     "Software prefetch T1 or T2 instructions per second",
+                     d_ratio(s_t1, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_w", [
+              Metric("swpf_bkdwn_w_per_swpf",
+                     "Software prefetch W instructions as a percent of all prefetch instructions",
+                     d_ratio(s_w, all_sw), "100%"),
+              Metric("swpf_bkdwn_w_rate",
+                     "Software prefetch W instructions per second",
+                     d_ratio(s_w, interval_sec), "insn/s"),
+          ]),
+      ]),
+  ], description="Sofware prefetch instruction breakdown")
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelSwpf(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


