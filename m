Return-Path: <linux-kernel+bounces-42738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCAE8405CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879C628576C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFC61679;
	Mon, 29 Jan 2024 12:55:33 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A6612EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532932; cv=none; b=n97cxomY7r0lkzHYgM3PLO6+JqNlMcaGY+SBi6S3E3yCE79e37D/+yZ3+vYVIHL9oKSnh+9dXUS/0Zw4R42pO0pCJWK8Tm8nNc8xQSX04EM9o0W1q1wz9Mw2eUqRMxzmGjjZYLiZ64vbSskR6jJI7x3PLICw8Jy7YZf/DyB3rCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532932; c=relaxed/simple;
	bh=gCNLN32onkfofc2XLJ63iawEcWMbF9XLfRMNpJZnSL8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MxfYK003kwM6tD6Ds3qV99S2nM0+DnC7f59MTplCEHVmHXadPbHSyp7kv61UsuW38/2WICkKIlr81/XwTsTWYozgX+emApzfg0NsRmxuLCNpn6XAnvl64cT0Poy0RKY+xmAox3dMCSCTnYdiAe6pqCH0ZWirFw4hrwo0InZgMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3610073a306so17335545ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532930; x=1707137730;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrnXr+h10ghLDpUHiMKmC913INgZavjkvo1GZXmFYWk=;
        b=RMFWAH719fNTFmfOHV7BNwWzpIkls+xH7Q1SpOUBRcD4AA6RlMpfmxJH+bbAER+Pwu
         5bWS0ABWMCzTBV0F4Hj6pCIsdZBDqLZ5fa+ILEabLCRnAx3X2r45zmmNQ+Zo76fuETBW
         mk6QYeSWhZTcr1YEV1S4TDBNyQgGGvjLDgzPTbAkTcfI0WIuzHbiDYD1kfZ1zCME3TTx
         w2aWkoUE3F7m+jQo5WZz1aA1cco0x3qUdWfD+zge+3zPAF8BrL8CexRloZYT6mJhhZIh
         4VOFlB7oWe/ekfLVQzDs9tB33DspJnBjy4hEUy1Fq5BKHsBH/CSypSRCJAuaIHTLXVY8
         74uw==
X-Gm-Message-State: AOJu0Yw0CNUW+r8oZTBH1oBYJweyejmIZxLgBVB2XymBaEp+Z7fDBHIY
	toxcCWrqgIqisY7wuCbjCYmjoujNZXHnYX9M0ue+rVxaVbPhdZPXe/lDIok/+jftcJ/pVmv9DmP
	ykUdzMdpDMYFAYV3Mm/Wn1pltkiIBs/ThBrgvFM2v1RYjxRGx4VNhi+E=
X-Google-Smtp-Source: AGHT+IGPlSzYOPzrKRbtnmW7WFNiwQKydE+NeSOBAz2/BDx3RJAYPJA+6muxCx6BYlUnVioEoU0kLBrzwWVFVTCWkJ1LVxq5FbUI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c562:0:b0:35f:f01e:bb18 with SMTP id
 b2-20020a92c562000000b0035ff01ebb18mr594758ilj.6.1706532930067; Mon, 29 Jan
 2024 04:55:30 -0800 (PST)
Date: Mon, 29 Jan 2024 04:55:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018273706101529cf@google.com>
Subject: [syzbot] [crypto?] BUG: unable to handle kernel NULL pointer
 dereference in crypto_arc4_crypt
From: syzbot <syzbot+050eeedd6c285d8c42f2@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3a5879d495b2 Merge tag 'ata-6.8-rc2' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1683b6bbe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=050eeedd6c285d8c42f2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15178ea0180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107f8eefe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f5df0cd5c86/disk-3a5879d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/284ff9c3970b/vmlinux-3a5879d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b75c80c77fad/bzImage-3a5879d4.xz

The issue was bisected to:

commit 47309ea1359115125d9cab17a279c8df72b47235
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Nov 28 06:52:57 2023 +0000

    crypto: arc4 - Add internal state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1325e5a0180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a5e5a0180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1725e5a0180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+050eeedd6c285d8c42f2@syzkaller.appspotmail.com
Fixes: 47309ea13591 ("crypto: arc4 - Add internal state")

"syz-executor299" (5065) uses obsolete ecb(arc4) skcipher
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 78051067 P4D 78051067 PUD 7e3d7067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5065 Comm: syz-executor299 Not tainted 6.8.0-rc1-syzkaller-00311-g3a5879d495b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:memcpy_orig+0x31/0x120 arch/x86/lib/memcpy_64.S:71
Code: 48 83 fa 20 0f 82 86 00 00 00 40 38 fe 7c 35 48 83 ea 20 48 83 ea 20 4c 8b 06 4c 8b 4e 08 4c 8b 56 10 4c 8b 5e 18 48 8d 76 20 <4c> 89 07 4c 89 4f 08 4c 89 57 10 4c 89 5f 18 48 8d 7f 20 73 d4 83
RSP: 0018:ffffc90003a378c0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff84401c81
RDX: 00000000000003c8 RSI: ffff888019ee1040 RDI: 0000000000000000
RBP: ffff888019ee1000 R08: 0000000400000003 R09: 0000002200000071
R10: 0000000800000016 R11: 0000001700000083 R12: 0000000000000000
R13: ffff88807f225da0 R14: ffff88807929e000 R15: 0000000000000001
FS:  00005555570b8380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007c30c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 crypto_arc4_crypt+0x4b/0x70 crypto/arc4.c:33
 crypto_lskcipher_crypt crypto/lskcipher.c:160 [inline]
 crypto_lskcipher_decrypt+0xd4/0x130 crypto/lskcipher.c:194
 crypto_cbc_decrypt_segment crypto/cbc.c:80 [inline]
 crypto_cbc_decrypt+0x14f/0x330 crypto/cbc.c:133
 crypto_lskcipher_crypt_sg+0x28c/0x460 crypto/lskcipher.c:229
 crypto_skcipher_decrypt+0xda/0x160 crypto/skcipher.c:693
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0xc2b/0x1040 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1068
 __sys_recvfrom+0x1ab/0x2e0 net/socket.c:2242
 __do_sys_recvfrom net/socket.c:2260 [inline]
 __se_sys_recvfrom net/socket.c:2256 [inline]
 __x64_sys_recvfrom+0xe0/0x1b0 net/socket.c:2256
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f23399079b9
Code: ff e8 cb 01 00 00 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d f1 56 07 00 00 41 89 ca 74 1c 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
RSP: 002b:00007ffe68b37d28 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 00007ffe68b37db4 RCX: 00007f23399079b9
RDX: 0000000000001000 RSI: 00007ffe68b37da0 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe68b37da0
R13: 00007ffe68b38f88 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:memcpy_orig+0x31/0x120 arch/x86/lib/memcpy_64.S:71
Code: 48 83 fa 20 0f 82 86 00 00 00 40 38 fe 7c 35 48 83 ea 20 48 83 ea 20 4c 8b 06 4c 8b 4e 08 4c 8b 56 10 4c 8b 5e 18 48 8d 76 20 <4c> 89 07 4c 89 4f 08 4c 89 57 10 4c 89 5f 18 48 8d 7f 20 73 d4 83
RSP: 0018:ffffc90003a378c0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff84401c81
RDX: 00000000000003c8 RSI: ffff888019ee1040 RDI: 0000000000000000
RBP: ffff888019ee1000 R08: 0000000400000003 R09: 0000002200000071
R10: 0000000800000016 R11: 0000001700000083 R12: 0000000000000000
R13: ffff88807f225da0 R14: ffff88807929e000 R15: 0000000000000001
FS:  00005555570b8380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007c30c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 83 fa 20          	cmp    $0x20,%rdx
   4:	0f 82 86 00 00 00    	jb     0x90
   a:	40 38 fe             	cmp    %dil,%sil
   d:	7c 35                	jl     0x44
   f:	48 83 ea 20          	sub    $0x20,%rdx
  13:	48 83 ea 20          	sub    $0x20,%rdx
  17:	4c 8b 06             	mov    (%rsi),%r8
  1a:	4c 8b 4e 08          	mov    0x8(%rsi),%r9
  1e:	4c 8b 56 10          	mov    0x10(%rsi),%r10
  22:	4c 8b 5e 18          	mov    0x18(%rsi),%r11
  26:	48 8d 76 20          	lea    0x20(%rsi),%rsi
* 2a:	4c 89 07             	mov    %r8,(%rdi) <-- trapping instruction
  2d:	4c 89 4f 08          	mov    %r9,0x8(%rdi)
  31:	4c 89 57 10          	mov    %r10,0x10(%rdi)
  35:	4c 89 5f 18          	mov    %r11,0x18(%rdi)
  39:	48 8d 7f 20          	lea    0x20(%rdi),%rdi
  3d:	73 d4                	jae    0x13
  3f:	83                   	.byte 0x83


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

