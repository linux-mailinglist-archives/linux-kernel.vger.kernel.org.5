Return-Path: <linux-kernel+bounces-120620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1674E88DA60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E59DB21909
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EA2381C1;
	Wed, 27 Mar 2024 09:39:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD4018E2A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532380; cv=none; b=kaCIqVgYGKOYodKxArxPYiBkS4Oa0mOeUDrI6k4IV8qENMbKSTzMC7SSytC0Im4iLZocO+zVTk84FCTA7PF6YJOQAHxZhNhFIlUpopoQwEVaVy0LXX1JblwAL7TUW8IODpFvecqN0ugMONRcYa4Geiu9eg5hsuA4oVryR5FSjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532380; c=relaxed/simple;
	bh=ZZzvx08FUI2ZF5uAa1WqbNUXgGRd5i/GiFY/fsRl5fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbRA+DQGPIiyfGKNHUu7S4cZKsOQdMoV2xHkgM/xuPpjRhfp3bKhDbPHFyoniDIkapQ0avRiAKco2QZf7BGKK9acD+dEwhrSqF1vHUcDTIC45Qv7ujXg18XYLoPy/NmT6vsHE0bLP5wBGctMkJZlU3yap7w8s3rcXW4UNWuRZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B8E2F4;
	Wed, 27 Mar 2024 02:40:11 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0691C3F7C5;
	Wed, 27 Mar 2024 02:39:34 -0700 (PDT)
Message-ID: <7ab73804-4f9b-44d3-b473-760a33460eae@arm.com>
Date: Wed, 27 Mar 2024 09:39:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] mm/swap: always use swap cache for
 synchronization
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
 Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>,
 SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20240326185032.72159-1-ryncsn@gmail.com>
 <878r24o07p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMgjq7B4Aejv16XK-zm9zPFrtVV1YutYWk5Ywzy8GwfMsTAXgA@mail.gmail.com>
 <58e4f0c2-99d1-42b9-ab70-907cf35ac1a7@arm.com>
 <87a5mkm5wg.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87a5mkm5wg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 08:32, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> [...]
>>
>>>>> Test 1, sequential swapin/out of 30G zero page on ZRAM:
>>>>>
>>>>>                Before (us)        After (us)
>>>>> Swapout:       33619409           33886008
>>>>> Swapin:        32393771           32465441 (- 0.2%)
>>>>> Swapout (THP): 7817909            6899938  (+11.8%)
>>>>> Swapin (THP) : 32452387           33193479 (- 2.2%)
>>>>
>>>> If my understanding were correct, we don't have swapin (THP) support,
>>>> yet.  Right?
>>>
>>> Yes, this series doesn't change how swapin/swapout works with THP in
>>> general, but now THP swapout will leave shadows with large order, so
>>> it needs to be splitted upon swapin, that will slow down later swapin
>>> by a little bit but I think that's worth it.
>>>
>>> If we can do THP swapin in the future, this split on swapin can be
>>> saved to make the performance even better.
>>
>> I'm confused by this (clearly my understanding of how this works is incorrect).
>> Perhaps you can help me understand:
>>
>> When you talk about "shadows" I assume you are referring to the swap cache? It
>> was my understanding that swapping out a THP would always leave the large folio
>> in the swap cache, so this is nothing new?
>>
>> And on swap-in, if the target page is in the swap cache, even if part of a large
>> folio, why does it need to be split? I assumed the single page would just be
>> mapped? (and if all the other pages subsequently fault, then you end up with a
>> fully mapped large folio back in the process)?
>>
>> Perhaps I'm misunderstanding what "shadows" are?
> 
> Perhaps, shadow is used to support workingset protection/detection on
> the anonymous LRU list as in the following patchset (merged).
> 
> https://lore.kernel.org/all/1595490560-15117-5-git-send-email-iamjoonsoo.kim@lge.com/T/#m962395eb5968c74b0c4c8e41d4b0dcdd3f28b2e6

Thanks! Although after reading the cover letter I still don't really understand
the need for splitting. The LRU applies to whole folios.


> 
> --
> Best Regards,
> Huang, Ying


