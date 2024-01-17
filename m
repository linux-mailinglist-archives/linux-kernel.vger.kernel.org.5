Return-Path: <linux-kernel+bounces-29304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF3830C70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89616B2334D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5E522F09;
	Wed, 17 Jan 2024 18:07:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A223747
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514841; cv=none; b=RBCCvwvwxqJXfa+owO47mMEBWs55Jx4noUIzK+HXQpBq9nxQKK4/r+5yI+yW/dxRVqvJ09QnCN8zT5sQf41uLhaapXDCn9/0peP/A0NM86GcaFD9pCFOYKoqvGJYuSltOzxa0a+y7QazTnCWTH2sbx/vnh9bxFQymMQN9KZ3jmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514841; c=relaxed/simple;
	bh=CmW2TWDbj+sd+IIAyfwHA+Ex1l7cZLJcHPWJPr9uD8Y=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=j6D0sha0G5+hKtOWEMtfGSsxLSq7ZmymdAoCIe0ge0yJUIo1ACpzTypV3Pb4OFWKtbTX77TFYJKN3zUuX6MoK3LfG6SL3wRlv1uFveWCYsH6vd2xGpJ4YQJo26NCVowgzc2KVW+J+7NoqZiS7G8lhXN+UxfvRogZ/lKGGWHnerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf5fe1ca9fso88957539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705514839; x=1706119639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6MXMgMiGYzsFjMUMCx6V1kOmEjQ4JWh3wRvu/GOMLU=;
        b=Pn7C87An2QoE8VteEP2H8sRjLQCu9XQ8ij0/oYXV53wcR97/4434ccOawPaLz+brdc
         eWHbX0LJm1QnPv9hUi0XgHd2+f3xo9Poo8YdeUp/3LZS2Kl/lanBIxD3u/LH0Y2BAoqz
         5cu8Vxl1zAmzGKZw+SOY88f748tKcfZiHuZIAdz9eAuZO/FTgwNCVwo1oDpj3ynNKjG5
         N042uPY6r1umLh9XlMVaFSj8m8UuWYNxB6MpxOKqrCLDbafzSnb9baGizjCQJqm+Z0mI
         Z1P3gc5q+jHlObVqNEZJnspM3NzAG6MmO/iJEilK1KDjbD8+dKaJFdOsuQbXcQiGVAv2
         bAFA==
X-Gm-Message-State: AOJu0YyKgPCWn2RO8IVdl9K1rrOS9K0iwK1z06AfpX7UWe5w/0inmHto
	tA0CaqXs1pG4Gc3QeYll8PZ+QZoNXbzLDYSA9l1n4yNLixVy
X-Google-Smtp-Source: AGHT+IFPgX/DJ+6CmPwDKhbwx0Xxde7H7An/97c9QfJ5pPOMb0oAzhW+EEn7geoFWioKtFK13s3dpBQc0kV80W4b408U1JGM2Hvo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:360:290:902d with SMTP id
 j12-20020a92ca0c000000b003600290902dmr183444ils.3.1705514839457; Wed, 17 Jan
 2024 10:07:19 -0800 (PST)
Date: Wed, 17 Jan 2024 10:07:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a4924060f281e0a@google.com>
Subject: [syzbot] [netfilter?] WARNING in nf_hook_entry_head
From: syzbot <syzbot+ea8f0147cde55bfa62e9@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111ec0fbe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
dashboard link: https://syzkaller.appspot.com/bug?extid=ea8f0147cde55bfa62e9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a58a0f0eb33d/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/019e6b0bba7a/bzImage-052d5343.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea8f0147cde55bfa62e9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4052 at net/netfilter/core.c:302 nf_hook_entry_head+0x289/0x300 net/netfilter/core.c:302
Modules linked in:
CPU: 1 PID: 4052 Comm: kworker/u16:32 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:nf_hook_entry_head+0x289/0x300 net/netfilter/core.c:302
Code: 80 3c 02 00 0f 85 82 00 00 00 4d 3b a5 08 01 00 00 75 a0 e8 c9 c0 cf f8 49 81 c5 90 00 00 00 e9 ae fe ff ff e8 b8 c0 cf f8 90 <0f> 0b 90 e9 24 ff ff ff e8 aa c0 cf f8 90 0f 0b 90 e9 16 ff ff ff
RSP: 0018:ffffc9000c417ac0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff88b736e5
RDX: ffff88803a6c2400 RSI: ffffffff88b73898 RDI: ffff888029572108
RBP: 0000000000000005 R08: 0000000000000005 R09: 0000000000000005
R10: 0000000000000005 R11: ffffffff8ace21e0 R12: ffff888064b59cc0
R13: ffff888029572000 R14: ffff88810a331c28 R15: ffff888035da3dec
FS:  0000000000000000(0000) GS:ffff88806b700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005569f03ef238 CR3: 000000002d4cc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __nf_unregister_net_hook+0x81/0x680 net/netfilter/core.c:494
 nf_unregister_net_hook net/netfilter/core.c:533 [inline]
 nf_unregister_net_hook+0xf3/0x110 net/netfilter/core.c:529
 nft_netdev_unregister_hooks+0xaf/0x270 net/netfilter/nf_tables_api.c:309
 __nf_tables_unregister_hook net/netfilter/nf_tables_api.c:358 [inline]
 __nf_tables_unregister_hook net/netfilter/nf_tables_api.c:340 [inline]
 __nft_release_hook+0x446/0x560 net/netfilter/nf_tables_api.c:11218
 __nft_release_hooks net/netfilter/nf_tables_api.c:11233 [inline]
 nf_tables_pre_exit_net+0xc5/0x120 net/netfilter/nf_tables_api.c:11379
 ops_pre_exit_list net/core/net_namespace.c:160 [inline]
 cleanup_net+0x46c/0xb20 net/core/net_namespace.c:606
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


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

