Return-Path: <linux-kernel+bounces-136570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506F89D59E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6D42832F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C679A7FBC2;
	Tue,  9 Apr 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YHSOJzlb"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3437FBB3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655081; cv=none; b=mxMiu3ZD6bAaIu3C8Peqy2VvDACIyMnagNSfUsBAReXghsAvq4NTmM97WA+lArqJ79atwBICIIs8eKGknYQ+Aj5ALTkB6TFeUbk4ka26Mvpz/4lpYFZqIq925bxmx6qSm7R1kvwSHomnTTPkzO23tripQSg5VTsJ2d7F4hcUPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655081; c=relaxed/simple;
	bh=FYgiFjXTdskLu0PMvm55ZF1Jor5HgrNNAHqGGsTKTh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJzykuF9zkpn7lqZTDv9tTwPtxu7WFrPs47kyD5cZqIekFlsFHKb7xkrhieXCOiBdknCthbahjo6CeHJhaeNzzpEdjdpp+PkDCFUA+bTqGVc7rgxVjfJqO6lsWJaNBFFa1B9TLwHPblKO4MNtMbTPIIeayV3lK7oA4R99vHLjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YHSOJzlb; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712655070; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0LnjQmyzNK4ZE6rezMRyW0SnrJ9XYzbVmvYfi+uWYb0=;
	b=YHSOJzlbeXbgD1O7XZ29pHpBPGy5AgQx4yYV2GCjXoud8t0jbGflSV3tz7BU2Wsgk1Z1Rkiebb2wHuFO5byNIUF/ZlSqX5uciESf/ZA14Vzb27Rh2trAsflGFgPzx5rOprW3ooatG9RlnEA1zG8R42RhZ0rOWAwqaKhUHNI7GgI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4E3E6q_1712655068;
Received: from 30.97.56.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W4E3E6q_1712655068)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 17:31:09 +0800
Message-ID: <26cb722f-6e1c-4aaf-9edd-ed10a60e0018@linux.alibaba.com>
Date: Tue, 9 Apr 2024 17:31:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
To: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
 <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>
 <20240408142340.GA1057805@cmpxchg.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240408142340.GA1057805@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/8 22:23, Johannes Weiner wrote:
> On Mon, Apr 08, 2024 at 09:38:20AM +0200, Vlastimil Babka wrote:
>> On 4/7/24 12:19 PM, Baolin Wang wrote:
>>> On 2024/3/21 02:02, Johannes Weiner wrote:
>>>>    
>>>> +	account_freepages(page, zone, 1 << order, migratetype);
>>>> +
>>>>    	while (order < MAX_PAGE_ORDER) {
>>>> -		if (compaction_capture(capc, page, order, migratetype)) {
>>>> -			__mod_zone_freepage_state(zone, -(1 << order),
>>>> -								migratetype);
>>>> +		int buddy_mt = migratetype;
>>>> +
>>>> +		if (compaction_capture(capc, page, order, migratetype))
>>>>    			return;
>>>> -		}
>>>
>>> IIUC, if the released page is captured by compaction, then the
>>> statistics for free pages should be correspondingly decreased,
>>> otherwise, there will be a slight regression for my thpcompact benchmark.
>>>
>>> thpcompact Percentage Faults Huge
>>>                             k6.9-rc2-base        base + patch10 + 2 fixes	
>>> Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
>>> Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
>>> Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
>>> Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
>>> Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
>>> Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
>>> Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
>>> Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
>>> Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)
>>>
>>> I add below fix based on your fix 2, then the thpcompact Percentage
>>> looks good. How do you think for the fix?
>>
>> Yeah another well spotted, thanks. "slight regression" is an understatement,
>> this affects not just a "statistics" but very important counter
>> NR_FREE_PAGES which IIUC would eventually become larger than reality, make
>> the watermark checks false positive and result in depleted reserves etc etc.
>> Actually wondering why we're not seeing -next failures already (or maybe I
>> just haven't noticed).
> 
> Good catch indeed.
> 
> Trying to understand why I didn't notice this during testing, and I
> think it's because I had order-10 pageblocks in my config. There is
> this in compaction_capture():
> 
> 	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
> 		return false;
> 
> Most compaction is for order-9 THPs on movable blocks, so I didn't get
> much capturing in practice in order for that leak to be noticable.

This makes me wonder why not use 'cc->migratetype' for migratetype 
comparison, so that low-order (like mTHP) compaction can directly get 
the released pages, which could avoid some compaction scans without 
mixing the migratetype?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2facf844ef84..7a64020f8222 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -622,7 +622,7 @@ compaction_capture(struct capture_control *capc, 
struct page *page,
          * and vice-versa but no more than normal fallback logic which can
          * have trouble finding a high-order free page.
          */
-       if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
+       if (order < pageblock_order && capc->cc->migratetype != migratetype)
                 return false;

         capc->page = page;

