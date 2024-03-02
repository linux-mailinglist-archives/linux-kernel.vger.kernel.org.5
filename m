Return-Path: <linux-kernel+bounces-89286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F06D86EDBD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B891F23E46
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C8182C7;
	Sat,  2 Mar 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQ/82Ny+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12B17C70
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341229; cv=none; b=OpYVKyM85WhkEi8fH8R/c2Ut+WGjb206w9cXnsCG7nk+Gy8iSdMSMdpzQKOdm8IXjD6erbHh0Jb8lRmzGNon37pmTF4rsTnxy62II71uYev5nDxv8M4skVPybz50hwZYnWUvmlUySP/FvTck2Btai0rqfrG22CNMcBWqGR9Vk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341229; c=relaxed/simple;
	bh=v3K5piv8aZamXDtQ+9SunlvVej87nRnO4NjntMDRkno=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oUgPdRSgIez1JIBGlbkXFBipOixsS7ZfozdP1LsZxsJvR8GHi1Cgvlp0SdtQ/IdqWkrSx4fdpDByTORO4sX89+7Z5+4qnNtU5pJKc/HH6JWIldB2x8MzAhLwZo39vYM4y1aTGGjJ9wNrcABPrsjdB1UAgl8bxmcTHYnOQIfPD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQ/82Ny+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso47128357b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341227; x=1709946027; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cp2KMY/NOxQl4V1qbGfl9TN4FcOPFLbnLz8O/u+Jtg=;
        b=EQ/82Ny+LYJWppUEIvicfKy55HUOFjptkX9MYvlUivTxdbOwkiAwJiTdrivK559sdG
         1mCddcxwFWUGEuJI8JLpd7KRmUfyl393jdOSelmaQmnflXVTW5daQutiufhAb1XDHF5A
         G5WIpgGYcDic8J0igUQipyd2mRlDqiUXBSP/JeopqYB6tNbwW3Ryi3vIP+NDICxOa0bt
         NKVEJK3tIvE+zTB3FB16HySj4QqxhcWM2nVptpKqn1fnXcs5zyHlUSHJMaMbVwOqFqsh
         Y60B8H4UIhQAV2xx/rH2jxNo+MPBbCSJXAHfGr9ZjC6e7qjcPDyUOxBxb0QeyQ02BRs0
         GC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341227; x=1709946027;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cp2KMY/NOxQl4V1qbGfl9TN4FcOPFLbnLz8O/u+Jtg=;
        b=NZa7W7RrwwrJHlsabE1H0X/epfcOkxxpswrLxk4c14KVxV+7WUlg2sRvVdjzpUX2DU
         AcIO/5CHgFGMA4ZwI5ayYLUqmWxnIIWBEEPwdo39mMx4Q5/NZWICH/tfZ3pfD5iyIUQn
         3xDyyRUUCh4W/xf5IJXOPDoThVvU4fdEdQKQvDn5dsU4mmEU2qUP2nX8BZc+Ws24YJwU
         6fLv2gwoqjKmNHYkl+zx/2fuyft+6rYZIhmvbu7V06a25LujYFaS0z62K9Sjrml1UFYN
         yXWxwryBpOj2JTF3J1wXJpbJUNBoyMlWDT25uEqAVGtPCkkAy5GtQ683WpzBSEfoCDnV
         L2+w==
X-Forwarded-Encrypted: i=1; AJvYcCW4WZEez9dCAae8U59xJp1CbuXkijpu3SPlB/XsEPyJUpLvXRh2G3nklk6l5/9j6WC8rNpqsQyOkVQ9ctUnF17SvUoeKW2RLq/aD6la
X-Gm-Message-State: AOJu0YyUniS7VrqCX2pFHfuv7ALYjlVR63S07lJOa+aL6HnqPZ3+PVRF
	bcgF4DW5cMeMZ76NcJx7EP/BbnASAZRvJ/HkiSC8+g9+TtxePzpGjvpQigCIZUvcgjOTDuPkzhA
	6/qGLKw==
X-Google-Smtp-Source: AGHT+IHqEZPKLEGhXqKB4fZsSseViwdZxVHRhpfRd5c/+1rZdmAPz/TIf/cxGN1QT8fp+aOVBVvLG0M1aKyX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:690c:c86:b0:608:ed2f:e8f1 with SMTP id
 cm6-20020a05690c0c8600b00608ed2fe8f1mr626514ywb.8.1709341227083; Fri, 01 Mar
 2024 17:00:27 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:50 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 12/12] perf jevents: Add load event json to verify and
 allow fallbacks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a LoadEvents function that loads all event json files in a
directory. In the Event constructor ensure all events are defined in
the event json except for legacy events like "cycles". If the initial
event isn't found then legacy_event1 is used, and if that isn't found
legacy_event2 is used. This allows a single Event to have multiple
event names as models will often rename the same event over time. If
the event doesn't exist an exception is raised.

So that references to metrics can be added, add the MetricRef
class. This doesn't validate as an event name and so provides an
escape hatch for metrics to refer to each other.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py   |  7 ++-
 tools/perf/pmu-events/arm64_metrics.py |  7 ++-
 tools/perf/pmu-events/intel_metrics.py |  7 ++-
 tools/perf/pmu-events/metric.py        | 77 +++++++++++++++++++++++++-
 4 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index cb850ab1ed13..227f9b98c016 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,14 +1,19 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="AMD perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
 parser.add_argument("model", help="e.g. amdzen[123]")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index a54fa8aae2fa..7cd0ebc0bd80 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,8 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="ARM perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
@@ -10,6 +12,9 @@ parser.add_argument("vendor", help="e.g. arm")
 parser.add_argument("model", help="e.g. neoverse-n1")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/arm64/{args.vendor}/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 8b67b9613ab5..4fbb31c9eccd 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,14 +1,19 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
 parser.add_argument("model", help="e.g. skylakex")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index dd8fd06940e6..03312cd6d491 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -3,10 +3,50 @@
 import ast
 import decimal
 import json
+import os
 import re
 from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+all_events = set()
+
+def LoadEvents(directory: str) -> None:
+  """Populate a global set of all known events for the purpose of validating Event names"""
+  global all_events
+  all_events = {
+      "context\-switches",
+      "cycles",
+      "duration_time",
+      "instructions",
+      "l2_itlb_misses",
+  }
+  for file in os.listdir(os.fsencode(directory)):
+    filename = os.fsdecode(file)
+    if filename.endswith(".json"):
+      for x in json.load(open(f"{directory}/{filename}")):
+        if "EventName" in x:
+          all_events.add(x["EventName"])
+        elif "ArchStdEvent" in x:
+          all_events.add(x["ArchStdEvent"])
+
+
+def CheckEvent(name: str) -> bool:
+  """Check the event name exists in the set of all loaded events"""
+  global all_events
+  if len(all_events) == 0:
+    # No events loaded so assume any event is good.
+    return True
+
+  if ':' in name:
+    # Remove trailing modifier.
+    name = name[:name.find(':')]
+  elif '/' in name:
+    # Name could begin with a PMU or an event, for now assume it is good.
+    return True
+
+  return name in all_events
+
+
 class MetricConstraint(Enum):
   GROUPED_EVENTS = 0
   NO_GROUP_EVENTS = 1
@@ -317,9 +357,18 @@ def _FixEscapes(s: str) -> str:
 class Event(Expression):
   """An event in an expression."""
 
-  def __init__(self, name: str, legacy_name: str = ''):
-    self.name = _FixEscapes(name)
-    self.legacy_name = _FixEscapes(legacy_name)
+  def __init__(self, *args: str):
+    error = ""
+    for name in args:
+      if CheckEvent(name):
+        self.name = _FixEscapes(name)
+        return
+      if error:
+        error += " or " + name
+      else:
+        error = name
+    global all_events
+    raise Exception(f"No event {error} in:\n{all_events}")
 
   def ToPerfJson(self):
     result = re.sub('/', '@', self.name)
@@ -338,6 +387,28 @@ class Event(Expression):
     return self
 
 
+class MetricRef(Expression):
+  """A metric reference in an expression."""
+
+  def __init__(self, name: str):
+    self.name = _FixEscapes(name)
+
+  def ToPerfJson(self):
+    return self.name
+
+  def ToPython(self):
+    return f'MetricRef(r"{self.name}")'
+
+  def Simplify(self) -> Expression:
+    return self
+
+  def Equals(self, other: Expression) -> bool:
+    return isinstance(other, MetricRef) and self.name == other.name
+
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
+
 class Constant(Expression):
   """A constant within the expression tree."""
 
-- 
2.44.0.278.ge034bb2e1d-goog


