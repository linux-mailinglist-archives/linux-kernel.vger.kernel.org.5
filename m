Return-Path: <linux-kernel+bounces-17574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 919AC824F91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89A61C22BAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586020B38;
	Fri,  5 Jan 2024 08:14:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052985690
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CA82F4;
	Fri,  5 Jan 2024 00:15:41 -0800 (PST)
Received: from [10.57.76.44] (unknown [10.57.76.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF1A03F5A1;
	Fri,  5 Jan 2024 00:14:53 -0800 (PST)
Message-ID: <1eb61435-c89c-4ca1-b1b6-aa00b3478cd2@arm.com>
Date: Fri, 5 Jan 2024 08:14:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
Content-Language: en-GB
To: Yin Fengwei <fengwei.yin@intel.com>, David Hildenbrand
 <david@redhat.com>,
 syzbot <syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Matthew Wilcox <willy@infradead.org>
References: <000000000000014174060e09316e@google.com>
 <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
 <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
 <36ace74a-1de7-4224-8bc1-7f487764f6e2@redhat.com>
 <8bc02927-a0f0-490a-a014-0e100d30ffe4@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8bc02927-a0f0-490a-a014-0e100d30ffe4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/01/2024 02:20, Yin Fengwei wrote:
> 
> 
> On 2024/1/5 05:36, David Hildenbrand wrote:
>> On 03.01.24 15:16, Yin, Fengwei wrote:
>>>
>>>
>>> On 1/3/2024 8:13 PM, David Hildenbrand wrote:
>>>> On 03.01.24 12:48, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    ab0b3e6ef50d Add linux-next specific files for 20240102
>>>>> git tree:       linux-next
>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17be3e09e80000
>>>>> kernel config:
>>>>> https://syzkaller.appspot.com/x/.config?x=a14a6350374945f9
>>>>> dashboard link:
>>>>> https://syzkaller.appspot.com/bug?extid=50ef73537bbc393a25bb
>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
>>>>> for Debian) 2.40
>>>>> syz repro:
>>>>> https://syzkaller.appspot.com/x/repro.syz?x=14e2256ee80000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b57db5e80000
>>>>>
>>>>> Downloadable assets:
>>>>> disk image:
>>>>> https://storage.googleapis.com/syzbot-assets/4e6376fe5764/disk-ab0b3e6e.raw.xz
>>>>> vmlinux:
>>>>> https://storage.googleapis.com/syzbot-assets/7cb9ecbaf001/vmlinux-ab0b3e6e.xz
>>>>> kernel image:
>>>>> https://storage.googleapis.com/syzbot-assets/2c1a9a6d424f/bzImage-ab0b3e6e.xz
>>>>>
>>>>> The issue was bisected to:
>>>>>
>>>>> commit 68f0320824fa59c5429cbc811e6c46e7a30ea32c
>>>>> Author: David Hildenbrand <david@redhat.com>
>>>>> Date:   Wed Dec 20 22:44:31 2023 +0000
>>>>>
>>>>>       mm/rmap: convert folio_add_file_rmap_range() into
>>>>> folio_add_file_rmap_[pte|ptes|pmd]()
>>>>>
>>>>> bisection log:
>>>>> https://syzkaller.appspot.com/x/bisect.txt?x=10b9e1b1e80000
>>>>> final oops:
>>>>> https://syzkaller.appspot.com/x/report.txt?x=12b9e1b1e80000
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14b9e1b1e80000
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to the
>>>>> commit:
>>>>> Reported-by: syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com
>>>>> Fixes: 68f0320824fa ("mm/rmap: convert folio_add_file_rmap_range()
>>>>> into folio_add_file_rmap_[pte|ptes|pmd]()")
>>>>>
>>>>>    kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
>>>>>    __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:324
>>>>>    kasan_slab_alloc include/linux/kasan.h:201 [inline]
>>>>>    slab_post_alloc_hook mm/slub.c:3813 [inline]
>>>>>    slab_alloc_node mm/slub.c:3860 [inline]
>>>>>    kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
>>>>>    vm_area_alloc+0x1f/0x220 kernel/fork.c:465
>>>>>    mmap_region+0x3ae/0x2a90 mm/mmap.c:2804
>>>>>    do_mmap+0x890/0xef0 mm/mmap.c:1379
>>>>>    vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>>>>    ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>>>>    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>>>>    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>>>>    __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>>>>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>>    do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>>>>    entry_SYSCALL_64_after_hwframe+0x62/0x6a
>>>>> ------------[ cut here ]------------
>>>>> WARNING: CPU: 1 PID: 5059 at include/linux/rmap.h:202
>>>>> __folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>>>>> Modules linked in:
>>>>> CPU: 1 PID: 5059 Comm: syz-executor115 Not tainted
>>>>> 6.7.0-rc8-next-20240102-syzkaller #0
>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>>> BIOS Google 11/17/2023
>>>>> RIP: 0010:__folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>>>>> Code: 41 83 e4 01 44 89 e6 e8 79 bc b7 ff 45 84 e4 0f 85 08 fc ff ff
>>>>> e8 3b c1 b7 ff 48 c7 c6 e0 b5 d9 8a 48 89 df e8 5c 12 f7 ff 90 <0f> 0b
>>>>> 90 e9 eb fb ff ff e8 1e c1 b7 ff be 01 00 00 00 48 89 df e8
>>>>> RSP: 0018:ffffc900038df978 EFLAGS: 00010293
>>>>> RAX: 0000000000000000 RBX: ffffea00008cde00 RCX: ffffffff81687419
>>>>> RDX: ffff88807becbb80 RSI: ffffffff81d06104 RDI: 0000000000000000
>>>>> RBP: ffffea00008cde00 R08: 0000000000000000 R09: fffffbfff1e75f6a
>>>>> R10: ffffffff8f3afb57 R11: 0000000000000001 R12: 0000000000000000
>>>>> R13: 0000000000000001 R14: 0000000000000000 R15: dffffc0000000000
>>>>> FS:  0000555556508380(0000) GS:ffff8880b9900000(0000)
>>>>> knlGS:0000000000000000
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 00000000200000c0 CR3: 0000000079000000 CR4: 00000000003506f0
>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>> Call Trace:
>>>>>    <TASK>
>>>>>    __folio_add_rmap mm/rmap.c:1167 [inline]
>>>>>    __folio_add_file_rmap mm/rmap.c:1452 [inline]
>>>>>    folio_add_file_rmap_ptes+0x8e/0x2c0 mm/rmap.c:1478
>>>>>    insert_page_into_pte_locked.isra.0+0x34d/0x960 mm/memory.c:1874
>>>>>    insert_page mm/memory.c:1900 [inline]
>>>>>    vm_insert_page+0x62c/0x8c0 mm/memory.c:2053
>>>>>    packet_mmap+0x314/0x570 net/packet/af_packet.c:4594
>>>>>    call_mmap include/linux/fs.h:2090 [inline]
>>>>>    mmap_region+0x745/0x2a90 mm/mmap.c:2819
>>>>>    do_mmap+0x890/0xef0 mm/mmap.c:1379
>>>>>    vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>>>>    ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>>>>    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>>>>    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>>>>    __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>>>>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>>    do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>>>>    entry_SYSCALL_64_after_hwframe+0x62/0x6a
>>>>
>>>> If I am not wrong, that triggers:
>>>>
>>>> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>>>>            !folio_test_large_rmappable(folio), folio);
>>>>
>>>> So we are trying to rmap a large folio that did not go through
>>>> folio_prep_large_rmappable().

Would someone mind explaining the rules to me for this? As far as I can see,
folio_prep_large_rmappable() just inits the _deferred_list and sets a flag so we
remember to deinit the list on destruction. Why can't we just init that list for
all folios order-2 or greater? Then everything is rmappable?

>>>>
>>>> net/packet/af_packet.c calls vm_insert_page() on some pages/folios stoed
>>>> in the "struct packet_ring_buffer". No idea where that comes from, but I
>>>> suspect it's simply some compound allocation.
>>> Looks like:
>>>    alloc_pg_vec
>>>      alloc_one_pg_vec_page
>>>           gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
>>>                             __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>>>
>>>           buffer = (char *) __get_free_pages(gfp_flags, order);
>>> So you are right here... :).
>>
>> Hm, but I wonder if this something that's supposed to work or is this one of
>> the cases where we should actually use a VM_PFN mapping?
>>
>> It's not a pagecache(file/shmem) page after all.
>>
>> We could relax that check and document why we expect something that is not
>> marked rmappable. But it fells wrong. I suspect this should be a VM_PFNMAP
>> instead (like recent udmabuf changes).
> 
> VM_PFNMAP looks correct.

And why is making the folio rmappable and mapping it the normal way not the
right solution here? Because the folio could be order-1? Or something more profound?

> 
> I do have another question: why do we just check the large folio
> rmappable? Does that mean order0 folio is always rmappable?
> 
> I ask this because vm_insert_pages() is called in net/ipv4/tcp.c
> and drivers call vm_insert_page. I suppose they all need be VM_PFNMAP.
> 
> There is not warning because we didn't check order0 folio rmappable.
> 
> 
> Regards
> Yin, Fengwei
> 


