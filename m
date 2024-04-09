Return-Path: <linux-kernel+bounces-136396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6748889D399
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA281C213F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B07D3E6;
	Tue,  9 Apr 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZlPUGA7g"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BC7D3E0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649421; cv=none; b=O3U2yKTuRM452l6P/ccG8Wd77zC0MfXqfkvu+5KNkpyZzLPEPMoCBpGRzzs7D1oDwcqm5O0e/uUuY5ORXKnkYc1AqocYsaGui3zJmD4mH27XVbYCn6D0MmVBQb3/A/nsxyGDlR+R8k1aa/dujkVdI7FXjiU3mVAU9aRi6EKJhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649421; c=relaxed/simple;
	bh=t5FmYFYzWQ9RJeo7BaK1gAfzAUCxLHL+9UzuXF/vZJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYU4gBmPlFCfZViIWjBIyYBXTTf2pmmVolj9nbl65rUOp2vaJ0CFUWkf8u8Cnf3nfmGbnZRnviIOzIY2zcLQBbBnHqaXwGMpxe7CW2wxDoiI5kVWvj17ZwiQB7xVjh9ZWx9alRiZF0ynHZMLRbwp7OETd8kTsdupf194mVnzq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZlPUGA7g; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712649411; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=INwongVnxowhpCqzZ53uSvZGShNrUKje6qYjzu16WRc=;
	b=ZlPUGA7gJg79QppNCYap8XFF558yVAcMaY/qOtbXrSQqFO4pP540jup2IZlU2y+0FM1IDxT/Kf+t8iXHecdyDGjlQjX6rbCiI9W1Z6DUpDdmLLYw7euNSvWdnodTWi7K6RYhnYai0oge9fgwopr8khVVn0YSJCXEm4tYDB9LdBA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4DoHiL_1712649410;
Received: from 30.97.56.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W4DoHiL_1712649410)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 15:56:50 +0800
Message-ID: <dbdcc175-b825-42f1-9bd6-a7a15902d6a0@linux.alibaba.com>
Date: Tue, 9 Apr 2024 15:56:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
To: Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
 <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>
 <20240408142340.GA1057805@cmpxchg.org>
 <1cc1e3d1-4646-436c-92cb-f8584406bf88@suse.cz>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1cc1e3d1-4646-436c-92cb-f8584406bf88@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/9 14:23, Vlastimil Babka wrote:
> On 4/8/24 4:23 PM, Johannes Weiner wrote:
>> On Mon, Apr 08, 2024 at 09:38:20AM +0200, Vlastimil Babka wrote:
>>> On 4/7/24 12:19 PM, Baolin Wang wrote:
>>>> On 2024/3/21 02:02, Johannes Weiner wrote:
>>>>>    
>>>>> +	account_freepages(page, zone, 1 << order, migratetype);
>>>>> +
>>>>>    	while (order < MAX_PAGE_ORDER) {
>>>>> -		if (compaction_capture(capc, page, order, migratetype)) {
>>>>> -			__mod_zone_freepage_state(zone, -(1 << order),
>>>>> -								migratetype);
>>>>> +		int buddy_mt = migratetype;
>>>>> +
>>>>> +		if (compaction_capture(capc, page, order, migratetype))
>>>>>    			return;
>>>>> -		}
>>>>
>>>> IIUC, if the released page is captured by compaction, then the
>>>> statistics for free pages should be correspondingly decreased,
>>>> otherwise, there will be a slight regression for my thpcompact benchmark.
>>>>
>>>> thpcompact Percentage Faults Huge
>>>>                             k6.9-rc2-base        base + patch10 + 2 fixes	
>>>> Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
>>>> Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
>>>> Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
>>>> Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
>>>> Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
>>>> Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
>>>> Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
>>>> Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
>>>> Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)
>>>>
>>>> I add below fix based on your fix 2, then the thpcompact Percentage
>>>> looks good. How do you think for the fix?
>>>
>>> Yeah another well spotted, thanks. "slight regression" is an understatement,
>>> this affects not just a "statistics" but very important counter
>>> NR_FREE_PAGES which IIUC would eventually become larger than reality, make
>>> the watermark checks false positive and result in depleted reserves etc etc.
>>> Actually wondering why we're not seeing -next failures already (or maybe I
>>> just haven't noticed).
>>
>> Good catch indeed.
>>
>> Trying to understand why I didn't notice this during testing, and I
>> think it's because I had order-10 pageblocks in my config. There is
>> this in compaction_capture():
>>
>> 	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
>> 		return false;
>>
>> Most compaction is for order-9 THPs on movable blocks, so I didn't get
>> much capturing in practice in order for that leak to be noticable.
>>
>> In earlier versions of the patches I had more aggressive capturing,
>> but also did the accounting in add_page_to/del_page_from_freelist(),
>> so capturing only steals what's already accounted to be off list.
>>
>> With the __add/__del and the consolidated account_freepages()
>> optimization, compaction_capture() needs explicit accounting again.
>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 8330c5c2de6b..2facf844ef84 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -805,8 +805,10 @@ static inline void __free_one_page(struct page *page,
>>>>           while (order < MAX_PAGE_ORDER) {
>>>>                   int buddy_mt = migratetype;
>>>>
>>>> -               if (compaction_capture(capc, page, order, migratetype))
>>>> +               if (compaction_capture(capc, page, order, migratetype)) {
>>>> +                       account_freepages(zone, -(1 << order), migratetype);
>>>>                           return;
>>>> +               }
>>>>
>>>>                   buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
>>>>                   if (!buddy)
>>>>
>>>> With my fix, the THP percentage looks better:
>>>>                         k6.9-rc2-base          base + patch10 + 2 fixes	+
>>>> my fix
>>>> Percentage huge-1        78.18 (   0.00%)       82.83 (   5.94%)
>>>> Percentage huge-3        86.70 (   0.00%)       93.47 (   7.81%)
>>>> Percentage huge-5        90.26 (   0.00%)       94.73 (   4.95%)
>>>> Percentage huge-7        92.34 (   0.00%)       95.22 (   3.12%)
>>>> Percentage huge-12       91.18 (   0.00%)       92.40 (   1.34%)
>>>> Percentage huge-18       89.00 (   0.00%)       85.39 (  -4.06%)
>>>> Percentage huge-24       90.52 (   0.00%)       94.70 (   4.61%)
>>>> Percentage huge-30       94.44 (   0.00%)       97.00 (   2.71%)
>>>> Percentage huge-32       93.09 (   0.00%)       92.87 (  -0.24%)
>>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

>> With fixed indentation:
> 
> Maybe Baolin could resend the finalized 2 fixups in a more ready-to-pick form?

Sure, I've send it out.

And I see Andrew has already folded the first fix 
("mm-page_alloc-fix-freelist-movement-during-block-conversion-fix") into 
the patch set. If a formal fix patch is needed, Andrew, please let me know.

