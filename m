Return-Path: <linux-kernel+bounces-38887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1FF83C7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB82295CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6397129A70;
	Thu, 25 Jan 2024 16:23:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28076EB66
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199810; cv=none; b=V9ifQNh0txedhOjOiUjlukQQLTmmVmuV1l2/njOVMl7XptNuurfr7n/QlP3pSVQ4GYDs+SVMjRWf8V0crO5elEbc1PCgu1YQtFTNzDeiPTD3hjELcNPqFcGYrCN7Nks1P1GNCQmuTjgCT3ksX0BLPqQZoow5tbNkCLWQmRNJALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199810; c=relaxed/simple;
	bh=+dZNkcg0nSKMNnkYx6iANd3TYWWA8LSBZUJCdRBMUM4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWGpsTQ5hqYjqS+qlK8bJuy6z9BaKGOlzmmrv7lX6HasfswU/cHK7SqOWMh6xe8d7D3nMYd8o3gMSwLCyAm8aohkWbYf6rtGJohYh/FI6zBtxGzym0M1W+kJ56TzCzU2mqGOqrv4k8WrT/uj8kbncPYHVdfESey/8hbZQaYzBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bad62322f0so801878539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199808; x=1706804608;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfwtl2ceVzED0XspuP8Y3DZUDaUYR9ioK42BVWaG2HE=;
        b=NpRK5vQRmMYdi8DmuE9Oa0H0sBPi6ekX/MmZzr+N+hcuDFpKM5yrTiqW4TUUglND1o
         TPa9xehWOP+yBJWHD7jRTdeApF3dMiUemmgZ+TX2JMIEnO/F+5OdtCEIBHB/w0IIJUyO
         BRTo9vMADkQPkyYFyTMZH5up+bRynmwwhj7xYi75ycA5kUycDsHC34NLgooRtMPkoq7O
         ACF88R1j/xRTM+jrF2n+Y3L6AV3EkEKW4SdamOoh1Pzuu7pd/EyI6sOGRzR1bo6sdn3I
         4OwNgaPrWZs8ayOHRhTI8Kemw0ewWxCX99nwGFZwZ6g7/uHbhKGpykrxMtizJ3wQJOZP
         KhUA==
X-Gm-Message-State: AOJu0YyoMNyAlzM5qEP8HVdbDf9HL33yar9dpqLrxLF58w4wOmLbFDpx
	uFYMx6nyNVUvT/OZ6chOApDhgjYWVXz3sAtmkm5ha2p+o7JAnz+0kIdgdWdlN9WiVeSgG0rGOab
	oKHWsPOgxAZbgTTT9DbSSYYbJpkBJkxKwxdgdTOZ0TcVDCee3sflR/YE=
X-Google-Smtp-Source: AGHT+IGVe/HKB3iccQCPQ0WzW5lz56JBI+wiR7cA3nZjQC1DpK0plDcqQZUhNDqyGqCSGZOQUzI+xHfmWVD2wPOHrJ6hClLSyFwY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2190:b0:46e:d5b8:e1e8 with SMTP id
 s16-20020a056638219000b0046ed5b8e1e8mr21773jaj.4.1706199808156; Thu, 25 Jan
 2024 08:23:28 -0800 (PST)
Date: Thu, 25 Jan 2024 08:23:28 -0800
In-Reply-To: <000000000000169132060fc66db3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b5379060fc79990@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12c59927e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153e178be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a6c1e3e80000

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

CPU: 1 PID: 5012 Comm: syz-executor935 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

