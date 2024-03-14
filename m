Return-Path: <linux-kernel+bounces-102843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1AA87B7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3EBB21600
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF363CF6B;
	Thu, 14 Mar 2024 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMlh6PXL"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20113B29A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395992; cv=none; b=QGqXfSMjNRrWtscx87vgp8V5E/dC6T3GJ6M4JOi3aSMq9Fl2wUqWtgBj/cmwgr02nMuZHSY9mCmCT0Q2SrsapAQgGTiDKmVZunbpm53FNO6G8LC5oHJeNIdWWwup0mQNoMZfHTWXeBrB5BHRQOiI4KPoAkPAGbsGMI4SkvCwNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395992; c=relaxed/simple;
	bh=FRD4urmCzmXTmNozFD4Dr+8XpRmwK3qVFgHQ1nWF1hg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hDrATCognvGYzQpDwV2SghLeXbyBdlCVliQhbAqOg3O9hDR4fcr0lAkgXA2hCIeD6TRjKLR6anr80S1P3q6Vs5k+L98Ep0EC/IvumhhbISuxYmcKvbqwhFgMde5l4zwKlrnZtZ8748lGCsJin5+5OVNPE7LHF5t+EzO0giFHhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMlh6PXL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so982558276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395990; x=1711000790; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILfM9APc2QmtUlfGAi2ySSBl9xHV6Dsl5aSOkdQM0Ig=;
        b=PMlh6PXLWUrJEN7+T4OJ7/W8aW9fYRQz5QAy74V31AntWFlmQFhjzW7PDpa4NyQh7W
         QPe2vGzFznRxfhIy/wezYn71kbbIzj6hqb2ca1KLeVR0fZll++GYumeSmUbAW/oWC780
         BYYLaQOmWjDt7ifndkMUm7+0RnXN8xLSgIxpe4K27wO+LjZ25UJ3YtvDjc+SYxzs8f0B
         t9AVKvmeqhtGVtUm73jmMVAD/ccJgMC74Zfu6wO+iN3lsvB9vrV0aNHoiBzN1SZWliFw
         zfbhZsRGLMe6b51SE7X/EzmXA/8iYw6UTtNhtfeHU8JuXvCjhXvE6mi2+OaUhp82wj90
         UYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395990; x=1711000790;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILfM9APc2QmtUlfGAi2ySSBl9xHV6Dsl5aSOkdQM0Ig=;
        b=M7Cg7ReneEi8MGSkIy0l9jR3CVEWJ0AettyFIBzNJ4yWLi4kxcCIk8GbwDk16pyaRG
         plN++2TyE1+gEdKLuYOqDWp/Wf8oC0B08WRCdViq/Da+mc6xwJfFvuFLN3LL2s1nEdGf
         xSd/Jyp8gt8jX/pCI7zUmS86x02xfhXd6xR8AoNsERwPIYL223Q1ljyLfaXLxzJz4Fc9
         geRwXaZSPOIgOf+l96rhO8I1oGP4QIOy2apIaMYtOM4H9R1vJYqHZ0wgqvP9T6O2kxLH
         o/9/8JFq7O8pcNuyTr+YyF3g+HFw0gcRzcYKmuaNFexwsiOHxlmQZu3Cac9egEOH7JcF
         5WoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr7sVMzrNCdWUbBQYBIW3TH/rtjK0ArCMYD2yyaGZhEKcHttpLlVjNYQeCP+VDXkT3JAMVT6vsOk4tPeOCY1L1OQ4yqaFh31BqbJAp
X-Gm-Message-State: AOJu0Yxk7KSH87DUzJCtnuhcoDEQFSujosTqzllctlHRy+wPorrwQZAj
	pVIv/xaR/4vQI8Nuu3KdqpPaH6ho0lxMxJ1d+5jsgeyw6BkW4CCM/b4dzQPX5aRtJ8rmHt7lFEk
	79OFbgQ==
X-Google-Smtp-Source: AGHT+IFpC7wmiwagj5y8cnwZSsboxN3EC3qcg38805ughEkS1bFKpFs0SIq5TZ9BGVGsPsTfIGRWURAoOFHS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:160f:b0:dcd:25be:aefb with SMTP
 id bw15-20020a056902160f00b00dcd25beaefbmr252248ybb.13.1710395990067; Wed, 13
 Mar 2024 22:59:50 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:05 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 06/20] perf jevents: Add br metric group for branch
 statistics on Intel
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. Conditional taken and not taken metrics are specific to
Icelake and later generations, so the presence of the event is used to
determine whether the metric should exist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 58e243695f0a..09f7b7159e7c 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -123,6 +123,143 @@ def Tsx() -> Optional[MetricGroup]:
   ], description="Breakdown of transactional memory statistics")
 
 
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
 def main() -> None:
   global _args
 
@@ -150,6 +287,7 @@ def main() -> None:
       Rapl(),
       Smi(),
       Tsx(),
+      IntelBr(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog


