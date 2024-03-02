Return-Path: <linux-kernel+bounces-89277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD6886EDB3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E51C21676
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6CB107B4;
	Sat,  2 Mar 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqMq4sXT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BC79F6
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341207; cv=none; b=sFoftPHEolxbaFZGIcAMIAXFrkgQbmiEMsAlvFmriD7Byux6FhtWSR9Qxtxw7HdPOh8XOGsWM9WqaLLd+3tCerl1DxDUdNEcUTlPkj66Zl7GnkN34BrfZsRNkAVPetCDVmOTlk5tP31V//ml4M9ZmJYeRgwqx2pFxEWZLf4pb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341207; c=relaxed/simple;
	bh=GN4Y68feIoyK84NORTnkVtG7K1dAvlvEPxB9mo8klN0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WY/jtcctyEPAm7969p/rS8WGtoHZAhJJPY6xN6LL7+kqR+WOhA6R33ow8x37mWeXdqYXWgxObU4nmHPwVvlTzQdx4xvO6JUhSCFED3bJKn3YUqzT0XmFutqRo2p4DqsyEZ36zc3CwKjyz9EuSK5Bf1oljpQ9XVHU+9pjmSEuAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqMq4sXT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so4696377276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341205; x=1709946005; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=lqMq4sXTlul76pp7I2oLoCW6U/v5uVo6CEQD4cpCawLPRu5lJlYZuqybKp+AQmLDnD
         jzTwNCgCke0KYsGqOlh25zFNKJDWjSbE+IPa2t3LMXjAcm/EAvQiKM1ofM4WwJINFBMZ
         LOs6NvatFNkFFHYQS8GQQDbN6+9zPaNNt75s76eoiZHXLXrxxRI+PeQOolQ+JjaI3sRm
         E0yxTt4tcA1cUPliGxbNqOfv6GghntCHwSIDBRJj4QY5/jdiA7DA0V0PjxB0L5XBvFIe
         6pPdr6LweaA3CrTkxDUq6i/91bBTdJWEh6lYfVZN+WJaVBMjYScUUcUW6vGEwENrOm37
         zmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341205; x=1709946005;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=qw70wLIrDayENU0CYcE4PosFSO7PzGeqPmEmDTG3BKwKG8EARHFBPntS2iSfwsVkjB
         n1RZtNssxYmhQIAfSZ0hBWZEgSTP91ubIo6pvMbqvt3gmDCOy3WZl4RQbSrD5K14/yIH
         M/AnIreTPy5OoUaeYuP0NFhwis9PZOnAltxQ6WtgC7GMcq9J8rckH0dxqHY6WgYXAOZM
         1wAVtmIHnYJTZaIJJy6ESdLH4eFMg72w6eHv5DWn3VNM59opC4Q8pAAJbkP1ldlYul9x
         9c3bzSjX2Pd1A/fGbLzeCtGFCOt5QBBLhqqkj0ft3wAik/Toua/J/EJCyIV5IVuA/6md
         pXYw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ueAror3Y2UuTzNPwUDpJcQ1aopBp7Y1u9n9kV11JojoxibCpe+7rzhQaS/P/rOX5dSOBsUcMoPIdtm+WOpIk5xTZ5uKxvBkfLBUL
X-Gm-Message-State: AOJu0YzjmyU0E1IlQ/QU1+/fxbsy+Vnjb6FFbqH+j3FtIHzApQh/HG0F
	ZDqTTolBj/62m5/KmYsB+8Sgr0uKEX6lxs0TepbZvCKRA8a3wmWXTXq6LmwS8MZ0wdrx2WLW8jq
	BMYSIRw==
X-Google-Smtp-Source: AGHT+IGSC9+3nntnvVn949Yfko6YHSUhQm4BDhRAsWEHmwZNprbyUHHVU/oK4rtjeaejLT8hBHSD9mJ2bpp4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP
 id w4-20020a056902100400b00dc23441897fmr721544ybt.6.1709341205149; Fri, 01
 Mar 2024 17:00:05 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:41 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 03/12] perf jevents: Add descriptions to metricgroup abstraction
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


