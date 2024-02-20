Return-Path: <linux-kernel+bounces-72467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF11485B3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C850E1C22440
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C562F5B5CD;
	Tue, 20 Feb 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mp6J7VeG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC45B5AF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413851; cv=none; b=YDNRus/VGwM/aifzOcPfmqYRaM3eoW6VK0e6yFRpwokBWlcRIwPpElxLPYthdfEgGk2mqTXnc957HD9kl6exwWNsaCwbGAuVRWrU9YkQFVyqseHt8kixahgPBnPt95eMBhbp+RtFEeibZkbnDxWbXMU/JeSkZ4k6L1pcCyN9zsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413851; c=relaxed/simple;
	bh=RtNRRa18GwhwVog0vEFc0loPHQWu4i5Y/0NbpjoyX9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CnH87wY3UMYGl92ATAoGf9IbIdQf74e23FMZWVJZtL+Bfo8KEQ4cktg+qqUF84/mEu8mYzyoqRTZYwHhzWz+xyYvFF7IRri5y1qTKklI1yBC55wKQrkcoBabksSUALMTKcKqx0UBkVTSShjLhfxKOQQ6YlKayAaF57soemOrodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mp6J7VeG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708413848; x=1739949848;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RtNRRa18GwhwVog0vEFc0loPHQWu4i5Y/0NbpjoyX9w=;
  b=Mp6J7VeGQc7ulZzo+fH/nTbOZCiJb6nE5UIbRKPTYK2ULoJDMkGJH0Bh
   69pbxgJ7PkNJmFYMtqEZoc5qzaS96s5+YoEEgLlNcYg9HdrtVMjkTS5F7
   HnSdmXVfK2KfXsNomD1bB8mcwjebtu3bKfe+90+s9kVFHc1PF0dM5EMOT
   CEHE9JdJc7VaYo8Lu+JiS++DOVXWsyYaB7/58JRD/apfVAl8sKPfEQHbR
   XKY7wBpBA3V4oIdQWb2r0co+QnkmbEGHKMkA6rw/JY+UQPssYuIx6p8Dp
   bP8ps0pcRQaCa94yn6DZlq6aKJFKUHaFe+Yf93ei3yfGcA6byDbIGNMYl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="27947376"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="27947376"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:24:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="42184372"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:24:02 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Donet Tom
 <donettom@linux.ibm.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Dave Hansen <dave.hansen@linux.intel.com>,
  Mel Gorman <mgorman@suse.de>,  Ben Widawsky <ben.widawsky@intel.com>,
  Feng Tang <feng.tang@intel.com>,  Michal Hocko <mhocko@kernel.org>,
  Andrea Arcangeli <aarcange@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van Riel
 <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Mike Kravetz <mike.kravetz@oracle.com>,  Vlastimil
 Babka <vbabka@suse.cz>,  Dan Williams <dan.j.williams@intel.com>,  Hugh
 Dickins <hughd@google.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,
  Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
In-Reply-To: <b599bfe5-1c4d-4750-b0d6-a086e1c8a34c@kernel.org> (Aneesh Kumar
	K. V.'s message of "Tue, 20 Feb 2024 12:33:51 +0530")
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
	<20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
	<63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
	<20240219172130.82a16c1ebecbf8ba86a8987d@linux-foundation.org>
	<21f343fa-84a7-4539-91e2-6fc963dbfb62@kernel.org>
	<87frxnps8w.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<7097ff95-6077-4744-a770-b90d224c0c9b@kernel.org>
	<b599bfe5-1c4d-4750-b0d6-a086e1c8a34c@kernel.org>
Date: Tue, 20 Feb 2024 15:22:07 +0800
Message-ID: <8734tnppls.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Aneesh Kumar K.V" <aneesh.kumar@kernel.org> writes:

> On 2/20/24 12:02 PM, Aneesh Kumar K.V wrote:
>> On 2/20/24 11:55 AM, Huang, Ying wrote:
>>> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> writes:
>>>
>>>> On 2/20/24 6:51 AM, Andrew Morton wrote:
>>>>> On Mon, 19 Feb 2024 14:04:23 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
>>>>>
>>>>>>>> --- a/mm/mempolicy.c
>>>>>>>> +++ b/mm/mempolicy.c
>>>>>>>> @@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>>>>>>>   		if (node_isset(curnid, pol->nodes))
>>>>>>>>   			goto out;
>>>>>>>>   		z = first_zones_zonelist(
>>>>>>>> -				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>>>>>>>> +				node_zonelist(thisnid, GFP_HIGHUSER),
>>>>>>>>   				gfp_zone(GFP_HIGHUSER),
>>>>>>>>   				&pol->nodes);
>>>>>>>>   		polnid = zone_to_nid(z->zone);
>>>>>>> 	int thisnid = cpu_to_node(thiscpu);
>>>>>>>
>>>>>>> Is there any dofference between numa_node_id() and
>>>>>>> cpu_to_node(raw_smp_processor_id())?  And it it explicable that we're
>>>>>>> using one here and not the other?
>>>>>>
>>>>>> Hi Andrew
>>>>>>
>>>>>> Both numa_node_id() and cpu_to_node(raw_smp_processor_id()) return the current execution node id,
>>>>>> Since the current execution node is already fetched at the beginning (thisnid) we can reuse it instead of getting it again.
>>>>>
>>>>> Sure, but mine was a broader thought: why do we have both?  Is one
>>>>> preferable and if so why?
>>>>
>>>> IIUC these are two helpers to fetch current numa node id. and either of them can be used based on need. The default implementation shows the details.
>>>> (One small difference is numa_node_id() can use optimized per cpu reader because it is fetching the per cpu variable of the currently running cpu.)
>>>>
>>>> #ifndef numa_node_id
>>>> /* Returns the number of the current Node. */
>>>> static inline int numa_node_id(void)
>>>> {
>>>> 	return raw_cpu_read(numa_node);
>>>> }
>>>> #endif
>>>>
>>>> #ifndef cpu_to_node
>>>> static inline int cpu_to_node(int cpu)
>>>> {
>>>> 	return per_cpu(numa_node, cpu);
>>>> }
>>>> #endif
>>>>
>>>> In mpol_misplaced function, we need the cpu details because we are using that in other place (should_numa_migreate_memory()). So it makes it easy
>>>> to use cpu_to_node(thiscpu) instead of numa_node_id(). 
>>>
>>> IIUC, numa_node_id() is faster than cpu_to_node(thiscpu), even if we
>>> have thiscpu already.  cpu_to_node() is mainly used to get the node of
>>> NOT current CPU.  So, IMHO, we should only use numa_node_id() in this
>>> function.
>>>
>> 
>> This change?
>> 
>> modified   mm/mempolicy.c
>> @@ -2502,8 +2502,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>  	pgoff_t ilx;
>>  	struct zoneref *z;
>>  	int curnid = folio_nid(folio);
>> -	int thiscpu = raw_smp_processor_id();
>> -	int thisnid = cpu_to_node(thiscpu);
>> +	int thisnid = numa_node_id();
>>  	int polnid = NUMA_NO_NODE;
>>  	int ret = NUMA_NO_NODE;
>>  
>> @@ -2573,7 +2572,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>  		polnid = thisnid;
>>  
>>  		if (!should_numa_migrate_memory(current, folio, curnid,
>> -						thiscpu))
>> +						raw_smp_processor_id()))
>>  			goto out;
>>  	}
>>  
>> 
>
> One of the problem with the above change will be the need to make sure smp processor id remaining stable, which
> I am not sure we want in this function. With that we can end up with processor id not related to the numa node id
> we are using. 

This isn't an issue now, because mpol_misplaced() are always called with
PTL held.  And, we can still keep thiscpu local variable.

--
Best Regards,
Huang, Ying

