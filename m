Return-Path: <linux-kernel+bounces-49868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73DA8470AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F675B28EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCC523F;
	Fri,  2 Feb 2024 12:53:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAEE15B1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878406; cv=none; b=hwfuwBsuUk52kaPBna+y/js2zRuA4U8ICWGjTpIzLGa+Xi80N2GovDuG6Rb5F7M0VNL9wlIPquOZJVDQT9moPt92RHD2rCBz+rsKd83nc35X2PdOURUMv6jGup2NH6f42jO7GSjxvK1c/rjUd3Y1DyhjxCSCEGDB79LVXGnIsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878406; c=relaxed/simple;
	bh=NhDd+Tjrs3zecVWZWAokSyfo++GFjqSQ5meR7L0p6H8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dyZe5x/RDcvEIsywuE4DCZ+p/KaIoCisWHo9fEmrZIHM5VMqQx66syStZ0WsQY8/D2jSWAX8OwSV/CLYtDGj1ygbXBofDczhrBRSl1vMuCHcbopxQSBfHVCQpDaiXrSaPN4AUx7cOQ4FaeC50U9ZmftYIB9xW4BtGdNuDr1xaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363930ba977so13899215ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878403; x=1707483203;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfyqUo/5cFyOU63RLdmNc5ZFT+mIllhFxuedyQIjzEo=;
        b=H/DS5+vX0slmOoa1uvTn9kqHCS+dK3qaL2kiK84cym4e+wwiBPjib3JfTFA6chokq1
         hzbBxkMgeRHl1QVbvpMrnzEzfsdNVYmXS4AQbwSDVE1pMpvygPZ2gkfWRndR9nJ77Ji4
         m+2wK2N5nRzi5iiXOKQNPSThuxMNaG3mQojpjB6xeMSMPhAPb+X/CWO5VlPIPw7DaBmb
         3rC3/xLXuBJG9nlHOjfasYABKPXF8fmfw9dLjv5UjtroXRtXbcqXRuFUFBmmFuFTENrO
         kecpQBfNG+GqtTOABS5d27R56o1SuiE8MvhZ86yO3I6W25N+bU87PdDXmbiF1ZHPrwyY
         sRdw==
X-Gm-Message-State: AOJu0YxzDjo1ydhc/1OejaHjlD26MF7X5nsmlxD3b02oefI9dVS7gQig
	tED1EEpFk6wtn1zkid6IHyhOVvknmQAyNn3Z5d7snRq+nM6Zjx0JFdu7f/0+oWIfuHcmEWXRE2b
	rXes5xuWMDGC56MLX8DlWlyFEXd0Xs4RUkcudjMorGnGTnA3Gg86wXHQ=
X-Google-Smtp-Source: AGHT+IHmOpnUMmBm28DUostXD8510BC4d6i1vxfAp9miDSNPMhWBVcztynrUCGZJgCptqlVMFstwgFiFvi+B4/tdWNyBn8gDUjmJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9252:ed47 with SMTP id
 j15-20020a056e02154f00b003639252ed47mr180263ilu.1.1706878403651; Fri, 02 Feb
 2024 04:53:23 -0800 (PST)
Date: Fri, 02 Feb 2024 04:53:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecb4750610659876@google.com>
Subject: [syzbot] [netfilter?] WARNING: ODEBUG bug in hash_netiface4_destroy
From: syzbot <syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    021533194476 Kconfig: Disable -Wstringop-overflow for GCC ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f8fe7be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60b985eda147877
dashboard link: https://syzkaller.appspot.com/bug?extid=52bbc0ad036f6f0d4a25
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d076fc4bbcb/disk-02153319.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/90a9389ef418/vmlinux-02153319.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72fe9fbafdc0/bzImage-02153319.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff8880157e3050 object type: timer_list hint: hash_netiface4_gc+0x0/0x470 net/netfilter/ipset/ip_set_hash_gen.h:537
WARNING: CPU: 1 PID: 8549 at lib/debugobjects.c:514 debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 8549 Comm: syz-executor.4 Not tainted 6.8.0-rc2-syzkaller-00199-g021533194476 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd 80 cc 6e 8b 41 56 4c 89 e6 48 c7 c7 e0 bf 6e 8b e8 be 4b d6 fc 90 <0f> 0b 90 90 58 83 05 a5 f6 23 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc9000437f038 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffc9000a19f000
RDX: 0000000000040000 RSI: ffffffff81509966 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8b6ec680
R13: ffffffff8b0f3480 R14: ffffffff891a9740 R15: ffffc9000437f148
FS:  00007f587a19c6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8d9cf81378 CR3: 0000000074178000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x4b8/0x600 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2093 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x252/0x370 mm/slub.c:4409
 hash_netiface4_destroy+0x204/0x3a0 net/netfilter/ipset/ip_set_hash_gen.h:460
 ip_set_create+0xda2/0x1360 net/netfilter/ipset/ip_set_core.c:1157
 nfnetlink_rcv_msg+0x9c6/0x11e0 net/netfilter/nfnetlink.c:302
 netlink_rcv_skb+0x16e/0x440 net/netlink/af_netlink.c:2543
 nfnetlink_rcv+0x1b4/0x430 net/netfilter/nfnetlink.c:659
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x545/0x820 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8bb/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab8/0xc90 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd8/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f587947dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f587a19c0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f58795abf80 RCX: 00007f587947dda9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007f58794ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f58795abf80 R15: 00007ffc5fbdd0c8
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

