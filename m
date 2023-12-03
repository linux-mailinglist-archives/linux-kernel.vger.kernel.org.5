Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91958802059
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 03:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjLCCRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 21:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCCRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 21:17:16 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C3C115
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 18:17:22 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fad1eeb333so2245191fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 18:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701569842; x=1702174642;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGzXlsAzbZiLccFkwH8GA+pyTeJhZabwV9L8aYXVjKo=;
        b=Yj00fdBweddmWlovp9AAXB3SWGoEFk99Nsdfc6V595qQJwDsbi3z52Ogr5pFSYKN+l
         62/vQDdjaDfFHE5xDL4aw1+rhsD+NQEJKObJ9JzRtucJXuMA7RMtflo/ELDqCXoytXx1
         oGQnRXPM005RwIZ5YAEXcyK9pAv+uYYICB4e2jpmSTXrKJJ49SpilCRDpHKUnDZy7m8U
         9EOxHexDPcXEhyUppKICJ5cumokth2ZVBNTW/oONA61mfGGw2WCikHmCCIOHZ6kciryf
         C5XnOlVeP0h+sgSvPs74rTIQ/J3SB7zzXH0FZrcwLqETsWrAIuW+MYnqiyMhqapK9b7Y
         OE4w==
X-Gm-Message-State: AOJu0YwSJeSFPTYzwUcReNkiLFoYIDw2xerPo/zRSJslvvOGCjKRKEtX
        QXwLvZEUuw1ty4/w/rSmrvBpbQpJNq7wKmLTb3vx/y1dLNU7
X-Google-Smtp-Source: AGHT+IH0hFtoyfkjTi/wlcQhnKQkR6jkSpzFeik5lnAZDT4v1m0WC9I7Nu68iRbHaOygebrSbFi81efNOarNRE7JGtC7ONW1IjKT
MIME-Version: 1.0
X-Received: by 2002:a05:6870:160a:b0:1fa:4e4:c49 with SMTP id
 b10-20020a056870160a00b001fa04e40c49mr2091482oae.0.1701569841976; Sat, 02 Dec
 2023 18:17:21 -0800 (PST)
Date:   Sat, 02 Dec 2023 18:17:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdfe4b060b91993f@google.com>
Subject: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From:   syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dan.carpenter@linaro.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        sidhartha.kumar@oracle.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

HEAD commit:    df60cee26a2e Merge tag '6.7-rc3-smb3-server-fixes' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ad46fce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17befd62e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5a90ce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c632017e0dc4/disk-df60cee2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f94c8fa25aeb/vmlinux-df60cee2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af80f80c708b/bzImage-df60cee2.xz

The issue was bisected to:

commit a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Date:   Tue Sep 26 19:20:17 2023 +0000

    mm/filemap: remove hugetlb special casing in filemap.c

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f61552e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140e1552e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=100e1552e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com
Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5072 Comm: syz-executor107 Not tainted 6.7.0-rc3-syzkaller-00014-gdf60cee26a2e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:pagemap_scan_backout_range fs/proc/task_mmu.c:1946 [inline]
RIP: 0010:pagemap_scan_hugetlb_entry+0x6ca/0x1130 fs/proc/task_mmu.c:2254
Code: 3c 02 00 0f 85 68 09 00 00 48 8b 83 80 00 00 00 48 8d 04 40 4d 8d 6c c5 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 51 09 00 00 4d 8b 75 00 48 8b 7c 24 08 4c 89 f6
RSP: 0018:ffffc90003a2fa50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90003a2fdb0 RCX: ffffffff82111e46
RDX: 0000000000000000 RSI: ffffffff82111e54 RDI: ffffc90003a2fe30
RBP: 1ffff92000745f52 R08: 0000000000000006 R09: 0000000020ffc000
R10: 00000000211f9000 R11: ffffffff915f5de8 R12: ffff8880299e0300
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020ffc000
FS:  0000555555c7b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 00000000752b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 walk_hugetlb_range mm/pagewalk.c:326 [inline]
 __walk_page_range+0x36c/0x770 mm/pagewalk.c:393
 walk_page_range+0x626/0xa80 mm/pagewalk.c:521
 do_pagemap_scan+0x40d/0xcd0 fs/proc/task_mmu.c:2437
 do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2478
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f171819d669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbe81bb68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffbe81bb80 RCX: 00007f171819d669
RDX: 0000000020000040 RSI: 00000000c0606610 RDI: 0000000000000003
RBP: 00007f1718210610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000286 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffbe81bdb8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pagemap_scan_backout_range fs/proc/task_mmu.c:1946 [inline]
RIP: 0010:pagemap_scan_hugetlb_entry+0x6ca/0x1130 fs/proc/task_mmu.c:2254
Code: 3c 02 00 0f 85 68 09 00 00 48 8b 83 80 00 00 00 48 8d 04 40 4d 8d 6c c5 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 51 09 00 00 4d 8b 75 00 48 8b 7c 24 08 4c 89 f6
RSP: 0018:ffffc90003a2fa50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90003a2fdb0 RCX: ffffffff82111e46
RDX: 0000000000000000 RSI: ffffffff82111e54 RDI: ffffc90003a2fe30
RBP: 1ffff92000745f52 R08: 0000000000000006 R09: 0000000020ffc000
R10: 00000000211f9000 R11: ffffffff915f5de8 R12: ffff8880299e0300
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020ffc000
FS:  0000555555c7b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 00000000752b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3c 02                	cmp    $0x2,%al
   2:	00 0f                	add    %cl,(%rdi)
   4:	85 68 09             	test   %ebp,0x9(%rax)
   7:	00 00                	add    %al,(%rax)
   9:	48 8b 83 80 00 00 00 	mov    0x80(%rbx),%rax
  10:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  14:	4d 8d 6c c5 00       	lea    0x0(%r13,%rax,8),%r13
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 ea             	mov    %r13,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 51 09 00 00    	jne    0x985
  34:	4d 8b 75 00          	mov    0x0(%r13),%r14
  38:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  3d:	4c 89 f6             	mov    %r14,%rsi


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
