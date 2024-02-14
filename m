Return-Path: <linux-kernel+bounces-65448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32620854D31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA63C1F21529
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F75D8EF;
	Wed, 14 Feb 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEPyTDFE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6FB5FDD5;
	Wed, 14 Feb 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925505; cv=none; b=sIhQ3HivZBrZ/zDv6gL7PY8V/jN4P361wIVoxLcCBkY3/45PDPJLurBuM1eegJJnTddSh1ICJRe3Vbc9lviljmULtHewRnhnQ3y0bd5MN6UgIHNgGkNSBHY7NAIpXLjjlb7w4yFrMu/YsaseMSVkswLgYBapls/BieSDPxGRgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925505; c=relaxed/simple;
	bh=EL7E34S73VEyNjrDaB02lzU+jLe0zHK8Ab5PHjatrCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtvB0OmIq7LipwR+E/5sreIWe+avbTxcyzKntcDpUczFag3zSZ4v0tMoZX5vEIIK54vWpggy1Elfo/mKOv+7Z+woZOYcpbwGN+0toPIPKDrQ0SZYq5QScY2VmkjOai2allYHiZU1aTwGq6+JANYRTmyNt11s5u+Ev/D/aoRSTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEPyTDFE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707925504; x=1739461504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EL7E34S73VEyNjrDaB02lzU+jLe0zHK8Ab5PHjatrCI=;
  b=bEPyTDFEWF9XL2nFkoiXq4BfmZvLTAC3PZy1GxNaOzLOmmZf0QlOlpxf
   uHwaxoU6eDDuaB3oRXYC5FfO/pdp1Le+1QJfrs+YA5W7LwQNOJMUXTgw5
   zfHC0A8Otiuv0YkkHaLkIUUAusWAnIEVv7XeFTWAhYHTpe+UsR6ZQ24Wl
   y700oTA2Qnue/0T18e9EWSGnnk2IYzChj3JtYArury5WEbMSWj5hm6SwO
   0fsAG/vdftzyJ2vn/nhXIUD4A+YnzgIG/QRq5OpDjBVpi5MNEFrDFwrGm
   wyyipLJWZSfZD/jqQTsLTb9qbNUNZhN9hpmtEiYBckDZT4HHdb34dO/Tp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5805266"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5805266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:45:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3218446"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:45:02 -0800
Received: from [10.212.64.118] (kliang2-mobl1.ccr.corp.intel.com [10.212.64.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 89CA95804CF;
	Wed, 14 Feb 2024 07:44:59 -0800 (PST)
Message-ID: <192acf18-ffcb-4e18-97e2-d843dc5f346c@linux.intel.com>
Date: Wed, 14 Feb 2024 10:44:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/30] perf vendor event and TMA 4.7 metric update
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Perry Taylor <perry.taylor@intel.com>, Samantha Alt
 <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Cc: Stephane Eranian <eranian@google.com>
References: <20240214011820.644458-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-13 8:17 p.m., Ian Rogers wrote:
> The first 12 patches update vendor events to those in:
> https://github.com/intel/perfmon
> 
> The next 18 patches update the TMA metrics from version 4.5 to version
> 4.7. This includes improvements to many models like the
> tma_info_bottleneck* metrics, an abstraction or summarization of the
> 100+ TMA tree nodes into 12-entry familiar performance metrics.
> 
> The update was possible due to the release of TMA 4.7 metrics in:
>   https://github.com/intel/perfmon/pull/140
>   https://github.com/intel/perfmon/pull/138
> 
> Pull request:
> https://github.com/intel/perfmon/pull/144
> was applied to the converter script. This PR adds back CORE_CLKS as in
> TMA metrics 4.5 for pre-Icelake models. This avoids an issue running
> perf stat not in system wide mode where pre-Icelake models need to
> scale the slots dependent on what the other hyperthread is doing (via
> the event CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE - later models have a
> slots counter for this). This is a known not accurate thing to do,
> hence the removal from TMA 4.7, but perf would allow the use of the
> metric not in system wide mode and report a metric with value. It
> seemed better to give a more accurate number in not system wide mode,
> possibly induce multiplexing, and have the TMA 4.5 behavior. We can
> later update the behavior to be NaN [1] when not in system wide mode
> to avoid broken usage. The not system wide mode in the TMA 4.5
> spreadsheet is known as "#EBS_Mode" and is detected in perf json with
> the "#core_wide" literal.
> 
> [1] https://lore.kernel.org/lkml/20240209204947.3873294-2-irogers@google.com/
> 
> Ian Rogers (30):
>   perf vendor events intel: Update alderlake events to v1.24
>   perf vendor events intel: Update alderlaken events to v1.24
>   perf vendor events intel: Update broadwell events to v29
>   perf vendor events intel: Update emeraldrapids events to v1.03
>   perf vendor events intel: Update grandridge events to v1.01
>   perf vendor events intel: Update haswell events to v35
>   perf vendor events intel: Update icelake events to v1.21
>   perf vendor events intel: Update meteorlake events to v1.07
>   perf vendor events intel: Update rocketlake events to v1.02
>   perf vendor events intel: Update sierraforst events to v1.01
>   perf vendor events intel: Update skylake events to v58
>   perf vendor events intel: Update tigerlake events to v1.15
>   perf vendor events intel: Update alderlake TMA metrics to 4.7
>   perf vendor events intel: Update broadwell TMA metrics to 4.7
>   perf vendor events intel: Update broadwellde TMA metrics to 4.7
>   perf vendor events intel: Update broadwellx TMA metrics to 4.7
>   perf vendor events intel: Update cascadelakex TMA metrics to 4.7
>   perf vendor events intel: Update haswell TMA metrics to 4.7
>   perf vendor events intel: Update haswellx TMA metrics to 4.7
>   perf vendor events intel: Update icelake TMA metrics to 4.7
>   perf vendor events intel: Update icelakex TMA metrics to 4.7
>   perf vendor events intel: Update ivybridge TMA metrics to 4.7
>   perf vendor events intel: Update ivytown TMA metrics to 4.7
>   perf vendor events intel: Update jaketown TMA metrics to 4.7
>   perf vendor events intel: Update rocketlake TMA metrics to 4.7
>   perf vendor events intel: Update sandybridge TMA metrics to 4.7
>   perf vendor events intel: Update sapphirerapids TMA metrics to 4.7
>   perf vendor events intel: Update skylake TMA metrics to 4.7
>   perf vendor events intel: Update skylakex TMA metrics to 4.7
>   perf vendor events intel: Update tigerlake TMA metrics to 4.7
> 

Thanks Ian!

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
>  .../arch/x86/alderlake/adl-metrics.json       |  459 ++-
>  .../arch/x86/alderlake/floating-point.json    |   30 +-
>  .../arch/x86/alderlake/metricgroups.json      |   11 +-
>  .../pmu-events/arch/x86/alderlake/other.json  |   10 +
>  .../arch/x86/alderlake/pipeline.json          |   13 +
>  .../pmu-events/arch/x86/alderlaken/other.json |    9 +
>  .../arch/x86/alderlaken/pipeline.json         |    9 +
>  .../arch/x86/broadwell/bdw-metrics.json       |  204 +-
>  .../pmu-events/arch/x86/broadwell/memory.json |    2 +-
>  .../arch/x86/broadwell/metricgroups.json      |    7 +-
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  191 +-
>  .../arch/x86/broadwellde/metricgroups.json    |    7 +-
>  .../arch/x86/broadwellx/bdx-metrics.json      |  250 +-
>  .../arch/x86/broadwellx/metricgroups.json     |    7 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    |  566 +++-
>  .../arch/x86/cascadelakex/metricgroups.json   |   12 +-
>  .../arch/x86/emeraldrapids/uncore-cache.json  |  152 +
>  .../pmu-events/arch/x86/grandridge/cache.json |  185 ++
>  .../arch/x86/grandridge/floating-point.json   |   68 +
>  .../arch/x86/grandridge/frontend.json         |   16 +
>  .../arch/x86/grandridge/memory.json           |   66 +
>  .../pmu-events/arch/x86/grandridge/other.json |   16 +
>  .../arch/x86/grandridge/pipeline.json         |  353 ++
>  .../arch/x86/grandridge/uncore-cache.json     | 1795 +++++++++++
>  .../x86/grandridge/uncore-interconnect.json   |  175 +
>  .../arch/x86/grandridge/uncore-io.json        | 1187 +++++++
>  .../arch/x86/grandridge/uncore-memory.json    |  385 +++
>  .../arch/x86/grandridge/uncore-power.json     |   10 +
>  .../arch/x86/grandridge/virtual-memory.json   |  113 +-
>  .../arch/x86/haswell/hsw-metrics.json         |  178 +-
>  .../pmu-events/arch/x86/haswell/memory.json   |    2 +-
>  .../arch/x86/haswell/metricgroups.json        |    7 +-
>  .../arch/x86/haswellx/hsx-metrics.json        |  224 +-
>  .../arch/x86/haswellx/metricgroups.json       |    7 +-
>  .../arch/x86/icelake/icl-metrics.json         |  398 ++-
>  .../pmu-events/arch/x86/icelake/memory.json   |    1 +
>  .../arch/x86/icelake/metricgroups.json        |   12 +-
>  .../pmu-events/arch/x86/icelake/other.json    |    2 +-
>  .../pmu-events/arch/x86/icelake/pipeline.json |   10 +-
>  .../arch/x86/icelakex/icx-metrics.json        |  586 +++-
>  .../arch/x86/icelakex/metricgroups.json       |   12 +-
>  .../arch/x86/ivybridge/ivb-metrics.json       |  197 +-
>  .../arch/x86/ivybridge/metricgroups.json      |    7 +-
>  .../arch/x86/ivytown/ivt-metrics.json         |  200 +-
>  .../arch/x86/ivytown/metricgroups.json        |    7 +-
>  .../arch/x86/jaketown/jkt-metrics.json        |   64 +-
>  .../arch/x86/jaketown/metricgroups.json       |    7 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   24 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |    8 +-
>  .../arch/x86/meteorlake/floating-point.json   |   86 +-
>  .../pmu-events/arch/x86/meteorlake/other.json |   10 +
>  .../arch/x86/meteorlake/pipeline.json         |   76 +
>  .../arch/x86/meteorlake/virtual-memory.json   |   36 +
>  .../arch/x86/rocketlake/memory.json           |    1 +
>  .../arch/x86/rocketlake/metricgroups.json     |   12 +-
>  .../pmu-events/arch/x86/rocketlake/other.json |    2 +-
>  .../arch/x86/rocketlake/pipeline.json         |   10 +-
>  .../arch/x86/rocketlake/rkl-metrics.json      |  406 ++-
>  .../arch/x86/sandybridge/metricgroups.json    |    7 +-
>  .../arch/x86/sandybridge/snb-metrics.json     |   71 +-
>  .../arch/x86/sapphirerapids/metricgroups.json |   12 +-
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  773 +++--
>  .../arch/x86/sierraforest/cache.json          |  185 ++
>  .../arch/x86/sierraforest/floating-point.json |   68 +
>  .../arch/x86/sierraforest/frontend.json       |   16 +
>  .../arch/x86/sierraforest/memory.json         |   66 +
>  .../arch/x86/sierraforest/other.json          |   16 +
>  .../arch/x86/sierraforest/pipeline.json       |  360 +++
>  .../arch/x86/sierraforest/uncore-cache.json   | 2853 +++++++++++++++++
>  .../arch/x86/sierraforest/uncore-cxl.json     |   10 +
>  .../x86/sierraforest/uncore-interconnect.json | 1228 +++++++
>  .../arch/x86/sierraforest/uncore-io.json      | 1634 ++++++++++
>  .../arch/x86/sierraforest/uncore-memory.json  |  385 +++
>  .../arch/x86/sierraforest/uncore-power.json   |   10 +
>  .../arch/x86/sierraforest/virtual-memory.json |  113 +-
>  .../pmu-events/arch/x86/skylake/memory.json   |    2 +-
>  .../arch/x86/skylake/metricgroups.json        |   12 +-
>  .../pmu-events/arch/x86/skylake/pipeline.json |    2 +-
>  .../arch/x86/skylake/skl-metrics.json         |  395 ++-
>  .../arch/x86/skylake/virtual-memory.json      |    2 +-
>  .../arch/x86/skylakex/metricgroups.json       |   12 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  548 +++-
>  .../arch/x86/tigerlake/metricgroups.json      |   12 +-
>  .../pmu-events/arch/x86/tigerlake/other.json  |    2 +-
>  .../arch/x86/tigerlake/pipeline.json          |   10 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  406 ++-
>  .../x86/tigerlake/uncore-interconnect.json    |    2 +
>  87 files changed, 15763 insertions(+), 2349 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-power.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json
> 

