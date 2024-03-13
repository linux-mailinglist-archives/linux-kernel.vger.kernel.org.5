Return-Path: <linux-kernel+bounces-101259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085387A4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFC11F22C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0261BDC2;
	Wed, 13 Mar 2024 09:10:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534631B273
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321009; cv=none; b=HM9IbIL600qqtIMn/IfOahRqEdCI/2fHv73NIRIg0bC9tFz/1LPGKD3Jr7MyRuvi7sWfoF1G15d9o3qBJ18kyqezoDovCJd0dTLG/tpbKG8s0RPKHtEP2pUL75FhvK9U4dOck9/uepiR6WSgffO2fZe390Z+9hu3aAU3QEYoiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321009; c=relaxed/simple;
	bh=Qwqg32CUXXTklt7/S4qp9vW/eWPK1jlCzeyzylwjNkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ou1nPCaFA5N1ONoQXvSSgczTrXklRqqYBirTv2gbpc1IhODbophuS7OGF6tmTluYKFjVIYNyNkbd+5fHZlNDZ3Za5KDSZSiEVO8LzLr4Fef9JAD8+Bl1sNfoBSmeBipsuEAxxHL1RIpdFUna3ppYhKLxJGxpotxUS034Au7lLCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 369C61007;
	Wed, 13 Mar 2024 02:10:43 -0700 (PDT)
Received: from [10.57.67.164] (unknown [10.57.67.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D0423F73F;
	Wed, 13 Mar 2024 02:10:02 -0700 (PDT)
Message-ID: <f880135f-e113-4d42-b3a0-8b0b9eebcbf4@arm.com>
Date: Wed, 13 Mar 2024 09:09:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/5] mm: swap: make should_try_to_free_swap()
 support large-folio
Content-Language: en-GB
To: Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-4-21cnbao@gmail.com>
 <e73c12ff-5234-44d5-a2b3-99cdc61a9c37@arm.com>
 <24dc6251-8582-790f-bbd3-465deed946f5@oppo.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <24dc6251-8582-790f-bbd3-465deed946f5@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/03/2024 02:21, Chuanhua Han wrote:
> hi, Ryan Roberts
> 
> 在 2024/3/12 20:34, Ryan Roberts 写道:
>> On 04/03/2024 08:13, Barry Song wrote:
>>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>>
>>> should_try_to_free_swap() works with an assumption that swap-in is always done
>>> at normal page granularity, aka, folio_nr_pages = 1. To support large folio
>>> swap-in, this patch removes the assumption.
>>>
>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> Acked-by: Chris Li <chrisl@kernel.org>
>>> ---
>>>  mm/memory.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index abd4f33d62c9..e0d34d705e07 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3837,7 +3837,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
>>>  	 * reference only in case it's likely that we'll be the exlusive user.
>>>  	 */
>>>  	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
>>> -		folio_ref_count(folio) == 2;
>>> +		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
>> I don't think this is correct; one reference has just been added to the folio in
>> do_swap_page(), either by getting from swapcache (swap_cache_get_folio()) or by
>> allocating. If it came from the swapcache, it could be a large folio, because we
>> swapped out a large folio and never removed it from swapcache. But in that case,
>> others may have partially mapped it, so the refcount could legitimately equal
>> the number of pages while still not being exclusively mapped.
>>
>> I'm guessing this logic is trying to estimate when we are likely exclusive so
>> that we remove from swapcache (release ref) and can then reuse rather than CoW
>> the folio? The main CoW path currently CoWs page-by-page even for large folios,
>> and with Barry's recent patch, even the last page gets copied. So not sure what
>> this change is really trying to achieve?
>>
> First, if it is a large folio in the swap cache, then its refcont is at
> least folio_nr_pages(folio) :  

Ahh! Sorry, I had it backwards - was thinking there would be 1 ref for the swap
cache, and you were assuming 1 ref per page taken by do_swap_page(). I
understand now. On this basis:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> 
> For example, in add_to_swap_cache path:
> 
> int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
>                         gfp_t gfp, void **shadowp)
> {
>         struct address_space *address_space = swap_address_space(entry);
>         pgoff_t idx = swp_offset(entry);
>         XA_STATE_ORDER(xas, &address_space->i_pages, idx,
> folio_order(folio));
>         unsigned long i, nr = folio_nr_pages(folio); <---
>         void *old;
>         ...
>         folio_ref_add(folio, nr); <---
>         folio_set_swapcache(folio);
>         ...
> }
> 
> 
>   *
> 
>     Then in the do_swap_page path:
> 
>   * if (should_try_to_free_swap(folio, vma, vmf->flags))
>             folio_free_swap(folio);
>   *
> 
>   * It also indicates that only folio in the swap cache will call
>     folio_free_swap
>   * to delete it from the swap cache, So I feel like this patch is
>     necessary!? 😁
> 
>>>  }
>>>  
>>>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> 
> Thanks,
> 
> Chuanhua
> 


