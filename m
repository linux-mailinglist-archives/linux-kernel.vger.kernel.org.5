Return-Path: <linux-kernel+bounces-137693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE289E613
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2800D283C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2B9158DC3;
	Tue,  9 Apr 2024 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FbNoYfX/"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD592156F4E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705470; cv=none; b=PnBM1PRSRZ2WD12WZAUzY0899H+/L2Rvnq3sXrR/zFeSLf5f8Zw4sZ3HoLM1tUNk0J4IqdJNC48NM0BMyPKb+TfVw4+aheo40wegqXeyQM/MW6oeZBhxjxNv4N5TavBPfxnlVEo4irWHdfaTvOz85ptP1isrV80vhtbRcju7cpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705470; c=relaxed/simple;
	bh=GHowE6rSKpa+0vodEeQuqp3EU/pnkgWdv2EUSEe2T4k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eTdlMy7Weg1DWE9kz4e0oLjRx+GSzXEYwDPOnq6ceCRRjdIf9AhlBipg5WY8PZ55ElbmES3AM/rFsxhY2VGmbnRxfhhCkdwQ2sMoCdjvqqDAY2WkFfeco+SCQF17q083xrLmJMOlpy26suENhFSG67GE4zctBPPbkqX1dV+sVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FbNoYfX/; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712705465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLe0Ge+h5210FpthFDM6maZCxUBDEJyCsCSH7nsHMBU=;
	b=FbNoYfX/uAEQuz43an1IOwQobDohYZMmmsVZlr46pOaDFhZwSz+8Xn/NY9lh5pTryIY+Bm
	u+jJx7iadj3TP7AwiI0necWO6VVL4xqMLYDqQnCHCfH/ihyxOZzLvpQyziNQFYVgUY4NfA
	IDjBFYHz2vudamjs2lNZJ9jpPHHWbBg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 0/4] Speed up boot with faster linear map creation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <156cf812-a2de-4480-80dc-31c38ca0eb57@redhat.com>
Date: Wed, 10 Apr 2024 08:30:41 +0900
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Donald Dutile <ddutile@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AA82C6E-F7E7-40A3-952D-392735E1405A@linux.dev>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <Zg+qwooaWFNL7KIg@vm3> <fd4aed3a-42be-44e0-b3bb-12f77c5911a1@arm.com>
 <ZhEkif45F0aVvKPx@vm3> <533adb77-8c2b-40db-84cb-88de77ab92bb@arm.com>
 <FCDCBCEE-7D97-4769-AB95-7294A9CE18E0@linux.dev>
 <1d5abb48-08a8-4d83-a681-6915bc7b6907@arm.com>
 <268FBD1C-B102-4726-A7F4-1125123BDA7A@linux.dev>
 <5e4dc2fe-2945-4fc5-a533-c8b2d04668a0@redhat.com>
 <d02959bc-84d8-4c74-a0da-9ad1159502e1@redhat.com>
 <c0d66e0d-f492-49ba-b79a-9215317bd65f@redhat.com>
 <b5e68f81-f917-4f82-8e86-a691a0721291@arm.com>
 <d1aca51c-2433-4e06-a3ef-842e27371db6@redhat.com>
 <e7af023f-39cd-4aa4-aa13-dd6aabea4cdf@arm.com>
 <156cf812-a2de-4480-80dc-31c38ca0eb57@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Migadu-Flow: FLOW_OUT

Hi David,

> On Apr 9, 2024, at 23:45, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 09.04.24 16:39, Ryan Roberts wrote:
>> On 09/04/2024 15:29, David Hildenbrand wrote:
>>> On 09.04.24 16:13, Ryan Roberts wrote:
>>>> On 09/04/2024 12:51, David Hildenbrand wrote:
>>>>> On 09.04.24 13:29, David Hildenbrand wrote:
>>>>>> On 09.04.24 13:22, David Hildenbrand wrote:
>>>>>>> On 09.04.24 12:13, Itaru Kitayama wrote:
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> On Apr 9, 2024, at 19:04, Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>>>>>>>>>=20
>>>>>>>>> On 09/04/2024 01:10, Itaru Kitayama wrote:
>>>>>>>>>> Hi Ryan,
>>>>>>>>>>=20
>>>>>>>>>>> On Apr 8, 2024, at 16:30, Ryan Roberts =
<ryan.roberts@arm.com> wrote:
>>>>>>>>>>>=20
>>>>>>>>>>> On 06/04/2024 11:31, Itaru Kitayama wrote:
>>>>>>>>>>>> Hi Ryan,
>>>>>>>>>>>>=20
>>>>>>>>>>>> On Sat, Apr 06, 2024 at 09:32:34AM +0100, Ryan Roberts =
wrote:
>>>>>>>>>>>>> Hi Itaru,
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> On 05/04/2024 08:39, Itaru Kitayama wrote:
>>>>>>>>>>>>>> On Thu, Apr 04, 2024 at 03:33:04PM +0100, Ryan Roberts =
wrote:
>>>>>>>>>>>>>>> Hi All,
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> It turns out that creating the linear map can take a =
significant
>>>>>>>>>>>>>>> proportion of
>>>>>>>>>>>>>>> the total boot time, especially when rodata=3Dfull. And =
most of the
>>>>>>>>>>>>>>> time is spent
>>>>>>>>>>>>>>> waiting on superfluous tlb invalidation and memory =
barriers. This
>>>>>>>>>>>>>>> series reworks
>>>>>>>>>>>>>>> the kernel pgtable generation code to significantly =
reduce the number
>>>>>>>>>>>>>>> of those
>>>>>>>>>>>>>>> TLBIs, ISBs and DSBs. See each patch for details.
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> The below shows the execution time of map_mem() across a =
couple of
>>>>>>>>>>>>>>> different
>>>>>>>>>>>>>>> systems with different RAM configurations. We measure =
after applying
>>>>>>>>>>>>>>> each patch
>>>>>>>>>>>>>>> and show the improvement relative to base (v6.9-rc2):
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>                    | Apple M2 VM | Ampere Altra| Ampere =
Altra| Ampere
>>>>>>>>>>>>>>> Altra
>>>>>>>>>>>>>>>                    | VM, 16G     | VM, 64G     | VM, =
256G    | Metal,
>>>>>>>>>>>>>>> 512G
>>>>>>>>>>>>>>> =
---------------|-------------|-------------|-------------|-------------
>>>>>>>>>>>>>>>                    |   ms    (%) |   ms    (%) |   ms    =
(%) |
>>>>>>>>>>>>>>> ms    (%)
>>>>>>>>>>>>>>> =
---------------|-------------|-------------|-------------|-------------
>>>>>>>>>>>>>>> base           |  153   (0%) | 2227   (0%) | 8798   (0%) =
| 17442
>>>>>>>>>>>>>>> (0%)
>>>>>>>>>>>>>>> no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 (-80%) =
|  3796
>>>>>>>>>>>>>>> (-78%)
>>>>>>>>>>>>>>> batch-barriers |   13 (-92%) |  162 (-93%) |  655 (-93%) =
|  1656
>>>>>>>>>>>>>>> (-91%)
>>>>>>>>>>>>>>> no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 (-95%) =
|  1257
>>>>>>>>>>>>>>> (-93%)
>>>>>>>>>>>>>>> lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 (-97%) =
|   838
>>>>>>>>>>>>>>> (-95%)
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> This series applies on top of v6.9-rc2. All mm selftests =
pass. I've
>>>>>>>>>>>>>>> compile and
>>>>>>>>>>>>>>> boot tested various PAGE_SIZE and VA size configs.
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> Changes since v1 [1]
>>>>>>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>       - Added Tested-by tags (thanks to Eric and Itaru)
>>>>>>>>>>>>>>>       - Renamed ___set_pte() -> __set_pte_nosync() (per =
Ard)
>>>>>>>>>>>>>>>       - Reordered patches (biggest impact & least =
controversial first)
>>>>>>>>>>>>>>>       - Reordered alloc/map/unmap functions in mmu.c to =
aid reader
>>>>>>>>>>>>>>>       - pte_clear() -> __pte_clear() in =
clear_fixmap_nosync()
>>>>>>>>>>>>>>>       - Reverted generic p4d_index() which caused x86 =
build error.
>>>>>>>>>>>>>>> Replaced with
>>>>>>>>>>>>>>>         unconditional p4d_index() define under arm64.
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> [1]
>>>>>>>>>>>>>>> =
https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.rob=
erts@arm.com/<https://lore.kernel.org/linux-arm-kernel/20240326101448.3453=
626-1-ryan.roberts@arm.com/>
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Ryan
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> Ryan Roberts (4):
>>>>>>>>>>>>>>>       arm64: mm: Don't remap pgtables per-cont(pte|pmd) =
block
>>>>>>>>>>>>>>>       arm64: mm: Batch dsb and isb when populating =
pgtables
>>>>>>>>>>>>>>>       arm64: mm: Don't remap pgtables for allocate vs =
populate
>>>>>>>>>>>>>>>       arm64: mm: Lazily clear pte table mappings from =
fixmap
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> arch/arm64/include/asm/fixmap.h  |   5 +-
>>>>>>>>>>>>>>> arch/arm64/include/asm/mmu.h     |   8 +
>>>>>>>>>>>>>>> arch/arm64/include/asm/pgtable.h |  13 +-
>>>>>>>>>>>>>>> arch/arm64/kernel/cpufeature.c   |  10 +-
>>>>>>>>>>>>>>> arch/arm64/mm/fixmap.c           |  11 +
>>>>>>>>>>>>>>> arch/arm64/mm/mmu.c              | 377 =
+++++++++++++++++++++++--------
>>>>>>>>>>>>>>> 6 files changed, 319 insertions(+), 105 deletions(-)
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> --=20
>>>>>>>>>>>>>>> 2.25.1
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> I've build and boot tested the v2 on FVP, base is taken =
from your
>>>>>>>>>>>>>> linux-rr repo. Running run_vmtests.sh on v2 left some gup =
longterm not
>>>>>>>>>>>>>> oks, would you take a look at it? The mm ksefltests used =
is from your
>>>>>>>>>>>>>> linux-rr repo too.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Thanks for taking a look at this.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> I can't reproduce your issue unfortunately; steps as =
follows on Apple
>>>>>>>>>>>>> M2 VM:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Config: arm64 defconfig + the following:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # Squashfs for snaps, xfs for large file folios.
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZO
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_XZ
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_XFS_FS
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # For general mm debug.
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_RB
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # For mm selftests.
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_USERFAULTFD
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_TEST_VMALLOC
>>>>>>>>>>>>> ./scripts/config --enable CONFIG_GUP_TEST
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Running on VM with 12G memory, split across 2 (emulated) =
NUMA nodes
>>>>>>>>>>>>> (needed by
>>>>>>>>>>>>> some mm selftests), with kernel command line to reserve =
hugetlbs and
>>>>>>>>>>>>> other
>>>>>>>>>>>>> features required by some mm selftests:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> "
>>>>>>>>>>>>> transparent_hugepage=3Dmadvise earlycon root=3D/dev/vda2 =
secretmem.enable
>>>>>>>>>>>>> hugepagesz=3D1G hugepages=3D0:2,1:2 hugepagesz=3D32M =
hugepages=3D0:2,1:2
>>>>>>>>>>>>> default_hugepagesz=3D2M hugepages=3D0:64,1:64 =
hugepagesz=3D64K
>>>>>>>>>>>>> hugepages=3D0:2,1:2
>>>>>>>>>>>>> "
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Ubuntu userspace running off XFS rootfs. Build and run mm =
selftests
>>>>>>>>>>>>> from same
>>>>>>>>>>>>> git tree.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Although I don't think any of this config should make a =
difference to
>>>>>>>>>>>>> gup_longterm.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Looks like your errors are all "ftruncate() failed". I've =
seen this
>>>>>>>>>>>>> problem on
>>>>>>>>>>>>> our CI system. There it is due to running the tests from =
NFS file
>>>>>>>>>>>>> system. What
>>>>>>>>>>>>> filesystem are you using? Perhaps you are sharing into the =
FVP using
>>>>>>>>>>>>> 9p? That
>>>>>>>>>>>>> might also be problematic.
>>>>>>>>>>>>=20
>>>>>>>>>>>> That was it. This time I booted up the kernel including =
your series on
>>>>>>>>>>>> QEMU on my M1 and executed the gup_longterm program without =
the ftruncate
>>>>>>>>>>>> failures. When testing your kernel on FVP, I was executing =
the script
>>>>>>>>>>>> from the FVP's host filesystem using 9p.
>>>>>>>>>>>=20
>>>>>>>>>>> I'm not sure exactly what the root cause is. Perhaps there =
isn't enough
>>>>>>>>>>> space on
>>>>>>>>>>> the disk? It might be worth enhancing the error log to =
provide the
>>>>>>>>>>> errno in
>>>>>>>>>>> tools/testing/selftests/mm/gup_longterm.c.
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> Attached is the strace=E2=80=99d gup_longterm executiong log =
on your
>>>>>>>>>> pgtable-boot-speedup-v2 kernel.
>>>>>>>>>=20
>>>>>>>>> Sorry are you saying that it only fails with the =
pgtable-boot-speedup-v2
>>>>>>>>> patch
>>>>>>>>> set applied? I thought we previously concluded that it was =
independent of
>>>>>>>>> that?
>>>>>>>>> I was under the impression that it was filesystem related and =
not something
>>>>>>>>> that
>>>>>>>>> I was planning to investigate.
>>>>>>>>=20
>>>>>>>> No, irrespective of the kernel, if using 9p on FVP the test =
program fails.
>>>>>>>> It is indeed 9p filesystem related, as I switched to using NFS =
all the
>>>>>>>> issues are gone.
>>>>>>>=20
>>>>>>> Did it never work on 9p? If so, we might have to SKIP that test.
>>>>>>>=20
>>>>>>> openat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", =
O_RDWR|O_CREAT|O_EXCL,
>>>>>>> 0600) =3D 3
>>>>>>> unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", 0) =3D 0
>>>>>>> fstatfs(3, 0xffffe505a840)              =3D -1 EOPNOTSUPP =
(Operation not
>>>>>>> supported)
>>>>>>> ftruncate(3, 4096)                      =3D -1 ENOENT (No such =
file or
>>>>>>> directory)
>>>>>>=20
>>>>>> Note: I'm wondering if the unlinkat here is the problem that =
makes
>>>>>> ftruncate() with 9p result in weird errors (e.g., the hypervisor
>>>>>> unlinked the file and cannot reopen it for the fstatfs/ftruncate. =
..
>>>>>> which gives us weird errors here).
>>>>>>=20
>>>>>> Then, we should lookup the fs type in run_with_local_tmpfile() =
before
>>>>>> the unlink() and simply skip the test if it is 9p.
>>>>>=20
>>>>> The unlink with 9p most certainly was a known issue in the past:
>>>>>=20
>>>>> https://gitlab.com/qemu-project/qemu/-/issues/103
>>>>>=20
>>>>> Maybe it's still an issue with older hypervisors (QEMU?)? Or it =
was never
>>>>> completely resolved?
>>>>=20
>>>> I believe Itaru is running on FVP (Fixed Virtual Platform - "fast =
model" -
>>>> Arm's architecture emulator). So QEMU won't be involved here. The =
FVP emulates
>>>> a 9p device, so perhaps the bug is in there.
>>>=20
>>> Very likely.
>>>=20
>>>>=20
>>>> Note that I see lots of "fallocate() failed" failures in =
gup_longterm when
>>>> running on our CI system. This is a completely different setup; =
Real HW with
>>>> Linux running bare metal using an NFS rootfs. I'm not sure if this =
is related.
>>>> Logs show it failing consistently for the "tmpfile" and "local =
tmpfile" test
>>>> configs. I also see a couple of these fails in the cow tests.
>>>=20
>>> What is the fallocate() errno you are getting? strace log would help =
(to see if
>>> statfs also fails already)! Likely a similar NFS issue.
>> Unfortunately this is a system I don't have access to. I've requested =
some of
>> this triage to be done, but its fairly low priority unfortunately.
>=20
> To work around these BUGs (?) elsewhere, we could simply skip the test =
if get_fs_type() is not able to detect the FS type. Likely that's an =
early indicator that the unlink() messed something up.
>=20
> ... doesn't feel right, though.

I think it=E2=80=99s a good idea so that the mm kselftests results look =
reasonable. Since you=E2=80=99re an expert on GUP-fast (or fast-GUP?), =
when you update the code, could you print out errno as well like the =
split_huge_page_test.c does?

Thanks,
Itaru.

>=20
> --=20
> Cheers,
>=20
> David / dhildenb
>=20


