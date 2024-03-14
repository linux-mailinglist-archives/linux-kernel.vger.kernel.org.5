Return-Path: <linux-kernel+bounces-102809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7855F87B777
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08300B21FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0017C9E;
	Thu, 14 Mar 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYyViSrD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CDB17C67
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395501; cv=none; b=B1r2a8f0qJcze+YghzMSqW2yRKP/XGNMnA59dbyc7gOk2EuTkli0oCGzHQrgP7TKVS/DIh0LArjDkuHvx2nBfpG3V4BLB1v0P0IpqOxPcQglEDy0U1fFAiyTccg61LB2WMUxhdq8P2vhBVqTEMz8a6MwuQDftGtGZ4Cd3m+FNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395501; c=relaxed/simple;
	bh=gNv29+h0IhWRsa2qydUVk3E45fI6zH8amlK1YqhsJZ8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=btOTKEViTDkVuV1+fS+FqReYGGlSvBTCalrqqgVj3vBmWK1zoNgfHpu4JgMIC6XecDTX66oNU7K65GzdgxZXBmMYTA178rzzbx1Tx1G6uKOOALFHu7axfTB5m7AEtHN6DABWxWirXRvPtbcMICGrjrGMfGUgnpjS8IUSqTuMIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYyViSrD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso842733276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395499; x=1711000299; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGG+6HzWesnJ1eAogyUwc6CZn4obQaKW0ElKvKW4EMk=;
        b=rYyViSrDpKKNMMGJ8bjP6bqb3Tbwe+tVJm2kn+qnbD49/uyfV53ltlm0UQFYRGsKTs
         bjLxNMyGNxf76f04v9vXg5nuM4hDNqiLAhiqf4w5vjZTXmWV8EZ244KqP/UutZsXWpw9
         7AA6C63KMiiSFuh7LKOOq2j1Wz0Y0nPMECuuOXXO8kNyeDIW/2qhkVpOnSNwohOAppFS
         MX+cDPPwNseaJsPlolq2W1AVedORiPDJzxt7BrRmmlkWe9AwciN/CH3EdmcwmKpRcbZv
         eCTZuhiR8EPPjduJ4j8bsVh4ejxS7v1leNSAvUlv6cd0AMGREbKkI8y96u+cbeCMbs8s
         W3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395499; x=1711000299;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGG+6HzWesnJ1eAogyUwc6CZn4obQaKW0ElKvKW4EMk=;
        b=MPh6dr3IXE962I4AJrMbFv+rmtLRcTaQXGX2pjXe0BBA71T54T2e6eyVyQLgib84FA
         V/EbXL6Abo1VeBzvUT1oHU74+laXfg8Bobxa4AwrNS9boUwr1nAvbvZ4dWMZwoGhngDy
         igbJRfAGF4PLxXeZKOmqdOidErWcp/57hqFKz3kf2C+eBP1P8NnAIwZOSGomgRKj+/Ds
         7TEBRT/vGuflAHhC2qaO6wK4zh8qjHDGYsind2IHnDSgq8Hn4HfFnscde+EJtX1d0Hxn
         q/APEVszjLZudqF9CppNIRivzvKhNj1UrXBgi3XD2R0j1csX+xAFHpicQvbjRlkUR1YY
         eQZA==
X-Forwarded-Encrypted: i=1; AJvYcCWxrdWmccAYJ5GEvtpzVas6KqtRZ8qTmzmIwde03mQ4P/lI+kd59ZlkDHrUtkGz6pzjZagsV66S/JKt15V0pG1QBoG0qjwdieT7/P63
X-Gm-Message-State: AOJu0YwXAlH+LKX1RCkhaFuD4/Wac18sEkO5ldN/j2kd3fks2vHsGZ3O
	zH6wIRss7fnbQkgXkJTj2uKhcUzPUr11tKvIRTafteWG8zrwDwmaoAK89zYTMZHjsq5//LbHNFS
	O8enUBA==
X-Google-Smtp-Source: AGHT+IEja1wmZDBHKsl/XJi/skgaumi6X/bo/V6oGWcJkhbKkYCs0Yuuo9kxFl8375k/lLdaOYPUHsEYJmOt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:248c:b0:dcc:41ad:fb3b with SMTP
 id ds12-20020a056902248c00b00dcc41adfb3bmr34206ybb.10.1710395498856; Wed, 13
 Mar 2024 22:51:38 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:49 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 10/12] perf jevents: Skip optional metrics in metric group list
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

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b39189182608..dd8fd06940e6 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -493,13 +493,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.44.0.278.ge034bb2e1d-goog


