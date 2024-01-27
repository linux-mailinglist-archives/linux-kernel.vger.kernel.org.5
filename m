Return-Path: <linux-kernel+bounces-40935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5A883E872
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986222871AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D85A50;
	Sat, 27 Jan 2024 00:25:43 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA8630
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315142; cv=none; b=eEyVjTYOuAj729R2wXkIqFFIiYzgm8/9OZJmle6tdCxluFvYWo5CTtTPz+UuUvj0wmlmMr5OqSrIdoTUY4mcnxGR0CLbinh2k3yLKvEy29N0letarramDFyjnRu+9/uLkU6DZHSs3qWynDV5pEqYSeQvEEWkqWaV7CQFXqzzKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315142; c=relaxed/simple;
	bh=i2x6TsOCNKwsjrmJmt15rpJsTG0hcCH3wOJxDBhRbjI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ESZz1xUJurrvy6kd2LEAOZBW6akRFG+YARjsIcbabeYWXrZKLvtJ699QdMpKk7PicUW/n+SY3jhL+0VAI74be9cfYnmSnQAP0pgvIryvkkEs/N13at6YtADn/+WWkR00z5Avjd/ArunvV5HYX8TjMmDcDZ+jSnLlwPGQ77D9zNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-361b0f701c4so3226065ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706315140; x=1706919940;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43e4mwtZQx1GOZZ69e5l5zLYoi2x5hsSS1zwVIJMBSg=;
        b=cOe2WALB3wgN2Q8CRJo4FLkRgByft3wTLrzgERe5T2zapsfgbuKkcQFc1OIheSfTDn
         yxK2CrBTkeIEHo5SN1NnNNoDKVpfNI1xGONHgEfBM+aO1rJ9Hke7dKU8oRDzBV40yJr6
         O7U2Vy/te7Bzk/FLUC7/YMZh2NLbUjooZ1270Uj0zIQeXnBghGdx4iQcwAOVjhZo+2io
         rOmD4XZFMW5EoBNqAdC/bvGZrQfy7GvcYTfEMy1tWQHv8cwi1hKKSJXtWaOy4OLFH2D5
         eq1nVYUDyk+4HV/1qlN/yBbhuAIZbWccZW6qz3ghYPodTwb4wzSoOJ1IQu3C64aGgYqQ
         XnFw==
X-Gm-Message-State: AOJu0Yyv/4LgtXpcEYZr/NYv/MY6cScckFesW4WN9A1XODg4IgRDP5OY
	yU7wTjlGhABZWsFL2zLADrXLHDPmcDo/NMGhQJvSwYivzj8GCbvo0Vnt5uOIWGSkEsuCViB1PUG
	mHIU2sdfNRm4TpxQQWlUNHa30AEH87eCOxMIW5tt/sWDkXCPwQRy8XBg=
X-Google-Smtp-Source: AGHT+IEfhpnYpZ9QqKuRVPdxGXE/qhr5bIe0ditH8EFhDYH7Vdd5EyvIGa60I0OYo/s3WoWEkgsRW+nOltv3T+rdsJ8oWmq69g7o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219a:b0:360:7c34:ffa7 with SMTP id
 j26-20020a056e02219a00b003607c34ffa7mr76346ila.1.1706315140333; Fri, 26 Jan
 2024 16:25:40 -0800 (PST)
Date: Fri, 26 Jan 2024 16:25:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d08921060fe27342@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in bpf_probe_read_compat_str
From: syzbot <syzbot+239f12e20785af44332c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, bp@suse.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dbc153fd3c14 net/smc: fix illegal rmb_desc access in SMC-D..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111f4053e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=719e6acaf392d56b
dashboard link: https://syzkaller.appspot.com/bug?extid=239f12e20785af44332c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1174113be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15065573e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03c4609fe0f7/disk-dbc153fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d96e02c115d/vmlinux-dbc153fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3acdf2bb45e3/bzImage-dbc153fd.xz

The issue was bisected to:

commit ca247283781d754216395a41c5e8be8ec79a5f1c
Author: Andy Lutomirski <luto@kernel.org>
Date:   Wed Feb 10 02:33:45 2021 +0000

    x86/fault: Don't run fixups for SMAP violations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ba553be80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15ba553be80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11ba553be80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+239f12e20785af44332c@syzkaller.appspotmail.com
Fixes: ca247283781d ("x86/fault: Don't run fixups for SMAP violations")

BUG: unable to handle page fault for address: ffffffffff600000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD cf7b067 P4D cf7b067 PUD cf7d067 PMD cfa0067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5063 Comm: syz-executor178 Not tainted 6.7.0-syzkaller-12263-gdbc153fd3c14 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:strncpy_from_kernel_nofault+0xc4/0x270 mm/maccess.c:91
Code: 83 85 6c 17 00 00 01 48 8b 2c 24 eb 18 e8 84 76 ce ff 4c 89 f6 4c 89 ef e8 89 71 ce ff 4d 39 f5 7d 5c 4c 89 fb e8 6c 76 ce ff <44> 8a 65 00 e8 63 76 ce ff 48 89 d8 48 89 da 48 b9 00 00 00 00 00
RSP: 0018:ffffc90003a6f990 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc90003a6fa00 RCX: ffffffff81b9aaa2
RDX: ffff888028743b80 RSI: ffffffff81b9ab14 RDI: ffff8880287452ec
RBP: ffffffffff600000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000008
R13: ffffffffff600000 R14: 0000000000000008 R15: ffffffffff600000
FS:  00005555560c2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000007a3e2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_probe_read_kernel_str_common kernel/trace/bpf_trace.c:266 [inline]
 ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:314 [inline]
 bpf_probe_read_compat_str+0x12f/0x170 kernel/trace/bpf_trace.c:307
 bpf_prog_f17ebaf3f5f7baf8+0x42/0x44
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x173/0x450 kernel/trace/bpf_trace.c:2422
 __bpf_trace_sched_switch+0x13e/0x180 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2235/0x5c00 kernel/sched/core.c:6724
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 ptrace_stop.part.0+0x44d/0x950 kernel/signal.c:2344
 ptrace_stop kernel/signal.c:2246 [inline]
 ptrace_do_notify+0x226/0x2d0 kernel/signal.c:2381
 ptrace_notify+0xc8/0x130 kernel/signal.c:2393
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:167 [inline]
 syscall_exit_to_user_mode_prepare+0x126/0x230 kernel/entry/common.c:194
 __syscall_exit_to_user_mode_work kernel/entry/common.c:199 [inline]
 syscall_exit_to_user_mode+0x11/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe0/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f69162d5b39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7c688218 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: 0000000000000004 RBX: 0000000000000000 RCX: 00007f69162d5b39
RDX: 0000000000000010 RSI: 0000000020000280 RDI: 0000000000000011
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000003a28
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: ffffffffff600000
---[ end trace 0000000000000000 ]---
RIP: 0010:strncpy_from_kernel_nofault+0xc4/0x270 mm/maccess.c:91
Code: 83 85 6c 17 00 00 01 48 8b 2c 24 eb 18 e8 84 76 ce ff 4c 89 f6 4c 89 ef e8 89 71 ce ff 4d 39 f5 7d 5c 4c 89 fb e8 6c 76 ce ff <44> 8a 65 00 e8 63 76 ce ff 48 89 d8 48 89 da 48 b9 00 00 00 00 00
RSP: 0018:ffffc90003a6f990 EFLAGS: 00010093

RAX: 0000000000000000 RBX: ffffc90003a6fa00 RCX: ffffffff81b9aaa2
RDX: ffff888028743b80 RSI: ffffffff81b9ab14 RDI: ffff8880287452ec
RBP: ffffffffff600000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000008
R13: ffffffffff600000 R14: 0000000000000008 R15: ffffffffff600000
FS:  00005555560c2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000007a3e2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	83 85 6c 17 00 00 01 	addl   $0x1,0x176c(%rbp)
   7:	48 8b 2c 24          	mov    (%rsp),%rbp
   b:	eb 18                	jmp    0x25
   d:	e8 84 76 ce ff       	call   0xffce7696
  12:	4c 89 f6             	mov    %r14,%rsi
  15:	4c 89 ef             	mov    %r13,%rdi
  18:	e8 89 71 ce ff       	call   0xffce71a6
  1d:	4d 39 f5             	cmp    %r14,%r13
  20:	7d 5c                	jge    0x7e
  22:	4c 89 fb             	mov    %r15,%rbx
  25:	e8 6c 76 ce ff       	call   0xffce7696
* 2a:	44 8a 65 00          	mov    0x0(%rbp),%r12b <-- trapping instruction
  2e:	e8 63 76 ce ff       	call   0xffce7696
  33:	48 89 d8             	mov    %rbx,%rax
  36:	48 89 da             	mov    %rbx,%rdx
  39:	48                   	rex.W
  3a:	b9 00 00 00 00       	mov    $0x0,%ecx


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

