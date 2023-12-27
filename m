Return-Path: <linux-kernel+bounces-12005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B41081EEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CCF1F217AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A449446CC;
	Wed, 27 Dec 2023 12:07:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BF2C684
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc6976630so60373865ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703678825; x=1704283625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBBYpMMPVlcAxv24+DAv2JRM6sWEypP2/syTIYHKzR8=;
        b=qLM8x+oLDv+LaM5h2e9Hz9zJxUFCi2EpFlPI2QIqB6JjTVCrPQ/HqbEm8fUbArLg2p
         y6E1eygWAeDWm7ckZJu5If/UIPTmngXqjnvgQ2AaQ83sfvCOAvmsIkRAJl/+tO7aJ5fS
         WjbhGKDgGlgcYxiCzL5ANNe0YwSEtRt2lLbuFNb5CNI/rz3IyACKLLMfVM2DkZtnBA1F
         sfarXvAO6Qk8h0/Y+NvDHMHQsF5BBNJU2lM8Yo3Pyxh9yKIAf2VB+Vsi0YbK15psDUj6
         cZIgH0L9HUB3i/UFsTzBfmIsh3GLhdAU4zBuwdaq/t8bDy9Cr6h0FgxVfh2DuZbQy30V
         0rtw==
X-Gm-Message-State: AOJu0YyZg322SLxoxquMktmE60YAaGmvNgdJBt1+M+hzkKsAOEXDUzOn
	TA4CZ0Ha2kyp/9PHDDQctCq+M+Dfr6cKIA79YsMO9SuvOp1C
X-Google-Smtp-Source: AGHT+IEmC9ApaczATfJEBf6WvFovj+nYnwHJAKKvo6PANzd+9rtdqgq4OqXfEnx4a31FdmXOeQzqFJ6p2tzZl+U5KAQjFWtLo3Y8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214d:b0:35f:c723:1f7b with SMTP id
 d13-20020a056e02214d00b0035fc7231f7bmr942406ilv.1.1703678825821; Wed, 27 Dec
 2023 04:07:05 -0800 (PST)
Date: Wed, 27 Dec 2023 04:07:05 -0800
In-Reply-To: <20231227115014.1612-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000397f60060d7ca33b@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in l2cap_do_send (2)
From: syzbot <syzbot+d6cd076b385aefcb6b16@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in hci_send_acl

------------[ cut here ]------------
WARNING: CPU: 3 PID: 7942 at kernel/workqueue.c:1722 __queue_work+0xdc6/0x11d0 kernel/workqueue.c:1721
Modules linked in:
CPU: 3 PID: 7942 Comm: syz-executor.2 Not tainted 6.7.0-rc7-syzkaller-gfbafc3e621c3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__queue_work+0xdc6/0x11d0 kernel/workqueue.c:1721
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 a3 92 87 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 e4 a6 31 00 85 db 75 56 e8 6b ab 31 00 90 <0f> 0b 90 e9 ac f8 ff ff e8 5d ab 31 00 90 0f 0b 90 e9 5b f8 ff ff
RSP: 0018:ffffc900035c76b8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8154b90c
RDX: ffff88803b7dce40 RSI: ffffffff8154b915 RDI: 0000000000000005
RBP: 0000000000000200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888041fc4df0
R13: 0000000000000000 R14: ffff88802e93c000 R15: ffff88802e93c000
FS:  00007f0253c846c0(0000) GS:ffff88806b900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001038 CR3: 000000002a347000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0xed/0x110 kernel/workqueue.c:1831
 queue_work include/linux/workqueue.h:562 [inline]
 hci_send_acl+0xa0a/0xd10 net/bluetooth/hci_core.c:3245
 l2cap_do_send+0x318/0x470 net/bluetooth/l2cap_core.c:1015
 l2cap_chan_send+0xb7d/0x2ae0 net/bluetooth/l2cap_core.c:2726
 l2cap_sock_sendmsg+0x218/0x2e0 net/bluetooth/l2cap_sock.c:1154
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x2ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmmsg+0x1a1/0x450 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0252e7cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0253c840c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f0252f9bf80 RCX: 00007f0252e7cce9
RDX: 0000000000000735 RSI: 0000000020000b80 RDI: 0000000000000004
RBP: 00007f0252ec947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000024044840 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0252f9bf80 R15: 00007ffdfd80dbc8
 </TASK>


Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14c1f31ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d6cd076b385aefcb6b16
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17377bbee80000


