Return-Path: <linux-kernel+bounces-50886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B106E847FDD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC2C1F26654
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A4D287;
	Sat,  3 Feb 2024 03:12:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575879EC
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929947; cv=none; b=F+hnT9IFO2VB3Wcmxe+r4/hWfPXrvHZqqIBfJl3ejmcVGVFXHXkBkqgLjIc4wc4nr0Fd9KyY+rDQwlgHEy90mxiNI4zMTFyb97mh2NabRBTkvERiNZ6F+sBmIVRBVO9TP+OGegejHXofTDjT72ZJmOf4KyzjMg3ShjNIfepZx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929947; c=relaxed/simple;
	bh=dxGXXVhs/4dgRo9jmAIcF+obGB4BDOna/EY2wTBjvoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IQTvP/g1WC/A39eh0JemvjXUL1C2FASooRJNpmc+GUmy1734uQUFioggyeBdCm8irN/AMYN5SMR2r1Gq9Sj3hUZVWvgSi6MOZVGJ2pufRN2lBQKvA9NG3uC7e4ypvoBCVHDmbHTqqlAs9Su6xmqAQ7muegKTk9+z/fg8+TfwfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c018ee4e46so189957539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 19:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706929945; x=1707534745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9boHSuibTSW8wHdrZL4yEexUDDVYmeyGpHIKOqzrahY=;
        b=SnO6KEUzQouqYoul6Trqa9Ds6lCacJ15b+JmsQK9/6LznNLpU3/NB9yrRM+Eojv9QH
         qmJpV6f0QyVvjN/dpnrkMJlyrvHxUzzcLIOKPgOZ+qYbtkonin7q5N+AvIMlFzj+Kvq9
         f7wFRPV0S2S3xVEnids5KzYbpokJA4aVi13AO6ED9Z09Fuk682dCEqpZWnw81lzxWF96
         hxCpYcGX8VhMYgyJWNJR1LSoxhKx1z0xok6yx5KhlSo8/e483X6M6I8jVeWjx49DN+of
         yEW/0Mct66/XsydOk9NMILkeY90HPRMAefWxfPj2iuoWjHBBVZlJT0JnqkswytINsg25
         DLfw==
X-Gm-Message-State: AOJu0YwDBtRy37OQtUcow1yoU7cRdj0g6trExhVx4J30JbbEyz0TTFJi
	+sB8piIIj1z0zeV7iV3kB0Mw0HVItvnNxzV90TZ9gVkwXFQKYQ1dAxwpmpwetasjECrXqH/ILpL
	A9Bziohco2gynj0peXQNxNz430NAO4ay/o9G+V5JRvNESQSOx4R3EvjI=
X-Google-Smtp-Source: AGHT+IFT6BW7LJ4oUZWETS5ReP1qbXAlR/uK/E1KrsLs9Sj2TMRPjN7FMgUJ5Ol3CTvKxDAU87hEmbyQhBOG7fJLxHHxyAfobcCZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:ec08:0:b0:7bf:cd7e:6a74 with SMTP id
 c8-20020a6bec08000000b007bfcd7e6a74mr26773ioh.1.1706929945452; Fri, 02 Feb
 2024 19:12:25 -0800 (PST)
Date: Fri, 02 Feb 2024 19:12:25 -0800
In-Reply-To: <000000000000ecb4750610659876@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e28060610719994@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in hash_netiface4_destroy
From: syzbot <syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6897cea71837 Merge tag 'for-6.8/dm-fixes' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1181d4ffe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=457249c250b93697
dashboard link: https://syzkaller.appspot.com/bug?extid=52bbc0ad036f6f0d4a25
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174bd5d3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fcf5b0180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/002e2c38dde7/disk-6897cea7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/316b28b8e4a4/vmlinux-6897cea7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35f7067d9e3f/bzImage-6897cea7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888018aee050 object type: timer_list hint: hash_netiface4_gc+0x0/0x570 net/netfilter/ipset/ip_set_hash_gen.h:445
WARNING: CPU: 1 PID: 5074 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 5074 Comm: syz-executor696 Not tainted 6.8.0-rc2-syzkaller-00251-g6897cea71837 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Code: e8 fb 03 4e fd 4c 8b 0b 48 c7 c7 a0 71 fe 8b 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 9b f8 af fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 2c 09 de 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc900040cead8 EFLAGS: 00010286
RAX: 92d7284228c9b100 RBX: ffffffff8bac9720 RCX: ffff888026548000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8bfe7320 R08: ffffffff81577992 R09: 1ffff92000819cac
R10: dffffc0000000000 R11: fffff52000819cad R12: 0000000000000000
R13: ffffffff8bfe7238 R14: dffffc0000000000 R15: ffff888018aee050
FS:  0000555555926380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000504 CR3: 000000002386a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x45b/0x580 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2093 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x110/0x380 mm/slub.c:4409
 hash_netiface4_destroy+0x297/0x2c0 net/netfilter/ipset/ip_set_hash_gen.h:460
 ip_set_create+0x13b6/0x1780 net/netfilter/ipset/ip_set_core.c:1157
 nfnetlink_rcv_msg+0xbee/0x1190 net/netfilter/nfnetlink.c:302
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2543
 nfnetlink_rcv+0x294/0x2650 net/netfilter/nfnetlink.c:659
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f7cfc8b0bb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4de24948 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7cfc8b0bb9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 0000000000012024 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd4de2495c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

