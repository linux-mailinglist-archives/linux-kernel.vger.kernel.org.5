Return-Path: <linux-kernel+bounces-111982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8C8873A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38BB1C227F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3972B7826D;
	Fri, 22 Mar 2024 19:13:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6177F33
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134811; cv=none; b=WP5QodLV3S4HDjZudZe6f0lJuBLPbizDllbfEGSKN5MPQTqmu87rgmug4tOixVEjEBJoW5td93KCxvgfMTHMPIW67nh1ibd6fj8XPraiKwyLekqZ/QTNwxVMIesava45H32/vQWyMePbS91+xFOlhPXXK7WZemDku3v1afeoYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134811; c=relaxed/simple;
	bh=3VXjUeNUXaxKamllEoPZR+mCbhv6y4uEoN3b+984HOk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HGHWcIHDrimU7GpOs3OQFGTB8cjl6Z/zosqNfIfuAqG8+A4zRr3P2qfIeX5JVZoR1RW7HUdNGeZ6DHOPPY8FW17XcSu0n557/KI4APeueeqxGu4Sns4f8kJT2zpevrCw8UxHAOekzIJkzsNQCFrO3ffY1ND6SiywGPa0XseGDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbffd468acso237137139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711134809; x=1711739609;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiRxOdAU5Wa2MVR5+wP0HXBTzdvMEM9GRbYV4FRUKkw=;
        b=RK99QVifqMCXGouP7aBWP7WeWwfn1O/BGwAJoNZx9hFn3VyvUi+8PqsTTcUxor+dtl
         dh0wnuq+4gkCV4wwmY76OjKKb4AYgTamXuEE2GCZsGnw7+NYplpBkQ/mcpe2goWG6azs
         7c7mUq43a42UJpUQel5i8i0e36ed9q65y34eNjB2UliXivbpY6y7hODs1Zy+DYNJKrGC
         k0x2NBWh1A0f7v3d56doFAwN1XHmhMhOEt1GMXtTaGnE46yTI6j29qkUI+HgKgfnvJw/
         0XAY/H7YNxs98bM9/B2hNFPJqlTHsu1p8jeC7Lmpm+QEkgxl/HBIpZFBAJTyPFf+Cn7k
         vXVg==
X-Forwarded-Encrypted: i=1; AJvYcCXDKLRFyeUOW517nXedE0ZnqvoX3VzsgwvZX3cxeNxlC67r/enY5jjhcSktwqUOYCRbeMHH80yVpt956ZMRrd69Ay9WUwbdtVN9pZPE
X-Gm-Message-State: AOJu0Yz9h0MYf2Tch55wp/TAsdzTzfZQiGVw68Of0Yna1LDLc4+ZI9wm
	0ayIBL9pz5iW1DernKj2KSmcQaTFO+C0S2IFKVRnQOYJz4iLY6iJn9OEq//6h6om/zgfTg2qQvC
	NB+WVqJVki38+e4mKivqXvSi3G839NpajSM+igKd5a2YrTWBnh34rqkw=
X-Google-Smtp-Source: AGHT+IH2cubx3TMqwhCFnytSkj1Z7xeM+RvWUsO3ulpYNPhX/sFprq8b3ykdRrV0AuqejoZEccp5btnVXvRVumE+8OtdkszDQnrV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d18:b0:368:73b8:6321 with SMTP id
 i24-20020a056e021d1800b0036873b86321mr22939ila.3.1711134809132; Fri, 22 Mar
 2024 12:13:29 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:13:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007628d60614449e5d@google.com>
Subject: [syzbot] [bpf?] general protection fault in bpf_check (2)
From: syzbot <syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ddb2ffdc474a libbpf: Define MFD_CLOEXEC if not available
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14ba06a5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ba82760c63ba37799f70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115671f1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f14e31180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e40c56954a9/disk-ddb2ffdc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/738240a7f62b/vmlinux-ddb2ffdc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b2e360f1d3a/bzImage-ddb2ffdc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 5066 Comm: syz-executor115 Not tainted 6.8.0-syzkaller-05232-gddb2ffdc474a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:do_misc_fixups kernel/bpf/verifier.c:19609 [inline]
RIP: 0010:bpf_check+0xa19b/0x19010 kernel/bpf/verifier.c:21294
Code: 48 c1 e8 03 80 3c 08 00 74 12 48 89 df e8 2d 93 50 00 48 b9 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <0f> b6 04 08 84 c0 0f 85 e3 4c 00 00 8b 1b be 00 00 04 00 21 de 31
RSP: 0018:ffffc900039671e0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: dffffc0000000000
RDX: ffff888018358000 RSI: 0000000000010000 RDI: 0000000000000001
RBP: ffffc90003967b50 R08: ffffffff81a7a128 R09: ffffffff81a7a365
R10: 0000000000000004 R11: ffff888018358000 R12: ffffc90000ace072
R13: 1ffff92000159c0e R14: 1ffff92000159c0e R15: 0000000000010000
FS:  000055555905c380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000111ed398 CR3: 000000002258e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f425974e3e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe73dd9d38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffe73dd9f18 RCX: 00007f425974e3e9
RDX: 0000000000000090 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007f42597c1610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe73dd9f08 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_misc_fixups kernel/bpf/verifier.c:19609 [inline]
RIP: 0010:bpf_check+0xa19b/0x19010 kernel/bpf/verifier.c:21294
Code: 48 c1 e8 03 80 3c 08 00 74 12 48 89 df e8 2d 93 50 00 48 b9 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <0f> b6 04 08 84 c0 0f 85 e3 4c 00 00 8b 1b be 00 00 04 00 21 de 31
RSP: 0018:ffffc900039671e0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: dffffc0000000000
RDX: ffff888018358000 RSI: 0000000000010000 RDI: 0000000000000001
RBP: ffffc90003967b50 R08: ffffffff81a7a128 R09: ffffffff81a7a365
R10: 0000000000000004 R11: ffff888018358000 R12: ffffc90000ace072
R13: 1ffff92000159c0e R14: 1ffff92000159c0e R15: 0000000000010000
FS:  000055555905c380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000111ed398 CR3: 000000002258e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 e8 03          	shr    $0x3,%rax
   4:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
   8:	74 12                	je     0x1c
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 2d 93 50 00       	call   0x50933f
  12:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  19:	fc ff df
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 30          	add    $0x30,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 e3 4c 00 00    	jne    0x4d19
  36:	8b 1b                	mov    (%rbx),%ebx
  38:	be 00 00 04 00       	mov    $0x40000,%esi
  3d:	21 de                	and    %ebx,%esi
  3f:	31                   	.byte 0x31


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

