Return-Path: <linux-kernel+bounces-56061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA484C582
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD83288E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE821F933;
	Wed,  7 Feb 2024 07:16:36 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3C1F5F0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290195; cv=none; b=ItuN40lDZYw62VTgvgvffkpPpIgwnlS35GBIe61kS35MCglvunSrvYCLE8Gs6wfExJ+Csc5hm9w/Pmb5SORUD1hnOgfif5LoPSMRJPmTLYRjBKzd10UyZoZycV9RTT/DWGLjNz+JdQVyDFYKzDToUCJGezhBEJlA+l04s+ucsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290195; c=relaxed/simple;
	bh=CTsUXrTAB6nRpLhQYKfEczchp3HwG9lBYoaZemAua2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AZTmN9iDCbNUcy48/sGadvEuX7fXEChEPEP1qOM7l7kYoOzm7EYnrceTy2fcC/hb/vqZCvkCleGuyh2lnGZpVcwRqL4gIE2zKwpe1y9pp+NgT717VFSwl7qUBqIuEF9t0CfLNHcEsCod/3jGLhpcr7uBN/KKUJW2qqv6jR423eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363d5475522so1893175ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 23:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707290193; x=1707894993;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEbRscJsWpR3uA/en5wCgkuZiQ1JKpTV6p5kPNxbslk=;
        b=hxTSgY41CXlHnz59sycXjEKTZ2yaLl/3eCwwtYnYzCld38XdEltYZB+Pz0A/aKbyGH
         Ios5X0SDcFr1AoH2t188j8YH4kw8vMqA6zop1ODzFLe9AiCzejHH+Jv6lk0xFjTZaNBA
         cqvYP2z+uZHiN2WUs9zowEh+fzWheJgVaqcVsUYbCGybnw6MBgFrTtA0+rMoveX0KMCr
         TX1iEdRJ1HUJ+wGoO3oveDPgg11pvNvaUChuWDdlzu5AbA64TR28YlpsIZEjglsS6hPI
         Go/BuNJ0qKfujODIRgZH+NNZ0TGK7B2lDPYRpINhMEVUcmnqqjx4tzdaOJCZZ18YX1+H
         tZYw==
X-Forwarded-Encrypted: i=1; AJvYcCVaVXOjoxWqd5K6ESdKimhw+rT8I4RltjZo0f6+9ULpjcQuzwB+1BRvhu+5H1/8r81zMJ9rKJGGCweFkh3x51Q2q8GSSG0niiw22W6r
X-Gm-Message-State: AOJu0Yy70JS1vyADqlbld+urxlu4EOIgt0oSAsdc9J6R339mhseaBjhG
	oy9VhJ9xG+PkZl4MAPn73MVhoJAzw4764iZ8cbnRBAN+01tszGcazPpc6CcCaY/9dqU3pX5T/Fg
	Mqh0isyPDd8nObk6h2YrvRTuC56KXBXk1aoYpndplhS/+3Af3uWa44Ys=
X-Google-Smtp-Source: AGHT+IF8kxkQkmT/5KCHM1C6ZTdhk8VcSKb0boOoqBidqGLqxylxrhdpl3CiQk6xofkS39/+opYEdb+icMZGeEHbDeCdmFQ1aqyP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1748:b0:361:a872:157a with SMTP id
 y8-20020a056e02174800b00361a872157amr404588ill.6.1707290192926; Tue, 06 Feb
 2024 23:16:32 -0800 (PST)
Date: Tue, 06 Feb 2024 23:16:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a5ef50610c5799c@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in bpf_probe_read_kernel_str
From: syzbot <syzbot+a0fa177e13690b663c74@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, bp@suse.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fb3f72702fb Merge branch 'improvements-for-tracking-scala..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1356a9b7e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b95408789b2ce1a
dashboard link: https://syzkaller.appspot.com/bug?extid=a0fa177e13690b663c74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121231e4180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15419118180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df63acb4ac9d/disk-6fb3f727.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62f12d4789e3/vmlinux-6fb3f727.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3390f746a855/bzImage-6fb3f727.xz

The issue was bisected to:

commit ca247283781d754216395a41c5e8be8ec79a5f1c
Author: Andy Lutomirski <luto@kernel.org>
Date:   Wed Feb 10 02:33:45 2021 +0000

    x86/fault: Don't run fixups for SMAP violations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ab3c9fe80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ab3c9fe80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ab3c9fe80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0fa177e13690b663c74@syzkaller.appspotmail.com
Fixes: ca247283781d ("x86/fault: Don't run fixups for SMAP violations")

BUG: unable to handle page fault for address: ffffffffff600000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD df36067 P4D df36067 PUD df38067 PMD df5b067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5064 Comm: syz-executor171 Not tainted 6.8.0-rc1-syzkaller-00523-g6fb3f72702fb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:strncpy_from_kernel_nofault+0x8d/0x1d0 mm/maccess.c:91
Code: 00 48 89 d0 48 c1 e8 03 48 89 44 24 10 0f b6 04 28 84 c0 48 89 14 24 0f 85 d9 00 00 00 ff 02 45 31 f6 49 89 df 48 8b 54 24 08 <42> 8a 1c 33 4a 8d 3c 32 48 89 f8 48 c1 e8 03 49 89 ec 0f b6 04 28
RSP: 0018:ffffc90003b5f888 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffff600000 RCX: ffff88801871d940
RDX: ffffc90003b5f900 RSI: ffffffffff600000 RDI: ffffffffff600000
RBP: dffffc0000000000 R08: ffffffff8141da1d R09: 1ffffffff2591484
R10: dffffc0000000000 R11: ffffffffa0001f90 R12: ffffffffff600000
R13: 0000000000000005 R14: 0000000000000000 R15: ffffffffff600000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_probe_read_kernel_str_common kernel/trace/bpf_trace.c:266 [inline]
 ____bpf_probe_read_kernel_str kernel/trace/bpf_trace.c:275 [inline]
 bpf_probe_read_kernel_str+0x2a/0x70 kernel/trace/bpf_trace.c:272
 bpf_prog_ef3a4661c9d1378e+0x4a/0x4c
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x28e/0x380 mm/slub.c:4396
 vma_numab_state_free include/linux/mm.h:638 [inline]
 __vm_area_free+0x42/0x110 kernel/fork.c:505
 remove_vma mm/mmap.c:146 [inline]
 exit_mmap+0x6a9/0xd40 mm/mmap.c:3301
 __mmput+0x115/0x3c0 kernel/fork.c:1343
 exit_mm+0x21f/0x310 kernel/exit.c:569
 do_exit+0x9af/0x2740 kernel/exit.c:858
 do_group_exit+0x206/0x2c0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1029
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fddca0c0c89
Code: Unable to access opcode bytes at 0x7fddca0c0c5f.
RSP: 002b:00007fff7476ad38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fddca0c0c89
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fddca13b290 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fddca13b290
R13: 0000000000000000 R14: 00007fddca13bce0 R15: 00007fddca091ec0
 </TASK>
Modules linked in:
CR2: ffffffffff600000
---[ end trace 0000000000000000 ]---
RIP: 0010:strncpy_from_kernel_nofault+0x8d/0x1d0 mm/maccess.c:91
Code: 00 48 89 d0 48 c1 e8 03 48 89 44 24 10 0f b6 04 28 84 c0 48 89 14 24 0f 85 d9 00 00 00 ff 02 45 31 f6 49 89 df 48 8b 54 24 08 <42> 8a 1c 33 4a 8d 3c 32 48 89 f8 48 c1 e8 03 49 89 ec 0f b6 04 28
RSP: 0018:ffffc90003b5f888 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffff600000 RCX: ffff88801871d940
RDX: ffffc90003b5f900 RSI: ffffffffff600000 RDI: ffffffffff600000
RBP: dffffc0000000000 R08: ffffffff8141da1d R09: 1ffffffff2591484
R10: dffffc0000000000 R11: ffffffffa0001f90 R12: ffffffffff600000
R13: 0000000000000005 R14: 0000000000000000 R15: ffffffffff600000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	d0 48 c1             	rorb   -0x3f(%rax)
   6:	e8 03 48 89 44       	call   0x4489480e
   b:	24 10                	and    $0x10,%al
   d:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax
  11:	84 c0                	test   %al,%al
  13:	48 89 14 24          	mov    %rdx,(%rsp)
  17:	0f 85 d9 00 00 00    	jne    0xf6
  1d:	ff 02                	incl   (%rdx)
  1f:	45 31 f6             	xor    %r14d,%r14d
  22:	49 89 df             	mov    %rbx,%r15
  25:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
* 2a:	42 8a 1c 33          	mov    (%rbx,%r14,1),%bl <-- trapping instruction
  2e:	4a 8d 3c 32          	lea    (%rdx,%r14,1),%rdi
  32:	48 89 f8             	mov    %rdi,%rax
  35:	48 c1 e8 03          	shr    $0x3,%rax
  39:	49 89 ec             	mov    %rbp,%r12
  3c:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax


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

