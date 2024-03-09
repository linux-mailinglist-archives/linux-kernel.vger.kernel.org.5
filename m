Return-Path: <linux-kernel+bounces-97932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B738771DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBA7281C07
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3862944373;
	Sat,  9 Mar 2024 15:13:37 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA628DDC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709997216; cv=none; b=VYbmeQP6m0X2/t/f+tJ8DfrO6esZmqAChioTu8uTamP/WLgWLCTkLk7ZIPp3LcQ0C8n6kijrvdV0HUCc1CnNKgSOFzEylDV9xyg/5fAhw6mS1lIoweBqMa2UuR9NcCqmRophNlzvgPh6A47c5TZ1HmnMlIu/qcR+Au7dbpdBEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709997216; c=relaxed/simple;
	bh=ecjBtlmvGV0p7yqL+7M3qVsWDvuTDH/Tf7Fyp/EEZmM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c13kX6dPyDZWTViu/MAx/4HDDQt29KJHr4qDFL1DUksIL8OKC+828Uz1oGeQcAFWOJexxy9LPNc+5xwuwOUDMSlXyx7pOwqxFVkj2/EaNJ46JaY2keRDHXKesPRnxHS7mhyyPoVTGHWiTwAilOcU6FsYTgSdYy7jR+0F2n45qyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a6a122b5so28510239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 07:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709997214; x=1710602014;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lscIlWimXdY5Wwukw/9HSnM1Sst+0Oh9TM0CnsPtOU4=;
        b=sIyUESmR6mdixFChgzj+BkFTFu7FPN2SmGGh8TrFe2J23Pszhrg4maWtNuMoKw/ZKT
         J34uNzTQVow9+D8+WMw1FWlb+Qk/5blYUxD3To9cBrQkGvtv4QsnjVhGZxz6FtusOHAp
         eRVtfEkyQbQW1ZRViqvIckkTVmEJvTwIz8CvvYmTYK4YRhYgt3HFQuChJtiHZLsN0Yvs
         j/u/+1Xbr6evdDEcAzUsvsDCBfCbcl4tVvfZT5CkjHqByZ0I1ogRPaWrHIJYRdgS5cxx
         oqqc3pWOJRNSxUR+plfBQ1URm7/aKd7jaGkl39P1PiUF0q9fYfegaNFS6E97+HEjNyCU
         YINw==
X-Forwarded-Encrypted: i=1; AJvYcCUG/ax5xVnbLf2Xrc6lhXldSU5flEGcruURFvNq8KTRxv4VYtVd6l0x91AFjYyrBQzXZIwRpB71WFjvahiu8QyD8lZjbHtHluiMXILn
X-Gm-Message-State: AOJu0YyCGQpVB8UgBn38iCueUZ2R2Qjvpn1bnwjyw8Cry/g7Gfbk3Bww
	ZCFkTFQ0UovtZ09Zlln+ffoTg3k/hZEfiRWezqnmZYiCrtmEy+Vdzgpd11HR5Mw/Da6+S4prYka
	3xAarEKZAyyOnEGWXvzQwZq7Ada5HBlROkIUywtEq5bTlNpgD4cnxZcM=
X-Google-Smtp-Source: AGHT+IEm0rsByzTWkN1qBG4ImRsHHYa2jnMi/UTtmEMeG083q6x+07+C/fVBTVdx6YBC6cU3EvLA6X6rEaCeEX2ToKE0KpwijcQS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24ca:b0:476:7265:9bfc with SMTP id
 y10-20020a05663824ca00b0047672659bfcmr113645jat.6.1709997214435; Sat, 09 Mar
 2024 07:13:34 -0800 (PST)
Date: Sat, 09 Mar 2024 07:13:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088981b06133bc07b@google.com>
Subject: [syzbot] [net?] kernel BUG in __nla_validate_parse
From: syzbot <syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f901582f032 Merge tag 'for-net-next-2024-03-08' of git://..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=112f130a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63afafeedf00ef8f
dashboard link: https://syzkaller.appspot.com/bug?extid=65bb09a7208ce3d4a633
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b03984cb5619/disk-2f901582.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/41787ac7c9d9/vmlinux-2f901582.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da7931fd36f6/bzImage-2f901582.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at lib/nlattr.c:411!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 14369 Comm: syz-executor.2 Not tainted 6.8.0-rc7-syzkaller-02415-g2f901582f032 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:validate_nla lib/nlattr.c:411 [inline]
RIP: 0010:__nla_validate_parse+0x2f61/0x2f70 lib/nlattr.c:635
Code: 48 8b 4c 24 18 80 e1 07 38 c1 0f 8c e0 f7 ff ff 48 8b 7c 24 18 e8 ff 0e 1d fd e9 d1 f7 ff ff e8 d5 c2 91 06 e8 50 64 ba fc 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90003c1eec0 EFLAGS: 00010287
RAX: ffffffff84d90ad0 RBX: ffffffff8caa11b0 RCX: 0000000000040000
RDX: ffffc9000499a000 RSI: 000000000000065e RDI: 000000000000065f
RBP: ffffc90003c1f100 R08: ffffffff84d8df5b R09: 0000000000000000
R10: ffffc90003c1f1a0 R11: fffff52000783e46 R12: 0000000000000008
R13: 1ffff1100f9c4183 R14: 000000000000006e R15: 0000000000000005
FS:  00007f5fe2d916c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000440 CR3: 00000000229a2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __nla_parse+0x40/0x60 lib/nlattr.c:732
 __nlmsg_parse include/net/netlink.h:756 [inline]
 nlmsg_parse include/net/netlink.h:777 [inline]
 rtm_del_nexthop+0x257/0x6d0 net/ipv4/nexthop.c:3256
 rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1902
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f5fe207dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5fe2d910c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5fe21abf80 RCX: 00007f5fe207dda9
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 0000000000000003
RBP: 00007f5fe20ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5fe21abf80 R15: 00007fff7d5a1278
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:validate_nla lib/nlattr.c:411 [inline]
RIP: 0010:__nla_validate_parse+0x2f61/0x2f70 lib/nlattr.c:635
Code: 48 8b 4c 24 18 80 e1 07 38 c1 0f 8c e0 f7 ff ff 48 8b 7c 24 18 e8 ff 0e 1d fd e9 d1 f7 ff ff e8 d5 c2 91 06 e8 50 64 ba fc 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90003c1eec0 EFLAGS: 00010287
RAX: ffffffff84d90ad0 RBX: ffffffff8caa11b0 RCX: 0000000000040000
RDX: ffffc9000499a000 RSI: 000000000000065e RDI: 000000000000065f
RBP: ffffc90003c1f100 R08: ffffffff84d8df5b R09: 0000000000000000
R10: ffffc90003c1f1a0 R11: fffff52000783e46 R12: 0000000000000008
R13: 1ffff1100f9c4183 R14: 000000000000006e R15: 0000000000000005
FS:  00007f5fe2d916c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00104bb94 CR3: 00000000229a2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

