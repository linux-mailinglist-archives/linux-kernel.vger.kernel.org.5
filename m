Return-Path: <linux-kernel+bounces-85913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57A186BCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1305E1C21E15
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3326460DC1;
	Thu, 29 Feb 2024 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tnh4PLt2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D7605A5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165953; cv=none; b=ZoHp3aBWWX5Ubbcj/ZPLrF/dRaMszZDVirmNLnP+mchAao7mmIL77w6tRzLNdMpISAjsJu+v4b2ylnYupU35bSS8mTHvLRhAMSIXtizzJriepWKXRjia+Gq+Lezdu0E6tSLglynjmLldb3/xxQozmJ26RRcgxSIoOIE68FXz+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165953; c=relaxed/simple;
	bh=McUJMeln2Z6sLdD8gh2mpJJERcOGFKDfTLUUixwws6c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rUs9IrJ1NjOAVrDQo0Y01jNrJYp6mgDYp11teIJrmmvstHKQsLluckRF9ndY2JbOx1V0GYBtHgBF8ioJ6w4Z3fwfbynYJ8PX0w6Byz0Mxgznd4zQkMp1kh1hycc4daEtF04wTSaPMCuC1KpJJb7zKdPhZ8nwXRtwrhe5vT38KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tnh4PLt2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso630894276.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165951; x=1709770751; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GARAKFSHROUeCUO/36ulyyjpscEMXnihleFvvHQNW7U=;
        b=Tnh4PLt2imeNpvK40JbRWZqzMn+X6PKolkVTyPqjJDdebpx+4e8mhHSAA2dMA+1+7i
         xkyzhHKK0lBRonO0/ULJsFnjdY08e/ZIqQTxqDUneUsljhtV/MrkoUe14qbN7LctzoGR
         Gzk0P4+TaI2gyCwKjCFAv4RQbvn/0r0Ri2kHvB8Aa87pwp4S2neHxtLDm8z0nBH0EoXp
         10Iww2+sufYcnq38Q9c6btRNbFRI3mlFzZF/9GdPcGfH1sjnIP4LT7wJr4QqkMjPR+Sx
         3+lz5tyPlUOk5UtgCjLLSwhRIxnJcXSbDWFd9TQLRaV7u40P53rUY9l97Dk2pO+R86HA
         tKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165951; x=1709770751;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GARAKFSHROUeCUO/36ulyyjpscEMXnihleFvvHQNW7U=;
        b=U55y3QK8F2zx9ldAVgrQ6+3Jki0VLi32knOhGVBNbmu8Ka6NVOdRxSEKwVcEh2yzY8
         m8cq3/ggwXTm2HFQ2+ofdWxPWWxSyqqFV6fwKnyDm0U5knqMYIubsIF6kedOqH2cgpM9
         NKcVUjgcHDOWGorUsPKHQkpXqD8M1Hns1OB4iqKCjoocACMbvTnxtahQS+6r9wBmMcRL
         UJMqe3LkqDjpr0wbTAUDoFynBApdp9lS5BOIT1z4GyAFaTj/QMS8CcwH2LUSHECS2mqP
         l81ug6Fnlie6LrVVEBw62J8XhQbqKFqAMbTKRgqDQWgcL0N+TzmA1n+cfWKzeZ8D7ZjP
         ceMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdm4GjppxGUyy+3l9/VYpJtFVvUh1ppF8d7F8SKhtmsFg8IwWMkydsNxnwH1KeChorPtIclQQFo6wdca2IRywL8yPZCTFoPNEzljBK
X-Gm-Message-State: AOJu0YzM8xCeDfFvpYF/kjO8zMruXc25ar4Kpkpz86vDuiknz+5XrrT3
	mve/7IIQfpIoHGAD7JzOhv0mDhrm6c/5Enyc0POc12aF+yvKhEY4LyX7+ciQgx60phkgwTTSYVr
	TfLT4PQ==
X-Google-Smtp-Source: AGHT+IEe7DD9zwn8ZOiGTYeSJUGCNvgxC5HKVgz1SIYEVj/NzumYBIuhM3sz8942xIHDOWjoqqfTLqiPZoUq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:dc6:e20f:80cb with SMTP
 id t4-20020a056902124400b00dc6e20f80cbmr44036ybu.3.1709165950813; Wed, 28 Feb
 2024 16:19:10 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:05 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 20/20] perf jevents: Add upi_bw metric for Intel
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

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index cdeb58e17c5e..219541a30450 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1006,6 +1006,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+  try:
+    upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+    upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+  except:
+    return None
+
+  upi_total = upi_rds + upi_wrs
+
+  # From "Uncore Performance Monitoring": When measuring the amount of
+  # bandwidth consumed by transmission of the data (i.e. NOT including
+  # the header), it should be .ALL_DATA / 9 * 64B.
+  scale = (64 / 9) / 1_000_000
+  return MetricGroup("upi_bw", [
+      Metric("upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 all_metrics = MetricGroup("", [
     Cycles(),
     Idle(),
@@ -1026,6 +1047,7 @@ all_metrics = MetricGroup("", [
     UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
+    UncoreUpiBw(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


