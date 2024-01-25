Return-Path: <linux-kernel+bounces-38785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DCF83C5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91156280E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383577625;
	Thu, 25 Jan 2024 14:59:31 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6671C6A5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194770; cv=none; b=FWfcr5rVJZBgIXPSjsWk/FTdtaN/KRKB6T7SWaCFtDNZexfsYcNMFol37wiwlQMZ/NFi28uP5jak0bQIBQBEtn9Q1uBZlL44DD97IjxLNsERSu2k4Er4CtcfanpZxa2Byvlf67WRV+ixYthEysfm5L1LbRBoLoGeiluV0xRGWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194770; c=relaxed/simple;
	bh=SfFn+LVcnbuv5H4nqloyIIFSzx33UBtzl06rVuhZWQ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=re7krH/2dtkYjWZJY1163hw26fnQetdqY8a1HDaOjz0Q+Cg6/lI0VNlcbounKKcLOjCDF7AX61fi0t/cK/zvGf8bkrVKYXgK3S5IChTX1sT8JeUUj8JJDSoGQTX5WuQjm+FnVBE/bweizJfu0DT/H3V916Z570o5RV1NxOPFf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-362a46bf0a6so3646445ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194768; x=1706799568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mU/6jmvsgWaXqy37Fg30ApZ+uX0PZZKZQyHdPjP2LT8=;
        b=JArsN4+dIpEzFvdVbc9QxrDjuRJ2ZQHio71cC/hVsjaq2ktntpgaMQsaQVDStVSIcM
         +zqwcq2RjJ7U61D+Pyv4e0CuLcjQ3gKfwRs+wv5N7U8GtoPRH573YVVpE3uwAeFeub0d
         wW0qGenrojRTTQaQIlMZVdUSd6Yr+ivxzNnfTJkaeMOLnOTOKd6f0+ngIai9hgiBDzfz
         3kL/bhpZBNoG4FMacxAIGly+5XnilKVfx20lzyN1BMivn7ryfJzokH0lSTXfhEuMckTE
         mOOgNT835pntURUeEeobG55hAIfcjSNxE5doa4tdLoalfshj90nX1YcDfRmSg1jshrv1
         b0OA==
X-Gm-Message-State: AOJu0Yyy4RBZCPr9L8TNmYNgAq4P2zi66izMusNqN6jM469oCN9hTc6M
	q1quE+ZBPmdGyEcSsimG0jW7DUMplFTdZ8Q318WVnRfRlrQKFoOcqEWf0mCbAnHWzaAP3KNfQQU
	OUPwHw3vDLyk4OMpA34EG1qmH45ELUZ3ZwJEJnYMKu/iX+PTl5knD31c=
X-Google-Smtp-Source: AGHT+IHp4re/iMw2MOCT4gjPBNDzQTxoQGWDHzn1FkIssXpT44U6JZgNW0rYoAj/TyX3Vzm/1ErbMQyJ6nxzkngKtY20pGUYu6Bv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:361:9a4c:8bf5 with SMTP id
 i2-20020a056e0212c200b003619a4c8bf5mr151623ilm.6.1706194768397; Thu, 25 Jan
 2024 06:59:28 -0800 (PST)
Date: Thu, 25 Jan 2024 06:59:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000169132060fc66db3@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d73c27e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/79d9f2f4b065/disk-9f8413c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbc68430d9c6/vmlinux-9f8413c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9740ad9fc172/bzImage-9f8413c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nci_init_req net/nfc/nci/core.c:177 [inline]
BUG: KMSAN: uninit-value in __nci_request net/nfc/nci/core.c:108 [inline]
BUG: KMSAN: uninit-value in nci_open_device net/nfc/nci/core.c:521 [inline]
BUG: KMSAN: uninit-value in nci_dev_up+0xfec/0x1b10 net/nfc/nci/core.c:632
 nci_init_req net/nfc/nci/core.c:177 [inline]
 __nci_request net/nfc/nci/core.c:108 [inline]
 nci_open_device net/nfc/nci/core.c:521 [inline]
 nci_dev_up+0xfec/0x1b10 net/nfc/nci/core.c:632
 nfc_dev_up+0x26e/0x440 net/nfc/core.c:118
 nfc_genl_dev_up+0xfe/0x1d0 net/nfc/netlink.c:770
 genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 nci_core_reset_ntf_packet net/nfc/nci/ntf.c:36 [inline]
 nci_ntf_packet+0x19dc/0x39c0 net/nfc/nci/ntf.c:782
 nci_rx_work+0x213/0x500 net/nfc/nci/core.c:1522
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2706
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2787
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 virtual_ncidev_write+0x6d/0x280 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x48b/0x1200 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:652
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5642 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


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

