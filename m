Return-Path: <linux-kernel+bounces-138201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5889EDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAF3B20FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE49154BFF;
	Wed, 10 Apr 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gHQ8sX38"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94413C90D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738990; cv=none; b=hWeejR8xlqKVv0+5bKdlvcy3rKQ7WIvUc0DRtJOU7SRi92R1sz+yxj2Cft9nJf6osfg/IMVOfTP84fIrSwDX/ZJ6gqV+pCrEy3mPC6eL9FInOtoUQ/RVXxparL78R2n3pXB53GXdGgA0hLP/OUtXuV00r1XvDVDxSkWxK6bB+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738990; c=relaxed/simple;
	bh=EuhUqKyi42jKQ13Gy6Zb/ZHyS6A85KCmaQdG5z7UwXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwX5RwXccJQ2u/ojTLeqdDuJMbCubK2C1YHNIqDdRxg0hOu6kHWxoeMNjVpHW0GF/HpVqpCSzmOiypYmzA3RqAMzwMkKcAuEiipSxDHmU9EKU9LRcIJjPci2R7d8p5C+oYw10UQqC656obYeMjdX3GyAahynFA+wEYG41sr3yIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gHQ8sX38; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712738984; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zi64y6gftwEUpOYycPmnGWa28oBRzWmtl7QJD3qYI3A=;
	b=gHQ8sX38ka0Y/NtcChoLO3BQM3JDdurGMFPbPGtwMoIzv6HV2+IpccsNeu3hWiriMM0MIx4pG6sP3GvBNvXhGRfEzcF5u6xii/wwOImney5Y0eZE3bFjvJi8aGIvemBbGiz6pvGgWnOSt9eJ+sHZJ0xfGhb+C+zwz7Qb5L1F104=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4HDLKP_1712738983;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W4HDLKP_1712738983)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 16:49:44 +0800
Message-ID: <093e883e-4ac5-4772-9a85-0117c2d990f6@linux.alibaba.com>
Date: Wed, 10 Apr 2024 16:49:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
To: Zi Yan <ziy@nvidia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, "Huang, Ying"
 <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
 <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>
 <20240408142340.GA1057805@cmpxchg.org>
 <26cb722f-6e1c-4aaf-9edd-ed10a60e0018@linux.alibaba.com>
 <FA55690D-0532-48DE-A929-5FECCB667C86@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <FA55690D-0532-48DE-A929-5FECCB667C86@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/9 22:46, Zi Yan wrote:
> On 9 Apr 2024, at 5:31, Baolin Wang wrote:
> 
>> On 2024/4/8 22:23, Johannes Weiner wrote:
>>> On Mon, Apr 08, 2024 at 09:38:20AM +0200, Vlastimil Babka wrote:
>>>> On 4/7/24 12:19 PM, Baolin Wang wrote:
>>>>> On 2024/3/21 02:02, Johannes Weiner wrote:
>>>>>>    +	account_freepages(page, zone, 1 << order, migratetype);
>>>>>> +
>>>>>>     	while (order < MAX_PAGE_ORDER) {
>>>>>> -		if (compaction_capture(capc, page, order, migratetype)) {
>>>>>> -			__mod_zone_freepage_state(zone, -(1 << order),
>>>>>> -								migratetype);
>>>>>> +		int buddy_mt = migratetype;
>>>>>> +
>>>>>> +		if (compaction_capture(capc, page, order, migratetype))
>>>>>>     			return;
>>>>>> -		}
>>>>>
>>>>> IIUC, if the released page is captured by compaction, then the
>>>>> statistics for free pages should be correspondingly decreased,
>>>>> otherwise, there will be a slight regression for my thpcompact benchmark.
>>>>>
>>>>> thpcompact Percentage Faults Huge
>>>>>                              k6.9-rc2-base        base + patch10 + 2 fixes	
>>>>> Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
>>>>> Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
>>>>> Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
>>>>> Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
>>>>> Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
>>>>> Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
>>>>> Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
>>>>> Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
>>>>> Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)
>>>>>
>>>>> I add below fix based on your fix 2, then the thpcompact Percentage
>>>>> looks good. How do you think for the fix?
>>>>
>>>> Yeah another well spotted, thanks. "slight regression" is an understatement,
>>>> this affects not just a "statistics" but very important counter
>>>> NR_FREE_PAGES which IIUC would eventually become larger than reality, make
>>>> the watermark checks false positive and result in depleted reserves etc etc.
>>>> Actually wondering why we're not seeing -next failures already (or maybe I
>>>> just haven't noticed).
>>>
>>> Good catch indeed.
>>>
>>> Trying to understand why I didn't notice this during testing, and I
>>> think it's because I had order-10 pageblocks in my config. There is
>>> this in compaction_capture():
>>>
>>> 	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
>>> 		return false;
>>>
>>> Most compaction is for order-9 THPs on movable blocks, so I didn't get
>>> much capturing in practice in order for that leak to be noticable.
>>
>> This makes me wonder why not use 'cc->migratetype' for migratetype comparison, so that low-order (like mTHP) compaction can directly get the released pages, which could avoid some compaction scans without mixing the migratetype?
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 2facf844ef84..7a64020f8222 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -622,7 +622,7 @@ compaction_capture(struct capture_control *capc, struct page *page,
>>           * and vice-versa but no more than normal fallback logic which can
>>           * have trouble finding a high-order free page.
>>           */
>> -       if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
>> +       if (order < pageblock_order && capc->cc->migratetype != migratetype)
>>                  return false;
>>
>>          capc->page = page;
> 
> It is worth trying, since at the original patch time mTHP was not present and
> not capturing any MIGRATE_MOVABLE makes sense. But with your change, the capture
> will lose the opportunity of letting an unmovable request use a reclaimable
> pageblock and vice-versa, like the comment says. Please change the comment
> as well and we should monitor potential unmovable and reclaimable regression.

Yes, but I think this case is easy to solve. Anyway let me try to do 
some measurement for mTHP.

