Return-Path: <linux-kernel+bounces-88585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58CD86E3BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65431C216EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18503A8CD;
	Fri,  1 Mar 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cw6zp7TN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3C22324;
	Fri,  1 Mar 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304750; cv=none; b=inhq03h6LCL45ITNHiBjVNVu+ff5eRxRgbbaYPKqokNQKgQkUaBLznkNAbnEYB4VrYDBWuUmTaERbavpUeDLHOYg5n2Wqd1tree0n6Bu+7FpJgMgl6Zu034jtJRshMh5CLTo469t1NT/G3nVJdAdqRkT2WuWUuis17iPNhlEvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304750; c=relaxed/simple;
	bh=rOEy1lKjPOcxZsqS0RdrBMGzspzvco5V3px+hW77xkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blsdxUFqysgtUiDXHfVIxfzKQcOWrDoUFoUzl3Sph9YHxp5tozjPCsgm9LEZIByht2yCD3FDJUpdRu7Xsn3BZ5YoqMwSDeNvSbNitpTMytFaBCvw/WOshRaC2XaEJLS1fRefMKWNYzhmQMF2iNi7Mof2IhixFVWxpPnBTe92Pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cw6zp7TN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709304749; x=1740840749;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rOEy1lKjPOcxZsqS0RdrBMGzspzvco5V3px+hW77xkg=;
  b=cw6zp7TNdT9FaCwagcWAtLpKgGN2a35tLsU3m7CcXZggDx4jGxgpKlss
   8BCj75kRqDL5BBz/q1SJrogT2n5lgMGco0QJJ9LKy5wzQkiwaj/nWaHmH
   f142jyJnUlMfSDjodGfGkRTheLKstCpUqhxL5DmvsVIOMPY+EHlfYdt+o
   6y7ICZOujLI5EWny9f0vGhOsbqaKdt6SoJtXMxUr5X+vRvfUuL5qSno1u
   UH15MDKUO4bP3NGwkxkxTnD4FLiJnd8Np8Ud10CdIxZWvKnp6b1Yh4nSc
   oyX7EMmpByBEnjg2U1uqZSVNBOt02BctWVSOsqaFHf7cwDZUPLkzfagmy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7613776"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7613776"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 06:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8640001"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 06:52:29 -0800
Received: from [10.209.156.90] (kliang2-mobl1.ccr.corp.intel.com [10.209.156.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 240AB580DA4;
	Fri,  1 Mar 2024 06:52:25 -0800 (PST)
Message-ID: <e1e04f03-5d99-466d-a2d1-ce7fb15e8b8e@linux.intel.com>
Date: Fri, 1 Mar 2024 09:52:23 -0500
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
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWSidi1zjwn8Zr93dAQvRBtngKrkVwDxorTMmVSVc9FWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-02-29 8:01 p.m., Ian Rogers wrote:
> On Thu, Feb 29, 2024 at 1:15 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
>>> Allow duplicated metric to be dropped from json files.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/pmu-events/intel_metrics.py | 51 ++++++++++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
>>> index 20c25d142f24..1096accea2aa 100755
>>> --- a/tools/perf/pmu-events/intel_metrics.py
>>> +++ b/tools/perf/pmu-events/intel_metrics.py
>>> @@ -7,6 +7,7 @@ import argparse
>>>  import json
>>>  import math
>>>  import os
>>> +from typing import Optional
>>>
>>>  parser = argparse.ArgumentParser(description="Intel perf json generator")
>>>  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
>>> @@ -77,10 +78,60 @@ def Smi() -> MetricGroup:
>>>      ])
>>>
>>>
>>> +def Tsx() -> Optional[MetricGroup]:
>>> +    if args.model not in [
>>> +        'alderlake',
>>> +        'cascadelakex',
>>> +        'icelake',
>>> +        'icelakex',
>>> +        'rocketlake',
>>> +        'sapphirerapids',
>>> +        'skylake',
>>> +        'skylakex',
>>> +        'tigerlake',> +    ]:
>>
>> Can we get ride of the model list? Otherwise, we have to keep updating
>> the list.
> 
> Do we expect the list to update? :-) 

Yes, at least for the meteorlake and graniterapids. They should be the
same as alderlake and sapphirerapids. I'm not sure about the future
platforms.

Maybe we can have a if args.model in list here to include all the
non-hybrid models which doesn't support TSX. I think the list should not
be changed shortly.

> The issue is the events are in
> sysfs and not the json. If we added the tsx events to json then this
> list wouldn't be necessary, but it also would mean the events would be
> present in "perf list" even when TSX is disabled.

I think there may an alternative way, to check the RTM events, e.g.,
RTM_RETIRED.START event. We only need to generate the metrics for the
platform which supports the RTM_RETIRED.START event.


> 
>>> +        return None
>>> +> +    pmu = "cpu_core" if args.model == "alderlake" else "cpu"
>>
>> Is it possible to change the check to the existence of the "cpu" PMU
>> here? has_pmu("cpu") ? "cpu" : "cpu_core"
> 
> The "Unit" on "cpu" events in json always just blank. On hybrid it is
> either "cpu_core" or "cpu_atom", so I can make this something like:
> 
> pmu = "cpu_core" if metrics.HasPmu("cpu_core") else "cpu"
> 
> which would be a build time test.

Yes, I think using the "Unit" is good enough.

> 
> 
>>> +    cycles = Event('cycles')
>>> +    cycles_in_tx = Event(f'{pmu}/cycles\-t/')
>>> +    transaction_start = Event(f'{pmu}/tx\-start/')
>>> +    cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
>>> +    metrics = [
>>> +        Metric('tsx_transactional_cycles',
>>> +                      'Percentage of cycles within a transaction region.',
>>> +                      Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
>>> +                      '100%'),
>>> +        Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
>>> +                      Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
>>> +                                    has_event(cycles_in_tx),
>>> +                                    0),
>>> +                      '100%'),
>>> +        Metric('tsx_cycles_per_transaction',
>>> +                      'Number of cycles within a transaction divided by the number of transactions.',
>>> +                      Select(cycles_in_tx / transaction_start,
>>> +                                    has_event(cycles_in_tx),
>>> +                                    0),
>>> +                      "cycles / transaction"),
>>> +    ]
>>> +    if args.model != 'sapphirerapids':
>>
>> Add the "tsx_cycles_per_elision" metric only if
>> has_event(f'{pmu}/el\-start/')?
> 
> It's a sysfs event, so this wouldn't work :-(

The below is the definition of el-start in the kernel.
EVENT_ATTR_STR(el-start,	el_start,	"event=0xc8,umask=0x1");

The corresponding event in the event list should be HLE_RETIRED.START
      "EventCode": "0xC8",
      "UMask": "0x01",
      "EventName": "HLE_RETIRED.START",

I think we may check the HLE_RETIRED.START instead. If the
HLE_RETIRED.START doesn't exist, I don't see a reason why the
tsx_cycles_per_elision should be supported.

Again, in the virtualization world, it's possible that the
HLE_RETIRED.START exists in the event list but el_start isn't available
in the sysfs. I think it has to be specially handle in the test as well.

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>> +        elision_start = Event(f'{pmu}/el\-start/')
>>> +        metrics += [
>>> +            Metric('tsx_cycles_per_elision',
>>> +                          'Number of cycles within a transaction divided by the number of elisions.',
>>> +                          Select(cycles_in_tx / elision_start,
>>> +                                        has_event(elision_start),
>>> +                                        0),
>>> +                          "cycles / elision"),
>>> +        ]
>>> +    return MetricGroup('transaction', metrics)
>>> +
>>> +
>>>  all_metrics = MetricGroup("", [
>>>      Idle(),
>>>      Rapl(),
>>>      Smi(),
>>> +    Tsx(),
>>>  ])
>>>
>>>  if args.metricgroups:
> 

