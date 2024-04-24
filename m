Return-Path: <linux-kernel+bounces-156540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD38B044C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4253284075
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F760158872;
	Wed, 24 Apr 2024 08:27:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFA15885F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947221; cv=none; b=oyHvdE39UoZL79eH0JkwgFN1DQvquyJ+AKWNzh1rIA7OfyB1cYMowPYOuO6GO0XMox0zPvgLZkLgO25uUUotr8Roj9siMimtog21SwldES5NWDB5C/52SoV0oNSG9ojAVdRkJK1ToPuepcDztjDBlZares7GlxComoHJQbmM6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947221; c=relaxed/simple;
	bh=cEIVa3Hgkq9YLgaiCUQhfbLjHHS1DtojnVqleYwEV2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV3SGliwujHm45xu0SvQLe6tO7jFB/UZxw3WltJp/0eO6c8Xej5fgC7EID/+Z6Qr3LjIZuU8WThKuBePkuWj/H9rTI1SIBAh4dWxf1Ae3ALrels3yEQ1xLp1wF7jfRkxfB4LlR66a8UpV88hFpFoSAyD14PP5O/BMhsjNCdpLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9A8D339;
	Wed, 24 Apr 2024 01:27:19 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95F6C3F64C;
	Wed, 24 Apr 2024 01:26:50 -0700 (PDT)
Message-ID: <80b5f87e-c156-4ccc-98f0-96f1fd864273@arm.com>
Date: Wed, 24 Apr 2024 09:26:49 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c1f68109-7665-4905-996f-f1067dfa2cb6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2024 07:55, Baolin Wang wrote:
> 
> 
> On 2024/4/23 18:41, Ryan Roberts wrote:
>> On 22/04/2024 08:02, Baolin Wang wrote:
>>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>>> through commit 19eaf44954df, that can allow THP to be configured through the
>>> sysfs interface located at
>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>
>>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>>> configured through the sysfs interface, and can only use the PMD-mapped
>>> THP, that is not reasonable. Many implement anonymous page sharing through
>>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>>> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
>>> also including the anonymous shared pages, in order to enjoy the benefits of
>>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
>>
>> This sounds like a very useful addition!
>>
>> Out of interest, can you point me at any workloads (and off-the-shelf benchmarks
>> for those workloads) that predominantly use shared anon memory?
> 
> As far as I know, some database related workloads make extensive use of shared
> anonymous page, such as PolarDB[1] in our Alibaba fleet, or MySQL likely also
> uses shared anonymous memory. And I still need to do some investigation to
> measure the performance.
> 
> [1] https://github.com/ApsaraDB/PolarDB-for-PostgreSQL

Thanks for the pointer!

> 
>>> The primary strategy is that, the use of huge pages for anonymous shared pages
>>> still follows the global control determined by the mount option "huge="
>>> parameter
>>> or the sysfs interface at '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>> The utilization of mTHP is allowed only when the global 'huge' switch is
>>> enabled.
>>> Subsequently, the mTHP sysfs interface
>>> (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
>>> is checked to determine the mTHP size that can be used for large folio
>>> allocation
>>> for these anonymous shared pages.
>>
>> I'm not sure about this proposed control mechanism; won't it break
>> compatibility? I could be wrong, but I don't think shmem's use of THP used to
>> depend upon the value of /sys/kernel/mm/transparent_hugepage/enabled? So it
> 
> Yes, I realized this after more testing.
> 
>> doesn't make sense to me that we now depend upon the
>> /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled values (which by
>> default disables all sizes except 2M, which is set to "inherit" from
>> /sys/kernel/mm/transparent_hugepage/enabled).
>>
>> The other problem is that shmem_enabled has a different set of options
>> (always/never/within_size/advise/deny/force) to enabled (always/madvise/never)
>>
>> Perhaps it would be cleaner to do the same trick we did for enabled; Introduce
>> /mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which can have all the
>> same values as the top-level /sys/kernel/mm/transparent_hugepage/shmem_enabled,
>> plus the additional "inherit" option. By default all sizes will be set to
>> "never" except 2M, which is set to "inherit".
> 
> Sounds good to me. But I do not want to copy all same values from top-level
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled':
> always within_size advise never deny force
> 
> For mTHP's shmem_enabled interface, we can just keep below values:
> always within_size advise never
> 
> Cause when checking if mTHP can be used for anon shmem, 'deny' is equal to
> 'never', and 'force' is equal to 'always'.

I'll admit it wasn't completely clear to me after reading the docs, but my rough
understanding is:

 - /sys/kernel/mm/transparent_hugepage/shmem_enabled controls
   mmap(SHARED|ANON) allocations (mostly; see rule 3)
 - huge=... controls tmpfs allocations
 - deny and force in shmem_enabled are equivalent to never and always for
   mmap(SHARED|ANON) but additionally override all tmpfs mounts so they act as
   if they were mounted with huge=never or huge=always

Is that correct? If so, then I think it still makes sense to support per-size
deny/force. Certainly if a per-size control is set to "inherit" and the
top-level control is set to deny or force, you would need that to mean something.

> 
>> Of course the huge= mount option would also need to take a per-size option in
>> this case. e.g. huge=2048kB:advise,64kB:always
> 
> IMO, I do not want to change the global 'huge=' mount option, which can control
> both anon shmem and tmpfs, but mTHP now is only applied for anon shmem. So let's

How does huge= control anon shmem? I thought it was only for mounted
filesystems; so tmpfs? Perhaps my mental model for how this works is broken...

> keep it be same with the global sysfs interface:
> /sys/kernel/mm/transparent_hugepage/shmem_enabled.
> 
> For tmpfs large folio strategy, I plan to address it later, and we may need more
> discussion to determine if it should follow the file large folio strategy or not
> (no investigation now).

OK. But until you get to tmpfs, you'll need an interim definition for what it
means if a per-size control is set to "inherit" and the top-level control is set
to deny/force.

> 
> Thanks for reviewing.

No problem! Thanks for doing the work!

> 
>>> TODO:
>>>   - More testing and provide some performance data.
>>>   - Need more discussion about the large folio allocation strategy for a
>>> 'regular
>>> file' operation created by memfd_create(), for example using ftruncate(fd) to
>>> specify
>>> the 'file' size, which need to follow the anonymous mTHP rule too?
>>>   - Do not split the large folio when share memory swap out.
>>>   - Can swap in a large folio for share memory.
>>>
>>> Baolin Wang (5):
>>>    mm: memory: extend finish_fault() to support large folio
>>>    mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
>>>    mm: shmem: add THP validation for PMD-mapped THP related statistics
>>>    mm: shmem: add mTHP support for anonymous share pages
>>>    mm: shmem: add anonymous share mTHP counters
>>>
>>>   include/linux/huge_mm.h |   4 +-
>>>   mm/huge_memory.c        |   8 ++-
>>>   mm/memory.c             |  25 +++++++---
>>>   mm/shmem.c              | 107 ++++++++++++++++++++++++++++++----------
>>>   4 files changed, 108 insertions(+), 36 deletions(-)
>>>


