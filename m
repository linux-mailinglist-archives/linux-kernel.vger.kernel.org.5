Return-Path: <linux-kernel+bounces-104286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BD87CBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564D3283A47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8621B5B1;
	Fri, 15 Mar 2024 10:49:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D8A1B59D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499770; cv=none; b=j2Y1kF83nXNEL8mtUgUGwC78bCRLT1d+GTVU1Asgd+WppUyQNve3atD2KVDpsqCbaKHrYm+HdKwjHEYOoix9IOig8HNeXBs4QqIiQqxMLqj2i6DqmrQaAHr4DWZOZuxxGDJGJlUgC2S04ksijv4IMaj0HD1lkENsUyEAngkIwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499770; c=relaxed/simple;
	bh=zWIzkz2a8WN8xkBFFysmUJVqxR7TWEnCjfwryFytUEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuZh/B9EzUynXkNlYYx7JwyVtYFacnjnrGDjtk6bsl1MoaZW/OuxWCG9hrHh8lMQKYW20jhhDAtySY2bS6X0p90BAXNgKbKOKDdM+p/kqwkTD+CFKGyoNwJIvmBwT5G7ezCXv8HfySl2GlcO2leXPDhtjxfHBFJ8aRMGQqakabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E58DC15;
	Fri, 15 Mar 2024 03:49:57 -0700 (PDT)
Received: from [10.57.69.160] (unknown [10.57.69.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E9D23F762;
	Fri, 15 Mar 2024 03:49:19 -0700 (PDT)
Message-ID: <1db242d3-5ff1-4ef5-b20a-578a317fa859@arm.com>
Date: Fri, 15 Mar 2024 10:49:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
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
 <20240311150058.1122862-6-ryan.roberts@arm.com>
 <d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/03/2024 10:43, David Hildenbrand wrote:
> On 11.03.24 16:00, Ryan Roberts wrote:
>> Now that swap supports storing all mTHP sizes, avoid splitting large
>> folios before swap-out. This benefits performance of the swap-out path
>> by eliding split_folio_to_list(), which is expensive, and also sets us
>> up for swapping in large folios in a future series.
>>
>> If the folio is partially mapped, we continue to split it since we want
>> to avoid the extra IO overhead and storage of writing out pages
>> uneccessarily.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   mm/vmscan.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index cf7d4cf47f1a..0ebec99e04c6 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct list_head
>> *folio_list,
>>                       if (!can_split_folio(folio, NULL))
>>                           goto activate_locked;
>>                       /*
>> -                     * Split folios without a PMD map right
>> -                     * away. Chances are some or all of the
>> -                     * tail pages can be freed without IO.
>> +                     * Split partially mapped folios map
>> +                     * right away. Chances are some or all
>> +                     * of the tail pages can be freed
>> +                     * without IO.
>>                        */
>> -                    if (!folio_entire_mapcount(folio) &&
>> +                    if (!list_empty(&folio->_deferred_list) &&
>>                           split_folio_to_list(folio,
>>                                   folio_list))
>>                           goto activate_locked;
> 
> Not sure if we might have to annotate that with data_race().

I asked that exact question to Matthew in another context bt didn't get a
response. There are examples of checking if the deferred list is empty with and
without data_race() in the code base. But list_empty() is implemented like this:

static inline int list_empty(const struct list_head *head)
{
	return READ_ONCE(head->next) == head;
}

So I assumed the READ_ONCE() makes everything safe without a lock? Perhaps not
sufficient for KCSAN?


> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks!

