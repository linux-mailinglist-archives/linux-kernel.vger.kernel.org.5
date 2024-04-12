Return-Path: <linux-kernel+bounces-142214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DE8A28F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C581F22E29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B74F613;
	Fri, 12 Apr 2024 08:12:00 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229894EB3F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909519; cv=none; b=FlzQ3TlvZ2n7koR5Qj859BvjCnQmzBh8Lhj8vzXu1n+h/jcy496Q66rrYTQrUfFsbQHnWVFjvEdc+vMEPyUs+3pyXiXgN9/buTj7R2YKvECSgZIAcQmzr4X0YeWHCN786FZRmrCXAEauS1PrVC+LH5pQy6v8FXvj1HpauYDxh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909519; c=relaxed/simple;
	bh=5hrwS29GFt3XJfU0QDTV4KVkh+UhqkRrHM14sTWKxWE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VvnFoAURNWTVWi6lMfwkbPkPHYolfrRoL3kzMKRNi6xeHs3pOlKjQgpID0aeMECVuWT7ieZk2sDzoyZSdOSKpzjHuJzDQ/PGq/iS4bPp+CzuRKoVUQnO3sd/X7FI1y89m5GXd/H43nzfvDjDX48VZ4NsVjBOMVGbfrN4LDTaVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VG8ND4QFzz2NW71;
	Fri, 12 Apr 2024 16:09:00 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 03CAB180060;
	Fri, 12 Apr 2024 16:11:54 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 16:11:53 +0800
Subject: Re: [PATCH v2] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>
CC: <naoya.horiguchi@nec.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240412025754.1897615-1-linmiaohe@huawei.com>
 <48647e5b-d15b-457b-9879-fb1b6bbaee27@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8d186776-f3b1-5d9a-2f94-fa249dee7d5f@huawei.com>
Date: Fri, 12 Apr 2024 16:11:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <48647e5b-d15b-457b-9879-fb1b6bbaee27@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/12 11:12, Sidhartha Kumar wrote:
> On 4/11/24 7:57 PM, Miaohe Lin wrote:
>> When I did hard offline test with hugetlb pages, below deadlock occurs:
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.8.0-11409-gf6cef5f8c37f #1 Not tainted
>> ------------------------------------------------------
>> bash/46904 is trying to acquire lock:
>> ffffffffabe68910 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_dec+0x16/0x60
>>
>> but task is already holding lock:
>> ffffffffabf92ea8 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x16/0x40
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (pcp_batch_high_lock){+.+.}-{3:3}:
>>         __mutex_lock+0x6c/0x770
>>         page_alloc_cpu_online+0x3c/0x70
>>         cpuhp_invoke_callback+0x397/0x5f0
>>         __cpuhp_invoke_callback_range+0x71/0xe0
>>         _cpu_up+0xeb/0x210
>>         cpu_up+0x91/0xe0
>>         cpuhp_bringup_mask+0x49/0xb0
>>         bringup_nonboot_cpus+0xb7/0xe0
>>         smp_init+0x25/0xa0
>>         kernel_init_freeable+0x15f/0x3e0
>>         kernel_init+0x15/0x1b0
>>         ret_from_fork+0x2f/0x50
>>         ret_from_fork_asm+0x1a/0x30
>>
>> -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>>         __lock_acquire+0x1298/0x1cd0
>>         lock_acquire+0xc0/0x2b0
>>         cpus_read_lock+0x2a/0xc0
>>         static_key_slow_dec+0x16/0x60
>>         __hugetlb_vmemmap_restore_folio+0x1b9/0x200
>>         dissolve_free_huge_page+0x211/0x260
>>         __page_handle_poison+0x45/0xc0
>>         memory_failure+0x65e/0xc70
>>         hard_offline_page_store+0x55/0xa0
>>         kernfs_fop_write_iter+0x12c/0x1d0
>>         vfs_write+0x387/0x550
>>         ksys_write+0x64/0xe0
>>         do_syscall_64+0xca/0x1e0
>>         entry_SYSCALL_64_after_hwframe+0x6d/0x75
>>
>> other info that might help us debug this:
>>
>>   Possible unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(pcp_batch_high_lock);
>>                                 lock(cpu_hotplug_lock);
>>                                 lock(pcp_batch_high_lock);
>>    rlock(cpu_hotplug_lock);
>>
>>   *** DEADLOCK ***
>>
>> 5 locks held by bash/46904:
>>   #0: ffff98f6c3bb23f0 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x64/0xe0
>>   #1: ffff98f6c328e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf8/0x1d0
>>   #2: ffff98ef83b31890 (kn->active#113){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1d0
>>   #3: ffffffffabf9db48 (mf_mutex){+.+.}-{3:3}, at: memory_failure+0x44/0xc70
>>   #4: ffffffffabf92ea8 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x16/0x40
>>
>> stack backtrace:
>> CPU: 10 PID: 46904 Comm: bash Kdump: loaded Not tainted 6.8.0-11409-gf6cef5f8c37f #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x68/0xa0
>>   check_noncircular+0x129/0x140
>>   __lock_acquire+0x1298/0x1cd0
>>   lock_acquire+0xc0/0x2b0
>>   cpus_read_lock+0x2a/0xc0
>>   static_key_slow_dec+0x16/0x60
>>   __hugetlb_vmemmap_restore_folio+0x1b9/0x200
>>   dissolve_free_huge_page+0x211/0x260
>>   __page_handle_poison+0x45/0xc0
>>   memory_failure+0x65e/0xc70
>>   hard_offline_page_store+0x55/0xa0
>>   kernfs_fop_write_iter+0x12c/0x1d0
>>   vfs_write+0x387/0x550
>>   ksys_write+0x64/0xe0
>>   do_syscall_64+0xca/0x1e0
>>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
>> RIP: 0033:0x7fc862314887
>> Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>> RSP: 002b:00007fff19311268 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fc862314887
>> RDX: 000000000000000c RSI: 000056405645fe10 RDI: 0000000000000001
>> RBP: 000056405645fe10 R08: 00007fc8623d1460 R09: 000000007fffffff
>> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
>> R13: 00007fc86241b780 R14: 00007fc862417600 R15: 00007fc862416a00
>>
>> In short, below scene breaks the lock dependency chain:
>>
>>   memory_failure
>>    __page_handle_poison
>>     zone_pcp_disable -- lock(pcp_batch_high_lock)
>>     dissolve_free_huge_page
>>      __hugetlb_vmemmap_restore_folio
>>       static_key_slow_dec
>>        cpus_read_lock -- rlock(cpu_hotplug_lock)
>>
>> Fix this by calling drain_all_pages() instead.
>>
>> Fixes: a6b40850c442 ("mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>> Cc: <stable@vger.kernel.org>
>> ---
>> v2:
>>   collect Acked-by tag and extend comment per Oscar. Thanks.
>> ---
>>   mm/memory-failure.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index edd6e114462f..c6750509d74c 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -153,11 +153,21 @@ static int __page_handle_poison(struct page *page)
>>   {
>>       int ret;
>>   -    zone_pcp_disable(page_zone(page));
>> +    /*
>> +     * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
>> +     * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
>> +     * when hugetlb vmemmap optimization is enabled. This will break current lock
>> +     * dependency chain and leads to deadlock.
>> +     * Disabling pcp before dissolving the page was a deterministic approach because
>> +     * we made sure that those pages cannot end up in any PCP list. Draining PCP lists
>> +     * expels those pages to the buddy system, but nothing guarantees that those pages
>> +     * do not get back to a PCP queue if we need to refill those.
>> +     */
>>       ret = dissolve_free_huge_page(page);
> 
> Hi Miaohe,
> 
> I recently sent a patch[1] to convert dissolve_free_huge_page() to folios which changes the function name and the name referenced in the comment so this will conflict with my patch. It's in mm-unstable now, would you be able to rebase to that in a new version?
> 

The version 1 of this patch is in mm-unstable too. So it might be better to send a separate patch to extend the comment.

Thanks.
.

> Thanks,
> Sid
> 
> [1] https://lore.kernel.org/linux-mm/20240411164756.261178-1-sidhartha.kumar@oracle.com/T/#u
> 
> 
>> -    if (!ret)
>> +    if (!ret) {
>> +        drain_all_pages(page_zone(page));
>>           ret = take_page_off_buddy(page);
>> -    zone_pcp_enable(page_zone(page));
>> +    }
>>         return ret;
>>   }
> 
> .


