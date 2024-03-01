Return-Path: <linux-kernel+bounces-88945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F886E8B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4317D288368
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F63CF75;
	Fri,  1 Mar 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqCkYMSe"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39613C49A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318887; cv=none; b=Gl9NkBJxYXFzpa/6FM9+4D0rHg20h54xvvcMmVQaHcsBdDRKus0pETLN+2HfG+iIvj3anf7/rFne2CdxwV66BEth0HS+Ad4nMG9jjAh3HXKrpDmp3b7w1MS4nOukNuOxhrP0nwUFXTWOKBwSVLg9TxrS8yR0xvJOyP9I05BbJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318887; c=relaxed/simple;
	bh=XBT9PFw4GJEI1QEQOFY5V3VQlW/6wsuXkDB+REWJty8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GWZ6yWnJPkxUe1vE1ey6XTHSVTxN/ZSM6z/yfffMFP6ys0gJVKZue0JOO1bvMmUJlTBWttaUP+QmeLSB1SNGDz2PueMCmQ5+f9Fl07l8k6ncb7lfAArw/fONJiB92rYfgv6BCMW6fAczDunMTuzAQoUxsI8m8EjjnXpEwyV7nB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqCkYMSe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607838c0800so38912087b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318885; x=1709923685; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QW5aXCnWYkSdBtfKb1tyFWz2NLyYuSqZgMPUtXRmNrc=;
        b=SqCkYMSegblOi7eJ1yNAYlydT0U/Jp1fbEVwXiQDqcgaCJD8BYfycN8NcFkjnDgAWd
         BBjJbY6VzCjKJeY9rHQZoI0HtR9xo97YAkjmeyr762x3BCH4KuyaI6ncy2zeEW6Io4Vc
         /1xCUF2EN7pwGXbRVjShjdmF2RmyQYshBqvmtwdRG9/yypINhWFT27jVN9+YujoDU3DW
         9w784GQVT2hsSfB/vGQ5MmiCMWF9rl6A2dp+cJz9GFtrfJLGl10O/C3E2G9xhfZGJ716
         LfugjHv04cf4qG2WSxRmKfC1yLcUjFs4xH1ORvuxBYmKxKDkyEhL+OKEK0IWUiHYOHjs
         XZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318885; x=1709923685;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QW5aXCnWYkSdBtfKb1tyFWz2NLyYuSqZgMPUtXRmNrc=;
        b=LhXaJAAovpp8B53JisJDSxyi7W5Dxdq6XbVq175TAX/YIjIfthoDxXiDQLCVsXGjjL
         sHNQ618jy3RC4SMlvZj5UHD7VdlovwBqPtn0vi4x9WLOCBvBWBN+pkH1L0gmnah1u19z
         9V3Bo7fRof6f/BlJBK8fbE88thmNY5UHPibihcZM0bux7yr2KDw6xlhgKg0YkhiMmOVF
         KNipsaOO7h9uPTKHL432dfy7D1pGyXNRYw3X0JDMlwYirYr8lUHnycNa1qUk5Db34zDh
         1zni3ojvZI839G7Z4gVzq+fV+MLgcsnk4Ap/lEGTuFXBY/2maWwtKkpW9S50BF1hf08s
         Kcvg==
X-Forwarded-Encrypted: i=1; AJvYcCUP4B8zX75NyLYT8H+TVbUmaTENY/XiL0rkb6QQvs1MlCadRDBsxxhcD5wBmk4+Nj+eBS6amVYSF/VVEhUxjNHXRHe51PRXHJ7G8FZz
X-Gm-Message-State: AOJu0Yw8X63nVEb3Fpl7pGuWtuvWUaJKt8CbmQnXXDAam0brCWdAzPEr
	NVtT8U7yXe3/U/29NlaLUB10MxjCMopc38WX/XsIOeuEc+8ftN6aZYa8hn1LAv3/UZgqcHPPAFc
	sA4Sz3Q==
X-Google-Smtp-Source: AGHT+IHi8ll8T6N/4FKRHr3jgBpE9kBtsY0MxYnyl87W0DLqijXID3ZgAZT5SDy9eMsuZjtJbkhonmVvY8a2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:110d:b0:dc6:e884:2342 with SMTP
 id o13-20020a056902110d00b00dc6e8842342mr710276ybu.5.1709318884811; Fri, 01
 Mar 2024 10:48:04 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:33 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 08/12] perf jevents: Add dtlb metric group for AMD
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

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 108 +++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 82aab39c2a50..be10acb40762 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,113 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdDtlb() -> Optional[MetricGroup]:
+  if zen_model >= 4:
+      return None
+
+  d_dat = Event("ls_dc_accesses") if zen_model <= 3 else None
+  d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
+  d_hcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if zen_model >= 2 else 0
+  d_h2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit")
+  d_h1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit")
+
+  d_m4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss")
+  d_mcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss") if zen_model >= 2 else 0
+  d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
+  d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
+
+  d_w0 = Event("ls_tablewalker.dc_type0") if zen_model <= 3 else None
+  d_w1 = Event("ls_tablewalker.dc_type1") if zen_model <= 3 else None
+  walks = d_w0 + d_w1
+  walks_r = d_ratio(walks, interval_sec)
+  ins_w = d_ratio(ins, walks)
+  l1 = d_dat
+  l1_r = d_ratio(l1, interval_sec)
+  l2_hits = d_h4k + d_hcoal + d_h2m + d_h1g
+  l2_miss = d_m4k + d_mcoal + d_m2m + d_m1g
+  l2_r = d_ratio(l2_hits + l2_miss, interval_sec)
+  l1_miss = l2_hits + l2_miss + walks
+  l1_hits = max(l1 - l1_miss, 0)
+  ins_l = d_ratio(ins, l1_miss)
+
+  return MetricGroup("dtlb", [
+      MetricGroup("dtlb_ov", [
+          Metric("dtlb_ov_insn_bt_l1_miss",
+                 "DTLB overview: instructions between l1 misses.", ins_l,
+                 "insns"),
+          Metric("dtlb_ov_insn_bt_walks",
+                 "DTLB overview: instructions between dtlb page table walks.",
+                 ins_w, "insns"),
+      ]),
+      MetricGroup("dtlb_l1", [
+          Metric("dtlb_l1_hits",
+                 "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_hits, l1), "100%"),
+          Metric("dtlb_l1_miss",
+                 "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_miss, l1), "100%"),
+          Metric("dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                 "insns/s"),
+      ]),
+      MetricGroup("dtlb_l2", [
+          Metric("dtlb_l2_hits",
+                 "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_miss",
+                 "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                 "insns/s"),
+          MetricGroup("dtlb_l2_4kb", [
+              Metric(
+                  "dtlb_l2_4kb_hits",
+                  "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                  "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+              Metric(
+                  "dtlb_l2_4kb_miss",
+                  "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                  "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+          ]),
+          MetricGroup("dtlb_l2_coalesced", [
+              Metric(
+                  "dtlb_l2_coal_hits",
+                  "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                  "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                    d_hcoal + d_mcoal), "100%"),
+              Metric(
+                  "dtlb_l2_coal_miss",
+                  "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                  "DTLB L2 coalesced accesses.",
+                  d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+          ]),
+          MetricGroup("dtlb_l2_2mb", [
+              Metric(
+                  "dtlb_l2_2mb_hits",
+                  "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                  "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+              Metric(
+                  "dtlb_l2_2mb_miss",
+                  "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                  "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+          ]),
+          MetricGroup("dtlb_l2_1g", [
+              Metric(
+                  "dtlb_l2_1g_hits",
+                  "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                  "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+              Metric(
+                  "dtlb_l2_1g_miss",
+                  "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                  "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+          ]),
+      ]),
+      MetricGroup("dtlb_walks", [
+          Metric("dtlb_walks_reqs", "DTLB page table walks per second.",
+                 walks_r, "walks/s"),
+      ]),
+  ], description="Data TLB metrics")
+
+
 def AmdItlb():
   l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
   l2m = Event("l2_itlb_misses")
@@ -362,6 +469,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdDtlb(),
     AmdItlb(),
     AmdHwpf(),
     AmdSwpf(),
-- 
2.44.0.278.ge034bb2e1d-goog


