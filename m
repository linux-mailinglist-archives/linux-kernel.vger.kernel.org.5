Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611077DE45C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjKAQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:03:38 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8BBE4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 09:03:32 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6d31f3feb12so559976a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 09:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698854612; x=1699459412;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdeQV2pIkNcTK7spnDytELNGhzvPyiLiMoKr4E/iFYg=;
        b=KqovAuSweOaM2AQ/+6FUVsccBNqcFCZTimvQdyIM1e8WnFbntl1rcv0+UbDgIIE7iP
         SVGC0JYDMooEcp5FxfwjpeYRZMpxBuE1ApgfOMFUBsxYbQ/5K1jnVozYFKpRaSuST7nX
         CSpZb6/de5fgUB2swoJVcJgzuYvduH09wXX4KxHmQdWeDKHYgxfUpaD8ZHMmqSpVnHYv
         FavXkxOzBgMqrX5GA7fOzubiOgrHX29mhYE97HjVjvSPZSKPu1fRJ0f7nQlWAne4BP5c
         L/kjbKb/HcEe/dQn9DRBeCOWK6x2ns8NxWclpLjUNkUxBvicRjqUfdySWDnRZCmgVMNH
         G28g==
X-Gm-Message-State: AOJu0YwNIsBaF7fv7qQ1xS3PqUu7+t34S+AzkNxUyObpIduJ3j5A0rcg
        zp4RUJeRNz+zWBg0CDR9oxDHc4HSxrYkp8wvlnhXU9CIhY8sG9/aOg==
X-Google-Smtp-Source: AGHT+IH6pqVhlK4/Ye6KVhcJbYipZaAOhCbWXksV5EcB8uznUSLjN1FhgL37OGuTiwA8CZARxfvOE3cYNM20XJsKeYF/0HOi5Wdq
MIME-Version: 1.0
X-Received: by 2002:a05:6871:5813:b0:1ef:ac35:a2fe with SMTP id
 oj19-20020a056871581300b001efac35a2femr5752413oac.6.1698854611993; Wed, 01
 Nov 2023 09:03:31 -0700 (PDT)
Date:   Wed, 01 Nov 2023 09:03:31 -0700
In-Reply-To: <000000000000ffc87a06086172a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac4b37060919693b@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From:   syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150b105f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e3b1d98cf5a2cca
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd173b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce0840e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b69c238dd56a/disk-89ed67ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f555d654a8ba/vmlinux-89ed67ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/335bbfb6c442/bzImage-89ed67ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com

list_del corruption. next->prev should be ffff88802a019048, but was ffff88802a401048. (next=ffff88802515e5e8)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:67!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6526 Comm: syz-executor155 Not tainted 6.6.0-syzkaller-05843-g89ed67ef126c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__list_del_entry_valid_or_report+0x122/0x130 lib/list_debug.c:65
Code: 85 06 0f 0b 48 c7 c7 20 5f 9d 8b 4c 89 fe 48 89 d9 e8 52 db 85 06 0f 0b 48 c7 c7 a0 5f 9d 8b 4c 89 fe 4c 89 f1 e8 3e db 85 06 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 80 3d 1d 6e
RSP: 0018:ffffc90009d67b18 EFLAGS: 00010046
RAX: 000000000000006d RBX: ffff88802515e5f0 RCX: 58e87076363f5a00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff88802a019008 R08: ffffffff81717aac R09: 1ffff920013acf04
R10: dffffc0000000000 R11: fffff520013acf05 R12: dffffc0000000000
R13: ffff88802a018000 R14: ffff88802515e5e8 R15: ffff88802a019048
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff08f2c4110 CR3: 0000000074918000 CR4: 00000000003506f0
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
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa2c/0x2650 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7ff08f248bf9
Code: Unable to access opcode bytes at 0x7ff08f248bcf.
RSP: 002b:00007ffc5a8eb438 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff08f248bf9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007ff08f2c3290 R08: ffffffffffffffb8 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff08f2c3290
R13: 0000000000000000 R14: 00007ff08f2c3d00 R15: 00007ff08f219da0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x122/0x130 lib/list_debug.c:65
Code: 85 06 0f 0b 48 c7 c7 20 5f 9d 8b 4c 89 fe 48 89 d9 e8 52 db 85 06 0f 0b 48 c7 c7 a0 5f 9d 8b 4c 89 fe 4c 89 f1 e8 3e db 85 06 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 80 3d 1d 6e
RSP: 0018:ffffc90009d67b18 EFLAGS: 00010046

RAX: 000000000000006d RBX: ffff88802515e5f0 RCX: 58e87076363f5a00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff88802a019008 R08: ffffffff81717aac R09: 1ffff920013acf04
R10: dffffc0000000000 R11: fffff520013acf05 R12: dffffc0000000000
R13: ffff88802a018000 R14: ffff88802515e5e8 R15: ffff88802a019048
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff08f2c4110 CR3: 0000000074918000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
