Return-Path: <linux-kernel+bounces-85227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8286B280
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A141C1C255DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0115B0FD;
	Wed, 28 Feb 2024 14:57:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B363873531
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132265; cv=none; b=Bi3gQ4AHloKrxlI3+mFWrxH+hL1bt12yc5MMw3cvN5W7UvK21KnFZ6LT/B2ZfotFUzobPy3OzkVFes4/bH8aPoz8llcSoqcpwy88yRhumwX3gNLb6qKC+CVP3qk7q3bg89M6t7ylji5dUClU/Qh3EwkkiUn4ggpVs9YK7EbAtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132265; c=relaxed/simple;
	bh=u+CxlfyPsAmnf6ezTygBrM4z1l4e5MJ76fX/bJTH2bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QK9oop6NKqIQ4jK2lUxy7KHf6q8xS6dVLGRpzgn8c8JLu7Mu5M8HhHudQJGOdw5pPht1kzV+CAlE8HUc5rpInxUu6/RieQj5zJfrqT3zod7SMqX65m/nDsMoKyZ+yPlC3LixL2rRpNK95Y5Tjvo4A2cQBpTdOVAfoq7/p9QuzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 678941FB;
	Wed, 28 Feb 2024 06:58:15 -0800 (PST)
Received: from [10.1.38.163] (XHFQ2J9959.cambridge.arm.com [10.1.38.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF1003F73F;
	Wed, 28 Feb 2024 06:57:34 -0800 (PST)
Message-ID: <4a73b16e-9317-477a-ac23-8033004b0637@arm.com>
Date: Wed, 28 Feb 2024 14:57:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2024 12:12, David Hildenbrand wrote:
>>> How relevant is it? Relevant enough that someone decided to put that
>>> optimization in? I don't know :)
>>
>> I'll have one last go at convincing you: Huang Ying (original author) commented
>> "I believe this should be OK.  Better to compare the performance too." at [1].
>> That implies to me that perhaps the optimization wasn't in response to a
>> specific problem after all. Do you have any thoughts, Huang?
> 
> Might make sense to include that in the patch description!
> 
>> OK so if we really do need to keep this optimization, here are some ideas:
>>
>> Fundamentally, we would like to be able to figure out the size of the swap slot
>> from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
>> PMD_SIZE, it always uses a full cluster, so can easily add a flag to the cluster
>> to mark it as PMD_SIZE.
>>
>> Going forwards, we want to support all sizes (power-of-2). Most of the time, a
>> cluster will contain only one size of THPs, but this is not the case when a THP
>> in the swapcache gets split or when an order-0 slot gets stolen. We expect these
>> cases to be rare.
>>
>> 1) Keep the size of the smallest swap entry in the cluster header. Most of the
>> time it will be the full size of the swap entry, but sometimes it will cover
>> only a portion. In the latter case you may see a false negative for
>> swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
>> There is one wrinkle: currently the HUGE flag is cleared in put_swap_folio(). We
>> wouldn't want to do the equivalent in the new scheme (i.e. set the whole cluster
>> to order-0). I think that is safe, but haven't completely convinced myself yet.
>>
>> 2) allocate 4 bits per (small) swap slot to hold the order. This will give
>> precise information and is conceptually simpler to understand, but will cost
>> more memory (half as much as the initial swap_map[] again).
>>
>> I still prefer to avoid this at all if we can (and would like to hear Huang's
>> thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
>> prototyping.
> 
> Taking a step back: what about we simply batch unmapping of swap entries?
> 
> That is, if we're unmapping a PTE range, we'll collect swap entries (under PT
> lock) that reference consecutive swap offsets in the same swap file.

Yes in principle, but there are 4 places where free_swap_and_cache() is called,
and only 2 of those are really amenable to batching (zap_pte_range() and
madvise_free_pte_range()). So the other two users will still take the "slow"
path. Maybe those 2 callsites are the only ones that really matter? I can
certainly have a stab at this approach.

> 
> There, we can then first decrement all the swap counts, and then try minimizing
> how often we actually have to try reclaiming swap space (lookup folio, see it's
> a large folio that we cannot reclaim or could reclaim, ...).
> 
> Might need some fine-tuning in swap code to "advance" to the next entry to try
> freeing up, but we certainly can do better than what we would do right now.

I'm not sure I've understood this. Isn't advancing just a matter of:

entry = swp_entry(swp_type(entry), swp_offset(entry) + 1);



