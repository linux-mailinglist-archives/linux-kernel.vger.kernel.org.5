Return-Path: <linux-kernel+bounces-134901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634F89B867
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4301F22D36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AEB25570;
	Mon,  8 Apr 2024 07:30:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8110224B2F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561444; cv=none; b=Ob/es0z7z6Me+MzcJ6gnnT9zKtFINKvOeVY8oR9wOVZ+KAc4b40wFiLfhYt9J/7YoUcpm0nKRHvwS8JGDAoS7jGzMS9HKYP3BRZjKMy+iR2+mhsC62A7VXY+/ZoEQHAmIlNq52oiCvVXQUEgsLXoEoNXbD4+WnO/zzvQsf3uSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561444; c=relaxed/simple;
	bh=XYJsF0RgC5u+B3iimuS2ScRDOTFUcvmpGeRi1MIQLDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gus3P/Xp4UobrN8P/1yxDZIlGOp4TEcsjIiC9cgC/fPrWwz/zIJzDwc23W01x34jdMvNrupzd7BZ7MHqDzUaKtPw4g6sqIleyz3aK6aZRVtaV4XzK8c9a/9lsKcoLOB3+FzLrvckZD8kCSTlppwkQhUJyNlh+sPGMq9RudR7wSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1820B1007;
	Mon,  8 Apr 2024 00:31:12 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4635B3F64C;
	Mon,  8 Apr 2024 00:30:40 -0700 (PDT)
Message-ID: <533adb77-8c2b-40db-84cb-88de77ab92bb@arm.com>
Date: Mon, 8 Apr 2024 08:30:38 +0100
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Hildenbrand <david@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Eric Chanudet <echanude@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <Zg+qwooaWFNL7KIg@vm3> <fd4aed3a-42be-44e0-b3bb-12f77c5911a1@arm.com>
 <ZhEkif45F0aVvKPx@vm3>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZhEkif45F0aVvKPx@vm3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/04/2024 11:31, Itaru Kitayama wrote:
> Hi Ryan,
> 
> On Sat, Apr 06, 2024 at 09:32:34AM +0100, Ryan Roberts wrote:
>> Hi Itaru,
>>
>> On 05/04/2024 08:39, Itaru Kitayama wrote:
>>> On Thu, Apr 04, 2024 at 03:33:04PM +0100, Ryan Roberts wrote:
>>>> Hi All,
>>>>
>>>> It turns out that creating the linear map can take a significant proportion of
>>>> the total boot time, especially when rodata=full. And most of the time is spent
>>>> waiting on superfluous tlb invalidation and memory barriers. This series reworks
>>>> the kernel pgtable generation code to significantly reduce the number of those
>>>> TLBIs, ISBs and DSBs. See each patch for details.
>>>>
>>>> The below shows the execution time of map_mem() across a couple of different
>>>> systems with different RAM configurations. We measure after applying each patch
>>>> and show the improvement relative to base (v6.9-rc2):
>>>>
>>>>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>>>>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
>>>> ---------------|-------------|-------------|-------------|-------------
>>>>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
>>>> ---------------|-------------|-------------|-------------|-------------
>>>> base           |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442   (0%)
>>>> no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796 (-78%)
>>>> batch-barriers |   13 (-92%) |  162 (-93%) |  655 (-93%) |  1656 (-91%)
>>>> no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 (-95%) |  1257 (-93%)
>>>> lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 (-97%) |   838 (-95%)
>>>>
>>>> This series applies on top of v6.9-rc2. All mm selftests pass. I've compile and
>>>> boot tested various PAGE_SIZE and VA size configs.
>>>>
>>>> ---
>>>>
>>>> Changes since v1 [1]
>>>> ====================
>>>>
>>>>   - Added Tested-by tags (thanks to Eric and Itaru)
>>>>   - Renamed ___set_pte() -> __set_pte_nosync() (per Ard)
>>>>   - Reordered patches (biggest impact & least controversial first)
>>>>   - Reordered alloc/map/unmap functions in mmu.c to aid reader
>>>>   - pte_clear() -> __pte_clear() in clear_fixmap_nosync()
>>>>   - Reverted generic p4d_index() which caused x86 build error. Replaced with
>>>>     unconditional p4d_index() define under arm64.
>>>>
>>>>
>>>> [1] https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>> Ryan Roberts (4):
>>>>   arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>>>>   arm64: mm: Batch dsb and isb when populating pgtables
>>>>   arm64: mm: Don't remap pgtables for allocate vs populate
>>>>   arm64: mm: Lazily clear pte table mappings from fixmap
>>>>
>>>>  arch/arm64/include/asm/fixmap.h  |   5 +-
>>>>  arch/arm64/include/asm/mmu.h     |   8 +
>>>>  arch/arm64/include/asm/pgtable.h |  13 +-
>>>>  arch/arm64/kernel/cpufeature.c   |  10 +-
>>>>  arch/arm64/mm/fixmap.c           |  11 +
>>>>  arch/arm64/mm/mmu.c              | 377 +++++++++++++++++++++++--------
>>>>  6 files changed, 319 insertions(+), 105 deletions(-)
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>>
>>> I've build and boot tested the v2 on FVP, base is taken from your
>>> linux-rr repo. Running run_vmtests.sh on v2 left some gup longterm not oks, would you take a look at it? The mm ksefltests used is from your linux-rr repo too.
>>
>> Thanks for taking a look at this.
>>
>> I can't reproduce your issue unfortunately; steps as follows on Apple M2 VM:
>>
>> Config: arm64 defconfig + the following:
>>
>> # Squashfs for snaps, xfs for large file folios.
>> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
>> ./scripts/config --enable CONFIG_SQUASHFS_LZO
>> ./scripts/config --enable CONFIG_SQUASHFS_XZ
>> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
>> ./scripts/config --enable CONFIG_XFS_FS
>>
>> # For general mm debug.
>> ./scripts/config --enable CONFIG_DEBUG_VM
>> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
>> ./scripts/config --enable CONFIG_DEBUG_VM_RB
>> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
>> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
>>
>> # For mm selftests.
>> ./scripts/config --enable CONFIG_USERFAULTFD
>> ./scripts/config --enable CONFIG_TEST_VMALLOC
>> ./scripts/config --enable CONFIG_GUP_TEST
>>
>> Running on VM with 12G memory, split across 2 (emulated) NUMA nodes (needed by
>> some mm selftests), with kernel command line to reserve hugetlbs and other
>> features required by some mm selftests:
>>
>> "
>> transparent_hugepage=madvise earlycon root=/dev/vda2 secretmem.enable
>> hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2
>> default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K hugepages=0:2,1:2
>> "
>>
>> Ubuntu userspace running off XFS rootfs. Build and run mm selftests from same
>> git tree.
>>
>>
>> Although I don't think any of this config should make a difference to gup_longterm.
>>
>> Looks like your errors are all "ftruncate() failed". I've seen this problem on
>> our CI system. There it is due to running the tests from NFS file system. What
>> filesystem are you using? Perhaps you are sharing into the FVP using 9p? That
>> might also be problematic.
> 
> That was it. This time I booted up the kernel including your series on
> QEMU on my M1 and executed the gup_longterm program without the ftruncate
> failures. When testing your kernel on FVP, I was executing the script from the FVP's host filesystem using 9p.

I'm not sure exactly what the root cause is. Perhaps there isn't enough space on
the disk? It might be worth enhancing the error log to provide the errno in
tools/testing/selftests/mm/gup_longterm.c.

Thanks,
Ryan

> 
> Thanks,
> Itaru.
> 
>>
>> Does this problem reproduce with v6.9-rc2, without my patches? I except it
>> probably does?
>>
>> Thanks,
>> Ryan
>>
>>>
>>> Thanks,
>>> Itaru.
>>


