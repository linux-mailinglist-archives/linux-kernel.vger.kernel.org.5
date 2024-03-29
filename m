Return-Path: <linux-kernel+bounces-124148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB393891301
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C251C2401D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D13B78B;
	Fri, 29 Mar 2024 04:54:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A13B185
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688079; cv=none; b=e3C66Va59f8oHZMFJO/MX/fW16r5mtN2iMiQy0akIcwkPszkaRyuTklgI/4odOEYYGhyxw5Imfd+r7TdyPncautZAUfj1LXfJNo8RzXEQz78DkpEAaDI7Qu+9rjOxOE9qQwZDivi7s/cK2tiTH73/7vAVQOipRWjw808/1VocEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688079; c=relaxed/simple;
	bh=shau2gOK93tUJtpm23RsS/oOlWAfMWvYVQGoLRHQUL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qIP+3olbGlOqzpzYTfNNUOyj7CBNsYoWfp61gjYfiNraTBeFeGyRBeKTRVQwJxb0sq6kP+8q4HGMBPayn4DdICjaR+xaKvP5t27Bdx59Ni/PwVVeCpCjPqSq7x51BZwEE1rOMnQFxv/4zNtktPpeH5NBJN0CQvDo2WKe91xJOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V5SgC0MnKz1h4QJ;
	Fri, 29 Mar 2024 12:51:51 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id EBE65140336;
	Fri, 29 Mar 2024 12:54:31 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 12:54:31 +0800
Message-ID: <74b147b0-718d-4d50-be75-d6afc801cd24@huawei.com>
Date: Fri, 29 Mar 2024 12:54:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] page_owner: Fix refcount imbalance
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Michal Hocko
	<mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Marco Elver
	<elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Alexander
 Potapenko <glider@google.com>
References: <20240326063036.6242-1-osalvador@suse.de>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240326063036.6242-1-osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/3/26 14:30, Oscar Salvador wrote:
> This series consists of a refactoring/correctness of updating the metadata
> of tail pages and a couple of fixups for the refcounting part.
> 
>>From this series on, instead of counting the stacks, we count the outstanding
> nr_base_pages each stack has, which gives us a much better memory overview.
> The other fixup is for the migration part.
> 
> A more detailed explanation can be found in the changelog of the respective
> patches.

Hi Oscar, this patchset fix the following issue when I test my migration 
changes, but

[   31.478715] ------------[ cut here ]------------
[   31.480491] refcount_t: decrement hit 0; leaking memory.
[   31.482724] WARNING: CPU: 7 PID: 113 at lib/refcount.c:31 
refcount_warn_saturate+0x13c/0x148
[   31.485390] Modules linked in:
[   31.486800] CPU: 7 PID: 113 Comm: sh Not tainted 
6.9.0-rc1-00178-g317c7bc0ef03 #139
[   31.487883] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 
02/06/2015
[   31.489066] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   31.489872] pc : refcount_warn_saturate+0x13c/0x148
[   31.490350] lr : refcount_warn_saturate+0x13c/0x148
[   31.490829] sp : ffff800087913650
[   31.491182] x29: ffff800087913650 x28: ffff00020624d010 x27: 
0000000000000000
[   31.492419] x26: 0000000000000001 x25: ffff800082dd0d60 x24: 
0000000000000000
[   31.493006] x23: 0000000754405c20 x22: ffff800082ec0000 x21: 
00000000028c008e
[   31.493527] x20: ffff0000d1638208 x19: ffff0000d1638200 x18: 
0000000000000010
[   31.493984] x17: 0000000000000006 x16: 0000000000000000 x15: 
ffff0000c6253c18
[   31.494330] x14: 0000000000000000 x13: 0000000000000002 x12: 
ffff800082dff318
[   31.494669] x11: ffff800082e6f640 x10: ffff800082e57600 x9 : 
ffff80008015869c
[   31.495056] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 
0000000000000001
[   31.495383] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 
0000000000000000
[   31.495756] x2 : ffff800082dff228 x1 : 0000000000000000 x0 : 
0000000000000000
[   31.496367] Call trace:
[   31.496528]  refcount_warn_saturate+0x13c/0x148
[   31.496760]  __reset_page_owner+0x124/0x158
[   31.496965]  free_unref_page_prepare+0x2a4/0x440
[   31.497183]  free_unref_folios+0x118/0x460
[   31.497368]  folios_put_refs+0x11c/0x250
[   31.497559]  free_pages_and_swap_cache+0xd4/0x160
[   31.497772]  tlb_flush_mmu+0x8c/0x188
[   31.497952]  tlb_finish_mmu+0x54/0x160
[   31.498123]  exit_mmap+0x174/0x4e8
[   31.498295]  mmput+0xb4/0x1a0
[   31.498429]  begin_new_exec+0x474/0xd30
[   31.498606]  load_elf_binary+0x378/0x1488
[   31.498792]  bprm_execve+0x2a0/0x7e0
[   31.498956]  do_execveat_common.isra.0+0x19c/0x240
[   31.499174]  __arm64_sys_execve+0x48/0x68
[   31.499358]  invoke_syscall+0x4c/0x118
[   31.499534]  el0_svc_common.constprop.0+0x48/0xf0
[   31.499816]  do_el0_svc+0x24/0x38
[   31.500063]  el0_svc+0x4c/0x120
[   31.500314]  el0t_64_sync_handler+0xc0/0xc8
[   31.500584]  el0t_64_sync+0x190/0x198

I still see the following memory leak, could you check it?

/mnt/arm64 # cat /sys//kernel/debug/kmemleak
unreferenced object 0xffff000200d91000 (size 16):
   comm "kworker/4:0", pid 42, jiffies 4294892753
   hex dump (first 16 bytes):
     60 37 57 c1 00 00 ff ff 00 00 00 00 00 00 00 00  `7W.............
   backtrace (crc 4458f477):
     [<(____ptrval____)>] kmemleak_alloc+0x3c/0x50
     [<(____ptrval____)>] kmalloc_trace+0x20c/0x2e0
     [<(____ptrval____)>] __set_page_owner+0x1d0/0x2a0
     [<(____ptrval____)>] prep_new_page+0x108/0x138
     [<(____ptrval____)>] get_page_from_freelist+0x79c/0x16b8
     [<(____ptrval____)>] __alloc_pages+0x1bc/0x440
     [<(____ptrval____)>] new_slab+0x104/0x3c8
     [<(____ptrval____)>] ___slab_alloc+0x368/0xb20
     [<(____ptrval____)>] __slab_alloc.isra.0+0x3c/0x88
     [<(____ptrval____)>] kmalloc_trace+0x280/0x2e0
     [<(____ptrval____)>] __set_page_owner+0x1d0/0x2a0
     [<(____ptrval____)>] prep_new_page+0x108/0x138
     [<(____ptrval____)>] get_page_from_freelist+0x79c/0x16b8
     [<(____ptrval____)>] __alloc_pages+0x1bc/0x440
     [<(____ptrval____)>] new_slab+0x104/0x3c8
     [<(____ptrval____)>] ___slab_alloc+0x368/0xb20
unreferenced object 0xffff000200d90000 (size 16):
   comm "kworker/4:0", pid 42, jiffies 4294892753
   hex dump (first 16 bytes):
     20 38 57 c1 00 00 ff ff 00 10 d9 00 02 00 ff ff   8W.............
   backtrace (crc 786eca4d):
     [<(____ptrval____)>] kmemleak_alloc+0x3c/0x50
     [<(____ptrval____)>] kmalloc_trace+0x20c/0x2e0
     [<(____ptrval____)>] __set_page_owner+0x1d0/0x2a0
     [<(____ptrval____)>] prep_new_page+0x108/0x138
     [<(____ptrval____)>] get_page_from_freelist+0x79c/0x16b8
     [<(____ptrval____)>] __alloc_pages+0x1bc/0x440
     [<(____ptrval____)>] new_slab+0x104/0x3c8
     [<(____ptrval____)>] ___slab_alloc+0x368/0xb20
     [<(____ptrval____)>] __slab_alloc.isra.0+0x3c/0x88
     [<(____ptrval____)>] kmalloc_node_trace+0x274/0x2f0
     [<(____ptrval____)>] alloc_worker+0x2c/0x70
     [<(____ptrval____)>] create_worker+0x58/0x278
     [<(____ptrval____)>] worker_thread+0x260/0x320
     [<(____ptrval____)>] kthread+0x130/0x148
     [<(____ptrval____)>] ret_from_fork+0x10/0x20
unreferenced object 0xffff000200d90010 (size 16):
   comm "kworker/4:0", pid 42, jiffies 4294892753
   hex dump (first 16 bytes):
     e0 39 57 c1 00 00 ff ff 00 00 d9 00 02 00 ff ff  .9W.............
   backtrace (crc d4c89665):
     [<(____ptrval____)>] kmemleak_alloc+0x3c/0x50
     [<(____ptrval____)>] kmalloc_trace+0x20c/0x2e0
     [<(____ptrval____)>] __set_page_owner+0x1d0/0x2a0
     [<(____ptrval____)>] prep_new_page+0x108/0x138
     [<(____ptrval____)>] get_page_from_freelist+0x79c/0x16b8
     [<(____ptrval____)>] __alloc_pages+0x1bc/0x440
     [<(____ptrval____)>] new_slab+0x104/0x3c8
     [<(____ptrval____)>] ___slab_alloc+0x368/0xb20
     [<(____ptrval____)>] __slab_alloc.isra.0+0x3c/0x88
     [<(____ptrval____)>] kmalloc_trace+0x280/0x2e0
     [<(____ptrval____)>] __kthread_create_on_node+0x7c/0x190
     [<(____ptrval____)>] kthread_create_on_node+0x60/0x90
     [<(____ptrval____)>] create_worker+0xd0/0x278
     [<(____ptrval____)>] worker_thread+0x260/0x320
     [<(____ptrval____)>] kthread+0x130/0x148
     [<(____ptrval____)>] ret_from_fork+0x10/0x20

Thanks.

> 
> Oscar Salvador (3):
>    mm,page_owner: Update metada for tail pages
>    mm,page_owner: Fix refcount imbalance
>    mm,page_owner: Fix accounting of pages when migrating
> 
>   Documentation/mm/page_owner.rst |  73 +++++++------
>   mm/page_owner.c                 | 184 +++++++++++++++++++-------------
>   2 files changed, 146 insertions(+), 111 deletions(-)
> 

