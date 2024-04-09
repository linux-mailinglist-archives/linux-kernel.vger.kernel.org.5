Return-Path: <linux-kernel+bounces-136037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87189CF38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B462C2823AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114FA10FA;
	Tue,  9 Apr 2024 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uurG1br8"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450738D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621467; cv=none; b=AIGWBT2aL/6OS4oQE1L1sY1evEihPF7XE6xT7wc37pQ5gtqQUsDzm0FG5yzU4/YC9mvZia9AprGnI+N35UsZ4LYlzXoCnDyiamWsWoMQiTJRUjJAquUvhlwlcA7G+R9AuYtTHwSC6q4zKyQgYkQdOcMzhy7Z1hb/p9SE6+UpNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621467; c=relaxed/simple;
	bh=PGxdP6sosyDpyyMVfCr9MQtsPxsE4YeVug8Utl0ywZE=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=gnDLhI6PbJlPWGn06XUGUjxi4t67o1pbtTn282q5+Q+1zbLENqvMFfteAvUFSKCCo3uKX4TtGH0nbkTzrs8mKn94F0bIW/xDnepoNkbmYocGVN1T+tH/m0rDXCNr8xUJX+Sm5VDjrqt0AlDkUxxPl2Busb2qh9ZA8Jfc31mN014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uurG1br8; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712621463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I11W5v1kCk/Un+Quo7Bx83cfQrZjzwg+cd/PDh7B/MM=;
	b=uurG1br8TkTb/VxcSuHFvJi52nn07588urHzoB7jZLiomN5QMKvm5eDdwnFTfPrAZd3O8b
	96K+fh98P7jEqfSDZFTlZEYKquvXrOfkNRAbxmBlrUm5PzNMoW5PUrAXQ9lN7lH7hl6m6V
	Cbf2L1PUAmmvEfdU1E2jF7KqGPgyPzE=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Message-Id: <FCDCBCEE-7D97-4769-AB95-7294A9CE18E0@linux.dev>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_6301FD46-615B-4C7C-A21F-4DBA8139077F"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 0/4] Speed up boot with faster linear map creation
Date: Tue, 9 Apr 2024 09:10:42 +0900
In-Reply-To: <533adb77-8c2b-40db-84cb-88de77ab92bb@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Donald Dutile <ddutile@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-kernel@vger.kernel.org
To: Ryan Roberts <ryan.roberts@arm.com>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <Zg+qwooaWFNL7KIg@vm3> <fd4aed3a-42be-44e0-b3bb-12f77c5911a1@arm.com>
 <ZhEkif45F0aVvKPx@vm3> <533adb77-8c2b-40db-84cb-88de77ab92bb@arm.com>
X-Migadu-Flow: FLOW_OUT


--Apple-Mail=_6301FD46-615B-4C7C-A21F-4DBA8139077F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Ryan,

> On Apr 8, 2024, at 16:30, Ryan Roberts <ryan.roberts@arm.com> wrote:
>=20
> On 06/04/2024 11:31, Itaru Kitayama wrote:
>> Hi Ryan,
>>=20
>> On Sat, Apr 06, 2024 at 09:32:34AM +0100, Ryan Roberts wrote:
>>> Hi Itaru,
>>>=20
>>> On 05/04/2024 08:39, Itaru Kitayama wrote:
>>>> On Thu, Apr 04, 2024 at 03:33:04PM +0100, Ryan Roberts wrote:
>>>>> Hi All,
>>>>>=20
>>>>> It turns out that creating the linear map can take a significant =
proportion of
>>>>> the total boot time, especially when rodata=3Dfull. And most of =
the time is spent
>>>>> waiting on superfluous tlb invalidation and memory barriers. This =
series reworks
>>>>> the kernel pgtable generation code to significantly reduce the =
number of those
>>>>> TLBIs, ISBs and DSBs. See each patch for details.
>>>>>=20
>>>>> The below shows the execution time of map_mem() across a couple of =
different
>>>>> systems with different RAM configurations. We measure after =
applying each patch
>>>>> and show the improvement relative to base (v6.9-rc2):
>>>>>=20
>>>>>               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere =
Altra
>>>>>               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, =
512G
>>>>> =
---------------|-------------|-------------|-------------|-------------
>>>>>               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    =
(%)
>>>>> =
---------------|-------------|-------------|-------------|-------------
>>>>> base           |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442   =
(0%)
>>>>> no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796 =
(-78%)
>>>>> batch-barriers |   13 (-92%) |  162 (-93%) |  655 (-93%) |  1656 =
(-91%)
>>>>> no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 (-95%) |  1257 =
(-93%)
>>>>> lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 (-97%) |   838 =
(-95%)
>>>>>=20
>>>>> This series applies on top of v6.9-rc2. All mm selftests pass. =
I've compile and
>>>>> boot tested various PAGE_SIZE and VA size configs.
>>>>>=20
>>>>> ---
>>>>>=20
>>>>> Changes since v1 [1]
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>=20
>>>>>  - Added Tested-by tags (thanks to Eric and Itaru)
>>>>>  - Renamed ___set_pte() -> __set_pte_nosync() (per Ard)
>>>>>  - Reordered patches (biggest impact & least controversial first)
>>>>>  - Reordered alloc/map/unmap functions in mmu.c to aid reader
>>>>>  - pte_clear() -> __pte_clear() in clear_fixmap_nosync()
>>>>>  - Reverted generic p4d_index() which caused x86 build error. =
Replaced with
>>>>>    unconditional p4d_index() define under arm64.
>>>>>=20
>>>>>=20
>>>>> [1] =
https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.rob=
erts@arm.com/
>>>>>=20
>>>>> Thanks,
>>>>> Ryan
>>>>>=20
>>>>>=20
>>>>> Ryan Roberts (4):
>>>>>  arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>>>>>  arm64: mm: Batch dsb and isb when populating pgtables
>>>>>  arm64: mm: Don't remap pgtables for allocate vs populate
>>>>>  arm64: mm: Lazily clear pte table mappings from fixmap
>>>>>=20
>>>>> arch/arm64/include/asm/fixmap.h  |   5 +-
>>>>> arch/arm64/include/asm/mmu.h     |   8 +
>>>>> arch/arm64/include/asm/pgtable.h |  13 +-
>>>>> arch/arm64/kernel/cpufeature.c   |  10 +-
>>>>> arch/arm64/mm/fixmap.c           |  11 +
>>>>> arch/arm64/mm/mmu.c              | 377 =
+++++++++++++++++++++++--------
>>>>> 6 files changed, 319 insertions(+), 105 deletions(-)
>>>>>=20
>>>>> --
>>>>> 2.25.1
>>>>>=20
>>>>=20
>>>> I've build and boot tested the v2 on FVP, base is taken from your
>>>> linux-rr repo. Running run_vmtests.sh on v2 left some gup longterm =
not oks, would you take a look at it? The mm ksefltests used is from =
your linux-rr repo too.
>>>=20
>>> Thanks for taking a look at this.
>>>=20
>>> I can't reproduce your issue unfortunately; steps as follows on =
Apple M2 VM:
>>>=20
>>> Config: arm64 defconfig + the following:
>>>=20
>>> # Squashfs for snaps, xfs for large file folios.
>>> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
>>> ./scripts/config --enable CONFIG_SQUASHFS_LZO
>>> ./scripts/config --enable CONFIG_SQUASHFS_XZ
>>> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
>>> ./scripts/config --enable CONFIG_XFS_FS
>>>=20
>>> # For general mm debug.
>>> ./scripts/config --enable CONFIG_DEBUG_VM
>>> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
>>> ./scripts/config --enable CONFIG_DEBUG_VM_RB
>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
>>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
>>>=20
>>> # For mm selftests.
>>> ./scripts/config --enable CONFIG_USERFAULTFD
>>> ./scripts/config --enable CONFIG_TEST_VMALLOC
>>> ./scripts/config --enable CONFIG_GUP_TEST
>>>=20
>>> Running on VM with 12G memory, split across 2 (emulated) NUMA nodes =
(needed by
>>> some mm selftests), with kernel command line to reserve hugetlbs and =
other
>>> features required by some mm selftests:
>>>=20
>>> "
>>> transparent_hugepage=3Dmadvise earlycon root=3D/dev/vda2 =
secretmem.enable
>>> hugepagesz=3D1G hugepages=3D0:2,1:2 hugepagesz=3D32M =
hugepages=3D0:2,1:2
>>> default_hugepagesz=3D2M hugepages=3D0:64,1:64 hugepagesz=3D64K =
hugepages=3D0:2,1:2
>>> "
>>>=20
>>> Ubuntu userspace running off XFS rootfs. Build and run mm selftests =
from same
>>> git tree.
>>>=20
>>>=20
>>> Although I don't think any of this config should make a difference =
to gup_longterm.
>>>=20
>>> Looks like your errors are all "ftruncate() failed". I've seen this =
problem on
>>> our CI system. There it is due to running the tests from NFS file =
system. What
>>> filesystem are you using? Perhaps you are sharing into the FVP using =
9p? That
>>> might also be problematic.
>>=20
>> That was it. This time I booted up the kernel including your series =
on
>> QEMU on my M1 and executed the gup_longterm program without the =
ftruncate
>> failures. When testing your kernel on FVP, I was executing the script =
from the FVP's host filesystem using 9p.
>=20
> I'm not sure exactly what the root cause is. Perhaps there isn't =
enough space on
> the disk? It might be worth enhancing the error log to provide the =
errno in
> tools/testing/selftests/mm/gup_longterm.c.
>=20

Attached is the strace=E2=80=99d gup_longterm executiong log on your =
pgtable-boot-speedup-v2 kernel.

Thanks,
Itaru.

--Apple-Mail=_6301FD46-615B-4C7C-A21F-4DBA8139077F
Content-Disposition: attachment;
	filename=straced-gup_longterm.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="straced-gup_longterm.log"
Content-Transfer-Encoding: 7bit

execve("./gup_longterm", ["./gup_longterm"], 0xffffc8e27490 /* 12 vars */) = 0
brk(NULL)                               = 0xaaaafb5dc000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffff8727d000
faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\260\265\2\0\0\0\0\0"..., 832) = 832
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=1605640, ...}, AT_EMPTY_PATH) = 0
mmap(NULL, 1650608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xffff870ea000
mmap(0xffff8726c000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x182000) = 0xffff8726c000
mmap(0xffff87271000, 49072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffff87271000
close(3)                                = 0
set_tid_address(0xffff8727def0)         = 194
set_robust_list(0xffff8727df00, 24)     = 0
rseq(0xffff8727e540, 0x20, 0, 0xd428bc00) = 0
mprotect(0xffff8726c000, 12288, PROT_READ) = 0
mprotect(0xaaaae548f000, 4096, PROT_READ) = 0
mprotect(0xffff872a8000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
openat(AT_FDCWD, "/sys/kernel/mm/hugepages/", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
newfstatat(3, "", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_EMPTY_PATH) = 0
getrandom("\xc0\xaf\xa1\xd8\x09\x56\x5c\x4d", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0xaaaafb5dc000
brk(0xaaaafb5fd000)                     = 0xaaaafb5fd000
getdents64(3, 0xaaaafb5dc2d0 /* 6 entries */, 32768) = 208
newfstatat(1, "", {st_mode=S_IFIFO|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
getdents64(3, 0xaaaafb5dc2d0 /* 0 entries */, 32768) = 0
close(3)                                = 0
openat(AT_FDCWD, "/sys/kernel/debug/gup_test", O_RDWR) = -1 ENOENT (No such file or directory)
memfd_create("test", 0)                 = 3
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x82baf8fa, 0x71479f87]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416024, f_bfree=416007, f_bavail=416007, f_files=416024, f_ffree=416018, f_fsid={val=[0x1357e84b, 0x1c37069b]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_twSAYO", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_twSAYO", 0) = 0
fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not supported)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = -1 ENOSPC (No space left on device)
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
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x82baf8fa, 0x71479f87]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416024, f_bfree=416007, f_bavail=416007, f_files=416024, f_ffree=416018, f_fsid={val=[0x1357e84b, 0x1c37069b]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_vDLIRw", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_vDLIRw", 0) = 0
fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not supported)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = -1 ENOSPC (No space left on device)
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
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x82baf8fa, 0x71479f87]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416024, f_bfree=416007, f_bavail=416007, f_files=416024, f_ffree=416018, f_fsid={val=[0x1357e84b, 0x1c37069b]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_TBRsO0", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_TBRsO0", 0) = 0
fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not supported)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = -1 ENOSPC (No space left on device)
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
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x82baf8fa, 0x71479f87]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416024, f_bfree=416007, f_bavail=416007, f_files=416024, f_ffree=416018, f_fsid={val=[0x1357e84b, 0x1c37069b]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_jwd7gF", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_jwd7gF", 0) = 0
fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not supported)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = -1 ENOSPC (No space left on device)
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
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x82baf8fa, 0x71479f87]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416024, f_bfree=416007, f_bavail=416007, f_files=416024, f_ffree=416018, f_fsid={val=[0x1357e84b, 0x1c37069b]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffff870e9000
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_XrL4Qd", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_XrL4Qd", 0) = 0
fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not supported)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
close(3)                                = 0
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = -1 ENOSPC (No space left on device)
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
not ok 3 ftruncate() failed
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 4 # SKIP need more free huge pages
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
not ok 10 ftruncate() failed
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 11 # SKIP need more free huge pages
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
not ok 17 ftruncate() failed
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 18 # SKIP need more free huge pages
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
not ok 24 ftruncate() failed
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 25 # SKIP need more free huge pages
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
not ok 31 ftruncate() failed
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
ok 32 # SKIP need more free huge pages
# [RUN] R/W longterm) = 4096
write(1, " GUP pin in MAP_PRIVATE file map"..., 71 GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (32768 kB)
) = 71
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
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x82baf8fa, 0x71479f87]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffff870e9000
write(1, "ok 36 # SKIP gup_test not availa"..., 36ok 36 # SKIP gup_test not available
) = 36
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 79# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
) = 79
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416024, f_bfree=416007, f_bavail=416007, f_files=416024, f_ffree=416018, f_fsid={val=[0x1357e84b, 0x1c37069b]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffff870e9000
write(1, "ok 37 # SKIP gup_test not availa"..., 36ok 37 # SKIP gup_test not available
) = 36
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 85# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
) = 85
openat(AT_FDCWD, "gup_longterm.c_tmpfile_vdu0ET", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_vdu0ET", 0) = 0
fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not supported)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
write(1, "not ok 38 ftruncate() failed\n", 29not ok 38 ftruncate() failed
) = 29
close(3)                                = 0
write(1, "# [RUN] R/W longterm GUP-fast pi"..., 95# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
) = 95
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = -1 ENOSPC (No space left on device)
write(1, "ok 39 # SKIP need more free huge"..., 39ok 39 # SKIP need more free huge pages
) = 39
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
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x82baf8fa, 0x71479f87]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffff870e9000
write(1, "ok 43 # SKIP gup_test not availa"..., 36ok 43 # SKIP gup_test not available
) = 36
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 74# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
) = 74
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416024, f_bfree=416007, f_bavail=416007, f_files=416024, f_ffree=416018, f_fsid={val=[0x1357e84b, 0x1c37069b]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffff870e9000
write(1, "ok 44 # SKIP gup_test not availa"..., 36ok 44 # SKIP gup_test not available
) = 36
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 80# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
) = 80
openat(AT_FDCWD, "gup_longterm.c_tmpfile_3KYzfZ", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_3KYzfZ", 0) = 0
fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not supported)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
write(1, "not ok 45 ftruncate() failed\n", 29not ok 45 ftruncate() failed
) = 29
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP pin in "..., 90# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
) = 90
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = -1 ENOSPC (No space left on device)
write(1, "ok 46 # SKIP need more free huge"..., 39ok 46 # SKIP need more free huge pages
) = 39
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
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x82baf8fa, 0x71479f87]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffff870e9000
write(1, "ok 50 # SKIP gup_test not availa"..., 36ok 50 # SKIP gup_test not available
) = 36
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 79# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
) = 79
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416024, f_bfree=416007, f_bavail=416007, f_files=416024, f_ffree=416018, f_fsid={val=[0x1357e84b, 0x1c37069b]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
ftruncate(3, 4096)                      = 0
fallocate(3, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xffff870e9000
write(1, "ok 51 # SKIP gup_test not availa"..., 36ok 51 # SKIP gup_test not available
) = 36
munmap(0xffff870e9000, 4096)            = 0
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 85# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
) = 85
openat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", 0) = 0
fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not supported)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)
write(1, "not ok 52 ftruncate() failed\n", 29not ok 52 ftruncate() failed
) = 29
close(3)                                = 0
write(1, "# [RUN] R/O longterm GUP-fast pi"..., 95# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
) = 95
memfd_create("test", MFD_HUGETLB|21<<MFD_HUGE_SHIFT) = 3
fstatfs(3, {f_type=HUGETLBFS_MAGIC, f_bsize=2097152, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={val=[0x10, 0]}, f_namelen=255, f_frsize=2097152, f_flags=ST_VALID}) = 0
ftruncate(3, 2097152)                   = 0
fallocate(3, 0, 0, 2097152)             = -1 ENOSPC (No space left on device)
write(1, "ok 53 # SKIP need more free huge"..., 39ok 53 # SKIP need more free huge pages
) = 39
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
write(1, "Bail out! 8 out of 56 tests fail"..., 35Bail out! 8 out of 56 tests failed
) = 35
write(1, "# Totals: pass:0 fail:8 xfail:0 "..., 56# Totals: pass:0 fail:8 xfail:0 xpass:0 skip:48 error:0
) = 56
exit_group(1)                           = ?
+++ exited with 1 +++

--Apple-Mail=_6301FD46-615B-4C7C-A21F-4DBA8139077F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Thanks,
> Ryan
>=20
>>=20
>> Thanks,
>> Itaru.
>>=20
>>>=20
>>> Does this problem reproduce with v6.9-rc2, without my patches? I =
except it
>>> probably does?
>>>=20
>>> Thanks,
>>> Ryan
>>>=20
>>>>=20
>>>> Thanks,
>>>> Itaru.



--Apple-Mail=_6301FD46-615B-4C7C-A21F-4DBA8139077F--

