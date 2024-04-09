Return-Path: <linux-kernel+bounces-136621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC4E89D63C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CC51C211E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8695485924;
	Tue,  9 Apr 2024 10:04:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319EE7D3E8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657091; cv=none; b=RSGjoBhCzaPhGEB2Z1PXF/1UpQWyoBkqlzTUbQGk1GJZa47OnoLEXMJa++omBG9Gb7Lryi0ogb6N6iTNZe0Igwzu56BH6lNnK9JSh4SXn/QZfcMNTvevdyazLBJAZWdbeu8bpn3zc5axODMkGXSVfeeF0JU/2esHB4lheQota1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657091; c=relaxed/simple;
	bh=Qolt17K47hyi9x89dn7T4Mg+Fe00rnphYHtpYdvu8Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFYCWoekAn0ppd5y1unZ2KonQVCmoxK4XmzmzllfvwecEfbigNkOP8dJR2KCJUVZmopc/bYEkodNp/dPzQ06owaqZcOjNSELGMu7R84o6Z8s8rLkzgMBqsU3mP0XwFXCx0iH3OJloxvXBwyfsMgyiVajzbKOz5JSkFv7CmZBPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED1ECDA7;
	Tue,  9 Apr 2024 03:05:18 -0700 (PDT)
Received: from [10.1.33.185] (unknown [10.1.33.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED383F6C4;
	Tue,  9 Apr 2024 03:04:47 -0700 (PDT)
Message-ID: <1d5abb48-08a8-4d83-a681-6915bc7b6907@arm.com>
Date: Tue, 9 Apr 2024 11:04:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Speed up boot with faster linear map creation
Content-Language: en-GB
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Hildenbrand <david@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <Zg+qwooaWFNL7KIg@vm3> <fd4aed3a-42be-44e0-b3bb-12f77c5911a1@arm.com>
 <ZhEkif45F0aVvKPx@vm3> <533adb77-8c2b-40db-84cb-88de77ab92bb@arm.com>
 <FCDCBCEE-7D97-4769-AB95-7294A9CE18E0@linux.dev>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <FCDCBCEE-7D97-4769-AB95-7294A9CE18E0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/04/2024 01:10, Itaru Kitayama wrote:
> Hi Ryan,
> 
>> On Apr 8, 2024, at 16:30, Ryan Roberts <ryan.roberts@arm.com> wrote:
>> 
>> On 06/04/2024 11:31, Itaru Kitayama wrote:
>>> Hi Ryan,
>>> 
>>> On Sat, Apr 06, 2024 at 09:32:34AM +0100, Ryan Roberts wrote:
>>>> Hi Itaru,
>>>> 
>>>> On 05/04/2024 08:39, Itaru Kitayama wrote:
>>>>> On Thu, Apr 04, 2024 at 03:33:04PM +0100, Ryan Roberts wrote:
>>>>>> Hi All,
>>>>>> 
>>>>>> It turns out that creating the linear map can take a significant proportion of
>>>>>> the total boot time, especially when rodata=full. And most of the time is spent
>>>>>> waiting on superfluous tlb invalidation and memory barriers. This series reworks
>>>>>> the kernel pgtable generation code to significantly reduce the number of those
>>>>>> TLBIs, ISBs and DSBs. See each patch for details.
>>>>>> 
>>>>>> The below shows the execution time of map_mem() across a couple of different
>>>>>> systems with different RAM configurations. We measure after applying each patch
>>>>>> and show the improvement relative to base (v6.9-rc2):
>>>>>> 
>>>>>>               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>>>>>>               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
>>>>>> ---------------|-------------|-------------|-------------|-------------
>>>>>>               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
>>>>>> ---------------|-------------|-------------|-------------|-------------
>>>>>> base           |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442   (0%)
>>>>>> no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796 (-78%)
>>>>>> batch-barriers |   13 (-92%) |  162 (-93%) |  655 (-93%) |  1656 (-91%)
>>>>>> no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 (-95%) |  1257 (-93%)
>>>>>> lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 (-97%) |   838 (-95%)
>>>>>> 
>>>>>> This series applies on top of v6.9-rc2. All mm selftests pass. I've compile and
>>>>>> boot tested various PAGE_SIZE and VA size configs.
>>>>>> 
>>>>>> ---
>>>>>> 
>>>>>> Changes since v1 [1]
>>>>>> ====================
>>>>>> 
>>>>>>  - Added Tested-by tags (thanks to Eric and Itaru)
>>>>>>  - Renamed ___set_pte() -> __set_pte_nosync() (per Ard)
>>>>>>  - Reordered patches (biggest impact & least controversial first)
>>>>>>  - Reordered alloc/map/unmap functions in mmu.c to aid reader
>>>>>>  - pte_clear() -> __pte_clear() in clear_fixmap_nosync()
>>>>>>  - Reverted generic p4d_index() which caused x86 build error. Replaced with
>>>>>>    unconditional p4d_index() define under arm64.
>>>>>> 
>>>>>> 
>>>>>> [1] https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/ <https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/>
>>>>>> 
>>>>>> Thanks,
>>>>>> Ryan
>>>>>> 
>>>>>> 
>>>>>> Ryan Roberts (4):
>>>>>>  arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>>>>>>  arm64: mm: Batch dsb and isb when populating pgtables
>>>>>>  arm64: mm: Don't remap pgtables for allocate vs populate
>>>>>>  arm64: mm: Lazily clear pte table mappings from fixmap
>>>>>> 
>>>>>> arch/arm64/include/asm/fixmap.h  |   5 +-
>>>>>> arch/arm64/include/asm/mmu.h     |   8 +
>>>>>> arch/arm64/include/asm/pgtable.h |  13 +-
>>>>>> arch/arm64/kernel/cpufeature.c   |  10 +-
>>>>>> arch/arm64/mm/fixmap.c           |  11 +
>>>>>> arch/arm64/mm/mmu.c              | 377 +++++++++++++++++++++++--------
>>>>>> 6 files changed, 319 insertions(+), 105 deletions(-)
>>>>>> 
>>>>>> --
>>>>>> 2.25.1
>>>>>> 
>>>>> 
>>>>> I've build and boot tested the v2 on FVP, base is taken from your
>>>>> linux-rr repo. Running run_vmtests.sh on v2 left some gup longterm not oks, would you take a look at it? The mm ksefltests used is from your linux-rr repo too.
>>>> 
>>>> Thanks for taking a look at this.
>>>> 
>>>> I can't reproduce your issue unfortunately; steps as follows on Apple M2 VM:
>>>> 
>>>> Config: arm64 defconfig + the following:
>>>> 
>>>> # Squashfs for snaps, xfs for large file folios.
>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZO
>>>> ./scripts/config --enable CONFIG_SQUASHFS_XZ
>>>> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
>>>> ./scripts/config --enable CONFIG_XFS_FS
>>>> 
>>>> # For general mm debug.
>>>> ./scripts/config --enable CONFIG_DEBUG_VM
>>>> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
>>>> ./scripts/config --enable CONFIG_DEBUG_VM_RB
>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
>>>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
>>>> 
>>>> # For mm selftests.
>>>> ./scripts/config --enable CONFIG_USERFAULTFD
>>>> ./scripts/config --enable CONFIG_TEST_VMALLOC
>>>> ./scripts/config --enable CONFIG_GUP_TEST
>>>> 
>>>> Running on VM with 12G memory, split across 2 (emulated) NUMA nodes (needed by
>>>> some mm selftests), with kernel command line to reserve hugetlbs and other
>>>> features required by some mm selftests:
>>>> 
>>>> "
>>>> transparent_hugepage=madvise earlycon root=/dev/vda2 secretmem.enable
>>>> hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2
>>>> default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K hugepages=0:2,1:2
>>>> "
>>>> 
>>>> Ubuntu userspace running off XFS rootfs. Build and run mm selftests from same
>>>> git tree.
>>>> 
>>>> 
>>>> Although I don't think any of this config should make a difference to gup_longterm.
>>>> 
>>>> Looks like your errors are all "ftruncate() failed". I've seen this problem on
>>>> our CI system. There it is due to running the tests from NFS file system. What
>>>> filesystem are you using? Perhaps you are sharing into the FVP using 9p? That
>>>> might also be problematic.
>>> 
>>> That was it. This time I booted up the kernel including your series on
>>> QEMU on my M1 and executed the gup_longterm program without the ftruncate
>>> failures. When testing your kernel on FVP, I was executing the script from the FVP's host filesystem using 9p.
>> 
>> I'm not sure exactly what the root cause is. Perhaps there isn't enough space on
>> the disk? It might be worth enhancing the error log to provide the errno in
>> tools/testing/selftests/mm/gup_longterm.c.
>> 
> 
> Attached is the strace’d gup_longterm executiong log on your
> pgtable-boot-speedup-v2 kernel.

Sorry are you saying that it only fails with the pgtable-boot-speedup-v2 patch
set applied? I thought we previously concluded that it was independent of that?
I was under the impression that it was filesystem related and not something that
I was planning to investigate.

> 
> Thanks,
> Itaru.
> 
>> Thanks,
>> Ryan
>> 
>>> 
>>> Thanks,
>>> Itaru.
>>> 
>>>> 
>>>> Does this problem reproduce with v6.9-rc2, without my patches? I except it
>>>> probably does?
>>>> 
>>>> Thanks,
>>>> Ryan
>>>> 
>>>>> 
>>>>> Thanks,
>>>>> Itaru.
> 
> 


