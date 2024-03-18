Return-Path: <linux-kernel+bounces-106005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B687E763
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD831F22681
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA02577D;
	Mon, 18 Mar 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="adoeg+gC"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207B1FB5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757878; cv=none; b=sbx43t+4W36absMxRKR9CvgbwCXnglPThKGFqVKuSmdOmzZkqebiVaUKjoGSYTLats0YW17Gc5NsGLPSC3QKTKf9jo+e+L51jcEYPU3kBnnqWDSvpauy6X2DtdHO5n33SLIhbARJ0C49EQMwG/kSabJfbssetKyjOXaPGjzZU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757878; c=relaxed/simple;
	bh=XYotKAMNzvycl1JG/Q3HI/vrv2SJntIP+AhU4IZD0vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQRLo3NvigHrDsdCankODtnb/zclN8u09a8uWMQY1UqgGO0Qr1Z/q8nNmKDJf1FpkMZ1gf3SF3pJup8I0fCGaLOeTDcqnV3BffRYLeq7wWhRxc95bfbwsZEf9yvWGUQCAbrC602WlZkeR8M2QUoxEfhMz/i0hb32q/a77a4cNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=adoeg+gC; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710757873; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N+z5yj4errvZzUnsDbH2i/qBxwekB8l9wAKiw6mVF4c=;
	b=adoeg+gCyGNv1WWfHrujKljcBNQdifgQMgknPj1c4M/rfgBp6Lr5X0EQidqLixgaD/ASaQ5Usriq0A6jKJMI0C9f8NISvC4BEAQ13bFpZz/i58m+Dk2Irr9m3Ylf6VJgpYUhDTUCqCYc14w4I8g5UU/7uHAaUJDY+/cWJe7XmZw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W2mJh7n_1710757871;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W2mJh7n_1710757871)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 18:31:12 +0800
Message-ID: <e9e614cd-1df6-4f8b-baef-aaa0a041ec07@linux.alibaba.com>
Date: Mon, 18 Mar 2024 18:31:10 +0800
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
 <3bf2c3e1-44fd-4bc8-a97b-9da7b606aec0@linux.alibaba.com>
 <8e13bce5-e353-4258-9891-97158b8ccd84@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8e13bce5-e353-4258-9891-97158b8ccd84@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/18 18:15, David Hildenbrand wrote:
> On 18.03.24 11:13, Baolin Wang wrote:
>>
>>
>> On 2024/3/18 17:48, David Hildenbrand wrote:
>>> On 18.03.24 10:42, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/3/18 14:16, Huang, Ying wrote:
>>>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>>>
>>>>>> Now the anonymous page allocation already supports multi-size THP
>>>>>> (mTHP),
>>>>>> but the numa balancing still prohibits mTHP migration even though it
>>>>>> is an
>>>>>> exclusive mapping, which is unreasonable. Thus let's support the
>>>>>> exclusive
>>>>>> mTHP numa balancing firstly.
>>>>>>
>>>>>> Allow scanning mTHP:
>>>>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data
>>>>>> section
>>>>>> pages") skips shared CoW pages' NUMA page migration to avoid shared
>>>>>> data
>>>>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't 
>>>>>> try to
>>>>>> NUMA-migrate COW pages that have other uses") change to use
>>>>>> page_count()
>>>>>> to avoid GUP pages migration, that will also skip the mTHP numa
>>>>>> scaning.
>>>>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>>>>> issue, although there is still a GUP race, the issue seems to have 
>>>>>> been
>>>>>> resolved by commit 80d47f5de5e3. Meanwhile, use the
>>>>>> folio_estimated_sharers()
>>>>>> to skip shared CoW pages though this is not a precise sharers 
>>>>>> count. To
>>>>>> check if the folio is shared, ideally we want to make sure every
>>>>>> page is
>>>>>> mapped to the same process, but doing that seems expensive and using
>>>>>> the estimated mapcount seems can work when running autonuma 
>>>>>> benchmark.
>>>>>>
>>>>>> Allow migrating mTHP:
>>>>>> As mentioned in the previous thread[1], large folios are more
>>>>>> susceptible
>>>>>> to false sharing issues, leading to pages ping-pong back and forth
>>>>>> during
>>>>>> numa balancing, which is currently hard to resolve. Therefore, as a
>>>>>> start to
>>>>>> support mTHP numa balancing, only exclusive mappings are allowed to
>>>>>> perform
>>>>>> numa migration to avoid the false sharing issues with large folios.
>>>>>> Similarly,
>>>>>> use the estimated mapcount to skip shared mappings, which seems can
>>>>>> work
>>>>>> in most cases (?), and we've used folio_estimated_sharers() to skip
>>>>>> shared
>>>>>> mappings in migrate_misplaced_folio() for numa balancing, seems no 
>>>>>> real
>>>>>> complaints.
>>>>>
>>>>> IIUC, folio_estimated_sharers() cannot identify multi-thread
>>>>> applications.  If some mTHP is shared by multiple threads in one
>>>>
>>>> Right.
>>>>
>>>
>>> Wasn't this "false sharing" previously raised/described by Mel in this
>>> context?
>>
>> Yes, I got confused with the process's false sharing.
>>
>>>>> process, how to deal with that?
>>>>
>>>> IMHO, seems the should_numa_migrate_memory() already did something to
>>>> help?
>>>>
>>>> ......
>>>>      if (!cpupid_pid_unset(last_cpupid) &&
>>>>                  cpupid_to_nid(last_cpupid) != dst_nid)
>>>>          return false;
>>>>
>>>>      /* Always allow migrate on private faults */
>>>>      if (cpupid_match_pid(p, last_cpupid))
>>>>          return true;
>>>> ......
>>>>
>>>> If the node of the CPU that accessed the mTHP last time is different
>>>> from this time, which means there is some contention for that mTHP 
>>>> among
>>>> threads. So it will not allow migration.
>>>>
>>>> If the contention for the mTHP among threads is light or the accessing
>>>> is relatively stable, then we can allow migration?
>>>>
>>>>> For example, I think that we should avoid to migrate on the first 
>>>>> fault
>>>>> for mTHP in should_numa_migrate_memory().
>>>>>
>>>>> More thoughts?  Can we add a field in struct folio for mTHP to count
>>>>> hint page faults from the same node?
>>>>
>>>> IIUC, we do not need add a new field for folio, seems we can reuse
>>>> ->_flags_2a field. But how to use it? If there are multiple consecutive
>>>> NUMA faults from the same node, then allow migration?
>>>
>>> _flags_2a cannot be used. You could place something after _deferred_list
>>
>> Could you be more explicit? I didn't see _flags_2 currently being used,
>> did I miss something?
> 
> Yes, that we use it implicitly via page->flags on subpages (for example, 
> some flags are still per-subpage and not per-folio).

Yes, thanks for reminding:)

