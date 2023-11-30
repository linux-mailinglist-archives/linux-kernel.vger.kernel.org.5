Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F467FF55F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjK3Q2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjK3Q2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:28:14 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E611A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:28:20 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c1af03481bso1048206a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361700; x=1701966500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbtCAq5mjC8KNiC8wJoTaHulbhokeFhHKjqid/82Iuk=;
        b=TOtdTxxyAs5/oDChYXcn84ERb1zgpPQ2NWBNoW2yWIRBcejImck5ZVIYI2twS22d+Q
         mpJlxx24hfKyKTi9Y2Pu93WvpH2PtUCWwOW8H5CDZfuEPVQqAiflg5PHCL4719db4KZf
         IM2rGtpqYL3oi3ArX8h/dfHisB7jzyZCGZBmAwcfhgZ1ZTXBs2jrEtr9KqdQkx7cXWu/
         HyrMYHqs8HeXMMBXmWOiViw3S3kQpKf2msrZfk0vE7w0lQ2AhgjA5sZFAhxB8xvtgxED
         0uwViBTjn8NmOyogGrvnfOzzl7xuPTgBa2NfNMIrREQ6q8T8sUVEfU1lzO0tiF6uZ/a8
         yNiA==
X-Gm-Message-State: AOJu0YwcxNhmeAVfPPM0ZgGt0x75kFsGvcBZGp8iB8Ct/JXlwIVJXrP1
        95ZnXAhWQgMy8WbqWNpg+ONLz6A/CwCI9NQc7bNKqSKndq/5
X-Google-Smtp-Source: AGHT+IF/1TELdciRNYQBh/T8lPRx2GMSNFh8lX3VG61Sb/uKB+YGKNJ8pvGZ8XFesSWYVVtUL4Owr1zynZvaG8M9OaccmHN0wIFg
MIME-Version: 1.0
X-Received: by 2002:a63:5864:0:b0:5bd:64f8:ca66 with SMTP id
 i36-20020a635864000000b005bd64f8ca66mr3564659pgm.1.1701361699758; Thu, 30 Nov
 2023 08:28:19 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:28:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfae51060b6123ba@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: null-ptr-deref Write in unix_stream_bpf_update_proto
From:   syzbot <syzbot+e8030702aefd3444fb9e@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org,
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

HEAD commit:    300fbb247eb3 Merge tag 'wireless-2023-11-29' of git://git...
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=115f1a54e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=e8030702aefd3444fb9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16929b52e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108a528ce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/882903ce12c3/disk-300fbb24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd633c35425c/vmlinux-300fbb24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e400d04e154e/bzImage-300fbb24.xz

The issue was bisected to:

commit 8866730aed5100f06d3d965c22f1c61f74942541
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Wed Nov 29 01:25:56 2023 +0000

    bpf, sockmap: af_unix stream sockets need to hold ref for pair sock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1635a52ce80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1535a52ce80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1135a52ce80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8030702aefd3444fb9e@syzkaller.appspotmail.com
Fixes: 8866730aed51 ("bpf, sockmap: af_unix stream sockets need to hold ref for pair sock")

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: null-ptr-deref in sock_hold include/net/sock.h:777 [inline]
BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
Write of size 4 at addr 0000000000000080 by task syz-executor360/5073

CPU: 1 PID: 5073 Comm: syz-executor360 Not tainted 6.7.0-rc2-syzkaller-00143-g300fbb247eb3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 sock_hold include/net/sock.h:777 [inline]
 unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
 sock_map_init_proto net/core/sock_map.c:190 [inline]
 sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
 sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
 sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
 bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
 map_update_elem+0x622/0x890 kernel/bpf/syscall.c:1526
 __sys_bpf+0x1bfb/0x4920 kernel/bpf/syscall.c:5371
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f1c8f3fe369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd877e4a58 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffd877e4c28 RCX: 00007f1c8f3fe369
RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000002
RBP: 00007f1c8f471610 R08: 00007ffd877e4c28 R09: 00007ffd877e4c28
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd877e4c18 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
