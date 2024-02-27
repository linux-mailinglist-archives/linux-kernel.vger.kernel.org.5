Return-Path: <linux-kernel+bounces-83379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692CF869694
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBE1C22F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86982145356;
	Tue, 27 Feb 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAFdtEfh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4313EFE4;
	Tue, 27 Feb 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043181; cv=none; b=IgqhNBA9YaopU2L40epkWQ48pmlMYLxhQPHr01Pb2tXyBU/5Ke9cyr23LRM5mAsTp42tf+cTB/9OWHF4bSLj1MxaAY2ngAlhp91AmUfHOF8jmxaAbUEolalEVNwns/OtlCF58C26kDAD2HqWtlsT7zCulD+FSieawnFYx2ja1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043181; c=relaxed/simple;
	bh=ZsjCkBtNP45Qq3VHR5aYMGjQ1PM8MVvWTnRPbDrdEjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JxN1ZrSkubhQuwrldtXA6pmX1iXYwJHEdMZjePeImPFoXxdqa5JAnlSBRjSmYcCKwhezTMV42XRSMACmls/rnlxxTcV5JiibHzOt2A5jIO47+xRHNgaJvg8gbJ5kr2yRpcemeRGiBKRh2mOkQ+CQOfTr19FMf2sU5nTD0O6xnM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAFdtEfh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709043179; x=1740579179;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ZsjCkBtNP45Qq3VHR5aYMGjQ1PM8MVvWTnRPbDrdEjQ=;
  b=NAFdtEfhQ3D5n23aFNZ9QB1/ITAfl/UqmRKUv7FXjJe0NBwa/mYbnOBc
   9FdjFpsWCRnoDxhHNy7A4rgBxypG9qnnnlr/9Bwl9+r4tkxubeDdAEQvu
   Tq1/DT+MOBorLfQNMRSS/Nzsa2NjX6cH7Emmesqb65ynACFx/70WxPkEq
   SAMprRHLlGjN2HpZOTnJRSLxMTiYr1Pec111r3ubbqjnqMHgeuZmq7GSQ
   /MbPQ1H+yULCsKLWATrn/iZHCRp4drQgMYssHygog5r3FWF624ZWB40OV
   IShxYTxHs2hp48xsq3OHFVE9N1eGsCjQRP7KiWEnldlwMwS/EFTf8104c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25848673"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="25848673"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="11656581"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:12:57 -0800
Received: from [10.212.111.188] (jdharan-MOBL1.amr.corp.intel.com [10.212.111.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C8DBE580B9A;
	Tue, 27 Feb 2024 06:12:55 -0800 (PST)
Message-ID: <0b2ff06f-099c-424a-97b5-fdf638892e41@linux.intel.com>
Date: Tue, 27 Feb 2024 09:12:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf vendor events intel: Add umasks to PCU events.
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226201517.3540187-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240226201517.3540187-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-26 3:15 p.m., Ian Rogers wrote:
> UMasks were being dropped leading to all PCU
> UNC_P_POWER_STATE_OCCUPANCY events having the same encoding. Don't
> drop the umask trying to be consistent with other sources of events
> like libpfm4 [1]. This applies the change from [2].
> 
> [1] https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/events/intel_skx_unc_pcu_events.h#l30
> [2] https://github.com/captain5050/perfmon/commit/661a229996493448095fb55415ed568ceabc631b
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

Thanks Ian.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

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
> index 83d20130c217..9a0bc34c08e1 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> @@ -396,6 +396,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -404,6 +405,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -412,6 +414,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> index 83d20130c217..9a0bc34c08e1 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> @@ -396,6 +396,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -404,6 +405,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -412,6 +414,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {
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
> index daebf1050acb..15097511cbd8 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> @@ -428,6 +428,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -436,6 +437,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -444,6 +446,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {
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
> index 5df1ebfb89ea..4dac5810324b 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> @@ -516,6 +516,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -524,6 +525,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -532,6 +534,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> index b3ee5d741015..a83e07dce947 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> @@ -235,6 +235,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x40",
>          "Unit": "PCU"
>      },
>      {
> @@ -243,6 +244,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0x80",
>          "Unit": "PCU"
>      },
>      {
> @@ -251,6 +253,7 @@
>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>          "PerPkg": "1",
>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
> +        "UMask": "0xc0",
>          "Unit": "PCU"
>      },
>      {
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

