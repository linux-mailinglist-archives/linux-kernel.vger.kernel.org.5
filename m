Return-Path: <linux-kernel+bounces-102802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08887B76F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8FD284E18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6E10A09;
	Thu, 14 Mar 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/br7fOA"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F3FC0B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395487; cv=none; b=njh6ctSLOxvB6q+I4nl5whRpqJmtgnAGS8f4holT5jQqFNPYi5Wf4zhkkGP90uDYHDOC4cYRVGV6yjTmUYLDaTCJ+bbL4fjdV/9O7x1WjCBaY31Je54PLNg/UDSrtmt5KPw2Ij4VTfRyQy602J+2zh3kKJGgfVcswszaKvTb13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395487; c=relaxed/simple;
	bh=GN4Y68feIoyK84NORTnkVtG7K1dAvlvEPxB9mo8klN0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y3WHJHN/RCudL7liGaOnOPFP6CN/CyBEsLE3SsCRdVni56ZQQqj+sybc942SmNtDxO2sXICwK+S4m/lJ58TOfhbHbJiEZpZN2Qng31rwJZshjNgwqP5ohrIYH6emg9ZkwBWYnraZJ5CG1NKizYE473qQGZYQUnsxYxuHv6F6q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/br7fOA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so888708276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395484; x=1711000284; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=r/br7fOAkQIniuUdpruKaK5brvGPEbh6x+MG5zdOSLmXtIVUPRF0BKma8RoHivK1d8
         iyIVQbLynDywRHyG+4g8BTqFCiyl3XQICcTBfUAhYF5Qf976302JG4h5zuXlEDxJymMv
         WnhA/moikRgEGQWCFMeNpHWN1OOJYdFffYZgqxL2fFzItdx3LWJ6cr4z7pGUAcjvRWqL
         NDLb/VhnKD+7Go+9hmaxbdjkJ/hNZsd+ZbcBbUCCjbzOrl1jrqSx0WGRDisaMZ9dEb/S
         IllSSBkM1eHRspfZOc3G/LCaUvzhqh9symfoACOEQyz19tVbIExxsWeue1JM2XJTBlO0
         4+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395484; x=1711000284;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=otFidQkDwjdnjY4F8+yGVzOB8rVwDD15fMlXmk90lZEYqS+hPq5JbwStodKg8VFzTa
         Rzp97OBqpMNVduuzLVt3Dp0jZWCFmI7ZOdoPWhrEIPVCC1gh54TlQOSt+lELa64hG8xe
         ib/LAm0b5xZLAsm49tnQZVkeohzThxKkYBRfmhsA4PkkiXIF+vd4BZEvd1dufacVvRNR
         EYg/51v/wMGbvS4yo39LZxGxLIrOCJkpmqGgC639QZi3JbP4AgOQ5mC77ouQynzlIXuy
         Htt6YsjhCBda6NGsS1I5B2M6QzKjryIAlPhgLdFlaAFrzUuhIa2WwosICdG6utzGhus8
         5Iug==
X-Forwarded-Encrypted: i=1; AJvYcCVC9kBBtVbIlhCBBZ446K9vTk2Td0PukxyEGs9lTRoCNk60u4gt+eTidYgDg3kzVL5ZG6y20/HIJRGNYkOrOaDe28kJ8muP/t3L4cFT
X-Gm-Message-State: AOJu0YxuMIrYb/1kxomdKhrg0y6WFlShEPcu1hOrEbgg4Otm/jyI/D5p
	Xf68XXmh2v+Hc2X0qIh3z5gdrBT48MknIhTYFCTKDm16F5qhH+XsWOJmHa2K7YHzjBSqqcTCNIa
	EtWMCmA==
X-Google-Smtp-Source: AGHT+IEefVp2QC5OaHOxVr60zApScmAZ36NzCqADLg2CL6GAfBmQEcSr+9+qOERum4cvJPHr1mGvB2mN3KA+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2206:b0:dc6:207e:e8b1 with SMTP
 id dm6-20020a056902220600b00dc6207ee8b1mr252265ybb.2.1710395483764; Wed, 13
 Mar 2024 22:51:23 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:42 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 03/12] perf jevents: Add descriptions to metricgroup abstraction
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

Add a function to recursively generate metric group descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8a718dd4b1fe..1de4fb72c75e 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -475,6 +475,8 @@ class Metric:
 
     return result
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    return {}
 
 class _MetricJsonEncoder(json.JSONEncoder):
   """Special handling for Metric objects."""
@@ -493,10 +495,12 @@ class MetricGroup:
   which can facilitate arrangements similar to trees.
   """
 
-  def __init__(self, name: str, metric_list: List[Union[Metric,
-                                                        'MetricGroup']]):
+  def __init__(self, name: str,
+               metric_list: List[Union[Metric, 'MetricGroup']],
+               description: Optional[str] = None):
     self.name = name
     self.metric_list = metric_list
+    self.description = description
     for metric in metric_list:
       metric.AddToMetricGroup(self)
 
@@ -516,6 +520,12 @@ class MetricGroup:
   def ToPerfJson(self) -> str:
     return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    result = {self.name: self.description} if self.description else {}
+    for x in self.metric_list:
+      result.update(x.ToMetricGroupDescriptions(False))
+    return result
+
   def __str__(self) -> str:
     return self.ToPerfJson()
 
-- 
2.44.0.278.ge034bb2e1d-goog


