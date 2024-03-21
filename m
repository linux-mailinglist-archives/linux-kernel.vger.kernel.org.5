Return-Path: <linux-kernel+bounces-109667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2D881C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3C4B21542
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C5439ACA;
	Thu, 21 Mar 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIpg7JSp"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC237494
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000826; cv=none; b=hYFrVzyDsgxxBjL+HV5TLIzdwxLsUANzCQ00x0OMkqZdTXZ06MezM+KUmZPK291oIdvysNIF5fbsIFBWlJ8yKqk0A10zQWnaGXtW004Wf66JKI14P6uk1V8vnqSgD9wXQaTCuj3gkMXKcHR3NkOwF4ShOUSRTACOgQAInnGul5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000826; c=relaxed/simple;
	bh=jRpRaEdrA7J6780gMXcjf+L/UPrcyknXSq1ovHjiA8E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=HZ64PHeMRAfyoLXSqY0mvmwDTFqFkVPWI8XLj5PjNj9xj515SSl/a+wUtpQmbXM0+iLVpfGbVNGBcVCNny6RFfbUz/fi+vup5SXy85RnTr3IYEGRhO3r/1gguqywkde0W0L/g/Kdj2v4RxM2rBiTfDATWjRvhAVUKuUHr44DVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EIpg7JSp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso965511276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000823; x=1711605623; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfW/k6FjlFxqVo75q9wM0sppIP+cY08HjgX4S+SAtUw=;
        b=EIpg7JSpNXPonPYSre0xGF76x6YWexOPqjBTwtDfmlEcGw7JScb68mVKxxgIY786Pv
         cAChBimIUSwKQOdNSRsyVWlHzeJzdtFiR63kFcqe+VK127wkztEoyl5KRKKvGSsxS3ik
         mnLTeRm01IPfJQqKgwPrOY4lsKZen68JMHLLeBluEBen+g3jRxCpYcdIxTudEeuwkaXd
         tlN1286htg4AVpjlm37VQRdNdB7Wu1RRnCB0HGw43qW9cyqYpiBfzWraGCCY9vBY6f/n
         sURPm1YJVcUOKv6NsAMlXU2ep8cmtehnjvBtD8s6XXc+GkeZGh1HPPC+pBBJjXyuzJAf
         Lzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000823; x=1711605623;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfW/k6FjlFxqVo75q9wM0sppIP+cY08HjgX4S+SAtUw=;
        b=D1W/x1v8gZQjyfYSyuF1nYP3HKPQWMcLmOC9ysllKsXZY43E9AN54UNAPvQ1/W4orh
         C20E3G6UFoC1+oXjoxVytBWoRX1rkQLhO5gfnaQ8hgodJxmRq7gs2ZCRVajUcVsxFqd3
         nsG6OfYMaaICEH8M3/BolwcODWrPVroGAzRFlEvBPIvg4ZlFCxC18Shy53k6NQsdP5ye
         ky2lDtzxzQKMW2so/c5aKGg5OQuSecghAIWhJJrHFThWI0gwNJUJLZ0JhslCG5BBZq3g
         2Ha/ltKYxE2h7Drh4CXz/0fdhf5borb+1a+4dsC7m7Z6nx3DTn/+u07gejf21N0vnf8V
         XcPg==
X-Forwarded-Encrypted: i=1; AJvYcCX53GWp3CAS3UFq3cWkMqi3SWQbMLP6kjoHtsa1EsbkUfo8ZjqGihlG4ewS3MVDrUoO1EsaHo9GpI0CULEZDPluOI3Y4Y3xfPthxVdI
X-Gm-Message-State: AOJu0YxC7mRjSEt312EN7bl76ne1VRi3Oa1/8WqB8360Km6c92eFLl6j
	GXbnlKaqXFEfo5pZcckOeqg1PbJBaesPf3Q00ZLZ1zoRLZJ2ZeC1wbgD1b4qihtGndUPmxvq9FI
	qBBiYXw==
X-Google-Smtp-Source: AGHT+IHqv08Xeqxe2iF1yDdfWFz+qxIc0flbopKHrucZepi2C33PrG1v26T9/zvfy66hWpV8Zngn85t2bJIx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:200b:b0:dc8:27e6:cde1 with SMTP
 id dh11-20020a056902200b00b00dc827e6cde1mr1073935ybb.5.1711000823597; Wed, 20
 Mar 2024 23:00:23 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:04 -0700
Message-Id: <20240321060016.1464787-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 00/12] perf vendor events intel update
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update events to the latest on:
https://github.com/intel/perfmon

Using the converter script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Ian Rogers (12):
  perf vendor events intel: Update cascadelakex to 1.21
  perf vendor events intel: Update emeraldrapids to 1.06
  perf vendor events intel: Update grandridge to 1.02
  perf vendor events intel: Update icelakex to 1.24
  perf vendor events intel: Update lunarlake to 1.01
  perf vendor events intel: Update meteorlake to 1.08
  perf vendor events intel: Update sapphirerapids to 1.20
  perf vendor events intel: Update sierraforest to 1.02
  perf vendor events intel: Update skylakex to 1.33
  perf vendor events intel: Update skylake to v58
  perf vendor events intel: Update snowridgex to 1.22
  perf vendor events intel: Remove info metrics erroneously in TopdownL1

 .../arch/x86/broadwellx/bdx-metrics.json      |  35 +++---
 .../arch/x86/cascadelakex/clx-metrics.json    |  85 +++++--------
 .../arch/x86/cascadelakex/frontend.json       |  10 +-
 .../arch/x86/cascadelakex/memory.json         |   2 +-
 .../arch/x86/cascadelakex/other.json          |   2 +-
 .../arch/x86/cascadelakex/pipeline.json       |   2 +-
 .../x86/cascadelakex/uncore-interconnect.json |  14 +--
 .../arch/x86/cascadelakex/virtual-memory.json |   2 +-
 .../arch/x86/emeraldrapids/frontend.json      |   2 +-
 .../arch/x86/emeraldrapids/memory.json        |   1 +
 .../arch/x86/emeraldrapids/pipeline.json      |   3 +
 .../arch/x86/emeraldrapids/uncore-cache.json  | 112 ++++++++++++++++-
 .../emeraldrapids/uncore-interconnect.json    |  26 ++--
 .../arch/x86/grandridge/pipeline.json         |  43 ++++++-
 .../arch/x86/grandridge/uncore-cache.json     |  28 ++++-
 .../arch/x86/haswellx/hsx-metrics.json        |  35 +++---
 .../arch/x86/icelakex/frontend.json           |   2 +-
 .../arch/x86/icelakex/icx-metrics.json        |  95 ++++++--------
 .../pmu-events/arch/x86/icelakex/memory.json  |   1 +
 .../arch/x86/icelakex/uncore-cache.json       |  22 +++-
 .../x86/icelakex/uncore-interconnect.json     |  64 +++++-----
 .../arch/x86/icelakex/uncore-io.json          |  11 --
 .../pmu-events/arch/x86/lunarlake/cache.json  |  24 ++--
 .../arch/x86/lunarlake/frontend.json          |   2 +-
 .../pmu-events/arch/x86/lunarlake/memory.json |   4 +-
 .../pmu-events/arch/x86/lunarlake/other.json  |   4 +-
 .../arch/x86/lunarlake/pipeline.json          | 109 +++++++++++++---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  20 +--
 .../pmu-events/arch/x86/meteorlake/cache.json |  30 +++++
 .../arch/x86/meteorlake/frontend.json         |   4 +-
 .../arch/x86/meteorlake/memory.json           |  20 +++
 .../pmu-events/arch/x86/meteorlake/other.json |  42 ++++++-
 .../arch/x86/meteorlake/pipeline.json         |  44 +++++--
 .../x86/meteorlake/uncore-interconnect.json   |  22 +++-
 .../arch/x86/sapphirerapids/cache.json        |   1 +
 .../arch/x86/sapphirerapids/frontend.json     |   2 +-
 .../arch/x86/sapphirerapids/memory.json       |   1 +
 .../arch/x86/sapphirerapids/pipeline.json     |  19 +--
 .../arch/x86/sapphirerapids/spr-metrics.json  | 119 +++++++-----------
 .../arch/x86/sapphirerapids/uncore-cache.json | 112 ++++++++++++++++-
 .../sapphirerapids/uncore-interconnect.json   |  26 ++--
 .../arch/x86/sierraforest/pipeline.json       |  36 +++++-
 .../pmu-events/arch/x86/skylake/frontend.json |  10 +-
 .../pmu-events/arch/x86/skylakex/cache.json   |   9 ++
 .../arch/x86/skylakex/frontend.json           |  10 +-
 .../pmu-events/arch/x86/skylakex/memory.json  |   2 +-
 .../pmu-events/arch/x86/skylakex/other.json   |   2 +-
 .../arch/x86/skylakex/pipeline.json           |   2 +-
 .../arch/x86/skylakex/skx-metrics.json        |  85 +++++--------
 .../x86/skylakex/uncore-interconnect.json     |  14 +--
 .../arch/x86/skylakex/uncore-io.json          |   2 +-
 .../arch/x86/skylakex/virtual-memory.json     |   2 +-
 .../arch/x86/snowridgex/uncore-cache.json     |   4 +-
 .../x86/snowridgex/uncore-interconnect.json   |   6 +-
 .../arch/x86/snowridgex/uncore-io.json        |  11 --
 55 files changed, 911 insertions(+), 486 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


