Return-Path: <linux-kernel+bounces-138029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E37189EB44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BAF2831F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657213AA4D;
	Wed, 10 Apr 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4vMAQ46"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D38C15
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731686; cv=none; b=bOOJuTqyeWdCO5P2QwzrjH3gjoHef0V5vHQ7vjBwg7Ijdl3xnWiJLhiRtQOtvpClrMT3df2dtiv+Kq+Ql1w7FcBPCnqp50MHbMtGVAS2s1Pc/lNebro0uR3cE+hwmiiaISOH029W/NZzq3adcknwgkCde0m9LM3OS1ORnp63c4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731686; c=relaxed/simple;
	bh=H9VsqQiJUMcIJuqnud1CfM4OpW7hYw3VjItdw/0hpko=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=naW6jVZJ+2os6QpQdSct1LwDHacAVbua2Uh57nkoZis+sJBTxnEKwU6KzwSF1AtIvRkrVaWJxHQ0/b5lTmbNxpn/Y12lJjcYNZSYWRR1VnCy4oQV5dPKYdK96C+SjM2weiDqiOHdUBvxybUmeQyaXcZ0iH/xcgcMEy3BLhAJxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h4vMAQ46; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712731680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hp5sBpTYcTiJq4xF+xTFKFGcJjMxsZUTfx+8IAZNC8=;
	b=h4vMAQ46AvOk8+XxekHiUKys4Flwsti+2yBzNril3OIVO/6/xQ/AhDUJtrLeh5GFSbpFTM
	fs0KbDPx14QM24kPUOTybRuUIFNCk2rKnM3ui/H8vIzF6TpAmFyVtrbYMuByvBvdiff2oc
	qI+ZhL9lW74yV+eL7kE2aQk2EaoBvNI=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Message-Id: <1E3DBD5D-0EF2-472B-8164-DBC1368C22B4@linux.dev>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_712787CF-6031-4DEA-8454-11032C4584CA"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 0/4] Speed up boot with faster linear map creation
Date: Wed, 10 Apr 2024 15:47:33 +0900
In-Reply-To: <8AA82C6E-F7E7-40A3-952D-392735E1405A@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Donald Dutile <ddutile@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
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
 <8AA82C6E-F7E7-40A3-952D-392735E1405A@linux.dev>
X-Migadu-Flow: FLOW_OUT


--Apple-Mail=_712787CF-6031-4DEA-8454-11032C4584CA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Apr 10, 2024, at 8:30, Itaru Kitayama <itaru.kitayama@linux.dev> =
wrote:
>=20
> Hi David,
>=20
>> On Apr 9, 2024, at 23:45, David Hildenbrand <david@redhat.com> wrote:
>>=20
>> On 09.04.24 16:39, Ryan Roberts wrote:
>>> On 09/04/2024 15:29, David Hildenbrand wrote:
>>>> On 09.04.24 16:13, Ryan Roberts wrote:
>>>>> On 09/04/2024 12:51, David Hildenbrand wrote:
>>>>>> On 09.04.24 13:29, David Hildenbrand wrote:
>>>>>>> On 09.04.24 13:22, David Hildenbrand wrote:
>>>>>>>> On 09.04.24 12:13, Itaru Kitayama wrote:
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>> On Apr 9, 2024, at 19:04, Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>>>>>>>>>>=20
>>>>>>>>>> On 09/04/2024 01:10, Itaru Kitayama wrote:
>>>>>>>>>>> Hi Ryan,
>>>>>>>>>>>=20
>>>>>>>>>>>> On Apr 8, 2024, at 16:30, Ryan Roberts =
<ryan.roberts@arm.com> wrote:
>>>>>>>>>>>>=20
>>>>>>>>>>>> On 06/04/2024 11:31, Itaru Kitayama wrote:
>>>>>>>>>>>>> Hi Ryan,
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> On Sat, Apr 06, 2024 at 09:32:34AM +0100, Ryan Roberts =
wrote:
>>>>>>>>>>>>>> Hi Itaru,
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> On 05/04/2024 08:39, Itaru Kitayama wrote:
>>>>>>>>>>>>>>> On Thu, Apr 04, 2024 at 03:33:04PM +0100, Ryan Roberts =
wrote:
>>>>>>>>>>>>>>>> Hi All,
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> It turns out that creating the linear map can take a =
significant
>>>>>>>>>>>>>>>> proportion of
>>>>>>>>>>>>>>>> the total boot time, especially when rodata=3Dfull. And =
most of the
>>>>>>>>>>>>>>>> time is spent
>>>>>>>>>>>>>>>> waiting on superfluous tlb invalidation and memory =
barriers. This
>>>>>>>>>>>>>>>> series reworks
>>>>>>>>>>>>>>>> the kernel pgtable generation code to significantly =
reduce the number
>>>>>>>>>>>>>>>> of those
>>>>>>>>>>>>>>>> TLBIs, ISBs and DSBs. See each patch for details.
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> The below shows the execution time of map_mem() across =
a couple of
>>>>>>>>>>>>>>>> different
>>>>>>>>>>>>>>>> systems with different RAM configurations. We measure =
after applying
>>>>>>>>>>>>>>>> each patch
>>>>>>>>>>>>>>>> and show the improvement relative to base (v6.9-rc2):
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>                   | Apple M2 VM | Ampere Altra| Ampere =
Altra| Ampere
>>>>>>>>>>>>>>>> Altra
>>>>>>>>>>>>>>>>                   | VM, 16G     | VM, 64G     | VM, =
256G    | Metal,
>>>>>>>>>>>>>>>> 512G
>>>>>>>>>>>>>>>> =
---------------|-------------|-------------|-------------|-------------
>>>>>>>>>>>>>>>>                   |   ms    (%) |   ms    (%) |   ms    =
(%) |
>>>>>>>>>>>>>>>> ms    (%)
>>>>>>>>>>>>>>>> =
---------------|-------------|-------------|-------------|-------------
>>>>>>>>>>>>>>>> base           |  153   (0%) | 2227   (0%) | 8798   =
(0%) | 17442
>>>>>>>>>>>>>>>> (0%)
>>>>>>>>>>>>>>>> no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 =
(-80%) |  3796
>>>>>>>>>>>>>>>> (-78%)
>>>>>>>>>>>>>>>> batch-barriers |   13 (-92%) |  162 (-93%) |  655 =
(-93%) |  1656
>>>>>>>>>>>>>>>> (-91%)
>>>>>>>>>>>>>>>> no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 =
(-95%) |  1257
>>>>>>>>>>>>>>>> (-93%)
>>>>>>>>>>>>>>>> lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 =
(-97%) |   838
>>>>>>>>>>>>>>>> (-95%)
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> This series applies on top of v6.9-rc2. All mm =
selftests pass. I've
>>>>>>>>>>>>>>>> compile and
>>>>>>>>>>>>>>>> boot tested various PAGE_SIZE and VA size configs.
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> Changes since v1 [1]
>>>>>>>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>      - Added Tested-by tags (thanks to Eric and Itaru)
>>>>>>>>>>>>>>>>      - Renamed ___set_pte() -> __set_pte_nosync() (per =
Ard)
>>>>>>>>>>>>>>>>      - Reordered patches (biggest impact & least =
controversial first)
>>>>>>>>>>>>>>>>      - Reordered alloc/map/unmap functions in mmu.c to =
aid reader
>>>>>>>>>>>>>>>>      - pte_clear() -> __pte_clear() in =
clear_fixmap_nosync()
>>>>>>>>>>>>>>>>      - Reverted generic p4d_index() which caused x86 =
build error.
>>>>>>>>>>>>>>>> Replaced with
>>>>>>>>>>>>>>>>        unconditional p4d_index() define under arm64.
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> [1]
>>>>>>>>>>>>>>>> =
https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.rob=
erts@arm.com/<https://lore.kernel.org/linux-arm-kernel/20240326101448.3453=
626-1-ryan.roberts@arm.com/>
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>> Ryan
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> Ryan Roberts (4):
>>>>>>>>>>>>>>>>      arm64: mm: Don't remap pgtables per-cont(pte|pmd) =
block
>>>>>>>>>>>>>>>>      arm64: mm: Batch dsb and isb when populating =
pgtables
>>>>>>>>>>>>>>>>      arm64: mm: Don't remap pgtables for allocate vs =
populate
>>>>>>>>>>>>>>>>      arm64: mm: Lazily clear pte table mappings from =
fixmap
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> arch/arm64/include/asm/fixmap.h  |   5 +-
>>>>>>>>>>>>>>>> arch/arm64/include/asm/mmu.h     |   8 +
>>>>>>>>>>>>>>>> arch/arm64/include/asm/pgtable.h |  13 +-
>>>>>>>>>>>>>>>> arch/arm64/kernel/cpufeature.c   |  10 +-
>>>>>>>>>>>>>>>> arch/arm64/mm/fixmap.c           |  11 +
>>>>>>>>>>>>>>>> arch/arm64/mm/mmu.c              | 377 =
+++++++++++++++++++++++--------
>>>>>>>>>>>>>>>> 6 files changed, 319 insertions(+), 105 deletions(-)
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> --=20
>>>>>>>>>>>>>>>> 2.25.1
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> I've build and boot tested the v2 on FVP, base is taken =
from your
>>>>>>>>>>>>>>> linux-rr repo. Running run_vmtests.sh on v2 left some =
gup longterm not
>>>>>>>>>>>>>>> oks, would you take a look at it? The mm ksefltests used =
is from your
>>>>>>>>>>>>>>> linux-rr repo too.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Thanks for taking a look at this.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> I can't reproduce your issue unfortunately; steps as =
follows on Apple
>>>>>>>>>>>>>> M2 VM:
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Config: arm64 defconfig + the following:
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> # Squashfs for snaps, xfs for large file folios.
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZO
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_XZ
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_XFS_FS
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> # For general mm debug.
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_RB
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> # For mm selftests.
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_USERFAULTFD
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_TEST_VMALLOC
>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_GUP_TEST
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Running on VM with 12G memory, split across 2 (emulated) =
NUMA nodes
>>>>>>>>>>>>>> (needed by
>>>>>>>>>>>>>> some mm selftests), with kernel command line to reserve =
hugetlbs and
>>>>>>>>>>>>>> other
>>>>>>>>>>>>>> features required by some mm selftests:
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> "
>>>>>>>>>>>>>> transparent_hugepage=3Dmadvise earlycon root=3D/dev/vda2 =
secretmem.enable
>>>>>>>>>>>>>> hugepagesz=3D1G hugepages=3D0:2,1:2 hugepagesz=3D32M =
hugepages=3D0:2,1:2
>>>>>>>>>>>>>> default_hugepagesz=3D2M hugepages=3D0:64,1:64 =
hugepagesz=3D64K
>>>>>>>>>>>>>> hugepages=3D0:2,1:2
>>>>>>>>>>>>>> "
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Ubuntu userspace running off XFS rootfs. Build and run mm =
selftests
>>>>>>>>>>>>>> from same
>>>>>>>>>>>>>> git tree.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Although I don't think any of this config should make a =
difference to
>>>>>>>>>>>>>> gup_longterm.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Looks like your errors are all "ftruncate() failed". I've =
seen this
>>>>>>>>>>>>>> problem on
>>>>>>>>>>>>>> our CI system. There it is due to running the tests from =
NFS file
>>>>>>>>>>>>>> system. What
>>>>>>>>>>>>>> filesystem are you using? Perhaps you are sharing into =
the FVP using
>>>>>>>>>>>>>> 9p? That
>>>>>>>>>>>>>> might also be problematic.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> That was it. This time I booted up the kernel including =
your series on
>>>>>>>>>>>>> QEMU on my M1 and executed the gup_longterm program =
without the ftruncate
>>>>>>>>>>>>> failures. When testing your kernel on FVP, I was executing =
the script
>>>>>>>>>>>>> from the FVP's host filesystem using 9p.
>>>>>>>>>>>>=20
>>>>>>>>>>>> I'm not sure exactly what the root cause is. Perhaps there =
isn't enough
>>>>>>>>>>>> space on
>>>>>>>>>>>> the disk? It might be worth enhancing the error log to =
provide the
>>>>>>>>>>>> errno in
>>>>>>>>>>>> tools/testing/selftests/mm/gup_longterm.c.
>>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> Attached is the strace=E2=80=99d gup_longterm executiong log =
on your
>>>>>>>>>>> pgtable-boot-speedup-v2 kernel.
>>>>>>>>>>=20
>>>>>>>>>> Sorry are you saying that it only fails with the =
pgtable-boot-speedup-v2
>>>>>>>>>> patch
>>>>>>>>>> set applied? I thought we previously concluded that it was =
independent of
>>>>>>>>>> that?
>>>>>>>>>> I was under the impression that it was filesystem related and =
not something
>>>>>>>>>> that
>>>>>>>>>> I was planning to investigate.
>>>>>>>>>=20
>>>>>>>>> No, irrespective of the kernel, if using 9p on FVP the test =
program fails.
>>>>>>>>> It is indeed 9p filesystem related, as I switched to using NFS =
all the
>>>>>>>>> issues are gone.
>>>>>>>>=20
>>>>>>>> Did it never work on 9p? If so, we might have to SKIP that =
test.
>>>>>>>>=20
>>>>>>>> openat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", =
O_RDWR|O_CREAT|O_EXCL,
>>>>>>>> 0600) =3D 3
>>>>>>>> unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", 0) =3D 0
>>>>>>>> fstatfs(3, 0xffffe505a840)              =3D -1 EOPNOTSUPP =
(Operation not
>>>>>>>> supported)
>>>>>>>> ftruncate(3, 4096)                      =3D -1 ENOENT (No such =
file or
>>>>>>>> directory)
>>>>>>>=20
>>>>>>> Note: I'm wondering if the unlinkat here is the problem that =
makes
>>>>>>> ftruncate() with 9p result in weird errors (e.g., the hypervisor
>>>>>>> unlinked the file and cannot reopen it for the =
fstatfs/ftruncate. ...
>>>>>>> which gives us weird errors here).
>>>>>>>=20
>>>>>>> Then, we should lookup the fs type in run_with_local_tmpfile() =
before
>>>>>>> the unlink() and simply skip the test if it is 9p.
>>>>>>=20
>>>>>> The unlink with 9p most certainly was a known issue in the past:
>>>>>>=20
>>>>>> https://gitlab.com/qemu-project/qemu/-/issues/103
>>>>>>=20
>>>>>> Maybe it's still an issue with older hypervisors (QEMU?)? Or it =
was never
>>>>>> completely resolved?
>>>>>=20
>>>>> I believe Itaru is running on FVP (Fixed Virtual Platform - "fast =
model" -
>>>>> Arm's architecture emulator). So QEMU won't be involved here. The =
FVP emulates
>>>>> a 9p device, so perhaps the bug is in there.
>>>>=20
>>>> Very likely.
>>>>=20
>>>>>=20
>>>>> Note that I see lots of "fallocate() failed" failures in =
gup_longterm when
>>>>> running on our CI system. This is a completely different setup; =
Real HW with
>>>>> Linux running bare metal using an NFS rootfs. I'm not sure if this =
is related.
>>>>> Logs show it failing consistently for the "tmpfile" and "local =
tmpfile" test
>>>>> configs. I also see a couple of these fails in the cow tests.
>>>>=20
>>>> What is the fallocate() errno you are getting? strace log would =
help (to see if
>>>> statfs also fails already)! Likely a similar NFS issue.
>>> Unfortunately this is a system I don't have access to. I've =
requested some of
>>> this triage to be done, but its fairly low priority unfortunately.
>>=20
>> To work around these BUGs (?) elsewhere, we could simply skip the =
test if get_fs_type() is not able to detect the FS type. Likely that's =
an early indicator that the unlink() messed something up.
>>=20
>> ... doesn't feel right, though.
>=20
> I think it=E2=80=99s a good idea so that the mm kselftests results =
look reasonable. Since you=E2=80=99re an expert on GUP-fast (or =
fast-GUP?), when you update the code, could you print out errno as well =
like the split_huge_page_test.c does?
>=20
> Thanks,
> Itaru.

David, attached is the straced execution log of the gup_longterm =
kselftest over the NFS case.
I=E2=80=99m running the program on FVP, let me know if you need other =
logs or test results. =20

Thanks,
Itaru.


--Apple-Mail=_712787CF-6031-4DEA-8454-11032C4584CA
Content-Disposition: attachment;
	filename=straced-gup_longterm-nfs.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="straced-gup_longterm-nfs.log"
Content-Transfer-Encoding: 7bit

execve("./gup_longterm", ["./gup_longterm"], 0xfffff6515bf0 /* 12 vars */) = 0
brk(NULL)                               = 0xaaaad667d000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffffbb911000
faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\260\265\2\0\0\0\0\0"..., 832) = 832
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=1605640, ...}, AT_EMPTY_PATH) = 0
mmap(NULL, 1650608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xffffbb77e000
mmap(0xffffbb900000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x182000) = 0xffffbb900000
mmap(0xffffbb905000, 49072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffffbb905000
close(3)                                = 0
set_tid_address(0xffffbb911ef0)         = 24635
set_robust_list(0xffffbb911f00, 24)     = 0
rseq(0xffffbb912540, 0x20, 0, 0xd428bc00) = 0
mprotect(0xffffbb900000, 12288, PROT_READ) = 0
mprotect(0xaaaacb0ef000, 4096, PROT_READ) = 0
mprotect(0xffffbb93c000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
openat(AT_FDCWD, "/sys/kernel/mm/hugepages/", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
newfstatat(3, "", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_EMPTY_PATH) = 0
getrandom("\x07\x03\x22\xbd\xf2\x68\x38\x0d", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0xaaaad667d000
brk(0xaaaad669e000)                     = 0xaaaad669e000
getdents64(3, 0xaaaad667d2d0 /* 6 entries */, 32768) = 208
newfstatat(1, "", {st_mode=S_IFIFO|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
getdents64(3, 0xaaaad667d2d0 /* 0 entries */, 32768) = 0
close(3)                                = 0
openat(AT_FDCWD, "/sys/kernel/debug/gup_test", O_RDWR) = -1 ENOENT (No such file or directory)
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x4c9de942, 0x9353d673]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_WMLTNf", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_WMLTNf", 0) = 0
fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = 0
mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb400000
munmap(0xffffbb400000, 2097152)         = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|25<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=33554432, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x12, 0]}, f_namelen=255, f_frsize=33554432, f_flags=ST_VALID}) = 0
ftruncate(3, 33554432)                  = 0
fallocate(3, 0, 0, 33554432)            = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|16<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=65536, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x13, 0]}, f_namelen=255, f_frsize=65536, f_flags=ST_VALID}) = 0
ftruncate(3, 65536)                     = 0
fallocate(3, 0, 0, 65536)               = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|30<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=1073741824, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x11, 0]}, f_namelen=255, f_frsize=1073741824, f_flags=ST_VALID}) = 0
ftruncate(3, 1073741824)                = 0
fallocate(3, 0, 0, 1073741824)          = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x4c9de942, 0x9353d673]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_inQHdT", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_inQHdT", 0) = 0
fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = 0
mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb400000
munmap(0xffffbb400000, 2097152)         = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|25<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=33554432, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x12, 0]}, f_namelen=255, f_frsize=33554432, f_flags=ST_VALID}) = 0
ftruncate(3, 33554432)                  = 0
fallocate(3, 0, 0, 33554432)            = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|16<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=65536, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x13, 0]}, f_namelen=255, f_frsize=65536, f_flags=ST_VALID}) = 0
ftruncate(3, 65536)                     = 0
fallocate(3, 0, 0, 65536)               = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|30<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=1073741824, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x11, 0]}, f_namelen=255, f_frsize=1073741824, f_flags=ST_VALID}) = 0
ftruncate(3, 1073741824)                = 0
fallocate(3, 0, 0, 1073741824)          = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x4c9de942, 0x9353d673]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_IJd9EX", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_IJd9EX", 0) = 0
fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = 0
mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb400000
munmap(0xffffbb400000, 2097152)         = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|25<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=33554432, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x12, 0]}, f_namelen=255, f_frsize=33554432, f_flags=ST_VALID}) = 0
ftruncate(3, 33554432)                  = 0
fallocate(3, 0, 0, 33554432)            = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|16<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=65536, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x13, 0]}, f_namelen=255, f_frsize=65536, f_flags=ST_VALID}) = 0
ftruncate(3, 65536)                     = 0
fallocate(3, 0, 0, 65536)               = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|30<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=1073741824, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x11, 0]}, f_namelen=255, f_frsize=1073741824, f_flags=ST_VALID}) = 0
ftruncate(3, 1073741824)                = 0
fallocate(3, 0, 0, 1073741824)          = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x4c9de942, 0x9353d673]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_qh3L7P", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_qh3L7P", 0) = 0
fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = 0
mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffffbb400000
munmap(0xffffbb400000, 2097152)         = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|25<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=33554432, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x12, 0]}, f_namelen=255, f_frsize=33554432, f_flags=ST_VALID}) = 0
ftruncate(3, 33554432)                  = 0
fallocate(3, 0, 0, 33554432)            = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|16<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=65536, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x13, 0]}, f_namelen=255, f_frsize=65536, f_flags=ST_VALID}) = 0
ftruncate(3, 65536)                     = 0
fallocate(3, 0, 0, 65536)               = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|30<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=1073741824, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x11, 0]}, f_namelen=255, f_frsize=1073741824, f_flags=ST_VALID}) = 0
ftruncate(3, 1073741824)                = 0
fallocate(3, 0, 0, 1073741824)          = -1 ENOSPC (No space left on device)
close(3)                                = 0
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x4c9de942, 0x9353d673]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_2Alu3T", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_2Alu3T", 0) = 0
fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = 0
mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb400000
munmap(0xffffbb400000, 2097152)         = 0
close(3)                                = 0
write(1, "# [INFO] detected hugetlb page s"..., 4096# [INFO] detected hugetlb page size: 2048 KiB
# [INFO] detected hugetlb page size: 32768 KiB
# [INFO] detected hugetlb page size: 64 KiB
# [INFO] detected hugetlb page size: 1048576 KiB
TAP version 13
1..56
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd
ok 1 # SKIP gup_test not available
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
ok 2 # SKIP gup_test not available
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
ok 3 # SKIP gup_test not available
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 4 # SKIP gup_test not available
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
ok 5 # SKIP need more free huge pages
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (64 kB)
ok 6 # SKIP need more free huge pages
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 7 # SKIP need more free huge pages
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd
ok 8 # SKIP gup_test not available
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with tmpfile
ok 9 # SKIP gup_test not available
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with local tmpfile
ok 10 # SKIP gup_test not available
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 11 # SKIP gup_test not available
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
ok 12 # SKIP need more free huge pages
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (64 kB)
ok 13 # SKIP need more free huge pages
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 14 # SKIP need more free huge pages
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd
ok 15 # SKIP gup_test not available
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
ok 16 # SKIP gup_test not available
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
ok 17 # SKIP gup_test not available
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 18 # SKIP gup_test not available
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
ok 19 # SKIP need more free huge pages
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (64 kB)
ok 20 # SKIP need more free huge pages
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 21 # SKIP need more free huge pages
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd
ok 22 # SKIP gup_test not available
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with tmpfile
ok 23 # SKIP gup_test not available
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with local tmpfile
ok 24 # SKIP gup_test not available
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 25 # SKIP gup_test not available
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
ok 26 # SKIP need more free huge pages
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (64 kB)
ok 27 # SKIP need more free huge pages
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 28 # SKIP need more free huge pages
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
ok 29 # SKIP gup_test not available
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
ok 30 # SKIP gup_test not available
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
ok 31 # SKIP gup_test not available
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
ok 32 # SKIP gup_test not available
) = 4096
write(1, "# [RUN] R/W longterm GUP pin in "..., 91# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
) = 91
memfd_create("test", MFD_HUGETLB|25<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=33554432, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x12, 0]}, f_namelen=255, f_frsize=33554432, f_flags=ST_VALID}) = 0
ftruncate(3, 33554432)                  = 0
fallocate(3, 0, 0, 33554432)            = -1 ENOSPC (No space left on device)
write(1, "ok 33 # SKIP need more free huge"..., 39ok 33 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP pin in "..., 88# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (64 kB)
) = 88
memfd_create("test", MFD_HUGETLB|16<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=65536, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x13, 0]}, f_namelen=255, f_frsize=65536, f_flags=ST_VALID}) = 0
ftruncate(3, 65536)                     = 0
fallocate(3, 0, 0, 65536)               = -1 ENOSPC (No space left on device)
write(1, "ok 34 # SKIP need more free huge"..., 39ok 34 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP pin in "..., 93# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
) = 93
memfd_create("test", MFD_HUGETLB|30<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=1073741824, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x11, 0]}, f_namelen=255, f_frsize=1073741824, f_flags=ST_VALID}) = 0
ftruncate(3, 1073741824)                = 0
fallocate(3, 0, 0, 1073741824)          = -1 ENOSPC (No space left on device)
write(1, "ok 35 # SKIP need more free huge"..., 39ok 35 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 77# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd
) = 77
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x4c9de942, 0x9353d673]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 36 # SKIP gup_test not availa"..., 36ok 36 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 79# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
) = 79
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 37 # SKIP gup_test not availa"..., 36ok 37 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 85# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
) = 85
openat(AT_FDCWD, "gup_longterm.c_tmpfile_SKHXe1", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_SKHXe1", 0) = 0
fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 38 # SKIP gup_test not availa"..., 36ok 38 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 95# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
) = 95
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = 0
mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb400000
write(1, "ok 39 # SKIP gup_test not availa"..., 36ok 39 # SKIP gup_test not available
) = 36
munmap(0xffffbb400000, 2097152)         = 0
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 96# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
) = 96
memfd_create("test", MFD_HUGETLB|25<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=33554432, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x12, 0]}, f_namelen=255, f_frsize=33554432, f_flags=ST_VALID}) = 0
ftruncate(3, 33554432)                  = 0
fallocate(3, 0, 0, 33554432)            = -1 ENOSPC (No space left on device)
write(1, "ok 40 # SKIP need more free huge"..., 39ok 40 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 93# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (64 kB)
) = 93
memfd_create("test", MFD_HUGETLB|16<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=65536, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x13, 0]}, f_namelen=255, f_frsize=65536, f_flags=ST_VALID}) = 0
ftruncate(3, 65536)                     = 0
fallocate(3, 0, 0, 65536)               = -1 ENOSPC (No space left on device)
write(1, "ok 41 # SKIP need more free huge"..., 39ok 41 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 98# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
) = 98
memfd_create("test", MFD_HUGETLB|30<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=1073741824, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x11, 0]}, f_namelen=255, f_frsize=1073741824, f_flags=ST_VALID}) = 0
ftruncate(3, 1073741824)                = 0
fallocate(3, 0, 0, 1073741824)          = -1 ENOSPC (No space left on device)
write(1, "ok 42 # SKIP need more free huge"..., 39ok 42 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 72# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
) = 72
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x4c9de942, 0x9353d673]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 43 # SKIP gup_test not availa"..., 36ok 43 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 74# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
) = 74
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 44 # SKIP gup_test not availa"..., 36ok 44 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 80# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
) = 80
openat(AT_FDCWD, "gup_longterm.c_tmpfile_YUsLWy", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_YUsLWy", 0) = 0
fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 45 # SKIP gup_test not availa"..., 36ok 45 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 90# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
) = 90
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = 0
mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb400000
write(1, "ok 46 # SKIP gup_test not availa"..., 36ok 46 # SKIP gup_test not available
) = 36
munmap(0xffffbb400000, 2097152)         = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 91# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
) = 91
memfd_create("test", MFD_HUGETLB|25<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=33554432, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x12, 0]}, f_namelen=255, f_frsize=33554432, f_flags=ST_VALID}) = 0
ftruncate(3, 33554432)                  = 0
fallocate(3, 0, 0, 33554432)            = -1 ENOSPC (No space left on device)
write(1, "ok 47 # SKIP need more free huge"..., 39ok 47 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 88# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (64 kB)
) = 88
memfd_create("test", MFD_HUGETLB|16<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=65536, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x13, 0]}, f_namelen=255, f_frsize=65536, f_flags=ST_VALID}) = 0
ftruncate(3, 65536)                     = 0
fallocate(3, 0, 0, 65536)               = -1 ENOSPC (No space left on device)
write(1, "ok 48 # SKIP need more free huge"..., 39ok 48 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 93# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
) = 93
memfd_create("test", MFD_HUGETLB|30<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=1073741824, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x11, 0]}, f_namelen=255, f_frsize=1073741824, f_flags=ST_VALID}) = 0
ftruncate(3, 1073741824)                = 0
fallocate(3, 0, 0, 1073741824)          = -1 ENOSPC (No space left on device)
write(1, "ok 49 # SKIP need more free huge"..., 39ok 49 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 77# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd
) = 77
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x4c9de942, 0x9353d673]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 50 # SKIP gup_test not availa"..., 36ok 50 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 79# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
) = 79
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 51 # SKIP gup_test not availa"..., 36ok 51 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 85# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
) = 85
openat(AT_FDCWD, "gup_longterm.c_tmpfile_sYGgQd", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_sYGgQd", 0) = 0
fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb77d000
write(1, "ok 52 # SKIP gup_test not availa"..., 36ok 52 # SKIP gup_test not available
) = 36
munmap(0xffffbb77d000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 95# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
) = 95
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = 0
mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffffbb400000
write(1, "ok 53 # SKIP gup_test not availa"..., 36ok 53 # SKIP gup_test not available
) = 36
munmap(0xffffbb400000, 2097152)         = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 96# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
) = 96
memfd_create("test", MFD_HUGETLB|25<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=33554432, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x12, 0]}, f_namelen=255, f_frsize=33554432, f_flags=ST_VALID}) = 0
ftruncate(3, 33554432)                  = 0
fallocate(3, 0, 0, 33554432)            = -1 ENOSPC (No space left on device)
write(1, "ok 54 # SKIP need more free huge"..., 39ok 54 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 93# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (64 kB)
) = 93
memfd_create("test", MFD_HUGETLB|16<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=65536, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x13, 0]}, f_namelen=255, f_frsize=65536, f_flags=ST_VALID}) = 0
ftruncate(3, 65536)                     = 0
fallocate(3, 0, 0, 65536)               = -1 ENOSPC (No space left on device)
write(1, "ok 55 # SKIP need more free huge"..., 39ok 55 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 98# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
) = 98
memfd_create("test", MFD_HUGETLB|30<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=1073741824, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x11, 0]}, f_namelen=255, f_frsize=1073741824, f_flags=ST_VALID}) = 0
ftruncate(3, 1073741824)                = 0
fallocate(3, 0, 0, 1073741824)          = -1 ENOSPC (No space left on device)
write(1, "ok 56 # SKIP need more free huge"..., 39ok 56 # SKIP need more free huge pages
) = 39
close(3)                                = 0
write(1, "# Totals: pass:0 fail:0 xfail:0 "..., 56# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:56 error:0
) = 56
exit_group(0)                           = ?
+++ exited with 0 +++

--Apple-Mail=_712787CF-6031-4DEA-8454-11032C4584CA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


  
> 
>> 
>> -- 
>> Cheers,
>> 
>> David / dhildenb



--Apple-Mail=_712787CF-6031-4DEA-8454-11032C4584CA--

