Return-Path: <linux-kernel+bounces-122339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1588F563
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF711F2D1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1E2C1A0;
	Thu, 28 Mar 2024 02:29:17 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536E28E22
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592957; cv=none; b=oNfY1TVSCxG1i6bgeyWLbu7tH1yYqm1B0outSb8IXTHZV838btmcK/dK1VHbDWPIEiPv2lBMI18usLpaU6Ji7H3Je0pMoyxc8LRDDTtAa+N9yo2EPuYmTLYAo/Ws2QYA7v8q3H+hjnL8w/QJjK+kIpmpGI7XQG+fEB6lvkx/5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592957; c=relaxed/simple;
	bh=mTzOgJXbUc28KD1DH55r0Idj2E6Ve7dep457Dz8BqaY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gUXdQXhHTrz+O8Jph5UXGMdRXmjM11NKdwf2SJ5/njRW9OroQdiGDkd5SSd2pxXeCOz/Pboj0zSCCe8+8B0efVBIM/vFhy6HFAG6YC2owsirXMY5UwF5C9SR61A1fnEAXJHFBssYsAoUEVHrAz7tshQNTFnLL245dI0pl42e2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366a7e3099bso4379755ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592955; x=1712197755;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSrtnXgsGlZhzA9628XmK3j4EGEf/Hqb/M1rvquhiOA=;
        b=TsnhmcQNFlGCxn3pK+xukwthA3/ZVMN9gOQaayi4XlhfIX2tlnzxwZiwzRCxmODrhe
         gDXOtT/P7KazMys7pxwqqhbMiqHk0HLIxh2KqeVL4DueR+qhtmXKy32np4esdEPdkyV6
         ysj0PbGiskPPIzegTW+Rt7OPhY8bcktAt4M+Wz0bQlOWjGckosMLDYSXwgbjvTXM+rZ8
         4Pn/4Hly5vrhBUcKxsIv49Ez5ddc18cDSSRFUm09smL+hqaRNlwh0fVwJxAzomdfkKV8
         Rt/DBrORhJ40niFOMLIhtsqF09V2UwIb7W8eY9LWX/Cy5897fwEeX7S3C89uOFQOisjg
         dIkw==
X-Forwarded-Encrypted: i=1; AJvYcCXSz595hgsHXr/cjzuWOVaJrv2cs7mbI5G1Rur/20m2Wfr8/KILqsnj4EFZW8GuQTEY5Pp/jDl3W7knytlu4DlGGJ+TwrQWL3nWp8t9
X-Gm-Message-State: AOJu0YxLxoFzCyp+OKa5Md2uRit8Nrq2maZL5KMPSlG9g+oFO6cFCH4o
	DCWI52N8gpnhCDlA8JirrNqoiwKwVMAiivxKren9MxMnz+u5Exhg7QbY+QS6dg/LIegAWnZ6hAs
	KzibRM917U/7wA0XQJgRsZeF46gaa+/0vXNVCgNQHW2madycAG2VtSio=
X-Google-Smtp-Source: AGHT+IFTPSc8NMZF6ptaIoRTss0MDKY9s8rYVd2S8CBd5GxDDugF+RdmEZljg6OfCYr61RS+jpqX1ci4m1rfI/Sgy9G8PXQJrrR7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:368:9839:d21a with SMTP id
 bs11-20020a056e02240b00b003689839d21amr81194ilb.5.1711592955016; Wed, 27 Mar
 2024 19:29:15 -0700 (PDT)
Date: Wed, 27 Mar 2024 19:29:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001589bc0614af4a26@google.com>
Subject: [syzbot] [net?] WARNING in validate_chain
From: syzbot <syzbot+6647fcd6542faf3abd06@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12a69546180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=6647fcd6542faf3abd06
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1549023a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c7b2a5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6647fcd6542faf3abd06@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!irqs_disabled())
WARNING: CPU: 1 PID: 60 at kernel/locking/lockdep.c:150 lockdep_unlock+0x1e6/0x300 kernel/locking/lockdep.c:150
Modules linked in:
CPU: 1 PID: 60 Comm: kworker/u8:4 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:lockdep_unlock+0x1e6/0x300 kernel/locking/lockdep.c:150
Code: 0f b6 04 30 84 c0 0f 85 e4 00 00 00 83 3d 61 90 15 0e 00 75 19 90 48 c7 c7 c0 c0 aa 8b 48 c7 c6 00 c1 aa 8b e8 2b 78 e6 ff 90 <0f> 0b 90 90 90 e9 d2 fe ff ff 90 e8 0a a4 2f 03 85 c0 74 3a 48 c7
RSP: 0018:ffffc900015b6820 EFLAGS: 00010246
RAX: 3dc93ee123955000 RBX: 1ffff920002b6d08 RCX: ffff888017b1bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900015b68b0 R08: ffffffff8157cc12 R09: 1ffff110172a51a2
R10: dffffc0000000000 R11: ffffed10172a51a3 R12: 1ffff920002b6d04
R13: ffff888017b1c838 R14: dffffc0000000000 R15: ffffc900015b6840
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558bb644a7a0 CR3: 000000007a1d6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 graph_unlock kernel/locking/lockdep.c:186 [inline]
 validate_chain+0x15a2/0x58e0 kernel/locking/lockdep.c:3873
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
 read_seqbegin include/linux/seqlock.h:772 [inline]
 neigh_hh_output include/net/neighbour.h:496 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0x857/0x1380 net/ipv4/ip_output.c:235
 iptunnel_xmit+0x540/0x9b0 net/ipv4/ip_tunnel_core.c:82
 udp_tunnel_xmit_skb+0x234/0x350 net/ipv4/udp_tunnel_core.c:172
 geneve_xmit_skb drivers/net/geneve.c:910 [inline]
 geneve_xmit+0x1907/0x31a0 drivers/net/geneve.c:1030
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
 __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0xff8/0x1670 net/ipv6/ip6_output.c:137
 ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xab0/0x1380 net/ipv6/ndisc.c:509
 ndisc_send_ns+0xcc/0x160 net/ipv6/ndisc.c:667
 addrconf_dad_work+0xb45/0x16f0 net/ipv6/addrconf.c:4279
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

