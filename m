Return-Path: <linux-kernel+bounces-88753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C094F86E61D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F361F21B83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1028382;
	Fri,  1 Mar 2024 16:44:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577E882E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311454; cv=none; b=GzWLSuBSEjta11i384ssYxs3rKh44zBckHOkfPuP5+zFYR37G3qo+Is5T/8BF2H7ivDDaOttaQ7lKgIzTH30TkTzglBxbVdbmMNjwZuB733WmprnDatc6B0EhB32wuAgQgjuvmB8OYO9byvVj8P14CbzllIvX3rLQ4DHAmrLqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311454; c=relaxed/simple;
	bh=ye5bABfqIH9nHzdBhk/BpXsgjuQ7wRgISNEXdSvVIbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHG00OSF56OvS5HCRXfM48RrIWnlgf76LHCrb1xkX2sVpUegGudbYrLJSP5oD7b512on3wuTZwswKb5huHqgqPWOSvEUNwpm9YmzS/zx74HUQ+yYhoBMeqQdzNuyzIzZ7jHgFZJUfdbM90CfQJP2xUQwoHoZe+hvokNJ4C5x8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E3C11FB;
	Fri,  1 Mar 2024 08:44:50 -0800 (PST)
Received: from [10.57.68.58] (unknown [10.57.68.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F823F73F;
	Fri,  1 Mar 2024 08:44:09 -0800 (PST)
Message-ID: <e56fbf5e-8051-4285-875b-1de529dc6809@arm.com>
Date: Fri, 1 Mar 2024 16:44:08 +0000
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
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZeIC0Bn7N0JlP4TY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 16:31, Matthew Wilcox wrote:
> On Fri, Mar 01, 2024 at 04:27:32PM +0000, Ryan Roberts wrote:
>> I've implemented the batching as David suggested, and I'm pretty confident it's
>> correct. The only problem is that during testing I can't provoke the code to
>> take the path. I've been pouring through the code but struggling to figure out
>> under what situation you would expect the swap entry passed to
>> free_swap_and_cache() to still have a cached folio? Does anyone have any idea?
>>
>> This is the original (unbatched) function, after my change, which caused David's
>> concern that we would end up calling __try_to_reclaim_swap() far too much:
>>
>> int free_swap_and_cache(swp_entry_t entry)
>> {
>> 	struct swap_info_struct *p;
>> 	unsigned char count;
>>
>> 	if (non_swap_entry(entry))
>> 		return 1;
>>
>> 	p = _swap_info_get(entry);
>> 	if (p) {
>> 		count = __swap_entry_free(p, entry);
>> 		if (count == SWAP_HAS_CACHE)
>> 			__try_to_reclaim_swap(p, swp_offset(entry),
>> 					      TTRS_UNMAPPED | TTRS_FULL);
>> 	}
>> 	return p != NULL;
>> }
>>
>> The trouble is, whenever its called, count is always 0, so
>> __try_to_reclaim_swap() never gets called.
>>
>> My test case is allocating 1G anon memory, then doing madvise(MADV_PAGEOUT) over
>> it. Then doing either a munmap() or madvise(MADV_FREE), both of which cause this
>> function to be called for every PTE, but count is always 0 after
>> __swap_entry_free() so __try_to_reclaim_swap() is never called. I've tried for
>> order-0 as well as PTE- and PMD-mapped 2M THP.
> 
> I think you have to page it back in again, then it will have an entry in
> the swap cache.  Maybe.  I know little about anon memory ;-)

Ahh, I was under the impression that the original folio is put into the swap
cache at swap out, then (I guess) its removed once the IO is complete? I'm sure
I'm miles out... what exactly is the lifecycle of a folio going through swap out?

I guess I can try forking after swap out, then fault it back in in the child and
exit. Then do the munmap in the parent. I guess that could force it? Thanks for
the tip - I'll have a play.

> 
> If that doesn't work, perhaps use tmpfs, and use some memory pressure to
> force that to swap?
> 
>> I'm guessing the swapcache was already reclaimed as part of MADV_PAGEOUT? I'm
>> using a block ram device as my backing store - I think this does synchronous IO
>> so perhaps if I have a real block device with async IO I might have more luck?
>> Just a guess...
>>
>> Or perhaps this code path is a corner case? In which case, perhaps its not worth
>> adding the batching optimization after all?
>>
>> Thanks,
>> Ryan
>>


