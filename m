Return-Path: <linux-kernel+bounces-88822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF81C86E72C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382B8288E11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A28BFE;
	Fri,  1 Mar 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWAF8pBu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F72900;
	Fri,  1 Mar 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314022; cv=none; b=WF13Ov5ovdfAacvEhjh0XePxUszOC9rqMDutJU9v0QENIQwke/rpnIM/fVtaXA1XWa+eJaO+oeRaGljo2D8yI+cj4uTQpJwapw26OtjurmlktXlswyB4BjraLAzqMVmJhRjxh06rX8XTkcBWj3okmzno2VijQ8njsV7H+Mlvjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314022; c=relaxed/simple;
	bh=YogIhGDbuAhFHlQeObalXFcZiiNQi2MV9J4WEdFmGf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPlEUiYZBIPgevMIKmfJmbQ1d/yuwQ7Xkf/il8zJXC8JAcv9g6pPd2CBalbx+UZ6OwGskbjV12wrXqFHacBNRSk0i6F/JqHbYM9CcnYYynXtRMrySK9ZOzERjSEiOzzPUsfuSuhzga/hQUCMaQzIaWboGUmvLtXklyaJ4QJyF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWAF8pBu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709314020; x=1740850020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YogIhGDbuAhFHlQeObalXFcZiiNQi2MV9J4WEdFmGf0=;
  b=OWAF8pBu8LorewQwGDJIhyEY5dUY68A8B/HPIai0gBi365xJjAKli+JG
   qLju2Om/vUm92J7QWpnKOPv1D6GYiNY4yb/5dVFduuoCxPQyH7ZHYnSDq
   kvre81ehwcwG+xuODekQMCAYMDOD0yZDkE9i1Gm9bS5M29VRzbeKs+QL7
   7DVkICnYJ9njfIQiqKl0jTxY7InhLt70o3DoDOKIZn28HXC6i67RYmf0V
   LeSp9vVx+mzQsWZcn2vDpQayGHsC/+UgZN02lX3YhoiQ177gwxVWNxtCZ
   Rcvvk3TL4ov140MLL3Q9eWkZCPBGc/B4v2tdFhifhPNRQvPJ2Vc/XRcez
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15273367"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15273367"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:26:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12958512"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:26:59 -0800
Received: from [10.209.156.90] (kliang2-mobl1.ccr.corp.intel.com [10.209.156.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 86B54580DA4;
	Fri,  1 Mar 2024 09:26:56 -0800 (PST)
Message-ID: <f9248ff6-6138-46b6-9cb7-a40442882195@linux.intel.com>
Date: Fri, 1 Mar 2024 12:26:55 -0500
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
 <20240229001806.4158429-5-irogers@google.com>
 <7aa2d2a2-b8f9-478f-9699-7b717d38a8ab@linux.intel.com>
 <CAP-5=fWSidi1zjwn8Zr93dAQvRBtngKrkVwDxorTMmVSVc9FWg@mail.gmail.com>
 <e1e04f03-5d99-466d-a2d1-ce7fb15e8b8e@linux.intel.com>
 <CAP-5=fVBPT9itsyruLeChu=90xnvuxT7PSBtBkWi5LiDNAm2iw@mail.gmail.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVBPT9itsyruLeChu=90xnvuxT7PSBtBkWi5LiDNAm2iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-03-01 11:37 a.m., Ian Rogers wrote:
> On Fri, Mar 1, 2024 at 6:52 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-02-29 8:01 p.m., Ian Rogers wrote:
>>> On Thu, Feb 29, 2024 at 1:15 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
>>>>> Allow duplicated metric to be dropped from json files.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>  tools/perf/pmu-events/intel_metrics.py | 51 ++++++++++++++++++++++++++
>>>>>  1 file changed, 51 insertions(+)
>>>>>
>>>>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
>>>>> index 20c25d142f24..1096accea2aa 100755
>>>>> --- a/tools/perf/pmu-events/intel_metrics.py
>>>>> +++ b/tools/perf/pmu-events/intel_metrics.py
>>>>> @@ -7,6 +7,7 @@ import argparse
>>>>>  import json
>>>>>  import math
>>>>>  import os
>>>>> +from typing import Optional
>>>>>
>>>>>  parser = argparse.ArgumentParser(description="Intel perf json generator")
>>>>>  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
>>>>> @@ -77,10 +78,60 @@ def Smi() -> MetricGroup:
>>>>>      ])
>>>>>
>>>>>
>>>>> +def Tsx() -> Optional[MetricGroup]:
>>>>> +    if args.model not in [
>>>>> +        'alderlake',
>>>>> +        'cascadelakex',
>>>>> +        'icelake',
>>>>> +        'icelakex',
>>>>> +        'rocketlake',
>>>>> +        'sapphirerapids',
>>>>> +        'skylake',
>>>>> +        'skylakex',
>>>>> +        'tigerlake',> +    ]:
>>>>
>>>> Can we get ride of the model list? Otherwise, we have to keep updating
>>>> the list.
>>>
>>> Do we expect the list to update? :-)
>>
>> Yes, at least for the meteorlake and graniterapids. They should be the
>> same as alderlake and sapphirerapids. I'm not sure about the future
>> platforms.
>>
>> Maybe we can have a if args.model in list here to include all the
>> non-hybrid models which doesn't support TSX. I think the list should not
>> be changed shortly.
>>
>>> The issue is the events are in
>>> sysfs and not the json. If we added the tsx events to json then this
>>> list wouldn't be necessary, but it also would mean the events would be
>>> present in "perf list" even when TSX is disabled.
>>
>> I think there may an alternative way, to check the RTM events, e.g.,
>> RTM_RETIRED.START event. We only need to generate the metrics for the
>> platform which supports the RTM_RETIRED.START event.
>>
>>
>>>
>>>>> +        return None
>>>>> +> +    pmu = "cpu_core" if args.model == "alderlake" else "cpu"
>>>>
>>>> Is it possible to change the check to the existence of the "cpu" PMU
>>>> here? has_pmu("cpu") ? "cpu" : "cpu_core"
>>>
>>> The "Unit" on "cpu" events in json always just blank. On hybrid it is
>>> either "cpu_core" or "cpu_atom", so I can make this something like:
>>>
>>> pmu = "cpu_core" if metrics.HasPmu("cpu_core") else "cpu"
>>>
>>> which would be a build time test.
>>
>> Yes, I think using the "Unit" is good enough.
>>
>>>
>>>
>>>>> +    cycles = Event('cycles')
>>>>> +    cycles_in_tx = Event(f'{pmu}/cycles\-t/')
>>>>> +    transaction_start = Event(f'{pmu}/tx\-start/')
>>>>> +    cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
>>>>> +    metrics = [
>>>>> +        Metric('tsx_transactional_cycles',
>>>>> +                      'Percentage of cycles within a transaction region.',
>>>>> +                      Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
>>>>> +                      '100%'),
>>>>> +        Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
>>>>> +                      Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
>>>>> +                                    has_event(cycles_in_tx),
>>>>> +                                    0),
>>>>> +                      '100%'),
>>>>> +        Metric('tsx_cycles_per_transaction',
>>>>> +                      'Number of cycles within a transaction divided by the number of transactions.',
>>>>> +                      Select(cycles_in_tx / transaction_start,
>>>>> +                                    has_event(cycles_in_tx),
>>>>> +                                    0),
>>>>> +                      "cycles / transaction"),
>>>>> +    ]
>>>>> +    if args.model != 'sapphirerapids':
>>>>
>>>> Add the "tsx_cycles_per_elision" metric only if
>>>> has_event(f'{pmu}/el\-start/')?
>>>
>>> It's a sysfs event, so this wouldn't work :-(
>>
>> The below is the definition of el-start in the kernel.
>> EVENT_ATTR_STR(el-start,        el_start,       "event=0xc8,umask=0x1");
>>
>> The corresponding event in the event list should be HLE_RETIRED.START
>>       "EventCode": "0xC8",
>>       "UMask": "0x01",
>>       "EventName": "HLE_RETIRED.START",
>>
>> I think we may check the HLE_RETIRED.START instead. If the
>> HLE_RETIRED.START doesn't exist, I don't see a reason why the
>> tsx_cycles_per_elision should be supported.
>>
>> Again, in the virtualization world, it's possible that the
>> HLE_RETIRED.START exists in the event list but el_start isn't available
>> in the sysfs. I think it has to be specially handle in the test as well.
> 
> So we keep the has_event test on the sysfs event to handle the
> virtualization and disabled case. We use  HLE_RETIRED.START to detect
> whether the model supports TSX.

Yes. I think the JSON event always keeps the latest status of an event.
If an event is deprecated someday, I don't think there is a reason to
keep any metrics including the event. So we should use it to check
whether to generate a metrics.

The sysfs event tells if the current kernel support the event. It should
be used to check whether a metrics should be used/enabled.

> Should the event be the sysfs or json
> version? i.e.
> 
>         "MetricExpr": "(cycles\\-t / el\\-start if
> has_event(el\\-start) else 0)",
> 
> or
> 
>         "MetricExpr": "(cycles\\-t / HLE_RETIRED.START if
> has_event(el\\-start) else 0)",
> 
> I think I favor the former for some consistency with the has_event.
>

Agree, the former looks good to me too.


> Using HLE_RETIRED.START means the set of TSX models goes from:
>         'alderlake',
>         'cascadelakex',
>         'icelake',
>         'icelakex',
>         'rocketlake',
>         'sapphirerapids',
>         'skylake',
>         'skylakex',
>         'tigerlake',
> 
> To:
>    broadwell
>    broadwellde
>    broadwellx
>    cascadelakex
>    haswell
>    haswellx
>    icelake
>    rocketlake
>    skylake
>    skylakex
> 
> Using RTM_RETIRED.START it goes to:
>    broadwell
>    broadwellde
>    broadwellx
>    cascadelakex
>    emeraldrapids
>    graniterapids
>    haswell
>    haswellx
>    icelake
>    icelakex
>    rocketlake
>    sapphirerapids
>    skylake
>    skylakex
>    tigerlake
> 
> So I'm not sure it is working equivalently to what we have today,
> which may be good or bad. Here is what I think the code should look
> like:

Yes, there should be some changes. But I think the changes should be good.

For icelakex, the HLE_RETIRED.START has been deprecated. I don't see a
reason why should perf keep the tsx_cycles_per_elision metric.

For alderlake, TSX is deprecated. The perf should drop the related
metrics as well.
https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/001/deprecated-technologies/

> 
> def Tsx() -> Optional[MetricGroup]:
>   pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
>   cycles = Event('cycles')
>   cycles_in_tx = Event(f'{pmu}/cycles\-t/')
>   cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
>   try:
>     # Test if the tsx event is present in the json, prefer the
>     # sysfs version so that we can detect its presence at runtime.
>     transaction_start = Event("RTM_RETIRED.START")
>     transaction_start = Event(f'{pmu}/tx\-start/')
>   except:
>     return None
> 
>   elision_start = None
>   try:
>     # Elision start isn't supported by all models, but we'll not
>     # generate the tsx_cycles_per_elision metric in that
>     # case. Again, prefer the sysfs encoding of the event.
>     elision_start = Event("HLE_RETIRED.START")
>     elision_start = Event(f'{pmu}/el\-start/')
>   except:
>     pass
> 
>   return MetricGroup('transaction', [
>       Metric('tsx_transactional_cycles',
>              'Percentage of cycles within a transaction region.',
>              Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
>              '100%'),
>       Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted
> transactions.',
>              Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
>                     has_event(cycles_in_tx),
>                     0),
>              '100%'),
>       Metric('tsx_cycles_per_transaction',
>              'Number of cycles within a transaction divided by the
> number of transactions.',
>              Select(cycles_in_tx / transaction_start,
>                     has_event(cycles_in_tx),
>                     0),
>              "cycles / transaction"),
>       Metric('tsx_cycles_per_elision',
>              'Number of cycles within a transaction divided by the
> number of elisions.',
>              Select(cycles_in_tx / elision_start,
>                     has_event(elision_start),
>                     0),
>              "cycles / elision") if elision_start else None,
>   ], description="Breakdown of transactional memory statistics")
> 
> Wdyt?

Looks good to me.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>>
>>> Thanks,
>>> Ian
>>>
>>>> Thanks,
>>>> Kan
>>>>
>>>>> +        elision_start = Event(f'{pmu}/el\-start/')
>>>>> +        metrics += [
>>>>> +            Metric('tsx_cycles_per_elision',
>>>>> +                          'Number of cycles within a transaction divided by the number of elisions.',
>>>>> +                          Select(cycles_in_tx / elision_start,
>>>>> +                                        has_event(elision_start),
>>>>> +                                        0),
>>>>> +                          "cycles / elision"),
>>>>> +        ]
>>>>> +    return MetricGroup('transaction', metrics)
>>>>> +
>>>>> +
>>>>>  all_metrics = MetricGroup("", [
>>>>>      Idle(),
>>>>>      Rapl(),
>>>>>      Smi(),
>>>>> +    Tsx(),
>>>>>  ])
>>>>>
>>>>>  if args.metricgroups:
>>>

