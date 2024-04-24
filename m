Return-Path: <linux-kernel+bounces-157064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81158B0C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAAB1C21DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D0115E5D1;
	Wed, 24 Apr 2024 14:20:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4F13DBB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968415; cv=none; b=exoxLkPjO5+pgArkK3ZHUqLiLXJ5LID1VcPvC6RdbAO5fC00v1eYzh34umArpLDsh5J5whQwviE0M36Xf5gedc+SR9LrXtUf6mTuw1mVBaWZfWWsjg3tmef9yhGq3Z1hwoXDN/D09zk80MV7V/YX0w+75zjg45LjpxFDmV+SIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968415; c=relaxed/simple;
	bh=TUN2RR6Hn8FNjOi+yLQlbqOHrhDef7bKVRA0Ciryy4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvHPhZwGkDCLBUcdWgY4PzZp+AZn22hZ9zTt+G6RR4GALFc+cdUhOq0xnxBs+tiqEPWdsG4i17S1T2PBfSyk3Dw1zlRp/CYmrTIsGpky2bsFmosGwfqZ15UcO/qwdKR+ziCnbhZXertQ2Io3EOlNwHYV06ee3diSZVuA6WVWJn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 117ED2F;
	Wed, 24 Apr 2024 07:20:39 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8B693F7BD;
	Wed, 24 Apr 2024 07:20:09 -0700 (PDT)
Message-ID: <76f816dd-3bbf-48c9-a630-3787051cf289@arm.com>
Date: Wed, 24 Apr 2024 15:20:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add mTHP support for anonymous share pages
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <4b998e7d-153f-48cc-a9bb-8c84bb675581@arm.com>
 <c1f68109-7665-4905-996f-f1067dfa2cb6@linux.alibaba.com>
 <80b5f87e-c156-4ccc-98f0-96f1fd864273@arm.com>
 <ef4f15dd-da31-4a1e-bec5-62a7002c4f7c@linux.alibaba.com>
 <5b8b22e7-6355-4b08-b5b5-1e33ebae6f16@arm.com>
 <813fe7fd-3004-4e8b-801d-95c33559a025@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <813fe7fd-3004-4e8b-801d-95c33559a025@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2024 14:49, Baolin Wang wrote:
> 
> 
> On 2024/4/24 18:01, Ryan Roberts wrote:
>> On 24/04/2024 10:55, Baolin Wang wrote:
>>>
>>>
>>> On 2024/4/24 16:26, Ryan Roberts wrote:
>>>> On 24/04/2024 07:55, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/4/23 18:41, Ryan Roberts wrote:
>>>>>> On 22/04/2024 08:02, Baolin Wang wrote:
>>>>>>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>>>>>>> through commit 19eaf44954df, that can allow THP to be configured through the
>>>>>>> sysfs interface located at
>>>>>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>>>>
>>>>>>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>>>>>>> configured through the sysfs interface, and can only use the PMD-mapped
>>>>>>> THP, that is not reasonable. Many implement anonymous page sharing through
>>>>>>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>>>>>>> therefore, users expect to apply an unified mTHP strategy for anonymous
>>>>>>> pages,
>>>>>>> also including the anonymous shared pages, in order to enjoy the benefits of
>>>>>>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>>>>>>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss
>>>>>>> etc.
>>>>>>
>>>>>> This sounds like a very useful addition!
>>>>>>
>>>>>> Out of interest, can you point me at any workloads (and off-the-shelf
>>>>>> benchmarks
>>>>>> for those workloads) that predominantly use shared anon memory?
>>>>>
>>>>> As far as I know, some database related workloads make extensive use of shared
>>>>> anonymous page, such as PolarDB[1] in our Alibaba fleet, or MySQL likely also
>>>>> uses shared anonymous memory. And I still need to do some investigation to
>>>>> measure the performance.
>>>>>
>>>>> [1] https://github.com/ApsaraDB/PolarDB-for-PostgreSQL
>>>>
>>>> Thanks for the pointer!
>>>>
>>>>>
>>>>>>> The primary strategy is that, the use of huge pages for anonymous shared
>>>>>>> pages
>>>>>>> still follows the global control determined by the mount option "huge="
>>>>>>> parameter
>>>>>>> or the sysfs interface at
>>>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>>>> The utilization of mTHP is allowed only when the global 'huge' switch is
>>>>>>> enabled.
>>>>>>> Subsequently, the mTHP sysfs interface
>>>>>>> (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
>>>>>>> is checked to determine the mTHP size that can be used for large folio
>>>>>>> allocation
>>>>>>> for these anonymous shared pages.
>>>>>>
>>>>>> I'm not sure about this proposed control mechanism; won't it break
>>>>>> compatibility? I could be wrong, but I don't think shmem's use of THP used to
>>>>>> depend upon the value of /sys/kernel/mm/transparent_hugepage/enabled? So it
>>>>>
>>>>> Yes, I realized this after more testing.
>>>>>
>>>>>> doesn't make sense to me that we now depend upon the
>>>>>> /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled values (which by
>>>>>> default disables all sizes except 2M, which is set to "inherit" from
>>>>>> /sys/kernel/mm/transparent_hugepage/enabled).
>>>>>>
>>>>>> The other problem is that shmem_enabled has a different set of options
>>>>>> (always/never/within_size/advise/deny/force) to enabled
>>>>>> (always/madvise/never)
>>>>>>
>>>>>> Perhaps it would be cleaner to do the same trick we did for enabled;
>>>>>> Introduce
>>>>>> /mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which can have all the
>>>>>> same values as the top-level
>>>>>> /sys/kernel/mm/transparent_hugepage/shmem_enabled,
>>>>>> plus the additional "inherit" option. By default all sizes will be set to
>>>>>> "never" except 2M, which is set to "inherit".
>>>>>
>>>>> Sounds good to me. But I do not want to copy all same values from top-level
>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled':
>>>>> always within_size advise never deny force
>>>>>
>>>>> For mTHP's shmem_enabled interface, we can just keep below values:
>>>>> always within_size advise never
>>>>>
>>>>> Cause when checking if mTHP can be used for anon shmem, 'deny' is equal to
>>>>> 'never', and 'force' is equal to 'always'.
>>>>
>>>> I'll admit it wasn't completely clear to me after reading the docs, but my
>>>> rough
>>>> understanding is:
>>>>
>>>>    - /sys/kernel/mm/transparent_hugepage/shmem_enabled controls
>>>>      mmap(SHARED|ANON) allocations (mostly; see rule 3)
>>>>    - huge=... controls tmpfs allocations
>>>>    - deny and force in shmem_enabled are equivalent to never and always for
>>>>      mmap(SHARED|ANON) but additionally override all tmpfs mounts so they
>>>> act as
>>>>      if they were mounted with huge=never or huge=always
>>>>
>>>> Is that correct? If so, then I think it still makes sense to support per-size
>>>
>>> Correct.
>>>
>>>> deny/force. Certainly if a per-size control is set to "inherit" and the
>>>> top-level control is set to deny or force, you would need that to mean
>>>> something.
>>>
>>> IMHO, the '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled' interface
>>> should only control the anonymous shmem. And 'huge=' controls tmpfs allocation,
>>> so we should not use anonymous control to override tmpfs control, which seems a
>>> little mess?
>>
>> I agree it would be cleaner to only handle mmap(SHARED|ANON) here, and leave the
>> tmpfs stuff for another time. But my point is that
>> /mm/transparent_hugepage/shmem_enabled already interferes with tmpfs if the
>> value is deny or force. So if you have:
>>
>> echo deny > /mm/transparent_hugepage/shmem_enabled
> 
> IIUC, this global control will cause shmem_is_huge() to always return false, so
> no matter how '/mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled' is set,
> anonymous shmem will not use mTHP. No?

No, that's not how '/mm/transparent_hugepage/hugepage-xxxkB/enabled' works, and
I think '/mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled' should follow
the established pattern.

For anon-private, each size is controlled by its
/mm/transparent_hugepage/hugepage-xxxkB/enabled value. Unless that value is
"inherit", in which case the value in /mm/transparent_hugepage/enabled is used
for that size.

That approach enables us to 1) maintain back-compat and 2) control each size
independently

1) is met because the default is that all sizes are initially set to "never",
except the PMD-size (e.g. /mm/transparent_hugepage/hugepage-2048kB/enabled)
which is initially set to inherit. So any mTHP unaware SW can still modify
/mm/transparent_hugepage/enabled and it will still only apply to PMD size.

2) is met because mTHP aware SW can come along and e.g. enable the 64K size
(echo always > /mm/transparent_hugepage/hugepage-64kB/enabled) without having to
modify the value in /mm/transparent_hugepage/enabled.

> 
>> echo inherit > /mm/transparent_hugepage/hugepage-64kB/shmem_enabled
>>
>> What does that mean?

So I think /mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled will need to
support the deny and force values. When applied to non-PMD sizes, "deny" can
just be a noop for now, because there was no way to configure a tmpfs mount for
non-PMD size THP in the first place. But I'm not sure what to do with "force"?

>>
>>>
>>>>>> Of course the huge= mount option would also need to take a per-size option in
>>>>>> this case. e.g. huge=2048kB:advise,64kB:always
>>>>>
>>>>> IMO, I do not want to change the global 'huge=' mount option, which can
>>>>> control
>>>>> both anon shmem and tmpfs, but mTHP now is only applied for anon shmem. So
>>>>> let's
>>>>
>>>> How does huge= control anon shmem? I thought it was only for mounted
>>>> filesystems; so tmpfs? Perhaps my mental model for how this works is broken...
>>>
>>> Sorry for noise, you are right. So this is still the reason I don't want to
>>> change the semantics of 'huge=', which is used to control tmpfs.
>>>
>>>>> keep it be same with the global sysfs interface:
>>>>> /sys/kernel/mm/transparent_hugepage/shmem_enabled.
>>>>>
>>>>> For tmpfs large folio strategy, I plan to address it later, and we may need
>>>>> more
>>>>> discussion to determine if it should follow the file large folio strategy
>>>>> or not
>>>>> (no investigation now).
>>>>
>>>> OK. But until you get to tmpfs, you'll need an interim definition for what it
>>>> means if a per-size control is set to "inherit" and the top-level control is
>>>> set
>>>> to deny/force.
>>>>
>>>>>
>>>>> Thanks for reviewing.
>>>>
>>>> No problem! Thanks for doing the work!
>>>>
>>>>>
>>>>>>> TODO:
>>>>>>>     - More testing and provide some performance data.
>>>>>>>     - Need more discussion about the large folio allocation strategy for a
>>>>>>> 'regular
>>>>>>> file' operation created by memfd_create(), for example using
>>>>>>> ftruncate(fd) to
>>>>>>> specify
>>>>>>> the 'file' size, which need to follow the anonymous mTHP rule too?
>>>>>>>     - Do not split the large folio when share memory swap out.
>>>>>>>     - Can swap in a large folio for share memory.
>>>>>>>
>>>>>>> Baolin Wang (5):
>>>>>>>      mm: memory: extend finish_fault() to support large folio
>>>>>>>      mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
>>>>>>>      mm: shmem: add THP validation for PMD-mapped THP related statistics
>>>>>>>      mm: shmem: add mTHP support for anonymous share pages
>>>>>>>      mm: shmem: add anonymous share mTHP counters
>>>>>>>
>>>>>>>     include/linux/huge_mm.h |   4 +-
>>>>>>>     mm/huge_memory.c        |   8 ++-
>>>>>>>     mm/memory.c             |  25 +++++++---
>>>>>>>     mm/shmem.c              | 107 ++++++++++++++++++++++++++++++----------
>>>>>>>     4 files changed, 108 insertions(+), 36 deletions(-)
>>>>>>>


