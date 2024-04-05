Return-Path: <linux-kernel+bounces-132567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BB18996B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A761F22D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2882812B141;
	Fri,  5 Apr 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X8R7mwWz"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5C12CD98
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302802; cv=none; b=Q+hcVODhfGAjWc676lxbbfMsJkB1/CM27FcCe8VkxmJhB8XkiUDaXsYqr47Z8JgoeQcy+CCQW7OSTDM4gk1WgS1ra8lk0U/CKryN77K9Z05ZT+L5XtmxetGjZKEoS1qzGpq8KimDA3HRaL3y15RfXrmGq2HjFvrP/oC8Pskygtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302802; c=relaxed/simple;
	bh=BeqsaYo2xZGVuYbqyF/RL0T2SfgJGjAFamSH4MN9AdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju2avjdXr99WJJklkJ3W0uDU9rdsGA2+oF1TqB7yzCCS7L7m7aUWoPugnz4viQrgRYfZHEzhJVWheBu39+FxZs7vFCPTtrBYVbcDPW257tLH/0FQMSCAg4WLSRlIJgZ/FsRXt8tWYUqRFYvCOdODpBGm6TLctfd8BKXsRMQbzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X8R7mwWz; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Apr 2024 16:39:46 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712302796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fb2509Xb4NnYEdIHcS3RMf+/MkmAWfEA1easoWL98yc=;
	b=X8R7mwWzAnZd4/qgKZcELc05LrVcG2Rtn/9sxzVKOaCEb1Ln+mgxrrNY/9I59nvzrY5JmQ
	Zr5yLFSCVDSL7ELflrudebGKDgI+rz3qDm0NdhJ+YKOvkRs7e198GVfsa2ztAY4Hzn9uXq
	tHzYKrJmcsLkLlcslXzGQL+kf2WDvOE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Speed up boot with faster linear map creation
Message-ID: <Zg+qwooaWFNL7KIg@vm3>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="O5ZNHbF7ZFbQXwhl"
Content-Disposition: inline
In-Reply-To: <20240404143308.2224141-1-ryan.roberts@arm.com>
X-Migadu-Flow: FLOW_OUT


--O5ZNHbF7ZFbQXwhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2024 at 03:33:04PM +0100, Ryan Roberts wrote:
> Hi All,
> 
> It turns out that creating the linear map can take a significant proportion of
> the total boot time, especially when rodata=full. And most of the time is spent
> waiting on superfluous tlb invalidation and memory barriers. This series reworks
> the kernel pgtable generation code to significantly reduce the number of those
> TLBIs, ISBs and DSBs. See each patch for details.
> 
> The below shows the execution time of map_mem() across a couple of different
> systems with different RAM configurations. We measure after applying each patch
> and show the improvement relative to base (v6.9-rc2):
> 
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> base           |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442   (0%)
> no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796 (-78%)
> batch-barriers |   13 (-92%) |  162 (-93%) |  655 (-93%) |  1656 (-91%)
> no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 (-95%) |  1257 (-93%)
> lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 (-97%) |   838 (-95%)
> 
> This series applies on top of v6.9-rc2. All mm selftests pass. I've compile and
> boot tested various PAGE_SIZE and VA size configs.
> 
> ---
> 
> Changes since v1 [1]
> ====================
> 
>   - Added Tested-by tags (thanks to Eric and Itaru)
>   - Renamed ___set_pte() -> __set_pte_nosync() (per Ard)
>   - Reordered patches (biggest impact & least controversial first)
>   - Reordered alloc/map/unmap functions in mmu.c to aid reader
>   - pte_clear() -> __pte_clear() in clear_fixmap_nosync()
>   - Reverted generic p4d_index() which caused x86 build error. Replaced with
>     unconditional p4d_index() define under arm64.
> 
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/
> 
> Thanks,
> Ryan
> 
> 
> Ryan Roberts (4):
>   arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>   arm64: mm: Batch dsb and isb when populating pgtables
>   arm64: mm: Don't remap pgtables for allocate vs populate
>   arm64: mm: Lazily clear pte table mappings from fixmap
> 
>  arch/arm64/include/asm/fixmap.h  |   5 +-
>  arch/arm64/include/asm/mmu.h     |   8 +
>  arch/arm64/include/asm/pgtable.h |  13 +-
>  arch/arm64/kernel/cpufeature.c   |  10 +-
>  arch/arm64/mm/fixmap.c           |  11 +
>  arch/arm64/mm/mmu.c              | 377 +++++++++++++++++++++++--------
>  6 files changed, 319 insertions(+), 105 deletions(-)
> 
> --
> 2.25.1
>

I've build and boot tested the v2 on FVP, base is taken from your
linux-rr repo. Running run_vmtests.sh on v2 left some gup longterm not oks, would you take a look at it? The mm ksefltests used is from your linux-rr repo too.

Thanks,
Itaru.

--O5ZNHbF7ZFbQXwhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="output.log"
Content-Transfer-Encoding: quoted-printable

# timeout set to 180
# TAP version 13
# # -unnin--./-u-e---e-mm--
# # running ./hugepage-mmap
# # -unnin--./-u-e---e-mm--
# # TAP version 13
# # 1..1
# # # Returned address is 0xffff92e00000
# # # First hex is 0
# # # First hex is 3020100
# # ok 1 Read same data
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 1 hugepage-mmap
# # -unnin--./-u-e---e-s-m
# # running ./hugepage-shm
# # -unnin--./-u-e---e-s-m
# # shmid: 0x0
# # shmaddr: 0xffffac600000
# # Starting the writes:
# # .......................................................................=
=2E........................................................................=
=2E........................................................................=
=2E......................................
# # Starting the Check...Done.
# # [PASS]
# ok 2 hugepage-shm
# # -unnin--./m--_-u-etlb
# # running ./map_hugetlb
# # -unnin--./m--_-u-etlb
# # TAP version 13
# # 1..1
# # # Default size hugepages
# # # Mapping 256 Mbytes
# # # Returned address is 0xffff7e400000
# # # First hex is 0
# # # First hex is 3020100
# # ok 1 Read correct data
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 3 map_hugetlb
# # -unnin--./-u-e---e-m-em--
# # running ./hugepage-mremap
# # -unnin--./-u-e---e-m-em--
# # TAP version 13
# # 1..1
# # # Map haddr: Returned address is 0x7eaa40000000
# # # Map daddr: Returned address is 0x7daa40000000
# # # Map vaddr: Returned address is 0x7faa40000000
# # # Address returned by mmap() =3D 0xffffb4a00000
# # # Mremap: Returned address is 0x7faa40000000
# # # First hex is 0
# # # First hex is 3020100
# # ok 1 Read same data
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 4 hugepage-mremap
# # -unnin--./-u-e---e-vmemm--
# # running ./hugepage-vmemmap
# # -unnin--./-u-e---e-vmemm--
# # Returned address is 0xffff88c00000 whose pfn is 89d000
# # [PASS]
# ok 5 hugepage-vmemmap
# # -unnin--./-u-etlb-m-dvise
# # running ./hugetlb-madvise
# # -unnin--./-u-etlb-m-dvise
# # [PASS]
# ok 6 hugetlb-madvise
# # -unnin--./-u-etlb_f-ult_-fte-_m-dv
# # running ./hugetlb_fault_after_madv
# # -unnin--./-u-etlb_f-ult_-fte-_m-dv
# # [PASS]
# ok 7 hugetlb_fault_after_madv
# # -unnin--./-u-etlb_m-dv_vs_m--
# # running ./hugetlb_madv_vs_map
# # -unnin--./-u-etlb_m-dv_vs_m--
# # [PASS]
# ok 8 hugetlb_madv_vs_map
# # NOTE: These hugetlb tests provide minimal coverage.  Use
# #       https://github.com/libhugetlbfs/libhugetlbfs.git for
# #       hugetlb regression testing.
# # -unnin--./m--_fixed_no-e-l-ce
# # running ./map_fixed_noreplace
# # -unnin--./m--_fixed_no-e-l-ce
# # TAP version 13
# # 1..9
# # ok 1 mmap() @ 0xffff9c341000-0xffff9c346000 p=3D0xffff9c341000 result=
=3DSuccess
# # ok 2 mmap() @ 0xffff9c342000-0xffff9c345000 p=3D0xffff9c342000 result=
=3DSuccess
# # ok 3 mmap() @ 0xffff9c341000-0xffff9c346000 p=3D0xffffffffffffffff resu=
lt=3DFile exists
# # ok 4 mmap() @ 0xffff9c343000-0xffff9c344000 p=3D0xffffffffffffffff resu=
lt=3DFile exists
# # ok 5 mmap() @ 0xffff9c344000-0xffff9c346000 p=3D0xffffffffffffffff resu=
lt=3DFile exists
# # ok 6 mmap() @ 0xffff9c341000-0xffff9c343000 p=3D0xffffffffffffffff resu=
lt=3DFile exists
# # ok 7 mmap() @ 0xffff9c341000-0xffff9c342000 p=3D0xffff9c341000 result=
=3DFile exists
# # ok 8 mmap() @ 0xffff9c345000-0xffff9c346000 p=3D0xffff9c345000 result=
=3DFile exists
# # ok 9 Base Address unmap() successful
# # # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 9 map_fixed_noreplace
# # -unnin--./-u-_test--u
# # running ./gup_test -u
# # -unnin--./-u-_test--u
# # TAP version 13
# # 1..1
# # # GUP_FAST_BENCHMARK: Time: get:311641 put:52261 us#=20
# # ok 1 ioctl status 0
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 10 gup_test -u
# # -unnin--./-u-_test---
# # running ./gup_test -a
# # -unnin--./-u-_test---
# # TAP version 13
# # 1..1
# # # PIN_FAST_BENCHMARK: Time: get:575618 put:102293 us#=20
# # ok 1 ioctl status 0
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 11 gup_test -a
# # -unnin--./-u-_test--ct--F-0x1-0-19-0x1000
# # running ./gup_test -ct -F 0x1 0 19 0x1000
# # -unnin--./-u-_test--ct--F-0x1-0-19-0x1000
# # TAP version 13
# # 1..1
# # # DUMP_USER_PAGES_TEST: done
# # ok 1 ioctl status 0
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 12 gup_test -ct -F 0x1 0 19 0x1000
# # -unnin--./-u-_lon-te-m
# # running ./gup_longterm
# # -unnin--./-u-_lon-te-m
# # # [INFO] detected hugetlb page size: 2048 KiB
# # # [INFO] detected hugetlb page size: 32768 KiB
# # # [INFO] detected hugetlb page size: 64 KiB
# # # [INFO] detected hugetlb page size: 1048576 KiB
# # TAP version 13
# # 1..56
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd
# # ok 1 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
# # ok 2 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with local =
tmpfile
# # not ok 3 ftruncate() failed
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd =
hugetlb (2048 kB)
# # ok 4 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd =
hugetlb (32768 kB)
# # ok 5 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd =
hugetlb (64 kB)
# # ok 6 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd =
hugetlb (1048576 kB)
# # ok 7 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd
# # ok 8 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with t=
mpfile
# # ok 9 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with l=
ocal tmpfile
# # not ok 10 ftruncate() failed
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd hugetlb (2048 kB)
# # ok 11 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd hugetlb (32768 kB)
# # ok 12 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd hugetlb (64 kB)
# # ok 13 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd hugetlb (1048576 kB)
# # ok 14 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd
# # ok 15 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
# # ok 16 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with local =
tmpfile
# # not ok 17 ftruncate() failed
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd =
hugetlb (2048 kB)
# # ok 18 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd =
hugetlb (32768 kB)
# # ok 19 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd =
hugetlb (64 kB)
# # ok 20 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd =
hugetlb (1048576 kB)
# # ok 21 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd
# # ok 22 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with t=
mpfile
# # ok 23 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with l=
ocal tmpfile
# # not ok 24 ftruncate() failed
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd hugetlb (2048 kB)
# # ok 25 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd hugetlb (32768 kB)
# # ok 26 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd hugetlb (64 kB)
# # ok 27 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with m=
emfd hugetlb (1048576 kB)
# # ok 28 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
# # ok 29 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfi=
le
# # ok 30 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with local=
 tmpfile
# # not ok 31 ftruncate() failed
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd=
 hugetlb (2048 kB)
# # ok 32 Should have worked
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd=
 hugetlb (32768 kB)
# # ok 33 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd=
 hugetlb (64 kB)
# # ok 34 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd=
 hugetlb (1048576 kB)
# # ok 35 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd
# # ok 36 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
tmpfile
# # ok 37 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
local tmpfile
# # not ok 38 ftruncate() failed
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (2048 kB)
# # ok 39 Should have worked
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (32768 kB)
# # ok 40 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (64 kB)
# # ok 41 # SKIP need more free huge pages
# # # [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (1048576 kB)
# # ok 42 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
# # ok 43 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfi=
le
# # ok 44 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with local=
 tmpfile
# # not ok 45 ftruncate() failed
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd=
 hugetlb (2048 kB)
# # ok 46 Should have worked
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd=
 hugetlb (32768 kB)
# # ok 47 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd=
 hugetlb (64 kB)
# # ok 48 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd=
 hugetlb (1048576 kB)
# # ok 49 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd
# # ok 50 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
tmpfile
# # ok 51 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
local tmpfile
# # not ok 52 ftruncate() failed
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (2048 kB)
# # ok 53 Should have worked
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (32768 kB)
# # ok 54 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (64 kB)
# # ok 55 # SKIP need more free huge pages
# # # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (1048576 kB)
# # ok 56 # SKIP need more free huge pages
# # Bail out! 8 out of 56 tests failed
# # # Totals: pass:24 fail:8 xfail:0 xpass:0 skip:24 error:0
# # [FAIL]
# not ok 13 gup_longterm # exit=3D1
# # -unnin--./uffd-unit-tests
# # running ./uffd-unit-tests
# # -unnin--./uffd-unit-tests
# # Testing UFFDIO_API (with syscall)... done
# # Testing UFFDIO_API (with /dev/userfaultfd)... done
# # Testing register-ioctls on anon... skipped [reason: feature missing]
# # Testing register-ioctls on shmem... skipped [reason: feature missing]
# # Testing register-ioctls on shmem-private... skipped [reason: feature mi=
ssing]
# # Testing register-ioctls on hugetlb... skipped [reason: feature missing]
# # Testing register-ioctls on hugetlb-private... skipped [reason: feature =
missing]
# # Testing zeropage on anon... done
# # Testing zeropage on shmem... done
# # Testing zeropage on shmem-private... done
# # Testing zeropage on hugetlb... done
# # Testing zeropage on hugetlb-private... done
# # Testing move on anon... done
# # Testing move-pmd on anon... done
# # Testing move-pmd-split on anon... done
# # Testing wp-fork on anon... skipped [reason: feature missing]
# # Testing wp-fork on shmem... skipped [reason: feature missing]
# # Testing wp-fork on shmem-private... skipped [reason: feature missing]
# # Testing wp-fork on hugetlb... skipped [reason: feature missing]
# # Testing wp-fork on hugetlb-private... skipped [reason: feature missing]
# # Testing wp-fork-with-event on anon... skipped [reason: feature missing]
# # Testing wp-fork-with-event on shmem... skipped [reason: feature missing]
# # Testing wp-fork-with-event on shmem-private... skipped [reason: feature=
 missing]
# # Testing wp-fork-with-event on hugetlb... skipped [reason: feature missi=
ng]
# # Testing wp-fork-with-event on hugetlb-private... skipped [reason: featu=
re missing]
# # Testing wp-fork-pin on anon... skipped [reason: feature missing]
# # Testing wp-fork-pin on shmem... skipped [reason: feature missing]
# # Testing wp-fork-pin on shmem-private... skipped [reason: feature missin=
g]
# # Testing wp-fork-pin on hugetlb... skipped [reason: feature missing]
# # Testing wp-fork-pin on hugetlb-private... skipped [reason: feature miss=
ing]
# # Testing wp-fork-pin-with-event on anon... skipped [reason: feature miss=
ing]
# # Testing wp-fork-pin-with-event on shmem... skipped [reason: feature mis=
sing]
# # Testing wp-fork-pin-with-event on shmem-private... skipped [reason: fea=
ture missing]
# # Testing wp-fork-pin-with-event on hugetlb... skipped [reason: feature m=
issing]
# # Testing wp-fork-pin-with-event on hugetlb-private... skipped [reason: f=
eature missing]
# # Testing wp-unpopulated on anon... skipped [reason: feature missing]
# # Testing minor on shmem... done
# # Testing minor on hugetlb... done
# # Testing minor-wp on shmem... skipped [reason: feature missing]
# # Testing minor-wp on hugetlb... skipped [reason: feature missing]
# # Testing minor-collapse on shmem... done
# # Testing sigbus on anon... done
# # Testing sigbus on shmem... done
# # Testing sigbus on shmem-private... done
# # Testing sigbus on hugetlb... done
# # Testing sigbus on hugetlb-private... done
# # Testing sigbus-wp on anon... skipped [reason: feature missing]
# # Testing sigbus-wp on shmem... skipped [reason: feature missing]
# # Testing sigbus-wp on shmem-private... skipped [reason: feature missing]
# # Testing sigbus-wp on hugetlb... skipped [reason: feature missing]
# # Testing sigbus-wp on hugetlb-private... skipped [reason: feature missin=
g]
# # Testing events on anon... done
# # Testing events on shmem... done
# # Testing events on shmem-private... done
# # Testing events on hugetlb... done
# # Testing events on hugetlb-private... done
# # Testing events-wp on anon... skipped [reason: feature missing]
# # Testing events-wp on shmem... skipped [reason: feature missing]
# # Testing events-wp on shmem-private... skipped [reason: feature missing]
# # Testing events-wp on hugetlb... skipped [reason: feature missing]
# # Testing events-wp on hugetlb-private... skipped [reason: feature missin=
g]
# # Testing poison on anon... done
# # Testing poison on shmem... done
# # Testing poison on shmem-private... done
# # Testing poison on hugetlb... done
# # Testing poison on hugetlb-private... done
# # Userfaults unit tests: pass=3D28, skip=3D38, fail=3D0 (total=3D66)
# # [PASS]
# ok 14 uffd-unit-tests
# # -unnin--./uffd-st-ess--non-20-16
# # running ./uffd-stress anon 20 16
# # -unnin--./uffd-st-ess--non-20-16
# # nr_pages: 5120, nr_pages_per_cpu: 640
# # bounces: 15, mode: rnd racing ver poll, userfaults: 867 missing (192+16=
0+139+121+97+61+63+34+=08)=20
# # bounces: 14, mode: racing ver poll, userfaults: 667 missing (122+102+10=
3+79+88+69+59+45+=08)=20
# # bounces: 13, mode: rnd ver poll, userfaults: 809 missing (188+159+122+1=
19+66+64+58+33+=08)=20
# # bounces: 12, mode: ver poll, userfaults: 1141 missing (246+208+214+155+=
190+61+33+34+=08)=20
# # bounces: 11, mode: rnd racing poll, userfaults: 977 missing (200+202+15=
3+132+104+74+62+50+=08)=20
# # bounces: 10, mode: racing poll, userfaults: 448 missing (106+78+75+59+4=
7+30+34+19+=08)=20
# # bounces: 9, mode: rnd poll, userfaults: 1600 missing (860+167+136+105+1=
00+102+70+60+=08)=20
# # bounces: 8, mode: poll, userfaults: 609 missing (153+101+80+72+65+47+52=
+39+=08)=20
# # bounces: 7, mode: rnd racing ver read, userfaults: 953 missing (208+176=
+142+123+104+87+70+43+=08)=20
# # bounces: 6, mode: racing ver read, userfaults: 745 missing (126+125+102=
+104+82+90+65+51+=08)=20
# # bounces: 5, mode: rnd ver read, userfaults: 981 missing (227+191+143+12=
2+109+79+65+45+=08)=20
# # bounces: 4, mode: ver read, userfaults: 780 missing (171+128+115+89+74+=
72+73+58+=08)=20
# # bounces: 3, mode: rnd racing read, userfaults: 1053 missing (265+212+15=
4+127+110+89+54+42+=08)=20
# # bounces: 2, mode: racing read, userfaults: 747 missing (145+122+110+101=
+83+46+56+84+=08)=20
# # bounces: 1, mode: rnd read, userfaults: 983 missing (231+175+144+116+10=
1+84+69+63+=08)=20
# # bounces: 0, mode: read, userfaults: 659 missing (148+86+83+73+84+72+65+=
48+=08)=20
# # [PASS]
# ok 15 uffd-stress anon 20 16
# # -unnin--./uffd-st-ess--u-etlb-128-32
# # running ./uffd-stress hugetlb 128 32
# # -unnin--./uffd-st-ess--u-etlb-128-32
# # nr_pages: 64, nr_pages_per_cpu: 8
# # bounces: 31, mode: rnd racing ver poll, userfaults: 42 missing (15+10+9=
+7+1+0+0+0+=08)=20
# # bounces: 30, mode: racing ver poll, userfaults: 23 missing (10+3+2+4+2+=
1+1+0+=08)=20
# # bounces: 29, mode: rnd ver poll, userfaults: 41 missing (15+13+8+3+2+0+=
0+0+=08)=20
# # bounces: 28, mode: ver poll, userfaults: 27 missing (11+8+6+2+0+0+0+0+=
=08)=20
# # bounces: 27, mode: rnd racing poll, userfaults: 43 missing (13+12+10+6+=
2+0+0+0+=08)=20
# # bounces: 26, mode: racing poll, userfaults: 25 missing (11+3+4+4+2+1+0+=
0+=08)=20
# # bounces: 25, mode: rnd poll, userfaults: 38 missing (13+9+8+5+3+0+0+0+=
=08)=20
# # bounces: 24, mode: poll, userfaults: 25 missing (25+0+0+0+0+0+0+0+=08)=
=20
# # bounces: 23, mode: rnd racing ver read, userfaults: 40 missing (13+12+7=
+4+4+0+0+0+=08)=20
# # bounces: 22, mode: racing ver read, userfaults: 21 missing (8+4+2+2+2+1=
+2+0+=08)=20
# # bounces: 21, mode: rnd ver read, userfaults: 40 missing (14+11+6+5+4+0+=
0+0+=08)=20
# # bounces: 20, mode: ver read, userfaults: 20 missing (9+6+4+1+0+0+0+0+=
=08)=20
# # bounces: 19, mode: rnd racing read, userfaults: 40 missing (14+11+9+3+2=
+1+0+0+=08)=20
# # bounces: 18, mode: racing read, userfaults: 17 missing (7+4+2+3+1+0+0+0=
+=08)=20
# # bounces: 17, mode: rnd read, userfaults: 40 missing (13+13+8+3+3+0+0+0+=
=08)=20
# # bounces: 16, mode: read, userfaults: 16 missing (7+6+2+1+0+0+0+0+=08)=
=20
# # bounces: 15, mode: rnd racing ver poll, userfaults: 40 missing (12+10+8=
+6+3+1+0+0+=08)=20
# # bounces: 14, mode: racing ver poll, userfaults: 16 missing (10+2+2+0+0+=
1+0+1+=08)=20
# # bounces: 13, mode: rnd ver poll, userfaults: 42 missing (15+11+8+6+1+1+=
0+0+=08)=20
# # bounces: 12, mode: ver poll, userfaults: 18 missing (9+4+1+4+0+0+0+0+=
=08)=20
# # bounces: 11, mode: rnd racing poll, userfaults: 41 missing (13+13+9+3+3=
+0+0+0+=08)=20
# # bounces: 10, mode: racing poll, userfaults: 9 missing (9+0+0+0+0+0+0+0+=
=08)=20
# # bounces: 9, mode: rnd poll, userfaults: 40 missing (14+11+7+6+2+0+0+0+=
=08)=20
# # bounces: 8, mode: poll, userfaults: 15 missing (6+4+2+1+1+1+0+0+=08)=20
# # bounces: 7, mode: rnd racing ver read, userfaults: 43 missing (13+12+8+=
6+3+1+0+0+=08)=20
# # bounces: 6, mode: racing ver read, userfaults: 10 missing (5+1+0+0+0+3+=
1+0+=08)=20
# # bounces: 5, mode: rnd ver read, userfaults: 37 missing (14+8+6+7+1+1+0+=
0+=08)=20
# # bounces: 4, mode: ver read, userfaults: 29 missing (9+4+5+2+3+3+2+1+=08=
)=20
# # bounces: 3, mode: rnd racing read, userfaults: 39 missing (14+10+7+5+3+=
0+0+0+=08)=20
# # bounces: 2, mode: racing read, userfaults: 8 missing (4+1+0+1+0+1+1+0+=
=08)=20
# # bounces: 1, mode: rnd read, userfaults: 39 missing (12+12+8+4+3+0+0+0+=
=08)=20
# # bounces: 0, mode: read, userfaults: 25 missing (6+6+5+2+3+3+0+0+=08)=20
# # [PASS]
# ok 16 uffd-stress hugetlb 128 32
# # -unnin--./uffd-st-ess--u-etlb---iv-te-128-32
# # running ./uffd-stress hugetlb-private 128 32
# # -unnin--./uffd-st-ess--u-etlb---iv-te-128-32
# # nr_pages: 64, nr_pages_per_cpu: 8
# # bounces: 31, mode: rnd racing ver poll, userfaults: 42 missing (13+12+9=
+6+2+0+0+0+=08)=20
# # bounces: 30, mode: racing ver poll, userfaults: 25 missing (12+3+6+0+0+=
3+1+0+=08)=20
# # bounces: 29, mode: rnd ver poll, userfaults: 41 missing (15+11+8+5+2+0+=
0+0+=08)=20
# # bounces: 28, mode: ver poll, userfaults: 28 missing (10+9+7+2+0+0+0+0+=
=08)=20
# # bounces: 27, mode: rnd racing poll, userfaults: 42 missing (15+13+7+5+1=
+1+0+0+=08)=20
# # bounces: 26, mode: racing poll, userfaults: 22 missing (8+2+4+3+1+1+2+1=
+=08)=20
# # bounces: 25, mode: rnd poll, userfaults: 39 missing (14+11+9+3+2+0+0+0+=
=08)=20
# # bounces: 24, mode: poll, userfaults: 24 missing (12+7+4+1+0+0+0+0+=08)=
=20
# # bounces: 23, mode: rnd racing ver read, userfaults: 44 missing (16+12+9=
+5+2+0+0+0+=08)=20
# # bounces: 22, mode: racing ver read, userfaults: 21 missing (12+0+4+1+2+=
1+1+0+=08)=20
# # bounces: 21, mode: rnd ver read, userfaults: 41 missing (12+13+8+6+2+0+=
0+0+=08)=20
# # bounces: 20, mode: ver read, userfaults: 37 missing (26+7+1+1+2+0+0+0+=
=08)=20
# # bounces: 19, mode: rnd racing read, userfaults: 46 missing (19+16+11+0+=
0+0+0+0+=08)=20
# # bounces: 18, mode: racing read, userfaults: 17 missing (7+5+4+1+0+0+0+0=
+=08)=20
# # bounces: 17, mode: rnd read, userfaults: 41 missing (15+10+9+4+3+0+0+0+=
=08)=20
# # bounces: 16, mode: read, userfaults: 17 missing (9+6+0+2+0+0+0+0+=08)=
=20
# # bounces: 15, mode: rnd racing ver poll, userfaults: 43 missing (15+11+8=
+7+1+1+0+0+=08)=20
# # bounces: 14, mode: racing ver poll, userfaults: 15 missing (10+2+1+1+0+=
1+0+0+=08)=20
# # bounces: 13, mode: rnd ver poll, userfaults: 43 missing (16+10+8+5+3+1+=
0+0+=08)=20
# # bounces: 12, mode: ver poll, userfaults: 17 missing (7+4+1+2+1+2+0+0+=
=08)=20
# # bounces: 11, mode: rnd racing poll, userfaults: 39 missing (16+11+5+4+3=
+0+0+0+=08)=20
# # bounces: 10, mode: racing poll, userfaults: 13 missing (6+3+1+1+1+0+0+1=
+=08)=20
# # bounces: 9, mode: rnd poll, userfaults: 40 missing (14+10+9+6+1+0+0+0+=
=08)=20
# # bounces: 8, mode: poll, userfaults: 19 missing (9+5+2+1+1+1+0+0+=08)=20
# # bounces: 7, mode: rnd racing ver read, userfaults: 39 missing (15+10+8+=
5+1+0+0+0+=08)=20
# # bounces: 6, mode: racing ver read, userfaults: 8 missing (6+1+0+0+0+0+1=
+0+=08)=20
# # bounces: 5, mode: rnd ver read, userfaults: 40 missing (15+8+8+5+3+1+0+=
0+=08)=20
# # bounces: 4, mode: ver read, userfaults: 29 missing (11+3+3+4+4+3+1+0+=
=08)=20
# # bounces: 3, mode: rnd racing read, userfaults: 40 missing (13+13+8+4+1+=
1+0+0+=08)=20
# # bounces: 2, mode: racing read, userfaults: 6 missing (4+0+1+0+0+1+0+0+=
=08)=20
# # bounces: 1, mode: rnd read, userfaults: 42 missing (15+11+9+4+3+0+0+0+=
=08)=20
# # bounces: 0, mode: read, userfaults: 27 missing (6+6+2+7+0+3+3+0+=08)=20
# # [PASS]
# ok 17 uffd-stress hugetlb-private 128 32
# # -unnin--./uffd-st-ess-s-mem-20-16
# # running ./uffd-stress shmem 20 16
# # -unnin--./uffd-st-ess-s-mem-20-16
# # nr_pages: 5120, nr_pages_per_cpu: 640
# # bounces: 15, mode: rnd racing ver poll, userfaults: 927 missing (199+16=
5+147+137+97+72+65+45+=08)=20
# # bounces: 14, mode: racing ver poll, userfaults: 412 missing (100+68+61+=
48+43+33+35+24+=08)=20
# # bounces: 13, mode: rnd ver poll, userfaults: 945 missing (173+164+131+1=
22+119+102+70+64+=08)=20
# # bounces: 12, mode: ver poll, userfaults: 658 missing (159+98+96+79+68+5=
6+72+30+=08)=20
# # bounces: 11, mode: rnd racing poll, userfaults: 926 missing (195+146+14=
0+114+112+103+73+43+=08)=20
# # bounces: 10, mode: racing poll, userfaults: 405 missing (88+77+59+59+44=
+26+32+20+=08)=20
# # bounces: 9, mode: rnd poll, userfaults: 933 missing (177+173+134+114+10=
1+104+68+62+=08)=20
# # bounces: 8, mode: poll, userfaults: 1329 missing (319+271+253+224+85+82=
+83+12+=08)=20
# # bounces: 7, mode: rnd racing ver read, userfaults: 959 missing (179+163=
+153+126+100+90+92+56+=08)=20
# # bounces: 6, mode: racing ver read, userfaults: 427 missing (81+80+60+57=
+43+49+31+26+=08)=20
# # bounces: 5, mode: rnd ver read, userfaults: 954 missing (201+175+152+11=
2+107+98+60+49+=08)=20
# # bounces: 4, mode: ver read, userfaults: 815 missing (171+131+115+115+86=
+81+63+53+=08)=20
# # bounces: 3, mode: rnd racing read, userfaults: 933 missing (187+152+140=
+137+105+91+62+59+=08)=20
# # bounces: 2, mode: racing read, userfaults: 415 missing (87+67+70+59+44+=
35+33+20+=08)=20
# # bounces: 1, mode: rnd read, userfaults: 933 missing (166+165+151+124+95=
+96+85+51+=08)=20
# # bounces: 0, mode: read, userfaults: 652 missing (117+103+112+65+80+76+5=
6+43+=08)=20
# # [PASS]
# ok 18 uffd-stress shmem 20 16
# # -unnin--./uffd-st-ess-s-mem---iv-te-20-16
# # running ./uffd-stress shmem-private 20 16
# # -unnin--./uffd-st-ess-s-mem---iv-te-20-16
# # nr_pages: 5120, nr_pages_per_cpu: 640
# # bounces: 15, mode: rnd racing ver poll, userfaults: 955 missing (178+17=
3+160+118+90+110+64+62+=08)=20
# # bounces: 14, mode: racing ver poll, userfaults: 400 missing (86+70+48+5=
3+43+38+34+28+=08)=20
# # bounces: 13, mode: rnd ver poll, userfaults: 1037 missing (184+190+163+=
141+121+73+102+63+=08)=20
# # bounces: 12, mode: ver poll, userfaults: 725 missing (155+104+97+87+89+=
68+62+63+=08)=20
# # bounces: 11, mode: rnd racing poll, userfaults: 986 missing (187+180+16=
4+154+97+69+74+61+=08)=20
# # bounces: 10, mode: racing poll, userfaults: 372 missing (82+66+68+43+34=
+28+31+20+=08)=20
# # bounces: 9, mode: rnd poll, userfaults: 891 missing (173+147+152+121+99=
+95+61+43+=08)=20
# # bounces: 8, mode: poll, userfaults: 670 missing (131+110+96+84+81+67+53=
+48+=08)=20
# # bounces: 7, mode: rnd racing ver read, userfaults: 1578 missing (866+16=
3+141+106+94+72+70+66+=08)=20
# # bounces: 6, mode: racing ver read, userfaults: 414 missing (79+75+66+55=
+44+48+22+25+=08)=20
# # bounces: 5, mode: rnd ver read, userfaults: 886 missing (190+151+139+10=
7+97+92+72+38+=08)=20
# # bounces: 4, mode: ver read, userfaults: 928 missing (171+147+114+123+10=
8+100+87+78+=08)=20
# # bounces: 3, mode: rnd racing read, userfaults: 909 missing (181+159+138=
+139+106+81+57+48+=08)=20
# # bounces: 2, mode: racing read, userfaults: 398 missing (89+67+55+56+42+=
40+27+22+=08)=20
# # bounces: 1, mode: rnd read, userfaults: 988 missing (160+176+177+126+12=
7+91+68+63+=08)=20
# # bounces: 0, mode: read, userfaults: 614 missing (127+94+79+75+68+67+46+=
58+=08)=20
# # [PASS]
# ok 19 uffd-stress shmem-private 20 16
# # -unnin--./com--ction_test
# # running ./compaction_test
# # -unnin--./com--ction_test
# # TAP version 13
# # 1..1
# # # Number of huge pages allocated =3D 848
# # ok 1 check_compaction
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 20 compaction_test
# # SKIP ./on-fault-limit
# # -unnin--./m--_-o-ul-te
# # running ./map_populate
# # -unnin--./m--_-o-ul-te
# # TAP version 13
# # 1..2
# # ok 1 MAP_POPULATE COW private page
# # ok 2 The mapping state
# # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 21 map_populate
# # -unnin--./mlock---ndom-test
# # running ./mlock-random-test
# # -unnin--./mlock---ndom-test
# # TAP version 13
# # 1..2
# # ok 1 test_mlock_within_limit
# # ok 2 test_mlock_outof_limit
# # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 22 mlock-random-test
# # -unnin--./mlock2-tests
# # running ./mlock2-tests
# # -unnin--./mlock2-tests
# # TAP version 13
# # 1..13
# # ok 1 test_mlock_lock: Locked
# # ok 2 test_mlock_lock: Locked
# # ok 3 test_mlock_onfault: VMA marked for lock on fault
# # ok 4 VMA open lock after fault
# # ok 5 test_munlockall0: Locked memory area
# # ok 6 test_munlockall0: No locked memory
# # ok 7 test_munlockall1: VMA marked for lock on fault
# # ok 8 test_munlockall1: Unlocked
# # ok 9 test_munlockall1: Locked
# # ok 10 test_munlockall1: No locked memory
# # ok 11 VMA with present pages is not marked lock on fault
# # ok 12 test_vma_management call_mlock 1
# # ok 13 test_vma_management call_mlock 0
# # # Totals: pass:13 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 23 mlock2-tests
# # -unnin--./m-ele-se_test
# # running ./mrelease_test
# # -unnin--./m-ele-se_test
# # TAP version 13
# # 1..1
# # ok 1 Success reaping a child with 1MB of memory allocations
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 24 mrelease_test
# # -unnin--./m-em--_test
# # running ./mremap_test
# # -unnin--./m-em--_test
# # # Test configs:
# # 	threshold_mb=3D4
# # 	pattern_seed=3D1712296164
# #=20
# # 1..19
# # # mremap failed: Invalid argument
# # ok 1 # XFAIL mremap - Source and Destination Regions Overlapping
# # 	Expected mremap failure
# # # mremap failed: Invalid argument
# # ok 2 # XFAIL mremap - Destination Address Misaligned (1KB-aligned)
# # 	Expected mremap failure
# # # Failed to map source region: Invalid argument
# # ok 3 # XFAIL mremap - Source Address Misaligned (1KB-aligned)
# # 	Expected mremap failure
# # ok 4 8KB mremap - Source PTE-aligned, Destination PTE-aligned
# # 	mremap time:      2646330ns
# # ok 5 2MB mremap - Source 1MB-aligned, Destination PTE-aligned
# # 	mremap time:      3390760ns
# # ok 6 2MB mremap - Source 1MB-aligned, Destination 1MB-aligned
# # 	mremap time:      2931770ns
# # ok 7 4MB mremap - Source PMD-aligned, Destination PTE-aligned
# # 	mremap time:      6104990ns
# # ok 8 4MB mremap - Source PMD-aligned, Destination 1MB-aligned
# # 	mremap time:      4501050ns
# # ok 9 4MB mremap - Source PMD-aligned, Destination PMD-aligned
# # 	mremap time:      2425660ns
# # ok 10 2GB mremap - Source PUD-aligned, Destination PTE-aligned
# # ok 11 2GB mremap - Source PUD-aligned, Destination 1MB-aligned
# # ok 12 2GB mremap - Source PUD-aligned, Destination PMD-aligned
# # ok 13 2GB mremap - Source PUD-aligned, Destination PUD-aligned
# # ok 14 5MB mremap - Source 1MB-aligned, Destination 1MB-aligned
# # ok 15 5MB mremap - Source 1MB-aligned, Dest 1MB-aligned with 40MB Pream=
ble
# # ok 16 mremap expand merge
# # ok 17 mremap expand merge offset
# # ok 18 mremap mremap move within range
# # ok 19 mremap move 1mb from start at 1MB+256KB aligned src
# # # Totals: pass:16 fail:0 xfail:3 xpass:0 skip:0 error:0
# # [PASS]
# ok 25 mremap_test
# # -unnin--./t-u-e--en
# # running ./thuge-gen
# # -unnin--./t-u-e--en
# # TAP version 13
# # # Found 1024MB
# # # SKIP for size 1024 MB as not enough huge pages, need 4
# # # Found 0MB
# # # SKIP for size 2 MB as not enough huge pages, need 4
# # # Found 0MB
# # # SKIP for size 32 MB as not enough huge pages, need 4
# # # Found 0MB
# # # SKIP for size 0 MB as not enough huge pages, need 4
# # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 26 thuge-gen
# # -unnin--./c----e_-ese-ved_-u-etlb.s---c--ou--v2
# # running ./charge_reserved_hugetlb.sh -cgroup-v2
# # -unnin--./c----e_-ese-ved_-u-etlb.s---c--ou--v2
# # mount: /dev/cgroup/memory: mount point does not exist.
# #        dmesg(1) may have more information after failed mount system cal=
l.
# # [FAIL]
# not ok 27 charge_reserved_hugetlb.sh -cgroup-v2 # exit=3D32
# # -unnin--./-u-etlb_-e---entin-_test.s---c--ou--v2
# # running ./hugetlb_reparenting_test.sh -cgroup-v2
# # -unnin--./-u-etlb_-e---entin-_test.s---c--ou--v2
# # mount: /dev/cgroup/memory: mount point does not exist.
# #        dmesg(1) may have more information after failed mount system cal=
l.
# # [FAIL]
# not ok 28 hugetlb_reparenting_test.sh -cgroup-v2 # exit=3D32
# # -unnin--./vi-tu-l_-dd-ess_--n-e
# # running ./virtual_address_range
# # -unnin--./vi-tu-l_-dd-ess_--n-e
# # TAP version 13
# # 1..1
# # ok 1 Test
# # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 29 virtual_address_range
# # -unnin--b-s--./v-_-i--_-dd-_switc-.s-
# # running bash ./va_high_addr_switch.sh
# # -unnin--b-s--./v-_-i--_-dd-_switc-.s-
# # [SKIP]
# ok 30 va_high_addr_switch.sh # SKIP
# # -unnin--b-s--./test_vm-lloc.s--smoke
# # running bash ./test_vmalloc.sh smoke
# # -unnin--b-s--./test_vm-lloc.s--smoke
# # ./test_vmalloc.sh: You must have the following enabled in your kernel:
# # CONFIG_TEST_VMALLOC=3Dm
# # [SKIP]
# ok 31 test_vmalloc.sh smoke # SKIP
# # -unnin--./m-em--_dontunm--
# # running ./mremap_dontunmap
# # -unnin--./m-em--_dontunm--
# # TAP version 13
# # 1..5
# # ok 1 mremap_dontunmap_simple
# # ok 2 mremap_dontunmap_simple_shmem
# # ok 3 mremap_dontunmap_simple_fixed
# # ok 4 mremap_dontunmap_partial_mapping
# # ok 5 mremap_dontunmap_partial_mapping_overwrite
# # # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [PASS]
# ok 32 mremap_dont
--O5ZNHbF7ZFbQXwhl--

