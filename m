Return-Path: <linux-kernel+bounces-102839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F887B7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB131C220DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EA4376E6;
	Thu, 14 Mar 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pStV3YOV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2214A8E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395985; cv=none; b=h1XuNCRwwLdIqhAS62NELwyKg5LuqzKfClcn7Ae6wEiwRJDdcTNwf4O9XkvgOlpKTKbN94cKkU+VhRsElarsepTWbb/LeKi9zwO0U+cPcMe/RHUwK1QhtCvIv3digvht/lS+iAuPaS4ONqsVzRmCaUUoRkyQBIwzDlAi3LBPGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395985; c=relaxed/simple;
	bh=cCSe3xBYHq317mfPy7MagbKNpW1UoVS0ABuezkShy9Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XLIecPJoEiM6inUFz0zxheu3GMsxSHUu2wukcjXeG2ZR9se6XyWegW5+7VuftaTzw9VTFIu2qrzFi+pIRDbfQlozeXJxeVrIBNLqWZOUp2sG9q+kgCJxxUVfv8ck4xeM/qyUV01yvJxBFI7CIyz+8zih4Twc/h08jS2P7JxhwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pStV3YOV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so895917276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395983; x=1711000783; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+veiSuaqo+0WmGFGd8SW73u7DHqxbnCf8x6yupKtD1s=;
        b=pStV3YOVX8Jcbj3uaMoU5XRlXBHKihx9wOOx6KtDZgAYLOehiP8IPJG+GmxDAXKgbb
         Q6I/Dpp74X4KvDnin9qHeKZMRDhwdmgWMY6dXxZ6D/zZiNJjckk1CUA/AKCezp1bWrA5
         4yWBrasyqV9j9a+rlHVO9cuHT5HiGXOGXUjZ9rORXUjsXPMOVTukmg2HITF9TanZ8LYt
         jhVWfJtvLujFx/9TM/FcJ3UfQcv32d798xFTHFc5/tj18XoXMDfFrupb6NL6mwRvk5fn
         /xsUvfNuAAACgGvxWtstZivRgxtHagb8EPwPUq+NQM2bIZpfl2hBrhBxWu48XQUQU7/v
         VSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395983; x=1711000783;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+veiSuaqo+0WmGFGd8SW73u7DHqxbnCf8x6yupKtD1s=;
        b=V96b1JNfW7+OijF6ta7if3LRuabeDZwkpKmTO+8xwuziS/w2cUqIzWSwatskCW026Q
         Ple57JNhw3BUJBlXgS3/i4ydiT2QktNgPhPC4Yc9XSSkT8G+FpkG1uPDG/Dqaqsktu9D
         WHzmnjgqpZNuX5MgjYxZAeYue695YaM79OXaDRNnkACmY/ErYxFBvowRW/UYa0YU04gx
         U4/iFT7I9OvqrckurnZLfjsRttgjuu+CgYKaop4uUnTXCybqOgUvn7BvBoNJa3RQvlaC
         gYUPIv1CVWWeyF6rHnIH1qOtsu/q4omDj1JLjA/g8NSFVpqMkiGHHYes2CYZyImbnTl8
         VlZA==
X-Forwarded-Encrypted: i=1; AJvYcCX1pqLspplSqdiW/NMwNklldXEYEPoUMA0wqfOEHperFCWlbA/8t8VDb7uxYZrx6UHslVvp0JsNRTKmnl1gMoCn6yP/db+0wHcN7L/W
X-Gm-Message-State: AOJu0Yw3h9QqU9WgkNc5Sly3L873bM6AB9O1VpMzjtgohwq8Wpg+5/Yz
	Wk67HFsdE7wDQ//nhRro1D2cCC9pVZp33dKEU553SDlWbvnKN32WQhRsokqsioPw3ERoRhoT7Z/
	WMmImlw==
X-Google-Smtp-Source: AGHT+IEzFwG3kjeE10nJw0pr6EwNRZ5U8tke7krs3iomuop09QzxhoLt+T1Qb3x2zno97wzCFNTWUvdibRro
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2181:b0:dc7:49a9:6666 with SMTP
 id dl1-20020a056902218100b00dc749a96666mr255019ybb.3.1710395983180; Wed, 13
 Mar 2024 22:59:43 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:02 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 03/20] perf jevents: Add smi metric group for Intel models
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

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f875eb844c78..f34b4230a4ee 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -56,6 +56,24 @@ def Rapl() -> MetricGroup:
                      description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    aperf = Event('msr/aperf/')
+    cycles = Event('cycles')
+    smi_num = Event('msr/smi/')
+    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
+                        has_event(aperf),
+                        0)
+    return MetricGroup('smi', [
+        Metric('smi_num', 'Number of SMI interrupts.',
+               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
+        # Note, the smi_cycles "Event" is really a reference to the metric.
+        Metric('smi_cycles',
+               'Percentage of cycles spent in System Management Interrupts. '
+               'Requires /sys/devices/cpu/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description = 'System Management Interrupt metrics')
+
+
 def main() -> None:
   global _args
 
@@ -81,6 +99,7 @@ def main() -> None:
   all_metrics = MetricGroup("", [
       Idle(),
       Rapl(),
+      Smi(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog


