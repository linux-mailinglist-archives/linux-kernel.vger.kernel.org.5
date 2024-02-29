Return-Path: <linux-kernel+bounces-85874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CF86BC91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9C7B219C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64D107B3;
	Thu, 29 Feb 2024 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+O+gPxR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB9C120
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165617; cv=none; b=Fxmp6ZNK7eX2I9nL2238JoiZ3eS6faP4FZpUUjd8aPOLqqxcqEIRDWNdSlLh7OQDeNLQDaNS0hCEiLfLhyh1TI2c4KCO2iNyQnW3/1gkxSh96ZKGBDk5HVV5AMsmvwtBaMFAjlghF0uRQ2EwzekHlxggtbteec2Ip/LLh4kk44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165617; c=relaxed/simple;
	bh=RmBYm+ZtRWY2Q7E8540FsapTEKqB2m8rCmYuA4GJXNw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DMt2AnQP5PIZ1DDs6IegdcTFqpzxZu/DiqRK+3dQ4nXkkVJWsN6SR/+pMTGPgdB8WXvJHfBmNdc+OLwIsmmcctfCDy+jyJx6IrX6KAqpgkulLblj6gvKKd3y4jDhZppnr2opSt/nwH0mcaICvrAJBW7MfWmY6xuIc294H/0za5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+O+gPxR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6092c637278so5401057b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165615; x=1709770415; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7G72lluaDAnsWJX5YIbxhUo5zYGBJynYcdzkkcMI8Zo=;
        b=z+O+gPxR0ziqUTninrIUFj6Co+uH1LwXXPDYj9itPIuDbOvUPiuEPnd/vCIKgMnOQU
         m187qJ9QEhZmpAUr/NdAXItYLhGqwcz43n/w77EXr798F/nqGCFU31fWKQg8h/NffzSD
         PlPWm+RJd/8WHgzE2vebUL8wjBeaMdtDXQmJJV3mSuNf9UesYkkjIlFR+ZZVcAEGyEyw
         c/+f0u63MlabU4/52mIUERnIaV01ZLLMTYivo/ikR37atGpWX+7GnITNmojN7x2iNt69
         iEgsneebhtQ4xO8EDzxb5gKDcKOgSvpbkdnoYCpHx4VmiKc2dHGbhG9idOKQBijBiB1l
         jPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165615; x=1709770415;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7G72lluaDAnsWJX5YIbxhUo5zYGBJynYcdzkkcMI8Zo=;
        b=fHNJekQVE1NARdYqCfCGnqEQCVYq3+LlpjCyNv+AxZAYBvLtlFlj1nhtsOJKVVJ/sB
         HdbC5M6J1SZk0f7axIn3FtCgejhI2UVPvLbcL/bDo7F/n+oQXg+kFOJ/++jnhzmOglVG
         E0vEF8LSPRqQPiuqKdBNDf2amFT46Z4BjfaN+sKHJliTIu9/Nu7Bfk1Wm21VOWXfulan
         +LhlayD8akN5r/U9dA7sMl0TXqf5zKq7ocT4qyPnBglxHQ182pBct119fom7BYKo5U90
         qlK+VfUOmjln9PqzBUAo2/YWb3ZFcXxjtBp883BYVSdrcSztkUL9AiwIK3L3U2P3fap0
         OqBg==
X-Forwarded-Encrypted: i=1; AJvYcCXnij/K+uET/ITZZsJQu+011fydvs0Z3QarF0x6r3WoeK+FEAaJtJU/o29iWY2QWOecClYcRCmFygXdu45rfASULJjDT3nKK6QW310j
X-Gm-Message-State: AOJu0YwfUh+T5me5Hf2Kl4+RL/+nfeOETGYs0+8fCl3Lg3rJK6O+wz6r
	dLBTl1b80WEUHmcr8kRsexlmAoq6j8eaw7JPBkcEA00Isoe4hHGR8dyYaVbh+CAokzlOk7K+Aaz
	hGtN0mg==
X-Google-Smtp-Source: AGHT+IF75xTI3XwTDMHMROUJxAdhz+QA2KHtU3yAX1qgVT6DL3VYdA3DxhD2i6/sTgc24ccWIiBDjkpesgFM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:c9d:b0:608:ced0:eb2e with SMTP id
 cm29-20020a05690c0c9d00b00608ced0eb2emr126092ywb.0.1709165614975; Wed, 28 Feb
 2024 16:13:34 -0800 (PST)
Date: Wed, 28 Feb 2024 16:13:25 -0800
In-Reply-To: <20240229001325.4157655-1-irogers@google.com>
Message-Id: <20240229001325.4157655-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001325.4157655-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 2/2] perf jevents: Add cycles breakdown metric for arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown cycles to user, kernel and guest.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arm64_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index 0dcf5236ea1f..e1874d8024c1 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -152,8 +152,26 @@ def Arm64Topdown() -> MetricGroup:
   ])
 
 
+def Cycles() -> MetricGroup:
+  cyc_k = Event("cycles:kHh")
+  cyc_g = Event("cycles:G")
+  cyc_u = Event("cycles:uH")
+  cyc = cyc_k + cyc_g + cyc_u
+
+  return MetricGroup("cycles", [
+      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
+      Metric("cycles_user", "User cycles as a percentage of all cycles",
+             d_ratio(cyc_u, cyc), "100%"),
+      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
+             d_ratio(cyc_k, cyc), "100%"),
+      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
+             d_ratio(cyc_g, cyc), "100%"),
+  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
+
+
 all_metrics = MetricGroup("",[
     Arm64Topdown(),
+    Cycles(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


