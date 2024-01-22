Return-Path: <linux-kernel+bounces-32712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F5A835F39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E331C2490A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF243A1A6;
	Mon, 22 Jan 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rqG8CLzM"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838A39870
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918384; cv=none; b=EHg0eld7xlfqq3toOFYUowJ1wWyt1955PDQoqUQxzHJcgWnK9chxE+1CDGH/uvA3Q+6hdGAjZI+KAkzJX6iuhwihnHGCEfX8lMM8IsKO9kLyrGfnfBmzZevNT2SNwePivIpqyb7O3LlPOMvF1leDAGQCcQtabt1RGEzkKE/W8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918384; c=relaxed/simple;
	bh=KKKcm2UPPp6PCIJwOIcXfs1ihooj1Xt09/GHTVoSUPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sI5TCPjfuKOX+QNykpK5xcyRFdmj2QHqe/uOfehduwSIkakAU9Ac4iTug6peSCz8YdnoxmkNKajgQtqGSfnBY/3sN2RJHtaPcxjico5Z2qH0txQnM8x+1OJTHtq5iWulY5SzPpTFCzspLYLItWnzrva+mOM6fJesEPcIuy54jxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rqG8CLzM; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14e38e95-2bc6-4571-b502-4e3954b4bcc4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705918380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i27gMbuhWRmHIea8xkCjO4LuE+uIyG5QpAJgAShJ0ac=;
	b=rqG8CLzMUsuUXsV3JA4pRQc8Ub3ClmHd5tVqjaYG7Ibp098Ee3kWxKq2Hvj4lsINpjlvKV
	F2ijQLOkyKsLbynUFfXnzBSeyTmn2yJXBlqPbx3Ob+0YTp3Do52+fjHYAPDDL+1yWGQv0F
	dUrZkuUAzRYDpnudnzTxqQgGzFY9q30=
Date: Mon, 22 Jan 2024 18:12:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 6/7] hugetlb: parallelize 2M hugetlb allocation and
 initialization
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>, David Hildenbrand
 <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-7-gang.li@linux.dev>
 <ddf37da4-4cbc-478a-be9b-3060b0aebc90@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <ddf37da4-4cbc-478a-be9b-3060b0aebc90@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/22 15:10, Muchun Song wrote:> On 2024/1/18 20:39, Gang Li wrote:
>> +static void __init hugetlb_alloc_node(unsigned long start, unsigned 
>> long end, void *arg)
>>   {
>> -    unsigned long i;
>> +    struct hstate *h = (struct hstate *)arg;
>> +    int i, num = end - start;
>> +    nodemask_t node_alloc_noretry;
>> +    unsigned long flags;
>> +    int next_node = 0;
> 
> This should be first_online_node which may be not zero.
> 

That's right. Thanks!

>> -    for (i = 0; i < h->max_huge_pages; ++i) {
>> -        if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
>> +    /* Bit mask controlling how hard we retry per-node allocations.*/
>> +    nodes_clear(node_alloc_noretry);
>> +
>> +    for (i = 0; i < num; ++i) {
>> +        struct folio *folio = alloc_pool_huge_folio(h, 
>> &node_states[N_MEMORY],
>> +                        &node_alloc_noretry, &next_node);
>> +        if (!folio)
>>               break;
>> +        spin_lock_irqsave(&hugetlb_lock, flags);
>  > I suspect there will more contention on this lock when parallelizing.

In the worst case, there are only 'numa node number' of threads in
contention. And in my testing, it doesn't degrade performance, but
rather improves performance due to the reduced granularity.

> I want to know why you chose to drop prep_and_add_allocated_folios()
> call in the original hugetlb_pages_alloc_boot()?

Splitting him to parallelize hugetlb_vmemmap_optimize_folios.

>> +static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
>> +{
>> +    struct padata_mt_job job = {
>> +        .fn_arg        = h,
>> +        .align        = 1,
>> +        .numa_aware    = true
>> +    };
>> +
>> +    job.thread_fn    = hugetlb_alloc_node;
>> +    job.start    = 0;
>> +    job.size    = h->max_huge_pages;
>> +    job.min_chunk    = h->max_huge_pages / num_node_state(N_MEMORY) / 2;
>> +    job.max_threads    = num_node_state(N_MEMORY) * 2;
> 
> I am curious the magic number of 2 used in assignments of ->min_chunk
> and ->max_threads, does it from your experiment? I thinke it should
> be a comment here.
> 

This is tested and I can perform more detailed tests and provide data.

> And I am also sceptical about the optimization for a small amount of
> allocation of hugepages. Given 4 hugepags needed to be allocated on UMA
> system, job.min_chunk will be 2, job.max_threads will be 2. Then, 2
> workers will be scheduled, however each worker will just allocate 2 pages,
> how much the cost of scheduling? What if allocate 4 pages in single
> worker? Do you have any numbers on parallelism vs non-parallelism in
> a small allocation case? If we cannot gain from this case, I think we shold
> assign a reasonable value to ->min_chunk based on experiment.
> 
> Thanks.
>

That's a good suggestion, I'll run some tests and choose the best
values.



