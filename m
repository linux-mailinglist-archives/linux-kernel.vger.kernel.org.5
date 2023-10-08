Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2D7BCE49
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 14:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjJHLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:49:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303B5A6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:49:26 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S3L3x4BFrzrTB8;
        Sun,  8 Oct 2023 19:46:53 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sun, 8 Oct 2023 19:49:23 +0800
Subject: Re: [PATCH] Bluetooth: Fix UAF for hci_chan
To:     Pauli Virtanen <pav@iki.fi>
CC:     <linux-kernel@vger.kernel.org>
References: <20231007093521.2404844-1-william.xuanziyang@huawei.com>
 <f1b9fe3939dff426528760eca39d4ad4ab2340a3.camel@iki.fi>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <8266e59c-0819-b477-7eff-c4bdfb5614de@huawei.com>
Date:   Sun, 8 Oct 2023 19:49:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f1b9fe3939dff426528760eca39d4ad4ab2340a3.camel@iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> la, 2023-10-07 kello 17:35 +0800, Ziyang Xuan kirjoitti:
>> Syzbot reports a UAF problem as follows:
>>
>> BUG: KASAN: slab-use-after-free in hci_send_acl+0x48/0xe70 net/bluetooth/hci_core.c:3231
>> ...
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>>  print_address_description mm/kasan/report.c:364 [inline]
>>  print_report+0x163/0x540 mm/kasan/report.c:475
>>  kasan_report+0x175/0x1b0 mm/kasan/report.c:588
>>  hci_send_acl+0x48/0xe70 net/bluetooth/hci_core.c:3231
>>  l2cap_send_conn_req net/bluetooth/l2cap_core.c:1286 [inline]
>>  l2cap_start_connection+0x465/0x620 net/bluetooth/l2cap_core.c:1514
>>  l2cap_conn_start+0xbf3/0x1130 net/bluetooth/l2cap_core.c:1661
>>  process_one_work kernel/workqueue.c:2630 [inline]
>>  process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
>>  worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
>>  kthread+0x2d3/0x370 kernel/kthread.c:388
>>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>>  </TASK>
> 
> Note this looks like the same issue as in the following thread, where
> there's a suggestion from maintainer:
> 
> https://lore.kernel.org/linux-bluetooth/fd9c0f0eddb8a7d73e9797568dc3cf2bc9b8ad62.1696077070.git.pav@iki.fi/T/#u
> 
> 
> Is it the same issue?

Yes, Thank you for your reminder.

I think use ida to make handle unique can solve the problem more easily.

I will rebase my patch.

Ziyang Xuan
> 
>>
>> Allocated by task 27110:
>>  kasan_save_stack mm/kasan/common.c:45 [inline]
>>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
>>  kmalloc include/linux/slab.h:599 [inline]
>>  kzalloc include/linux/slab.h:720 [inline]
>>  hci_chan_create+0xc8/0x300 net/bluetooth/hci_conn.c:2714
>>  l2cap_conn_add+0x69/0xc10 net/bluetooth/l2cap_core.c:7841
>>  l2cap_chan_connect+0x61f/0xeb0 net/bluetooth/l2cap_core.c:8053
>>  bt_6lowpan_connect net/bluetooth/6lowpan.c:894 [inline]
>>  lowpan_control_write+0x55e/0x850 net/bluetooth/6lowpan.c:1129
>>  full_proxy_write+0x113/0x1c0 fs/debugfs/file.c:236
>>  vfs_write+0x286/0xaf0 fs/read_write.c:582
>>  ksys_write+0x1a0/0x2c0 fs/read_write.c:637
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Freed by task 5067:
>>  kasan_save_stack mm/kasan/common.c:45 [inline]
>>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>>  kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
>>  ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>>  kasan_slab_free include/linux/kasan.h:164 [inline]
>>  slab_free_hook mm/slub.c:1800 [inline]
>>  slab_free_freelist_hook mm/slub.c:1826 [inline]
>>  slab_free mm/slub.c:3809 [inline]
>>  __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
>>  hci_chan_list_flush net/bluetooth/hci_conn.c:2754 [inline]
>>  hci_conn_cleanup net/bluetooth/hci_conn.c:152 [inline]
>>  hci_conn_del+0x4f8/0xc40 net/bluetooth/hci_conn.c:1156
>>  hci_abort_conn_sync+0xa45/0xfe0
>>  hci_cmd_sync_work+0x228/0x400 net/bluetooth/hci_sync.c:306
>>  process_one_work kernel/workqueue.c:2630 [inline]
>>  process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
>>  worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
>>  kthread+0x2d3/0x370 kernel/kthread.c:388
>>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>>
>> There are two main reasons for this:
>> 1. In the case of hci_conn_add() concurrency, the handle of
>> hci_conn allocated through hci_conn_hash_alloc_unset() is not unique.
>> 2. The processes related to hci_abort_conn() and hci_connect_xxx()
>> can be concurrent, but the two processes lack synchronization.
>>
>> To fix this, use ida to manage the allocation of conn->handle, and
>> add the HCI_CONN_DISC flag to achieve synchronization between
>> hci_abort_conn() and hci_connect_xxx() related processes.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
