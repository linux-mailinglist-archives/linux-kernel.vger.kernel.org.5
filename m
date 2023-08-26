Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A05789377
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 04:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjHZCgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjHZCfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 22:35:40 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0BE26A2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 19:35:33 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bf703dd1c0so16348625ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 19:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693017333; x=1693622133;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2g2UPzbWrAm/zdNxZneBmUubTHP968M1TKl1MUR1Sw=;
        b=MO8nciecbN01ll+d28SkGihMn8/vWJQvyNpKSEsB1UHbpNCaDl7mRSnW568CwyBHx9
         dnhrdTpdm8cGha2OB7DM/mCkpklAbA9HBPVA4eQ5NrrOcBEb+q/GEiIBQyMSKy1MTuTy
         /knFvXR9VCuebHXeDNXpFjeP7wP6P7K/FCZB/LY8i2V7Lpxvl133Hk94lsIn3UBZgL6K
         7jJmO/Cdk+39xcKGwxDGNHNWTIbDEnacIZ/XBk7/XEd/5fR0/H8/7oIs6AZurnVq7LDj
         1OOtEGW7IzoEhWmlryTlRJ/D7ei9ASEB2wMoy8iHk57Cly+EShm+bADgAFtPuVYJMsAu
         lWYQ==
X-Gm-Message-State: AOJu0YzViWRL7J86vgbsUT5BXnon6aSV/nmJbWB0dhnPitX7doOBF/yH
        oWVygXyOsBy5+cikOSXBl2ARAj2dTc62EFu+3jZyLHTi+zqZ
X-Google-Smtp-Source: AGHT+IHD8qgktpP2XvFZCrFU1/TXL0CEMXqaSAhh0kRZ/1MpA6lZ4Jn8aXqUnWVQmjcJaT31r3qBsuJFTpmZYfTvOjRnOuKab510
MIME-Version: 1.0
X-Received: by 2002:a17:902:f543:b0:1c0:d575:d25 with SMTP id
 h3-20020a170902f54300b001c0d5750d25mr719282plf.11.1693017332730; Fri, 25 Aug
 2023 19:35:32 -0700 (PDT)
Date:   Fri, 25 Aug 2023 19:35:32 -0700
In-Reply-To: <20230826011201.3252-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b754e50603ca5017@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in hci_cmd_sync_queue

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: use-after-free in hci_cmd_sync_queue+0x31/0xa0 net/bluetooth/hci_sync.c:736
Read of size 8 at addr ffff88806a2f00a8 by task kworker/u4:3/48

CPU: 0 PID: 48 Comm: kworker/u4:3 Not tainted 6.5.0-rc6-next-20230818-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events_unbound hci_conn_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hci_cmd_sync_queue+0x31/0xa0 net/bluetooth/hci_sync.c:736
 hci_abort_conn+0x15b/0x330 net/bluetooth/hci_conn.c:2912
 hci_conn_timeout+0x1a9/0x210 net/bluetooth/hci_conn.c:631
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001a8bc00 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6a2f0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001957c08 ffffea0001a25708 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x5c2cc0(GFP_USER|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_ACCOUNT), pid 4708, tgid 4708 (dhcpcd), ts 454062019777, free_ts 454066820991
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3219
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4475
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x87/0x1c0 mm/slab_common.c:1145
 __do_kmalloc_node mm/slab_common.c:992 [inline]
 __kmalloc_node_track_caller.cold+0x5/0xdd mm/slab_common.c:1024
 kmalloc_reserve+0xef/0x270 net/core/skbuff.c:575
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6274
 sock_alloc_send_pskb+0x7c8/0x950 net/core/sock.c:2794
 unix_dgram_sendmsg+0x455/0x1c30 net/unix/af_unix.c:1953
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 sock_write_iter+0x29b/0x3d0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1983 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_writev+0x221/0x700 fs/read_write.c:933
 do_writev+0x285/0x370 fs/read_write.c:976
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2441
 skb_kfree_head net/core/skbuff.c:939 [inline]
 skb_free_head+0x110/0x1b0 net/core/skbuff.c:951
 skb_release_data+0x5ba/0x870 net/core/skbuff.c:981
 skb_release_all net/core/skbuff.c:1047 [inline]
 __kfree_skb net/core/skbuff.c:1061 [inline]
 consume_skb net/core/skbuff.c:1277 [inline]
 consume_skb+0xd2/0x170 net/core/skbuff.c:1271
 __unix_dgram_recvmsg+0x814/0xe50 net/unix/af_unix.c:2442
 unix_dgram_recvmsg+0xc3/0xf0 net/unix/af_unix.c:2459
 sock_recvmsg_nosec net/socket.c:1026 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1048
 sock_read_iter+0x2c3/0x3c0 net/socket.c:1118
 call_read_iter include/linux/fs.h:1977 [inline]
 do_iter_readv_writev+0x2f2/0x3c0 fs/read_write.c:733
 do_iter_read+0x315/0x870 fs/read_write.c:795
 vfs_readv+0x12d/0x1a0 fs/read_write.c:915
 do_readv+0x285/0x370 fs/read_write.c:952
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88806a2eff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88806a2f0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88806a2f0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                  ^
 ffff88806a2f0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88806a2f0180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         7271b2a5 Add linux-next specific files for 20230818
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1005e760680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145e5f5ba80000

