Return-Path: <linux-kernel+bounces-137065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B38689DBE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1EF1C22211
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255AF12FB0B;
	Tue,  9 Apr 2024 14:13:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA60912F5AF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671999; cv=none; b=tLZ5kDLLLF0yjKt/ZAHIjbsb+kKZoSbFKknmxOxTK6o+5EZgtfH5cOzyj/w7v/8EZiu8B+5VweYyGl78D3a6YqPh/PQRNaLWTkhYdO7j59rKczMxlJ4gqX5vIeFYSHvno3SMCW1iIFzjctrDafyfxyBu9upV4O2/67VlzQNitKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671999; c=relaxed/simple;
	bh=lG6x6Kx7/G8MO2/cVfUMmdotIQM6sDjSix0nr1ECeXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFtfu120CNyRbBRr4+z4RaejHeRIfGNTbXjfAcvUJ8PMxAz//Yo8DHXw93b7Ji8eoXJuoZdzQOhko5R2NofUxYcYnt97lYymAXUJrq7FPLW8tcdRFGmM3Lp8x33XOl8Qaa3nKnEEIcJ9ZA3XHBpePCOJOVRP+1alV7+0Lp7f4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E872139F;
	Tue,  9 Apr 2024 07:13:46 -0700 (PDT)
Received: from [10.1.33.185] (XHFQ2J9959.cambridge.arm.com [10.1.33.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 809D63F766;
	Tue,  9 Apr 2024 07:13:14 -0700 (PDT)
Message-ID: <b5e68f81-f917-4f82-8e86-a691a0721291@arm.com>
Date: Tue, 9 Apr 2024 15:13:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Speed up boot with faster linear map creation
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <Zg+qwooaWFNL7KIg@vm3> <fd4aed3a-42be-44e0-b3bb-12f77c5911a1@arm.com>
 <ZhEkif45F0aVvKPx@vm3> <533adb77-8c2b-40db-84cb-88de77ab92bb@arm.com>
 <FCDCBCEE-7D97-4769-AB95-7294A9CE18E0@linux.dev>
 <1d5abb48-08a8-4d83-a681-6915bc7b6907@arm.com>
 <268FBD1C-B102-4726-A7F4-1125123BDA7A@linux.dev>
 <5e4dc2fe-2945-4fc5-a533-c8b2d04668a0@redhat.com>
 <d02959bc-84d8-4c74-a0da-9ad1159502e1@redhat.com>
 <c0d66e0d-f492-49ba-b79a-9215317bd65f@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c0d66e0d-f492-49ba-b79a-9215317bd65f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/04/2024 12:51, David Hildenbrand wrote:
> On 09.04.24 13:29, David Hildenbrand wrote:
>> On 09.04.24 13:22, David Hildenbrand wrote:
>>> On 09.04.24 12:13, Itaru Kitayama wrote:
>>>>
>>>>
>>>>> On Apr 9, 2024, at 19:04, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> On 09/04/2024 01:10, Itaru Kitayama wrote:
>>>>>> Hi Ryan,
>>>>>>
>>>>>>> On Apr 8, 2024, at 16:30, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>
>>>>>>> On 06/04/2024 11:31, Itaru Kitayama wrote:
>>>>>>>> Hi Ryan,
>>>>>>>>
>>>>>>>> On Sat, Apr 06, 2024 at 09:32:34AM +0100, Ryan Roberts wrote:
>>>>>>>>> Hi Itaru,
>>>>>>>>>
>>>>>>>>> On 05/04/2024 08:39, Itaru Kitayama wrote:
>>>>>>>>>> On Thu, Apr 04, 2024 at 03:33:04PM +0100, Ryan Roberts wrote:
>>>>>>>>>>> Hi All,
>>>>>>>>>>>
>>>>>>>>>>> It turns out that creating the linear map can take a significant
>>>>>>>>>>> proportion of
>>>>>>>>>>> the total boot time, especially when rodata=full. And most of the
>>>>>>>>>>> time is spent
>>>>>>>>>>> waiting on superfluous tlb invalidation and memory barriers. This
>>>>>>>>>>> series reworks
>>>>>>>>>>> the kernel pgtable generation code to significantly reduce the number
>>>>>>>>>>> of those
>>>>>>>>>>> TLBIs, ISBs and DSBs. See each patch for details.
>>>>>>>>>>>
>>>>>>>>>>> The below shows the execution time of map_mem() across a couple of
>>>>>>>>>>> different
>>>>>>>>>>> systems with different RAM configurations. We measure after applying
>>>>>>>>>>> each patch
>>>>>>>>>>> and show the improvement relative to base (v6.9-rc2):
>>>>>>>>>>>
>>>>>>>>>>>                   | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere
>>>>>>>>>>> Altra
>>>>>>>>>>>                   | VM, 16G     | VM, 64G     | VM, 256G    | Metal,
>>>>>>>>>>> 512G
>>>>>>>>>>> ---------------|-------------|-------------|-------------|-------------
>>>>>>>>>>>                   |   ms    (%) |   ms    (%) |   ms    (%) |   
>>>>>>>>>>> ms    (%)
>>>>>>>>>>> ---------------|-------------|-------------|-------------|-------------
>>>>>>>>>>> base           |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442   (0%)
>>>>>>>>>>> no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796 (-78%)
>>>>>>>>>>> batch-barriers |   13 (-92%) |  162 (-93%) |  655 (-93%) |  1656 (-91%)
>>>>>>>>>>> no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 (-95%) |  1257 (-93%)
>>>>>>>>>>> lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 (-97%) |   838 (-95%)
>>>>>>>>>>>
>>>>>>>>>>> This series applies on top of v6.9-rc2. All mm selftests pass. I've
>>>>>>>>>>> compile and
>>>>>>>>>>> boot tested various PAGE_SIZE and VA size configs.
>>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>> Changes since v1 [1]
>>>>>>>>>>> ====================
>>>>>>>>>>>
>>>>>>>>>>>      - Added Tested-by tags (thanks to Eric and Itaru)
>>>>>>>>>>>      - Renamed ___set_pte() -> __set_pte_nosync() (per Ard)
>>>>>>>>>>>      - Reordered patches (biggest impact & least controversial first)
>>>>>>>>>>>      - Reordered alloc/map/unmap functions in mmu.c to aid reader
>>>>>>>>>>>      - pte_clear() -> __pte_clear() in clear_fixmap_nosync()
>>>>>>>>>>>      - Reverted generic p4d_index() which caused x86 build error.
>>>>>>>>>>> Replaced with
>>>>>>>>>>>        unconditional p4d_index() define under arm64.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> [1]
>>>>>>>>>>> https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/<https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/>
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Ryan
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Ryan Roberts (4):
>>>>>>>>>>>      arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>>>>>>>>>>>      arm64: mm: Batch dsb and isb when populating pgtables
>>>>>>>>>>>      arm64: mm: Don't remap pgtables for allocate vs populate
>>>>>>>>>>>      arm64: mm: Lazily clear pte table mappings from fixmap
>>>>>>>>>>>
>>>>>>>>>>> arch/arm64/include/asm/fixmap.h  |   5 +-
>>>>>>>>>>> arch/arm64/include/asm/mmu.h     |   8 +
>>>>>>>>>>> arch/arm64/include/asm/pgtable.h |  13 +-
>>>>>>>>>>> arch/arm64/kernel/cpufeature.c   |  10 +-
>>>>>>>>>>> arch/arm64/mm/fixmap.c           |  11 +
>>>>>>>>>>> arch/arm64/mm/mmu.c              | 377 +++++++++++++++++++++++--------
>>>>>>>>>>> 6 files changed, 319 insertions(+), 105 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> -- 
>>>>>>>>>>> 2.25.1
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I've build and boot tested the v2 on FVP, base is taken from your
>>>>>>>>>> linux-rr repo. Running run_vmtests.sh on v2 left some gup longterm not
>>>>>>>>>> oks, would you take a look at it? The mm ksefltests used is from your
>>>>>>>>>> linux-rr repo too.
>>>>>>>>>
>>>>>>>>> Thanks for taking a look at this.
>>>>>>>>>
>>>>>>>>> I can't reproduce your issue unfortunately; steps as follows on Apple
>>>>>>>>> M2 VM:
>>>>>>>>>
>>>>>>>>> Config: arm64 defconfig + the following:
>>>>>>>>>
>>>>>>>>> # Squashfs for snaps, xfs for large file folios.
>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZO
>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_XZ
>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
>>>>>>>>> ./scripts/config --enable CONFIG_XFS_FS
>>>>>>>>>
>>>>>>>>> # For general mm debug.
>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM
>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_RB
>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
>>>>>>>>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
>>>>>>>>>
>>>>>>>>> # For mm selftests.
>>>>>>>>> ./scripts/config --enable CONFIG_USERFAULTFD
>>>>>>>>> ./scripts/config --enable CONFIG_TEST_VMALLOC
>>>>>>>>> ./scripts/config --enable CONFIG_GUP_TEST
>>>>>>>>>
>>>>>>>>> Running on VM with 12G memory, split across 2 (emulated) NUMA nodes
>>>>>>>>> (needed by
>>>>>>>>> some mm selftests), with kernel command line to reserve hugetlbs and other
>>>>>>>>> features required by some mm selftests:
>>>>>>>>>
>>>>>>>>> "
>>>>>>>>> transparent_hugepage=madvise earlycon root=/dev/vda2 secretmem.enable
>>>>>>>>> hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2
>>>>>>>>> default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K hugepages=0:2,1:2
>>>>>>>>> "
>>>>>>>>>
>>>>>>>>> Ubuntu userspace running off XFS rootfs. Build and run mm selftests
>>>>>>>>> from same
>>>>>>>>> git tree.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Although I don't think any of this config should make a difference to
>>>>>>>>> gup_longterm.
>>>>>>>>>
>>>>>>>>> Looks like your errors are all "ftruncate() failed". I've seen this
>>>>>>>>> problem on
>>>>>>>>> our CI system. There it is due to running the tests from NFS file
>>>>>>>>> system. What
>>>>>>>>> filesystem are you using? Perhaps you are sharing into the FVP using
>>>>>>>>> 9p? That
>>>>>>>>> might also be problematic.
>>>>>>>>
>>>>>>>> That was it. This time I booted up the kernel including your series on
>>>>>>>> QEMU on my M1 and executed the gup_longterm program without the ftruncate
>>>>>>>> failures. When testing your kernel on FVP, I was executing the script
>>>>>>>> from the FVP's host filesystem using 9p.
>>>>>>>
>>>>>>> I'm not sure exactly what the root cause is. Perhaps there isn't enough
>>>>>>> space on
>>>>>>> the disk? It might be worth enhancing the error log to provide the errno in
>>>>>>> tools/testing/selftests/mm/gup_longterm.c.
>>>>>>>
>>>>>>
>>>>>> Attached is the strace’d gup_longterm executiong log on your
>>>>>> pgtable-boot-speedup-v2 kernel.
>>>>>
>>>>> Sorry are you saying that it only fails with the pgtable-boot-speedup-v2 patch
>>>>> set applied? I thought we previously concluded that it was independent of
>>>>> that?
>>>>> I was under the impression that it was filesystem related and not something
>>>>> that
>>>>> I was planning to investigate.
>>>>
>>>> No, irrespective of the kernel, if using 9p on FVP the test program fails.
>>>> It is indeed 9p filesystem related, as I switched to using NFS all the
>>>> issues are gone.
>>>
>>> Did it never work on 9p? If so, we might have to SKIP that test.
>>>
>>> openat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", O_RDWR|O_CREAT|O_EXCL,
>>> 0600) = 3
>>> unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", 0) = 0
>>> fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not
>>> supported)
>>> ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
>>
>> Note: I'm wondering if the unlinkat here is the problem that makes
>> ftruncate() with 9p result in weird errors (e.g., the hypervisor
>> unlinked the file and cannot reopen it for the fstatfs/ftruncate. ...
>> which gives us weird errors here).
>>
>> Then, we should lookup the fs type in run_with_local_tmpfile() before
>> the unlink() and simply skip the test if it is 9p.
> 
> The unlink with 9p most certainly was a known issue in the past:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/103
> 
> Maybe it's still an issue with older hypervisors (QEMU?)? Or it was never
> completely resolved?

I believe Itaru is running on FVP (Fixed Virtual Platform - "fast model" - Arm's architecture emulator). So QEMU won't be involved here. The FVP emulates a 9p device, so perhaps the bug is in there.

Note that I see lots of "fallocate() failed" failures in gup_longterm when running on our CI system. This is a completely different setup; Real HW with Linux running bare metal using an NFS rootfs. I'm not sure if this is related. Logs show it failing consistently for the "tmpfile" and "local tmpfile" test configs. I also see a couple of these fails in the cow tests.

Logs for reference:

# # ----------------------
# # running ./gup_longterm
# # ----------------------
# # # [INFO] detected hugetlb page size: 2048 KiB
# # # [INFO] detected hugetlb page size: 32768 KiB
# # # [INFO] detected hugetlb page size: 64 KiB
# # # [INFO] detected hugetlb page size: 1048576 KiB
# # TAP version 13
# # 1..56
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd
# # ok 1 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
# # not ok 2 fallocate() failed
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
# # not ok 3 fallocate() failed
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
# # ok 4 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
# # ok 5 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (64 kB)
# # ok 6 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
# # ok 7 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd
# # ok 8 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with tmpfile
# # not ok 9 fallocate() failed
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with local tmpfile
# # not ok 10 fallocate() failed
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
# # ok 11 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
# # ok 12 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (64 kB)
# # ok 13 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
# # ok 14 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd
# # ok 15 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
# # not ok 16 fallocate() failed
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
# # not ok 17 fallocate() failed
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
# # ok 18 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
# # ok 19 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (64 kB)
# # ok 20 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
# # ok 21 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd
# # ok 22 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with tmpfile
# # not ok 23 fallocate() failed
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with local tmpfile
# # not ok 24 fallocate() failed
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
# # ok 25 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
# # ok 26 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (64 kB)
# # ok 27 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
# # ok 28 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
# # ok 29 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
# # not ok 30 fallocate() failed
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
# # not ok 31 fallocate() failed
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
# # ok 32 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
# # ok 33 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (64 kB)
# # ok 34 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
# # ok 35 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd
# # ok 36 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
# # not ok 37 fallocate() failed
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
# # not ok 38 fallocate() failed
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
# # ok 39 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
# # ok 40 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (64 kB)
# # ok 41 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
# # ok 42 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
# # ok 43 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
# # not ok 44 fallocate() failed
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
# # not ok 45 fallocate() failed
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
# # ok 46 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
# # ok 47 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (64 kB)
# # ok 48 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
# # ok 49 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd
# # ok 50 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
# # not ok 51 fallocate() failed
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
# # not ok 52 fallocate() failed
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
# # ok 53 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
# # ok 54 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (64 kB)
# # ok 55 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
# # ok 56 Should have worked
# # Bail out! 16 out of 56 tests failed
# # # Totals: pass:40 fail:16 xfail:0 xpass:0 skip:0 error:0
# # [FAIL]
# not ok 13 gup_longterm # exit=1

