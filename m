Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD77F0830
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjKSRxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSRx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:53:29 -0500
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183A115
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:53:25 -0800 (PST)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-5be09b7d01fso3964292a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700416405; x=1701021205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+W4dYR6p0MuCMx9i/Xtc7RR141me0vHWQgYK7bRbNg=;
        b=CTEN/J3+GI5Z/uOnC1Ky8Yq9ikPiRyRD3YEiv2MqRMGamw7g9k1+cR6iWhJaFNSrHi
         GxKRFNcFfqo9AuIUxh+Xm2KNF1DuXzJwmlHjc7zZTl0Qbz51aUSrWoekOXqH0fMm7iRr
         WaAFxTbcEOiszTzzDLlmvfIRKyIm8gWxBWtxcnTgRY+WR5bjP45qB/vj3KPHDY4/EVP/
         pX0r7G0ZOeJSDAqO2dchmX4bwSbZBiszVgLwEGx9UYyw9yBrgyhbEd/N+pJZgznkn2MB
         CHb9pceGZiy0O3ZQqkrzslHqUXxD1ywwaoQo63fDVtBqQDpb9EXKnPvttoIX0z4fQbBY
         88qg==
X-Gm-Message-State: AOJu0Yx48kM129bdqCkOTEUaXkTLAkjOl7xST569wSxVUWBqg3uiu75s
        1twFif0UtmyOe/rUNWODhh4zJ+HyAwipAVEcyNsqRHJTxLgw
X-Google-Smtp-Source: AGHT+IEqIGz+YeHEMA6P+E8B/HMO3WfmjvdWVyuJwyb3E3y4ggX2Fl8SK/FTmiqdGjMUzrFj9PmZHrMi1IBWIjDDklb5DB96BB/W
MIME-Version: 1.0
X-Received: by 2002:a63:e110:0:b0:5bd:a359:7e0a with SMTP id
 z16-20020a63e110000000b005bda3597e0amr1118829pgh.9.1700416404863; Sun, 19 Nov
 2023 09:53:24 -0800 (PST)
Date:   Sun, 19 Nov 2023 09:53:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c84343060a850bd0@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in copy_from_kernel_nofault
From:   syzbot <syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, bp@suse.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
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

HEAD commit:    1fda5bb66ad8 bpf: Do not allocate percpu memory at init st..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d99420e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae0ccd6bfde5eb0
dashboard link: https://syzkaller.appspot.com/bug?extid=72aa0161922eba61b50e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dff22f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1027dc70e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e24d257ce8d/disk-1fda5bb6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eaa9caffb0e4/vmlinux-1fda5bb6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16182bbed726/bzImage-1fda5bb6.xz

The issue was bisected to:

commit ca247283781d754216395a41c5e8be8ec79a5f1c
Author: Andy Lutomirski <luto@kernel.org>
Date:   Wed Feb 10 02:33:45 2021 +0000

    x86/fault: Don't run fixups for SMAP violations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103d92db680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=123d92db680000
console output: https://syzkaller.appspot.com/x/log.txt?x=143d92db680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
Fixes: ca247283781d ("x86/fault: Don't run fixups for SMAP violations")

BUG: unable to handle page fault for address: ffffffffff600000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD cd7a067 P4D cd7a067 PUD cd7c067 PMD cd9f067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5071 Comm: syz-executor322 Not tainted 6.6.0-syzkaller-15867-g1fda5bb66ad8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:copy_from_kernel_nofault mm/maccess.c:36 [inline]
RIP: 0010:copy_from_kernel_nofault+0x86/0x240 mm/maccess.c:24
Code: ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ab 01 00 00 41 83 85 6c 17 00 00 01 eb 1e e8 ba 23 cf ff <48> 8b 45 00 49 89 04 24 48 83 c5 08 49 83 c4 08 48 83 eb 08 e8 a1
RSP: 0018:ffffc900038d7ae8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffffffff81b8690c
RDX: ffff888016ab0000 RSI: ffffffff81b868e6 RDI: 0000000000000007
RBP: ffffffffff600000 R08: 0000000000000007 R09: 0000000000000007
R10: 0000000000000008 R11: 0000000000000001 R12: ffffc900038d7b30
R13: ffff888016ab0000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000000cd77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_probe_read_kernel_common include/linux/bpf.h:2747 [inline]
 ____bpf_probe_read_kernel kernel/trace/bpf_trace.c:236 [inline]
 bpf_probe_read_kernel+0x26/0x70 kernel/trace/bpf_trace.c:233
 bpf_prog_bd8b22826c103b08+0x42/0x44
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2307 [inline]
 bpf_trace_run2+0x14e/0x410 kernel/trace/bpf_trace.c:2346
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0xec/0x150 mm/slab_common.c:1043
 vma_numab_state_free include/linux/mm.h:638 [inline]
 __vm_area_free+0x3e/0x140 kernel/fork.c:525
 remove_vma+0x128/0x170 mm/mmap.c:146
 exit_mmap+0x453/0xa70 mm/mmap.c:3332
 __mmput+0x12a/0x4d0 kernel/fork.c:1349
 mmput+0x62/0x70 kernel/fork.c:1371
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9ad/0x2ae0 kernel/exit.c:858
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe1c24c2dc9
Code: Unable to access opcode bytes at 0x7fe1c24c2d9f.
RSP: 002b:00007ffd4d4b8dc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe1c24c2dc9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fe1c253e290 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe1c253e290
R13: 0000000000000000 R14: 00007fe1c253ece0 R15: 00007fe1c2494030
 </TASK>
Modules linked in:
CR2: ffffffffff600000
---[ end trace 0000000000000000 ]---
RIP: 0010:copy_from_kernel_nofault mm/maccess.c:36 [inline]
RIP: 0010:copy_from_kernel_nofault+0x86/0x240 mm/maccess.c:24
Code: ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ab 01 00 00 41 83 85 6c 17 00 00 01 eb 1e e8 ba 23 cf ff <48> 8b 45 00 49 89 04 24 48 83 c5 08 49 83 c4 08 48 83 eb 08 e8 a1
RSP: 0018:ffffc900038d7ae8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffffffff81b8690c
RDX: ffff888016ab0000 RSI: ffffffff81b868e6 RDI: 0000000000000007
RBP: ffffffffff600000 R08: 0000000000000007 R09: 0000000000000007
R10: 0000000000000008 R11: 0000000000000001 R12: ffffc900038d7b30
R13: ffff888016ab0000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000000cd77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	03 0f                	add    (%rdi),%ecx
   2:	b6 14                	mov    $0x14,%dh
   4:	02 48 89             	add    -0x77(%rax),%cl
   7:	f8                   	clc
   8:	83 e0 07             	and    $0x7,%eax
   b:	83 c0 03             	add    $0x3,%eax
   e:	38 d0                	cmp    %dl,%al
  10:	7c 08                	jl     0x1a
  12:	84 d2                	test   %dl,%dl
  14:	0f 85 ab 01 00 00    	jne    0x1c5
  1a:	41 83 85 6c 17 00 00 	addl   $0x1,0x176c(%r13)
  21:	01
  22:	eb 1e                	jmp    0x42
  24:	e8 ba 23 cf ff       	call   0xffcf23e3
* 29:	48 8b 45 00          	mov    0x0(%rbp),%rax <-- trapping instruction
  2d:	49 89 04 24          	mov    %rax,(%r12)
  31:	48 83 c5 08          	add    $0x8,%rbp
  35:	49 83 c4 08          	add    $0x8,%r12
  39:	48 83 eb 08          	sub    $0x8,%rbx
  3d:	e8                   	.byte 0xe8
  3e:	a1                   	.byte 0xa1


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
