Return-Path: <linux-kernel+bounces-52913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743A7849E33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE11288A69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5AF2DF9D;
	Mon,  5 Feb 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Talj3SxN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF732C91;
	Mon,  5 Feb 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147161; cv=none; b=JFKmYeSdYUDaUkAOkJGm3UGmWsX3U9pf8DhwhTXxxVDEoIeRXT5SCNyPrFGI5+6i5Rut0SYRkfhY5k3MmjmDhjwmNbG4eTtnUihMfwVyvF6idWQSNtSjlUXaPqtn4Fmq5MIDXXVpuqrFKS3+uNVt3VmLFAFHQ2cNe3pp36cNUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147161; c=relaxed/simple;
	bh=/zcq73sYVUW+h0jnwspQL/RXLud8ceA7/Ln5O42NPho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGzWs0NF+LINa9s6JD6QFBfRI+7sww51M4PLlkVXwDYNXJkAAbwiNOKAJmseVF2t/NgDsuyKOvTfaz9XqW9myjDC14gMWd6KXSqe+4iTVoJPP5bawpHawryV84Ld9td3wAsZJ2Ejyl7cwbcXt6MgCbQ5gkWr1+PUMktW1AK5GjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Talj3SxN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707147159; x=1738683159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/zcq73sYVUW+h0jnwspQL/RXLud8ceA7/Ln5O42NPho=;
  b=Talj3SxNm35vEMjlAIfTXmsGslXhDuMOo72i0upM6ABGUC8dgpTBZ1cS
   3db3iz+mhA814qRR94iuvqvmA0vksrse67b6eFYNeNJASxt5LFFcKOccP
   gEkSz0BhWRTVI9tTaIwlBnwKepD32dhtgvHzCQG1f254ZBscnVv6aXTKm
   H0LQ4zW3LS/2dwk+bAavCN2qzk3f/qICEPhXP1eVssctab5k3bmXrWhOz
   h+oh875GTaV8f2p43gcOzK2EwYUPiTf6YIF0vynC9yWQkHsHeljNVDKZn
   /l2luxJFaq/PMsa4GnzteSBi5BiQz7CwIbMfEC50ta8jetpWUJSs4pj19
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="17965270"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="17965270"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 07:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31829884"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 07:32:38 -0800
Received: from [10.212.74.66] (kliang2-mobl1.ccr.corp.intel.com [10.212.74.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6A84D580ABB;
	Mon,  5 Feb 2024 07:32:36 -0800 (PST)
Message-ID: <82dbb7de-8211-4bab-8289-eb2573d8ef1d@linux.intel.com>
Date: Mon, 5 Feb 2024 10:32:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/uncore: avoid null-ptr-deref on error in
 pmu_alloc_topology
Content-Language: en-US
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
 Alexander Antonov <alexander.antonov@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240204134841.80003-1-pchelkin@ispras.ru>
 <a5e8e3fe-a8c2-45e7-9139-84967cba06eb@linux.intel.com>
 <2b5c4fbc-67c8-42f6-84a0-2adb4fbb0a2a-pchelkin@ispras.ru>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <2b5c4fbc-67c8-42f6-84a0-2adb4fbb0a2a-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-05 10:18 a.m., Fedor Pchelkin wrote:
> Hello,
> 
> On 24/02/05 10:08AM, Liang, Kan wrote:
>>
>>
>> On 2024-02-04 8:48 a.m., Fedor Pchelkin wrote:
>>> If topology[die] array allocation fails then topology[die][idx] elements
>>> can't be accessed on error path.
>>>
>>> Checking this on the error path probably looks more readable than
>>> decrementing the counter in the allocation loop.
>>>
>>> Found by Linux Verification Center (linuxtesting.org).
>>>
>>> Fixes: 4d13be8ab5d4 ("perf/x86/intel/uncore: Generalize IIO topology support")
>>> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>>> ---
>>
>> It seems the code just jumps to the wrong kfree on the error path.
>> Does the below patch work?
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c
>> b/arch/x86/events/intel/uncore_snbep.c
>> index 8250f0f59c2b..5481fd00d861 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -3808,7 +3808,7 @@ static int pmu_alloc_topology(struct
>> intel_uncore_type *type, int topology_type)
>>  	for (die = 0; die < uncore_max_dies(); die++) {
>>  		topology[die] = kcalloc(type->num_boxes, sizeof(**topology), GFP_KERNEL);
>>  		if (!topology[die])
>> -			goto clear;
>> +			goto free_topology;
>>  		for (idx = 0; idx < type->num_boxes; idx++) {
>>  			topology[die][idx].untyped = kcalloc(type->num_boxes,
>>  							     topology_size[topology_type],
>> @@ -3827,6 +3827,7 @@ static int pmu_alloc_topology(struct
>> intel_uncore_type *type, int topology_type)
>>  			kfree(topology[die][idx].untyped);
>>  		kfree(topology[die]);
>>  	}
>> +free_topology:
>>  	kfree(topology);
>>  err:
>>  	return -ENOMEM;
>>
>> Thanks,
>> Kan
>>
> 
> In this way the already allocated topology[die] elements won't be freed.
>

Ah, right. The patch looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> --
> Fedor
> 

