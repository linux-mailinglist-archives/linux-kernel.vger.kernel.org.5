Return-Path: <linux-kernel+bounces-88946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB5A86E8CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED35B2E90C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB53D0C0;
	Fri,  1 Mar 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ahg71M3n"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9C13CF74
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318889; cv=none; b=iqf105zcKidTYlVJfZtPM5wHbzAzeOHrJrnuSkqyZB2mFpWW9jci2GJ0zuW1polu6k8vylcAjsTzjKXHTxWzAYHRHHQ1j1KmD7pyQVPZuX3ssVsSCPsk+Tl7MfcbID7xZDqgTtoGykWJAeA67sxdhfz/w10jvCCx4oJV+uKG+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318889; c=relaxed/simple;
	bh=xBfxlNT0aaXEMy2J3656vmd02rMeN9x8F3Ypxz5k1Kk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Aqgw3XUU0S0gvT0FffNO2T9ljOaj1OQ282GzlB7hgsaSrQlOd2iriTOv6A6e9xr9ALkz75dx2Llv3phYGswJKDd7lXDN+ByvOcwKvJeWrxLPKCBlrgW5Bp/Uf4ipMns9dCOl4zT4CH048jL1u3ua9r8Sd2A4sE5pOuSd5xZui9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ahg71M3n; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so3500327276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318887; x=1709923687; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnw8j+u3lnjVu4UTXXzRJGFzX9SHr9I3FGbOrJjWHHs=;
        b=Ahg71M3n0naNsQXjrkAS1qZhpfiRGx9o2Y15Pl2hEOyNdnM6frSa6/BXytIQvfbDKM
         2SJ8F+8TMQ5W2HdVnDzyk0b7A4xD36/aEx4NTITmSg1cakySxMxS57NtE4YlgG4ZUmBB
         VBgtlrPQc4NH3/XCT86vvbPJEWEoFDeRr0brz6vSwHXBY+C7ZLsOVK7l6UxN8FfGUiTI
         4QDxqBcpdZaSkRM3eG5MiezkU5hmcJfPLSS+URNfA4ZGbsykjAmJxtTsQTHgzvO5Gxfl
         ovdr4Zk/NfzagBKQIDEkMcRwauO6agfPRUxqtv2ZS6A1p29hFUXs03IMnPlPKZDv4uQj
         Nx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318887; x=1709923687;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnw8j+u3lnjVu4UTXXzRJGFzX9SHr9I3FGbOrJjWHHs=;
        b=dccdzsx4zC4rBcUOp9SacZB020tAbzRcWVUG0nNp5Rnt7um/1y8tZJth2HWtIyGX7Q
         xhol+kD1u3Tqh6BWO94MBn5LplhZA3WQSsHRyOlBE2S+sQp92bVIpewC4EODob5ADxE/
         EWL55A/LKO/ZZrgz7uu9dSm5kLGwxZI87QtyFo73a095DnON83UB9ZUsHHtOHI+J3PSf
         7iyPaA8jFVjqHUaxfRVylxAHwqNLoGfoAbk8TSyMeUEvyTMXoVRvz1svSM8NqLKYj3BI
         p+iq62UWPUPc78KlKnqa6dsqT1nyCaIdS0EksVMOy++bF6durwMQJKDM9K09FKkD9KFR
         pJVg==
X-Forwarded-Encrypted: i=1; AJvYcCUXtH0cXUcFu8eQWFfLNZOjnpoStFRUCmP5uOVrPzAHA2ACiHmEoVPDo2xrqDGjvpDqgtMKiDaqdyTCmd/s8Lma/HwyvpcfcCqmu/oZ
X-Gm-Message-State: AOJu0YwmvUNOT1U5Row6h6Ef1H8iJMGE1TvA6+n36nne5YgxASoxybjz
	lPmpJdikip/jzOkwzE0P7wzNioCvRw9J2RiWwgPYmssvJ4X7BTKOT/RjiQakuHKnDqKIqyQWaM7
	Ne9K7og==
X-Google-Smtp-Source: AGHT+IF3gtdTZX8zZ+qhGN79j9W6Px3w2MCjga4xswXwduGdchfGJAS2dE10Pyq4+3LxxdG/Wm87j4Qni4Ss
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:c782:0:b0:dcd:88e9:e508 with SMTP id
 w124-20020a25c782000000b00dcd88e9e508mr536559ybe.5.1709318887193; Fri, 01 Mar
 2024 10:48:07 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:34 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 09/12] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index be10acb40762..f4a4ece551ef 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -467,6 +467,23 @@ def Rapl() -> MetricGroup:
   return MetricGroup("cpu_power", metrics,
                      description="Processor socket power consumption estimates")
 
+def UncoreL3():
+  acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+              "l3_lookup_state.all_l3_req_typs")
+  miss = Event("l3_lookup_state.l3_miss",
+               "l3_comb_clstr_state.request_miss")
+  acc = max(acc, miss)
+  hits = acc - miss
+
+  return MetricGroup("l3", [
+      Metric("l3_accesses", "L3 victim cache accesses",
+             d_ratio(acc, interval_sec), "accesses/sec"),
+      Metric("l3_hits", "L3 victim cache hit rate", d_ratio(hits, acc), "100%"),
+      Metric("l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+             "100%"),
+  ], description="L3 cache breakdown per CCX")
+
+
 all_metrics = MetricGroup("", [
     AmdBr(),
     AmdDtlb(),
@@ -476,6 +493,7 @@ all_metrics = MetricGroup("", [
     AmdUpc(),
     Idle(),
     Rapl(),
+    UncoreL3(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


