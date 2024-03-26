Return-Path: <linux-kernel+bounces-119737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE588CC91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFF61F80BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E64413CC73;
	Tue, 26 Mar 2024 19:00:36 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F66FE35
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479635; cv=none; b=VcIcWZiC4tGfVoRvuJqpstNU2yeBnv0ibORGbkaADoRwAeRm3Hvfd6HDkEZCSTCFwf1Wegwbq1s8nFfIXsFGuFiITAMWryzAxJoYboVV7PQ2pE7IQaNoXn8hca0pHJg4OVYXPkoRNnMcf5KNHBkqNSjAs5jiJxs/vtUtNYptRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479635; c=relaxed/simple;
	bh=7HDloqRSDdn+FNnsv1j7aPLrnomcwb8pA0DxtNg/nrI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZMdlkRZIypTgiIEmuv7GE/270l2Q21s5M9a25BUM5AaCumcp8BNRWgERuTeMByblKhAXRcRf6WIOXJk/CPf53vVeiziNPfTIAl/SK1Wk4MIhHiy+irFEUR6RvBRUnLakj6DYU4CSACu0HQIt1XB7EbXxyfMsfHEn4JqxGLsVBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-368a360baabso9252565ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479623; x=1712084423;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EQq1+C0rxxXWWlIywUcuDOKzK5nbEvWmmdoOCe2LpE=;
        b=BczYbf7VOtg7nTtVJ6Kx02TFjxLO5xowNN4sb5dbkzAm8+UaKMKGzObT+3/05oWSW4
         CLVCgWv3THoxvpgTGadLwEDMvcU/Qz5P24eFz3bAPICIs6oKdHCC2UrArQCsjs46Fure
         eqwKhvR0d0X/vrVsTCs6HQoyCPF92qANHIzbFHmpXR2U+XaVhi74xDmDFnQ/VEHYTgHC
         kEW8MUhMdh22kpsq0p4NeIfxg0OAiHHquyhq2WuIDn3kPuXaKz4UdW3A9rPa9W2MPufB
         fv6DkVr9Oct8Qfg6hMv4rdWXWzlG/ni0QjqTWpKa2WRH2crhwKvrgQW+Y/fwfS3QgcVC
         Er7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmnQ1OY5ZjUQ9wYpn/4ntllrl8TSk2sGPqPK6tqBtZ3O5dkc5ZPImw8FFWe08LAjpWBhJ5re+UJTLjUb0J0dG4BvcB9XRFQwj2//x2
X-Gm-Message-State: AOJu0YwnDi9FDSrl//BbCLdEBYxnvXQ3NeIn7k97yvnp9sSgVvCCepb1
	byfDpUwzptMXHlClAXN9+KqRIJUuza7TmIqYUE0ZQN+8i/yhB9IFeR9pihj8UZBNCmFLLRPwtvz
	32Cuwkvjb7yP1yfN0p9z9UK/qlZdl9lsj+0XAMCe0ffH8WWUxmZYKxnI=
X-Google-Smtp-Source: AGHT+IHbFVVAE7ADdPRwhETSn8OEneL86XBPP2rHXEU6ar59LK9sQo7jJrDfHGKTwtewbJIAbSzSFFXEveEa+Y/TTCYUIeydSiLX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ea:b0:368:7d6b:a7cd with SMTP id
 l10-20020a056e0212ea00b003687d6ba7cdmr537549iln.3.1711479622876; Tue, 26 Mar
 2024 12:00:22 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:00:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6531b061494e696@google.com>
Subject: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158ad421180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 13398 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 56 3a d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 60 89 3b 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc90010e6f688 EFLAGS: 00010256
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000fb19000 RSI: 0000000000000c96 RDI: 0000000000000c97
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff8954502e
R10: 0000000000000004 R11: ffff88805bde3c00 R12: ffff88807e182000
R13: ffff88805595d070 R14: dffffc0000000000 R15: ffff8880b953c288
FS:  00007fe7632126c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32d23000 CR3: 000000006b1cc000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __xdp_do_redirect_frame net/core/filter.c:4384 [inline]
 xdp_do_redirect_frame+0x20d/0x4d0 net/core/filter.c:4438
 xdp_test_run_batch net/bpf/test_run.c:336 [inline]
 bpf_test_run_xdp_live+0xe8a/0x1e90 net/bpf/test_run.c:384
 bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x33c/0x3b0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fe76247dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe7632120c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fe7625abf80 RCX: 00007fe76247dda9
RDX: 0000000000000050 RSI: 0000000020000240 RDI: 000000000000000a
RBP: 00007fe7624ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe7625abf80 R15: 00007ffcf8e59e58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 56 3a d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 60 89 3b 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc90010e6f688 EFLAGS: 00010256
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000fb19000 RSI: 0000000000000c96 RDI: 0000000000000c97
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff8954502e
R10: 0000000000000004 R11: ffff88805bde3c00 R12: ffff88807e182000
R13: ffff88805595d070 R14: dffffc0000000000 R15: ffff8880b953c288
FS:  00007fe7632126c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32d23000 CR3: 000000006b1cc000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	41 56                	push   %r14
   2:	41 55                	push   %r13
   4:	41 54                	push   %r12
   6:	53                   	push   %rbx
   7:	48 83 ec 18          	sub    $0x18,%rsp
   b:	49 89 d4             	mov    %rdx,%r12
   e:	49 89 f5             	mov    %rsi,%r13
  11:	48 89 fd             	mov    %rdi,%rbp
  14:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  1b:	fc ff df
  1e:	e8 56 3a d8 ff       	call   0xffd83a79
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 60 89 3b 00       	call   0x3b8999
  39:	4c 8b 7d 00          	mov    0x0(%rbp),%r15
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c5                   	.byte 0xc5


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

