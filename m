Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4153A793322
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbjIFBDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIFBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:03:53 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC5D1A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 18:03:49 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1c0888c175fso31339395ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 18:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693962229; x=1694567029;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3o4aqefOnfZZp0bGQqmL+DEsPalW2hv9Y52VLM2n/+E=;
        b=iuPlFdNnJHhLwR9UIPJmm4ZUpGKl8GAMIHPwGONgl3Be0wWNp5QKCwmYbzIe1X5bNq
         HODM0B+j4yr31RnBpPB4OR14dI2re7grS1eP+V5IMXNV3RlClQOeE6xoGxHZlbjCuFo2
         pxiBPRscQ8ifRXlrp1VUrAFgFJKYb8zY2ogEYV759ezCAXdNWitLoqqShwrIshm7W0mp
         olsuVZ2GqSf+7nS8m/Rp5i0TpXgSMNKz2ighYu0He1dENQ8NoY1WJOOLTfTX8yz/AUJe
         FmAv1xtODRl0Uz1iJyNf7mDrqbTbK7MsUrBj1w2UDsCIUJJY2vGDzXwXNfSl+xvuPnNT
         kqHA==
X-Gm-Message-State: AOJu0YyCPrKj5xQP8HlzYhq9gmWZ3z++gTI8/83zX4PGtLsWWASqgdbL
        atSX6n27AJw6gFoO41Ruq3J4YhTHqJqNADdCN5RWjjlKGOq1
X-Google-Smtp-Source: AGHT+IFFI9N6cY9cl66efcyaJW5lci61+71otZof8ZgRRCX+mkdAHvpx3mcdAE0ahKvfSX+/+4If/MEvsQ2heW7Ms08DJyVeVR8/
MIME-Version: 1.0
X-Received: by 2002:a17:903:2452:b0:1b8:a555:7615 with SMTP id
 l18-20020a170903245200b001b8a5557615mr4991082pls.9.1693962229484; Tue, 05 Sep
 2023 18:03:49 -0700 (PDT)
Date:   Tue, 05 Sep 2023 18:03:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f392a60604a65085@google.com>
Subject: [syzbot] [mm?] kernel BUG in vma_replace_policy
From:   syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a47fc304d2b6 Add linux-next specific files for 20230831
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16502ddba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ecd2a74f20953b9
dashboard link: https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120e7d70680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1523f9c0680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2e8f4217527/disk-a47fc304.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc09339/vmlinux-a47fc304.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd9b2475bf5a/bzImage-a47fc304.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com

vma ffff888077381a00 start 0000000020c2a000 end 0000000021000000 mm ffff8880258a8980
prot 25 anon_vma 0000000000000000 vm_ops 0000000000000000
pgoff 20c2a file 0000000000000000 private_data 0000000000000000
flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|account|softdirty)
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:733!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5040 Comm: syz-executor418 Not tainted 6.5.0-next-20230831-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:vma_assert_write_locked include/linux/mm.h:733 [inline]
RIP: 0010:vma_assert_write_locked include/linux/mm.h:729 [inline]
RIP: 0010:vma_replace_policy+0x406/0x4e0 mm/mempolicy.c:783
Code: ff 48 89 ef e8 db 78 ff ff e9 83 fe ff ff e8 d1 7c ad ff 4c 89 e7 e8 a9 86 eb ff 0f 0b e8 c2 7c ad ff 48 89 df e8 fa 83 eb ff <0f> 0b e8 b3 7c ad ff 41 89 ec e9 58 fe ff ff 48 c7 c7 d0 55 ce 8e
RSP: 0018:ffffc9000395fc58 EFLAGS: 00010282
RAX: 000000000000011b RBX: ffff888077381a00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816b9a92 RDI: 0000000000000005
RBP: ffff888014a7e030 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000015
R13: 0000000000000016 R14: 0000000000000001 R15: 0000000021000000
FS:  0000555556684380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd277b0020 CR3: 00000000773e1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mbind_range+0x37c/0x530 mm/mempolicy.c:855
 do_mbind+0x583/0xa00 mm/mempolicy.c:1345
 kernel_mbind+0x1d4/0x1f0 mm/mempolicy.c:1502
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb959069369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd276bed98 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007ffd276bef78 RCX: 00007fb959069369
RDX: 0000000000000004 RSI: 0000000000c00000 RDI: 0000000020400000
RBP: 00007fb9590dc610 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd276bef68 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vma_assert_write_locked include/linux/mm.h:733 [inline]
RIP: 0010:vma_assert_write_locked include/linux/mm.h:729 [inline]
RIP: 0010:vma_replace_policy+0x406/0x4e0 mm/mempolicy.c:783
Code: ff 48 89 ef e8 db 78 ff ff e9 83 fe ff ff e8 d1 7c ad ff 4c 89 e7 e8 a9 86 eb ff 0f 0b e8 c2 7c ad ff 48 89 df e8 fa 83 eb ff <0f> 0b e8 b3 7c ad ff 41 89 ec e9 58 fe ff ff 48 c7 c7 d0 55 ce 8e
RSP: 0018:ffffc9000395fc58 EFLAGS: 00010282
RAX: 000000000000011b RBX: ffff888077381a00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816b9a92 RDI: 0000000000000005
RBP: ffff888014a7e030 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000015
R13: 0000000000000016 R14: 0000000000000001 R15: 0000000021000000
FS:  0000555556684380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd277b0020 CR3: 00000000773e1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
