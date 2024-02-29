Return-Path: <linux-kernel+bounces-87552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CA86D5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C8D281141
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E157F158D67;
	Thu, 29 Feb 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvZ3BZPm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EE6D538;
	Thu, 29 Feb 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240379; cv=none; b=UAh9cEvY0SYZD+MHZb0nh5/dSd2D2jK04lOi6Miw0nMTVZNg3evd/RlAiL/uOA+JIcPINQPjsu8T/Z6euCR2p4e4K9mBY8ntyBiKQ7OzZmIqZGr+lB7bpUieEI0DWFnpGpQMk4/HZRdVNrIZDi3//B5qEUVWbjZRiemrteGdQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240379; c=relaxed/simple;
	bh=pzB9IxRRq+Rx+vVaEO+uogdqRWJOs+QMWQ8UmzsWilA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l9a6+RNpXXFm1xnW5Rbt30vC/omwEdyvXvbN05Id7X9hYjSJRRUpzeFSrZVFfvWCvyM1+tyYyFB89YqRGCc8UaS0++tnVKRDT9sRVbGnffQoN4sCwFrCk4gOVY/3U1JFPHYmpozdQG08pPWP0bmDadFSAdXJGMcF4DsP8tiA2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvZ3BZPm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709240378; x=1740776378;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pzB9IxRRq+Rx+vVaEO+uogdqRWJOs+QMWQ8UmzsWilA=;
  b=QvZ3BZPm0yTY4iudeF+ocBYn+MKChn+B6p3EJxrhc/kSfEIJvLQzgKsA
   3FAoB04vz9m9OaBeP0/Vtq1apqNwKDgtbJCwwHNpHEhr03k3yQ6CSDh2x
   5N9T5ohTX6LhKA3EYeF3m5m8XhGxv8DgITSEZ2ZZl9M7NHuz5yonR10Zh
   WCXdRBckkiYHLM2a5cWp7T6TStT3FO6n9SaJEdre8lg38bdKcj+h5NN9+
   5IbEM8LAfq6Tiwa0nQvXdVyfXWZ9husfoVl1TFYue4oU6U+XlCSVPXDXO
   ckAMjoDeVmcKKxWDdSr7BY/72schtBJKGUswpMm+Td/739YFZ3Z5gNp7z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15186328"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="15186328"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8007119"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:59:37 -0800
Received: from [10.212.85.217] (kliang2-mobl1.ccr.corp.intel.com [10.212.85.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4AB3B580D37;
	Thu, 29 Feb 2024 12:59:33 -0800 (PST)
Message-ID: <28bc7ea0-ff3e-48a5-a8b3-20cc52728a5f@linux.intel.com>
Date: Thu, 29 Feb 2024 15:59:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/20] perf jevents: Add RAPL metrics for all Intel
 models
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
 <20240229001806.4158429-2-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240229001806.4158429-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> Add a 'cpu_power' metric group that computes the power consumption
> from RAPL events if they are present.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 45 ++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index 4fbb31c9eccd..5827f555005f 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -1,9 +1,10 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
> -                    MetricGroup)
> +from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
> +                    LoadEvents, Metric, MetricGroup, Select)
>  import argparse
>  import json
> +import math
>  import os
>  
>  parser = argparse.ArgumentParser(description="Intel perf json generator")
> @@ -14,7 +15,45 @@ args = parser.parse_args()
>  directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
>  LoadEvents(directory)
>  
> -all_metrics = MetricGroup("",[])
> +interval_sec = Event("duration_time")
> +
> +def Rapl() -> MetricGroup:
> +  """Processor socket power consumption estimate.
> +
> +  Use events from the running average power limit (RAPL) driver.
> +  """
> +  # Watts = joules/second
> +  pkg = Event("power/energy\-pkg/")
> +  cond_pkg = Select(pkg, has_event(pkg), math.nan)
> +  cores = Event("power/energy\-cores/")
> +  cond_cores = Select(cores, has_event(cores), math.nan)
> +  ram = Event("power/energy\-ram/")
> +  cond_ram = Select(ram, has_event(ram), math.nan)
> +  gpu = Event("power/energy\-gpu/")
> +  cond_gpu = Select(gpu, has_event(gpu), math.nan)
> +  psys = Event("power/energy\-psys/")
> +  cond_psys = Select(psys, has_event(psys), math.nan)
> +  scale = 2.3283064365386962890625e-10
> +  metrics = [
> +      Metric("cpu_power_pkg", "",
> +             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
> +      Metric("cpu_power_cores", "",
> +             d_ratio(cond_cores * scale, interval_sec), "Watts"),
> +      Metric("cpu_power_ram", "",
> +             d_ratio(cond_ram * scale, interval_sec), "Watts"),
> +      Metric("cpu_power_gpu", "",
> +             d_ratio(cond_gpu * scale, interval_sec), "Watts"),
> +      Metric("cpu_power_psys", "",
> +             d_ratio(cond_psys * scale, interval_sec), "Watts"),
> +  ]
> +
> +  return MetricGroup("cpu_power", metrics,
> +                     description="Processor socket power consumption estimates")

As far as I know, the RAPL counters are to monitor energy consumption
across different domains. The scope may not always be a socket. I think
the description may brings confusions.
Maybe we just call it "RAPL power consumption estimates", or "Running
Average Power Limit (RAPL) power consumption estimates".

Thanks,
Kan
> +
> +
> +all_metrics = MetricGroup("", [
> +    Rapl(),
> +])
>  
>  if args.metricgroups:
>    print(JsonEncodeMetricGroupDescriptions(all_metrics))

