Return-Path: <linux-kernel+bounces-120503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB0F88D878
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3BB1F2A322
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ADE2D60B;
	Wed, 27 Mar 2024 08:10:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4182C842
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527028; cv=none; b=fcnf9ONMYkUMAzjTg4gs0BaVSRPTjxx3KLqcGcwsQDFqtFdo2kePci2OfFyhK1j66H/z5zPfb2v/vTWexFvA9CoJa7DELeWjx6tOQREmc+InWlx1trMggiml8ApXBXKguEYtJCn27+Ih5WKupazB4KgGVONejtATFYH26BdSnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527028; c=relaxed/simple;
	bh=vCvfEahHjZAkW+O6g9pPGopW0u821OQfSSlcU3Ov9aU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RDQmsg/AA1JEFoInFs6J5V6S2609a+RMiExoEscdt0yjvRAJ5W/OaBjLk5i6abjPbLNf4oNgw+262GQ/PNE0VgAQYJLDPh9GjlLrKwTyryp4PDd2oS9PtmPDlP1/+3fqrkPKA+MxdosMU16ke5HCDUSiR0aZE+MxqOSyVHYko5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368593f281bso62682975ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527026; x=1712131826;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGiWUvAa6L+cHxPyWZ6TJFAGG3f4fNVktjBZljI6Owc=;
        b=mH4kHsZEtgnkW4ZMrxAiij5ehVhj1KjRqVrU4ca/k0ertwQBTbDU+UNtFlEtJeeTZM
         29yvMv8zfp4OJ7Q0Ic2JHo9CwC6WMD4LVEv4XCDkSxDjb6OelBaK2alWri4q4gfH2HqR
         EVIbZNTaBMM/dYZalV54RdaS2LQ+oL+6T+/hNcpb7VDDmJpM3LNvW3VTHmooKkXmXtaH
         CH5Onan3g+OAtuk0kFeae7FBB+iezgfulosUlo02qRKY8ayviq8XrE7/hDAnmT/XxZQs
         ojz0GNPYcLZmbRsqaoPZYStKhtoxbDAo4+twkJ/jZJJSqWhJuGQse4ETsRv9CIknkPrC
         VRYw==
X-Forwarded-Encrypted: i=1; AJvYcCXXGGwSU0WLYJLPrqQWbIln5bCqtXSCstFI3v6w/em2oQj81bR4e4cmjeWYiuEGnkoovQFTq5GPomxBbfbUpLmB8NZ2UOVJm4S5sCNf
X-Gm-Message-State: AOJu0YxC5sERB13GsUIPPlfveDbEBMBxtTLK2c/wOTW7LNYOcLAR0TuL
	IKFdlVvMaakS243tKOfLprEfZCoAgUVzET+qvCJYFsCKduNsOT5SyRXyp6j/b/U34RZtGDI7qOj
	zqQzNpevzE1UfOTuM+K7MvS7K5YoeX/GwMz/VuMEIoWFX48a9ayjDjnQ=
X-Google-Smtp-Source: AGHT+IFt/ebXjGSIxGhSzs3o1fzYBP0G5Ct5VVO0aRLylyyV/lnLMufnSMMqBQkmr9DSE6qQefejvffznV5i/2qNUio6aVFg2/gw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:368:a259:75cc with SMTP id
 s14-20020a056e021a0e00b00368a25975ccmr231667ild.3.1711527026086; Wed, 27 Mar
 2024 01:10:26 -0700 (PDT)
Date: Wed, 27 Mar 2024 01:10:26 -0700
In-Reply-To: <000000000000f6531b061494e696@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069ee1a06149ff00c@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d370b1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d6b041180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1060cc81180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5078 Comm: syz-executor295 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 a6 42 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 10 8a 3b 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc90003bef688 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888022169e00
RDX: 0000000000000000 RSI: ffff88802ef65070 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff90e
R10: 0000000000000004 R11: ffff888022169e00 R12: ffff888015bd0000
R13: ffff88802ef65070 R14: dffffc0000000000 R15: ffff8880b953c088
FS:  000055558e3b9380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1141b380d0 CR3: 0000000021838000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __xdp_do_redirect_frame net/core/filter.c:4384 [inline]
 xdp_do_redirect_frame+0x20d/0x4d0 net/core/filter.c:4438
 xdp_test_run_batch net/bpf/test_run.c:336 [inline]
 bpf_test_run_xdp_live+0xe8a/0x1e90 net/bpf/test_run.c:384
 bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1141ac0fb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe180a1958 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1141ac0fb9
RDX: 0000000000000048 RSI: 0000000020000340 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 a6 42 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 10 8a 3b 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc90003bef688 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888022169e00
RDX: 0000000000000000 RSI: ffff88802ef65070 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff90e
R10: 0000000000000004 R11: ffff888022169e00 R12: ffff888015bd0000
R13: ffff88802ef65070 R14: dffffc0000000000 R15: ffff8880b953c088
FS:  000055558e3b9380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1141b380d0 CR3: 0000000021838000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
  1e:	e8 a6 42 d8 ff       	call   0xffd842c9
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 10 8a 3b 00       	call   0x3b8a49
  39:	4c 8b 7d 00          	mov    0x0(%rbp),%r15
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c5                   	.byte 0xc5


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

