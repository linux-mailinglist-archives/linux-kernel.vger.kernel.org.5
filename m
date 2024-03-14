Return-Path: <linux-kernel+bounces-102837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F687B7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887601F2463D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2E36AE3;
	Thu, 14 Mar 2024 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uw6UsQ1u"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325A2942F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395984; cv=none; b=L05WDBkb8PJPeo4pNO4pkRX2lsvlVygdLyIGgVMBTJX/JZzyjebQ13J+UJvNpGtxU2Fezl9vdCvvh2YK9DEEwhEpZdGUVSvMPG+RP08r8CNYg+u9omXxgoRar12PtEjfG/52U/6o28AY0B+bJ9GCQA70KW4W/oDurPvtiNi5gLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395984; c=relaxed/simple;
	bh=OQajBVIwbLXlXH3seDBeY4/yU1jC4uwbycQvos7p61U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uLBmmVYvkrnc92E1EneW3+eZ5WcoLpzbO9zDpTxE3QmmUMJxg2l07poF7TQyNUF88HlqllgF47sDubjt0LjfaxM7ZQxYWqRVAPmd0zK29mVjvQ1f38kOIdACd6I0xUsrp6PbXPs6Q54KWXg53ZU3ftuhLkvE46qmGkJaqwAf0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uw6UsQ1u; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so881513276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395981; x=1711000781; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dca7nBv5ffv1LpnnFFef+qmnX+jAjEuRfkSwVUElMaM=;
        b=uw6UsQ1u3QZk7Hq7vCjk4/cH2uTRyW57TWrydB7WaSl2OfYNtt2ftiWLUYN9JsI0vF
         f2vbh8b8LnJZznzBkEjSrVz5cn90y1VQcpmKhJLDqMfHZ1684PjgW2WWwjN/lvE9qUX+
         8YWgbm0Scij/la1XkDRjvBP1/Ess8hPt4FLlFD41mPApBzNEIo0NLWR71N7qJBfLMF6F
         pXaPAiG7U8ZhpXs8BfodAqQ1zg1nntrP3HRwqGfEs2KA8FYAXFfVa0M/KtiLkhp1QGqb
         TIWj7AD1FFoNulzupwqWST7jB4rY/DAY9PDBPnSnR9sZrGP9bH3tCB8ty9U0rUrw55yo
         Qb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395981; x=1711000781;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dca7nBv5ffv1LpnnFFef+qmnX+jAjEuRfkSwVUElMaM=;
        b=uK5gmRgqGxBomsCyrUP4L+lcfOWTFS28wxFBZP9x1h3XePKttogGeiQHO4LsT8j5xl
         5cTWtzWSuF0XBY8doROcbYM3orTwrJ4DxHqdWv6KCR/nVHv2sp9NAcsNrIdzQ9hyr0i5
         0ZPdPn/SxhJmawA6HxmxNmVK4flAb0Do1wzDGsG3sseooDRVTMrB3hx2OAzZXI5JMswF
         dglc9r+pPGivtJgoPsYCboliV46ng+rggw7YlKDli/oGjA3yrBpn99MO3dSFv6FUDIhe
         IFbNuDpjjNRjPUaa5LGBO6Am7j2z4gZzavEGO4joj5AQy36u3vcw2/o+HgpKhHOMd3DB
         mMiA==
X-Forwarded-Encrypted: i=1; AJvYcCUwp+JZ0KxGeQ5iWf0fPcbsSNKE8rOB8ynvIuyNVYMwvZSRYNK1H8Xq2B2M8Al0o6a/uimMZ6KVMFEvkaqbrC3ui2xIS8sAW3XGCmXA
X-Gm-Message-State: AOJu0YwLB+MNfYLRixrGOIwtcutHnFEQss66bP5z84lJ/hN8pLZbpTrG
	ITQlHN9/36kYZC89ZEqLtohVcSvyzOhd1mWZh9H9QrJPibp6C+Hbv8cKOQgr03DvTDRVZO7jP3q
	DcBAtvg==
X-Google-Smtp-Source: AGHT+IE3q0P9tUDVg+d0BLMp1b5jR1m3PPrykyADgJLMI9+R/WuDbjv//oDHpHvz4iACeyIpNNOo/27VzaDB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:220e:b0:dcb:bc80:8333 with SMTP
 id dm14-20020a056902220e00b00dcbbc808333mr212170ybb.13.1710395981118; Wed, 13
 Mar 2024 22:59:41 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:01 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 02/20] perf jevents: Add idle metric for Intel models
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
index 58e23eb48312..f875eb844c78 100755
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
@@ -11,6 +12,16 @@ import os
 _args = None
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
 
@@ -68,6 +79,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


