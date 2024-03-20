Return-Path: <linux-kernel+bounces-108977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2021C8812C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62CAEB24AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347542065;
	Wed, 20 Mar 2024 13:57:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76183FE23
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943047; cv=none; b=pO3jltS7RQIu1Ks8ct29MDQGuuN2a3EiFvV2ekZErJSnuN+Aiz3oUknJkGK5mXc7gLMEoIXwgM+B1JGhq9UAlq7toJfMeWCWWHY5eNSzw8TZNYFbgjwuwFQl1ZtULBCWA9mj6AxSGfhQxkiZDgA7SHpufXQnMnJo7mui/iw1ViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943047; c=relaxed/simple;
	bh=kHPz1EElqflbe3FM3dpaHqlVoQzEWqMlyaZlYH4LXDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KojdiNtARtw+wwG7CB6EEEkEs5ONZFDocMpkgqSwubJgDLqPwW7F9amx6HGC7AmiVUhjvd/u/VWAep4Kb+x5REM35FdZekd8lEZ8Fle/ffxMp9KETTjqHYcjPCnmsWfWvGV+72HIvezMKu9e/uq0cpwrYb1DbcuNMmjaDAjnLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7C3A1007;
	Wed, 20 Mar 2024 06:57:59 -0700 (PDT)
Received: from [10.57.72.78] (unknown [10.57.72.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C1B83F64C;
	Wed, 20 Mar 2024 06:57:22 -0700 (PDT)
Message-ID: <9ce7b66f-f84e-4e94-863c-2f02dcff4bd3@arm.com>
Date: Wed, 20 Mar 2024 13:57:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and
 MADV_COLD
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com>
 <ffeee7da-e625-40dc-8da8-b70e4e6ef935@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ffeee7da-e625-40dc-8da8-b70e4e6ef935@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/03/2024 10:35, David Hildenbrand wrote:
>> -        if (!pageout && pte_young(ptent)) {
>> -            ptent = ptep_get_and_clear_full(mm, addr, pte,
>> -                            tlb->fullmm);
>> -            ptent = pte_mkold(ptent);
>> -            set_pte_at(mm, addr, pte, ptent);
>> -            tlb_remove_tlb_entry(tlb, pte, addr);
>> +        if (!pageout) {
>> +            for (; nr != 0; nr--, pte++, addr += PAGE_SIZE) {
>> +                if (ptep_test_and_clear_young(vma, addr, pte))
>> +                    tlb_remove_tlb_entry(tlb, pte, addr);
>> +            }
>>           }
> 
> 
> The following might turn out a bit nicer: Make folio_pte_batch() collect
> "any_young", then doing something like we do with "any_writable" in the fork()
> case:
> 
> ...
>     nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
>                  fpb_flags, NULL, any_young);
>     if (any_young)
>         pte_mkyoung(ptent)
> ...
> 
> if (!pageout && pte_young(ptent)) {
>     mkold_full_ptes(mm, addr, pte, nr, tlb->fullmm);

I don't think tlb->fullmm makes sense here because we are not clearing the pte,
so there is no chance of optimization? So planning to call this mkold_ptes() and
remove that param. Have I missed something?

>     tlb_remove_tlb_entries(tlb, pte, nr, addr);
> }
> 


