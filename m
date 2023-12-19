Return-Path: <linux-kernel+bounces-5446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C3818AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C216283BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA151C69D;
	Tue, 19 Dec 2023 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqAAp2zO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428191C29F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702998261; x=1734534261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=katbumrUel6pNPhQstdVj759l1kLtw2Y7xfH4s5BUgw=;
  b=AqAAp2zODuu8EXggonOvxIq0Ki6qBoj9zcBkQxRUxBTdrbYkRYwbZr0l
   iCyeILJsvz9+g5QqqlvQNNCaG1rXkjaSyt97PpQ5GMvuIpHsYC7jbX8GX
   mG3qcnRPQzG+nj/gUjoI56kYOKLAda2Kg4A89X23llmSb7zXfAMvaqnZ9
   Zhw5bmmQQLml85HRRsYRpkai+M0oRf3j/MpAyx5royq6hxPeGx9RnGHAy
   kGv1X+o37TBoP9ZQpGBqZiwAfqGQEhWGX43hVSTHVQ9fFQxkhjEsIlrjn
   Uo8hHTjqwSgeM0KkPZQS+Ekr9R2Y4jkUdVUThUzAeApuzMDOcOzin8/t0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375160987"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="375160987"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="919640811"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="919640811"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:04:19 -0800
Received: from [10.209.175.219] (kliang2-mobl1.ccr.corp.intel.com [10.209.175.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 25347580BA2;
	Tue, 19 Dec 2023 07:04:18 -0800 (PST)
Message-ID: <c633f4df-af09-43a3-8907-c439d6681b1d@linux.intel.com>
Date: Tue, 19 Dec 2023 10:04:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Hide Topdown metrics events if slots is
 not enumerated
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, joe.jin@oracle.com, likexu@tencent.com,
 linux-kernel@vger.kernel.org
References: <20220922201505.2721654-1-kan.liang@linux.intel.com>
 <91d8d712-f20b-0809-7272-9b16bf83968d@oracle.com>
 <d48fdd31-c989-e610-f9be-5c51a0a1402a@oracle.com>
 <da494232-b3da-d236-2138-bc3f481a60a8@oracle.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <da494232-b3da-d236-2138-bc3f481a60a8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-19 8:22 a.m., Dongli Zhang wrote:
> I can still reproduce this issue with the most recent mainline linux kernel (at
> least when the KVM is not the most recent).
> 
> Any chance to have this patch in the linux kernel?
> 
> (We may need to rename 'cpu_type' due to commit b0560bfd4b70 ("perf/x86/intel:
> Clean up the hybrid CPU type handling code"))

I have re-based the patch on top of the latest 6.7-rc.
https://lore.kernel.org/lkml/20231219150109.1596634-1-kan.liang@linux.intel.com/

Besides the 'cpu_type', I also use the intel_cap.perf_metrics to do the
check, which should be more accurate than the slots event.

Please give it a try and let us know if the V2 works for you.

Thanks,
Kan
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> On 10/27/22 09:17, Dongli Zhang wrote:
>> Ping? Any plan for this patch? Currently "perf stat" will fail on Icelake VMs
>> (without the topdown metric). The user will need to manually specify the events
>> to trace.
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>> On 10/9/22 10:03 PM, Dongli Zhang wrote:
>>> Ping?
>>>
>>> Currently the default "perf stat" may fail on all Icelake KVM VMs.
>>>
>>> Thank you very much!
>>>
>>> Dongli Zhang
>>>
>>> On 9/22/22 13:15, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The below error is observed on Ice Lake VM.
>>>>
>>>> $ perf stat
>>>> Error:
>>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
>>>> for event (slots).
>>>> /bin/dmesg | grep -i perf may provide additional information.
>>>>
>>>> In a virtualization env, the Topdown metrics and the slots event haven't
>>>> been supported yet. The guest CPUID doesn't enumerate them. However, the
>>>> current kernel unconditionally exposes the slots event and the Topdown
>>>> metrics events to sysfs, which misleads the perf tool and triggers the
>>>> error.
>>>>
>>>> Hide the perf metrics topdown events and the slots event if the slots
>>>> event is not enumerated.
>>>>
>>>> The big core of a hybrid platform can also supports the perf-metrics
>>>> feature. Fix the hybrid platform as well.
>>>>
>>>> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>> ---
>>>>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index b16c91ac9219..a0a62b67c440 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -5335,6 +5335,19 @@ static struct attribute *intel_pmu_attrs[] = {
>>>>  	NULL,
>>>>  };
>>>>  
>>>> +static umode_t
>>>> +td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>>> +{
>>>> +	/*
>>>> +	 * Hide the perf metrics topdown events
>>>> +	 * if the slots is not enumerated.
>>>> +	 */
>>>> +	if (x86_pmu.num_topdown_events)
>>>> +		return (x86_pmu.intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
>>>> +
>>>> +	return attr->mode;
>>>> +}
>>>> +
>>>>  static umode_t
>>>>  tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>>>  {
>>>> @@ -5370,6 +5383,7 @@ default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>>>  
>>>>  static struct attribute_group group_events_td  = {
>>>>  	.name = "events",
>>>> +	.is_visible = td_is_visible,
>>>>  };
>>>>  
>>>>  static struct attribute_group group_events_mem = {
>>>> @@ -5522,6 +5536,23 @@ static inline int hybrid_find_supported_cpu(struct x86_hybrid_pmu *pmu)
>>>>  	return (cpu >= nr_cpu_ids) ? -1 : cpu;
>>>>  }
>>>>  
>>>> +static umode_t hybrid_td_is_visible(struct kobject *kobj,
>>>> +					struct attribute *attr, int i)
>>>> +{
>>>> +	struct device *dev = kobj_to_dev(kobj);
>>>> +	struct x86_hybrid_pmu *pmu =
>>>> +		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
>>>> +
>>>> +	if (!is_attr_for_this_pmu(kobj, attr))
>>>> +		return 0;
>>>> +
>>>> +	/* Only check the big core which supports perf metrics */
>>>> +	if (pmu->cpu_type == hybrid_big)
>>>> +		return (pmu->intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
>>>> +
>>>> +	return attr->mode;
>>>> +}
>>>> +
>>>>  static umode_t hybrid_tsx_is_visible(struct kobject *kobj,
>>>>  				     struct attribute *attr, int i)
>>>>  {
>>>> @@ -5548,7 +5579,7 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
>>>>  
>>>>  static struct attribute_group hybrid_group_events_td  = {
>>>>  	.name		= "events",
>>>> -	.is_visible	= hybrid_events_is_visible,
>>>> +	.is_visible	= hybrid_td_is_visible,
>>>>  };
>>>>  
>>>>  static struct attribute_group hybrid_group_events_mem = {
> 

