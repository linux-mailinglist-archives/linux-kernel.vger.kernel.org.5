Return-Path: <linux-kernel+bounces-85483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DC86B68A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D131F2380E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47671EA7;
	Wed, 28 Feb 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2+WVsMe"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349471EA2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143017; cv=none; b=XW5lhIK/umeI259fv/5iIGtv4DeE9aWXUTW0KnQgJ9Y0d9R6kWEdSVwwhxTQ3EphRcHHYULlPPHcsWtmPfV71ZcyfnKFrMnDISSvCP6Jec+Q0PRhG4Awanefcrz5o8C3urMAWSH/n8kVPA8bdEV2GrbHxDvA2WAKn6MkgT7NYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143017; c=relaxed/simple;
	bh=VTP7cncy4gwlJI397PHFOaaK/IbC9Og3Mfc2WSlODYE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Mgkivtnq8xxhDUnGwZ1A4SMgeJcEsK+KOZJehZ1FFoMCiyMMBZcW/JMXeB5LQw9sbYFHpHaYMcaNS6D0j1UctcfGdLwneryPI17vyocy2zjUoXsFfpqgXAiqoY4D62lcajkJTvrDk281kKbi/kBWptP0UUDWN6+VrXxVBFYqaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2+WVsMe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ab197437so407327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143015; x=1709747815; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cDzpg5+MKhLD8FCqutlzYcO5JjMHCNs7N0k1WxKxV0=;
        b=L2+WVsMeq0+UglGKtkx8YJb09gOIqw8hmNdlqL13kuIkGqRlNYqOoPwR+sGGxT4Lz1
         c9B9h3TREDhIo0WuA6OrSDkCnsrHOvYClye9meHzStkXIrrTUlmSylUsMKN23dJrJyFr
         l4F0WC2eFh49P6axqS1utz8oTjVTm4g6d9DpsIWxeyPStyMlKDP4O2pRCvA0YjdnowKY
         bahvwxVysqP4TNk2ytIO3dCIfwSuADEqLCUQwKWqX0Hb4yJzI/1YxyuZp5aDUY84nFPy
         U7gLdCf3GCw4bZsi6sQeeBEOFKGkfAP5qlLgS7axbDYenC11bNnRcnZEK3mKUhFuOtiM
         p8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143015; x=1709747815;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cDzpg5+MKhLD8FCqutlzYcO5JjMHCNs7N0k1WxKxV0=;
        b=E2WFHtRXwiz1sXdZyCdVtKmwRpuzcJHWDoE84QugqvS0ckmlzq9wC+9cODMuh1ZNOl
         U/CqbfNxJPGdHnw4hSNjVQTL4G945NgtptfVPkgkygY+hAlPDiFEuWYrJK92wsZpaTga
         WO807OGqZz68L2A0HyeLmH/w0RLzbJcq2LygRJCY/1vki6JMjoNGJFDapf4VZtVaKlqf
         gk+mHtSlVkzQMI/f/MeCNMoCUh6Cbku9rf1Z/423HAcCVl/+RA5J+gEOaY/HFieeNkER
         kY7Dw4rW08Cowa7oKzPmZ2LMom5RuVeG2SsZmM4wEaXa+svjqLO640/Qjd4LVk6nWzSe
         UpQg==
X-Forwarded-Encrypted: i=1; AJvYcCUB2evLgnKSBnE31mf6/apbydy4SvvIFIxVDU/HZLSanCWjmhhpLDgc/2hCYqMKm4rB2cHCKhubuqPDnR5UyB2BN882TS6oa9YIZ6un
X-Gm-Message-State: AOJu0YylZnjPZliU73xGDpapXw8u+BLwheUpt1rBSlMBf+yQpo10y4Lw
	wBmf0AorqG7MaPjz4E7IhQ/xn4UUX+qsMoQq3FmiUjZ2FQOb83IrteuHw4wRLUH/QncIYFul2QW
	ggsbUcw==
X-Google-Smtp-Source: AGHT+IH+u+lWaPqOD3wy6Jx6TWBgQds/O41pt+EPMt1C47UVMEnr4Ubr+FBxxcBFLLghfaDTPm5c2hLsE8wc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a0d:e654:0:b0:609:3c46:1889 with SMTP id
 p81-20020a0de654000000b006093c461889mr568853ywe.7.1709143015239; Wed, 28 Feb
 2024 09:56:55 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:13 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 08/12] perf jevents: Move json encoding to its own functions
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

Have dedicate encode functions rather than having them embedded in
MetricGroup. This is to provide some uniformity in the Metric ToXXX
routines.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 88022b7f08f4..8b37cef0256a 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -483,15 +483,6 @@ class Metric:
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     return {}
 
-class _MetricJsonEncoder(json.JSONEncoder):
-  """Special handling for Metric objects."""
-
-  def default(self, o):
-    if isinstance(o, Metric):
-      return o.ToPerfJson()
-    return json.JSONEncoder.default(self, o)
-
-
 class MetricGroup:
   """A group of metrics.
 
@@ -522,8 +513,8 @@ class MetricGroup:
 
     return result
 
-  def ToPerfJson(self) -> str:
-    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+  def ToPerfJson(self) -> List[Dict[str, str]]:
+    return sorted(self.Flatten())
 
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
@@ -535,6 +526,22 @@ class MetricGroup:
     return self.ToPerfJson()
 
 
+def JsonEncodeMetric(x: MetricGroup):
+  class MetricJsonEncoder(json.JSONEncoder):
+    """Special handling for Metric objects."""
+
+    def default(self, o):
+      if isinstance(o, Metric) or isinstance(o, MetricGroup):
+        return o.ToPerfJson()
+      return json.JSONEncoder.default(self, o)
+
+  return json.dumps(x, indent=2, cls=MetricJsonEncoder)
+
+
+def JsonEncodeMetricGroupDescriptions(x: MetricGroup):
+  return json.dumps(x.ToMetricGroupDescriptions(), indent=2)
+
+
 class _RewriteIfExpToSelect(ast.NodeTransformer):
   """Transformer to convert if-else nodes to Select expressions."""
 
-- 
2.44.0.278.ge034bb2e1d-goog


