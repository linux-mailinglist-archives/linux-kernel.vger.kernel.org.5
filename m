Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA307AA7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjIVEv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIVEvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:51:53 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115EC194
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:51:46 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3ade9e00118so2478727b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695358305; x=1695963105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soFbprgcrBvp6iSkOZ0K+CA6AdLh6QbW+/lp9BNjVAo=;
        b=Jh3PMtxkvRTYYtBOLfzNLrAIZvesWqT/gLevWN6MVBV+9nRi+2drbAojm8LQzgD42j
         4h3Ny97cEg0eRVk5WD/7FRhcZIoseX4CElWzy6PwtHyYqIzeirbx0jZAZogIvo0PFCvA
         AP7SfMnh6Fetdb+daWo0TNk5+ruz7qAOHrHHbLq2P8WjmRnKCs8FoB3ob0/UL97womBs
         +Nu2LnEZguGm8u3EDgJ5hg8BFNC+p1lTlDcitNreXxy7iOaFlaC/4mNa9apfZSlPN6+6
         leUqv7Ve67F16jZnJXKAKqcF3jvZqMe9t9LB7UIDP+H4vjMfe2NnFjO+sqHxWg5gCc8L
         WNIw==
X-Gm-Message-State: AOJu0Yz55HTa657Vwce43aS9dxoQ451hDsd+yg67OXe+mx5te+wiw4xX
        iBLJ6s0EnO5kStIGhtOtDu3mG2H9ySJdCF+IX5OmGZjmv+QH
X-Google-Smtp-Source: AGHT+IEKseYWmn4Z0Npyyco87WBo3cXXZuePCIN+JQtv+9i91m1I3biA30GH/2jRUH1Pay2PYrsZP1dBywrvsEw2QzvHOb5fAZbF
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a20:b0:3ad:adea:3f11 with SMTP id
 bk32-20020a0568081a2000b003adadea3f11mr4055679oib.11.1695358305488; Thu, 21
 Sep 2023 21:51:45 -0700 (PDT)
Date:   Thu, 21 Sep 2023 21:51:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090d6a00605eb5de9@google.com>
Subject: [syzbot] [mm?] linux-next test error: WARNING in page_add_anon_rmap
From:   syzbot <syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7fc7222d9680 Add linux-next specific files for 20230918
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13acae54680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79253779bcbe3130
dashboard link: https://syzkaller.appspot.com/bug?extid=6ccbcd15a17f3e1cde38
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82da18e596ba/disk-7fc7222d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e71084ae5e0/vmlinux-7fc7222d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f412e76b12e4/bzImage-7fc7222d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com

 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3df0 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x11c/0x640 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x8f0 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5053 at mm/rmap.c:1252 page_add_anon_rmap+0xc33/0x1a70 mm/rmap.c:1252
Modules linked in:
CPU: 0 PID: 5053 Comm: syz-fuzzer Not tainted 6.6.0-rc2-next-20230918-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:page_add_anon_rmap+0xc33/0x1a70 mm/rmap.c:1252
Code: 48 c1 eb 11 83 e3 01 89 de e8 99 aa b8 ff 84 db 0f 84 36 fb ff ff e8 5c af b8 ff 48 c7 c6 40 89 99 8a 4c 89 e7 e8 dd 02 f7 ff <0f> 0b e9 1b fb ff ff e8 41 af b8 ff 49 89 dd 31 ff 41 81 e5 ff 0f
RSP: 0018:ffffc900039af6b8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801aad3b80 RSI: ffffffff81cf4673 RDI: ffffffff8ae94460
RBP: ffff88801d45a400 R08: 0000000000000000 R09: fffffbfff1d9d0aa
R10: ffffffff8ece8557 R11: 0000000000000001 R12: ffffea00019e0000
R13: 00fff800000a0078 R14: 0000000000000000 R15: ffffea0001a9b988
FS:  000000c000bec490(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00148d000 CR3: 00000000744da000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __split_huge_pmd_locked mm/huge_memory.c:2276 [inline]
 __split_huge_pmd+0x17d5/0x31e0 mm/huge_memory.c:2320
 zap_pmd_range mm/memory.c:1550 [inline]
 zap_pud_range mm/memory.c:1600 [inline]
 zap_p4d_range mm/memory.c:1621 [inline]
 unmap_page_range+0xf13/0x2c00 mm/memory.c:1642
 unmap_single_vma+0x194/0x2b0 mm/memory.c:1688
 zap_page_range_single+0x324/0x4e0 mm/memory.c:1764
 madvise_dontneed_single_vma mm/madvise.c:822 [inline]
 madvise_dontneed_free mm/madvise.c:903 [inline]
 madvise_vma_behavior+0xbb0/0x1d00 mm/madvise.c:1042
 madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1267
 do_madvise+0x333/0x660 mm/madvise.c:1447
 __do_sys_madvise mm/madvise.c:1460 [inline]
 __se_sys_madvise mm/madvise.c:1458 [inline]
 __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1458
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x46b677
Code: 8b 24 24 48 8b 6c 24 10 48 83 c4 18 c3 cc cc cc cc cc cc 48 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 48 c7 c0 1c 00 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14
RSP: 002b:000000c000065d70 EFLAGS: 00000202 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 000000000016e000 RCX: 000000000046b677
RDX: 0000000000000004 RSI: 000000000016e000 RDI: 000000c001692000
RBP: 000000c000065db0 R08: 0000000000200000 R09: 000080c0017fffff
R10: 0000000001134fa0 R11: 0000000000000202 R12: 0000000001134f20
R13: 0000000000000003 R14: 000000c000007ba0 R15: 0000000001134f60
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
