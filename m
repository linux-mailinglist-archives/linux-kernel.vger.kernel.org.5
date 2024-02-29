Return-Path: <linux-kernel+bounces-85902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F486BCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0C3286859
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97CC5A4D3;
	Thu, 29 Feb 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwOhs7Na"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAF1CD23
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165930; cv=none; b=RhnIlJI83NGodmsCm1VSBCxfZirPsZeqHndOo4xJm0qN4uO4PdfTlvsDdXR0G5oCh+j4eZFnfnatIEsd0eegSgW2ePe1AOxd6miqrlbqAAwrlVBWrgjmqDo1DIYwf29j+gGzb5WPqIqhcpJdcLM6XV/Ep5EnJI/unfqDwCWmDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165930; c=relaxed/simple;
	bh=Eq3tg/JsCmJvAD5Ui2Tzj2WmM5yVtYEVdiyfvstEmk8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GU5U4XopQP/RXInkEIzYOZoQw2eyQ9hmwgcwo18UoejHf83y0H1BK6UbThM91xRaqsD48swtZBuTJ9N3LrUPTMKj57+JF1GNmiVC32BSeTMdoVWWQL/b3HhYdXqOXaaQHmEeEmQ9orEmWz8dFIK2kfstYAOUu+7XsdhfFx98Yag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwOhs7Na; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so605804276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165927; x=1709770727; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NpctYLw69wVy2quG2Men4l4HVGKm57XDegIiPRKOj4=;
        b=JwOhs7NaUhl30dz4ea8HQ4nJwqr1dnNIWDyLMceO5eosq2kg29iQGPYnkt4ab7P136
         2aUeUpj/k+bsDxzwZwiEze4A7tde9cXx3OaZhAOvAtK5B3yRA5aa8qtW1GVKTCaXkkSg
         KwUnexhgrvhUudDiQQd3hRowvMuGU2zpqIookx4gFingryVGwryOA3YhRLZQuY4ejKhW
         bvw78y5jEhBRDZsIVOJTI/PVW8pNQJ1Ig/jpJ2lsj2XOSvPFO5KeTJ1ywwjJFRTwfxxW
         /+7TwkWCat7WHdZWQoBLIUXbIpP14u//8bKG8lfv413X0U1EluD+LYycppNSbC4+TJs+
         HAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165927; x=1709770727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NpctYLw69wVy2quG2Men4l4HVGKm57XDegIiPRKOj4=;
        b=GHf7DEoAG2QWqzvKZMSdLzGXi/d2qUT/rW7tkdfYSkK+kGURKGMCS8xp61C9RCrsq8
         OMfa7SRvNrHIN+08q/68p8lJkz4d8WsMojPakCCuHeuefPMdSmTYmGqu/+Din6PgjcRl
         6ja6OcyQyyIftY3XTkbz2CAPqsF9dkXCo6TJeNVp6bWxO0OKBg6aB5mCnWvg65NHBAK0
         i/jsaNxTt1AVHJ9l8P/zEEIA2rAgOgNeck3lVXuT7+GtPkQ8LVyNqsXGtHPGm6PiOsZ/
         0OWVRcg7pJrtNbUeux4I+cyHxOhn9EHT0EezNoQFp+R6FlA1uaVhr3srk6eP9WwcRNgB
         BTmg==
X-Forwarded-Encrypted: i=1; AJvYcCVSA3srnEkHCAvsCqCgfeqoNMmtEdyRejaplQEGOiiGrV0eq5jj9QGpJr9plaQRXDNS6mkJDQwTefJuwdBAz1y+6xDqWdgOeJiCbegb
X-Gm-Message-State: AOJu0YxePmncrfghU6PeqL9/MuunZmVyZXLy/DEQcOHk+muQDjXYsZ6z
	ACYRzxRKBaWye4mTCLbz2r8a/VmZ/iDc8rkPIzExYmKwrnCpuWDFmU2m55df+wCIpdw/so7BjK/
	foxGDIg==
X-Google-Smtp-Source: AGHT+IFN5KukWzHp4RywVFGqtouZzsR9PWwnvecj3o4ERkM6SW+nBdl+7mQnDNoZHqOXyjmT3Vbg08GMm/t7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:dc6:e20f:80cb with SMTP
 id t4-20020a056902124400b00dc6e20f80cbmr44031ybu.3.1709165926883; Wed, 28 Feb
 2024 16:18:46 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:55 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 10/20] perf jevents: Add ILP metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 0035e2441d6b..0ca72aeec1ea 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -271,6 +271,35 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("INST_RETIRED.ANY_P")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("ilp", [
+        Metric("ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("ilp_inst_ret_0", "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("ilp_inst_ret_1", "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("ilp_inst_ret_2", "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("ilp_inst_ret_3", "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("ilp_inst_ret_4", "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("ilp_inst_ret_5", "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -603,6 +632,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelIlp(),
     IntelL2(),
     IntelLdSt(),
     IntelPorts(),
-- 
2.44.0.278.ge034bb2e1d-goog


