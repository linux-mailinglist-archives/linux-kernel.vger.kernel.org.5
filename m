Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F8D7A3FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbjIRD5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjIRD5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:57:09 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878628F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:57:03 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3acfa8f8df3so5062964b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695009423; x=1695614223;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7DcxlVoyio/UsYk2pWgTqoNT0EdQFYFh4kF6XZqV0E=;
        b=EQ9UclWnnF+qfGT9JK23jkxRyUU3hh4vBDUySi6bX+CGI1lGEM1ckQCeyqo4LaLFFx
         sOV5OPthEbmvFkUskHbDxJr5J7CgcNQh45LTadyXrh4BAFKjfsthLXn52Zgqqf44fuSY
         f11jRuhgM6Z0PdzCzzD3LLwGo+ecVXbyHkCBPtDZiZryvSzqJGdvEaI9TotaWBnocAJ9
         kj9XqSFSFVYYs59WRgFkcit7xGGDyvSUwRlkZwrPydC9qKzr0ex9EAiRAhyIoDTtBpyh
         8B97dM5PvRGzmD/ayNfX/E3/8yyQhW2+PbF0aEuSnY6EODs/wpw9QVfunBD9gmI6SziE
         vPoA==
X-Gm-Message-State: AOJu0YzmDTLTmWhiAFme6pYPwnL68nz4Dq0IY0JaCYorrjPDFW2xl9pV
        qfu2f8jZQ7sdJxIvW2PbT0tvTjEW9zyfVP1Ir2Xszq72duQl
X-Google-Smtp-Source: AGHT+IHW1IInHcI6qcK1MjwZIwJV1eAYzlHMjVRMOyVFbJJXf3P+7/ksB+0qJoOe8xi1MD5u9DBzeuoq8Pe6JjkZmHwkjLEiLZ7C
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1282:b0:3a7:3b45:74ed with SMTP id
 a2-20020a056808128200b003a73b4574edmr3751141oiw.0.1695009422962; Sun, 17 Sep
 2023 20:57:02 -0700 (PDT)
Date:   Sun, 17 Sep 2023 20:57:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bf71d06059a2276@google.com>
Subject: [syzbot] [mm?] WARNING in page_add_anon_rmap
From:   syzbot <syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    98897dc735cf Add linux-next specific files for 20230914
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1214a152680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1502c503717ada5c
dashboard link: https://syzkaller.appspot.com/bug?extid=6e4f59235036c3c2e296
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15869ea0680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f1b952680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/00e4c0af5a8a/disk-98897dc7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b54a00eee56/vmlinux-98897dc7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/100094353b8e/bzImage-98897dc7.xz

The issue was bisected to:

commit b8575fa4abaa1dee1a61f1f27a86a02757310a7e
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Sep 13 12:51:12 2023 +0000

    mm/rmap: simplify PageAnonExclusive sanity checks when adding anon rmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140e9ea0680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=160e9ea0680000
console output: https://syzkaller.appspot.com/x/log.txt?x=120e9ea0680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com
Fixes: b8575fa4abaa ("mm/rmap: simplify PageAnonExclusive sanity checks when adding anon rmap")

page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1138 [inline]
 free_unref_page+0x554/0xd70 mm/page_alloc.c:2460
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6396
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3df0 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x8f0 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5039 at mm/rmap.c:1252 page_add_anon_rmap+0xc33/0x1a70 mm/rmap.c:1252
Modules linked in:
CPU: 0 PID: 5039 Comm: syz-executor266 Not tainted 6.6.0-rc1-next-20230914-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:page_add_anon_rmap+0xc33/0x1a70 mm/rmap.c:1252
Code: 48 c1 eb 11 83 e3 01 89 de e8 79 d4 b8 ff 84 db 0f 84 36 fb ff ff e8 3c d9 b8 ff 48 c7 c6 80 83 99 8a 4c 89 e7 e8 dd 02 f7 ff <0f> 0b e9 1b fb ff ff e8 21 d9 b8 ff 49 89 dd 31 ff 41 81 e5 ff 0f
RSP: 0018:ffffc90003ccf900 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801c4a5940 RSI: ffffffff81cf16a3 RDI: 0000000000000000
RBP: ffff888072c4fb00 R08: 0000000000000000 R09: fffffbfff1d9c7b2
R10: ffffffff8ece3d97 R11: 0000000000000001 R12: ffffea0001c88000
R13: 00fff800000a0078 R14: 0000000000000000 R15: ffffea0001cc4d88
FS:  0000555555943380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020123008 CR3: 000000001c4d7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __split_huge_pmd_locked mm/huge_memory.c:2276 [inline]
 __split_huge_pmd+0x17d5/0x31e0 mm/huge_memory.c:2320
 split_huge_pmd_address mm/huge_memory.c:2336 [inline]
 split_huge_pmd_if_needed mm/huge_memory.c:2348 [inline]
 split_huge_pmd_if_needed mm/huge_memory.c:2339 [inline]
 vma_adjust_trans_huge+0x2da/0x560 mm/huge_memory.c:2360
 __split_vma+0xba3/0x1070 mm/mmap.c:2376
 split_vma+0xc8/0x110 mm/mmap.c:2412
 mlock_fixup+0x9b7/0x1290 mm/mlock.c:438
 apply_vma_lock_flags+0x250/0x370 mm/mlock.c:514
 do_mlock+0x263/0x820 mm/mlock.c:610
 __do_sys_mlock mm/mlock.c:624 [inline]
 __se_sys_mlock mm/mlock.c:622 [inline]
 __x64_sys_mlock+0x59/0x80 mm/mlock.c:622
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f23893c4329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc63bf5018 EFLAGS: 00000246 ORIG_RAX: 0000000000000095
RAX: ffffffffffffffda RBX: 00007ffc63bf51f8 RCX: 00007f23893c4329
RDX: 00007f23893c4329 RSI: 0000000000001000 RDI: 00000000202cf000
RBP: 00007f2389437610 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000023a R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc63bf51e8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
