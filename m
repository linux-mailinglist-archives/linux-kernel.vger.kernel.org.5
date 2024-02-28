Return-Path: <linux-kernel+bounces-85222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E486B274
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EF41C23C32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C291612FC;
	Wed, 28 Feb 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRtRMqQ1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68081586C5;
	Wed, 28 Feb 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132106; cv=none; b=TO0qBMBpmbvZTdqQ3CCQZNQdjeHozdZ9g1ICkJIq/RGXVQwPX3QYlqvo2XwYeCK8G5Iz2ppl29xCWcu/NWwE9C4oi3vL75V4K91oOErsVigsIDzYHxhfnLBdoUQF2tTDxfAI+4eFoZFezTatHj3NBQQxWwmPJBukHZhsNvpgA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132106; c=relaxed/simple;
	bh=Mo78dJ9Wp+tA4cX4x0JBLjMbdszD3R7oJcgpk28Ai2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcX1j5EPTC8hftQ0Zadqgx3qOWuAxwrosEhBiw0/cy/skY450tJnEQCG5x1uGXdZMTXqE7RpaEoFG8igFRUdeRrqadGdYWKbw58JIvE6b4bPqnlk328QknOFTtbsmWGhk0rvP9rkjF9J5GR/UHqcCMOByFzXhz6vJ+TMZ8r1kXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRtRMqQ1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709132104; x=1740668104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mo78dJ9Wp+tA4cX4x0JBLjMbdszD3R7oJcgpk28Ai2Y=;
  b=nRtRMqQ12RDwd2wy+iv6+uKfnC7Xu1RZFcRElSj3u0FElAvjb+k/zc4B
   KIJi+UZD3NkNWbuVz/amue225RzuyJ1HzTCmgzwaeHnzYC8++sNDWPS2r
   CMBmYaiXMIXi72imgbpjxGJ9sQfCJ6jBMOq4g0hkd79Afm+ZuhuibnnJp
   3oOrIK7HZCBaMZOrgGHDDaxaisHyGk1DXYXqNZ7Haef/H0mO4k2z3L3B8
   OZ7gYw3GKgkgNHkABd7JRZlTd73DRRIfjboH8wleUJsWW2So97urfDaPz
   NDnyyL8pvyp7vIb2Rgaay0yQ0xLhEEs8W3uCfiPFjrQGVMATEfo4Jsp5F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7314269"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7314269"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 06:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="8022598"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 06:55:03 -0800
Received: from [10.213.186.121] (kliang2-mobl1.ccr.corp.intel.com [10.213.186.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 31AAC5807E2;
	Wed, 28 Feb 2024 06:55:01 -0800 (PST)
Message-ID: <2b950564-fe20-4426-ac91-5b40a2087099@linux.intel.com>
Date: Wed, 28 Feb 2024 09:54:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf vendor events intel: Add umasks to PCU events.
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226201517.3540187-1-irogers@google.com>
 <0b2ff06f-099c-424a-97b5-fdf638892e41@linux.intel.com>
 <CAP-5=fVTOgOO=N7uf4CaANWu+WCCLXXMuNBnDdBOP3E6vijG_A@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVTOgOO=N7uf4CaANWu+WCCLXXMuNBnDdBOP3E6vijG_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-02-27 9:12 p.m., Ian Rogers wrote:
> On Tue, Feb 27, 2024 at 6:12 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-02-26 3:15 p.m., Ian Rogers wrote:
>>> UMasks were being dropped leading to all PCU
>>> UNC_P_POWER_STATE_OCCUPANCY events having the same encoding. Don't
>>> drop the umask trying to be consistent with other sources of events
>>> like libpfm4 [1]. This applies the change from [2].
>>>
>>> [1] https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/events/intel_skx_unc_pcu_events.h#l30
>>> [2] https://github.com/captain5050/perfmon/commit/661a229996493448095fb55415ed568ceabc631b
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>
>> Thanks Ian.
>>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> Thanks,
>> Kan
>>
>>>  tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json  | 3 +++
>>>  tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json   | 3 +++
>>>  tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json | 3 +++
>>>  tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json     | 3 +++
>>>  tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json     | 3 +++
>>>  tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json      | 3 +++
>>>  tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json     | 3 +++
>>>  tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json     | 3 +++
>>>  tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json   | 3 +++
>>>  9 files changed, 27 insertions(+)
>>>
>>> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
>>> index 83d20130c217..9a0bc34c08e1 100644
>>> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
>>> @@ -396,6 +396,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -404,6 +405,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -412,6 +414,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
>>> index 83d20130c217..9a0bc34c08e1 100644
>>> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
>>> @@ -396,6 +396,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -404,6 +405,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -412,6 +414,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
>>> index c6254af7a468..ceef46046488 100644
>>> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
>>> @@ -144,6 +144,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -152,6 +153,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -160,6 +162,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
>>> index daebf1050acb..15097511cbd8 100644
>>> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
>>> @@ -428,6 +428,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -436,6 +437,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -444,6 +446,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
>>> index ee4dac6fc797..920cab6ffe37 100644
>>> --- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
>>> @@ -151,6 +151,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "Number of cores in C-State : C0 and C1 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -159,6 +160,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "Number of cores in C-State : C3 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -167,6 +169,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "Number of cores in C-State : C6 and C7 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
>>> index 5df1ebfb89ea..4dac5810324b 100644
>>> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
>>> @@ -516,6 +516,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
> 
> There's something wrong on Ivytown, I don't see a umask format in uncore_pmu:
> ```
> $ ls /sys/devices/uncore_pcu/format/
> edge   filter_band0  filter_band2  occ_edge    occ_sel
> event  filter_band1  filter_band3  occ_invert  thresh
> ```
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/uncore_snbep.c#n1606
> 
> It does exist for skylake though:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/uncore_snbep.c#n4145
> 
> Kan, what's the right way to deal with this?

There is no umask in the uncore spec. Please see P120 of the spec.
https://www.intel.com/content/www/us/en/develop/download/intel-xeon-processor-e5-2600-v2-product-family-uncore-performance-monitoring-reference.html

It should be occ_sel.
The occ_sel = (the umask from the event list >> 6) & 0x3.

I don't think we want to change either the kernel or the perf tool.
There is nothing to help either if we add the occ_sel in the original
event list. So it seems the only choice should be handling it in the
convertor tool.

Is it possible to check the UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 in IVT
and use "Filter": "occ_sel=0x1" to replace "UMask": "0x40"?

It seems everything in the filter will directly be appended. Is my
understanding correct?

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -524,6 +525,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -532,6 +534,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
>>> index b3ee5d741015..a83e07dce947 100644
>>> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
>>> @@ -235,6 +235,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -243,6 +244,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -251,6 +253,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in C0.  It can be used by itself to get the average number of cores in C0, with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
>>> index c6254af7a468..ceef46046488 100644
>>> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
>>> @@ -144,6 +144,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -152,6 +153,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -160,6 +162,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
>>> index a61ffca2dfea..dcf268467db9 100644
>>> --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
>>> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
>>> @@ -150,6 +150,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "Number of cores in C-State : C0 and C1 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x40",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -158,6 +159,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "Number of cores in C-State : C3 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0x80",
>>>          "Unit": "PCU"
>>>      },
>>>      {
>>> @@ -166,6 +168,7 @@
>>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
>>>          "PerPkg": "1",
>>>          "PublicDescription": "Number of cores in C-State : C6 and C7 : This is an occupancy event that tracks the number of cores that are in the chosen C-State.  It can be used by itself to get the average number of cores in that C-state with thresholding to generate histograms, or with other PCU events and occupancy triggering to capture other details.",
>>> +        "UMask": "0xc0",
>>>          "Unit": "PCU"
>>>      },
>>>      {
> 

