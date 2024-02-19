Return-Path: <linux-kernel+bounces-70665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5EB859AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1CA1C21027
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE852114;
	Mon, 19 Feb 2024 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mA8/dNu+"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD611FC8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708311365; cv=none; b=B1wvf3iGqjmjRYZ5JNwUm/VHNTQXoIBx8bzJHe8/nlk2Zz80wwimuUd3P+1kY+NhwDT7Lf/FK9pFsQePEPUd6vH6Zd8NyJcGAWpe6DCc73jbmJTR4bfHPo0SEB7dqgGjfZ9jWhdX71oBSW7uux5ogIU9cX2Jx7hwLISK2HYrBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708311365; c=relaxed/simple;
	bh=9I3/khzFwIbdzXjPtuKVOdiJu0VzmQlOsKemxYS09TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz6U0X/BdO12knZBT5mix85ScoWCjji3IlyUqOT7TBeN0aNvhI0nJhCW8o/Olc/wjgc8RURJq3pyhWlB5D5Luc+FXoy+9CahAf9Qb6bxc9+WDOqhaNOujUmBHxYZg6TKqG6F1fC1Ixe/XKBd7cUVMmZE+Euls+lr2IyUX+fyzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mA8/dNu+; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708311360; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yQrlVUbCNycovOpvidI2cU4GO80wwX6nTyqP1bcvxIc=;
	b=mA8/dNu+PbaXczsmCXl1lKeRVO5+gN6ORC0Cs1wz4PURyYKrBTtrRzGZvzh9VsLBNQqf24X/m39ePItXdBJMPmvMz2TMYFkD3L0D9nm4+y+E7qI/SXGm1N1VNAVqI7hy4J86DgSzxthWwtmVA+llH34zEkJqJan0/FQuuF3zExU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W0mvt6V_1708311359;
Received: from 30.97.56.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0mvt6V_1708311359)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 10:56:00 +0800
Message-ID: <83bc1070-2eb4-4fac-aecf-9cc407003ca2@linux.alibaba.com>
Date: Mon, 19 Feb 2024 10:55:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: compaction: limit the suitable target page order
 to be less than cc->order
To: Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
 <20c8fa7c-62ae-4e48-aaec-8b512519cee9@suse.cz>
 <5277627F-6791-46A1-AFC2-54FBF0DABF1A@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5277627F-6791-46A1-AFC2-54FBF0DABF1A@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/12 23:00, Zi Yan wrote:
> On 12 Feb 2024, at 4:13, Vlastimil Babka wrote:
> 
>> On 1/22/24 14:01, Baolin Wang wrote:
>>> It can not improve the fragmentation if we isolate the target free pages
>>> exceeding cc->order, especially when the cc->order is less than pageblock_order.
>>> For example, suppose the pageblock_order is MAX_ORDER (size is 4M) and cc->order
>>> is 2M THP size, we should not isolate other 2M free pages to be the migration
>>> target, which can not improve the fragmentation.
>>>
>>> Moreover this is also applicable for large folio compaction.
>>
>> So why not Cc: Zi Yan? (done)
>>
> 
> Thanks.
> 
> Hi Baolin,
> 
> How often do you see this happening?

This is theoretically analyzed from the code inspection.

>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> I doubt this will make much difference, because if such a larger order free
>> page exists, we shouldn't have a reason to be compacting for a lower order
>> in the first place?
> 
> Unless kswapd gets us such a free block in the background right after
> get_page_from_freelist() and before compaction finishes in the allocation
> slow path.
> 
> If this happens often and cc->order is not -1, it might be better to stop
> compaction and get_page_from_freelist() to save cycles on unnecessary pfn
> scanning. For completeness, when cc->order == -1, the logic does not change.

Yes, this is one possible case. There are also some other concurrent 
scenarios, such as when compaction is running (after 
compaction_suitable()), at the same time, other applications release a 
large folio to the free list. In this case, the free large folio 
scanning should also be avoided.

>>> ---
>>>   mm/compaction.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 27ada42924d5..066b72b3471a 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -1346,12 +1346,14 @@ static bool suitable_migration_target(struct compact_control *cc,
>>>   {
>>>   	/* If the page is a large free page, then disallow migration */
>>>   	if (PageBuddy(page)) {
>>> +		int order = cc->order > 0 ? cc->order : pageblock_order;
>>> +
>>>   		/*
>>>   		 * We are checking page_order without zone->lock taken. But
>>>   		 * the only small danger is that we skip a potentially suitable
>>>   		 * pageblock, so it's not worth to check order for valid range.
>>>   		 */
>>> -		if (buddy_order_unsafe(page) >= pageblock_order)
>>> +		if (buddy_order_unsafe(page) >= order)
>>>   			return false;
>>>   	}
>>>
> 
> 
> --
> Best Regards,
> Yan, Zi

