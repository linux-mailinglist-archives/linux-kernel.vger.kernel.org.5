Return-Path: <linux-kernel+bounces-87562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B715086D5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470ABB2586B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE417144036;
	Thu, 29 Feb 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8vbRf1r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67328143724;
	Thu, 29 Feb 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240953; cv=none; b=rrgHH70a8tTGEvasTO/7sH7tY9S+pE8WYXAhu6/vKkAaf3kFgfm2cg0V5Qgsx/pR9GKjW0ckPdAIthEb/gn6MAdAwjyZSFkIIFQasLMGEjwzl0CZT367S+SdEJAmmMhYAuXy+CIDw/yOszFqF8ET5d1gU/bwRofSmf1N00mVnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240953; c=relaxed/simple;
	bh=vI3JErcIXK8PkI3jc2jIkSRfvAVQ/YbU0r8nU36vXdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZU67VgxNNKHB/U9+pNuide+2jqEe9K/e9c8FqgPJo025qR9eIyIDQi2CoLKPcIwqedV1ZY14g6KZc144DGGLP1Ij7EyMpgXMVtFxdaIJ4VFGA0+Qha5WoSF3Cb8F0Hl+5HnCFAqc/ph6AMwMtfRHCgtwgW6hk08JAG72RgC8qNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8vbRf1r; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709240951; x=1740776951;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=vI3JErcIXK8PkI3jc2jIkSRfvAVQ/YbU0r8nU36vXdA=;
  b=f8vbRf1rszH2B0+Zi46r4K54MsoZOMtq3fOl7jnw8EP9gUs3FXM0YXUQ
   9WvlOHfpV3cfQfehraXGAhpmGcnIEdiqd9pjYPLSSGkJDrsB1iT6OsdK3
   Y+spqIHcm5fwjJgnVc5WdyKeVGfVTv4oH9tkxsBQvPWmg6ERPbX8zwLj+
   sKlq0Yoiy+lybeu4Fm2VM9MAMjkNJVekaIN6Zi185IU7VuVskTbB+owds
   ICZbioBhGZSmlR3qWk8O2xh+dvTlTPfMNpbdZXunizffAcql7/f6KzWSC
   Vjyrh3Sjk4i5o10PILa7QLDThaA9V/NCHSvac7K+9eGj2qNM+ZaWt1Ioz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3865398"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3865398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8341044"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:09:04 -0800
Received: from [10.212.85.217] (kliang2-mobl1.ccr.corp.intel.com [10.212.85.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A8308580D37;
	Thu, 29 Feb 2024 13:09:01 -0800 (PST)
Message-ID: <f2e34072-542a-4055-b8fd-20171e6783a1@linux.intel.com>
Date: Thu, 29 Feb 2024 16:09:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/20] perf jevents: Add smi metric group for Intel
 models
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang
 <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>,
 Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 John Garry <john.g.garry@oracle.com>, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>,
 James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
References: <20240229001806.4158429-1-irogers@google.com>
 <20240229001806.4158429-4-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240229001806.4158429-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> Allow duplicated metric to be dropped from json files.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index 46866a25b166..20c25d142f24 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
>                      JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
> -                    MetricGroup, Select)
> +                    MetricGroup, MetricRef, Select)
>  import argparse
>  import json
>  import math
> @@ -62,9 +62,25 @@ def Rapl() -> MetricGroup:
>                       description="Processor socket power consumption estimates")
>  
>  
> +def Smi() -> MetricGroup:
> +    aperf = Event('msr/aperf/')

There are CPUID enumeration for the aperf and mperf. I believe they
should be always available for a newer bare metal. But they may not be
enumerated in an virtualization env. Should we add a has_event() check
before using it?

Thanks,
Kan

> +    cycles = Event('cycles')
> +    smi_num = Event('msr/smi/')
> +    smi_cycles = Select((aperf - cycles) / aperf, smi_num > 0, 0)
> +    return MetricGroup('smi', [
> +        Metric('smi_num', 'Number of SMI interrupts.',
> +               smi_num, 'SMI#'),
> +        # Note, the smi_cycles "Event" is really a reference to the metric.
> +        Metric('smi_cycles',
> +               'Percentage of cycles spent in System Management Interrupts.',
> +               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
> +    ])
> +
> +
>  all_metrics = MetricGroup("", [
>      Idle(),
>      Rapl(),
> +    Smi(),
>  ])
>  
>  if args.metricgroups:

