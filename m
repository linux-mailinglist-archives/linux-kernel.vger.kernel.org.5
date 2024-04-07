Return-Path: <linux-kernel+bounces-134208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E00389AEFA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CA51C21532
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA07483;
	Sun,  7 Apr 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RvIQ7f5j"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B87489
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473098; cv=none; b=rLDc5VW/DI2V+bFILy/dBUimvACkFdgFSNWkSJSJPvy2gPZqH1jp2+sFddCa0fzhuyaLIDTCfc3Dwm82m/kQY5dCCqx0H/teOf11/boVvrnahFEqWPBD39ABg+pv/75Bis7+i+M80FS4Ws+R87scG6I+wPkfJaodtFsAo5r7m7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473098; c=relaxed/simple;
	bh=TaNgPEqiKGl7DzwBOZcUc0XNLqFsrIeNAGpIOO0BTsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO5Cm73OfvtYDsumDMukGEbKahzpEh8ERfmJ2K5V/8M/706qy+DUWY3uZiKOG+6kNl3x/36NyjSSHx0TCGk3/kGXG4niaPLUeuVwoPx3oBxg58MI9jB3ML901qGZ4rVg81RloIuYQIBbDJDt1unvwcEFSL/zqaTcumB1CMnctcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RvIQ7f5j; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712473092; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=keZgjnQ9O+2hNdJMQ6VR91QK3KYWM4wdrpBYXw8no5M=;
	b=RvIQ7f5jjaSlelrNYF2fvq7zaKGNkyuIlQrzyMvElTxnhuFUvWLb3uoqW9f5gyT7SwUidH5ExOvcqOoQDDVzlFbBnXwSrdBE8DwT/M7iua1lmp8SBv66Ci0OgaCDoP8do9M8UhAnEd6QTSl6OWh7hPqr5dWukFFE2L683POmiVs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4.dlUx_1712473012;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W4.dlUx_1712473012)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 14:58:12 +0800
Message-ID: <e5282de6-4a44-45bf-95ed-7453da21191a@linux.alibaba.com>
Date: Sun, 7 Apr 2024 14:58:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] mm: page_alloc: fix freelist movement during block
 conversion
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>,
 Zi Yan <ziy@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-7-hannes@cmpxchg.org>
 <a97697e0-45b0-4f71-b087-fdc7a1d43c0e@linux.alibaba.com>
 <20240405165632.GA870124@cmpxchg.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240405165632.GA870124@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/6 00:56, Johannes Weiner wrote:
> Hi Baolin,
> 
> On Fri, Apr 05, 2024 at 08:11:47PM +0800, Baolin Wang wrote:
>> On 2024/3/21 02:02, Johannes Weiner wrote:
>>> @@ -2127,15 +2165,14 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>>>    				return page;
>>>    		}
>>>    	}
>>> -retry:
>>> +
>>>    	page = __rmqueue_smallest(zone, order, migratetype);
>>>    	if (unlikely(!page)) {
>>>    		if (alloc_flags & ALLOC_CMA)
>>>    			page = __rmqueue_cma_fallback(zone, order);
>>> -
>>> -		if (!page && __rmqueue_fallback(zone, order, migratetype,
>>> -								alloc_flags))
>>> -			goto retry;
>>> +		else
>>> +			page = __rmqueue_fallback(zone, order, migratetype,
>>> +						  alloc_flags);
>>
>> (Sorry for chim in late.)
>>
>> I have some doubts about the changes here. The original code logic was
>> that if the 'migratetype' type allocation is failed, it would first try
>> CMA page allocation and then attempt to fallback to other migratetype
>> allocations. Now it has been changed so that if CMA allocation fails, it
>> will directly return. This change has caused a regression when I running
>> the thpcompact benchmark, resulting in a significant reduction in the
>> percentage of THPs like below:
>>
>> thpcompact Percentage Faults Huge
>>                            K6.9-rc2                K6.9-rc2 + this patch
>> Percentage huge-1        78.18 (   0.00%)       42.49 ( -45.65%)
>> Percentage huge-3        86.70 (   0.00%)       35.13 ( -59.49%)
>> Percentage huge-5        90.26 (   0.00%)       52.35 ( -42.00%)
>> Percentage huge-7        92.34 (   0.00%)       31.84 ( -65.52%)
>> Percentage huge-12       91.18 (   0.00%)       45.85 ( -49.72%)
>> Percentage huge-18       89.00 (   0.00%)       29.18 ( -67.22%)
>> Percentage huge-24       90.52 (   0.00%)       46.68 ( -48.43%)
>> Percentage huge-30       94.44 (   0.00%)       38.35 ( -59.39%)
>> Percentage huge-32       93.09 (   0.00%)       39.37 ( -57.70%)
> 
> Ouch, sorry about that! I changed that specific part around later
> during development and didn't retest with CMA. I'll be sure to
> re-enable it again in my config.
> 
>> After making the following modifications, the regression is gone.
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index ce67dc6777fa..a7cfe65e45c1 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2139,7 +2139,8 @@ __rmqueue(struct zone *zone, unsigned int order,
>> int migratetype,
>>           if (unlikely(!page)) {
>>                   if (alloc_flags & ALLOC_CMA)
>>                           page = __rmqueue_cma_fallback(zone, order);
>> -               else
>> +
>> +               if (!page)
>>                           page = __rmqueue_fallback(zone, order, migratetype,
>>                                                     alloc_flags);
>>           }
>>
>> But I am not sure your original change is intentional? IIUC, we still
>> need try fallbacking even though CMA allocation is failed, please
>> correct me if I misunderstand your code. Thanks.
> 
> No, this was accidental. I missed that CMA dependency when changing
> things around for the new return type of __rmqueue_fallback(). Your
> fix is good: just because the request qualifies for CMA doesn't mean
> it will succeed from that region. We need the fallback for those.

OK. Thanks for the clarification.

> Andrew, could you please pick up Baolin's change for this patch?
> 
> [baolin.wang@linux.alibaba.com: fix allocation failures with CONFIG_CMA]
> 
> Thanks for debugging this and the fix, Baolin.

My pleasure.

