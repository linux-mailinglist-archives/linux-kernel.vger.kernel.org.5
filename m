Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4C7F8CCB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjKYRdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKYRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:33:03 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A4F11F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:33:09 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b8d4a559ddso3968020a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700933589; x=1701538389;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ/lJwJ9V8LGwXeSxUY6Bh74FRjOczfLYNMObLeTU0s=;
        b=ifc667NbU38Ftvy3vOt/ta8I2QiSjLiptBIC/fQFKEgdXZuf0grJplfPRHwqEup4FB
         KjHtcsDwEyYmIFkH8Zb64iy15UaS9Xe2v1IIQBOWM364gfCpyePitJBi0aPMmFrtKsgO
         jDH7jgMh5i0//hq4BOMftBqc8qOhKh6hmkX1ywSXHgVybDdKnRhOUk78+W49eJx50kiQ
         avoxETUSGY9TsAlsiQheEs8pkcjlM/v2ZgYWsV0p3uLWFozsV/58sXYbwePgDMmrhHOB
         6cJTVG+00F8QhovrmC+dDcP3ABfYbAvhslUdLueRmvwDco7yIrPJwZrfwTx1qn1Md/Ud
         DrNA==
X-Gm-Message-State: AOJu0YzvE1Ov7M+LRRUN+sc1ZenVAQU6kk/dHUSsBbxpvnYLYpWu2eHT
        mxAPcl2DKE0gIR3UP8XQBlTVywIqVJwcTiptuDwgwuff6VvJ
X-Google-Smtp-Source: AGHT+IH9QCmG5am2wMlm0N4WzERSxGZC1RohWc0XXc1spCdVI1M0xOx2QZAXMQ54cAgwrTQweshwGy6HaPJAwsnxgG7O75zGNYJ4
MIME-Version: 1.0
X-Received: by 2002:a63:1049:0:b0:5bd:3a19:e5ab with SMTP id
 9-20020a631049000000b005bd3a19e5abmr1004663pgq.7.1700933588924; Sat, 25 Nov
 2023 09:33:08 -0800 (PST)
Date:   Sat, 25 Nov 2023 09:33:08 -0800
In-Reply-To: <8aa60891-cd52-42c0-b9a2-594d69b133fd@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005abf1f060afd76bd@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in nfc_llcp_socket_release

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5478, name: syz-executor.0
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor.0/5478:
 #0: ffff88806cd22468 (&local->sockets.lock){++++}-{2:2}, at: nfc_llcp_socket_release+0x56/0xb90 net/nfc/llcp_core.c:90
 #1: ffff88806cd5c0b0 (slock-AF_NFC){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff88806cd5c0b0 (slock-AF_NFC){+.+.}-{2:2}, at: nfc_llcp_socket_release+0xcb/0xb90 net/nfc/llcp_core.c:95
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5478 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00198-g7ac1c88a5daa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 __might_resched+0x5cf/0x780 kernel/sched/core.c:10151
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0xc1/0xd60 kernel/locking/mutex.c:747
 nfc_llcp_sock_close net/nfc/llcp_core.c:33 [inline]
 nfc_llcp_socket_release+0x498/0xb90 net/nfc/llcp_core.c:120
 local_cleanup+0x28/0xe0 net/nfc/llcp_core.c:161
 nfc_llcp_unregister_device+0x160/0x240 net/nfc/llcp_core.c:1655
 nfc_unregister_device+0x167/0x2a0 net/nfc/core.c:1179
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:163
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe8ddc7b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007fffdaf3d080 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe8ddc7b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fe8ddd9d980 R08: 0000001b2e060000 R09: 00007fffdaf810b0
R10: 00007fffdaf81080 R11: 0000000000000293 R12: 00000000000151df
R13: ffffffffffffffff R14: 00007fe8dd800000 R15: 0000000000014e9e
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.7.0-rc2-syzkaller-00198-g7ac1c88a5daa #0 Tainted: G        W         
-----------------------------
syz-executor.0/5478 is trying to lock:
ffff88806cd5c590 (&llcp_sock->lock){+.+.}-{3:3}, at: nfc_llcp_sock_close net/nfc/llcp_core.c:33 [inline]
ffff88806cd5c590 (&llcp_sock->lock){+.+.}-{3:3}, at: nfc_llcp_socket_release+0x498/0xb90 net/nfc/llcp_core.c:120
other info that might help us debug this:
context-{4:4}
2 locks held by syz-executor.0/5478:
 #0: ffff88806cd22468 (&local->sockets.lock){++++}-{2:2}, at: nfc_llcp_socket_release+0x56/0xb90 net/nfc/llcp_core.c:90
 #1: ffff88806cd5c0b0 (slock-AF_NFC){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff88806cd5c0b0 (slock-AF_NFC){+.+.}-{2:2}, at: nfc_llcp_socket_release+0xcb/0xb90 net/nfc/llcp_core.c:95
stack backtrace:
CPU: 0 PID: 5478 Comm: syz-executor.0 Tainted: G        W          6.7.0-rc2-syzkaller-00198-g7ac1c88a5daa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4750 [inline]
 check_wait_context kernel/locking/lockdep.c:4820 [inline]
 __lock_acquire+0x1825/0x7f70 kernel/locking/lockdep.c:5086
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
 nfc_llcp_sock_close net/nfc/llcp_core.c:33 [inline]
 nfc_llcp_socket_release+0x498/0xb90 net/nfc/llcp_core.c:120
 local_cleanup+0x28/0xe0 net/nfc/llcp_core.c:161
 nfc_llcp_unregister_device+0x160/0x240 net/nfc/llcp_core.c:1655
 nfc_unregister_device+0x167/0x2a0 net/nfc/core.c:1179
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:163
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe8ddc7b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007fffdaf3d080 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe8ddc7b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fe8ddd9d980 R08: 0000001b2e060000 R09: 00007fffdaf810b0
R10: 00007fffdaf81080 R11: 0000000000000293 R12: 00000000000151df
R13: ffffffffffffffff R14: 00007fe8dd800000 R15: 0000000000014e9e
 </TASK>


Tested on:

commit:         7ac1c88a lock
git tree:       https://github.com/siddhpant/linux.git lock
console output: https://syzkaller.appspot.com/x/log.txt?x=11f333af680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6a76f6c7029ca2
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
