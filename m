Return-Path: <linux-kernel+bounces-126873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DAA894251
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA75AB20B07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D584F5FD;
	Mon,  1 Apr 2024 16:51:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B6481D1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990282; cv=none; b=E1MC9UIL9pFUboIqRqDin2vTWTXOp80134zvdbJN/DwJx6O2V9oxTGVBHHQn8Wp84bv66mryoO0xf6GC6sMBWif/NYMJV2Y5LSVy9e65tDKWvbHR4Lu4j7HzDmatah0S88cXyDNFiOF9qq98nPdpo+xslIqqlAbTTbiXff611Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990282; c=relaxed/simple;
	bh=+YpLD+4LiDllvY8qBsgrDSTA9AJ0+xQFee1/kxIpYlc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LdRJr9kMTxTd91SyKRJIWMEVoVS8IJ7PUBs+Bf+OuzDNbXw/JPTVZCXFQPBPNLi9hg9JlrQvhqouNpwG2y97XnoPI+rn0VhGiJmLoEyi+1+02HLGcz3MZ5mMt4+59tXQL+l4WA2oltoHxO+SvzOQqW1Zd7DsBYWHnxMWpJrm2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so447844539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 09:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990280; x=1712595080;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdk8hs5YwRs0MgKKaMSnooSWizCujgZiOxORDfdAX/0=;
        b=VHfagUU52KOMcCYXDhxwtcXxpYiE3d5/7I3Bvl5v221CX88uo5Od4aqhEaTCqr1MIV
         SO8UKykTUJdGhvJECyfY2kfZE6pLVouwBz3TtDNX88YX68Kob6ctSDz5pvQ3kfltZOKD
         i9NthL39otQXcNgZmYn9OjmJUuBlaIcaZZ1+KSvQJZkTtTStlR7rhIbluaNMjy1C7aPI
         //ukSkoIBJG8qpkw5Ku2Slafd8JTz5f4Cdzff/Emn/putTXoGTdQ6L0vOwQidnf603TC
         hIOjyXdFd8qkJmroZWJCli+B5iCpUz/vUV4JJB7/7AdYMpdE99HabQaDqLRwrPEITxOj
         ogFg==
X-Forwarded-Encrypted: i=1; AJvYcCXseC6h26lvfGFiuay6ZStmQNxnswQEhSmNsk9dlql0PBGMF1MCfBAWikZWKVETAN2bw4ytBkb0y0Cr5MK12HC6gMX0aO6D3D9U4vsP
X-Gm-Message-State: AOJu0YxPi5tE2tHylpbbLoA+slc3fCHP81gTC109jzJ/V3q0KVXtdkaV
	0x9hHXyDfA27DVrq5Xy3LgXHSu5e3SBO9biNoLxxobQcLt9k+SZGfW+OCPMrFCZacd5RemPZqKi
	PYEa4aocn9Pb/J+0uO2d1KtJJnrXjJoHmxhW5GhMJ/p42K3D2Mzaelzg=
X-Google-Smtp-Source: AGHT+IGvh+h9Q7ZKk4dzQgcg/ciJVMmq/GBMv8Wtyz3R29FKzahTPJgHxJnFFV/WhUXFq7csn3ZGP0Txvp4nKR+njrehwDhRFGim
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150c:b0:7d0:ad03:af10 with SMTP id
 g12-20020a056602150c00b007d0ad03af10mr179166iow.1.1711990280083; Mon, 01 Apr
 2024 09:51:20 -0700 (PDT)
Date: Mon, 01 Apr 2024 09:51:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081146c06150bcc2a@google.com>
Subject: [syzbot] [bpf?] WARNING in __mark_chain_precision (4)
From: syzbot <syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14024776180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=148110ee7cf72f39f33e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c51c1d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127285b1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier backtracking bug
WARNING: CPU: 0 PID: 5066 at kernel/bpf/verifier.c:3714 backtrack_insn kernel/bpf/verifier.c:3714 [inline]
WARNING: CPU: 0 PID: 5066 at kernel/bpf/verifier.c:3714 __mark_chain_precision+0x7027/0x7520 kernel/bpf/verifier.c:4255
Modules linked in:
CPU: 0 PID: 5066 Comm: syz-executor296 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:backtrack_insn kernel/bpf/verifier.c:3714 [inline]
RIP: 0010:__mark_chain_precision+0x7027/0x7520 kernel/bpf/verifier.c:4255
Code: 8b e8 ed df b0 ff 90 0f 0b 90 90 e9 7d f2 ff ff e8 9e 0b ee ff c6 05 41 c2 c9 0d 01 90 48 c7 c7 c0 af b0 8b e8 ca df b0 ff 90 <0f> 0b 90 90 e9 5a f2 ff ff e8 7b 0b ee ff c6 05 1f c2 c9 0d 01 90
RSP: 0018:ffffc900043f6ac0 EFLAGS: 00010246
RAX: 3bf0d782b73e5400 RBX: ffff8880236c5600 RCX: ffff88802a9dbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900043f6d10 R08: ffffffff8157cb22 R09: 1ffff110172851a2
R10: dffffc0000000000 R11: ffffed10172851a3 R12: 0000000080000000
R13: 0000000000000010 R14: 0000000000000001 R15: ffff8880236c0000
FS:  000055557d2fe380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000082 CR3: 00000000231d4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mark_chain_precision kernel/bpf/verifier.c:4358 [inline]
 check_return_code+0xbe0/0x11e0 kernel/bpf/verifier.c:15500
 do_check+0xb91f/0x10500 kernel/bpf/verifier.c:17867
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20492
 do_check_main kernel/bpf/verifier.c:20583 [inline]
 bpf_check+0x136ab/0x19010 kernel/bpf/verifier.c:21253
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f6484f2a469
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc85bd0a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffc85bd0be8 RCX: 00007f6484f2a469
RDX: 0000000000000090 RSI: 0000000020000600 RDI: 0000000000000005
RBP: 00007f6484f9d610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc85bd0bd8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

