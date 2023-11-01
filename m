Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED27DDB22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbjKACvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbjKACvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:51:35 -0400
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514ADBD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:51:29 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1e9877c1bf7so7953371fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698807087; x=1699411887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJcfotsCm12BSyne7j2myEzCh5vLbz+nR4XaUK+27+k=;
        b=sdNFSQKAF3sM7nxa3eZ/J8Pv42pFXFBcrjVJY1evTzuVPkxpT0tQFMLFhTK/tRzLqZ
         ysnJDXB3PbRBBXnypVPY1PaVIvO8XVMJc2McGX8UxFU+DgOJVjA3uq0q3Y0JF5DZ8ZDS
         uW3eBcP7r1+FUdJPglkZYU+2JAfUylXvTPu1pbJwyZOGGL59qHtNb7im3wt69SIh0m8J
         42aY0mULPQYVN9d7qwWErcjrTYQOimzhXSe7zhjxoa8Tfdf/XvozLaqgtK8nGv9OQoTt
         98o//nT5dorUvpAVCtI1mZqhvpqvXYmk/kqZS/AHVzcxQi2i22ubo0owtyZbpO345OJd
         DS/w==
X-Gm-Message-State: AOJu0YwGo7db1KBzh3SGd6E9ObW/U4V0kseXyuPFkxKMny5+QAPo5Q3L
        A+ACZf59zUGm8jgsDgmukOMpBPoPv0UiwpcykQ/3DQHG38xx205JEQ==
X-Google-Smtp-Source: AGHT+IFlc/qnt5TorD6SUYKXTdlAfhvgagYm6ivuVjTLTIc/k5wXQPNFWdniTRSM9DVROrPwtMBm4YzORjcj4sHVTXpZprY5ZfMu
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7188:b0:1e9:a727:e1f with SMTP id
 d8-20020a056870718800b001e9a7270e1fmr7951961oah.8.1698807087782; Tue, 31 Oct
 2023 19:51:27 -0700 (PDT)
Date:   Tue, 31 Oct 2023 19:51:27 -0700
In-Reply-To: <000000000000ffc87a06086172a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000261b806090e5989@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From:   syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    89ed67ef126c Merge tag 'net-next-6.7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1142a1a5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e3b1d98cf5a2cca
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1751c63d680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b69c238dd56a/disk-89ed67ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f555d654a8ba/vmlinux-89ed67ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/335bbfb6c442/bzImage-89ed67ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com

list_del corruption. next->prev should be ffff888020fe5048, but was ffff88807a0f9048. (next=ffff88802533e5e8)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:67!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5827 Comm: syz-executor.5 Not tainted 6.6.0-syzkaller-05843-g89ed67ef126c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__list_del_entry_valid_or_report+0x122/0x130 lib/list_debug.c:65
Code: 85 06 0f 0b 48 c7 c7 20 5f 9d 8b 4c 89 fe 48 89 d9 e8 52 db 85 06 0f 0b 48 c7 c7 a0 5f 9d 8b 4c 89 fe 4c 89 f1 e8 3e db 85 06 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 80 3d 1d 6e
RSP: 0018:ffffc9000aaa7db0 EFLAGS: 00010046
RAX: 000000000000006d RBX: ffff88802533e5f0 RCX: 88e517f49d581b00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff888020fe5008 R08: ffffffff81717aac R09: 1ffff92001554f54
R10: dffffc0000000000 R11: fffff52001554f55 R12: dffffc0000000000
R13: ffff888020fe4000 R14: ffff88802533e5e8 R15: ffff888020fe5048
FS:  0000555557106480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1cc2398000 CR3: 000000001cad1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 ptp_release+0xa8/0x1e0 drivers/ptp/ptp_chardev.c:147
 posix_clock_release+0x8c/0x100 kernel/time/posix-clock.c:157
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f1cc227b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffe5d85d9f0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f1cc227b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000032 R08: 0000001b30160000 R09: 00007f1cc239bf8c
R10: 00007ffe5d85db40 R11: 0000000000000293 R12: 00007f1cc1e001d8
R13: ffffffffffffffff R14: 00007f1cc1e00000 R15: 0000000000015db0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x122/0x130 lib/list_debug.c:65
Code: 85 06 0f 0b 48 c7 c7 20 5f 9d 8b 4c 89 fe 48 89 d9 e8 52 db 85 06 0f 0b 48 c7 c7 a0 5f 9d 8b 4c 89 fe 4c 89 f1 e8 3e db 85 06 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 80 3d 1d 6e
RSP: 0018:ffffc9000aaa7db0 EFLAGS: 00010046

RAX: 000000000000006d RBX: ffff88802533e5f0 RCX: 88e517f49d581b00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff888020fe5008 R08: ffffffff81717aac R09: 1ffff92001554f54
R10: dffffc0000000000 R11: fffff52001554f55 R12: dffffc0000000000
R13: ffff888020fe4000 R14: ffff88802533e5e8 R15: ffff888020fe5048
FS:  0000555557106480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1cc2398000 CR3: 000000001cad1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
