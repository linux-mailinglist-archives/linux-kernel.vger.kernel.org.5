Return-Path: <linux-kernel+bounces-52205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC2849559
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508051F229D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1B125A1;
	Mon,  5 Feb 2024 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r6EZbbN5"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE011738
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121595; cv=none; b=Rvr6GSze5nE1n14Qx8o2JmGLzC6hHVIiLK1Y6tIdQ4OdkAKjn7WZqE0MPQcYgmAJxfbcLadXJsmBBqWYatSCz7K4MkEP/knt0U7AmxdHdjEHZJPfjadIRyfzfbB9TTDnfig1j18l+2pnHvfQwCZZe0q1FtDMR79AriZMNsbKhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121595; c=relaxed/simple;
	bh=mmziVtY9vGIQoS7rpx+3hMuAswUDLfSmkEDdnkqSX9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McsPfWAg/S0umXlA72z7yTTw9ZjdILAWRTzS6Z+ksg5/myU+vRzFoGrOQJe6QWMCUAzRfYlPwjbqJCtXI4xbLvqll6IJEVSK4G4jtXT2icrrXf8F42/LHBeOcizSziFnwTSKSNxLudnEnm+gwENk4vh0gLCP7o/0UfGhjJYhU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r6EZbbN5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <277e0eed-918f-414f-b19d-219bd155ac14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707121591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYnIGA8kuvR5y6gmVI63CeQLe1FfUo5SgyZ3aZHYeLs=;
	b=r6EZbbN5p7gCBCmq+arlz/5myx0SG5omwL9pKEuLL3Fgc1mWjvfa7e4ghJS2/D1r7f9o8H
	8rV5IuT967VrA15Le/KCExhcfV+Wc0YhnkX+JwsKSeSLSG2VYR5B03ySNjwj2s1g2l2HeI
	kXvuz95nxj9X8f4n3S45zUZS2XctVMI=
Date: Mon, 5 Feb 2024 16:26:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 7/7] hugetlb: parallelize 1G hugetlb initialization
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>, David Hildenbrand
 <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240126152411.1238072-1-gang.li@linux.dev>
 <20240126152411.1238072-8-gang.li@linux.dev>
 <f8c89a25-e7f2-4f3c-a99a-a1945e18e026@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <f8c89a25-e7f2-4f3c-a99a-a1945e18e026@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/2/5 15:28, Muchun Song wrote:
> On 2024/1/26 23:24, Gang Li wrote:
>> @@ -3390,8 +3390,6 @@ static void __init 
>> prep_and_add_bootmem_folios(struct hstate *h,
>>       /* Send list for bulk vmemmap optimization processing */
>>       hugetlb_vmemmap_optimize_folios(h, folio_list);
>> -    /* Add all new pool pages to free lists in one lock cycle */
>> -    spin_lock_irqsave(&hugetlb_lock, flags);
>>       list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
>>           if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
>>               /*
>> @@ -3404,23 +3402,27 @@ static void __init 
>> prep_and_add_bootmem_folios(struct hstate *h,
>>                       HUGETLB_VMEMMAP_RESERVE_PAGES,
>>                       pages_per_huge_page(h));
>>           }
>> +        /* Subdivide locks to achieve better parallel performance */
>> +        spin_lock_irqsave(&hugetlb_lock, flags);
>>           __prep_account_new_huge_page(h, folio_nid(folio));
>>           enqueue_hugetlb_folio(h, folio);
>> +        spin_unlock_irqrestore(&hugetlb_lock, flags);
>>       }
>> -    spin_unlock_irqrestore(&hugetlb_lock, flags);
>>   }
>>   /*
>>    * Put bootmem huge pages into the standard lists after mem_map is up.
>>    * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
>>    */
>> -static void __init gather_bootmem_prealloc(void)
>> +static void __init gather_bootmem_prealloc_node(unsigned long start, 
>> unsigned long end, void *arg)
>> +
>>   {
>> +    int nid = start;
> 
> Sorry for so late to notice an issue here. I have seen a comment from
> PADATA, whcih says:
> 
>      @max_threads: Max threads to use for the job, actual number may be 
> less
>                    depending on task size and minimum chunk size.
> 
> PADATA will not guarantee gather_bootmem_prealloc_node() will be called
> ->max_threads times (You have initialized it to the number of NUMA nodes in
> gather_bootmem_prealloc). Therefore, we should add a loop here to 
> initialize
> multiple nodes, namely (@end - @start) here. Otherwise, we will miss
> initializing some nodes.
> 
> Thanks.
>
In padata_do_multithreaded:

```
/* Ensure at least one thread when size < min_chunk. */
nworks = max(job->size / max(job->min_chunk, job->align), 1ul);
nworks = min(nworks, job->max_threads);

ps.nworks      = padata_work_alloc_mt(nworks, &ps, &works);
```

So we have works <= max_threads, but >= size/min_chunk.

Thanks!

