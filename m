Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03EE80116E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378239AbjLAQOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjLAQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:14:16 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E5C10F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:14:21 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c5c8ece6c4so713692a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447261; x=1702052061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEtDZIP82VxMlYg7UA5Ytfxnjx2Cbb370QUc13RWESs=;
        b=t5B6vlUZo1xoJb3J2ikMgdBMqiy0uMfPmceNShU4xV2QafpLyWwurxV/wEvhPBfy1Q
         eQmO+tUM/dzCHFjKBL9P4cegTxNU8jHZ9Lt+QaJVai/3/sm1n11GBaZDBCOK5VRExO9X
         ojPas6mzGrVnJPYFuDJydCCYb6GWvoaLXaFcnKxJHWXP9vqnyWlKZ5aGelLv8mqsmyMp
         fLtgnz63aFNzKXtLZ48/e+A0rtgQGMXjBFfY1OUYDZ9tFQiKawhYjnuuBQzYULCy6cCy
         w+VbHzdYJ2oVZODzKBszgg8knlVvprXV7LHo8+gkd/W/nRoLdhW1YjbhIIQOF0OYPGgj
         Vzhw==
X-Gm-Message-State: AOJu0YwQ43XxsYNknJdM16Yi9q2U6etxkFEpFpBGemP9O4/46n3adtGq
        dFRewnjXJmmYM0Ag3SQoeUwj00fYq3+CK4/vCooRjUpvzBlW
X-Google-Smtp-Source: AGHT+IFpvK2Dsg3/9Rax/6rp/kkDoRmJD4LLMonQLWCZ50TS8hMN4ulTZ2efRBBfRFQyVJ3QXOwORNgfkrOmEvRkuni6rYoxOscB
MIME-Version: 1.0
X-Received: by 2002:a63:4c:0:b0:5bd:d756:86d2 with SMTP id 73-20020a63004c000000b005bdd75686d2mr3700859pga.10.1701447261485;
 Fri, 01 Dec 2023 08:14:21 -0800 (PST)
Date:   Fri, 01 Dec 2023 08:14:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fffb7060b750f4f@google.com>
Subject: [syzbot] [net?] memory leak in copy_net_ns (2)
From:   syzbot <syzbot+989b6c53cd6d6ec47ab2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    e017769f4ce2 Merge tag 'for-6.6-rc7-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10277593680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c4e4700f1727d30
dashboard link: https://syzkaller.appspot.com/bug?extid=989b6c53cd6d6ec47ab2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174e61ed680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52a9cd027b72/disk-e017769f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/646078695995/vmlinux-e017769f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a78855f93880/bzImage-e017769f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+989b6c53cd6d6ec47ab2@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810e8d3660 (size 32):
  comm "syz-executor.3", pid 5088, jiffies 4294979538 (age 423.340s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81574aa5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1117
    [<ffffffff83eb94f0>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff83eb94f0>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83eb94f0>] net_alloc net/core/net_namespace.c:422 [inline]
    [<ffffffff83eb94f0>] copy_net_ns+0xc0/0x3d0 net/core/net_namespace.c:476
    [<ffffffff812db5d7>] create_new_namespaces+0x197/0x500 kernel/nsproxy.c:110
    [<ffffffff812dc012>] unshare_nsproxy_namespaces+0xa2/0x120 kernel/nsproxy.c:228
    [<ffffffff81293f84>] ksys_unshare+0x314/0x610 kernel/fork.c:3435
    [<ffffffff81294296>] __do_sys_unshare kernel/fork.c:3506 [inline]
    [<ffffffff81294296>] __se_sys_unshare kernel/fork.c:3504 [inline]
    [<ffffffff81294296>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3504
    [<ffffffff84b2b548>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2b548>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810e8d3fa0 (size 32):
  comm "syz-executor.4", pid 5078, jiffies 4294979546 (age 423.260s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81574aa5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1117
    [<ffffffff83eb94f0>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff83eb94f0>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83eb94f0>] net_alloc net/core/net_namespace.c:422 [inline]
    [<ffffffff83eb94f0>] copy_net_ns+0xc0/0x3d0 net/core/net_namespace.c:476
    [<ffffffff812db5d7>] create_new_namespaces+0x197/0x500 kernel/nsproxy.c:110
    [<ffffffff812dc012>] unshare_nsproxy_namespaces+0xa2/0x120 kernel/nsproxy.c:228
    [<ffffffff81293f84>] ksys_unshare+0x314/0x610 kernel/fork.c:3435
    [<ffffffff81294296>] __do_sys_unshare kernel/fork.c:3506 [inline]
    [<ffffffff81294296>] __se_sys_unshare kernel/fork.c:3504 [inline]
    [<ffffffff81294296>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3504
    [<ffffffff84b2b548>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2b548>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888111239400 (size 32):
  comm "syz-executor.1", pid 5075, jiffies 4294979553 (age 423.190s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81574aa5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1117
    [<ffffffff83eb94f0>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff83eb94f0>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83eb94f0>] net_alloc net/core/net_namespace.c:422 [inline]
    [<ffffffff83eb94f0>] copy_net_ns+0xc0/0x3d0 net/core/net_namespace.c:476
    [<ffffffff812db5d7>] create_new_namespaces+0x197/0x500 kernel/nsproxy.c:110
    [<ffffffff812dc012>] unshare_nsproxy_namespaces+0xa2/0x120 kernel/nsproxy.c:228
    [<ffffffff81293f84>] ksys_unshare+0x314/0x610 kernel/fork.c:3435
    [<ffffffff81294296>] __do_sys_unshare kernel/fork.c:3506 [inline]
    [<ffffffff81294296>] __se_sys_unshare kernel/fork.c:3504 [inline]
    [<ffffffff81294296>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3504
    [<ffffffff84b2b548>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2b548>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888111239840 (size 32):
  comm "syz-executor.7", pid 5076, jiffies 4294979555 (age 423.170s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81574aa5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1117
    [<ffffffff83eb94f0>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff83eb94f0>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83eb94f0>] net_alloc net/core/net_namespace.c:422 [inline]
    [<ffffffff83eb94f0>] copy_net_ns+0xc0/0x3d0 net/core/net_namespace.c:476
    [<ffffffff812db5d7>] create_new_namespaces+0x197/0x500 kernel/nsproxy.c:110
    [<ffffffff812dc012>] unshare_nsproxy_namespaces+0xa2/0x120 kernel/nsproxy.c:228
    [<ffffffff81293f84>] ksys_unshare+0x314/0x610 kernel/fork.c:3435
    [<ffffffff81294296>] __do_sys_unshare kernel/fork.c:3506 [inline]
    [<ffffffff81294296>] __se_sys_unshare kernel/fork.c:3504 [inline]
    [<ffffffff81294296>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3504
    [<ffffffff84b2b548>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2b548>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888143eae6c0 (size 32):
  comm "syz-executor.6", pid 5077, jiffies 4294979559 (age 423.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81574aa5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1117
    [<ffffffff83eb94f0>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff83eb94f0>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83eb94f0>] net_alloc net/core/net_namespace.c:422 [inline]
    [<ffffffff83eb94f0>] copy_net_ns+0xc0/0x3d0 net/core/net_namespace.c:476
    [<ffffffff812db5d7>] create_new_namespaces+0x197/0x500 kernel/nsproxy.c:110
    [<ffffffff812dc012>] unshare_nsproxy_namespaces+0xa2/0x120 kernel/nsproxy.c:228
    [<ffffffff81293f84>] ksys_unshare+0x314/0x610 kernel/fork.c:3435
    [<ffffffff81294296>] __do_sys_unshare kernel/fork.c:3506 [inline]
    [<ffffffff81294296>] __se_sys_unshare kernel/fork.c:3504 [inline]
    [<ffffffff81294296>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:3504
    [<ffffffff84b2b548>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2b548>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

[  846.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
