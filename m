Return-Path: <linux-kernel+bounces-102836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E5B87B7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264E01C20C61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9429CED;
	Thu, 14 Mar 2024 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMQKKVpm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72113FFC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395981; cv=none; b=sgwCSSRBqRl8ADYKSP6y+h7kgsuCWZagXKlgOIv5b8RfHCq1DT9ueCEiepDQe7HOdjJGSxnw9POIkn3fi7cZyXMmPqgHc/OVfepMiBUHoyYx3djEZNAKuKpygwr8QFZ5tOedq695xhNzKYO6O3XiVu09oQDk6KP1ipoKb2HG/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395981; c=relaxed/simple;
	bh=RoaV1PGHpB7iF+mzzYLJ0/v6xXT6l3SZAuzH3D8tIYE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=J2NVYUmWGYWgvAHa366atl5imkjjdW/nKmBKQBw5Ywxax4XqAMTsHh+Qf2EcQGyau6/iklUr4w2U6LeVB10mpK32OMK330okMq6VD0oDBCqdnWJ2vvwIOMH5UkBF9H6RAdq06iHDgxLlTsntg4rr93aF1vLOcGzvAkhDNfERv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMQKKVpm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0a5bf550so12016977b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395979; x=1711000779; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpyhD4Js3wJeDTz3uN0UEDz2T8BCDX/cFh8ndCI6xOc=;
        b=eMQKKVpmarxTCEqfJ5/+YdsflY/IyFOviGs99c2eH4IB8SDWOboxbZpunqMwZnpseF
         CO9ARn1xaKLftS8zAJKWoyssx6NZdpTa0WaZOz8vAcUuStsbCPnmLDI18bf9DB7Gc5bI
         SOimIugGT8lDELYYX0TCYfCoWEw+BY+KzA4PTysL1o4oklUbimKeEtWaQasdM1u+0/qc
         i4XMTzEmWz3vMtt8hbmR2VMA6Y7MOoRUfDfeRKVLkP6H+TpIM8Es+kTE6eNpVPwQLSdd
         eZ+4fmjqTRbdObNfS8nyIZAyoZQaZAXSJ2U/G1HP3HgJoOFYUmIQ47A4ssh7TVc/vKaG
         wung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395979; x=1711000779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpyhD4Js3wJeDTz3uN0UEDz2T8BCDX/cFh8ndCI6xOc=;
        b=K90kT6PSXzI4QJfUcvm73c9K3LZYuzDpkzbM3d+nx8zNER6462ven6J1NVtpvrcqRf
         5iTa0EmZYf/nJ9e2pxJIwnQyqhRCR60XZ47xJ3MEFwckNpto4IGIyvDkDVU6xzhMeWpI
         xtND50pOJbqQo0LfHTZCdWNdrpk6b4XECdQRPrNg8EaJ24pT3fGM3uJu18tU+DWUZhKw
         5IBoQeIlv0i0kegI7ViPJqGgrt2OJhKbBfqBsi62QRYIuqg5DV3k3NIhtlxvIofC0ZuL
         0FVxjxHiNto1UZCWTi/K0nNe839GSMfG/wnL3ayFKba2ui10ldtA6lRv0H4W/ICjLVcu
         MsBA==
X-Forwarded-Encrypted: i=1; AJvYcCUaOsyoDRc25giPY29Vyizewr1KkMjB7XuZzjrfuLBBVxhn9Xebu4qbdvNy5dZelFJa6S5OjR0kh5MwsdUPS1gg/QMmD9jpnBn4kJF3
X-Gm-Message-State: AOJu0YyZioqPyHMFYjc4I7Fd1xlhbe4KnQCgta7j5+IMo59DZXOrYXnO
	UmcxNR65pLnW9xHcp4qsnChqMQvSnY9bTQy3X2ffPJXdkMsLYgjVEYDl/UsGyfZPYidl9Dmz1kg
	RmM8g/g==
X-Google-Smtp-Source: AGHT+IG1J4Jc5hyWHjED6a03IGV2XHl621GM4AHi1LarrkTaUZeYHjyI667L69+bKaCy3v7R4rM9qXfHQnlj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:690c:a15:b0:60c:ca8a:4c10 with SMTP id
 cg21-20020a05690c0a1500b0060cca8a4c10mr172343ywb.2.1710395978939; Wed, 13 Mar
 2024 22:59:38 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:00 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 01/20] perf jevents: Add RAPL metrics for all Intel models
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
index 04a19d05c6c1..58e23eb48312 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,13 +1,49 @@
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
 
 # Global command line arguments.
 _args = None
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
 
 def main() -> None:
   global _args
@@ -31,7 +67,10 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
-  all_metrics = MetricGroup("",[])
+  all_metrics = MetricGroup("", [
+      Rapl(),
+  ])
+
 
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.44.0.278.ge034bb2e1d-goog


