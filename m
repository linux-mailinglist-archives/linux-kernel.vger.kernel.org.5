Return-Path: <linux-kernel+bounces-89276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D2A86EDB2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33835286C94
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799E79F0;
	Sat,  2 Mar 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFk8W1dH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B25CA1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341205; cv=none; b=MjSeVe2uHrCmOok3zwfMP8tkOue8Q1x4y2DLCOwANhpZARmrdC2cYyeioqV6uaodKE7nOkowPoMWsEESV1IIupBIhDQLYDKhXSyt62AI2wTwPDlZXV6v3rnGPtE6ITRR+ptej4wOePU4ffTQ9rMe+JhH/dy6GpAdFd4j9Z9tDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341205; c=relaxed/simple;
	bh=hLfRLYYEBDGHVllbq1W2MRKFt2uEVseZ3ckqP7HQcJs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CIgsCuCFekDqrEB4qp4fXEDQ15wc+pBDqFD6nSrqQE6U7LRjKJIoIVQnkapd03y7rRwbYNUEclBoQFlkFdSSXTt4PjKc/YBui2W0RYKDbEvba1ZQwZyXUvSOTEZB+bAt8bWWM1hcAbbDf2mKx9wvVzsKd5xRWboiGBEGRaQI/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFk8W1dH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so5227213276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341203; x=1709946003; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=AFk8W1dHLucI1lzV9klBxz+8G+cQ/sXQjH2CxBpRsZQwpR38Ri68XuEv5uSefbaDDv
         9PusemxFaGn+WxpkCXDjwhcrLlrA7+lXHeOJLdsLFWohYIJo2Ao1mbK6YztCF8NeuR1P
         9wibUWh2mP6xD94pZ8fVzbhpG+bBkgCEudKC3epFPaAXvOtYAYUBt+Jr6Dn5/Uz3WNPg
         ESSkDfNL4qPCNvJPZPwPFBFW/A2HAznQvxis7ROGx2CAcREa2h8pPMZEMcKaN6qK6S8N
         DegiEgPqYqmzNZOMuldmg3Ci2iNzN6QcsRleOYlKEuGM3/Yy97nKFR7NWXP5YIqppC2u
         EzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341203; x=1709946003;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=gld+wDFPDGfVEQ3fPcp4SxKSKujrMtIAnf1+S3utd4NufjUEdS00kYXzMB5nS12ezp
         xzjDqzo/4osYJlj1jKpBszHJ4wAPF+V79eukRZpDiYCoE8NmvovDeuukrk4oe0kE4xRP
         j4OSARCwSDsN6BqSy/gojVZJHgIuMqf2Fdb+tx9QnsrOVGe3uJEnNe1Uvs9ly/inoSBi
         UHSn3B0uSdSqwzRXPTVKXCC0TppyBtwc7QaCgs2gwvdZiiekOAlJ1p35zIAp8cx0EBFu
         HpW+uahT57UAdQbkeACyXOztAyxYqUQyjVbQsulWAGtB3uGGjEka4d6bG/lYA6MY6PdW
         +pgw==
X-Forwarded-Encrypted: i=1; AJvYcCX8jNnTt7zz8LFTblqn7BeDEbRsseN20e6g9BFTqOXCUSV01fUYgzBWfAZ3DNRSBQ0P3nCz9GPDGqCJuznGp8dkSZODiUw8VqGyBhUm
X-Gm-Message-State: AOJu0YyR+56u/dJpQflA47iJicFW9Uy8md9ddrsC/5SgiAAj5/W/lHhX
	lajYZJpSwEqrEBIEB4aVPvkwAMY05PxI/JOEgbFymtySMbVY+5p+CngWaltSPfY6ZZDEerWheyx
	TnZZLTA==
X-Google-Smtp-Source: AGHT+IELbTz3gewzuBUQeWefqRwNUhsFbXWyJjPH4NG6Rd6XYYHISDWKcqTJ9Xd+wlGNJZUgpVUuazYRvO5P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dc7:5aad:8965 with SMTP
 id w10-20020a056902100a00b00dc75aad8965mr766000ybt.0.1709341202870; Fri, 01
 Mar 2024 17:00:02 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:40 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 02/12] perf jevents: Update metric constraint support
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

Previous metric constraints were binary, either none or don't group
when the NMI watchdog is present. Update to match the definitions in
'enum metric_event_groups' in pmu-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 92acd89ed97a..8a718dd4b1fe 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -4,8 +4,14 @@ import ast
 import decimal
 import json
 import re
+from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+class MetricConstraint(Enum):
+  GROUPED_EVENTS = 0
+  NO_GROUP_EVENTS = 1
+  NO_GROUP_EVENTS_NMI = 2
+  NO_GROUP_EVENTS_SMT = 3
 
 class Expression:
   """Abstract base class of elements in a metric expression."""
@@ -423,14 +429,14 @@ class Metric:
   groups: Set[str]
   expr: Expression
   scale_unit: str
-  constraint: bool
+  constraint: MetricConstraint
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: bool = False):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -464,8 +470,8 @@ class Metric:
         'MetricExpr': self.expr.ToPerfJson(),
         'ScaleUnit': self.scale_unit
     }
-    if self.constraint:
-      result['MetricConstraint'] = 'NO_NMI_WATCHDOG'
+    if self.constraint != MetricConstraint.GROUPED_EVENTS:
+      result['MetricConstraint'] = self.constraint.name
 
     return result
 
-- 
2.44.0.278.ge034bb2e1d-goog


