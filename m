Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC57E0C16
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKCXLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjKCXLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:11:30 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9871BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:11:27 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3b51e0bd5c0so3881791b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053087; x=1699657887;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvhMA5vwNRzWu65SJGEeddhJb2JU6sR1loI4Z11L+Zw=;
        b=sNV3V5EERago4GpxNo+1uukXcMkcbDFvWDF+A7UrYJt1hIaJtR1BviuaoPR+HYWCMV
         p2joWd+LyKmW/TMLWtoes7tEN32DLL3dhuad4kpjvPJ4BU0+3LEAl4hyFKczMS/T4soo
         inyEmMBHRcWmcR8C2/uWD61Vhj3o6h0acie9gipu1BCGh2Es57tCdNo3iYse/ssby5Ni
         FsmKqyks1neGGe2U8OJ8gEosplSvZYUwXcT43aw72QjbROGysVtuBaCjTp+240TLLvOO
         MDjousgz2lbA8AxslU7C4eXevvky1pXOykOg2NL1Op7I2/ikLNTwF3VTK+mvCdv53vlK
         bzWQ==
X-Gm-Message-State: AOJu0YwAzjTJxmzYyPbgB0WOjLjJOZp2XRYrNJu5jrwxXgQWrTuna244
        aBX0qwP2b3EW3OjRE2AENGErSDecKvOATs924GExfG+MbnmS
X-Google-Smtp-Source: AGHT+IEbOT7zy+LOW+19lFyQcULJd8dT0Zo0D+pVBfsaG8eEoTVRz58N2hSTZsSI9U71l/7MRC0GYFl414x/Us/Sf3QmEm4NuwZE
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a8:b0:3a7:3737:60fd with SMTP id
 bj40-20020a05680819a800b003a7373760fdmr8317522oib.7.1699053087289; Fri, 03
 Nov 2023 16:11:27 -0700 (PDT)
Date:   Fri, 03 Nov 2023 16:11:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8f8610609479fa3@google.com>
Subject: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in sk_psock_verdict_data_ready
From:   syzbot <syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    55c900477f5b net: fill in MODULE_DESCRIPTION()s under driv..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12586b51680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429fa76d04cf393c
dashboard link: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154a6ac7680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c2f876eca348/disk-55c90047.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fae06633f86c/vmlinux-55c90047.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9bdbf63cb857/bzImage-55c90047.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 637d5067 P4D 637d5067 PUD 631c2067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6103 Comm: syz-executor.1 Not tainted 6.6.0-rc7-syzkaller-02075-g55c900477f5b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000314f868 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888028b0b000 RCX: 0000000000000000
RDX: 1ffff1100f3c305c RSI: ffffffff8848f069 RDI: ffff888028b0b000
RBP: 0000000000000004 R08: 0000000000000007 R09: 0000000000000000
R10: ffff888079e18000 R11: 0000000000000000 R12: ffff888079e18000
R13: 0000000000000000 R14: ffff888028b0b000 R15: ffff888028b0b000
FS:  00007fc30c5666c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000025154000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sk_psock_verdict_data_ready net/core/skmsg.c:1228 [inline]
 sk_psock_verdict_data_ready+0x207/0x3d0 net/core/skmsg.c:1208
 unix_dgram_sendmsg+0x11b3/0x1ca0 net/unix/af_unix.c:2116
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x2ac/0x940 net/socket.c:2558
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2612
 __sys_sendmmsg+0x1a1/0x450 net/socket.c:2698
 __do_sys_sendmmsg net/socket.c:2727 [inline]
 __se_sys_sendmmsg net/socket.c:2724 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2724
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc30b87cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc30c5660c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fc30b99bf80 RCX: 00007fc30b87cae9
RDX: 0000000000000002 RSI: 0000000020001680 RDI: 0000000000000003
RBP: 00007fc30b8c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc30b99bf80 R15: 00007ffc0cccf7e8
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000314f868 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888028b0b000 RCX: 0000000000000000
RDX: 1ffff1100f3c305c RSI: ffffffff8848f069 RDI: ffff888028b0b000
RBP: 0000000000000004 R08: 0000000000000007 R09: 0000000000000000
R10: ffff888079e18000 R11: 0000000000000000 R12: ffff888079e18000
R13: 0000000000000000 R14: ffff888028b0b000 R15: ffff888028b0b000
FS:  00007fc30c5666c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000025154000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
