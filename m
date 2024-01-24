Return-Path: <linux-kernel+bounces-36706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3042583A54C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36892901F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75CA1862A;
	Wed, 24 Jan 2024 09:22:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9518EA5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088136; cv=none; b=CZ4MwAs4DblzK2vx4VzwHetOGyULJ69zPTtS5J8ZOZ2j3TdxbCCCmMlIXtqTM8rywhKI57+WG08tSPX3XeUE5NePPx88/5eiTve52rxfYMI8mSIvzOcwRZogaqd3CoLVqywSYNXuIki+FsmN4TbQZQOjAnAwSpH6ngTjYRJAo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088136; c=relaxed/simple;
	bh=vLAI9684/Q4X22lce6BqN9QMtQIvqKY8BpDhB63fPjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAdiUF4JeedAUkRHCF0gKwERbN3rlZBllDIf186HIZIfoUUtjk3kgjC9l5/ajkFrUbg9sEgbq77CYo7gCK2hxNbLP7p0MQSpsE9KXeLdb3wx/urWjwnjswZo224+u4Kd1u9imUeW13MJcHcEVHCSk+CApcP77USkFsUlmDLvtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7693F1FB;
	Wed, 24 Jan 2024 01:22:56 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4EC3F762;
	Wed, 24 Jan 2024 01:22:05 -0800 (PST)
Message-ID: <7a0d92a9-f28c-4f3c-b956-1157e614dcbe@arm.com>
Date: Wed, 24 Jan 2024 09:22:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/hugetlb: Restore the reservation if needed
Content-Language: en-GB
To: Breno Leitao <leitao@debian.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: lstoakes@gmail.com, willy@infradead.org, mike.kravetz@oracle.com,
 Rik van Riel <riel@surriel.com>,
 "open list:HUGETLB SUBSYSTEM" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240117171058.2192286-1-leitao@debian.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240117171058.2192286-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 17:10, Breno Leitao wrote:
> Currently there is a bug that a huge page could be stolen, and when the
> original owner tries to fault in it, it causes a page fault.
> 
> You can achieve that by:
>   1) Creating a single page
> 	echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> 
>   2) mmap() the page above with MAP_HUGETLB into (void *ptr1).
> 	* This will mark the page as reserved
>   3) touch the page, which causes a page fault and allocates the page
> 	* This will move the page out of the free list.
> 	* It will also unreserved the page, since there is no more free
> 	  page
>   4) madvise(MADV_DONTNEED) the page
> 	* This will free the page, but not mark it as reserved.
>   5) Allocate a secondary page with mmap(MAP_HUGETLB) into (void *ptr2).
> 	* it should fail, but, since there is no more available page.
> 	* But, since the page above is not reserved, this mmap() succeed.
>   6) Faulting at ptr1 will cause a SIGBUS
> 	* it will try to allocate a huge page, but there is none
> 	  available
> 
> A full reproducer is in selftest. See
> https://lore.kernel.org/all/20240105155419.1939484-1-leitao@debian.org/
> 
> Fix this by restoring the reserved page if necessary. If the page being
> unmapped has HPAGE_RESV_OWNER set, and needs a reservation, set the
> restore_reserve flag, which will move the page from free to reserved.
> 
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/hugetlb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ed1581b670d4..fa2c17767e44 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5677,6 +5677,16 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		hugetlb_count_sub(pages_per_huge_page(h), mm);
>  		hugetlb_remove_rmap(page_folio(page));
>  
> +		if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
> +		    vma_needs_reservation(h, vma, start)) {
> +			/*
> +			 * Restore the reservation if needed, otherwise the
> +			 * backing page could be stolen by someone.
> +			 */
> +			folio_set_hugetlb_restore_reserve(page_folio(page));
> +			vma_add_reservation(h, vma, address);
> +		}
> +
>  		spin_unlock(ptl);
>  		tlb_remove_page_size(tlb, page, huge_page_size(h));
>  		/*

Hi Breno,

I'm seeing a kernel bug fire when running the "map_hugetlb" mm selftest against latest mm-unstable. Bisect tells me this patch is culprit. I'm running on arm64 with defconfig plus the following:

# Woraround mm-unstable build errors.
/scripts/config --file ${param:builddir}/.config --enable ANON_VMA_NAME

# Squashfs for snaps, xfs for large file folios.
/scripts/config --enable CONFIG_SQUASHFS_LZ4
/scripts/config --enable CONFIG_SQUASHFS_LZO
/scripts/config --enable CONFIG_SQUASHFS_XZ
/scripts/config --enable CONFIG_SQUASHFS_ZSTD
/scripts/config --enable CONFIG_XFS_FS

# Useful trace features (on for Ubuntu configs).
/scripts/config --enable CONFIG_FTRACE
/scripts/config --enable CONFIG_FUNCTION_TRACER
/scripts/config --enable CONFIG_KPROBES
/scripts/config --enable CONFIG_HIST_TRIGGERS
/scripts/config --enable CONFIG_FTRACE_SYSCALLS

# For general mm debug.
/scripts/config --enable CONFIG_DEBUG_VM
/scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
/scripts/config --enable CONFIG_DEBUG_VM_RB
/scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
/scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
/scripts/config --enable CONFIG_PAGE_TABLE_CHECK

# For mm selftests.
/scripts/config --enable CONFIG_USERFAULTFD
/scripts/config --enable CONFIG_TEST_VMALLOC
/scripts/config --enable CONFIG_GUP_TEST


Steps to reproduce:

$ sudo ./map_hugetlb


git bisect log:

git bisect start
# good: [6613476e225e090cc9aad49be7fa504e290dd33d] Linux 6.8-rc1
git bisect good 6613476e225e090cc9aad49be7fa504e290dd33d
# bad: [ba34798948c09778ff707415fd52daa591bd361a] mm: add swappiness= arg to memory.reclaim
git bisect bad ba34798948c09778ff707415fd52daa591bd361a
# bad: [69d0e75874638fe852ed7004666e068cf9e2148d] mm: list_lru: disable memcg_aware when cgroup.memory is set to "nokmem"
git bisect bad 69d0e75874638fe852ed7004666e068cf9e2148d
# good: [38c61fca93058635b533ad927c1d6529757424d3] mm: huge_memory: don't force huge page alignment on 32 bit
git bisect good 38c61fca93058635b533ad927c1d6529757424d3
# bad: [552225e31fdc31315d06c5c7f59b8dbc78e45d18] mm: vmalloc: rename adjust_va_to_fit_type() function
git bisect bad 552225e31fdc31315d06c5c7f59b8dbc78e45d18
# bad: [184c8db9112ee2370c2d17efab76a6c2aad061bc] s390/sclp: remove unhandled memory notifier type
git bisect bad 184c8db9112ee2370c2d17efab76a6c2aad061bc
# bad: [7ccaa21733f6a0fefdf978da0ee08a459c8441ca] mm/cma: fix placement of trace_cma_alloc_start/finish
git bisect bad 7ccaa21733f6a0fefdf978da0ee08a459c8441ca
# bad: [be7a8289b10f82365b9a209d9db9e4aaab1a86d4] selftests/mm: run_vmtests.sh: add hugetlb_madv_vs_map
git bisect bad be7a8289b10f82365b9a209d9db9e4aaab1a86d4
# bad: [947b031634e7af3d265275c26ec17e2f96fdb5a1] mm/hugetlb: restore the reservation if needed
git bisect bad 947b031634e7af3d265275c26ec17e2f96fdb5a1
# first bad commit: [947b031634e7af3d265275c26ec17e2f96fdb5a1] mm/hugetlb: restore the reservation if needed


BUG:

[   11.959447] kernel BUG at mm/hugetlb.c:1129!
[   11.959628] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[   11.959870] Modules linked in:
[   11.959975] CPU: 0 PID: 1211 Comm: map_hugetlb Not tainted 6.8.0-rc1-00029-g947b031634e7 #11
[   11.960272] Hardware name: linux,dummy-virt (DT)
[   11.960434] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   11.960680] pc : resv_map_release+0xa8/0xb8
[   11.960895] lr : resv_map_release+0x6c/0xb8
[   11.961041] sp : ffff80008863bb20
[   11.961159] x29: ffff80008863bb20 x28: 0000000000000000 x27: 0000000000000001
[   11.961500] x26: ffff77b80e91a704 x25: 0000000000000001 x24: ffff77b80e91a708
[   11.961740] x23: ffff77b80e91a700 x22: 0000000000000080 x21: 0000000000000000
[   11.961992] x20: ffff77b80e91a720 x19: ffff77b80e91a720 x18: 0000fffff7fecfff
[   11.962239] x17: 0000000000000000 x16: 1fffeef701697601 x15: 0000000000000001
[   11.962484] x14: ffffffffffffffff x13: 0000000000000000 x12: ffffc8c6bc3b3cd0
[   11.962729] x11: 0000000000000001 x10: 0000000000000000 x9 : ffffc8c6bad5245c
[   11.962971] x8 : ffff80008863bae0 x7 : 0000000000000000 x6 : ffff77b801966900
[   11.963285] x5 : ffffc8c6bad6b7e4 x4 : fffffddee1613ea0 x3 : 0000000000400010
[   11.963629] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000007f
[   11.963945] Call trace:
[   11.964070]  resv_map_release+0xa8/0xb8
[   11.964255]  hugetlb_vm_op_close+0x1a0/0x1f0
[   11.964431]  remove_vma+0x34/0x88
[   11.964604]  do_vmi_align_munmap+0x4b8/0x5f0
[   11.964792]  do_vmi_munmap+0xb4/0x138
[   11.964936]  __vm_munmap+0xa8/0x188
[   11.965074]  __arm64_sys_munmap+0x28/0x40
[   11.965237]  invoke_syscall+0x50/0x128
[   11.965388]  el0_svc_common.constprop.0+0x48/0xf0
[   11.965573]  do_el0_svc+0x24/0x38
[   11.965705]  el0_svc+0x34/0xb8
[   11.965862]  el0t_64_sync_handler+0x100/0x130
[   11.966032]  el0t_64_sync+0x190/0x198
[   11.966174] Code: a8c47bfd d50323bf d65f03c0 a9025bf5 (d4210000) 
[   11.966410] ---[ end trace 0000000000000000 ]---
[   11.966594] note: map_hugetlb[1211] exited with irqs disabled
[   11.966874] note: map_hugetlb[1211] exited with preempt_count 1
[   11.967915] ------------[ cut here ]------------
[   11.968165] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop.0+0x108/0x120
[   11.968560] Modules linked in:
[   11.968651] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D            6.8.0-rc1-00029-g947b031634e7 #11
[   11.969235] Hardware name: linux,dummy-virt (DT)
[   11.970045] pstate: 214003c5 (nzCv DAIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   11.970941] pc : ct_kernel_exit.constprop.0+0x108/0x120
[   11.971241] lr : ct_idle_enter+0x10/0x20
[   11.971397] sp : ffffc8c6bd7f3d40
[   11.971527] x29: ffffc8c6bd7f3d40 x28: 000000004224d0ac x27: 0000000000000000
[   11.971811] x26: 0000000000000000 x25: ffffc8c6bd804980 x24: 0000000000000000
[   11.972279] x23: 0000000000000000 x22: ffffc8c6bd804980 x21: ffffc8c6bd7f9ae0
[   11.973023] x20: ffffc8c6bd7f9a20 x19: ffff77b83ff8dce0 x18: 0000000000000001
[   11.973856] x17: 0000000000000000 x16: 1fffeef701697721 x15: 0000fffff7fed000
[   11.975799] x14: ffff80008863b688 x13: 0000000000000000 x12: ffffc8c6bc3b3cd0
[   11.976202] x11: 0000000000000001 x10: fc206bc54f751bff x9 : ffffc8c6bab7f564
[   11.976461] x8 : ffffc8c6bd805a58 x7 : 00000000000001e5 x6 : 00000000119b8986
[   11.976722] x5 : 4000000000000002 x4 : ffffaef18328b000 x3 : ffffc8c6bd7f3d40
[   11.976985] x2 : ffffc8c6bcd02ce0 x1 : 4000000000000000 x0 : ffffc8c6bcd02ce0
[   11.977245] Call trace:
[   11.977338]  ct_kernel_exit.constprop.0+0x108/0x120
[   11.977520]  ct_idle_enter+0x10/0x20
[   11.977654]  default_idle_call+0x3c/0x170
[   11.977804]  do_idle+0x218/0x278
[   11.977942]  cpu_startup_entry+0x40/0x50
[   11.978087]  rest_init+0xf0/0xf8
[   11.978209]  arch_call_rest_init+0x18/0x20
[   11.978391]  start_kernel+0x524/0x670
[   11.978528]  __primary_switched+0xb8/0xc8
[   11.978681] ---[ end trace 0000000000000000 ]---

Thanks,
Ryan


