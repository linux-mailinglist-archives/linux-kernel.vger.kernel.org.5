Return-Path: <linux-kernel+bounces-102834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08087B7A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686FB280A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB013FEE;
	Thu, 14 Mar 2024 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACyDRM0e"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D710962
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395978; cv=none; b=gJLvVlKr46eprSly6hrv/6NnKrhYZGJ8x3bixG0Y1806DSTXaYRWw6PaV0D/X9F21I6VGWwv66wxHQP3AWmL2rrAOGh0XpG75X5PR8uK2NB2su9gXTAftoigwU6km/lA/Y+LkiGuC4+Ke6qPnVA7fsnws4LVRpxG8ZOh4YdR29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395978; c=relaxed/simple;
	bh=LyYWkoBF0P1c0DOJICMXfmzvr8RS4ew644VymSLO8fA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ckl+MuI68ssdHeTY4zHAtn7Gpg3SDhcDtZczBI7E3pTR7xumE2gaBj+drP+GjofE23n6IJR4hUp28/+YvFFecf8asc2spExh3+ebpz4YYjcBtZ3/HpRwo8C7nxiMSOB9ieI4+HZPtun4flQPnsaf3i5rrGWu99Razweqnua4yEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ACyDRM0e; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso651678276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395976; x=1711000776; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mYqX63qH2QI08KtgPVfUX9rzA4k+k/gYXO7veJ+nMnQ=;
        b=ACyDRM0e02e2SgqyWcd9BfpqF1kMGRSxKNjiJHRwErhEtuonpns9rYfyjBGeE6xug/
         5P9tdmDuIng0orDjaLi869wOqV/sy4c/RsfEBnEZZfhU4vSX9saYbqXLv06GeMjZskKa
         BT73C6uvCXGeNTJzS1oo4FH3MP0XJWt1178Ma3vqv4LbFoP7UhNeb9LSmAcQVpTZdFyy
         O2kyAIZlxtW7cxpzrEcg9ZXyYbbCFuHojmk4X/uJ5fQJ8N8dGF2YbSQTU92/UKm7xD6R
         Ov6eUNCwbDZuZ2apIxU1Bbel9bI4r7FZdsi8AM23BBoPy5m915Fe5n6ZVhlWhmAZ5wCz
         1niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395976; x=1711000776;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYqX63qH2QI08KtgPVfUX9rzA4k+k/gYXO7veJ+nMnQ=;
        b=e85uYvqJBFh8FuAOfNHc7a6amdgeoU5WJRbjA5iNaSOxIi5x4jjwokwXh0bnTh+H6g
         Z3mAJf+5r3GLlXBhXrz7tCAaOpPUF360duDkJrQqn0Sl334j64QzvS7n5WFvCqjGNweg
         5fvFqORBayn4nShXXzchasvcnVeQ6viFVGP7fzrt7Fy6ht3GUIj9BvFti8zdXssodEv/
         I9sxYJiVzwGKiFvjULCS/5oRBKEqc6iI7RR2H3PDP+AohXAqhNm/hMX8RC7iWIePHi8y
         qXZSz546gFWG1Q6TFOAYj1g2FUjDHrzxXgFkwRqw8JiToMpJPIknZAkXXpZH1Pdp9B7E
         CPDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZpeBJqckiWy6T2bISht5GoB93h9948wGTU0uQ6GJtfEj8NN3r5BLDnS+Cn3MMIh9OvKg136zqhMhvGeiZ30BDxJLcm8+SHCfBKBuq
X-Gm-Message-State: AOJu0Yw6e9RQoMKY22WhchU1tBRUwdNjKHLP0Cl1wOSa8GplFZlPxuYu
	IGoO9UJiAguSOM/kb6nu7QxfT6fRXnYVADN0Brw7BldIumAV6znIsHsN5tqzTribdY79PbdcpS2
	FpqK/HQ==
X-Google-Smtp-Source: AGHT+IFBVRs2U0wkLF7xsLHWNZwSFSKC6tIGeoNNo9vmrHamsC+zOe3HgJ6keKdUYtHfpNieEtLOLv0MgajX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:220e:b0:dcb:bc80:8333 with SMTP
 id dm14-20020a056902220e00b00dcbbc808333mr212152ybb.13.1710395976722; Wed, 13
 Mar 2024 22:59:36 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:59 -0700
Message-Id: <20240314055919.1979781-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 00/20] Python generated Intel metrics
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

Generate nineteen sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
eleven core metrics. Add a CheckPmu function to metric to simplify
detecting the presence of hybrid PMUs in events.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/

v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
    minor code cleanup changes. Drop reference to merged fix for
    umasks/occ_sel in PCU events and for cstate metrics.
v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.

Ian Rogers (20):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add smi metric group for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add br metric group for branch statistics on Intel
  perf jevents: Add software prefetch (swpf) metric group for Intel
  perf jevents: Add ports metric group giving utilization on Intel
  perf jevents: Add L2 metrics for Intel
  perf jevents: Add load store breakdown metrics ldst for Intel
  perf jevents: Add ILP metrics for Intel
  perf jevents: Add context switch metrics for Intel
  perf jevents: Add FPU metrics for Intel
  perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
  perf jevents: Add mem_bw metric for Intel
  perf jevents: Add local/remote "mem" breakdown metrics for Intel
  perf jevents: Add dir breakdown metrics for Intel
  perf jevents: Add C-State metrics from the PCU PMU for Intel
  perf jevents: Add local/remote miss latency metrics for Intel
  perf jevents: Add upi_bw metric for Intel

 tools/perf/pmu-events/intel_metrics.py | 1022 +++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |    8 +
 2 files changed, 1027 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


