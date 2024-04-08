Return-Path: <linux-kernel+bounces-135115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45D89BB54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC79E28184E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930493FB83;
	Mon,  8 Apr 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sskiNhnO"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1234CDE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567646; cv=none; b=Xy+2NTI2QnLEFOI274W+9DgedNvglpmdw38ms+/61dBTHuYIyv6W2HdA5RquvLab7f7gD2ML/hE6jybDI/3vqSF/d8a+oBC45Nu96MBRy8myIm3QyPT2rdeGgibStrdzC8CDt3Y1mRo/6t58YnSBJqUm8D712+ksF3aVZPF6x28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567646; c=relaxed/simple;
	bh=8+I33Q7W7iw315CemMmiCzk+goWkzaVeSs5DNZuhE5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imZROLSlgV80Qwv5StBdpwEkoe3kFp+4mFR6qIaHc5QKl+HuTjqs3yEsJIUjA/75hA1/E1eZqUWrnVc1C2b2QmFDH6OEOj1hkL77UKFElVWq5Acv/yCE2Om/afPvBV62EnNA2hS6slvkcTlYYeubE4kH3w6kaFXsIYjTeAx6+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sskiNhnO; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712567635; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=K6qk+9ggjcNMTTz30BtXi3bL/FtbPiUNAq+6RisDvL0=;
	b=sskiNhnOELfdDhMzxz1CxYeQmMeTKW/ZTmd9BzUWBuaUz5N+AGe83ppE/SC001zvvErfghgujJpGL73i+hs4nRTyon+COn767kOJZKtsjxAdrM00fL0XMjSSrPwMYL3yOh0kmSIBCKob6WrxkdFRm/eFWrrSCu3I9IfgUm/pUcM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W46vhRi_1712567634;
Received: from 30.97.56.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W46vhRi_1712567634)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 17:13:55 +0800
Message-ID: <8c811ea8-f4ea-4f0f-91f8-3bc798a19407@linux.alibaba.com>
Date: Mon, 8 Apr 2024 17:13:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
To: Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
 <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/8 15:38, Vlastimil Babka wrote:
> On 4/7/24 12:19 PM, Baolin Wang wrote:
>> On 2024/3/21 02:02, Johannes Weiner wrote:
>>>    
>>> +	account_freepages(page, zone, 1 << order, migratetype);
>>> +
>>>    	while (order < MAX_PAGE_ORDER) {
>>> -		if (compaction_capture(capc, page, order, migratetype)) {
>>> -			__mod_zone_freepage_state(zone, -(1 << order),
>>> -								migratetype);
>>> +		int buddy_mt = migratetype;
>>> +
>>> +		if (compaction_capture(capc, page, order, migratetype))
>>>    			return;
>>> -		}
>>
>> IIUC, if the released page is captured by compaction, then the
>> statistics for free pages should be correspondingly decreased,
>> otherwise, there will be a slight regression for my thpcompact benchmark.
>>
>> thpcompact Percentage Faults Huge
>>                             k6.9-rc2-base        base + patch10 + 2 fixes	
>> Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
>> Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
>> Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
>> Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
>> Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
>> Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
>> Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
>> Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
>> Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)
>>
>> I add below fix based on your fix 2, then the thpcompact Percentage
>> looks good. How do you think for the fix?
> 
> Yeah another well spotted, thanks. "slight regression" is an understatement,

Thanks for helping to confirm.

> this affects not just a "statistics" but very important counter
> NR_FREE_PAGES which IIUC would eventually become larger than reality, make
> the watermark checks false positive and result in depleted reserves etc etc.

Right, agree.

> Actually wondering why we're not seeing -next failures already (or maybe I
> just haven't noticed).
> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 8330c5c2de6b..2facf844ef84 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -805,8 +805,10 @@ static inline void __free_one_page(struct page *page,
>>           while (order < MAX_PAGE_ORDER) {
>>                   int buddy_mt = migratetype;
>>
>> -               if (compaction_capture(capc, page, order, migratetype))
>> +               if (compaction_capture(capc, page, order, migratetype)) {
>> +                       account_freepages(zone, -(1 << order), migratetype);
>>                           return;
>> +               }
>>
>>                   buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
>>                   if (!buddy)
>>
>> With my fix, the THP percentage looks better:
>>                         k6.9-rc2-base          base + patch10 + 2 fixes	+
>> my fix
>> Percentage huge-1        78.18 (   0.00%)       82.83 (   5.94%)
>> Percentage huge-3        86.70 (   0.00%)       93.47 (   7.81%)
>> Percentage huge-5        90.26 (   0.00%)       94.73 (   4.95%)
>> Percentage huge-7        92.34 (   0.00%)       95.22 (   3.12%)
>> Percentage huge-12       91.18 (   0.00%)       92.40 (   1.34%)
>> Percentage huge-18       89.00 (   0.00%)       85.39 (  -4.06%)
>> Percentage huge-24       90.52 (   0.00%)       94.70 (   4.61%)
>> Percentage huge-30       94.44 (   0.00%)       97.00 (   2.71%)
>> Percentage huge-32       93.09 (   0.00%)       92.87 (  -0.24%)

