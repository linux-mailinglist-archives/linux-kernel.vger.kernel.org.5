Return-Path: <linux-kernel+bounces-34969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D5838A06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386C81F24B96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDEC5812D;
	Tue, 23 Jan 2024 09:11:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C5EEC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001083; cv=none; b=qHbjtsrfL+d/zCc1Aodwr5f9b945nM31uALBRTF+3VbNxyCsfxEKos6QeRqULXk2n47qJzwraaZPx74/eP714zl+nEnZyc9V1VWzoP97RO8GjMFcdiapS7t996mi1xFhJmGg4gsGlNOO9iO+wDkpGNdwLdCxN4l3FM27GFMSKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001083; c=relaxed/simple;
	bh=QTm5KDaDNycZTdiSGLpEJGEokNHNaMWSiHCJhri3Orc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MtbzT52Ce3APYc2qVV9ZkXwhaf4VeWboAoYSpiiU4U8g7nIYZcHzSsxOYKizC0OR9e8Ec4dg7jltmCdVHGHq/hkJLXyeXJz++StpTY3pIfiCVWTdt9YxrWfqfN1Vg3unDba3sD+J6bVGgr7nAgi2UWJls+NI2d5edpqS3120jV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-361b1ff327cso27645255ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001081; x=1706605881;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8JHX+MRfx2RrG0GI0Ld2XhBIptDf5Ajx1M3GH8izJY=;
        b=cD50dPh8Hage5OKYO1LqmIXjt65qZ4BYA7zKFZ5WMZJQZswL7Jef9+W22LrGsi2kJz
         Ohf8UOQYca0FOw0cb0BmH9nsdas7eG9cxENX73AF7f/L9KlNpNEmq1e67H/zGWr3mIN8
         DNj/Fv/iuF23um+0SCqLLJ7JQHlXDN+icf6CvC3B8zmcoA/z2oscJc/lLWSBTv7zmGg2
         3zODwH7/okw1zl3VYntW5bIdHuOEQRvDvb//NXoDdB6qJfG4+MlvoCV9oID10mNZZGD4
         khuMVBpZgrt0muFFD1oq08YDP0eKPcJOpErmLAYuvFaMhDjOPnH3OK14WDCbxwYidPZb
         /hQA==
X-Gm-Message-State: AOJu0YwUNtSOxV7KzDNBqgFxCwDYOOSkiP9nuWXtr9siOkT8MlpSA7wN
	YntSUWy7MlSfrvJESjXVv5gnUkTUitzWva34mszmWC/7krMICjDWIXz3x4+HPEh/6bU+w1HJB02
	cUyrVSJ9Kj+FV4jk/xGrcWo8HzO/wyg0uPKfIC/uePLvvWso4k/YnLss=
X-Google-Smtp-Source: AGHT+IHjnT0c6IU9Y8eh+EIRpgV7cYUACnvoc+unffKxZ5AxGkGqIWUUhaap7lDH7CtHwNqdHiJ3cRowKibaUG9YrzOkadiGK1zu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:35f:f01e:bb18 with SMTP id
 h8-20020a056e021d8800b0035ff01ebb18mr875536ila.6.1706001081646; Tue, 23 Jan
 2024 01:11:21 -0800 (PST)
Date: Tue, 23 Jan 2024 01:11:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007549a6060f99544d@google.com>
Subject: [syzbot] [tipc?] general protection fault in tipc_udp_nl_dump_remoteip
From: syzbot <syzbot+314c727eef32ba20b65d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39369c9a6e09 selftests: netdevsim: add a config file
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1383ebbde80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d54ca15e81ba55f
dashboard link: https://syzkaller.appspot.com/bug?extid=314c727eef32ba20b65d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3095adfa6c3d/disk-39369c9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/105f20ab46b4/vmlinux-39369c9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d8afb887806/bzImage-39369c9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+314c727eef32ba20b65d@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 14603 Comm: syz-executor.3 Not tainted 6.7.0-syzkaller-04690-g39369c9a6e09 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:tipc_udp_nl_dump_remoteip+0x3c7/0xa60 net/tipc/udp_media.c:513
Code: 48 c1 ea 03 80 3c 02 00 0f 85 df 05 00 00 48 8b 9b 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8d 7b c8 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 6b 06 00 00 48 8b 03 48 39 d9 4c 8d 70 c8 0f 84
RSP: 0018:ffffc900160171e8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88804cc52098
RDX: 0000000000000000 RSI: ffffffff8a288b69 RDI: 0000000000000005
RBP: ffff888047885780 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000001000 R12: 0000000000000000
R13: ffffc90016017268 R14: ffff888047885780 R15: ffffffffffffffc8
FS:  00007f35d634c6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1f7a57b038 CR3: 000000002bfe0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 genl_dumpit+0x119/0x220 net/netlink/genetlink.c:1025
 netlink_dump+0x588/0xca0 net/netlink/af_netlink.c:2264
 __netlink_dump_start+0x6d0/0x9c0 net/netlink/af_netlink.c:2370
 genl_family_rcv_msg_dumpit+0x1e1/0x2d0 net/netlink/genetlink.c:1074
 genl_family_rcv_msg net/netlink/genetlink.c:1190 [inline]
 genl_rcv_msg+0x470/0x800 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f35d567cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35d634c0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f35d57abf80 RCX: 00007f35d567cda9
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00007f35d56c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f35d57abf80 R15: 00007ffed090ed98
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tipc_udp_nl_dump_remoteip+0x3c7/0xa60 net/tipc/udp_media.c:513
Code: 48 c1 ea 03 80 3c 02 00 0f 85 df 05 00 00 48 8b 9b 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8d 7b c8 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 6b 06 00 00 48 8b 03 48 39 d9 4c 8d 70 c8 0f 84
RSP: 0018:ffffc900160171e8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88804cc52098
RDX: 0000000000000000 RSI: ffffffff8a288b69 RDI: 0000000000000005
RBP: ffff888047885780 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000001000 R12: 0000000000000000
R13: ffffc90016017268 R14: ffff888047885780 R15: ffffffffffffffc8
FS:  00007f35d634c6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc4601dcf78 CR3: 000000002bfe0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 df 05 00 00    	jne    0x5ed
   e:	48 8b 9b 98 00 00 00 	mov    0x98(%rbx),%rbx
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	4c 8d 7b c8          	lea    -0x38(%rbx),%r15
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 6b 06 00 00    	jne    0x69f
  34:	48 8b 03             	mov    (%rbx),%rax
  37:	48 39 d9             	cmp    %rbx,%rcx
  3a:	4c 8d 70 c8          	lea    -0x38(%rax),%r14
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84


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

