Return-Path: <linux-kernel+bounces-85888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D075486BCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FF0288C56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8165057306;
	Thu, 29 Feb 2024 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evhdKGJQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FC56B6D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165770; cv=none; b=c+UNjg/f1LOdMnePDFpb4NyTeq2UztE6ibpvDeUKxyMatpjtjV6Qhd47Tps3hkngkLd5YcBxq1qr+bSR/TAxSP2/21RmFAJHToEozR1na9Y0APYzk2B94+Hb1zvNb9f66+pZSCdOB7Skf7CoEsO6kUvS5UO++l517zkVGYJ0H7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165770; c=relaxed/simple;
	bh=rdT/e0Jk04uz/hli1au/7w9zNoOK9Gsygo85Wow1ix4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Z3YYF4IswhA/cdh2Uh27vt/PhjCF4Buti6Gmm26c6MyQo21lH9G/6/sFfn/SyTNjVJBW/6q/dhiGxfhsVz+kZCeg3w3wVPOrWBQA+M0e6tx0QchOcTQ8xjJng+YOUXCy0x2ujfo2H6a2XaI+G1bbsmE8zYD8l20feaKzNBDOs1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evhdKGJQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60957e0b914so6068667b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165768; x=1709770568; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHahQF2BiK1eIw2Re/KcTjpVIHmS0xMmp3oAqD999cA=;
        b=evhdKGJQU2b/oZ/NAsFgZvxh0AxV5W85oves5f90jukk/PFjqkBIrTxVeG6UJ2XB+g
         nKsO7IVHIa32CZS9+y25N/SXDYIQkJfd/ZWdISUvJnJwu/r9usdwbKgepMG6ocWythzi
         EHwA7W5n30THvvCxxihJMHKDq1Az8aL8yoyscFjl34fzNVVH3122aJijbg6yPDdBnLaq
         YvAaz5EwR2Auh6eNn745Bzxs9J8UQ2aXtajLVnqZlZQvzNV1pmk+88Q+u66u9RUgBOhC
         aHOQ0GiHuiGDzKP/ENaXjhIMZ3n4Rfu3WuIXpfdLCq1AGxZz7Lz+rXxSptSgHqifQBf9
         yHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165768; x=1709770568;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHahQF2BiK1eIw2Re/KcTjpVIHmS0xMmp3oAqD999cA=;
        b=tXsL/gHs0kF5XVelwfGfuhnsTOGL4jQ7absUAc3cBHzjCzJWVGIt9LyD+/bBWGAsZg
         oJuB05+HJkxYXRsVYeEJSSoStTrX+5EDBO4lipDfvKI8O6IX8HOnkn0vgVpjiwiqU/yy
         q1vIdSISrNwO3g6KAk+NmP1OzT/vw43GpO32SAYYwy50FLYy42usmFyoe4aCpmvXJTjZ
         4oXRRUpc+l4K5oXJRLkQt4NUHtzVsX6Jsop5M/8EarhMSKXaypy1Y5eNA0EhNvE102No
         hD5csXCiGv77xaOTaZAvAtxD86O0pGfmMfDjCGptZlwWxHSY0sXClKYlh+cxemM7CHJh
         WkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxMYKWWW56pDAfhOjT24RatDowyiC1S8AZETASnAk5L9D2kJKKOe9rYTO/FN8MPaCZLQiCm2RoOe/HedOFBzl7IjpMJSn08T3UZo3z
X-Gm-Message-State: AOJu0YxHmwppv2k5OphHCV/Ly64/1+hz9GHm4WLBp9u+a5ZAnkHYDaf/
	2X10xL/JjUAVaQq/gIgDxR47xnkXfvvoK7zDlGreclUUi6LZK837kmtZK143DPgXog133TlydBM
	b/000pw==
X-Google-Smtp-Source: AGHT+IG/3aNxiRC63BWDBZbj1S2tf4ajqBK0IG0ZThGkkU02FYQuy0rwRvvmvubAF9jWfd2f5MVBjOefPdbI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:c1e:b0:609:4c74:5cab with SMTP id
 cl30-20020a05690c0c1e00b006094c745cabmr139123ywb.2.1709165768568; Wed, 28 Feb
 2024 16:16:08 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:35 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 11/13] perf jevents: Add ILP metrics for AMD
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 6b182a9bbfe5..91f323c1a149 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,35 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
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
 def AmdDtlb() -> Optional[MetricGroup]:
   if zen_model >= 4:
       return None
@@ -560,6 +589,7 @@ def UncoreL3():
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdIlp(),
     AmdDtlb(),
     AmdItlb(),
     AmdLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog


