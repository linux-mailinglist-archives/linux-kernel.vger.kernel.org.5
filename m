Return-Path: <linux-kernel+bounces-136217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1017E89D156
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541462872AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521C64CD0;
	Tue,  9 Apr 2024 03:53:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869863087
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634809; cv=none; b=CV7NHKutdc5nHzwksjhEVvzCwzRaypKzKBVwisuamMVFp867wBwqJMjMat1+tzAkVQBDhK/CMQRHl13FiOXNeULgctsJBv8ROV9Ah1nZODCgfYvuBSVYMg+3IE/V4sB4o2bcoZCMs13JWKzuKHTwQNe3g+5qMGhhKhtrGdEkMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634809; c=relaxed/simple;
	bh=06vTN+d8pRhXwgOwvKMUusnB5ChI+3oNMJ5UsAw8fww=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KXxoF+wo07s97wXBYpx7xCgfDdQwFMGx15fSrovfdriFoimp+M1TvC5E4jKnivLLKPhEVoJv7MtVLCXlEdWVUkUBqT0xWDrwaR0XHhsNBLq2W8HumxC/78/VyNfbOXxI8eVdDdALg/BewJrl2gP83A53rDB6anR6rLi5WmhERqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d096c4d663so678488839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 20:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712634806; x=1713239606;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDUHbU7qxbjeLelTJDOElWWcMiZCN2QW8ArLRBQh1Lg=;
        b=BN+mScexv+GfLd2i/XrN6Kch67ndUG/EaIZKpdHxTSgKqadTc+QKSKHZuUqZ8wYHry
         ddKhgEdu9ofUmVL/YV5S9rxqqy+N5gzdhym6G6D/karJBVY7/L/c1hQ7c7bDqh5Md9xB
         e9ILFvLb4GrEh4z446STbwjBmVOFjG9EfInOBdS3OcFSrUv2eErX2mqxbCgmlAlkXSod
         xDEv3kEhc+MoJ3Xx4g1SbjslYm5wTNxgqKJdM4KMvo+5R4B8A66qNELBbFeUyQkc+Ff4
         fxKC1/9q53EUI4kBRp78dmRgYbyrzvfVLIx5RkXQlv9sGK7Rt4+T0/tCliu0hI8MvhqV
         AaJw==
X-Forwarded-Encrypted: i=1; AJvYcCVeC2QmgCkPcLjVfwD8AGZhSgIXr00g0GMofSBi+3AEoL+NP+emdl7V8XEq34AiLbn3laRPhM3X07d2FExyAEnYifpzsrW7rvQBHpKj
X-Gm-Message-State: AOJu0YzMOAwJlBYLJmFeN8mrFQ70fb6+Ii0nik0mlIgFsFyo3t4MQdaJ
	5jfISfqKh1x/jIeh7gQcSZN0sFzeRS1EkOV5hinpznv3u+ERpH6IHzTLUC20v37JFVs3wNti417
	nhUEfHTN87sst88oaqZEwqO8SDmpfAk1tUOyUevZ7rlFvkQz2NLCyVxo=
X-Google-Smtp-Source: AGHT+IHenuXx0HIDdsGRc5cXIVDZHqMeeD8NdKsQzyMXltaL67tyqC8c6SpHD7kjsAeanNJ/xB4goy98hAIH7WjfE01htwKV61Wr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16d0:b0:482:83aa:16be with SMTP id
 g16-20020a05663816d000b0048283aa16bemr272729jat.5.1712634806633; Mon, 08 Apr
 2024 20:53:26 -0700 (PDT)
Date: Mon, 08 Apr 2024 20:53:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004792a90615a1dde0@google.com>
Subject: [syzbot] [bpf?] BUG: unable to handle kernel paging request in
 bpf_prog_ADDR (2)
From: syzbot <syzbot+838346b979830606c854@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12596223180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=838346b979830606c854
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134ecbb5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141a8b3d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 0000001000000112
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 800000002e7b1067 P4D 800000002e7b1067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5060 Comm: syz-executor351 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:bpf_prog_a8e24a805b35c61b+0x19/0x1e
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 31 c0 48 8b 7f 18 <8b> 7f 00 c9 c3 cc cc cc cc cc cc 40 03 00 00 cc cc cc cc cc cc cc
RSP: 0018:ffffc90003b07b30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc90000ace048 RCX: ffff88802aa89e00
RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000001000000112
RBP: ffffc90003b07b30 R08: ffffffff81bf633c R09: 1ffffffff2595ca0
R10: dffffc0000000000 R11: ffffffffa000095c R12: ffffc90000ace030
R13: ffff88802ac3ae28 R14: dffffc0000000000 R15: ffff88802ac3ae28
FS:  000055558f759380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001000000112 CR3: 0000000077cfa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_prog_run_array_cg kernel/bpf/cgroup.c:51 [inline]
 __cgroup_bpf_run_filter_setsockopt+0x6fa/0x1040 kernel/bpf/cgroup.c:1830
 do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fb234535cc9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd33db0138 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb234535cc9
RDX: 0000000000000010 RSI: 0000000000000112 RDI: 0000000000000007
RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000055558f759338
R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 0000001000000112
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_prog_a8e24a805b35c61b+0x19/0x1e
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 31 c0 48 8b 7f 18 <8b> 7f 00 c9 c3 cc cc cc cc cc cc 40 03 00 00 cc cc cc cc cc cc cc
RSP: 0018:ffffc90003b07b30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc90000ace048 RCX: ffff88802aa89e00
RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000001000000112
RBP: ffffc90003b07b30 R08: ffffffff81bf633c R09: 1ffffffff2595ca0
R10: dffffc0000000000 R11: ffffffffa000095c R12: ffffc90000ace030
R13: ffff88802ac3ae28 R14: dffffc0000000000 R15: ffff88802ac3ae28
FS:  000055558f759380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001000000112 CR3: 0000000077cfa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	cc                   	int3
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	f3 0f 1e fa          	endbr64
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	66 90                	xchg   %ax,%ax
  1c:	55                   	push   %rbp
  1d:	48 89 e5             	mov    %rsp,%rbp
  20:	f3 0f 1e fa          	endbr64
  24:	31 c0                	xor    %eax,%eax
  26:	48 8b 7f 18          	mov    0x18(%rdi),%rdi
* 2a:	8b 7f 00             	mov    0x0(%rdi),%edi <-- trapping instruction
  2d:	c9                   	leave
  2e:	c3                   	ret
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	40 03 00             	rex add (%rax),%eax
  38:	00 cc                	add    %cl,%ah
  3a:	cc                   	int3
  3b:	cc                   	int3
  3c:	cc                   	int3
  3d:	cc                   	int3
  3e:	cc                   	int3
  3f:	cc                   	int3


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

