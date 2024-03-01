Return-Path: <linux-kernel+bounces-88960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8FA86E8D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9D81F21548
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166103B18F;
	Fri,  1 Mar 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="td1ebTcd"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5C3A1D7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319380; cv=none; b=bGSBZft0MoeYWWMWtFYiJJklmB4qnsEpoWGcMBjfYdcAQKy4XGPx14ftK7HnMFy11p9ZujiLwnpBOFRQsEE8X3tbypCiOWPZz/NtflXanvKXNucdmBrVsNw3DQupt6BS/t56x/jmcRyGCvq+e1pWVpX2lsfuxtRqAcivI2OvJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319380; c=relaxed/simple;
	bh=E0c1iJm+nhJFbSwna0W+hQvedFVJgQU0OfqpGYXtacY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QtB+kvDger/oaHMA1RniFf27aa9p0JyTsybzvwaSiPVN93Y/ddk1vkbT3kIPcCkF5yckwmuT8n0S/FcKYf0S0t6hprOvwvsy6j3QvDaQNpb6BrfnFeiQS0buU3HZgfPoVXFSyqkaIqJQ+s1tpp9NF2EMPzuXTxBXLFhJe1DIFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=td1ebTcd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608852fc324so36525067b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319378; x=1709924178; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKFU1+MHZzi/z8CBZByS67OdqLWVZjwrZ1eTBs4nZzo=;
        b=td1ebTcdZk28aPBKMd1V2gQC/JTGS0MXy7/ALgwf4r6Jt0yQPthZHqgitofER2UscW
         ng9fLcoJYkgeNahsctRIT2JrwiGzWgS9AIktuL49BMGjQrc4srGUEkD48qNsCDshyYHI
         Hm6cDJYVue5uRjdhoIVp7p6NEi0pjCdiTbzWv7gyR0XYKE+Sga7g42ALdRUwjX4r6sjU
         Barr+Fs6t6hR/O3N2Nc2UOenVlEAMXbfRKk0P/N8Ig9J6ZKOa9rYTIXAtU8FRvH+/kQ2
         eCC//QJ57/k5qC8BhsIXpETi/xIRFibFd1PP9NahV5uFSGCE0V1uuYBh6I6aQh43jHKG
         iURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319378; x=1709924178;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKFU1+MHZzi/z8CBZByS67OdqLWVZjwrZ1eTBs4nZzo=;
        b=dGxtsn+G5aKZn/coaZQB19kWlWu9zf5b4N2LJfXEYyYXZVOu0kikL4eMTXRq6u0DRg
         CqE1T5pHdUw6Mg8+X5vyIEx+j3MLw18QBKGZKdTa8njoIHik1Ty2mslq6XYhzyYeT7L3
         HN0YcCv4BWd5hPE+f5KCtqgA8nb072CkRd5Lrz7o1kz+pvwCqk9/Ai23eqOAkDGn74SL
         pLfxhrWMOzx8ivtNc70C6XLhxV+4kR4FtezI8zeV6x9tW3hzbORhP4ik+sKChtrdD5tv
         ldcjR3MOm06yCmU6v/Gcvo+5+aklIklZZylHsJEClvZbeyU6SjY/Mgnxk82Wh6uGqR5K
         M6/A==
X-Forwarded-Encrypted: i=1; AJvYcCViwOadC7bryDkC48aR7OHGftPVPaBBQW7raMPRaCFEJGtehaiwhyt69VimyxR123NQl+BizAG7Y+24/XaUUxuwme7bxEF0Y3HsBT0M
X-Gm-Message-State: AOJu0YyaS9IAOnKUsxvAKG7ZsaOPZQ7c9eAwLcHuhdlmMuhou1K1+Vyn
	50YCCenw5j4D0EBtOq94rKgM1TctDufD+qnktCkGE4387t8/a9S4haFq6t3179elKmaSkTu2cMS
	ejlL+Zg==
X-Google-Smtp-Source: AGHT+IHU5sootKYsn2v95NMGoRi3R41CN/d38Kn03wSGCpThROIQ8S++5MzkqtSSFcyPAOCyCgy864qVFd0I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP
 id w4-20020a056902100400b00dc23441897fmr538112ybt.6.1709319377920; Fri, 01
 Mar 2024 10:56:17 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:41 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 02/20] perf jevents: Add idle metric for Intel models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 7704c170a7db..2622d4e5ff54 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,7 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 import argparse
 import json
 import math
@@ -17,6 +18,16 @@ LoadEvents(directory)
 
 interval_sec = Event("duration_time")
 
+def Idle() -> Metric:
+  cyc = Event("msr/mperf/")
+  tsc = Event("msr/tsc/")
+  low = max(tsc - cyc, 0)
+  return Metric(
+      "idle",
+      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+      d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
   """Processor power consumption estimate.
 
@@ -52,6 +63,7 @@ def Rapl() -> MetricGroup:
 
 
 all_metrics = MetricGroup("", [
+    Idle(),
     Rapl(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


