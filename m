Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9680ED9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbjLLNbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346479AbjLLNb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:31:27 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE25BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:31:32 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d9fb7402d6so3486350a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387892; x=1702992692;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEwhSkiCAHEXWU6GFKtWKs3hHe1hKKgZ81tIqA3x4I4=;
        b=CL2knlfJE99lFrRjAzdMwTgpINmM3XOryOzVEqJIV1iS5gA/Iym69AUF89L6IYGj/P
         TXw/7w0F5ddX3rqfh6/g4WNHC388qKst0WkwUiDv7esiYI/82PMsnZ0AAkTeoQXWzr2r
         gZscanMi0ayowCCVbCLYNib3BM1VXRR0CwOoIrn6/RD+PqwccSWFiAXRlDp/CONo6vx1
         hGuKHZua9+l4W3zKT/V8/TqMjvnbDGaQXkBWYdUcRVDzvG0FMTOmZSKHtl8KDuDETQMs
         IYB39LK+TVV5EZpwUmKIIRhnxNoiMBflD/dQFDYHlJKD4SVSRO7O8G+utB6PrKOMHDkX
         gIUA==
X-Gm-Message-State: AOJu0YzyJBCFIB7cFDNUpq3SULrqQc2EhA1DVI24Nn4O735cc+zAMGh9
        LZSzSOdoGV6uRhL0/IAl4EFm9JkZW91HhMWecqQd3K/3Ixko
X-Google-Smtp-Source: AGHT+IET/f8AEfECjWNt0wUJv335xzyALho0HZKH6uXH2GPYGpdS/AWIw3EKbrqgop2+MV/cXc2CFfCB/Y6ma0sV0XD/0+oMASJj
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3492:b0:6d9:ce5d:19a7 with SMTP id
 c18-20020a056830349200b006d9ce5d19a7mr5756216otu.1.1702387892047; Tue, 12 Dec
 2023 05:31:32 -0800 (PST)
Date:   Tue, 12 Dec 2023 05:31:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009354da060c5011d7@google.com>
Subject: [syzbot] linux-next test error: INFO: rcu detected stall in corrupted (2)
From:   syzbot <syzbot+3ed86348059ea02052e6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbd220ce4e29 Add linux-next specific files for 20231211
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147dc36ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=857c7631aa489aff
dashboard link: https://syzkaller.appspot.com/bug?extid=3ed86348059ea02052e6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5772438d8d39/disk-bbd220ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7580482c8fd0/vmlinux-bbd220ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b26f5e4254af/bzImage-bbd220ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ed86348059ea02052e6@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 2680 jiffies s: 601 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 1148 Comm: kworker/0:3 Not tainted 6.7.0-rc4-next-20231211-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events linkwatch_event
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: 56 c1 dd 02 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be b0 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <f3> 0f 1e fa 65 48 8b 15 f4 9a 7b 7e 65 8b 05 f5 9a 7b 7e a9 00 01
RSP: 0018:ffffc90005447c38 EFLAGS: 00000087
RAX: ffff8880743b86a8 RBX: ffff888068bbc6a8 RCX: ffffffff887dd5c0
RDX: ffff888020ac3b80 RSI: ffffffff887dd463 RDI: 0000000000000001
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: 00000000000000bd
R13: 0000000000000001 R14: ffff888068ba06a8 R15: ffff888068bbc6b0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f5683fd000 CR3: 0000000068b32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __linkwatch_run_queue+0x14b/0x460 net/core/link_watch.c:216
 linkwatch_event+0x8f/0xc0 net/core/link_watch.c:273
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
