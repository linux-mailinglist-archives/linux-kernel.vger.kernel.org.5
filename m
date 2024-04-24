Return-Path: <linux-kernel+bounces-156670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884D8B0695
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6781F237C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF1159200;
	Wed, 24 Apr 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XhmkgYqr"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF211159213
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952512; cv=none; b=ECWl+OiFnSBwPxsEJhm1GY2Q7C8ZwdXNMDtNgKGY9MKxC2Uqm5H5VmEl+nGMGMd/QHaUQJNmLys0WiekLTT+Dtp3bgQuMBDC2l3fRRk2YsiNFF4hMaB1I5IrQQNI8qvMBWHa1H9eYRDdEvxRFDqdPTPiJEHCMKdSU85P1sYfJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952512; c=relaxed/simple;
	bh=UrblfufPmUefv21ZljC8aDdBXskUhSizaHgQq3RlQsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM47bSvgypcriTFO6mOUkiZNk6QVLViaCSWNDsrGr86mPblwaUqsfmRKuQobWJ1DW6CCHIQyumlxpNK9QCyfboejg5uHimnwGjiWosIljVouL1CSKg15WHSb7aMlqPTrXN3N1arAq365uWvgKzxx7f5ARGQFj+5Ay2OvLClW+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XhmkgYqr; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713952507; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e52knmUNyXvu2+TTi6pLEP8hob+kIrxi8q2mNj7OiZ4=;
	b=XhmkgYqr3pmvVsYjqQvSRBg0qYoa2zAOqZWHTCWRNc9lqveZdsqZ/YC3B4ABz1WgCd6otvNmkoG9hiTyOEknVPzfSQ69gW1ICt0A72ajTkKcxh9HShOt2t74BWZkOgn1yGpRbYubQvUuBQ2B8lupXCJ4gLuf1Oo3j1NJgaoVRlU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5ByRRo_1713952504;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5ByRRo_1713952504)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 17:55:05 +0800
Message-ID: <ef4f15dd-da31-4a1e-bec5-62a7002c4f7c@linux.alibaba.com>
Date: Wed, 24 Apr 2024 17:55:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add mTHP support for anonymous share pages
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <4b998e7d-153f-48cc-a9bb-8c84bb675581@arm.com>
 <c1f68109-7665-4905-996f-f1067dfa2cb6@linux.alibaba.com>
 <80b5f87e-c156-4ccc-98f0-96f1fd864273@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <80b5f87e-c156-4ccc-98f0-96f1fd864273@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/24 16:26, Ryan Roberts wrote:
> On 24/04/2024 07:55, Baolin Wang wrote:
>>
>>
>> On 2024/4/23 18:41, Ryan Roberts wrote:
>>> On 22/04/2024 08:02, Baolin Wang wrote:
>>>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>>>> through commit 19eaf44954df, that can allow THP to be configured through the
>>>> sysfs interface located at
>>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>
>>>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>>>> configured through the sysfs interface, and can only use the PMD-mapped
>>>> THP, that is not reasonable. Many implement anonymous page sharing through
>>>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>>>> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
>>>> also including the anonymous shared pages, in order to enjoy the benefits of
>>>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>>>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
>>>
>>> This sounds like a very useful addition!
>>>
>>> Out of interest, can you point me at any workloads (and off-the-shelf benchmarks
>>> for those workloads) that predominantly use shared anon memory?
>>
>> As far as I know, some database related workloads make extensive use of shared
>> anonymous page, such as PolarDB[1] in our Alibaba fleet, or MySQL likely also
>> uses shared anonymous memory. And I still need to do some investigation to
>> measure the performance.
>>
>> [1] https://github.com/ApsaraDB/PolarDB-for-PostgreSQL
> 
> Thanks for the pointer!
> 
>>
>>>> The primary strategy is that, the use of huge pages for anonymous shared pages
>>>> still follows the global control determined by the mount option "huge="
>>>> parameter
>>>> or the sysfs interface at '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>> The utilization of mTHP is allowed only when the global 'huge' switch is
>>>> enabled.
>>>> Subsequently, the mTHP sysfs interface
>>>> (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
>>>> is checked to determine the mTHP size that can be used for large folio
>>>> allocation
>>>> for these anonymous shared pages.
>>>
>>> I'm not sure about this proposed control mechanism; won't it break
>>> compatibility? I could be wrong, but I don't think shmem's use of THP used to
>>> depend upon the value of /sys/kernel/mm/transparent_hugepage/enabled? So it
>>
>> Yes, I realized this after more testing.
>>
>>> doesn't make sense to me that we now depend upon the
>>> /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled values (which by
>>> default disables all sizes except 2M, which is set to "inherit" from
>>> /sys/kernel/mm/transparent_hugepage/enabled).
>>>
>>> The other problem is that shmem_enabled has a different set of options
>>> (always/never/within_size/advise/deny/force) to enabled (always/madvise/never)
>>>
>>> Perhaps it would be cleaner to do the same trick we did for enabled; Introduce
>>> /mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which can have all the
>>> same values as the top-level /sys/kernel/mm/transparent_hugepage/shmem_enabled,
>>> plus the additional "inherit" option. By default all sizes will be set to
>>> "never" except 2M, which is set to "inherit".
>>
>> Sounds good to me. But I do not want to copy all same values from top-level
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled':
>> always within_size advise never deny force
>>
>> For mTHP's shmem_enabled interface, we can just keep below values:
>> always within_size advise never
>>
>> Cause when checking if mTHP can be used for anon shmem, 'deny' is equal to
>> 'never', and 'force' is equal to 'always'.
> 
> I'll admit it wasn't completely clear to me after reading the docs, but my rough
> understanding is:
> 
>   - /sys/kernel/mm/transparent_hugepage/shmem_enabled controls
>     mmap(SHARED|ANON) allocations (mostly; see rule 3)
>   - huge=... controls tmpfs allocations
>   - deny and force in shmem_enabled are equivalent to never and always for
>     mmap(SHARED|ANON) but additionally override all tmpfs mounts so they act as
>     if they were mounted with huge=never or huge=always
> 
> Is that correct? If so, then I think it still makes sense to support per-size

Correct.

> deny/force. Certainly if a per-size control is set to "inherit" and the
> top-level control is set to deny or force, you would need that to mean something.

IMHO, the '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled' 
interface should only control the anonymous shmem. And 'huge=' controls 
tmpfs allocation, so we should not use anonymous control to override 
tmpfs control, which seems a little mess?

>>> Of course the huge= mount option would also need to take a per-size option in
>>> this case. e.g. huge=2048kB:advise,64kB:always
>>
>> IMO, I do not want to change the global 'huge=' mount option, which can control
>> both anon shmem and tmpfs, but mTHP now is only applied for anon shmem. So let's
> 
> How does huge= control anon shmem? I thought it was only for mounted
> filesystems; so tmpfs? Perhaps my mental model for how this works is broken...

Sorry for noise, you are right. So this is still the reason I don't want 
to change the semantics of 'huge=', which is used to control tmpfs.

>> keep it be same with the global sysfs interface:
>> /sys/kernel/mm/transparent_hugepage/shmem_enabled.
>>
>> For tmpfs large folio strategy, I plan to address it later, and we may need more
>> discussion to determine if it should follow the file large folio strategy or not
>> (no investigation now).
> 
> OK. But until you get to tmpfs, you'll need an interim definition for what it
> means if a per-size control is set to "inherit" and the top-level control is set
> to deny/force.
> 
>>
>> Thanks for reviewing.
> 
> No problem! Thanks for doing the work!
> 
>>
>>>> TODO:
>>>>    - More testing and provide some performance data.
>>>>    - Need more discussion about the large folio allocation strategy for a
>>>> 'regular
>>>> file' operation created by memfd_create(), for example using ftruncate(fd) to
>>>> specify
>>>> the 'file' size, which need to follow the anonymous mTHP rule too?
>>>>    - Do not split the large folio when share memory swap out.
>>>>    - Can swap in a large folio for share memory.
>>>>
>>>> Baolin Wang (5):
>>>>     mm: memory: extend finish_fault() to support large folio
>>>>     mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
>>>>     mm: shmem: add THP validation for PMD-mapped THP related statistics
>>>>     mm: shmem: add mTHP support for anonymous share pages
>>>>     mm: shmem: add anonymous share mTHP counters
>>>>
>>>>    include/linux/huge_mm.h |   4 +-
>>>>    mm/huge_memory.c        |   8 ++-
>>>>    mm/memory.c             |  25 +++++++---
>>>>    mm/shmem.c              | 107 ++++++++++++++++++++++++++++++----------
>>>>    4 files changed, 108 insertions(+), 36 deletions(-)
>>>>

