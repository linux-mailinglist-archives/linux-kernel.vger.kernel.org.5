Return-Path: <linux-kernel+bounces-85897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB886BCAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F1F2847A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F845955;
	Thu, 29 Feb 2024 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dq/cFuI9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2D42A8C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165918; cv=none; b=NUX25ArFumhksiDVitD/pVF4DDPIksIUJ0qJpG4NYvEp212e1LWBkrv+kcwfjiY3FKST8GlsArd7Ijnf2BZa3Xjq+Jc8lMdlqqRVFFuF2m41dQseglV4QCnyvzv9v5vAZ/vI3uIMkUICwsPeyOs2Y++noLSDNU3vQUvYtDqnDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165918; c=relaxed/simple;
	bh=lh38C2ZP3x0TtmsYtzGGwnk35I03kkxZ3DF9a2lkNs8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=vB6mvWELGcoeeJZAjTX8OLIBa6TQ8SsAey89C+j3rNsDMSAldDO7rEvykt2OToxFX8qqfZYrXww8crm1upTdkRgHMRyeQ18/QLmv8erTfOPNscP6QuqZN0tsr07RNMoQWScQZQFoF9BZDlbbYwiSXjszqff0m9EIhPaUlAkCmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dq/cFuI9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607c9677a91so5912027b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165915; x=1709770715; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFlMx+oNasYCjHbkgyCsRQrkyODw2CbaRmUxLrBz57E=;
        b=Dq/cFuI9y/evbZOWtKeVWlsfNbNE9w3FhYKZadsSug9L9f0TjF580XkGR40LmE7jZc
         jwxCSzBX/J0tMtW2NMxy7iUZVkQo/CMiT7S3+xMngLxNQc4k2dfE5pu95Y3fH/Te4Ev9
         wmojcVo4zt+NZtwWllb+suCNpJ8SlMbCincehbrfdCXuuXsvDBXGp6CMPERNE32SRzpz
         wqXxj3tgYkbZ3T+9hiZo14PyocJ4BSjD2Krt2+RwViQdVkPK6W/xRv4h0uWD5hHYcVei
         MwLm3GuZUiS5SfufhahY/INLH44vbuJGluD8cnoK44IsxEcDqBmvGsT7GOERkX/Ec5as
         V86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165915; x=1709770715;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFlMx+oNasYCjHbkgyCsRQrkyODw2CbaRmUxLrBz57E=;
        b=cgpJnbjX+QfqQsOMSPdfw3aKr3VOp0KOcEZnpFofsPKu2m8HOcoBfXL7xRJsZeUlIK
         EBglAGy/I110Yqtpog9vXTREo7IMXYUvtrIbuIeJONdCRxA6+JkaHsHb/HU4s8lm+cuF
         LQtXeQBihz6tehncYpoggXyVWPOO9uf0NGmVUkF4LuZPllvzRxHywIvrVBevUKu3TrQn
         QL0a3w/m1Rn9LNkc9x8HQ4J1+cJRZnLfunJDI/crItn99GmBak5LEdjZk8ELkQXgTge5
         KleM1jRmNW9wu7KXf8H4tJRE3MwZrlwdxldLZuSi9RArIwkt5j6+c8g+pkDPY93fdUn6
         YBSw==
X-Forwarded-Encrypted: i=1; AJvYcCWrdiCPc/taFlFXP5XSqZdxZ3gS72ePlCBiMMZTqJo+T8Tga/te8TFulphoWHctLpKeeHJwJuA6ZTRfvrH3BN1bVUFzQO7KXMg2Qc2I
X-Gm-Message-State: AOJu0YwYZeZqbmJ7N4v+F+6VWfY/1gcZn2j8AOne6AUg02l53tipQpXy
	C3hpqfcD/oulVJH0y9iDqAY6Dp1Gw9UbfPMOZPB2lN0/SBVHRfsPxltAsfSceJ1eUjqhTTlxgQA
	3r/Zu/w==
X-Google-Smtp-Source: AGHT+IHC14oTBO4GDCo83r7qwcuz2rr/yMZTII/RSuGhoXST3N7hzinHTtQb1DAHe/57G8TxacAvrF1Xu+jQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:9849:0:b0:609:3c46:1889 with SMTP id
 p70-20020a819849000000b006093c461889mr145864ywg.7.1709165915657; Wed, 28 Feb
 2024 16:18:35 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:50 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 05/20] perf jevents: Add br metric group for branch
 statistics on Intel
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. Condtional taken and not taken metrics are specific to Icelake
and later generations, so a model to generation look up is added.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 139 +++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 1096accea2aa..bee5da19d19d 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -19,6 +19,7 @@ LoadEvents(directory)
 
 interval_sec = Event("duration_time")
 
+
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
   tsc = Event("msr/tsc/")
@@ -127,11 +128,149 @@ def Tsx() -> Optional[MetricGroup]:
     return MetricGroup('transaction', metrics)
 
 
+def IntelBr():
+  ins = Event("instructions")
+
+  def Total() -> MetricGroup:
+    br_all = Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
+                     "BR_INST_RETIRED.MISPRED",
+                     "BR_MISP_EXEC.ANY")
+    br_clr = None
+    try:
+      br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
+    except:
+      pass
+
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_all, br_all)
+    clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
+
+    return MetricGroup("br_total", [
+        Metric("br_total_retired",
+               "The number of branch instructions retired per second.", br_r,
+               "insn/s"),
+        Metric(
+            "br_total_mispred",
+            "The number of branch instructions retired, of any type, that were "
+            "not correctly predicted as a percentage of all branch instrucions.",
+            misp_r, "100%"),
+        Metric("br_total_insn_between_branches",
+               "The number of instructions divided by the number of branches.",
+               ins_r, "insn"),
+        Metric("br_total_insn_fe_resteers",
+               "The number of resync branches per second.", clr_r, "req/s"
+               ) if clr_r else None
+    ])
+
+  def Taken() -> MetricGroup:
+    br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_tk = None
+    try:
+      br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
+                      "BR_MISP_RETIRED.TAKEN_JCC",
+                      "BR_INST_RETIRED.MISPRED_TAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
+    return MetricGroup("br_taken", [
+        Metric("br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%") if misp_r else None,
+        Metric(
+            "br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    try:
+      br_cond = Event("BR_INST_RETIRED.COND",
+                      "BR_INST_RETIRED.CONDITIONAL",
+                      "BR_INST_RETIRED.TAKEN_JCC")
+      br_m_cond = Event("BR_MISP_RETIRED.COND",
+                        "BR_MISP_RETIRED.CONDITIONAL",
+                        "BR_MISP_RETIRED.TAKEN_JCC")
+    except:
+      return None
+
+    br_cond_nt = None
+    br_m_cond_nt = None
+    try:
+      br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
+      br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_cond, interval_sec)
+    ins_r = d_ratio(ins, br_cond)
+    misp_r = d_ratio(br_m_cond, br_cond)
+    taken_metrics = [
+        Metric("br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+        Metric("br_cond_mispred",
+               "Retired conditional branch instructions mispredicted as a "
+               "percentage of all conditional branches.", misp_r, "100%"),
+    ]
+    if not br_m_cond_nt:
+      return MetricGroup("br_cond", taken_metrics)
+
+    br_r = d_ratio(br_cond_nt, interval_sec)
+    ins_r = d_ratio(ins, br_cond_nt)
+    misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
+
+    not_taken_metrics = [
+        Metric("br_cond_retired", "Retired conditional not taken branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of not taken conditional "
+               "branches.", ins_r, "insn"),
+        Metric("br_cond_mispred",
+               "Retired not taken conditional branch instructions mispredicted as a "
+               "percentage of all not taken conditional branches.", misp_r, "100%"),
+    ]
+    return MetricGroup("br_cond", [
+        MetricGroup("br_cond_nt", not_taken_metrics),
+        MetricGroup("br_cond_tkn", taken_metrics),
+    ])
+
+  def Far() -> Optional[MetricGroup]:
+    try:
+      br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
+    except:
+      return None
+
+    br_r = d_ratio(br_far, interval_sec)
+    ins_r = d_ratio(ins, br_far)
+    return MetricGroup("br_far", [
+        Metric("br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("br", [Total(), Taken(), Conditional(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
     Smi(),
     Tsx(),
+    IntelBr(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


