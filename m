Return-Path: <linux-kernel+bounces-102851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB787B7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85CF280D27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C34CB2E;
	Thu, 14 Mar 2024 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L//ABNds"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431943ACE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396004; cv=none; b=iG5XC0JjsG317cyqGX3vicOQHFkD7diukSrCAuhlu+Die0mcs1qAf3hvwzvf2x+MzCOSBzmbOSvW1CDmS1Tvgz1n1m++lk4wijC8IlaLNd+87xrnh2xRgPsveF0J649BerAmeNzdG//WpY0Ze7SXPruFyYiUz+jK3s6TvhlsONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396004; c=relaxed/simple;
	bh=ATIEU1OwZT5UPCeNuSu9+OJJ7mgcQCq56xVHEiwhOQo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jO4o5QUf28+L9XPpSOuVpAFazgg3H3DOj/zS1XBot7kwh0f+YWkknjpzL3VfdMQ9mo5nFSb3q38UGwsTu+0yfRquFBC6HmBgIXmD4e1ufhmSxx+bAABk4cBq2vT7yEkyFcWk7B8FSc7x5VOw8Q9TgbGGgUtajUGeXGMG64GLvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L//ABNds; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ccc3cfa39so3470167b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396000; x=1711000800; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dpf5hHVN3JuBV5acx4fDuNQxWamY4EcOXEKL6JOmADo=;
        b=L//ABNdsdXLmodTQ6SJNfN+MPpaKjkg2GvsVR4+3VtQ1DKImzLP0AeXF83Yz4FF9Pb
         5AxYKcmqfMxOK4+QbcvtHFHDn6kYbhaB20JLIv0JlN6flTyyI40KdBHj6MtwHa/0t7J0
         b4QVe+o1/0vSM0eGvi5x6rkFzmRVjbO87bJ2SrHjsFhBfjuyYVTnF66vq4KUPacQffja
         8YjdrvQHkCZveMQfG5cz+SyCJK2Wx1VDKjUdZNCfG3MMK1QZ7G3Y4HSe34Lx/l232Yjp
         hIzEX4ocJYJF9D2l2OB10uiI8zu3C+fI/+GRzQauXz//S607VbJOvPHeBDHcRtXKT2Xr
         bpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396000; x=1711000800;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpf5hHVN3JuBV5acx4fDuNQxWamY4EcOXEKL6JOmADo=;
        b=VmcedPcdBQ1PFBhI3xLGTxsgEndE57QzoTTBWi5aMTr0ALDbPqAbRt+AmNTVCR1LH8
         C35Js93JgD2Zk9LowlmYQhVGcV4dAL/rMfICIJrMynOWJFt9aGmCUF+xnONCzJIDrlT+
         ajJMbI0JPS0Cvd6WMbAWRHS7ETF5q7djLGPTgvUmknd75hZ+5qOhwuTI1W+oC+wPqEfm
         bzjmv9rki+1ku7jKiI45YM39sR8uzHB2Cfv3oEr1xtnmbk6hlKwT/b6KnpTB5GwumfgD
         frc2nlp/HMCiaxN4YZLdsRPqhQpiyL1KlV77wdNKPoI3mETD6hEuCU574OlaCh4yUSxa
         0JSw==
X-Forwarded-Encrypted: i=1; AJvYcCVF5R/b1ELo5cobli3tNPQRjr8pYW4nCm/hKcZaG1Ohnzf/Q4ECQ3HwTaxyQNXvkOlA0NwS4AnjFKHjzg59Egg8bEY4d3ivxDCdnols
X-Gm-Message-State: AOJu0YzzVrYhcDpe4eBfr3egWyD+R29W2cV0anlo7PB8DbCGcEDw46kP
	RIHoMFcHJtOXK2J4+l9TiQLfIS6FCkVjhZfOXbEOSJ6SZ59sLntJG7+lV41oO3GL66hyVyr+EEI
	5/ACcUA==
X-Google-Smtp-Source: AGHT+IGZTjZk04FELRhd0NJWv7Oiq9IKYNIMixNmG3acf5ytq9ZgxcP7xIUpAkvk/rTlh7aM/9Zepk/FZDZ5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:5297:0:b0:60c:b1d4:a9f9 with SMTP id
 g145-20020a815297000000b0060cb1d4a9f9mr210861ywb.10.1710396000037; Wed, 13
 Mar 2024 23:00:00 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:10 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 11/20] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 4ac419212b3d..d15f9ac05204 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -266,6 +266,35 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+  tsc = Event("msr/tsc/")
+  c0 = Event("msr/mperf/")
+  low = tsc - c0
+  inst_ret = Event("INST_RETIRED.ANY_P")
+  inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+  ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+  ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+  ilp0 = 1
+  for x in ilp:
+    ilp0 -= x
+  return MetricGroup("ilp", [
+      Metric("ilp_idle", "Lower power cycles as a percentage of all cycles",
+             d_ratio(low, tsc), "100%"),
+      Metric("ilp_inst_ret_0", "Instructions retired in 0 cycles as a percentage of all cycles",
+             ilp0, "100%"),
+      Metric("ilp_inst_ret_1", "Instructions retired in 1 cycles as a percentage of all cycles",
+             ilp[0], "100%"),
+      Metric("ilp_inst_ret_2", "Instructions retired in 2 cycles as a percentage of all cycles",
+             ilp[1], "100%"),
+      Metric("ilp_inst_ret_3", "Instructions retired in 3 cycles as a percentage of all cycles",
+             ilp[2], "100%"),
+      Metric("ilp_inst_ret_4", "Instructions retired in 4 cycles as a percentage of all cycles",
+             ilp[3], "100%"),
+      Metric("ilp_inst_ret_5", "Instructions retired in 5 or more cycles as a percentage of all cycles",
+             ilp[4], "100%"),
+  ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -619,6 +648,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelIlp(),
       IntelL2(),
       IntelLdSt(),
       IntelPorts(),
-- 
2.44.0.278.ge034bb2e1d-goog


