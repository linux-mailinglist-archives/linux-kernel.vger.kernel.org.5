Return-Path: <linux-kernel+bounces-102853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D4787B7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A99C1C208C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3134EB51;
	Thu, 14 Mar 2024 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjW59jlT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D22171AB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396005; cv=none; b=h7UAQgUmLq+uWn8gio8UHFpTe1cIuSb6VwANrBqhS4m6nZ/Tjm8KwNcFt/hAnEHpABoqDb4E9KsLaNa1S4t5OZjYyj9j16JAlPQYzKTamsHa2Y757vCKKUFcsIMVnqdS+XC659yZAcfrkpQ4QEVR5LNqTP2ekvVvRNiS2Qcw2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396005; c=relaxed/simple;
	bh=EoFQZBcR++BJQLNWKAmvS5P9iYM2cGSAT9IpU470kgI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VD9daeEHj78DyYBjZaMv9TgUuHPthpi97XKT3aUMUGJ5r1h04Na0202AgRbqd6uZwg/RKMkWZFrJdfThvbX07YlQr/GP24iAFr5hmfitvzRcQlhUohs9Y659IxbNm5kvZ+iUxAInQFHaot2WNEsDLP/hPIWOruU1WOZ+DpYoHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjW59jlT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a61b31993so11547117b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396002; x=1711000802; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2Jgedq1NZZPPT1/Dtc3WDNIcL7gv577kczHEe0Db7I=;
        b=WjW59jlT/S+m5MRfXyMH1t2YBnAbv1z0kjwqTwag4v77T9TCZHfoeCMEVZQGHPwrGP
         lrt2AK/19rHkAEN7dEh0+xU00YxjCZzGnMzoMcVo//4XNG7YDgGGEEi6QQV1DL5SdLaB
         x0QrgUHC3stvxUsKmxqqFsOavz9X8sUsKN4KiLA9D8aeaiK2TtFZnNBAGOWIWYuf3+eI
         +zU8oM9rhVAH7LizTxpqkvfrxswpx2b/XNBgySJgPbL5fA3iqUawdo3wmkALu1lgi3Ay
         uT/09GBxu8+yZtBMx0HeK1iBm3W+it+Hpj2O/9nbq2/wukaFegZ/N2xqoYIv5P/PXHWL
         Gz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396002; x=1711000802;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2Jgedq1NZZPPT1/Dtc3WDNIcL7gv577kczHEe0Db7I=;
        b=AY/CJzFMIoipATuHk2rSVT+jaFyfYgEyyqr4gK2n+p6tTNVQVPjMwrM211luo2NyRu
         U4ULz8OE/3k8AfTlQaro6Wm5yL/EhIU0zeoB9UBUAK7aiB/y5KjSPmejFEjOJsUL8Ehv
         51bTFT62hVKpzla7gfxQktu63IL1q0uRnyc/8gWzx614Q4mowhcunAOPFbexp2gEDfD7
         iTe3PrbkB3HTYdE8f4VmDlqjMBCVQWIDEc2WyWkbm+NWmEyIYAO/WpxLlBOqmAJGpeGg
         YiXsKUWXpoYue/K2l8vWMSEuyxpmY54LUdVvS+XUXqQycCRdrYLz4fzkgo0YtMps6lVu
         PeSA==
X-Forwarded-Encrypted: i=1; AJvYcCVqgqhN4yXen6t/BGjWQ7xFf4M5h95kOWMO2RBxKiMZpeh6dtcpIcrAXnU7O3iB+ErsOi8iWTCPDVa2xQMJ6Hb+UgHG554UcO11lItY
X-Gm-Message-State: AOJu0YzLHFKJnJZWU4nJTGXSqPQdpDc+0IK1uTsWPbJTDY7ZNMuPWHmH
	dOypTW4YpOym8fxZSm7GVMgrHwx/qoQ4Fc0rtb409cx6/wQMWUCiKiqwFxcAtTILYFCQ7yEBoCj
	YiYV2DA==
X-Google-Smtp-Source: AGHT+IFDQ+9xU0M+SjIFSslxASNCJrc5/k+6p6o3YihJ7av0y0N3jJIcNU/Crks/O9Qb/x+/ZtaBweQ5IYsJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a0d:d808:0:b0:60b:998c:389f with SMTP id
 a8-20020a0dd808000000b0060b998c389fmr179760ywe.10.1710396002262; Wed, 13 Mar
 2024 23:00:02 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:11 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 12/20] perf jevents: Add context switch metrics for Intel
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index d15f9ac05204..387981d58320 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -266,6 +266,60 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+    metrics.append(Metric("cs_stores", "Stores per context switch",
+                          d_ratio(ev, cs), "stores/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+    metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                          d_ratio(ev, cs), "br_taken/cs"))
+  except:
+    pass
+
+  try:
+    l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                 Event("L2_RQSTS.RFO_MISS") +
+                 Event("L2_RQSTS.CODE_RD_MISS"))
+    try:
+      l2_misses += Event("L2_RQSTS.HWPF_MISS", "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+    except:
+      pass
+
+    metrics.append(Metric("cs_l2_misses", "L2 misses per context switch",
+                          d_ratio(l2_misses, cs), "l2_misses/cs"))
+  except:
+    pass
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
   tsc = Event("msr/tsc/")
   c0 = Event("msr/mperf/")
@@ -648,6 +702,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelCtxSw(),
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog


