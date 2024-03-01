Return-Path: <linux-kernel+bounces-88959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7486E8D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD361C21BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1F3A269;
	Fri,  1 Mar 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzbY4fVJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610B39AF6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319378; cv=none; b=KBszHy4O87rUEuC0tfFsAOTrJywBT6iVCAv25MUrtQmLXvLS/Sg3XomRNwSKyAd0sgW7lVo9aV0JwfNlPKbKdMhNgw2RYQax0RxuBFbZ0cgwxMOAs5CT2uMJFYw/QDD8pgrabviJ3l7fHORl+dnMUwsgivEU+/pfAZdY8u0/OFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319378; c=relaxed/simple;
	bh=eVUKJulxTaDZWA+5YoZDb5UoIVwFCiPRNSmcWb0uoWM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Vd8yGnSn3f1sAoZd0pRnkbFbdy1LsyFRAjC50JP8LiVb/5UYSQjKID5PXCxjIg1mkaL252HrNuJ4zkx3EAA9dF9Q8Q5OtuxGGMK8RQ8VHOsfrcPPeQPR+0btKnDa1jM+sP7PZeh14t81GPh/EM0EUxKvn8qBMziSBkxmyQnv8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzbY4fVJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608852fc324so36524647b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319376; x=1709924176; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3PxAWhsu0Wk1JCVDmtXtAqqbWoqISlhy4eOUAXnDEI=;
        b=RzbY4fVJ7zUHUvVgAM/nw25wC+77DsGSmfgkChOQLUetdOw/nCv+yAEMMdF/yAt72l
         nbGePWgeSbzdSSJ73Tzz3OLZI6XNbwMTGXR3z1MS7fsYPovCgfPmWNEEMT+rLdNj4jka
         nSM9POwdiNaevK3qiVHALU/FMsMJp0DZDd1djusC8vM6xwqAxuv8tdhQlZos6iyRmcmR
         khjwT6uqvm8ksWtd48NQgRuUgQ7hB385GI/WvWTmhLhkE0jaSfHTGZuz12vachSrsbqc
         mOoALSkyeROFmJYsRk9Zmm8IEwf9NCxWzEg5QbezZ1ZiuWPR7A8J5j9jdyqKs5kd/TPn
         oO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319376; x=1709924176;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3PxAWhsu0Wk1JCVDmtXtAqqbWoqISlhy4eOUAXnDEI=;
        b=sr5EYUsnnOMN1hysx1ThipjRh41wuKn+Irs/A3LFj4xgxIdUSPq/fOwQspkIjr313e
         ikYvu9F+4T6BK9DOlFtTdYcEPXtO/pGvBvuZkWNwIIFwKoaqz4P6tc+IBGW2zij45eUW
         HCcgEO6cwKEBfXFIvAujs5bqqH/NRtX++1ad20eDQUPzhgpOIONOgG3wTpiDz6trxkCc
         2HDwLxilu4MNwqO8TqdI7CGbPA9kWYmYVGPDkzg8mX1Lxa+ClNlsKbWeMh7etkQ0KkPE
         gzLvN9U5opVNgxyCiAxIlFVFvQKv9lSDh1PihO8CFqEH1AVE3ts9oMgG/NoTZ+PkZhv7
         //Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXboPYJAVSZKc8X5jFa+uW6/IKkad1wnEVYBdRNe8PN0wta4xf9zexwWSR72SiJJxqhMP8Z8Euz9+ItUZYSqOwHjGODKzSWSkXnf4O8
X-Gm-Message-State: AOJu0YyNMwFbhns4oId1DByGz99S7YnIDD0JbFbsTj/rSXa6+mTFuhwA
	feSqnDbULM0b5eBTS/KkdXRFndPbmHxla38Mt9SqEjBRGBkbPFPJH4QMtNPBOBnBngY/cNqppJB
	bcE/3Gg==
X-Google-Smtp-Source: AGHT+IES9Y1Xr3gfHjAX5zvXMI5CI2HyGaPo5BkbPzzc8IGg72mN9khRsEKwQw260K0Ns0HNNtDGlAvCLrsN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:724:b0:dcc:5a91:aee9 with SMTP id
 l4-20020a056902072400b00dcc5a91aee9mr537791ybt.7.1709319375833; Fri, 01 Mar
 2024 10:56:15 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:40 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 01/20] perf jevents: Add RAPL metrics for all Intel models
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

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 45 ++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 4fbb31c9eccd..7704c170a7db 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,9 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 import argparse
 import json
+import math
 import os
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
@@ -14,7 +15,45 @@ args = parser.parse_args()
 directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
 LoadEvents(directory)
 
-all_metrics = MetricGroup("",[])
+interval_sec = Event("duration_time")
+
+def Rapl() -> MetricGroup:
+  """Processor power consumption estimate.
+
+  Use events from the running average power limit (RAPL) driver.
+  """
+  # Watts = joules/second
+  pkg = Event("power/energy\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  cores = Event("power/energy\-cores/")
+  cond_cores = Select(cores, has_event(cores), math.nan)
+  ram = Event("power/energy\-ram/")
+  cond_ram = Select(ram, has_event(ram), math.nan)
+  gpu = Event("power/energy\-gpu/")
+  cond_gpu = Select(gpu, has_event(gpu), math.nan)
+  psys = Event("power/energy\-psys/")
+  cond_psys = Select(psys, has_event(psys), math.nan)
+  scale = 2.3283064365386962890625e-10
+  metrics = [
+      Metric("cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+      Metric("cpu_power_cores", "",
+             d_ratio(cond_cores * scale, interval_sec), "Watts"),
+      Metric("cpu_power_ram", "",
+             d_ratio(cond_ram * scale, interval_sec), "Watts"),
+      Metric("cpu_power_gpu", "",
+             d_ratio(cond_gpu * scale, interval_sec), "Watts"),
+      Metric("cpu_power_psys", "",
+             d_ratio(cond_psys * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("cpu_power", metrics,
+                     description="Running Average Power Limit (RAPL) power consumption estimates")
+
+
+all_metrics = MetricGroup("", [
+    Rapl(),
+])
 
 if args.metricgroups:
   print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.44.0.278.ge034bb2e1d-goog


