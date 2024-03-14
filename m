Return-Path: <linux-kernel+bounces-102845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE187B7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649F71F25C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB63D56A;
	Thu, 14 Mar 2024 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B97USwWV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3514F90
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395994; cv=none; b=sI1Q4KH9u/0ryaD4PdWz3uVLsJxad1PBW3F42/CR0lrG4T2uWvR4NSJ+vFL4S8HuN9tFYrTJaQsjK4X+9gZnBPFfOOtWfC6fyF39zrthmk0op73DfjZBo/z6H9VqYt7Qsxee2ZT/tx5W/DViK6UpPjqywRoRsZjeTHBwKfa/x1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395994; c=relaxed/simple;
	bh=nJWLpagX3fnUwoQICD5hV02eLFbaofPniJ75oRrnaLI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fYKoOeI8wdzHdK/AA2Ttq9gdRG/a8ytyEnanxEKlB+PGYMqpPpa3gYh1GxGTFFgMrySzm+f9VQqtwcuZWmxOExDSrHjTKIpfEV07n8zAbKutGvpMSxbOt1Vg0me/NGGnvBJpS7E7S9v66SZiMuUI8APzJQ+JjSyRimPMDchjos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B97USwWV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc15b03287so719139276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395992; x=1711000792; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5XPP3oK+Thn/1zVInzu5FDzzEZZaV5BcTwipAM2LAc=;
        b=B97USwWVUKN+k84mKYQlKEOwh4jVIQCLYh1MwvkDI04ynl7ldGEyRzK7XRDzFk6+P1
         8SRLjmvhS38bjSUCD6FCa2XH7NCiuM1Z7GBvzw26WzIwPcPbKYieHC+5x2Y6cpTR2P2T
         cx+QK6fK1UbBwprzDZ+oxImstTMCDPDKSrkDEI6DbrOeqYqVGYWhvxvNULWr5sJW+MGX
         hTOHRW695xoea2s4x+XRBSMVJsDs7suSIbg4krITON1ax8o8g/AkcSmUeXYmBvjjpovk
         KcB4bMrxjaUCKkPibKe0KIpj4+5ESzaYEM0RGQDpO+r9YSo/wZkJUwUFdMh9I8vLCLF2
         3T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395992; x=1711000792;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5XPP3oK+Thn/1zVInzu5FDzzEZZaV5BcTwipAM2LAc=;
        b=v1gHm4Pjt0Z4itQPmw4jKnJechZbxFluY8NpdZkF4xnoTxxjQV7XJFAZRRcdHX1/la
         k/5kh3fpW8Ou3I85NxZLkqgCLM5+pm6DsUksNtVtYIUGlnXyQ3TcOSLeoLFZ31GWhy2d
         +0cqp5ahzKjYNZD0wlAKy28p/wwed3fpfHwsAdzLz+v9mmwrllQkRmigJ7ARFYZAwHJe
         nzVY/UKAdBAVurJh3h10/NQ1X5zcnur7JAji2yYiNBhgT2NYa/T5kO/usBCw4/QuGenM
         kh9FxT6v7G0VNPw2XyPodACFmleSNR5h0w1/BpfuqdX3htgWOYJxF/1zaqD0fMO1LFn0
         0aqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcNVSGmz1yBgUBi9zYxIToqF4GpwISwOlg0UI2mDU6CqLT1gzidajq3IeYXJJKCGVrFV3zWJad/DpOphFD+DpfpNuhQY0GdWZztgnj
X-Gm-Message-State: AOJu0Yz1eVxH86kNodVMebggoyWwEL6uu145LcdpZow3Ycun4EtKpCxY
	/wSAy0XlGxyE1bOVTtxTD4FuMtoFlRf5BWLrAtVZ9URYGCol8DI4PjzPR2LvYdGIqga0w90QkNQ
	9M4Omjw==
X-Google-Smtp-Source: AGHT+IH5I8Fe3CBTlfB/EPtyqAz2vDrc+lU9Zc5GRy3nAjmfR9sDsnN7X2mAQs+C8FR01oh4LdpOBQfYymAI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2503:b0:dcb:fb69:eadc with SMTP
 id dt3-20020a056902250300b00dcbfb69eadcmr20434ybb.6.1710395992101; Wed, 13
 Mar 2024 22:59:52 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:06 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 07/20] perf jevents: Add software prefetch (swpf) metric
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
index 09f7b7159e7c..b02d0c0c3793 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -260,6 +260,70 @@ def IntelBr():
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
 def main() -> None:
   global _args
 
@@ -288,6 +352,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelSwpf(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog


