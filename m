Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB2B75EB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGXGXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXGXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:23:19 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7CE55
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:23:14 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a41e98b337so8237631b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690179794; x=1690784594;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7uKJzEL5J+lzLSb0bV+bGIPWTYsGpRP0191adOuOB8=;
        b=gsw2lnjJpXXs8gWDB9OCuLPwevuBQnINgP9D0sSdJ0FW6omFcodJQfXa7Cz6oMPieq
         KRK7C3QJRU9J6utKWXWN7MUk7te7D6DXXaO8TAZsXl9oMYe9j+Nbllar2mgPHG5/4+bQ
         +FTpvZCsJ/NeXePVTWFEUMpaX4Uf/lxCWZDA96Ys7oFdg+VjEy8Brfes3RGhgWJXzHkL
         OkYS4WQW+LrKr5xpueo7ZV3ri0o5dSI7OcDt3NuHga0AOZXVpLdkr2qlNtOEP+/0cRvk
         9tCvO7oFusOGqSQcb2gPtAF+GvTOHg2uxG4p25YVNF0AxcFhRphEXI1lqzUBC5GQ667w
         Ewng==
X-Gm-Message-State: ABy/qLZJIsEmeWHkoIc2O+J+NaK9bBaB3lxBwJOGupbBpNBkCCCVsAEQ
        c8vUh/NAybdvYGWZR/UWdXWwONkPQLyaVcLPYeuz72P/B03B
X-Google-Smtp-Source: APBJJlF0ojjp16l7Q1l7Nr8WRVXlxhacPOP63GyfN0e29Sgb1aEKy1fTUvqx3nFUzgRq9PVAhE3LKwSqf3Ndg1rbiRFmB0k56zbB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1810:b0:3a4:1265:67e7 with SMTP id
 bh16-20020a056808181000b003a4126567e7mr16800324oib.8.1690179794040; Sun, 23
 Jul 2023 23:23:14 -0700 (PDT)
Date:   Sun, 23 Jul 2023 23:23:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003afcb4060135a664@google.com>
Subject: [syzbot] [kernel?] general protection fault in arch_tlbbatch_flush
From:   syzbot <syzbot+5759bce381cb6f9c51fa@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c58c49dd8932 Add linux-next specific files for 20230720
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16dc3a9ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27d64413bce3a1d8
dashboard link: https://syzkaller.appspot.com/bug?extid=5759bce381cb6f9c51fa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f484ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e4a4e6a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e4bcbe4cabb/disk-c58c49dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f914705f688f/vmlinux-c58c49dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc19caf12e86/bzImage-c58c49dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5759bce381cb6f9c51fa@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc00000000fe: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000007f0-0x00000000000007f7]
CPU: 1 PID: 31 Comm: kcompactd0 Not tainted 6.5.0-rc2-next-20230720-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:mm_has_notifiers include/linux/mmu_notifier.h:282 [inline]
RIP: 0010:mmu_notifier_arch_invalidate_secondary_tlbs include/linux/mmu_notifier.h:489 [inline]
RIP: 0010:arch_tlbbatch_flush+0x3d8/0x560 arch/x86/mm/tlb.c:1268
Code: 03 80 3c 02 00 0f 85 f3 00 00 00 48 8b 9b 28 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bb f0 07 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c0 00 00 00 48 83 bb f0 07 00 00 00 75 62 48 83
RSP: 0018:ffffc90000a7f5d0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000000fe RSI: ffffffff813b2ae5 RDI: 00000000000007f0
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880b993bbc0
R13: 0000000000000001 R14: ffffc90000a7f8d8 R15: ffffea0000314b48
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd5da70d80 CR3: 000000002a6e2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 try_to_unmap_flush+0x6b/0xf0 mm/rmap.c:621
 migrate_pages_batch+0x2524/0x2c70 mm/migrate.c:1740
 migrate_pages_sync mm/migrate.c:1822 [inline]
 migrate_pages+0x1a01/0x2640 mm/migrate.c:1926
 compact_zone+0x1cee/0x3f60 mm/compaction.c:2512
 proactive_compact_node+0x118/0x1d0 mm/compaction.c:2777
 kcompactd+0x710/0xd80 mm/compaction.c:3097
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mm_has_notifiers include/linux/mmu_notifier.h:282 [inline]
RIP: 0010:mmu_notifier_arch_invalidate_secondary_tlbs include/linux/mmu_notifier.h:489 [inline]
RIP: 0010:arch_tlbbatch_flush+0x3d8/0x560 arch/x86/mm/tlb.c:1268
Code: 03 80 3c 02 00 0f 85 f3 00 00 00 48 8b 9b 28 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bb f0 07 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c0 00 00 00 48 83 bb f0 07 00 00 00 75 62 48 83
RSP: 0018:ffffc90000a7f5d0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000000fe RSI: ffffffff813b2ae5 RDI: 00000000000007f0
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880b993bbc0
R13: 0000000000000001 R14: ffffc90000a7f8d8 R15: ffffea0000314b48
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000c776000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 f3 00 00 00    	jne    0xfd
   a:	48 8b 9b 28 05 00 00 	mov    0x528(%rbx),%rbx
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	48 8d bb f0 07 00 00 	lea    0x7f0(%rbx),%rdi
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 c0 00 00 00    	jne    0xf3
  33:	48 83 bb f0 07 00 00 	cmpq   $0x0,0x7f0(%rbx)
  3a:	00
  3b:	75 62                	jne    0x9f
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
