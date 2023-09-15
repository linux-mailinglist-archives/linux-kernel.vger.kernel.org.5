Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD97A1620
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjIOGaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjIOGaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:30:04 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39CD273E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:29:53 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1c8f953e111so2664206fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694759393; x=1695364193;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/dhNCOa2uUHoRVvRlugiXn30K4c1kP4ooQHJs85hMs=;
        b=I8yj118tD22B8aR4jGtW7wbdkHMMXWoQMkWI+F0TKzDipOTuFtpXfSEBrDb19yU4eU
         Psc6qmlem20UTYvmTpW91IiQpmpOfnae1AHvG3qkQQ4rGF8ZrB9STR4ClUQbalqHGqqh
         7evyPl6kEyzUuaAzyPloRPGMn/i3GmOMLzfXuZRXs1MPhQq4jWZj10aN2eQGd6w/itWo
         ZbdqhM18joRTb0jnzoiwpkB4JY9hROy2ArnpXntSPKGUKNwG0SPtZ/JleVt2F3U93NbK
         JRCpYXzdD9hhE+mE4nEIVczn5Ahf5R0noGcfYY4Z/7INNoovzOgJxxc72QAWZnA0KV+C
         5DwQ==
X-Gm-Message-State: AOJu0YwvFQJHsFYB1/VJqpkZktCURkwQAUpGmYJ2sbWYgccHEmQW3Z+o
        CrjgFkSlSrmZ0t7a8C2kZNhhokwyeFJvZxwuKi0iJr0wDw1L
X-Google-Smtp-Source: AGHT+IGUAR1x0L5isvY9gORqZtpTYZVC0Fi/Ern5ryAg5URX/rh2wJk4hefFicSD2npvpdP+QiWAVR0rbIC/C3N+zLVCOAlsDwld
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a97:b0:1c5:e4a5:6990 with SMTP id
 dt23-20020a0568705a9700b001c5e4a56990mr271000oab.5.1694759393144; Thu, 14 Sep
 2023 23:29:53 -0700 (PDT)
Date:   Thu, 14 Sep 2023 23:29:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bb78206055feb7c@google.com>
Subject: [syzbot] [serial?] memory leak in gsm_activate_mux
From:   syzbot <syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
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

syzbot found the following issue on:

HEAD commit:    0bb80ecc33a8 Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a8aad8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99ce3535087fc27
dashboard link: https://syzkaller.appspot.com/bug?extid=b5d1f455d385b2c7da3c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163a9e30680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fcd4a0680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce21ae500663/disk-0bb80ecc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d2f34908198/vmlinux-0bb80ecc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c6f5eecda20/bzImage-0bb80ecc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888101230c00 (size 1024):
  comm "syz-executor201", pid 5036, jiffies 4294942174 (age 8.190s)
  hex dump (first 32 bytes):
    00 78 0f 11 81 88 ff ff 00 00 00 00 00 00 00 00  .x..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81573b75>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff827ec407>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff827ec407>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff827ec407>] gsm_dlci_alloc+0x27/0x1f0 drivers/tty/n_gsm.c:2640
    [<ffffffff827ec5ec>] gsm_activate_mux+0x1c/0x1c0 drivers/tty/n_gsm.c:3129
    [<ffffffff827f310f>] gsm_config_ext drivers/tty/n_gsm.c:3434 [inline]
    [<ffffffff827f310f>] gsmld_ioctl+0x6cf/0x9f0 drivers/tty/n_gsm.c:3798
    [<ffffffff827d7bbb>] tty_ioctl+0x3eb/0xc70 drivers/tty/tty_io.c:2785
    [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888104f38000 (size 4096):
  comm "syz-executor201", pid 5036, jiffies 4294942174 (age 8.190s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815742ab>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815742ab>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff824f9f89>] kmalloc_array include/linux/slab.h:636 [inline]
    [<ffffffff824f9f89>] __kfifo_alloc+0x89/0xe0 lib/kfifo.c:43
    [<ffffffff827ec451>] gsm_dlci_alloc+0x71/0x1f0 drivers/tty/n_gsm.c:2645
    [<ffffffff827ec5ec>] gsm_activate_mux+0x1c/0x1c0 drivers/tty/n_gsm.c:3129
    [<ffffffff827f310f>] gsm_config_ext drivers/tty/n_gsm.c:3434 [inline]
    [<ffffffff827f310f>] gsmld_ioctl+0x6cf/0x9f0 drivers/tty/n_gsm.c:3798
    [<ffffffff827d7bbb>] tty_ioctl+0x3eb/0xc70 drivers/tty/tty_io.c:2785
    [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
