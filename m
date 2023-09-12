Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C397279D5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjILQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbjILQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:05:27 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A2D1726
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:05:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 809706015F;
        Tue, 12 Sep 2023 18:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1694534716; bh=Z8Gm8EEDA9utCugsFuIdFkdNNYonTkF+l+YPI0j5134=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OhB6NQZ+zWF68IVRyh19n5yULqmQcDiqoq/AXbz+TvdR6qOfQ/KGYM3e7BxqN5+pv
         MbhKxDpwgj8eTUd509R6t37/pb460rLEBZjnuo78V7Go09lfaspQnHqdB2GFmQbetq
         s17uwLh/f0a2VzbqV8Pw5lkG8Hzph3BE0scGZD7aBAL7ftOHLaLv0Mor05sMLzrTN+
         AkV8ufUzUrimp7C85ijCMul0SuyrFwZIpfDBrVOVcVR+DOZTnAP0JtF4ScAMEfrbZQ
         l5fYZE1jjllteNuyviSvgigKCKeSZ/mWdwQgzZ5IolkEF7g3f0fgM7s58mObQFM55r
         SUpyehJj621sg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 154C-awrRPcd; Tue, 12 Sep 2023 18:05:13 +0200 (CEST)
Received: from [192.168.1.6] (78-0-136-152.adsl.net.t-com.hr [78.0.136.152])
        by domac.alu.hr (Postfix) with ESMTPSA id 4987E6013C;
        Tue, 12 Sep 2023 18:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1694534713; bh=Z8Gm8EEDA9utCugsFuIdFkdNNYonTkF+l+YPI0j5134=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=2PA71VFdnCePXG8CcGpiSgsaCgg3sfbsLtprMDjYa1fFBWU+3gaiI8Ww1MIGPjJFY
         BQKCTDcFk5wiPOe+RKYErdmAoHRle9ra0ItVdqwVKD9ATBZn2k3AuqLO8R/Y2240ys
         Gf1G+QgaWg30tCh122GSUGCJ9HNC4QM24W0olYK4D2dBXCqGfUsQs9hz6PMbhmRg1A
         /p0fbW49clgy61EZDFRqQInjt4x7GOFCrUNM8gWxn8JDcHrdLe3PA1T2K3IyR1QDJ+
         +OGcWujRdU5GTZh5MMYWXJhdGmzzg0XEK/IM7fng9nQtWMN2OCQr3sjjcqpveO2Sgv
         8PbhD6qa7Ky2A==
Message-ID: <70e2400d-cc0c-14fb-61b7-9aa424b0e975@alu.unizg.hr>
Date:   Tue, 12 Sep 2023 18:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
 <ZPCpQQVTtlB0FA5A@casper.infradead.org>
 <ZPs8+sLv5oaubrKj@casper.infradead.org>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZPs8+sLv5oaubrKj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/23 17:25, Matthew Wilcox wrote:
> On Thu, Aug 31, 2023 at 03:52:49PM +0100, Matthew Wilcox wrote:
>>>   read to 0xffffef9a44978bc0 of 8 bytes by task 348 on cpu 12:
>>>   folio_batch_move_lru (./include/linux/mm.h:1814 ./include/linux/mm.h:1824 ./include/linux/memcontrol.h:1636 ./include/linux/memcontrol.h:1659 mm/swap.c:216)
>>>   folio_batch_add_and_move (mm/swap.c:235)
>>>   folio_add_lru (./arch/x86/include/asm/preempt.h:95 mm/swap.c:518)
>>>   folio_add_lru_vma (mm/swap.c:538)
>>>   do_anonymous_page (mm/memory.c:4146)
>>
>> This is the part I don't understand.  The path to calling
>> folio_add_lru_vma() comes directly from vma_alloc_zeroed_movable_folio():
>>
> [snip]
>>
>> (sorry that's a lot of lines).  But there's _nowhere_ there that sets
>> PG_locked.  It's a freshly allocated page; all page flags (that are
>> actually flags; ignore the stuff up at the top) should be clear.  We
>> even check that with PAGE_FLAGS_CHECK_AT_PREP.  Plus, it doesn't
>> make sense that we'd start I/O; the page is freshly allocated, full of
>> zeroes; there's no backing store to read the page from.
>>
>> It really feels like this page was freed while it was still under I/O
>> and it's been reallocated to this victim process.
>>
>> I'm going to try a few things and see if I can figure this out.
> 
> I'm having trouble reproducing this.  Can you get it to happen reliably?
> 
> This is what I'm currently running with, and it doesn't trigger.
> I'd expect it to if we were going to hit the KCSAN bug.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0c5be12f9336..d22e8798c326 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4439,6 +4439,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
>   	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
>   
>   out:
> +	VM_BUG_ON_PAGE(page && (page->flags & (PAGE_FLAGS_CHECK_AT_PREP &~ (1 << PG_head))), page);
>   	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>   	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
>   		__free_pages(page, order);

Hello, Mr. Matthew,

I have applied your patch to 6.6-rc1 torvalds tree vanilla kernel, and so far there was not KCSAN
report on folio_batch_move_lru() repeated. :-/

I realise that it would be good if this is made reproducible, so I will try a couple of other things ...

I am not that familiar with the memory management core, so you should probably tell me what to expect.

So far I got the best match (but probably unrelated) from this KCSAN report
(from secondary_startup_64_no_verify() to bio_endio() the stacktrace is the same):

[   72.708078] ==================================================================
[   72.708094] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked

[   72.708113] write to 0xffff888105d5dd90 of 8 bytes by interrupt on cpu 19:
[   72.708123] xas_clear_mark (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/bitops.h:178 /home/marvin/linux/kernel/torvalds2/./include/asm-generic/bitops/instrumented-non-atomic.h:115 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:102 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:914)
[   72.708134] __xa_clear_mark (/home/marvin/linux/kernel/torvalds2/lib/xarray.c:1929)
[   72.708143] __folio_end_writeback (/home/marvin/linux/kernel/torvalds2/mm/page-writeback.c:2960)
[   72.708155] folio_end_writeback (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:1613)
[   72.708164] end_page_writeback (/home/marvin/linux/kernel/torvalds2/mm/folio-compat.c:28)
[   72.708175] btrfs_page_clear_writeback (/home/marvin/linux/kernel/torvalds2/fs/btrfs/subpage.c:646) btrfs
[   72.708758] extent_buffer_write_end_io (/home/marvin/linux/kernel/torvalds2/./include/linux/bio.h:84 /home/marvin/linux/kernel/torvalds2/fs/btrfs/extent_io.c:1622) btrfs
[   72.709343] __btrfs_bio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:120) btrfs
[   72.709921] btrfs_orig_bbio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:164) btrfs
[   72.710521] btrfs_orig_write_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:420) btrfs
[   72.711118] bio_endio (/home/marvin/linux/kernel/torvalds2/block/bio.c:1603)
[   72.711128] blk_mq_end_request_batch (/home/marvin/linux/kernel/torvalds2/block/blk-mq.c:851 /home/marvin/linux/kernel/torvalds2/block/blk-mq.c:1089)
[   72.711139] nvme_pci_complete_batch (/home/marvin/linux/kernel/torvalds2/drivers/nvme/host/pci.c:986) nvme
[   72.711185] nvme_irq (/home/marvin/linux/kernel/torvalds2/drivers/nvme/host/pci.c:1086) nvme
[   72.711226] __handle_irq_event_percpu (/home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:158)
[   72.711239] handle_irq_event (/home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:195 /home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:210)
[   72.711251] handle_edge_irq (/home/marvin/linux/kernel/torvalds2/kernel/irq/chip.c:833)
[   72.711262] __common_interrupt (/home/marvin/linux/kernel/torvalds2/./include/linux/irqdesc.h:161 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:238 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:257)
[   72.711272] common_interrupt (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:247 (discriminator 14))
[   72.711282] asm_common_interrupt (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/idtentry.h:636)
[   72.711292] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:291)
[   72.711301] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
[   72.711309] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
[   72.711320] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
[   72.711328] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
[   72.711337] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
[   72.711349] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)

[   72.711366] read to 0xffff888105d5dd90 of 8 bytes by task 555 on cpu 17:
[   72.711377] xas_find_marked (/home/marvin/linux/kernel/torvalds2/./include/linux/xarray.h:1724 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:1354)
[   72.711387] filemap_get_folios_tag (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:1978 /home/marvin/linux/kernel/torvalds2/mm/filemap.c:2266)
[   72.711396] __filemap_fdatawait_range (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:516)
[   72.711405] filemap_fdatawait_range (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:553)
[   72.711414] __btrfs_wait_marked_extents.isra.0 (/home/marvin/linux/kernel/torvalds2/fs/btrfs/transaction.c:1150) btrfs
[   72.712027] btrfs_write_and_wait_transaction (/home/marvin/linux/kernel/torvalds2/fs/btrfs/transaction.c:1169 /home/marvin/linux/kernel/torvalds2/fs/btrfs/transaction.c:1218) btrfs
[   72.712639] btrfs_commit_transaction (/home/marvin/linux/kernel/torvalds2/fs/btrfs/transaction.c:2500) btrfs
[   72.713251] transaction_kthread (/home/marvin/linux/kernel/torvalds2/fs/btrfs/disk-io.c:1537) btrfs
[   72.713856] kthread (/home/marvin/linux/kernel/torvalds2/kernel/kthread.c:388)
[   72.713865] ret_from_fork (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/process.c:147)
[   72.713876] ret_from_fork_asm (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:312)

[   72.713889] value changed: 0x0f00c00fff000000 -> 0x0000000fff000000

[   72.713903] Reported by Kernel Concurrency Sanitizer on:
[   72.713910] CPU: 17 PID: 555 Comm: btrfs-transacti Tainted: G             L     6.6.0-rc1-kcsan-dirty #2
[   72.713920] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[   72.713927] ==================================================================

However, I have upgraded to 6.6-rc1 torvalds tree kernel in the meantime.

If you want me, I could test with the 6.5 + your patch.

Best regards,
Mirsad Todorovac
