Return-Path: <linux-kernel+bounces-82929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE7868BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74A71C21F91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CFF13AA22;
	Tue, 27 Feb 2024 09:10:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46313A87C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025021; cv=none; b=aL8GiHOsB5WOynxh9WOAziqTpwgRRH+7lDgBul5uEs9wdVZekZwYuDYrMJncusEkZiuzlL7Jgei+46pQ0iYTTXsO+NHa6EgrT94a5pXeItb15S4jQbkdZ6PxYHyM9eS2yHgFnmBmYWJWom4nJBnIil04Rokc9gDYauooCOoTuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025021; c=relaxed/simple;
	bh=iKt/FJSJlIUobet9tOnZhP4EyVnmjjds2m/Rz82uPuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUjs7gGFNoGG2qczk+tkhVOVp/CQMomp3Po4XeGcUFK8MfHl5wwjStYDSS9QPjgAWiiJQ+8wDZOQiB3+qTQ6whbpvMrxh3Nn4U9E4xk6BT8APJKS2aIuc+AUk6U0bopb6ynLVUcV+tYr8ttlVutgPyLEWr0deOI2lUEb0/8jyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE808DA7;
	Tue, 27 Feb 2024 01:10:56 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01243F762;
	Tue, 27 Feb 2024 01:10:15 -0800 (PST)
Message-ID: <f6ee8263-ab8b-40f8-a40c-2badee58ae17@arm.com>
Date: Tue, 27 Feb 2024 09:10:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): allow split
 while folio_estimated_sharers = 0
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>,
 Vishal Moola <vishal.moola@gmail.com>, Yang Shi <shy828301@gmail.com>
References: <20240221085036.105621-1-21cnbao@gmail.com>
 <71fa4302-2df6-4e55-a5a8-7609476c41d4@arm.com>
 <CAGsJ_4wj_xcrMkw9+W79TpO73nPQx+rs=zPj7_5kWVMAvHUGTA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wj_xcrMkw9+W79TpO73nPQx+rs=zPj7_5kWVMAvHUGTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2024 21:17, Barry Song wrote:
> On Tue, Feb 27, 2024 at 2:46 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 21/02/2024 08:50, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> The purpose is stopping splitting large folios whose mapcount are 2 or
>>> above. Folios whose estimated_shares = 0 should be still perfect and
>>> even better candidates than estimated_shares = 1.
>>>
>>> Consider a pte-mapped large folio with 16 subpages, if we unmap 1-15,
>>> the current code will split folios and reclaim them while madvise goes
>>> on this folio; but if we unmap subpage 0, we will keep this folio and
>>> break. This is weird.
>>>
>>> For pmd-mapped large folios, we can still use "= 1" as the condition
>>> as anyway we have the entire map for it. So this patch doesn't change
>>> the condition for pmd-mapped large folios.
>>> This also explains why we had been using "= 1" for both pmd-mapped and
>>> pte-mapped large folios before commit 07e8c82b5eff ("madvise: convert
>>> madvise_cold_or_pageout_pte_range() to use folios"), because in the
>>> past, we used the mapcount of the specific subpage, since the subpage
>>> had pte present, its mapcount wouldn't be 0.
>>>
>>> The problem can be quite easily reproduced by writing a small program,
>>> unmapping the first subpage of a pte-mapped large folio vs. unmapping
>>> anyone other than the first subpage.
>>>
>>> Fixes: 2f406263e3e9 ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")
>>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>>> Cc: Yu Zhao <yuzhao@google.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>  mm/madvise.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>> index cfa5e7288261..abde3edb04f0 100644
>>> --- a/mm/madvise.c
>>> +++ b/mm/madvise.c
>>> @@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>               if (folio_test_large(folio)) {
>>>                       int err;
>>>
>>> -                     if (folio_estimated_sharers(folio) != 1)
>>> +                     if (folio_estimated_sharers(folio) > 1)
>>>                               break;
>>>                       if (pageout_anon_only_filter && !folio_test_anon(folio))
>>>                               break;
>>
>> I wonder if we should change all the instances:
>>
>> folio_estimated_sharers() != 1   ->   folio_estimated_sharers() > 1
>> folio_estimated_sharers() == 1   ->   folio_estimated_sharers() <= 1
>>
>> It shouldn't cause a problem for the pmd case, and there are definitely other
>> cases where it will help. e.g. madvise_free_pte_range().
> 
> right. My test case covered PAGEOUT only and I agree madvise_free and
> others have
> exactly the same issue. for pmd case, it doesn't matter whether we
> change the condition
> or not because we have already pmd-mapped in the page table.
> 
> And good to know David will have a wrapper in folio_mapped_shared()  to more
> widely address this issue.
> 
>>
>> Regardless:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>
> 
> Thanks though we might have missed your tag as this one has been
> in mm-stable.

No problem! I've been out on holiday so a bit behind on where everything is.

> 
> Best regards,
> Barry


