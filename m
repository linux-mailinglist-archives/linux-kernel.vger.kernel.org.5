Return-Path: <linux-kernel+bounces-64631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BB85410E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18762816BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2A4687;
	Wed, 14 Feb 2024 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3C/LG3GH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE8625
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873519; cv=none; b=Vb5Rxw19IN8uSgJVEcM0GWlALNi3Wl6nAq4X2hLXJaWNJIXNaksRTRs19XoW3I5DZ4HahPjGQ5C2WqSAjkDMf5V2sF8ncbl3JCcZPLNCSvVWduIcjrz+cuzD5XMVEYDiGpHrc3rvZF3U4iV7+aHBnie5addo1yz68uOMPuh4qHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873519; c=relaxed/simple;
	bh=epHuE807hPFjopcGUsovj1cnL5FusHEi3EywIX1rQOw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=nWPElyldo+KHSvk4Y0cgPEyhorM8YnMHkZGnKsoOgNQSQMtVRjdP5Uh/M8iOZlXnwaFJ0tDSORAKZgYXk8o+DtcjRbmI8CgTAPMTx+uwBIR5utgEdeKLT4Jl4pkBnDrhFHG+cvPDUIflSuaVE9y+8AY3EZvL0SuerIu0Ueg0cTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3C/LG3GH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047f0741e2so79564087b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873516; x=1708478316; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EHeQ9WuBVlbffpEI823a/N9bWAJYf9ReXQIyFsgpsok=;
        b=3C/LG3GHGfVqcPM3IyOIiazgWYRUIyzh5CTyBE8LorzfjofJeVAP8Y2iVrYJFOHrUu
         7NOI2efzr+pEYXHViOLvDCSbV4N3HPu+evM1gSmQGAJobPZhkN1SevoJRBD8a9bat93p
         5ezgZQdbh9BkO8YrGTLGv2u2QMm+OHc585lGB2hOhoP9IHMVVgpwXJ4Ok5XxIHxivy7y
         aLQFNjRB2Tz5YJyBPMLsStXxlUVG+hnJ7z5yXCWnSHQjnqwkcVth46NdcygTWKQDGxp4
         btvv1bx7bwKNggbIOwkCeUlwOozsDBztoviDXr6LRIHwOW78Z4u1JWHtPju6koaALjdD
         U+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873516; x=1708478316;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHeQ9WuBVlbffpEI823a/N9bWAJYf9ReXQIyFsgpsok=;
        b=X6kHsvI1LvId2yibeFG8jyjBScE07oWVVTQ9BbotAocxD/7en/nnFQP2p48kokqS1c
         Dbe1V42ulFIG6/H22KbNv3xvN0RkzOzhIiTukMM+p+tsHCJTdOh9t41MDxKhv4U7hJ1J
         67R51OPMpnxOqyDeSTmDVqNcz4Yt4AYmGfI0vKlg+lRrUA8GsCgw3QHETpzkxY4z45R/
         MGa2BYiI1zrovTcyxKPLlTOVmnXDGKeuPteIYAVi+TNSHrLNwJUGEYiexWwhNIlt0KOp
         pASJGAaIHYn7QMifr1yDSr1GgMNzmAhO/KPG44d5XQOxQC4T9aF11H28mj6bDnAtIHz2
         TWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlvAUjM76oPhlsi9Y+72GFrNj2CqkOf9V4fhDZkjkIxYG2g6KYyK9asE1gy5jpW2EysBSCSi9V471Is/gJEWeOqBBDnz6wim6HxdXm
X-Gm-Message-State: AOJu0YySpD3PjpZa0XNxcZmEcK70XaXHZV8awOMl948iCrXZSuzivq+s
	cAFIIHZE2VtECkeD4ZCsk+vbDDJ1cs68nYXiwa86lBhk0Acg+aKt8dBiBD59URgqs3o1Xbyo2fk
	4Zbh+oQ==
X-Google-Smtp-Source: AGHT+IGcg4/EyCOOKMrRrRls8S6gHHgBHX82LEKyoua1JKPzwG6A5Bl+9IxxqLEIZ8qHaQUFe5Ou4UCrDCAW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:82:b0:dc7:9218:df3b with SMTP id
 h2-20020a056902008200b00dc79218df3bmr52400ybs.10.1707873516405; Tue, 13 Feb
 2024 17:18:36 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:49 -0800
Message-Id: <20240214011820.644458-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 00/30] perf vendor event and TMA 4.7 metric update
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The first 12 patches update vendor events to those in:
https://github.com/intel/perfmon

The next 18 patches update the TMA metrics from version 4.5 to version
4.7. This includes improvements to many models like the
tma_info_bottleneck* metrics, an abstraction or summarization of the
100+ TMA tree nodes into 12-entry familiar performance metrics.

The update was possible due to the release of TMA 4.7 metrics in:
  https://github.com/intel/perfmon/pull/140
  https://github.com/intel/perfmon/pull/138

Pull request:
https://github.com/intel/perfmon/pull/144
was applied to the converter script. This PR adds back CORE_CLKS as in
TMA metrics 4.5 for pre-Icelake models. This avoids an issue running
perf stat not in system wide mode where pre-Icelake models need to
scale the slots dependent on what the other hyperthread is doing (via
the event CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE - later models have a
slots counter for this). This is a known not accurate thing to do,
hence the removal from TMA 4.7, but perf would allow the use of the
metric not in system wide mode and report a metric with value. It
seemed better to give a more accurate number in not system wide mode,
possibly induce multiplexing, and have the TMA 4.5 behavior. We can
later update the behavior to be NaN [1] when not in system wide mode
to avoid broken usage. The not system wide mode in the TMA 4.5
spreadsheet is known as "#EBS_Mode" and is detected in perf json with
the "#core_wide" literal.

[1] https://lore.kernel.org/lkml/20240209204947.3873294-2-irogers@google.com/

Ian Rogers (30):
  perf vendor events intel: Update alderlake events to v1.24
  perf vendor events intel: Update alderlaken events to v1.24
  perf vendor events intel: Update broadwell events to v29
  perf vendor events intel: Update emeraldrapids events to v1.03
  perf vendor events intel: Update grandridge events to v1.01
  perf vendor events intel: Update haswell events to v35
  perf vendor events intel: Update icelake events to v1.21
  perf vendor events intel: Update meteorlake events to v1.07
  perf vendor events intel: Update rocketlake events to v1.02
  perf vendor events intel: Update sierraforst events to v1.01
  perf vendor events intel: Update skylake events to v58
  perf vendor events intel: Update tigerlake events to v1.15
  perf vendor events intel: Update alderlake TMA metrics to 4.7
  perf vendor events intel: Update broadwell TMA metrics to 4.7
  perf vendor events intel: Update broadwellde TMA metrics to 4.7
  perf vendor events intel: Update broadwellx TMA metrics to 4.7
  perf vendor events intel: Update cascadelakex TMA metrics to 4.7
  perf vendor events intel: Update haswell TMA metrics to 4.7
  perf vendor events intel: Update haswellx TMA metrics to 4.7
  perf vendor events intel: Update icelake TMA metrics to 4.7
  perf vendor events intel: Update icelakex TMA metrics to 4.7
  perf vendor events intel: Update ivybridge TMA metrics to 4.7
  perf vendor events intel: Update ivytown TMA metrics to 4.7
  perf vendor events intel: Update jaketown TMA metrics to 4.7
  perf vendor events intel: Update rocketlake TMA metrics to 4.7
  perf vendor events intel: Update sandybridge TMA metrics to 4.7
  perf vendor events intel: Update sapphirerapids TMA metrics to 4.7
  perf vendor events intel: Update skylake TMA metrics to 4.7
  perf vendor events intel: Update skylakex TMA metrics to 4.7
  perf vendor events intel: Update tigerlake TMA metrics to 4.7

 .../arch/x86/alderlake/adl-metrics.json       |  459 ++-
 .../arch/x86/alderlake/floating-point.json    |   30 +-
 .../arch/x86/alderlake/metricgroups.json      |   11 +-
 .../pmu-events/arch/x86/alderlake/other.json  |   10 +
 .../arch/x86/alderlake/pipeline.json          |   13 +
 .../pmu-events/arch/x86/alderlaken/other.json |    9 +
 .../arch/x86/alderlaken/pipeline.json         |    9 +
 .../arch/x86/broadwell/bdw-metrics.json       |  204 +-
 .../pmu-events/arch/x86/broadwell/memory.json |    2 +-
 .../arch/x86/broadwell/metricgroups.json      |    7 +-
 .../arch/x86/broadwellde/bdwde-metrics.json   |  191 +-
 .../arch/x86/broadwellde/metricgroups.json    |    7 +-
 .../arch/x86/broadwellx/bdx-metrics.json      |  250 +-
 .../arch/x86/broadwellx/metricgroups.json     |    7 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  566 +++-
 .../arch/x86/cascadelakex/metricgroups.json   |   12 +-
 .../arch/x86/emeraldrapids/uncore-cache.json  |  152 +
 .../pmu-events/arch/x86/grandridge/cache.json |  185 ++
 .../arch/x86/grandridge/floating-point.json   |   68 +
 .../arch/x86/grandridge/frontend.json         |   16 +
 .../arch/x86/grandridge/memory.json           |   66 +
 .../pmu-events/arch/x86/grandridge/other.json |   16 +
 .../arch/x86/grandridge/pipeline.json         |  353 ++
 .../arch/x86/grandridge/uncore-cache.json     | 1795 +++++++++++
 .../x86/grandridge/uncore-interconnect.json   |  175 +
 .../arch/x86/grandridge/uncore-io.json        | 1187 +++++++
 .../arch/x86/grandridge/uncore-memory.json    |  385 +++
 .../arch/x86/grandridge/uncore-power.json     |   10 +
 .../arch/x86/grandridge/virtual-memory.json   |  113 +-
 .../arch/x86/haswell/hsw-metrics.json         |  178 +-
 .../pmu-events/arch/x86/haswell/memory.json   |    2 +-
 .../arch/x86/haswell/metricgroups.json        |    7 +-
 .../arch/x86/haswellx/hsx-metrics.json        |  224 +-
 .../arch/x86/haswellx/metricgroups.json       |    7 +-
 .../arch/x86/icelake/icl-metrics.json         |  398 ++-
 .../pmu-events/arch/x86/icelake/memory.json   |    1 +
 .../arch/x86/icelake/metricgroups.json        |   12 +-
 .../pmu-events/arch/x86/icelake/other.json    |    2 +-
 .../pmu-events/arch/x86/icelake/pipeline.json |   10 +-
 .../arch/x86/icelakex/icx-metrics.json        |  586 +++-
 .../arch/x86/icelakex/metricgroups.json       |   12 +-
 .../arch/x86/ivybridge/ivb-metrics.json       |  197 +-
 .../arch/x86/ivybridge/metricgroups.json      |    7 +-
 .../arch/x86/ivytown/ivt-metrics.json         |  200 +-
 .../arch/x86/ivytown/metricgroups.json        |    7 +-
 .../arch/x86/jaketown/jkt-metrics.json        |   64 +-
 .../arch/x86/jaketown/metricgroups.json       |    7 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   24 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |    8 +-
 .../arch/x86/meteorlake/floating-point.json   |   86 +-
 .../pmu-events/arch/x86/meteorlake/other.json |   10 +
 .../arch/x86/meteorlake/pipeline.json         |   76 +
 .../arch/x86/meteorlake/virtual-memory.json   |   36 +
 .../arch/x86/rocketlake/memory.json           |    1 +
 .../arch/x86/rocketlake/metricgroups.json     |   12 +-
 .../pmu-events/arch/x86/rocketlake/other.json |    2 +-
 .../arch/x86/rocketlake/pipeline.json         |   10 +-
 .../arch/x86/rocketlake/rkl-metrics.json      |  406 ++-
 .../arch/x86/sandybridge/metricgroups.json    |    7 +-
 .../arch/x86/sandybridge/snb-metrics.json     |   71 +-
 .../arch/x86/sapphirerapids/metricgroups.json |   12 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  |  773 +++--
 .../arch/x86/sierraforest/cache.json          |  185 ++
 .../arch/x86/sierraforest/floating-point.json |   68 +
 .../arch/x86/sierraforest/frontend.json       |   16 +
 .../arch/x86/sierraforest/memory.json         |   66 +
 .../arch/x86/sierraforest/other.json          |   16 +
 .../arch/x86/sierraforest/pipeline.json       |  360 +++
 .../arch/x86/sierraforest/uncore-cache.json   | 2853 +++++++++++++++++
 .../arch/x86/sierraforest/uncore-cxl.json     |   10 +
 .../x86/sierraforest/uncore-interconnect.json | 1228 +++++++
 .../arch/x86/sierraforest/uncore-io.json      | 1634 ++++++++++
 .../arch/x86/sierraforest/uncore-memory.json  |  385 +++
 .../arch/x86/sierraforest/uncore-power.json   |   10 +
 .../arch/x86/sierraforest/virtual-memory.json |  113 +-
 .../pmu-events/arch/x86/skylake/memory.json   |    2 +-
 .../arch/x86/skylake/metricgroups.json        |   12 +-
 .../pmu-events/arch/x86/skylake/pipeline.json |    2 +-
 .../arch/x86/skylake/skl-metrics.json         |  395 ++-
 .../arch/x86/skylake/virtual-memory.json      |    2 +-
 .../arch/x86/skylakex/metricgroups.json       |   12 +-
 .../arch/x86/skylakex/skx-metrics.json        |  548 +++-
 .../arch/x86/tigerlake/metricgroups.json      |   12 +-
 .../pmu-events/arch/x86/tigerlake/other.json  |    2 +-
 .../arch/x86/tigerlake/pipeline.json          |   10 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  406 ++-
 .../x86/tigerlake/uncore-interconnect.json    |    2 +
 87 files changed, 15763 insertions(+), 2349 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json

-- 
2.43.0.687.g38aa6559b0-goog


