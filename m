Return-Path: <linux-kernel+bounces-85683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9C86B93B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8021B247A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34D15A4A6;
	Wed, 28 Feb 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeObH4pX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA25E077;
	Wed, 28 Feb 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153187; cv=none; b=cb0CC2CEr80BranG/jslFmxsg0hJhY1rSur0I83Wjyb7F3vsGYud1mR992GGa8rvTBn45xkb34T2DTLiCa0dlB/rCiLPiypjBasVZeeQwTZIyXOOCbhpVBpqvveOamw217GqvG7XWha4Hq5JlHIi98EcpKvmz3Q2U1EmrDAVfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153187; c=relaxed/simple;
	bh=XkITRX+vWnE/eg/4GvdQz5amNPo2xGCgZAEIC7zClWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e33wbHowUfmXw9qPBByyv/9HcOvdtx0biUkDh1v2yyHkafVfDgBqo0qD8D+nmDwjO2Ki1cw9WF0j6W7Pr5ngDaXsKgYzRS7aoEurA13AVzX+oK18tXLrBA68cjnzW3xVikSk5Q7Jq/Z3smE1AUwtHb2HRrpeOu92lB3EK9eNQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeObH4pX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153185; x=1740689185;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XkITRX+vWnE/eg/4GvdQz5amNPo2xGCgZAEIC7zClWQ=;
  b=VeObH4pXj4NoAISE2RzpI/C2U+nApEtgTpDWkOrqfx8B/OnWqtzi+O+d
   cMNOkcNTxMbyOg406HHl9XBgdG02o8Ldt9Vo11Nz4XDV4qeGvemw+YrSx
   4xif7UaOUcr5iVJdLRx8Y1RmqUQkpavL7BKT3SvA1truKTZV6H14pB5/h
   pCATubqvRYAoBfRVxVK8u2P5np7rXTT0HmCrd3CHa8KPkGkbMpNmryet3
   8sesIVYOSCTqSA/S/pVtR6tVa0R8Hg5y+14rbiCdfmoHTTnDjC+ADBYGb
   60XcuP/Q9hM0WU6ywgWeyk5O9u6gxpV9Lgi2tle+SXtzgJE+aVBdodnBJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7415583"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7415583"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:46:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7677401"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:46:24 -0800
Received: from [10.212.115.214] (kliang2-mobl1.ccr.corp.intel.com [10.212.115.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 49A35580D7F;
	Wed, 28 Feb 2024 12:46:22 -0800 (PST)
Message-ID: <36449491-c17b-4d85-a1a0-f5101bdb42e7@linux.intel.com>
Date: Wed, 28 Feb 2024 15:46:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf vendor events intel: Add umasks/occ_sel to PCU
 events.
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240228170529.4035675-1-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240228170529.4035675-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-28 12:05 p.m., Ian Rogers wrote:
> UMasks were being dropped leading to all PCU
> UNC_P_POWER_STATE_OCCUPANCY events having the same encoding. Don't
> drop the umask trying to be consistent with other sources of events
> like libpfm4 [1]. Older models need to use occ_sel rather than umask,
> correct these values too. This applies the change from [2].
> 
> [1] https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/events/intel_skx_unc_pcu_events.h#l30
> [2] https://github.com/captain5050/perfmon/commit/cbd4aee81023e5bfa09677b1ce170ff69e9c423d
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2 corrects BDW-DE, BDX, HSX and JKT to not use umask but occ_sel.

Thanks Ian for the fix.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json  | 3 +++
>  tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json   | 3 +++
>  tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json | 3 +++
>  tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json     | 3 +++
>  tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json     | 3 +++
>  tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json      | 3 +++
>  tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json     | 3 +++
>  tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json     | 3 +++
>  tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json   | 3 +++
>  9 files changed, 27 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> index 83d20130c217..320aaab53a0b 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> @@ -394,6 +394,7 @@
>          "BriefDescription": "Number of cores in C-State; C0 and C1",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> +        "Filter": "occ_sel=1",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -402,6 +403,7 @@
>          "BriefDescription": "Number of cores in C-State; C3",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> +        "Filter": "occ_sel=2",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -410,6 +412,7 @@
>          "BriefDescription": "Number of cores in C-State; C6 and C7",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> +        "Filter": "occ_sel=3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> index 83d20130c217..320aaab53a0b 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> @@ -394,6 +394,7 @@
>          "BriefDescription": "Number of cores in C-State; C0 and C1",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> +        "Filter": "occ_sel=1",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -402,6 +403,7 @@
>          "BriefDescription": "Number of cores in C-State; C3",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> +        "Filter": "occ_sel=2",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -410,6 +412,7 @@
>          "BriefDescription": "Number of cores in C-State; C6 and C7",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> +        "Filter": "occ_sel=3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> index c6254af7a468..ceef46046488 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> @@ -144,6 +144,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -152,6 +153,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -160,6 +162,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> index daebf1050acb..c391325ee36b 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> @@ -426,6 +426,7 @@
>          "BriefDescription": "Number of cores in C-State; C0 and C1",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> +        "Filter": "occ_sel=1",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -434,6 +435,7 @@
>          "BriefDescription": "Number of cores in C-State; C3",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> +        "Filter": "occ_sel=2",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -442,6 +444,7 @@
>          "BriefDescription": "Number of cores in C-State; C6 and C7",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> +        "Filter": "occ_sel=3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> index ee4dac6fc797..920cab6ffe37 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> @@ -151,6 +151,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "Number of cores in C-State : C0 and C1 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -159,6 +160,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "Number of cores in C-State : C3 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -167,6 +169,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "Number of cores in C-State : C6 and C7 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> index 5df1ebfb89ea..ad6c531a9e38 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> @@ -514,6 +514,7 @@
>          "BriefDescription": "Number of cores in C-State; C0 and C1",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> +        "Filter": "occ_sel=1",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -522,6 +523,7 @@
>          "BriefDescription": "Number of cores in C-State; C3",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> +        "Filter": "occ_sel=2",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -530,6 +532,7 @@
>          "BriefDescription": "Number of cores in C-State; C6 and C7",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> +        "Filter": "occ_sel=3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> index b3ee5d741015..6f98fc1728e6 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> @@ -233,6 +233,7 @@
>          "BriefDescription": "Number of cores in C0",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> +        "Filter": "occ_sel=1",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -241,6 +242,7 @@
>          "BriefDescription": "Number of cores in C0",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> +        "Filter": "occ_sel=2",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> @@ -249,6 +251,7 @@
>          "BriefDescription": "Number of cores in C0",
>          "EventCode": "0x80",
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> +        "Filter": "occ_sel=3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>          "Unit": "PCU"
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> index c6254af7a468..ceef46046488 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> @@ -144,6 +144,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -152,6 +153,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -160,6 +162,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> index a61ffca2dfea..dcf268467db9 100644
> --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> @@ -150,6 +150,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "Number of cores in C-State : C0 and C1 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -158,6 +159,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "Number of cores in C-State : C3 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -166,6 +168,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "Number of cores in C-State : C6 and C7 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {

