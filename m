Return-Path: <linux-kernel+bounces-72415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA585B2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B2628748F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB529A8;
	Tue, 20 Feb 2024 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuMOJcFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2642054
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410786; cv=none; b=pfU0ctAkGpa4YMPT5y8OfLNrQq+VETw+rgidk9AGji1dJslRlHbnPheXOFc76eIN6lV/jOKi1oujlt1JhBkvSQXBbUKmIJuG56RyOAjCl3de4n4pcrSfVU2ycibdvaNKkIUqano4PSJZIeQ9dAL/Ysct9U/KIA1GO8Qf39VKSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410786; c=relaxed/simple;
	bh=gZZeREXEUghP1MKgAgV1Z2A/YMLqIsmKYAK87mJddTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDViftRLop+P5Y2pPZTQ0eSe0YhyZST0v8Vtd9c/of/3yFsnvjUP1zGN3xCMxwrive3IXDRgxtJm4VqYXOkAqku8fDupBbRzLXNLZkX78JXUMbpBmygYTTc7gQ50/+I3XMecKyHyZxn22DsyVmG8f5vQWEII8LmvEduyi1JN9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuMOJcFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7D1C433C7;
	Tue, 20 Feb 2024 06:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708410785;
	bh=gZZeREXEUghP1MKgAgV1Z2A/YMLqIsmKYAK87mJddTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JuMOJcFcTd82+d09cB2S5AxQMjuCMX/j3NFvQfhFhL84oJlNQZ/+f16rcbgBihoPk
	 XiAYa7+nzkg7noKjtEUMNauwGDJ52VmclnLOcLoP7ZK9nk2HveOvskBh7J1noQusZe
	 Wu+W+l7p+f2oKzAngCGeWc1Okiv8ASmooh6SgO0It6Nh9z7D8tELTxgTfBYDPbC9Jp
	 ueUiUY4WB2ArDBlpCJoXE+dSxXQXLassKo8MjDhzOkMFRTfRbNwzfRX0NHlJ+qTcO5
	 QA3e2fL+mDtJ5Ukd0B+XKIt6O84QxEaj+xYVzg0BZ4EeshEfVXY81kegqS2H0RBjys
	 uLhUFLzdsFB/w==
Message-ID: <7097ff95-6077-4744-a770-b90d224c0c9b@kernel.org>
Date: Tue, 20 Feb 2024 12:02:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Donet Tom <donettom@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
 Feng Tang <feng.tang@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Mike Kravetz
 <mike.kravetz@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Dan Williams <dan.j.williams@intel.com>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
 <63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
 <20240219172130.82a16c1ebecbf8ba86a8987d@linux-foundation.org>
 <21f343fa-84a7-4539-91e2-6fc963dbfb62@kernel.org>
 <87frxnps8w.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
In-Reply-To: <87frxnps8w.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 11:55 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> writes:
> 
>> On 2/20/24 6:51 AM, Andrew Morton wrote:
>>> On Mon, 19 Feb 2024 14:04:23 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
>>>
>>>>>> --- a/mm/mempolicy.c
>>>>>> +++ b/mm/mempolicy.c
>>>>>> @@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>>>>>   		if (node_isset(curnid, pol->nodes))
>>>>>>   			goto out;
>>>>>>   		z = first_zones_zonelist(
>>>>>> -				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>>>>>> +				node_zonelist(thisnid, GFP_HIGHUSER),
>>>>>>   				gfp_zone(GFP_HIGHUSER),
>>>>>>   				&pol->nodes);
>>>>>>   		polnid = zone_to_nid(z->zone);
>>>>> 	int thisnid = cpu_to_node(thiscpu);
>>>>>
>>>>> Is there any dofference between numa_node_id() and
>>>>> cpu_to_node(raw_smp_processor_id())?  And it it explicable that we're
>>>>> using one here and not the other?
>>>>
>>>> Hi Andrew
>>>>
>>>> Both numa_node_id() and cpu_to_node(raw_smp_processor_id()) return the current execution node id,
>>>> Since the current execution node is already fetched at the beginning (thisnid) we can reuse it instead of getting it again.
>>>
>>> Sure, but mine was a broader thought: why do we have both?  Is one
>>> preferable and if so why?
>>
>> IIUC these are two helpers to fetch current numa node id. and either of them can be used based on need. The default implementation shows the details.
>> (One small difference is numa_node_id() can use optimized per cpu reader because it is fetching the per cpu variable of the currently running cpu.)
>>
>> #ifndef numa_node_id
>> /* Returns the number of the current Node. */
>> static inline int numa_node_id(void)
>> {
>> 	return raw_cpu_read(numa_node);
>> }
>> #endif
>>
>> #ifndef cpu_to_node
>> static inline int cpu_to_node(int cpu)
>> {
>> 	return per_cpu(numa_node, cpu);
>> }
>> #endif
>>
>> In mpol_misplaced function, we need the cpu details because we are using that in other place (should_numa_migreate_memory()). So it makes it easy
>> to use cpu_to_node(thiscpu) instead of numa_node_id(). 
> 
> IIUC, numa_node_id() is faster than cpu_to_node(thiscpu), even if we
> have thiscpu already.  cpu_to_node() is mainly used to get the node of
> NOT current CPU.  So, IMHO, we should only use numa_node_id() in this
> function.
> 

This change?

modified   mm/mempolicy.c
@@ -2502,8 +2502,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 	pgoff_t ilx;
 	struct zoneref *z;
 	int curnid = folio_nid(folio);
-	int thiscpu = raw_smp_processor_id();
-	int thisnid = cpu_to_node(thiscpu);
+	int thisnid = numa_node_id();
 	int polnid = NUMA_NO_NODE;
 	int ret = NUMA_NO_NODE;
 
@@ -2573,7 +2572,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		polnid = thisnid;
 
 		if (!should_numa_migrate_memory(current, folio, curnid,
-						thiscpu))
+						raw_smp_processor_id()))
 			goto out;
 	}
 



-aneesh

