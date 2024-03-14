Return-Path: <linux-kernel+bounces-102846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426B87B7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CCA1C220DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC63EA6C;
	Thu, 14 Mar 2024 05:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSNs9+tY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B303D396
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395996; cv=none; b=fscIjAmceEcEw585pn6i3GFICzCsXtgzSa35+NmkWF3+/UhRa9KUxMJZXfcZiQfXh6zBJV20Fs1c/cTxQtM8jSNL30aKapGWM3zDuV1tyluB/141Xx1YZmXXjGI9CljZjyCppHiZdvPye0br03qYxnX+RoXJMgXUlxudNwS8hbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395996; c=relaxed/simple;
	bh=1Qr2GggjPi/6cKOviasaXOdwphBzKolEl5/0BUkGD1s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=trm0KK7e41IvEehanUGKix14Oc+kqm7sLYCoRrLe8+WFoFoDR3je83Xnw6Euv3aCIVyB/Odfp4ndQq4ItJjjSh/QqAHaMAXMsNfIsRVwuLPrPLVosVaTjxwgJm4vc5RqBcedD1VEy+z18u3Y2FHzrm3OSb/SSqHsiInvNrc4Cyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSNs9+tY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso906787276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395994; x=1711000794; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE3dX9dz2CABEFOsw5CuUFowasd8wR4u7GmklzSvWhM=;
        b=JSNs9+tY95CCkU3pejcP26dgu4kBgxLsz5vQ+G9c9nc0wXvYTvugDRscn2gshQSYCe
         SlBm53EN2T8vQlBHUg3Wlh1vh3Bbmea7j3YpfUjir3xliH3cyb2Myy9llo6to64/NvFA
         CIOG3qVPcRi3QbLIUCqySzOmpyOByhYsdh0NFlkLqLN/Fp762kJFq8WPG8xQSRcwXFK7
         6Z9kg/R0DQeMxxhS7Yu5/Y4CusJnqQXCysO4FhRdNJObie+5PuTg+tO14E0Gl/lpfLVy
         cUGL2l3Owgos6rUeu2l6e3RYA6YS4n5DIuxyZaHhtgu7FD+aw7fFoCYwSueztwQ5Lvjj
         fBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395994; x=1711000794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE3dX9dz2CABEFOsw5CuUFowasd8wR4u7GmklzSvWhM=;
        b=S/H/yQYFnpTmP3pUAOG6jDzib5iEDtDGJJhYiVvg0UpPR77zsrx8P6jv27Iz0bXYoA
         pUaQNvtcmrOVGDd7Mjw2ydP6VorWZ81B+MeoZc9ljCrszrjKoxSrwSxoRrA9U78H/day
         jEKpk7hoCbeeiWR4JknNYyoQ8y764hidP+QvqG2HU0B1jEOEAiTqsxMujS5jOexmC/Hq
         u7X0ZLMVU+yfNC0dKbDc9aEhzVvE+p78v4k+u7ho2LdKqZ+dcYAkbpFt4OiX6ZV/ijSl
         qQkiLnTTuYV2hD+4O/fX50PKhVbv3r2zfotuIv2akh7x1n/sb816EzAHVm+Dbnas7fPf
         uh+A==
X-Forwarded-Encrypted: i=1; AJvYcCWGStd6InXU6z+nl6xvx4ZRT+WTD2d9GEBVkRMnla7anhalxivieCJMuMISwoENm4fxM3kzg5Rd6unJ72M7sOR7bNorS3OImKSLE4IQ
X-Gm-Message-State: AOJu0YwGlm7Qn+f3sfI6ti3bpvtsKI7JHy2BizGdZDzIQUsDyC4GLeVy
	z8lBD6xXksVIwqCIrTQ/enVlVmwn/Ug05QTsgyQ0zoQM3FxE4xVHMI3MtBitPl/d8lSr/M/8xya
	AcNTulQ==
X-Google-Smtp-Source: AGHT+IGL9I2AEtU9Gouc8KiH//2cnv3aSfUatRw9lJIZ+fLfFOIe54VbJ81T1fFUWjOlzTPpwFpI/IZ7Fpmt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:247:b0:dcc:6065:2b3d with SMTP id
 k7-20020a056902024700b00dcc60652b3dmr211350ybs.8.1710395993876; Wed, 13 Mar
 2024 22:59:53 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:07 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 08/20] perf jevents: Add ports metric group giving
 utilization on Intel
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

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b02d0c0c3793..b181574c9486 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,17 +1,23 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, MetricRef, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+import re
 from typing import Optional
 
 # Global command line arguments.
 _args = None
 interval_sec = Event("duration_time")
+core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                    "CPU_CLK_UNHALTED.DISTRIBUTED",
+                    "cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
 
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
@@ -260,6 +266,27 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
+
+  metrics = []
+  for x in pipeline_events:
+    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
+      name = x["EventName"]
+      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
+      if name.endswith("_CORE"):
+        cyc = core_cycles
+      else:
+        cyc = smt_cycles
+      metrics.append(Metric(port, f"{port} utilization (higher is better)",
+                            d_ratio(Event(name), cyc), "100%"))
+  if len(metrics) == 0:
+    return None
+
+  return MetricGroup("ports", metrics, "functional unit (port) utilization -- "
+                     "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
   ins = Event("instructions")
   try:
@@ -352,6 +379,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelPorts(),
       IntelSwpf(),
   ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


