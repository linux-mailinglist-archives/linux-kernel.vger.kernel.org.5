Return-Path: <linux-kernel+bounces-105975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9A87E704
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE63FB21F59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDB32C6C;
	Mon, 18 Mar 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i5/zPefn"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03B2EAE5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756833; cv=none; b=GJtkzDfCLOAx+UJW0dEm5hbKZz88VNjBDnoLhpp2aLevKrDi0tmvbl06qG7yiLbDo92HnVeuCzosxecyXrr4Y99u+/52F+LNwhNCx56cLoNK3r4bPYDLWVe3Bxkyb8GFzqFOsP6dnIhd2/c8xU3ICH0kf4RfxyPYBl84NRMCYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756833; c=relaxed/simple;
	bh=BVQVjPQqiMgcRPEuINLkFaAWCTauJZF/198L7S/256Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRolDVkSyL7XZDX4DpbNz3157H55P3P7ZkD4/xXL+9ZAvL4CmPfDAlKgxYiuFz/jg9J4DGzTljWT2ZLacpy/ayw4XQIbV9QwrmiqXQ9XBxv4aRpxGuvbupSFCEtsfkAe3U09fkkRfG6uBPM65JwoOCRUKPf3nysw3bDNONfKgco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i5/zPefn; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710756823; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RVovdAQ+7yisrAzCVk5VJkY+zylsB44T+cg1BQ8q4f4=;
	b=i5/zPefnNH/kJ9AcebBXHC4dy2DNfowmBsyqZ5YS4lMee3a9ITJ0uKLM81xPKHsSL7m5UAqRGojsWSJnkxKCGs8JZAF1EKE3ptRYgRN0VeV7ojV6XcDmS4nAXL5y9/uOSaEtpQMRIocULsUD1szE2lIzZgH3WPYMrUCfTjqLIE8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W2mZ7Xx_1710756820;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W2mZ7Xx_1710756820)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 18:13:41 +0800
Message-ID: <3bf2c3e1-44fd-4bc8-a97b-9da7b606aec0@linux.alibaba.com>
Date: Mon, 18 Mar 2024 18:13:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm: support multi-size THP numa balancing
To: David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net,
 wangkefeng.wang@huawei.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <903bf13fc3e68b8dc1f256570d78b55b2dd9c96f.1710493587.git.baolin.wang@linux.alibaba.com>
 <871q88vzc4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f00316da-e45d-46c1-99b8-ee160303eaaa@linux.alibaba.com>
 <ca6cca00-8a1b-48c8-b93a-99a772103b8e@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ca6cca00-8a1b-48c8-b93a-99a772103b8e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/18 17:48, David Hildenbrand wrote:
> On 18.03.24 10:42, Baolin Wang wrote:
>>
>>
>> On 2024/3/18 14:16, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> Now the anonymous page allocation already supports multi-size THP 
>>>> (mTHP),
>>>> but the numa balancing still prohibits mTHP migration even though it 
>>>> is an
>>>> exclusive mapping, which is unreasonable. Thus let's support the 
>>>> exclusive
>>>> mTHP numa balancing firstly.
>>>>
>>>> Allow scanning mTHP:
>>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data 
>>>> section
>>>> pages") skips shared CoW pages' NUMA page migration to avoid shared 
>>>> data
>>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>>> NUMA-migrate COW pages that have other uses") change to use 
>>>> page_count()
>>>> to avoid GUP pages migration, that will also skip the mTHP numa 
>>>> scaning.
>>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>>> issue, although there is still a GUP race, the issue seems to have been
>>>> resolved by commit 80d47f5de5e3. Meanwhile, use the 
>>>> folio_estimated_sharers()
>>>> to skip shared CoW pages though this is not a precise sharers count. To
>>>> check if the folio is shared, ideally we want to make sure every 
>>>> page is
>>>> mapped to the same process, but doing that seems expensive and using
>>>> the estimated mapcount seems can work when running autonuma benchmark.
>>>>
>>>> Allow migrating mTHP:
>>>> As mentioned in the previous thread[1], large folios are more 
>>>> susceptible
>>>> to false sharing issues, leading to pages ping-pong back and forth 
>>>> during
>>>> numa balancing, which is currently hard to resolve. Therefore, as a 
>>>> start to
>>>> support mTHP numa balancing, only exclusive mappings are allowed to 
>>>> perform
>>>> numa migration to avoid the false sharing issues with large folios. 
>>>> Similarly,
>>>> use the estimated mapcount to skip shared mappings, which seems can 
>>>> work
>>>> in most cases (?), and we've used folio_estimated_sharers() to skip 
>>>> shared
>>>> mappings in migrate_misplaced_folio() for numa balancing, seems no real
>>>> complaints.
>>>
>>> IIUC, folio_estimated_sharers() cannot identify multi-thread
>>> applications.  If some mTHP is shared by multiple threads in one
>>
>> Right.
>>
> 
> Wasn't this "false sharing" previously raised/described by Mel in this 
> context?

Yes, I got confused with the process's false sharing.

>>> process, how to deal with that?
>>
>> IMHO, seems the should_numa_migrate_memory() already did something to 
>> help?
>>
>> ......
>>     if (!cpupid_pid_unset(last_cpupid) &&
>>                 cpupid_to_nid(last_cpupid) != dst_nid)
>>         return false;
>>
>>     /* Always allow migrate on private faults */
>>     if (cpupid_match_pid(p, last_cpupid))
>>         return true;
>> ......
>>
>> If the node of the CPU that accessed the mTHP last time is different
>> from this time, which means there is some contention for that mTHP among
>> threads. So it will not allow migration.
>>
>> If the contention for the mTHP among threads is light or the accessing
>> is relatively stable, then we can allow migration?
>>
>>> For example, I think that we should avoid to migrate on the first fault
>>> for mTHP in should_numa_migrate_memory().
>>>
>>> More thoughts?  Can we add a field in struct folio for mTHP to count
>>> hint page faults from the same node?
>>
>> IIUC, we do not need add a new field for folio, seems we can reuse
>> ->_flags_2a field. But how to use it? If there are multiple consecutive
>> NUMA faults from the same node, then allow migration?
> 
> _flags_2a cannot be used. You could place something after _deferred_list 

Could you be more explicit? I didn't see _flags_2 currently being used, 
did I miss something?

> IIRC. But only for folios with order>1.

Yes, order 1 folio may use the same strategy with order 0, but need some 
evaluation.

> But I also wonder how one could achieve that using a new field.

