Return-Path: <linux-kernel+bounces-88520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C985786E2CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48E31C2224B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC66F08A;
	Fri,  1 Mar 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHyJwO+M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D06F061;
	Fri,  1 Mar 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301213; cv=none; b=gp9cqtlfGumRluRdsLk55stHquVYu4k9v/N848Gbwhc8FjwaYC8pcaIghSE6H2XG8TlX+Vbv18Gr5IK78uY2RsMlpu+V+S7nkm8TUMaFTnZxgPk1BPPhS1i5CmVCyYE9U9GplmMV/1x0jeIneLGblNOgfC4k0+sxTtmkAstirQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301213; c=relaxed/simple;
	bh=M1xUh7ZKCKbjOhIeycBxfyXIaBQ4HjPL23BzKlTCLkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su+fkNQmIvI96tjRiT3bBwORphk1ATCdSykBF0LYDVx/xwM37OnuSeBNufqBJkP2GoOe9M1PPOpoYvJMpus0HOSxUxtMCJC0QV6ZVMp6B18Gam/T3wZTqaVWJtIpCPeMzVb1JL87TTRiZ1wQmqgS3kQXy/W2kTF3ojzCVvHAEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHyJwO+M; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709301211; x=1740837211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M1xUh7ZKCKbjOhIeycBxfyXIaBQ4HjPL23BzKlTCLkk=;
  b=oHyJwO+MAFbLYCZrlUYyXDetcjvk0IeIZ/+sZ1uE+PePPwMbFrzv5J1K
   StwYZcw8ixPA3dHYny1WQBezAWkMzhFS6v/99v/+tUjdff/TBvxhU/0Xe
   Te8SD/hxkSOhaNUNj47EHR/lA6WpLK+S0yx0sc/O24Tm7hH38NK0ixs0i
   3ZemXob42Bs6Hl/iin647unnDidKFSFycEpTZD0fQiIkdEU8ocOMYeiHT
   vZIUXxYCqAuJxQdBhkRGgaEqkdHUwnG8BwhgFLzIlQqYEhbJMt3Z0FYPy
   cH5jrcfvmSB+CUJavkLRrN/KnypP41gCbl0bR/YcqIXCajzqPSaWifWFR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3764687"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3764687"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 05:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8603825"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 05:53:31 -0800
Received: from [10.209.156.90] (kliang2-mobl1.ccr.corp.intel.com [10.209.156.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 57568580DA4;
	Fri,  1 Mar 2024 05:53:27 -0800 (PST)
Message-ID: <e80b3e63-a344-4c05-a6cd-5a20c89cf3e9@linux.intel.com>
Date: Fri, 1 Mar 2024 08:53:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/20] perf jevents: Add cycles breakdown metric for
 Intel
To: Ian Rogers <irogers@google.com>
Cc: Perry Taylor <perry.taylor@intel.com>,
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
 <b1ec1953-2df8-4987-a7d0-4758835b5392@linux.intel.com>
 <CAP-5=fWHQthKat7SZx6P8CeMpjfsgYgp8=+nxvHBMmMVZF9_vw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWHQthKat7SZx6P8CeMpjfsgYgp8=+nxvHBMmMVZF9_vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-02-29 7:48 p.m., Ian Rogers wrote:
> On Thu, Feb 29, 2024 at 1:30 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
>>> Breakdown cycles to user, kernel and guest.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/pmu-events/intel_metrics.py | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
>>> index dae44d296861..fef40969a4b8 100755
>>> --- a/tools/perf/pmu-events/intel_metrics.py
>>> +++ b/tools/perf/pmu-events/intel_metrics.py
>>> @@ -26,6 +26,23 @@ core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
>>>  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
>>>
>>>
>>> +def Cycles() -> MetricGroup:
>>> +  cyc_k = Event("cycles:kHh")
>>> +  cyc_g = Event("cycles:G")
>>> +  cyc_u = Event("cycles:uH")
>>> +  cyc = cyc_k + cyc_g + cyc_u
>>> +
>>> +  return MetricGroup("cycles", [
>>> +      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
>>> +      Metric("cycles_user", "User cycles as a percentage of all cycles",
>>> +             d_ratio(cyc_u, cyc), "100%"),
>>> +      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
>>> +             d_ratio(cyc_k, cyc), "100%"),
>>> +      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
>>> +             d_ratio(cyc_g, cyc), "100%"),
>>> +  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
>>> +
>>> +
>>>  def Idle() -> Metric:
>>>    cyc = Event("msr/mperf/")
>>>    tsc = Event("msr/tsc/")
>>> @@ -770,6 +787,7 @@ def IntelLdSt() -> Optional[MetricGroup]:
>>>
>>>
>>>  all_metrics = MetricGroup("", [
>>> +    Cycles(),
>>
>> The metric group seem exactly the same on AMD and ARM. Maybe we can have
>> tools/perf/pmu-events/common_metrics.py for all the common metrics.
> 
> Agreed. I think we can drop cycles in the three sets and then once
> then do the common_metrics.py as a follow up.
>

Sounds good to me.

Thanks,
Kan

> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>>      Idle(),
>>>      Rapl(),
>>>      Smi(),
> 

