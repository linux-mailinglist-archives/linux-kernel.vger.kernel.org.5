Return-Path: <linux-kernel+bounces-102827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FC87B797
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DC71C218D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA81B7E8;
	Thu, 14 Mar 2024 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXtggZ7d"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BF18C31
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395948; cv=none; b=nr7CR2Bt7FES36PjARLQb284do1Kemd0o0RwiETupgY0AiWhg0F6exMj78nQmhKHsgxLhEz4L0DExXPKwVvSAaV9Gs94ZDKS9xspLOY6038jVQ/DOubiva+sCNqfDVlmhEbpyovW9SVjoKeNIv2rClE1dhi0tIu8Alkg+XEtaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395948; c=relaxed/simple;
	bh=QxznQlTiwxvRoxcxuNV3lrLzfe9XcWRO0Ze5cmywbq8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eVTz7DgsJcFMrmvXcB4ty17k274GtkqdREH+jr8YmJSrIZk0UX8s8bztweUJ2RfKpfIeD/c86+eZxxNg9KLgBSZjkLlMRIL4rtujakH0DTtc7SnotFrGQl4+CquLPA+QGBWMLek6yJALYV/hkgMq0eUeMtsIYgO0D74BbqfiLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AXtggZ7d; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso1349719276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395946; x=1711000746; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oeo18tfO4V4k4hOOFEDEBLHaBjdn7guPG+ER0JNnTTc=;
        b=AXtggZ7dttyMt4bYoWmOC8WKi5bzydN51AuI0T2mYTHbiZGP06bWd7kV7W2mSqb+vD
         b83ToA41KA6PFuTUJ3Rvf992spXrF6ESWUEPfbFfqcTlsHB+D/HHcaHS6geGd2ve2waX
         FXB3rtrdzE89GByO4la9XkUH5e4gWqVTH7o8jZ94dAuSDjdEZyqPhahWsKkZyVfsqHX3
         3CR5Hb5yLfeJapfMZcL6yzB6LAe7CT1PpSqJOQrRb2RtjoR2WcBd4HVNtVKXs4h4915U
         P//ZKxamqjT5jOWxoygL5cF8eCASlge/8J3hLG5iYJXxjJfZ3Tnfrs47uohwmeC48uMq
         dNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395946; x=1711000746;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oeo18tfO4V4k4hOOFEDEBLHaBjdn7guPG+ER0JNnTTc=;
        b=Stz6VYcXJiS3/RNhyqoAed2JpsbySdAgEW/gqf4xvBCR9AsxC2IrCcRk7Z/rInE8jN
         NfJvVRpwpR0oxRk07ChgXPkXDrVf6euPbv0EzOu6t9czr5Ckx2vuwHrxksDihcdD7fWF
         xmxg52qGdvFzjC2R/XkgZ+pg8U9d11MKd6ahZT1gvHqTGV+N7ewWcdX+ofdesN3EvB/6
         EGzRIX9b5wWEarITlaQqnAViwqiWoeKYwC5Ndw649Up3bANguOf3Dw77N2ibjw/Ofrsj
         Jji4LYZ2v7vk3VMFY7ZOlK7r5RedTDycWOrVmJT4KmSZqhwQijs80bSP0Bjog/5anrxQ
         7JSg==
X-Forwarded-Encrypted: i=1; AJvYcCWVxo3aSwZbs+g+6jP1NeS/m/XQ7LHTYB0Cy3ZTPMdGwCnyBFSkhfmpoemcfi6O277Dbz9GlcfCTURawO7Raq+iaETcPCPC8z5R8g9J
X-Gm-Message-State: AOJu0YxgxY34qbYEC7ssB3VqR0ZCUhq/pIY9jr65MGc4Su8LE7lcP6XU
	EUz7uMhr1BLf6KOi80DKomXhD4BJv2Byx4BPAuYLBS1l6IaRIEOw97XH82X/bQ43BGNNI4i258Y
	KO1nAnQ==
X-Google-Smtp-Source: AGHT+IG/XogiODg03QMgLQSvsA9HqjPkCurw8x+4o9RsmV5BB/Z3oRwYqk0vvwKt62C06+05JF1JG6gPS+px
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2504:b0:dbf:4359:326a with SMTP
 id dt4-20020a056902250400b00dbf4359326amr261294ybb.1.1710395946496; Wed, 13
 Mar 2024 22:59:06 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:37 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 10/12] perf jevents: Add load store breakdown metrics ldst
 for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
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

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 79312e33c2d0..2fc8064e4fc0 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -275,6 +275,80 @@ def AmdItlb():
   ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+  ldst_ld = Event("ls_dispatch.ld_dispatch")
+  ldst_st = Event("ls_dispatch.store_dispatch")
+  ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+  ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+  ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+  ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+  ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+  ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+  ldst_cyc = Event("ls_not_halted_cyc")
+
+  ld_rate = d_ratio(ldst_ld, interval_sec)
+  st_rate = d_ratio(ldst_st, interval_sec)
+
+  ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+  ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+  ld_v3 = ldst_ldc3
+
+  st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+  st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+  st_v3 = ldst_stc3
+
+  return MetricGroup("ldst", [
+      MetricGroup("ldst_total", [
+          Metric("ldst_total_ld", "Number of loads dispatched per second.",
+                 ld_rate, "insns/sec"),
+          Metric("ldst_total_st", "Number of stores dispatched per second.",
+                 st_rate, "insns/sec"),
+      ]),
+      MetricGroup("ldst_percent_insn", [
+          Metric("ldst_percent_insn_ld",
+                 "Load instructions as a percentage of all instructions.",
+                 d_ratio(ldst_ld, ins), "100%"),
+          Metric("ldst_percent_insn_st",
+                 "Store instructions as a percentage of all instructions.",
+                 d_ratio(ldst_st, ins), "100%"),
+      ]),
+      MetricGroup("ldst_ret_loads_per_cycle", [
+          Metric(
+              "ldst_ret_loads_per_cycle_1",
+              "Load instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_loads_per_cycle_2",
+              "Load instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_loads_per_cycle_3",
+              "Load instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("ldst_ret_stores_per_cycle", [
+          Metric(
+              "ldst_ret_stores_per_cycle_1",
+              "Store instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_stores_per_cycle_2",
+              "Store instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_stores_per_cycle_3",
+              "Store instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("ldst_insn_bt", [
+          Metric("ldst_insn_bt_ld", "Number of instructions between loads.",
+                 d_ratio(ins, ldst_ld), "insns"),
+          Metric("ldst_insn_bt_st", "Number of instructions between stores.",
+                 d_ratio(ins, ldst_st), "insns"),
+      ])
+  ], description="Breakdown of load/store instructions")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   global _zen_model
@@ -512,6 +586,7 @@ def main() -> None:
       AmdBr(),
       AmdDtlb(),
       AmdItlb(),
+      AmdLdSt(),
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
-- 
2.44.0.278.ge034bb2e1d-goog


