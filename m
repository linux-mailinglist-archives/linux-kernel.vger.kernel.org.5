Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2585878B34C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjH1OiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjH1OiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:38:02 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F2B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:37:59 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-26d4ced65c1so3751013a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233479; x=1693838279;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haZCXzzyQVdc0yaxbpwUxNox05oXr6eXnYZN4WxqPLk=;
        b=PSb2fjg2uSI5Ai5SJV2rm4iZtsPF2vkXVL0DsDXyqWhFN+um6boEi2A5V8PVBbjEtP
         24E/7qhwh5kVQvL/UYy+Mnm6/1ZCYfU1O0TQ7RssDlxbBaO7ha7zyDJ8LfB4lrATOilk
         9h44S/8YaJSi6Vk3WzQclOeK6cotzhYQgnDUAEs/8/9Pi1/3QTGfM7xRQAin5NSPGceQ
         GlQcfbxgUsgX6X0Zh2er6sKATL8WauLjiMpJkKGgKY++0qOT9TP3G7FswEcbI5NUDHZt
         07Q2WlYZNkVELzlh9lS+oi9fjJrppucWPyhPyFSQrWwYLwuVOzhDXCnVs5cYg7yRCilV
         bf4w==
X-Gm-Message-State: AOJu0YwStNzXmicCQZWJ7Z+wnOb5lchRsq/8hhUwTY/4k3nFeSaKH206
        LxtTznRMBK8HNyoJlblln7WxqugV7DWQCWY5vfrZKxyoQdjI
X-Google-Smtp-Source: AGHT+IHcD6gG9F9AL0FFsAAdBxUy+/WZm/avxQqWllSMulkqzYGVFpxvkcInoAqZO1wqNNuOQmscel2nUaEFwqCAYHiihMD7fM/b
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d184:b0:269:2227:b290 with SMTP id
 fu4-20020a17090ad18400b002692227b290mr5441575pjb.7.1693233479502; Mon, 28 Aug
 2023 07:37:59 -0700 (PDT)
Date:   Mon, 28 Aug 2023 07:37:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011542d0603fca409@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in pfifo_fast_dequeue /
 pfifo_fast_enqueue (3)
From:   syzbot <syzbot+b197eb04ec8e2c0407bd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    25aa0bebba72 Merge tag 'net-6.5-rc6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140d163ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1abf5b066126c86
dashboard link: https://syzkaller.appspot.com/bug?extid=b197eb04ec8e2c0407bd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37e7726f4b59/disk-25aa0beb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c08aceaec1ed/vmlinux-25aa0beb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49fb33802692/bzImage-25aa0beb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b197eb04ec8e2c0407bd@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue

write to 0xffff88810487fe80 of 8 bytes by task 19023 on cpu 1:
 __ptr_ring_discard_one include/linux/ptr_ring.h:280 [inline]
 __ptr_ring_consume include/linux/ptr_ring.h:301 [inline]
 __skb_array_consume include/linux/skb_array.h:98 [inline]
 pfifo_fast_dequeue+0x887/0xee0 net/sched/sch_generic.c:757
 dequeue_skb net/sched/sch_generic.c:292 [inline]
 qdisc_restart net/sched/sch_generic.c:397 [inline]
 __qdisc_run+0x1a2/0x1100 net/sched/sch_generic.c:415
 __dev_xmit_skb net/core/dev.c:3766 [inline]
 __dev_queue_xmit+0xe98/0x1d10 net/core/dev.c:4169
 dev_queue_xmit include/linux/netdevice.h:3088 [inline]
 llc_build_and_send_ui_pkt+0x1d4/0x1f0 net/llc/llc_output.c:67
 llc_ui_sendmsg+0x43a/0x5e0 net/llc/af_llc.c:978
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0x79/0xd0 net/socket.c:748
 splice_to_socket+0x653/0x9c0 fs/splice.c:884
 do_splice_from fs/splice.c:936 [inline]
 direct_splice_actor+0x8a/0xb0 fs/splice.c:1145
 splice_direct_to_actor+0x31d/0x690 fs/splice.c:1091
 do_splice_direct+0x10d/0x190 fs/splice.c:1197
 do_sendfile+0x3b6/0x9a0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88810487fe80 of 8 bytes by task 19022 on cpu 0:
 __ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
 ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
 skb_array_produce include/linux/skb_array.h:44 [inline]
 pfifo_fast_enqueue+0xcc/0x2a0 net/sched/sch_generic.c:730
 dev_qdisc_enqueue net/core/dev.c:3732 [inline]
 __dev_xmit_skb net/core/dev.c:3772 [inline]
 __dev_queue_xmit+0x7c7/0x1d10 net/core/dev.c:4169
 dev_queue_xmit include/linux/netdevice.h:3088 [inline]
 llc_build_and_send_ui_pkt+0x1d4/0x1f0 net/llc/llc_output.c:67
 llc_ui_sendmsg+0x43a/0x5e0 net/llc/af_llc.c:978
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0x79/0xd0 net/socket.c:748
 splice_to_socket+0x653/0x9c0 fs/splice.c:884
 do_splice_from fs/splice.c:936 [inline]
 direct_splice_actor+0x8a/0xb0 fs/splice.c:1145
 splice_direct_to_actor+0x31d/0x690 fs/splice.c:1091
 do_splice_direct+0x10d/0x190 fs/splice.c:1197
 do_sendfile+0x3b6/0x9a0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffff888161b34f00 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 19022 Comm: syz-executor.0 Tainted: G        W          6.5.0-rc5-syzkaller-00182-g25aa0bebba72 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
