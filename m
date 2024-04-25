Return-Path: <linux-kernel+bounces-158331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB448B1E76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF61CB28C10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181984FD4;
	Thu, 25 Apr 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cR+fLNv4"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF186ADB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038632; cv=none; b=Crbl/i2fUXIdGn9nNF+rFun0g4y8x0G14pz4l56nQOKSMiWduRgfp916gOX90tLLxWM9UMkN0/HsDTfMtQxaNSru14ZaHMLvfndRNFpLKwH0DGHDoPD0usJpqV6rSWPE7rlbeFS/LtOjoGdrhZLBGZbkn5FPRC2eZBCaz1/CWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038632; c=relaxed/simple;
	bh=CGKOY4Le5SDGtI9v2qsLJh5crjCDpDIBujBOkQX51BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pi4WI38FakVQ2OHz/1ILjNZtA63K+NVn5ek1lK+0+XWpI+tX1XDZHTNKBmY22fvWtHbPACxYasVY5IsXBIcfRDJslBBIQunx/RAHHYaNpsOnHCKIejKk5UqfvClK3vdfOfbn15N8yqSL1eol5v54Emd2Ys4OH7XKj0e5JAzJWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cR+fLNv4; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714038626; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=se3yPeF51hBo3fkuzg2gIkMGgNxTW+K6R074msstH2I=;
	b=cR+fLNv43DpfjQzCzpv0SwZSV1HrVtQUm9bB5pzEeywukvJFsWq2wGXxURBmvtBsktrje+peQsQwGJgFofXs9A9BaxwwOYbVA6scFWu205XPeaIoOhvFofmG+A9IR7s7eEwbqG1fZvZu0IZ7MgcDDqjxY2VLe0HufD8vPz94bN4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5F8cen_1714038623;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5F8cen_1714038623)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 17:50:24 +0800
Message-ID: <c56af91f-3601-40f0-b5e7-e2468cb98972@linux.alibaba.com>
Date: Thu, 25 Apr 2024 17:50:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add mTHP support for anonymous share pages
To: David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ying.huang@intel.com, shy828301@gmail.com, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <4b998e7d-153f-48cc-a9bb-8c84bb675581@arm.com>
 <c1f68109-7665-4905-996f-f1067dfa2cb6@linux.alibaba.com>
 <80b5f87e-c156-4ccc-98f0-96f1fd864273@arm.com>
 <ef4f15dd-da31-4a1e-bec5-62a7002c4f7c@linux.alibaba.com>
 <5b8b22e7-6355-4b08-b5b5-1e33ebae6f16@arm.com>
 <813fe7fd-3004-4e8b-801d-95c33559a025@linux.alibaba.com>
 <76f816dd-3bbf-48c9-a630-3787051cf289@arm.com>
 <8c0d6358-3c16-4a57-822c-04b3b3403fe6@linux.alibaba.com>
 <4204b5f6-21f0-4aa2-a625-3dd2f416b649@arm.com>
 <94ae96f7-79ce-4b3f-a272-6af62d01a3f8@redhat.com>
 <71c1e953-84f9-4d47-bd4c-725a447627df@arm.com>
 <bf005e0f-6fda-4068-8af6-5f8c00257de7@redhat.com>
 <bc92c74e-80e2-4065-9b61-46adacdfd17a@linux.alibaba.com>
 <8665df72-0855-4f71-823b-5ff8d8342fd1@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8665df72-0855-4f71-823b-5ff8d8342fd1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/25 17:20, David Hildenbrand wrote:
> On 25.04.24 11:05, Baolin Wang wrote:
>>
>>
>> On 2024/4/25 16:57, David Hildenbrand wrote:
>>> On 25.04.24 10:46, Ryan Roberts wrote:
>>>> On 25/04/2024 09:26, David Hildenbrand wrote:
>>>>> On 25.04.24 10:17, Ryan Roberts wrote:
>>>>>> On 25/04/2024 07:20, Baolin Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2024/4/24 22:20, Ryan Roberts wrote:
>>>>>>>> On 24/04/2024 14:49, Baolin Wang wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2024/4/24 18:01, Ryan Roberts wrote:
>>>>>>>>>> On 24/04/2024 10:55, Baolin Wang wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 2024/4/24 16:26, Ryan Roberts wrote:
>>>>>>>>>>>> On 24/04/2024 07:55, Baolin Wang wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2024/4/23 18:41, Ryan Roberts wrote:
>>>>>>>>>>>>>> On 22/04/2024 08:02, Baolin Wang wrote:
>>>>>>>>>>>>>>> Anonymous pages have already been supported for multi-size
>>>>>>>>>>>>>>> (mTHP)
>>>>>>>>>>>>>>> allocation
>>>>>>>>>>>>>>> through commit 19eaf44954df, that can allow THP to be
>>>>>>>>>>>>>>> configured
>>>>>>>>>>>>>>> through the
>>>>>>>>>>>>>>> sysfs interface located at
>>>>>>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> However, the anonymous shared pages will ignore the
>>>>>>>>>>>>>>> anonymous mTHP rule
>>>>>>>>>>>>>>> configured through the sysfs interface, and can only use
>>>>>>>>>>>>>>> the PMD-mapped
>>>>>>>>>>>>>>> THP, that is not reasonable. Many implement anonymous page
>>>>>>>>>>>>>>> sharing
>>>>>>>>>>>>>>> through
>>>>>>>>>>>>>>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database 
>>>>>>>>>>>>>>> usage
>>>>>>>>>>>>>>> scenarios,
>>>>>>>>>>>>>>> therefore, users expect to apply an unified mTHP strategy
>>>>>>>>>>>>>>> for anonymous
>>>>>>>>>>>>>>> pages,
>>>>>>>>>>>>>>> also including the anonymous shared pages, in order to
>>>>>>>>>>>>>>> enjoy the
>>>>>>>>>>>>>>> benefits of
>>>>>>>>>>>>>>> mTHP. For example, lower latency than PMD-mapped THP,
>>>>>>>>>>>>>>> smaller memory
>>>>>>>>>>>>>>> bloat
>>>>>>>>>>>>>>> than PMD-mapped THP, contiguous PTEs on ARM architecture to
>>>>>>>>>>>>>>> reduce TLB
>>>>>>>>>>>>>>> miss
>>>>>>>>>>>>>>> etc.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This sounds like a very useful addition!
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Out of interest, can you point me at any workloads (and
>>>>>>>>>>>>>> off-the-shelf
>>>>>>>>>>>>>> benchmarks
>>>>>>>>>>>>>> for those workloads) that predominantly use shared anon 
>>>>>>>>>>>>>> memory?
>>>>>>>>>>>>>
>>>>>>>>>>>>> As far as I know, some database related workloads make
>>>>>>>>>>>>> extensive use of
>>>>>>>>>>>>> shared
>>>>>>>>>>>>> anonymous page, such as PolarDB[1] in our Alibaba fleet, or
>>>>>>>>>>>>> MySQL likely
>>>>>>>>>>>>> also
>>>>>>>>>>>>> uses shared anonymous memory. And I still need to do some
>>>>>>>>>>>>> investigation to
>>>>>>>>>>>>> measure the performance.
>>>>>>>>>>>>>
>>>>>>>>>>>>> [1] https://github.com/ApsaraDB/PolarDB-for-PostgreSQL
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks for the pointer!
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The primary strategy is that, the use of huge pages for
>>>>>>>>>>>>>>> anonymous shared
>>>>>>>>>>>>>>> pages
>>>>>>>>>>>>>>> still follows the global control determined by the mount
>>>>>>>>>>>>>>> option "huge="
>>>>>>>>>>>>>>> parameter
>>>>>>>>>>>>>>> or the sysfs interface at
>>>>>>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>>>>>>>>>>>> The utilization of mTHP is allowed only when the global
>>>>>>>>>>>>>>> 'huge' switch is
>>>>>>>>>>>>>>> enabled.
>>>>>>>>>>>>>>> Subsequently, the mTHP sysfs interface
>>>>>>>>>>>>>>> (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
>>>>>>>>>>>>>>> is checked to determine the mTHP size that can be used for
>>>>>>>>>>>>>>> large folio
>>>>>>>>>>>>>>> allocation
>>>>>>>>>>>>>>> for these anonymous shared pages.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'm not sure about this proposed control mechanism; won't it
>>>>>>>>>>>>>> break
>>>>>>>>>>>>>> compatibility? I could be wrong, but I don't think shmem's
>>>>>>>>>>>>>> use of THP
>>>>>>>>>>>>>> used to
>>>>>>>>>>>>>> depend upon the value of
>>>>>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/enabled?
>>>>>>>>>>>>>> So it
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes, I realized this after more testing.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> doesn't make sense to me that we now depend upon the
>>>>>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
>>>>>>>>>>>>>> values
>>>>>>>>>>>>>> (which by
>>>>>>>>>>>>>> default disables all sizes except 2M, which is set to
>>>>>>>>>>>>>> "inherit" from
>>>>>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/enabled).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The other problem is that shmem_enabled has a different set
>>>>>>>>>>>>>> of options
>>>>>>>>>>>>>> (always/never/within_size/advise/deny/force) to enabled
>>>>>>>>>>>>>> (always/madvise/never)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Perhaps it would be cleaner to do the same trick we did for
>>>>>>>>>>>>>> enabled;
>>>>>>>>>>>>>> Introduce
>>>>>>>>>>>>>> /mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which
>>>>>>>>>>>>>> can have all
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> same values as the top-level
>>>>>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/shmem_enabled,
>>>>>>>>>>>>>> plus the additional "inherit" option. By default all sizes
>>>>>>>>>>>>>> will be set to
>>>>>>>>>>>>>> "never" except 2M, which is set to "inherit".
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sounds good to me. But I do not want to copy all same values
>>>>>>>>>>>>> from
>>>>>>>>>>>>> top-level
>>>>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled':
>>>>>>>>>>>>> always within_size advise never deny force
>>>>>>>>>>>>>
>>>>>>>>>>>>> For mTHP's shmem_enabled interface, we can just keep below
>>>>>>>>>>>>> values:
>>>>>>>>>>>>> always within_size advise never
>>>>>>>>>>>>>
>>>>>>>>>>>>> Cause when checking if mTHP can be used for anon shmem,
>>>>>>>>>>>>> 'deny' is equal to
>>>>>>>>>>>>> 'never', and 'force' is equal to 'always'.
>>>>>>>>>>>>
>>>>>>>>>>>> I'll admit it wasn't completely clear to me after reading the
>>>>>>>>>>>> docs, but my
>>>>>>>>>>>> rough
>>>>>>>>>>>> understanding is:
>>>>>>>>>>>>
>>>>>>>>>>>>        - /sys/kernel/mm/transparent_hugepage/shmem_enabled
>>>>>>>>>>>> controls
>>>>>>>>>>>>          mmap(SHARED|ANON) allocations (mostly; see rule 3)
>>>>>>>>>>>>        - huge=... controls tmpfs allocations
>>>>>>>>>>>>        - deny and force in shmem_enabled are equivalent to
>>>>>>>>>>>> never and
>>>>>>>>>>>> always for
>>>>>>>>>>>>          mmap(SHARED|ANON) but additionally override all tmpfs
>>>>>>>>>>>> mounts so they
>>>>>>>>>>>> act as
>>>>>>>>>>>>          if they were mounted with huge=never or huge=always
>>>>>>>>>>>>
>>>>>>>>>>>> Is that correct? If so, then I think it still makes sense to
>>>>>>>>>>>> support
>>>>>>>>>>>> per-size
>>>>>>>>>>>
>>>>>>>>>>> Correct.
>>>>>>>>>>>
>>>>>>>>>>>> deny/force. Certainly if a per-size control is set to
>>>>>>>>>>>> "inherit" and the
>>>>>>>>>>>> top-level control is set to deny or force, you would need that
>>>>>>>>>>>> to mean
>>>>>>>>>>>> something.
>>>>>>>>>>>
>>>>>>>>>>> IMHO, the
>>>>>>>>>>> '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled' interface
>>>>>>>>>>> should only control the anonymous shmem. And 'huge=' controls
>>>>>>>>>>> tmpfs
>>>>>>>>>>> allocation,
>>>>>>>>>>> so we should not use anonymous control to override tmpfs
>>>>>>>>>>> control, which
>>>>>>>>>>> seems a
>>>>>>>>>>> little mess?
>>>>>>>>>>
>>>>>>>>>> I agree it would be cleaner to only handle mmap(SHARED|ANON)
>>>>>>>>>> here, and leave
>>>>>>>>>> the
>>>>>>>>>> tmpfs stuff for another time. But my point is that
>>>>>>>>>> /mm/transparent_hugepage/shmem_enabled already interferes with
>>>>>>>>>> tmpfs if the
>>>>>>>>>> value is deny or force. So if you have:
>>>>>>>>>>
>>>>>>>>>> echo deny > /mm/transparent_hugepage/shmem_enabled
>>>>>>>>>
>>>>>>>>> IIUC, this global control will cause shmem_is_huge() to always
>>>>>>>>> return
>>>>>>>>> false, so
>>>>>>>>> no matter how
>>>>>>>>> '/mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled' is set,
>>>>>>>>> anonymous shmem will not use mTHP. No?
>>>>>>>>
>>>>>>>> No, that's not how
>>>>>>>> '/mm/transparent_hugepage/hugepage-xxxkB/enabled' works, and
>>>>>>>> I think '/mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled'
>>>>>>>> should follow
>>>>>>>> the established pattern.
>>>>>>>>
>>>>>>>> For anon-private, each size is controlled by its
>>>>>>>> /mm/transparent_hugepage/hugepage-xxxkB/enabled value. Unless that
>>>>>>>> value is
>>>>>>>> "inherit", in which case the value in
>>>>>>>> /mm/transparent_hugepage/enabled is used
>>>>>>>> for that size.
>>>>>>>>
>>>>>>>> That approach enables us to 1) maintain back-compat and 2) control
>>>>>>>> each size
>>>>>>>> independently
>>>>>>>>
>>>>>>>> 1) is met because the default is that all sizes are initially set
>>>>>>>> to "never",
>>>>>>>> except the PMD-size (e.g.
>>>>>>>> /mm/transparent_hugepage/hugepage-2048kB/enabled)
>>>>>>>> which is initially set to inherit. So any mTHP unaware SW can
>>>>>>>> still modify
>>>>>>>> /mm/transparent_hugepage/enabled and it will still only apply to
>>>>>>>> PMD size.
>>>>>>>>
>>>>>>>> 2) is met because mTHP aware SW can come along and e.g. enable the
>>>>>>>> 64K size
>>>>>>>> (echo always > /mm/transparent_hugepage/hugepage-64kB/enabled)
>>>>>>>> without
>>>>>>>> having to
>>>>>>>> modify the value in /mm/transparent_hugepage/enabled.
>>>>>>>
>>>>>>> Thanks for explanation. Initially, I want to make
>>>>>>> ‘/mm/transparent_hugepage/shmem_enabled’ be a global control for
>>>>>>> huge page, but
>>>>>>> I think it should follow the same strategy as anon mTHP as you said.
>>>>>>>
>>>>>>>>>> echo inherit > 
>>>>>>>>>> /mm/transparent_hugepage/hugepage-64kB/shmem_enabled
>>>>>>>>>>
>>>>>>>>>> What does that mean?
>>>>>>>>
>>>>>>>> So I think /mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled
>>>>>>>> will need to
>>>>>>>> support the deny and force values. When applied to non-PMD sizes,
>>>>>>>> "deny" can
>>>>>>>> just be a noop for now, because there was no way to configure a
>>>>>>>> tmpfs mount for
>>>>>>>> non-PMD size THP in the first place. But I'm not sure what to do
>>>>>>>> with "force"?
>>>>>>>
>>>>>>> OK. And I also prefer that "force" should be a noop too, since anon
>>>>>>> shmem
>>>>>>> control should not configure tmpfs huge page allocation.
>>>>>>
>>>>>> I guess technically they won't be noops, but (for the non-PMD-sizes)
>>>>>> "force"
>>>>>> will be an alias for "always" and "deny" will be an alias for 
>>>>>> "never"?
>>>>>>
>>>>>> I was just a bit concerned about later changing that behavior to
>>>>>> also impact
>>>>>> tmpfs once tmpfs supports mTHP; could that cause breaks? But
>>>>>> thinking about it,
>>>>>> I don't see that as a problem.
>>>>>
>>>>> Is the question what should happen if we "inherit" "force" or if 
>>>>> someone
>>>>> specifies "force" for a mTP size explicitly?
>>>>
>>>> Well I think it amounts to the same thing; there isn't much point in
>>>> forbidding
>>>> "force" to be set directly because it can still be set indirectly 
>>>> through
>>>> "inherit". We can't forbid indirectly setting it, because "inherit"
>>>> could be set
>>>> first, then the top-level shmem_enabled changed to "force" after - 
>>>> and we
>>>> wouldn't want to fail that.
>>>
>>> The default for PMD should be "inherit", for the other mTHP sizes it
>>> should be "never".
>>>
>>> So we should fail if:
>>> * Setting top-level to "force" when any non-PMD size is "inherit"
>>> * Setting "inherit" of a non-PMD size when the top-level is force
>>
>> IMO, for tmpfs this is true, but for anon shmem, this 2 cases should not
>> fail.
> 
> If force does not apply to an mTHP size, it should fail if it would get 
> inherited. Until it applies and we enable it.
> 
> I'm still confused about all the toggles here, so could be I am missing 
> something.

Yes, this is a little messy:(

After thinking more, considering that 'force' is used to override the 
tmpfs mount option, and 'inherit' will inherit the global setting. Your 
suggestion will make the logic eary to understand (though it is valid 
for anon shmem mTHP allocations, which are not part of this scenario), 
Ryan, what do you think?

