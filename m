Return-Path: <linux-kernel+bounces-72312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908785B1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2318F1C23DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961457871;
	Tue, 20 Feb 2024 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0x0FCUo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1B57333
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402210; cv=none; b=rTEC3caiMWOWj5a4yNDMPT/Z6774BOmWaJkSn3jr5xIgCLlXoa+q4jW7gKodsN9abJMw9FX16YKdq7J7+Xzl7yE26MFxWJx4Nf79alfPxl77igddnM3Z5nCa5JTvNLS4QENMbcjVjPh2Q/vrTLYLS69YKARDccnDwhl1k3zjX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402210; c=relaxed/simple;
	bh=KKHHRdVhhgZ9aWQzJ7mjvLx6wN0urMkPn6mNuza3z9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdFFjGfUPA4Hzoy8QgB0mvOO5cgdE8UXn6ASt85g6qWcYBD/9fcoyTU0Rdg7fQk+kFZEMg9D6FDxBKKRmb+OXpyNkVYdN32WS7dnB19Ey6ZtGe1o/oO7IzVQTyYCNBlIvCQVbi3X62PS0h1vqWl1+tPb2gZ/NpcSlY4feVXXnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0x0FCUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26A7C43390;
	Tue, 20 Feb 2024 04:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708402210;
	bh=KKHHRdVhhgZ9aWQzJ7mjvLx6wN0urMkPn6mNuza3z9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X0x0FCUossxV1bBbCmQT9HhLxk0SSYRolnLvORHtXWsYx3cFWrZPMKEJZy0kfAggv
	 nlxbMiwTK51yLipQgJtARMTFscIcUoQTsT1A9WCdI5JOHBeTeyEwVlM0JSMeV8Pxy3
	 81KgVTLZxLiDFOoSmOOM6GSsuAV33KVqdkxriG+F3B75PkIueN6U80FRbp6vWvldmw
	 3eEouoftA8Azo/Swy22m4heA/sPdtfAAuv12SNr6UxQEl2IOnyYtF5/ooRrutj2s7k
	 LhwZpartF/KcIJOl+pDC9bAMQKVwu67nKlgHX+PlVds9uTXuP0894BaMEjHTl7v02q
	 1cQnAsxA2RxpA==
Message-ID: <21f343fa-84a7-4539-91e2-6fc963dbfb62@kernel.org>
Date: Tue, 20 Feb 2024 09:40:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 Donet Tom <donettom@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Huang Ying <ying.huang@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Mel Gorman <mgorman@suse.de>,
 Ben Widawsky <ben.widawsky@intel.com>, Feng Tang <feng.tang@intel.com>,
 Michal Hocko <mhocko@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
In-Reply-To: <20240219172130.82a16c1ebecbf8ba86a8987d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 6:51 AM, Andrew Morton wrote:
> On Mon, 19 Feb 2024 14:04:23 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
> 
>>>> --- a/mm/mempolicy.c
>>>> +++ b/mm/mempolicy.c
>>>> @@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>>>   		if (node_isset(curnid, pol->nodes))
>>>>   			goto out;
>>>>   		z = first_zones_zonelist(
>>>> -				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>>>> +				node_zonelist(thisnid, GFP_HIGHUSER),
>>>>   				gfp_zone(GFP_HIGHUSER),
>>>>   				&pol->nodes);
>>>>   		polnid = zone_to_nid(z->zone);
>>> 	int thisnid = cpu_to_node(thiscpu);
>>>
>>> Is there any dofference between numa_node_id() and
>>> cpu_to_node(raw_smp_processor_id())?  And it it explicable that we're
>>> using one here and not the other?
>>
>> Hi Andrew
>>
>> Both numa_node_id() and cpu_to_node(raw_smp_processor_id()) return the current execution node id,
>> Since the current execution node is already fetched at the beginning (thisnid) we can reuse it instead of getting it again.
> 
> Sure, but mine was a broader thought: why do we have both?  Is one
> preferable and if so why?

IIUC these are two helpers to fetch current numa node id. and either of them can be used based on need. The default implementation shows the details.
(One small difference is numa_node_id() can use optimized per cpu reader because it is fetching the per cpu variable of the currently running cpu.)

#ifndef numa_node_id
/* Returns the number of the current Node. */
static inline int numa_node_id(void)
{
	return raw_cpu_read(numa_node);
}
#endif

#ifndef cpu_to_node
static inline int cpu_to_node(int cpu)
{
	return per_cpu(numa_node, cpu);
}
#endif

In mpol_misplaced function, we need the cpu details because we are using that in other place (should_numa_migreate_memory()). So it makes it easy
to use cpu_to_node(thiscpu) instead of numa_node_id(). 

-aneesh



