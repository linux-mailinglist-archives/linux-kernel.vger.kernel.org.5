Return-Path: <linux-kernel+bounces-35459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090F2839185
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BBDB29949
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA874EB33;
	Tue, 23 Jan 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ks6Fdd+h"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081212E5F;
	Tue, 23 Jan 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020604; cv=none; b=dknjkR3R95i3s2oD1x2sY+tWaT+6gXjuszFdWzT+4Md4JUBVZU8KgE9Z7tWpP1M2tb3WVn8zGY797+B4RxkVhk3QKzQY6834a8Pyv1iotoGdu3Eumv2uoPmJb+EXxZIJeQ9FP8gPpFPRNcncdl2lHzpo3+LuB5dB5awTK/S4OiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020604; c=relaxed/simple;
	bh=b5WsAWXcMZJ3oedYBhrg7imN/aUDHQ+7R2QdjuUQDzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rpDMEHsm/ElNyn6/sgrPEr8rYQnATLQbLdTzg+RXEBqjQq0eeYHfTjpV/9UTNeBGV7jZkkAwtw7Spxf44DmGuXLVbESA0oC58v5b34pTMyIiZSmX41N2xmBrxPEcGv9m4OZNT0evoVen42fB94r6pUxDQDgTFnbV9Jp5LVvUL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ks6Fdd+h; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706020602; x=1737556602;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=b5WsAWXcMZJ3oedYBhrg7imN/aUDHQ+7R2QdjuUQDzU=;
  b=Ks6Fdd+hiWQw3oKh6gdu62fpvKw00cGo5xg9DjpCa/ns0UXRKOXpDn5F
   ULcBOZAhcE3MDQPhlZNvoBNpBu8kDSk1D01p/amYvnT3EG+qlLBJb+z6U
   lXnW/YZ06qYh8i0AEK+1e14SGI6hqJmd6mXvlBGhvSlENossjLM9Rm+KD
   CYmjTaH+9OUIKy+LEmZ9MGqiQipdTSwSuLh89tiUV/Z0LqOJH9sGOwSGC
   3Idch6z/xUPRypuCBaJQTy14RB0KBMvF1+POUAB573B/KTvVmE3ghWvyZ
   XB41R5Lrzsk7DwPDWo8n/6oc59lmnw3Xr2PxDY1pKAmbK1IEGRHIz+gZO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405295082"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="405295082"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 06:36:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="34426302"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 06:36:42 -0800
Received: from [10.212.112.252] (unknown [10.212.112.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id AE968580CA5;
	Tue, 23 Jan 2024 06:36:38 -0800 (PST)
Message-ID: <0d85e3f6-d857-4c62-8ad8-c20ac2665e91@linux.intel.com>
Date: Tue, 23 Jan 2024 09:36:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] Clean up perf mem
To: Thomas Richter <tmricht@linux.ibm.com>, kajoljain <kjain@linux.ibm.com>,
 acme@kernel.org, irogers@google.com, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
 john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
 mike.leach@linaro.org, leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com,
 renyu.zj@linux.alibaba.com, ravi.bangoria@amd.com,
 atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
 <a0abfee5-4dcd-3eb5-82fe-1a0dcdade038@linux.ibm.com>
 <befb6acd-86be-4255-af96-38865affc56c@linux.intel.com>
 <8bfadc86-e137-4a9f-a9ce-0bc62464c195@linux.intel.com>
 <057a1c19-3117-1aec-41d6-4950c599b862@linux.ibm.com>
 <692e16f9-062c-4b3c-bd66-a16bac68216c@linux.intel.com>
 <cd7dc93f-ade9-6403-a732-2daca8e6cff9@linux.ibm.com>
 <a0540796-1933-4057-8282-aa219ddda4fe@linux.intel.com>
 <6ace2f9f-b073-e22b-0dd6-69c52814d49a@linux.ibm.com>
 <ceffdc69-982b-4909-95df-5b6a8a277f20@linux.ibm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ceffdc69-982b-4909-95df-5b6a8a277f20@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-23 12:56 a.m., Thomas Richter wrote:
> On 1/23/24 06:30, kajoljain wrote:
>>
>>
>> On 1/16/24 22:07, Liang, Kan wrote:
>>>
>>>
>>> On 2024-01-16 9:05 a.m., kajoljain wrote:
>>>>> For powerpc, the patch 3 introduced a perf_mem_events_power, which
>>>>> doesn't have ldlat. But it only be assigned to the pmu->is_core. I'm not
>>>>> sure if it's the problem.
>>>> Hi Kan,
>>>>  Correct there were some small issues with patch 3, I added fix for that.
>>>>
>>>
>>> Thanks Kajol Jain! I will fold your fix into V4.
>>>
>>>>> Also, S390 still uses the default perf_mem_events, which includes ldlat.
>>>>> I'm not sure if S390 supports the ldlat.
>>>> I checked it, I didn't find ldlat parameter defined in arch/s390
>>>> directory. I think its better to make default ldlat value as false
>>>> in tools/perf/util/mem-events.c file.
>>>
>>> The s390 may not be the only user for the default perf_mem_events[] in
>>> the tools/perf/util/mem-events.c. We probably cannot change the default
>>> value.
>>> We may share the perf_mem_events_power[] between powerpc and s390. (We
>>> did the similar share for arm and arm64.)
>>>
>>> How about the below patch (not tested.)
>>>
>>> diff --git a/tools/perf/arch/s390/util/pmu.c
>>> b/tools/perf/arch/s390/util/pmu.c
>>> index 225d7dc2379c..411034c984bb 100644
>>> --- a/tools/perf/arch/s390/util/pmu.c
>>> +++ b/tools/perf/arch/s390/util/pmu.c
>>> @@ -8,6 +8,7 @@
>>>  #include <string.h>
>>>
>>>  #include "../../../util/pmu.h"
>>> +#include "../../powerpc/util/mem-events.h"
>>>
>>>  #define        S390_PMUPAI_CRYPTO      "pai_crypto"
>>>  #define        S390_PMUPAI_EXT         "pai_ext"
>>> @@ -21,5 +22,5 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>>>                 pmu->selectable = true;
>>>
>>>         if (pmu->is_core)
>>> -               pmu->mem_events = perf_mem_events;
>>> +               pmu->mem_events = perf_mem_events_power;
>>>  }
>>>
>>>
>>>
>>> However, the original s390 code doesn't include any s390 specific code
>>> for perf_mem. So I thought it uses the default perf_mem_events[].
>>> Is there something I missed?
>>>
>>> Or does the s390 even support mem events? If not, I may remove the
>>> mem_events from s390.
>>
>> Hi Kan,
>>    I don't have s390 system to do testing. But from my end I am fine
>> with the changes.
>>
>> Thanks,
>> Kajol Jain
>>
> 
> s390 does not support perf mem at all. Right now it is save to remove it from s390.

Thanks for the confirmation!

Thanks,
Kan

> Thanks
> 
>>>
>>> Thanks,
>>> Kan
>>
> 

