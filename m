Return-Path: <linux-kernel+bounces-96033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA487565B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63852817D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7908C134CFC;
	Thu,  7 Mar 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMn1lrGK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798F12B145
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837384; cv=none; b=ariA/JH1tS7nnJhQyp4zqmADmWUidnHybKcO3qN2nMQPp3iJllzjSZUii7OA0u6mb9qQhtoeUg/FWcX2gIOnRKobJFmGT/RfPtd2MXyrULjXyJZ4TVzjlRty6MvUICRp78tsXsO2i/xXS/Di6yOnMonYCTTxzu7pJafetOUfQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837384; c=relaxed/simple;
	bh=ykQKquOaR2edvYuDMHBtq/4PMcMtFtpTs1QQ5b2GUqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vsh8f+UpfJsrOczYEWLwr2X9OF8r/ReSCd5ILkR2Yx/mTwT8enYE60asukGrQxjk/3xyfHtb3E2wCXOLRIfkHIcxgGMh1NpdCx8peDiKtKgPpn/M7txXoTzf3FZBlvJWQPxNdAOKPDzjWCsStapHB9XhFHomdwKWMozB/IdsWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMn1lrGK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709837381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nDojNDkKf/+w07Ua7ePHerjCZuy1kzDe7wvkCm1/Vc=;
	b=DMn1lrGKyXSDMl1b3XOfzqMO6A6xxKHW2rMeiBeRri9lmwkxsJ7o0XbTuIRdK4aM/kCW2a
	Kt9fULstc8+xjQch5dMSqMN5sHGb4RWXhFJy+4UjnAhwaIEYmStmos4HOBBjvyfhoaxHMC
	ydXokmjRrBFlWQRkOr+2wvnWXBncBMc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-6O7iwpoxPm-2Sl5GIXPtCg-1; Thu,
 07 Mar 2024 13:49:40 -0500
X-MC-Unique: 6O7iwpoxPm-2Sl5GIXPtCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B12693C000AD;
	Thu,  7 Mar 2024 18:49:39 +0000 (UTC)
Received: from [10.22.17.9] (unknown [10.22.17.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64A6840C6CB7;
	Thu,  7 Mar 2024 18:49:39 +0000 (UTC)
Message-ID: <43374498-2dd3-4167-ba4e-b0ecc4282860@redhat.com>
Date: Thu, 7 Mar 2024 13:49:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/kmemleak: Don't hold kmemleak_lock when calling
 printk()
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Audra Mitchell <aubaker@redhat.com>
References: <20240307184707.961255-1-longman@redhat.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240307184707.961255-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 3/7/24 13:47, Waiman Long wrote:
> When some error conditions happen (like OOM), some kmemleak functions
> call printk() to dump out some useful debugging information while holding
> the kmemleak_lock. This may cause deadlock as the printk() function
> may need to allocate additional memory leading to a create_object()
> call acquiring kmemleak_lock again.
>
> An abbreviated lockdep splat is as follows:

FYI, The full lockdep splat is

[ 3991.084294] Out of memory: Killed process 30721 (mandb) 
total-vm:38708kB, anon-rss:4kB, file-rss:1656kB, shmem-rss:0
kB, UID:0 pgtables:112kB oom_score_adj:0
[ 3991.433640] kmemleak: Memory pool empty, consider increasing 
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE
[ 3991.445095] kmemleak: Cannot allocate a kmemleak_object structure
[ 3991.447309] kmemleak: Cannot allocate a kmemleak_object structure
[ 3991.448306] kmemleak: Cannot allocate a kmemleak_object structure
[ 3991.448396] kmemleak: Kernel memory leak detector disabled
[ 3991.452437]
[ 3991.452440] ======================================================
[ 3991.452441] WARNING: possible circular locking dependency detected
[ 3991.452442] 4.18.0-513.el8.x86_64+debug #1 Not tainted
[ 3991.452444] ------------------------------------------------------
[ 3991.452445] kworker/21:1H/436 is trying to acquire lock:
[ 3991.452446] ffffffff8b64c460 (console_owner) {....}-{0:0}, at: 
console_unlock+0x3dc/0xaa0
[ 3991.452452]
[ 3991.452453] but task is already holding lock:
[ 3991.452454] ffffffff8bd2b138 (kmemleak_lock){..}-{2:2}, at: 
create_object+0x4ba/0xac0
[ 3991.452459]
[ 3991.452460] which lock already depends on the new lock.
[ 3991.452461]
[ 3991.452461]
[ 3991.452462] the existing dependency chain (in reverse order) is:
[ 3991.452463]
[ 3991.452464] #3 (kmemleak_lock){.-.}-{2:2}:
[ 3991.452469] lock_acquire+0x1db/0x620
[ 3991.452470] _raw_spin_lock_irqsave+0x4c/0x90
[ 3991.452471] create_object+0x3fc/0xac0
[ 3991.452472] slab_post_alloc_hook+0x66/0x3b0
[ 3991.452473] __kmalloc+0x129/0x270
[ 3991.452474] __tty_buffer_request_room+0x1b4/0x550
[ 3991.452475] tty_insert_flip_string_fixed_flag.part.4+0x79/0x2e0
[ 3991.452476] tty_insert_flip_string_and_push_buffer+0x3e/0x150
[ 3991.452477] n_tty_write+0x48c/0xf10
[ 3991.452478] tty_write+0x389/0x970
[ 3991.452479] vfs_write+0x157/0x460
[ 3991.452480] redirected_tty_write+0x6b/0xb0
[ 3991.452481] do_iter_write+0x382/0x540
[ 3991.452482] vfs_writev+0x176/0x2e0
[ 3991.452483] do_writev+0xc1/0x220
[ 3991.452484] do_syscall_64+0xa5/0x450
[ 3991.452485] entry_SYSCALL_64_after_hwframe+0x66/0xdb
[ 3991.452486]
[ 3991.452486] #2 (&port>lock){..}-{2:2}:
[ 3991.452490] lock_acquire+0x1db/0x620
[ 3991.452491] _raw_spin_lock_irqsave+0x4c/0x90
[ 3991.452492] tty_port_tty_get+0x1d/0x80
[ 3991.452493] tty_port_default_wakeup+0xb/0x30
[ 3991.452494] serial8250_tx_chars+0x3df/0x980
[ 3991.452495] serial8250_handle_irq.part.14+0x145/0x220
[ 3991.452496] serial8250_default_handle_irq+0x82/0xe0
[ 3991.452497] serial8250_interrupt+0xde/0x1b0
[ 3991.452498] __handle_irq_event_percpu+0xfc/0x8a0
[ 3991.452499] handle_irq_event_percpu+0x70/0x140
[ 3991.452500] handle_irq_event+0xa5/0x135
[ 3991.452501] handle_edge_irq+0x20a/0xa40
[ 3991.452502] handle_irq+0x3e/0x60
[ 3991.452503] do_IRQ+0x82/0x200
[ 3991.452504] ret_from_intr+0x0/0x22
[ 3991.452505] cpuidle_enter_state+0x297/0x17f0
[ 3991.452506] cpuidle_enter+0x50/0xb0
[ 3991.452507] do_idle+0x4ed/0x630
[ 3991.452508] cpu_startup_entry+0xcb/0xd4
[ 3991.452509] start_secondary+0x3fb/0x540
[ 3991.452510] secondary_startup_64_no_verify+0xd2/0xdb
[ 3991.452511]
[ 3991.452512] > #1 (&port_lock_key){.-.}-{2:2}:
[ 3991.452516] lock_acquire+0x1db/0x620
[ 3991.452517] _raw_spin_lock_irqsave+0x4c/0x90
[ 3991.452518] serial8250_console_write+0x12c/0x8c0
[ 3991.452519] console_unlock+0x73d/0xaa0
[ 3991.452520] vprintk_emit+0x1fe/0x420
[ 3991.452520] printk+0x9f/0xc9
[ 3991.452521] lockdep_init+0xc/0xb6
[ 3991.452522] start_kernel+0x523/0x7d3
[ 3991.452523] secondary_startup_64_no_verify+0xd2/0xdb
[ 3991.452524]
[ 3991.452525] #0 (console_owner){....}-{0:0}:
[ 3991.452529] check_prevs_add+0x3fa/0x18b0
[ 3991.452530] __lock_acquire+0x21b6/0x2b70
[ 3991.452531] lock_acquire+0x1db/0x620
[ 3991.452532] console_unlock+0x44b/0xaa0
[ 3991.452533] vprintk_emit+0x1fe/0x420
[ 3991.452533] printk+0x9f/0xc9
[ 3991.452534] create_object.cold.19+0x13/0x86
[ 3991.452535] slab_post_alloc_hook+0x66/0x3b0
[ 3991.452536] kmem_cache_alloc+0x155/0x360
[ 3991.452537] radix_tree_node_alloc.constprop.7+0x172/0x2f0
[ 3991.452538] radix_tree_insert+0x197/0x580
[ 3991.452539] add_dma_entry+0x224/0x4e0
[ 3991.452540] debug_dma_map_sg+0x5d7/0xc10
[ 3991.452541] dma_map_sg_attrs+0xc7/0x190
[ 3991.452542] ata_qc_issue+0x65c/0xd60 [libata]
[ 3991.452544] __ata_scsi_queuecmd+0x45f/0xc40 [libata]
[ 3991.452545] ata_scsi_queuecmd+0xa5/0x180 [libata]
[ 3991.452546] scsi_queue_rq+0x16bc/0x3200
[ 3991.452547] blk_mq_dispatch_rq_list+0x3a3/0x2100
[ 3991.452548] blk_mq_do_dispatch_sched+0x72c/0xac0
[ 3991.452549] __blk_mq_sched_dispatch_requests+0x293/0x3f0
[ 3991.452550] blk_mq_sched_dispatch_requests+0xd0/0x130
[ 3991.452551] __blk_mq_run_hw_queue+0xa7/0x110
[ 3991.452552] process_one_work+0x93d/0x17e0
[ 3991.452553] worker_thread+0x87/0xb50
[ 3991.452554] kthread+0x334/0x3f0
[ 3991.452555] ret_from_fork+0x24/0x50
[ 3991.452555]
[ 3991.452556] other info that might help us debug this:
[ 3991.452557]
[ 3991.452558] Chain exists of:
[ 3991.452559] console_owner -> &port>lock --> kmemleak_lock
[ 3991.452565]
[ 3991.452566] Possible unsafe locking scenario:
[ 3991.452566]
[ 3991.452567] CPU0 CPU1
[ 3991.452568] ---- ----
[ 3991.452569] lock(kmemleak_lock);
[ 3991.452572] lock(&port->lock);
[ 3991.452574] lock(kmemleak_lock);
[ 3991.452577] lock(console_owner);
[ 3991.452579]
[ 3991.452580] *** DEADLOCK ***
[ 3991.452581]
[ 3991.452582] 7 locks held by kworker/21:1H/436:
[ 3991.452582] #0: ff110003ec46b548 ((wq_completion)kblockd){..}-{0:0}, 
at: process_one_work+0x816/0x17e0
[ 3991.452588] #1: ffa0000004617e00 
((work_completion)(&(&hctx->run_work)>work)){..} {0:0}, at: 
process_one_work+0x84a/
0x17e0
[ 3991.452594] #2: ffffffff8ba0b440 (rcu_read_lock) {....}-{1:2}, at: 
hctx_lock+0x6d/0x190
[ 3991.452599] #3: ff110001906ad818 (&host->lock){..}-{2:2}, at: 
ata_scsi_queuecmd+0x87/0x180 [libata]
[ 3991.452604] #4: ffffffff8bad8118 (radix_lock){..}-{2:2}, at: 
add_dma_entry+0x20f/0x4e0
[ 3991.452609] #5: ffffffff8bd2b138 (kmemleak_lock){..}-{2:2}, at: 
create_object+0x4ba/0xac0
[ 3991.452614] #6: ffffffff8b9ccae0 (console_lock){..}-{0:0}, at: 
vprintk_emit+0x1f5/0x420
[ 3991.452619]
[ 3991.452620] stack backtrace:
[ 3991.452621] CPU: 21 PID: 436 Comm: kworker/21:1H Kdump: loaded Not 
tainted 4.18.0-513.el8.x86_64+debug #1
[ 3991.452622] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW, 
BIOS AFE118M-1.32 06/29/2022
[ 3991.452623] Workqueue: kblockd blk_mq_run_work_fn
[ 3991.452625] Call Trace:
[ 3991.452626] dump_stack+0x5c/0x80
[ 3991.452627] check_noncircular+0x283/0x320
[ 3991.452631] check_prevs_add+0x3fa/0x18b0
[ 3991.452635] __lock_acquire+0x21b6/0x2b70
[ 3991.452637] lock_acquire+0x1db/0x620
[ 3991.452640] console_unlock+0x44b/0xaa0
[ 3991.452644] vprintk_emit+0x1fe/0x420
[ 3991.452645] printk+0x9f/0xc9
[ 3991.452648] create_object.cold.19+0x13/0x86
[ 3991.452650] slab_post_alloc_hook+0x66/0x3b0
[ 3991.452652] kmem_cache_alloc+0x155/0x360
[ 3991.452653] radix_tree_node_alloc.constprop.7+0x172/0x2f0
[ 3991.452654] radix_tree_insert+0x197/0x580
[ 3991.452657] add_dma_entry+0x224/0x4e0
[ 3991.452659] debug_dma_map_sg+0x5d7/0xc10
[ 3991.452661] dma_map_sg_attrs+0xc7/0x190
[ 3991.452662] ata_qc_issue+0x65c/0xd60 [libata]
[ 3991.452665] __ata_scsi_queuecmd+0x45f/0xc40 [libata]
[ 3991.452666] ata_scsi_queuecmd+0xa5/0x180 [libata]
[ 3991.452667] scsi_queue_rq+0x16bc/0x3200
[ 3991.452668] blk_mq_dispatch_rq_list+0x3a3/0x2100
[ 3991.452675] blk_mq_do_dispatch_sched+0x72c/0xac0
[ 3991.452679] __blk_mq_sched_dispatch_requests+0x293/0x3f0
[ 3991.452682] blk_mq_sched_dispatch_requests+0xd0/0x130
[ 3991.452683] __blk_mq_run_hw_queue+0xa7/0x110
[ 3991.452686] process_one_work+0x93d/0x17e0
[ 3991.452688] worker_thread+0x87/0xb50
[ 3991.452691] kthread+0x334/0x3f0
[ 3991.452693] ret_from_fork+0x24/0x50
[ 3991.865403] kmemleak: Automatic memory scanning thread ended
[ 3992.174346] -----------[ cut here ]-----------

Cheers,
Longman


