Return-Path: <linux-kernel+bounces-34628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0630883855F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3911F295C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDDB2582;
	Tue, 23 Jan 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BCY2542/"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3362109
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975970; cv=none; b=WV5SfKqRJggDnMo6yGU1XsBPcn5kzvU4nBP8I67Iad2dr6WjOz+253wnoOpz3uLwdij+Ku/URur3sAJbn3v6Ph3eOTvhgp0+Uj9eeJL75PuHfiZnaXx0PJVjNhCU1aDI2JlB9mBuziB60Hv+Hs80LTTz8BNTgrd96kYDhX2YRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975970; c=relaxed/simple;
	bh=diarVyQXDUNoSTg9ELLmNUjuBHEmmtNPPO/s5sxsFwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4EXi9DzRTuDHHSfC+n2LUFjmvVUQeM9fFVZ7VTY+PdKTmszvAuBCPER3UADp6g62m1Ws77RfezjOi0tjLm+3Yz9M8TYbKt+nPhz5ZU1LfKBmsQcoKHEBf90s217BXEgwHzl6Zm8kbatoxxbN0XtIo+2Dd3kdb1Hr8U2iCtoSwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BCY2542/; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <829fb129-f643-4960-a2da-cd38e5ee8f39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705975966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiqFJ3djgll3P+M/6YrFMCqE2soJCrfxlM6Qkrb0hJo=;
	b=BCY2542/N2/xlwmhTkgJ/YNu5Darjyl7TDWNmulm13er7a3H3uBw9LbPYgVz4DC4PACdWS
	pbjyfMHhyUcmDLDA1wp3PeNNIgbWYuh2XdtdxUKRUg/WQmpgEJ/M3ladQMN1PXx8RmVDVz
	FzYcU23dmCsIQqbnZlo8PLEU3kf9WxY=
Date: Tue, 23 Jan 2024 10:12:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 6/7] hugetlb: parallelize 2M hugetlb allocation and
 initialization
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, David Rientjes
 <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, Linux-MM <linux-mm@kvack.org>,
 Gang Li <gang.li@linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 Gang Li <ligang.bdlg@bytedance.com>
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-7-gang.li@linux.dev>
 <ddf37da4-4cbc-478a-be9b-3060b0aebc90@linux.dev>
 <14e38e95-2bc6-4571-b502-4e3954b4bcc4@linux.dev>
 <849D7EA4-BCF4-4587-8A78-F3B35B63EAE9@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <849D7EA4-BCF4-4587-8A78-F3B35B63EAE9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/22 19:30, Muchun Song wrote:
>> On Jan 22, 2024, at 18:12, Gang Li <gang.li@linux.dev> wrote:
>>
>> On 2024/1/22 15:10, Muchun Song wrote:> On 2024/1/18 20:39, Gang Li wrote:
>>>> +static void __init hugetlb_alloc_node(unsigned long start, unsigned long end, void *arg)
>>>>    {
>>>> -    unsigned long i;
>>>> +    struct hstate *h = (struct hstate *)arg;
>>>> +    int i, num = end - start;
>>>> +    nodemask_t node_alloc_noretry;
>>>> +    unsigned long flags;
>>>> +    int next_node = 0;
>>> This should be first_online_node which may be not zero.
>>
>> That's right. Thanks!
>>
>>>> -    for (i = 0; i < h->max_huge_pages; ++i) {
>>>> -        if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
>>>> +    /* Bit mask controlling how hard we retry per-node allocations.*/
>>>> +    nodes_clear(node_alloc_noretry);
>>>> +
>>>> +    for (i = 0; i < num; ++i) {
>>>> +        struct folio *folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
>>>> +                        &node_alloc_noretry, &next_node);
>>>> +        if (!folio)
>>>>                break;
>>>> +        spin_lock_irqsave(&hugetlb_lock, flags);
>>>> I suspect there will more contention on this lock when parallelizing.
>>
>> In the worst case, there are only 'numa node number' of threads in
>> contention. And in my testing, it doesn't degrade performance, but
>> rather improves performance due to the reduced granularity.
> 
> So, the performance does not change if you move the lock out of
> loop?
>

If we move the lock out of loop, then multi-threading becomes 
single-threading, which definitely reduces performance.

```
+       spin_lock_irqsave(&hugetlb_lock, flags);
         for (i = 0; i < num; ++i) {
                 struct folio *folio = alloc_pool_huge_folio(h, 
&node_states[N_MEMORY],
                                                 &node_alloc_noretry, 
&next_node);
                 if (!folio)
                         break;
-               spin_lock_irqsave(&hugetlb_lock, flags);
                 __prep_account_new_huge_page(h, folio_nid(folio));
                 enqueue_hugetlb_folio(h, folio);
-               spin_unlock_irqrestore(&hugetlb_lock, flags);
                 cond_resched();
         }
+       spin_unlock_irqrestore(&hugetlb_lock, flags);
  }
```


