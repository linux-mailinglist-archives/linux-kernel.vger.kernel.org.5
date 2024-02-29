Return-Path: <linux-kernel+bounces-87567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BFF86D5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32294B218BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7DF16FF46;
	Thu, 29 Feb 2024 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxnxiymL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310116FF31;
	Thu, 29 Feb 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241359; cv=none; b=d+2QyKKMV4m8riG3SCPZ+c80c4ZGh89bot8WivgkXwMrt6aLyL2UozbQWdnbBBYsJgU3zPi8UNPWakkJKdvRk8qP/jx618pWI3nBXAjZBHjMbuWYtWWA8SxI7ngiT3/VVmdsk3U8UZ8ZdCY9ZmsonwzEILswwcisQ3jh8A962CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241359; c=relaxed/simple;
	bh=xOxDegQasEklfMTwb0uGHJaYs+H/kBKUxdhMsGU3IZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EbkRhaPic9U5kUwCA3xrx5duHUzYiQ0yE6R5cZxspYvdbHew4M1eny4pC0kCgoIC8hBE+yIntmORlpRwXATTxJgAc6RV7z3K0/s2h6eaHQmRnFsC5Ul+ENQthOGG0vQmdJKzu7rNh+mnDKWTUaGWs4yXze+PnLvC0/M75d1wK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxnxiymL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709241358; x=1740777358;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xOxDegQasEklfMTwb0uGHJaYs+H/kBKUxdhMsGU3IZ8=;
  b=JxnxiymLfJowhP2WLR+xVw+9vy39ULxCWEEOPhjS2GjHzyWwob/qvrPF
   Evg7WbzZBsZiQmxRL78M0FuDlGk52kxLcssBxcwFEklCb5QOCs7GtL562
   a35MsBMig504/BeyBuO11gInMYlUUWOM0xV3rhcnxrA+eZo2uy+hO9UAX
   sS8s3QthXPD1m9upCqt9PoEugmtUe37JEL5xOjxxlSPOI9v64PrngkPec
   LuPwcZ7peiO7BoFrHlv9Gw2Z9Cd6BSX9fPMR/BJh/ac9EXvW1CwoY2gLx
   yJX6oL9Pqbugrisp/YGizNyw2vUWU7jRXq0JXmwAKdWC+bbSd3ibyUqEI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3634344"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3634344"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:15:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38803997"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:15:56 -0800
Received: from [10.212.85.217] (kliang2-mobl1.ccr.corp.intel.com [10.212.85.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 46342580D37;
	Thu, 29 Feb 2024 13:15:53 -0800 (PST)
Message-ID: <7aa2d2a2-b8f9-478f-9699-7b717d38a8ab@linux.intel.com>
Date: Thu, 29 Feb 2024 16:15:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/20] perf jevents: Add tsx metric group for Intel
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
 <20240229001806.4158429-5-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240229001806.4158429-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> Allow duplicated metric to be dropped from json files.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 51 ++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index 20c25d142f24..1096accea2aa 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -7,6 +7,7 @@ import argparse
>  import json
>  import math
>  import os
> +from typing import Optional
>  
>  parser = argparse.ArgumentParser(description="Intel perf json generator")
>  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
> @@ -77,10 +78,60 @@ def Smi() -> MetricGroup:
>      ])
>  
>  
> +def Tsx() -> Optional[MetricGroup]:
> +    if args.model not in [
> +        'alderlake',
> +        'cascadelakex',
> +        'icelake',
> +        'icelakex',
> +        'rocketlake',
> +        'sapphirerapids',
> +        'skylake',
> +        'skylakex',
> +        'tigerlake',> +    ]:

Can we get ride of the model list? Otherwise, we have to keep updating
the list.

> +        return None
> +> +    pmu = "cpu_core" if args.model == "alderlake" else "cpu"

Is it possible to change the check to the existence of the "cpu" PMU
here? has_pmu("cpu") ? "cpu" : "cpu_core"

> +    cycles = Event('cycles')
> +    cycles_in_tx = Event(f'{pmu}/cycles\-t/')
> +    transaction_start = Event(f'{pmu}/tx\-start/')
> +    cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
> +    metrics = [
> +        Metric('tsx_transactional_cycles',
> +                      'Percentage of cycles within a transaction region.',
> +                      Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
> +                      '100%'),
> +        Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
> +                      Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
> +                                    has_event(cycles_in_tx),
> +                                    0),
> +                      '100%'),
> +        Metric('tsx_cycles_per_transaction',
> +                      'Number of cycles within a transaction divided by the number of transactions.',
> +                      Select(cycles_in_tx / transaction_start,
> +                                    has_event(cycles_in_tx),
> +                                    0),
> +                      "cycles / transaction"),
> +    ]
> +    if args.model != 'sapphirerapids':

Add the "tsx_cycles_per_elision" metric only if
has_event(f'{pmu}/el\-start/')?

Thanks,
Kan

> +        elision_start = Event(f'{pmu}/el\-start/')
> +        metrics += [
> +            Metric('tsx_cycles_per_elision',
> +                          'Number of cycles within a transaction divided by the number of elisions.',
> +                          Select(cycles_in_tx / elision_start,
> +                                        has_event(elision_start),
> +                                        0),
> +                          "cycles / elision"),
> +        ]
> +    return MetricGroup('transaction', metrics)
> +
> +
>  all_metrics = MetricGroup("", [
>      Idle(),
>      Rapl(),
>      Smi(),
> +    Tsx(),
>  ])
>  
>  if args.metricgroups:

