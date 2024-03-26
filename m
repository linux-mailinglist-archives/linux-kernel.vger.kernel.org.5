Return-Path: <linux-kernel+bounces-119437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A8B88C8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257482E831F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C337413CA98;
	Tue, 26 Mar 2024 16:17:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12513C8E2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469842; cv=none; b=KTrb117Wdrn/Hp4YDeSm10ME0pYKqO/6IDqcJlJXvv2UlvRKHNHpmCSMowgAx4SbEIMaYZryQ+5Fn34ZXJ+CMUuPeSwk1DLMDNb73ZX4hQtmBHYatPHm6NKt6wdq8ra5AY7Kw9y+Kd3s5qoTdrkgjIA8Dq1tSXB6LCDl5r1ecFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469842; c=relaxed/simple;
	bh=Eo4uqpIyoqavyiinY7O48ueSVpp+jY+UAtDVkrKX52s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDItizFHp9a8OV5JH3N54KV1bjpFIwetgd797eZnVXMHfHJI7Q4VFR7/YuN+2HF50d41k25muL2d4cyEslvNz3AjD/ZCRydRryMcSPEinh2heAzipp/R2sZFf4X7T/FGNyMNfqmL/bryoiE97iCnht/u1zfnyga3Isi29Tvn33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F8792F4;
	Tue, 26 Mar 2024 09:17:52 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF9A3F694;
	Tue, 26 Mar 2024 09:17:15 -0700 (PDT)
Message-ID: <b63b965e-0aa1-4389-a7e0-badfe43e8dc5@arm.com>
Date: Tue, 26 Mar 2024 16:17:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: hold PTL from the first PTE while reclaiming a
 large folio
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, hanchuanhua@oppo.com, hughd@google.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com,
 v-songbaohua@oppo.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com
References: <20240306095219.71086-1-21cnbao@gmail.com>
 <cf16a19d-cc3b-4f19-a46f-83554a472368@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cf16a19d-cc3b-4f19-a46f-83554a472368@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 16:10, David Hildenbrand wrote:
> On 06.03.24 10:52, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> Within try_to_unmap_one(), page_vma_mapped_walk() races with other
>> PTE modifications preceded by pte clear. While iterating over PTEs
>> of a large folio, it only starts acquiring PTL from the first valid
>> (present) PTE. PTE modifications can temporarily set PTEs to
>> pte_none. Consequently, the initial PTEs of a large folio might
>> be skipped in try_to_unmap_one().
>> For example, for an anon folio, if we skip PTE0, we may have PTE0
>> which is still present, while PTE1 ~ PTE(nr_pages - 1) are swap
>> entries after try_to_unmap_one().
>> So folio will be still mapped, the folio fails to be reclaimed
>> and is put back to LRU in this round.
>> This also breaks up PTEs optimization such as CONT-PTE on this
>> large folio and may lead to accident folio_split() afterwards.
>> And since a part of PTEs are now swap entries, accessing those
>> parts will introduce overhead - do_swap_page.
>> Although the kernel can withstand all of the above issues, the
>> situation still seems quite awkward and warrants making it more
>> ideal.
>> The same race also occurs with small folios, but they have only
>> one PTE, thus, it won't be possible for them to be partially
>> unmapped.
>> This patch holds PTL from PTE0, allowing us to avoid reading PTE
>> values that are in the process of being transformed. With stable
>> PTE values, we can ensure that this large folio is either
>> completely reclaimed or that all PTEs remain untouched in this
>> round.
>> A corner case is that if we hold PTL from PTE0 and most initial
>> PTEs have been really unmapped before that, we may increase the
>> duration of holding PTL. Thus we only apply this optimization to
>> folios which are still entirely mapped (not in deferred_split
>> list).
>>
>> Cc: Hugh Dickins <hughd@google.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>   v2:
>>    * Refine commit message and code comment after reading all comments
>>      from Ryan and David, thanks!
>>    * Avoid increasing the duration of PTL by applying optimization
>>      on folios not in deferred_split_list with respect to Ying's
>>      comment, thanks!
>>
>>   mm/vmscan.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 0b888a2afa58..7106741387e8 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1270,6 +1270,18 @@ static unsigned int shrink_folio_list(struct list_head
>> *folio_list,
>>                 if (folio_test_pmd_mappable(folio))
>>                   flags |= TTU_SPLIT_HUGE_PMD;
>> +            /*
>> +             * Without TTU_SYNC, try_to_unmap will only begin to hold PTL
>> +             * from the first present PTE within a large folio. Some initial
>> +             * PTEs might be skipped due to races with parallel PTE writes
>> +             * in which PTEs can be cleared temporarily before being written
>> +             * new present values. This will lead to a large folio is still
>> +             * mapped while some subpages have been partially unmapped after
>> +             * try_to_unmap; TTU_SYNC helps try_to_unmap acquire PTL from the
>> +             * first PTE, eliminating the influence of temporary PTE values.
>> +             */
>> +            if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
>> +                flags |= TTU_SYNC;
>>                 try_to_unmap(folio, flags);
>>               if (folio_mapped(folio)) {
> 
> Hopefully this won't have unexpected performance "surprises".
> 
> I do wonder if we should really care about the "_deferred_list" optimization
> here, though, I'd just drop it.

I also concluded that we do need the data_race() annotation around list_empty()
if you do wind up keeping it. But I agree with David about dropping it.

> 
> In any case
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


