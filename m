Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36B175B201
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjGTPGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjGTPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:06:11 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF86BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:06:09 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6b9d3ce1a56so1509067a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865568; x=1690470368;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKVBvLPG0X3iK7tBptTq+Ag6ZQ3K/JZ4/J9b/33HYx0=;
        b=lId0zpWACv4457Lvv12L4/cIOl5klcmjouCYg+A+U2i9/hHgpX/cTdN5T82Zpsyj74
         3rws/WKZg0jDx0LoCtMUyOXFi19oqXQpXzNfncf8Q5yIvAA3LsUcaUuD0Y8Lrr/vG+Eg
         dZ3NkN2qDsJPJgaxkHNnwBrmE5NEBZWAucbdteVrjjaZ1Mq5WTcw8mYqn6Gjm3hgLOxe
         f9LJwKGB8br0CvWqqNBKTobx1rHqHIAFGxozjLXlco/wXximKPsrqXsNpJepCK+Ogc4Z
         j/5B2Rx2RmIGmGD3gYluruXU0IBMHfVCB+H07qUBAxCJP9TJ6ppMTGpaH9f9HvjYHIG4
         zEXQ==
X-Gm-Message-State: ABy/qLYAn/ePU/mCGhVP9kvcEOUrtRLyc7HuEAsKydN10PlzHx7+EkOk
        /8TCF111khZ7DtsNs+0HXVogPraXLiV+E5T+lRqJtL0nDGJ5
X-Google-Smtp-Source: APBJJlHHXuaOTeRId5gNXQ+tDR5YOI1aFTzat+v+7c6DbDdGpzRv8lFcTImDAHbvoeovUaRkkJ4HcvnWlTExuo+hU3354885WXpm
MIME-Version: 1.0
X-Received: by 2002:a9d:6503:0:b0:6b7:4ec4:cbb1 with SMTP id
 i3-20020a9d6503000000b006b74ec4cbb1mr3697830otl.7.1689865568542; Thu, 20 Jul
 2023 08:06:08 -0700 (PDT)
Date:   Thu, 20 Jul 2023 08:06:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee69e80600ec7cc7@google.com>
Subject: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
From:   syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    03b123debcbc tcp: tcp_enter_quickack_mode() should be static
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ac9ffaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=14736e249bce46091c18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133f36c6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8e73aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348462fb61fa/disk-03b123de.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33375730f77f/vmlinux-03b123de.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6882fbac041/bzImage-03b123de.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff88801529b000 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 57 at lib/debugobjects.c:514 debug_print_object+0x19e/0x2a0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 57 Comm: kworker/u4:4 Not tainted 6.5.0-rc1-syzkaller-00458-g03b123debcbc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x19e/0x2a0 lib/debugobjects.c:514
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 49 48 8b 14 dd c0 20 c8 8a 41 56 4c 89 e6 48 c7 c7 20 14 c8 8a e8 b2 fa 28 fd <0f> 0b 58 83 05 5c 8b 87 0a 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc90001587828 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888016ee5940 RSI: ffffffff814d4986 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8ac81a80
R13: ffffffff8a6df720 R14: 0000000000000000 R15: ffff88802a6b65c8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000c776000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_activate+0x32b/0x490 lib/debugobjects.c:733
 debug_rcu_head_queue kernel/rcu/rcu.h:226 [inline]
 kvfree_call_rcu+0x30/0xbe0 kernel/rcu/tree.c:3359
 tcx_entry_free include/net/tcx.h:96 [inline]
 tcx_uninstall+0x2fd/0x630 kernel/bpf/tcx.c:115
 dev_tcx_uninstall include/net/tcx.h:174 [inline]
 unregister_netdevice_many_notify+0x5e7/0x1a20 net/core/dev.c:10899
 ip6gre_exit_batch_net+0x3ea/0x580 net/ipv6/ip6_gre.c:1642
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
