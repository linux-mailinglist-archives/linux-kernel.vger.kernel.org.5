Return-Path: <linux-kernel+bounces-88814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2586E70A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E5B2BCD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ABB522C;
	Fri,  1 Mar 2024 17:14:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE62846B7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313246; cv=none; b=UfLMZOT6GrTOofRt7iKjnyef0KdH+DTfvZj5KhNKAGJEkW82NvJ9hK99GXuWCcpstluhvIEK1qIYHaPoIT0W/1gnTIx86YtoHHMID1nyVf/OsJ1bbLidyzA11Ij76R0LFcTim7Zc7KuQt0TGS5XuozruE95OYnUaX49pWHji8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313246; c=relaxed/simple;
	bh=zExfEQ8bBJzVchpv1wp510MY8pIHJpEaXvN8wwNzGsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHNQFZAJztsVvlYdoEHsSSB+AfY30gBY2GvvvnmTM4PuUvu7a//2/ZOzh/DF84FKDWRX3DC391j0AcntTMjpv3Steg8TdoRIbcjlRoZgWc00xqSsx9n+i8LANRfEuc8WzGb7RJbnJuIC+x1Bws30kb5y/Q4z0aiBNUpZ7jEq4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663691FB;
	Fri,  1 Mar 2024 09:14:42 -0800 (PST)
Received: from [10.57.68.58] (unknown [10.57.68.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D3B73F6C4;
	Fri,  1 Mar 2024 09:14:02 -0800 (PST)
Message-ID: <7774edad-a194-4259-a95f-88bcef846f90@arm.com>
Date: Fri, 1 Mar 2024 17:14:00 +0000
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
To: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <4a73b16e-9317-477a-ac23-8033004b0637@arm.com>
 <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
 <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com>
 <ZeIC0Bn7N0JlP4TY@casper.infradead.org>
 <e56fbf5e-8051-4285-875b-1de529dc6809@arm.com>
 <c12fbea5-0d5d-4c06-b063-dab3dd00e704@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c12fbea5-0d5d-4c06-b063-dab3dd00e704@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/03/2024 17:00, David Hildenbrand wrote:
> On 01.03.24 17:44, Ryan Roberts wrote:
>> On 01/03/2024 16:31, Matthew Wilcox wrote:
>>> On Fri, Mar 01, 2024 at 04:27:32PM +0000, Ryan Roberts wrote:
>>>> I've implemented the batching as David suggested, and I'm pretty confident it's
>>>> correct. The only problem is that during testing I can't provoke the code to
>>>> take the path. I've been pouring through the code but struggling to figure out
>>>> under what situation you would expect the swap entry passed to
>>>> free_swap_and_cache() to still have a cached folio? Does anyone have any idea?
>>>>
>>>> This is the original (unbatched) function, after my change, which caused
>>>> David's
>>>> concern that we would end up calling __try_to_reclaim_swap() far too much:
>>>>
>>>> int free_swap_and_cache(swp_entry_t entry)
>>>> {
>>>>     struct swap_info_struct *p;
>>>>     unsigned char count;
>>>>
>>>>     if (non_swap_entry(entry))
>>>>         return 1;
>>>>
>>>>     p = _swap_info_get(entry);
>>>>     if (p) {
>>>>         count = __swap_entry_free(p, entry);
>>>>         if (count == SWAP_HAS_CACHE)
>>>>             __try_to_reclaim_swap(p, swp_offset(entry),
>>>>                           TTRS_UNMAPPED | TTRS_FULL);
>>>>     }
>>>>     return p != NULL;
>>>> }
>>>>
>>>> The trouble is, whenever its called, count is always 0, so
>>>> __try_to_reclaim_swap() never gets called.
>>>>
>>>> My test case is allocating 1G anon memory, then doing madvise(MADV_PAGEOUT)
>>>> over
>>>> it. Then doing either a munmap() or madvise(MADV_FREE), both of which cause
>>>> this
>>>> function to be called for every PTE, but count is always 0 after
>>>> __swap_entry_free() so __try_to_reclaim_swap() is never called. I've tried for
>>>> order-0 as well as PTE- and PMD-mapped 2M THP.
>>>
>>> I think you have to page it back in again, then it will have an entry in
>>> the swap cache.  Maybe.  I know little about anon memory ;-)
>>
>> Ahh, I was under the impression that the original folio is put into the swap
>> cache at swap out, then (I guess) its removed once the IO is complete? I'm sure
>> I'm miles out... what exactly is the lifecycle of a folio going through swap out?
> 
> I thought with most (disk) backends you will add it to the swapcache and leave
> it there until there is actual memory pressure. Only then, under memory
> pressure, you'd actually reclaim the folio.

OK, my problem is that I'm using a VM, whose disk shows up as rotating media, so
the swap subsystem refuses to swap out THPs to that and they get split. To solve
that, (and to speed up testing) I moved to the block ram disk, which convinces
swap to swap-out THPs. But that causes the folios to be removed from the swap
cache (I assumed because its syncrhonous, but maybe there is a flag somewhere to
affect that behavior?) And I can't convince QEMU to emulate an SSD to the guest
under macos. Perhaps the easiest thing is to hack it to ignore the rotating
media flag.

> 
> You can fault it back in from the swapcache without having to go to disk.
> 
> That's how you can today end up with a THP in the swapcache: during swapin from
> disk (after the folio was reclaimed) you'd currently only get order-0 folios.
> 
> At least that was my assumption with my MADV_PAGEOUT testing so far :)
> 


