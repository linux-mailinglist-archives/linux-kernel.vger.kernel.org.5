Return-Path: <linux-kernel+bounces-87585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D47D86D62E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E481F24DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820995025E;
	Thu, 29 Feb 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBBAd+hT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C416FF52;
	Thu, 29 Feb 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242220; cv=none; b=diCuF19UMqozxRUciimpQwwX3v09YXej5s5vVMzl9jjrFLePcxCB+8VcUnSxgKCVMMZ6AAr62jfLQLuKNK0rK/txTPmf4/2zQsttpyUHMBSlhpM8yIrhc5XsH9mewJNtPARJ8pHyVmlNqTZY3hzVk/79udLPyJqAS9c9BCQV0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242220; c=relaxed/simple;
	bh=mT/AQyobgDmVTi23Ha5uXa5XI85omJqUGMjXm04pHnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZMCRC58RuIuLH6eoPaV5TpzONZ9f0mvlYkjA2v+/nihDryI3p/2URPRYSMN4WotWBzvku8jYGOClzpFk1o9oXAJk9cTp+8DVZ2VfFoVkb8XPUk5YfgdQHhdTskfNShUC0GkbuJKjF3dWjnWoLTnGwqBdVzfKXy+pgFgVQ+ad2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBBAd+hT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709242220; x=1740778220;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=mT/AQyobgDmVTi23Ha5uXa5XI85omJqUGMjXm04pHnw=;
  b=XBBAd+hT3O7dznInZALAk1deDo//F76QtiYxCp6ZLyg+EAxLDWmhHnE2
   qHq2VIztrGlkTvVw563nUuAEfnW9eSep9ZSGCugzz8LMpr2N4HXeNWmsz
   G41ZG6ACNSu1JossA4rATcoAzz1Fl3I/o/rPin/TlTDYFy+obPo+2+Kxc
   RqRcy34+aCbJSJjxjbYuDFWB9q9r62ZBGrMZLUSconZ1D5Iw4szrOLmHU
   BM0lCt+QBy0qyKyWtg3tZZjxET7/nuvHBcEu11TS9C/LTz+fdPvytAdgt
   yP/4fsiNzVeHegh7+h8ZnmME4BD+BNpHn+u7xYYgBh+WyFATuz5v5Rn6w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3867231"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3867231"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8022073"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:30:17 -0800
Received: from [10.212.85.217] (kliang2-mobl1.ccr.corp.intel.com [10.212.85.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D528B580D37;
	Thu, 29 Feb 2024 13:30:13 -0800 (PST)
Message-ID: <b1ec1953-2df8-4987-a7d0-4758835b5392@linux.intel.com>
Date: Thu, 29 Feb 2024 16:30:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/20] perf jevents: Add cycles breakdown metric for
 Intel
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
 <20240229001806.4158429-14-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240229001806.4158429-14-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> Breakdown cycles to user, kernel and guest.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index dae44d296861..fef40969a4b8 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -26,6 +26,23 @@ core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
>  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
>  
>  
> +def Cycles() -> MetricGroup:
> +  cyc_k = Event("cycles:kHh")
> +  cyc_g = Event("cycles:G")
> +  cyc_u = Event("cycles:uH")
> +  cyc = cyc_k + cyc_g + cyc_u
> +
> +  return MetricGroup("cycles", [
> +      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
> +      Metric("cycles_user", "User cycles as a percentage of all cycles",
> +             d_ratio(cyc_u, cyc), "100%"),
> +      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
> +             d_ratio(cyc_k, cyc), "100%"),
> +      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
> +             d_ratio(cyc_g, cyc), "100%"),
> +  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
> +
> +
>  def Idle() -> Metric:
>    cyc = Event("msr/mperf/")
>    tsc = Event("msr/tsc/")
> @@ -770,6 +787,7 @@ def IntelLdSt() -> Optional[MetricGroup]:
>  
>  
>  all_metrics = MetricGroup("", [
> +    Cycles(),

The metric group seem exactly the same on AMD and ARM. Maybe we can have
tools/perf/pmu-events/common_metrics.py for all the common metrics.

Thanks,
Kan

>      Idle(),
>      Rapl(),
>      Smi(),

