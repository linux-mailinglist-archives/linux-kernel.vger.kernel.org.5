Return-Path: <linux-kernel+bounces-49579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D2846BF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7561C21EF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1477637;
	Fri,  2 Feb 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="igFZU13d"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B95FF1C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866129; cv=none; b=eChT+hkVaqoc49o7AhpAA+xepL1UCqTwWO61aUdJtKIXI5x+WGRksWGriTZd1zUav85OhFWBsWWAiaOwZLekLy7QKWhkY9OM78pNFZQIfGBvffJ0/GVVVEXR7TzpVwxAm4qXbp5Sz6krEDsV8ED7YTdalJayaB4XZFbCELHKykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866129; c=relaxed/simple;
	bh=VJXC3t3pof0hM5QfLvLHKn+Dk+5+0wmcTobYwk/ekv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpmiJ73vMGNgMoNFgVJBDcw0TKhNicUOyim+BE0xPHmPmJs4sX+RFn2pKupmztSq3rGGgSqCQZttznbYO/oSQLz73c5yS+RNq4imscBQ2ntBSztbqSkhUl3kXwaPwBKWfL+wEJIPhpq6sZjnn3jCOHTt07O++9yKJMbP8FHQ5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=igFZU13d; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706866124; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Mq/Heb4h+f5RoC1ScHkmVU31bkVi/CnbkssDq0b9Pc4=;
	b=igFZU13dpCj+8yvhf2Rvwb2jDyDcjJLCu13Z4l7DNRqZXDctNvZmMGVCAoUPy5ADIClF9ARzNLbAGyTk9k8Baslc96K/BG2b09fPyordWMkisLIkzTu52MWjJ72FRgEcWd3EAHxeN2h2pf+stCyKLg1DImW56FA5XAmJATdMuAM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.wc2fj_1706866122;
Received: from 30.97.56.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.wc2fj_1706866122)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 17:28:43 +0800
Message-ID: <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
Date: Fri, 2 Feb 2024 17:29:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
 <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
 <ZbylJr_bbWCUMjMl@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZbylJr_bbWCUMjMl@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/2/2024 4:17 PM, Michal Hocko wrote:
> On Fri 02-02-24 09:35:58, Baolin Wang wrote:
>>
>>
>> On 2/1/2024 11:27 PM, Michal Hocko wrote:
>>> On Thu 01-02-24 21:31:13, Baolin Wang wrote:
>>>> Since commit 369fa227c219 ("mm: make alloc_contig_range handle free
>>>> hugetlb pages"), the alloc_contig_range() can handle free hugetlb pages
>>>> by allocating a new fresh hugepage, and replacing the old one in the
>>>> free hugepage pool.
>>>>
>>>> However, our customers can still see the failure of alloc_contig_range()
>>>> when seeing a free hugetlb page. The reason is that, there are few memory
>>>> on the old hugetlb page's node, and it can not allocate a fresh hugetlb
>>>> page on the old hugetlb page's node in isolate_or_dissolve_huge_page() with
>>>> setting __GFP_THISNODE flag. This makes sense to some degree.
>>>>
>>>> Later, the commit ae37c7ff79f1 (" mm: make alloc_contig_range handle
>>>> in-use hugetlb pages") handles the in-use hugetlb pages by isolating it
>>>> and doing migration in __alloc_contig_migrate_range(), but it can allow
>>>> fallbacking to other numa node when allocating a new hugetlb in
>>>> alloc_migration_target().
>>>>
>>>> This introduces inconsistency to handling free and in-use hugetlb.
>>>> Considering the CMA allocation and memory hotplug relying on the
>>>> alloc_contig_range() are important in some scenarios, as well as keeping
>>>> the consistent hugetlb handling, we should remove the __GFP_THISNODE flag
>>>> in isolate_or_dissolve_huge_page() to allow fallbacking to other numa node,
>>>> which can solve the failure of alloc_contig_range() in our case.
>>>
>>> I do agree that the inconsistency is not really good but I am not sure
>>> dropping __GFP_THISNODE is the right way forward. Breaking pre-allocated
>>> per-node pools might result in unexpected failures when node bound
>>> workloads doesn't get what is asssumed available. Keep in mind that our
>>> user APIs allow to pre-allocate per-node pools separately.
>>
>> Yes, I agree, that is also what I concered. But sometimes users don't care
>> about the distribution of per-node hugetlb, instead they are more concerned
>> about the success of cma allocation or memory hotplug.
> 
> Yes, sometimes the exact per-node distribution is not really important.
> But the kernel has no way of knowing that right now. And we have to make
> a conservative guess here.
>   
>>> The in-use hugetlb is a very similar case. While having a temporarily
>>> misplaced page doesn't really look terrible once that hugetlb page is
>>> released back into the pool we are back to the case above. Either we
>>> make sure that the node affinity is restored later on or it shouldn't be
>>> migrated to a different node at all.
>>
>> Agree. So how about below changing?
>> (1) disallow fallbacking to other nodes when handing in-use hugetlb, which
>> can ensure consistent behavior in handling hugetlb.
> 
> I can see two cases here. alloc_contig_range which is an internal kernel
> user and then we have memory offlining. The former shouldn't break the
> per-node hugetlb pool reservations, the latter might not have any other
> choice (the whole node could get offline and that resembles breaking cpu
> affininty if the cpu is gone).

IMO, not always true for memory offlining, when handling a free hugetlb, 
it disallows fallbacking, which is inconsistent.

Not only memory offlining, but also the longterm pinning (in 
migrate_longterm_unpinnable_pages()) and memory failure (in 
soft_offline_in_use_page()) can also break the per-node hugetlb pool 
reservations.

> Now I can see how a hugetlb page sitting inside a CMA region breaks CMA
> users expectations but hugetlb migration already tries hard to allocate
> a replacement hugetlb so the system must be under a heavy memory
> pressure if that fails, right? Is it possible that the hugetlb
> reservation is just overshooted here? Maybe the memory is just terribly
> fragmented though?
> 
> Could you be more specific about numbers in your failure case?

Sure. Our customer's machine contains serveral numa nodes, and the 
system reserves a large number of CMA memory occupied 50% of the total 
memory which is used for the virtual machine, meanwhile it also reserves 
lots of hugetlb which can occupy 50% of the CMA. So before starting the 
virtual machine, the hugetlb can use 50% of the CMA, but when starting 
the virtual machine, the CMA will be used by the virtual machine and the 
hugetlb should be migrated from CMA.

Due to several nodes in the system, one node's memory can be exhausted, 
which will fail the hugetlb migration with __GFP_THISNODE flag.

>> (2) introduce a new sysctl (may be named as "hugetlb_allow_fallback_nodes")
>> for users to control to allow fallbacking, that can solve the CMA or memory
>> hotplug failures that users are more concerned about.
> 
> I do not think this is a good idea. The policy might be different on
> each node and this would get messy pretty quickly. If anything we could
> try to detect a dedicated per node pool allocation instead. It is quite
> likely that if admin preallocates pool without any memory policy then
> the exact distribution of pages doesn't play a huge role.

I also agree. Now I think the policy is already messy when handing 
hugetlb migration:

1. CMA allocation: can or can not break the per-node hugetlb pool 
reservations.
   1.1 handling free hugetlb: can not break per-node hugetlb pool 
reservations.
   1.2 handling in-use hugetlb: can break per-node hugetlb pool 
reservations.
2. memory offlining: can or can not break per-node hugetlb pool 
reservations.
   2.1 handling free hugetlb: can not break
   2.2 handling in-use hugetlb: can break
3. longterm pinning: can break per-node hugetlb pool reservations.
4. memory soft-offline: can break per-node hugetlb pool reservations.

What a messy policy. And now we have no documentation to describe this 
messy policy. So we need to make things more clear when handling hugetlb 
migration with proper documantation.

