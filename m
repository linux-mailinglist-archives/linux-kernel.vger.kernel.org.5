Return-Path: <linux-kernel+bounces-70654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BD859ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32351F21563
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4271FC8;
	Mon, 19 Feb 2024 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N4qwP1kb"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41640EDD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708310079; cv=none; b=bIY0FmBYx8coZx2YzsGAh07p5P6En5VDVfq8utIC6xEAL8Mbtzv2s3bqI8IJwTKtgxtcVtGnbtGqxsG2QGG2p2YKoPo2CG3BZymdhTwcwUmz5jTbaOKz+cAW4YI4ZrSzqsamWjXYmMJGdW9zVmMpfF0tC4BgbgSvIMVheXcCT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708310079; c=relaxed/simple;
	bh=JeyK8A25Fachxr6Owd8b2m5jXCqZjqnuLwNUU7e3iic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeAefGg3FMpRGmdImPQW0kGuZgMgW4AmxHRQreOABzfxDQ60g0Yh1ZYNuoGSMvH/LNNBZ+FvJI13M7CccgERHQu0xfS01K+khOl9NlYr0J6atebvrJuD34frVdCbhVm9oJin29ZDRKkqvpw0i6AJ1vTqkzYWQThUDHgrbqaOtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N4qwP1kb; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708310068; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HJJiNC7u8LJvikP1pwnY9KUsvCMk8b/lQNjyfCPmCtU=;
	b=N4qwP1kb5leMSFxZnRZ+RvxDa6b7M+F8CWTGkOOGVXS+ppFb+OuAACY/NPt/9ldxijncnyzqv7IeRbx4DwSwOtppIxl+QXapXz9uXPpI6zs50rSEjN8PvqulYjr4ZcxLjmr6f2YObjJT3lLIJRG17JCIDQf1DoZQ8TGDz53F0Js=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W0moMY8_1708310067;
Received: from 30.97.56.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0moMY8_1708310067)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 10:34:28 +0800
Message-ID: <92e272d5-34e4-47f0-88ee-95b8a25ffd3d@linux.alibaba.com>
Date: Mon, 19 Feb 2024 10:34:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: compaction: update the cc->nr_migratepages when
 allocating or freeing the freepages
To: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
 Zi Yan <ziy@nvidia.com>
Cc: mgorman@techsingularity.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
 <0773058df022fa701b78f9a6dfe3c501a1a77351.1705928395.git.baolin.wang@linux.alibaba.com>
 <7f34e789-e01f-4929-a618-b73c04ebf4d2@suse.cz>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <7f34e789-e01f-4929-a618-b73c04ebf4d2@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/12 18:32, Vlastimil Babka wrote:
> On 1/22/24 14:01, Baolin Wang wrote:
>> Currently we will use 'cc->nr_freepages >= cc->nr_migratepages' comparison
>> to ensure that enough freepages are isolated in isolate_freepages(), however
>> it just decreases the cc->nr_freepages without updating cc->nr_migratepages
>> in compaction_alloc(), which will waste more CPU cycles and cause too many
>> freepages to be isolated.
> 
> Hm yeah I guess this can happen with fast_isolate_freepages() if it returns
> with something but not all the freepages that are expected to be needed, and
> then we get to isolate_freepages() again.

Yes.

> 
>> So we should also update the cc->nr_migratepages when allocating or freeing
>> the freepages to avoid isolating excess freepages. And I can see fewer free
>> pages are scanned and isolated when running thpcompact on my Arm64 server:
>>                                         k6.7         k6.7_patched
>> Ops Compaction pages isolated      120692036.00   118160797.00
>> Ops Compaction migrate scanned     131210329.00   154093268.00
>> Ops Compaction free scanned       1090587971.00  1080632536.00
>> Ops Compact scan efficiency               12.03          14.26
>>
>> Moreover, I did not see an obvious latency improvements, this is likely because
>> isolating freepages is not the bottleneck in the thpcompact test case.
>>                                k6.7                  k6.7_patched
>> Amean     fault-both-1      1089.76 (   0.00%)     1080.16 *   0.88%*
>> Amean     fault-both-3      1616.48 (   0.00%)     1636.65 *  -1.25%*
>> Amean     fault-both-5      2266.66 (   0.00%)     2219.20 *   2.09%*
>> Amean     fault-both-7      2909.84 (   0.00%)     2801.90 *   3.71%*
>> Amean     fault-both-12     4861.26 (   0.00%)     4733.25 *   2.63%*
>> Amean     fault-both-18     7351.11 (   0.00%)     6950.51 *   5.45%*
>> Amean     fault-both-24     9059.30 (   0.00%)     9159.99 *  -1.11%*
>> Amean     fault-both-30    10685.68 (   0.00%)    11399.02 *  -6.68%*
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/compaction.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 066b72b3471a..6c84e3a5b32b 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1779,6 +1779,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>>   	dst = list_entry(cc->freepages.next, struct folio, lru);
>>   	list_del(&dst->lru);
>>   	cc->nr_freepages--;
>> +	cc->nr_migratepages--;
> 
> This is breaking the tracepoint TRACE_EVENT(mm_compaction_migratepages)
> which does
> 
> __entry->nr_failed = cc->nr_migratepages - nr_succeeded;
> 
> and is called after migrate_pages() finishes, so now this will underflow.
> 
> Probably need to get a snapshot of cc->nr_migratepages before calling
> migrate_pages() and then feed that to the tracepoint instead of cc.

Ah, good catch. Will fix in next version. Thanks.

