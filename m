Return-Path: <linux-kernel+bounces-38745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1CA83C524
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549E61C230B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD246E2DB;
	Thu, 25 Jan 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW0TNtLa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529A4F209;
	Thu, 25 Jan 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194109; cv=none; b=Nu/4tvfQbG1/jFoD6HfaL/uxt7b/C2nqM86zfj0ua03t4vZHiuiaEwcaugMDOCGN0V5lgxruFb9DQ/Vk7Ioz9icer0BXq2MVyUzYxYcVrOIHQVPMOzrGnsEzPFMyFS7AFOdiFdDrNcULVUncmDkL0r4Sqh4BXufOf4HRdjWNTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194109; c=relaxed/simple;
	bh=spqCaUCwgind5qF3rdv4vTorSXO63Lqv5cjjfoCGhy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fk12uirKB/wZKWW6r/KMfhaYWZMr0T75iMWZB7BiRwmGrOkYLgH/tEoavP602i6r4ne0qVAUHhXnpou4nddGDfaITYM4ve6WKW7ErjssUngjRfDA8mTqmiz3YKJO13Nfp1q7TZpVMDrwWol8a3nngoAMj58bSWZvvNCL8/ff7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW0TNtLa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706194107; x=1737730107;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=spqCaUCwgind5qF3rdv4vTorSXO63Lqv5cjjfoCGhy8=;
  b=PW0TNtLaIo9uPmcWXxmYS6PUOc6XM382BajV2NyxIpttMK8mBSejnhIR
   h+DA1ESOElPKeLf6LrTuF+N/H7OBV/pPvIn0FfoxfUxODFzcEuo8y/maB
   +w0ahmE7ekka1V67Gggn/dspbBX89y2e2u5e/HLe9EdnggaYcdYAHUyt2
   yxZkJE6ok8TzqPlHfOr8YokwFbFCwYNNRMH/neg00tI/gAG3NA1w8QdTD
   fdTvTh+BdFm/y35znrAyMnUKYxC3vuGW3Lcs+c2Yp3A80wJMXjaqmBrhY
   TPnhloEDNME9zTJqmy6KBhFu1p31wdgP5COt/rqr1Ls1U+KXfpamno7m0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="2070134"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2070134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="910019714"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910019714"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:48:25 -0800
Received: from [10.209.135.136] (kliang2-mobl1.ccr.corp.intel.com [10.209.135.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 56A5E580CBC;
	Thu, 25 Jan 2024 06:48:23 -0800 (PST)
Message-ID: <31c90c4d-f6db-4f98-9b38-83260b0f8aa2@linux.intel.com>
Date: Thu, 25 Jan 2024 09:48:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf pmu: Treat the msr pmu as software
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang
 <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
References: <20240124234200.1510417-1-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240124234200.1510417-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-24 6:42 p.m., Ian Rogers wrote:
> The msr PMU is a software one, meaning msr events may be grouped
> with events in a hardware context. As the msr PMU isn't marked as a
> software PMU by perf_pmu__is_software, groups with the msr PMU in
> are broken and the msr events placed in a different group. This
> may lead to multiplexing errors where a hardware event isn't
> counted while the msr event, such as tsc, is. Fix all of this by
> marking the msr PMU as software, which agrees with the driver.

Yes, the MSR PMU is in SW context, perf_sw_context.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
> Before:
> ```
> $ perf stat -e '{slots,tsc}' -a true
> WARNING: events were regrouped to match PMUs
> 
>  Performance counter stats for 'system wide':
> 
>          1,750,335      slots
>          4,243,557      tsc
> 
>        0.001456717 seconds time elapsed
> ```
> 
> After:
> ```
> $ perf stat -e '{slots,tsc}' -a true
>  Performance counter stats for 'system wide':
> 
>         12,526,380      slots
>          3,415,163      tsc
> 
>        0.001488360 seconds time elapsed
> ```
> 
> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> The fixes tag is close enough rather than being fully accurate. The
> regression was introduced earlier by the automatic event regrouping.
> ---
>  tools/perf/util/pmu.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 3c9609944a2f..88b9aa7d3a27 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1760,6 +1760,12 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
>  
>  bool perf_pmu__is_software(const struct perf_pmu *pmu)
>  {
> +	const char *known_sw_pmus[] = {
> +		"kprobe",
> +		"msr",
> +		"uprobe",
> +	};
> +
>  	if (pmu->is_core || pmu->is_uncore || pmu->auxtrace)
>  		return false;
>  	switch (pmu->type) {
> @@ -1771,7 +1777,11 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
>  	case PERF_TYPE_BREAKPOINT:	return true;
>  	default: break;
>  	}
> -	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
> +	for (size_t i = 0; i < ARRAY_SIZE(known_sw_pmus); i++) {
> +		if (!strcmp(pmu->name, known_sw_pmus[i]))
> +			return true;
> +	}
> +	return false;
>  }
>  
>  FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)

