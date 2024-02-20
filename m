Return-Path: <linux-kernel+bounces-72448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7385B39A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F8B228A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1118B5B200;
	Tue, 20 Feb 2024 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi6tPaWa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031F5A7BF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412641; cv=none; b=PzJgwhlJQ+a+wSlDpyql5bxWpfHkaDNdXs8pnsRZKZXDsc9IkLqd7XskJxcF38vhXkPaUB7vfJ3HRI5r5dGdL2JPyfbsiPz/HDKthqfUFTOhnr9wExJF65AKMcpcJKyw0NQE9RpL4h4mXUnOasK9f3ocXaV3WsHOtHk+B3+/SqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412641; c=relaxed/simple;
	bh=PMQoz8O5HTzQHK/8qIlXhgJEFRcEgbpMwCdJThDc+fw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z+by43Ip2Pm/jvBRnksY93J9U8WNIesaRRASb7crtoVbXONFhcMymIRuD4A5Ww3vS6s/5WobgmmU7vD6OxxiQkosSzhsRd2f9MIvpGRFgXXZJVNGMyognNqdrsu/25glfbTC4AI30zwGFkF/tFNALwsSB2/+4yv/fIviv1mh2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi6tPaWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61638C433C7;
	Tue, 20 Feb 2024 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708412640;
	bh=PMQoz8O5HTzQHK/8qIlXhgJEFRcEgbpMwCdJThDc+fw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Zi6tPaWauef5T/Nrx1WvQcsey8zBCfJYKhuNwG4sQVYWSgEn4RyMBl1F2VIw/qSHc
	 TPvDCayTZeuLIBnW9CapdThhB5qgi9Wx6l+ub9jpClL9IhO0+nfGkGNAldSOLlk+SY
	 Vu3n1T/jP9+re25D1PeOen5sX+lktNX7f6TBb/7jS7jFGiu+NwvldGNnBTijzy+wRl
	 gLwNabtb+XH6AJmMeHNnZxc/cKi000RPpKfksdoi2faTxZucxAHLA9pR/JdiPLZceV
	 PfZHT0G47zBC4gTe3NArvuVNU5Qj2TQKOMJXj+LjpIj5QYaC9uLIRxskAB5sEKsFi1
	 L/CbHRRFRQOCw==
Message-ID: <b599bfe5-1c4d-4750-b0d6-a086e1c8a34c@kernel.org>
Date: Tue, 20 Feb 2024 12:33:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
Content-Language: en-US
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
 <7097ff95-6077-4744-a770-b90d224c0c9b@kernel.org>
In-Reply-To: <7097ff95-6077-4744-a770-b90d224c0c9b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 12:02 PM, Aneesh Kumar K.V wrote:
> On 2/20/24 11:55 AM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> writes:
>>
>>> On 2/20/24 6:51 AM, Andrew Morton wrote:
>>>> On Mon, 19 Feb 2024 14:04:23 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
>>>>
>>>>>>> --- a/mm/mempolicy.c
>>>>>>> +++ b/mm/mempolicy.c
>>>>>>> @@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>>>>>>   		if (node_isset(curnid, pol->nodes))
>>>>>>>   			goto out;
>>>>>>>   		z = first_zones_zonelist(
>>>>>>> -				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>>>>>>> +				node_zonelist(thisnid, GFP_HIGHUSER),
>>>>>>>   				gfp_zone(GFP_HIGHUSER),
>>>>>>>   				&pol->nodes);
>>>>>>>   		polnid = zone_to_nid(z->zone);
>>>>>> 	int thisnid = cpu_to_node(thiscpu);
>>>>>>
>>>>>> Is there any dofference between numa_node_id() and
>>>>>> cpu_to_node(raw_smp_processor_id())?  And it it explicable that we're
>>>>>> using one here and not the other?
>>>>>
>>>>> Hi Andrew
>>>>>
>>>>> Both numa_node_id() and cpu_to_node(raw_smp_processor_id()) return the current execution node id,
>>>>> Since the current execution node is already fetched at the beginning (thisnid) we can reuse it instead of getting it again.
>>>>
>>>> Sure, but mine was a broader thought: why do we have both?  Is one
>>>> preferable and if so why?
>>>
>>> IIUC these are two helpers to fetch current numa node id. and either of them can be used based on need. The default implementation shows the details.
>>> (One small difference is numa_node_id() can use optimized per cpu reader because it is fetching the per cpu variable of the currently running cpu.)
>>>
>>> #ifndef numa_node_id
>>> /* Returns the number of the current Node. */
>>> static inline int numa_node_id(void)
>>> {
>>> 	return raw_cpu_read(numa_node);
>>> }
>>> #endif
>>>
>>> #ifndef cpu_to_node
>>> static inline int cpu_to_node(int cpu)
>>> {
>>> 	return per_cpu(numa_node, cpu);
>>> }
>>> #endif
>>>
>>> In mpol_misplaced function, we need the cpu details because we are using that in other place (should_numa_migreate_memory()). So it makes it easy
>>> to use cpu_to_node(thiscpu) instead of numa_node_id(). 
>>
>> IIUC, numa_node_id() is faster than cpu_to_node(thiscpu), even if we
>> have thiscpu already.  cpu_to_node() is mainly used to get the node of
>> NOT current CPU.  So, IMHO, we should only use numa_node_id() in this
>> function.
>>
> 
> This change?
> 
> modified   mm/mempolicy.c
> @@ -2502,8 +2502,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>  	pgoff_t ilx;
>  	struct zoneref *z;
>  	int curnid = folio_nid(folio);
> -	int thiscpu = raw_smp_processor_id();
> -	int thisnid = cpu_to_node(thiscpu);
> +	int thisnid = numa_node_id();
>  	int polnid = NUMA_NO_NODE;
>  	int ret = NUMA_NO_NODE;
>  
> @@ -2573,7 +2572,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>  		polnid = thisnid;
>  
>  		if (!should_numa_migrate_memory(current, folio, curnid,
> -						thiscpu))
> +						raw_smp_processor_id()))
>  			goto out;
>  	}
>  
> 

One of the problem with the above change will be the need to make sure smp processor id remaining stable, which
I am not sure we want in this function. With that we can end up with processor id not related to the numa node id
we are using. 

-aneesh


