Return-Path: <linux-kernel+bounces-13873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80B8213DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F5F28201A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF354689;
	Mon,  1 Jan 2024 13:39:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E33C35
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fcbc79fd3so163441825ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 05:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704116361; x=1704721161;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8FnIEcMFrHn8eKbutFIX8/q+SDhk+mEBhpSpWYx9gw=;
        b=eCMCv8dvIkxQBABOyp2lwDaJSyhaTrVuvJq4UVoX1kr7Rj5Z6F9hiylMPNwH+qas4Y
         6IGIBXCDFDbyU/9bcAfngqZii4bTybPwWWWtwcLCGPGhPjwq/Oh4sOsv9i0c6aIgw9C/
         oGOqUnelerNWCRH4523p/s1Xyr8UOMq8tUev8zNs/RnWqEoqRJ5+b++nDM72VUigNqOw
         b14TdMQUb25wovQ7XjuP7x+59ZqA6d33EnWdHh65Ql064r3c9B7t3Zuh/w9dcJn6ldfD
         3NgRVZ2zX5KqRAs5hW21+NZcn8bQplohHs+3c75AlldptN+gyqEunOE4spGJ9639HAtU
         eKJw==
X-Gm-Message-State: AOJu0YyUMhjG1V4jIqLSY2ACKYQGSnyjCl0lfSnrLLLLyMF26Nj3pOun
	Gm/JvtIzMTIIOtGXhXa0K8nkChoKgVx8kYt1IlwPSrqiJtNL
X-Google-Smtp-Source: AGHT+IGdgmSCVgzhXzmmQgkPzliStRX/MaKevhdpX/Z7BmCjNXaRSO1ElDFLnjY6vyGrPExJjhstACMj+55SmDjxGtEAuIQYRdCP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174c:b0:35f:ce07:e18e with SMTP id
 y12-20020a056e02174c00b0035fce07e18emr2216306ill.4.1704116361308; Mon, 01 Jan
 2024 05:39:21 -0800 (PST)
Date: Mon, 01 Jan 2024 05:39:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f31a3060de282e6@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_ntf_packet
From: syzbot <syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f82f1c3a036 Merge tag 'x86-urgent-2023-12-23' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111a1579e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a65fa9f077ead01
dashboard link: https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6dcfebcfcfff/disk-3f82f1c3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/827b51868337/vmlinux-3f82f1c3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4571542e7260/bzImage-3f82f1c3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com

nci: nci_add_new_protocol: the target found does not have the desired protocol
=====================================================
BUG: KMSAN: uninit-value in nci_rf_discover_ntf_packet net/nfc/nci/ntf.c:386 [inline]
BUG: KMSAN: uninit-value in nci_ntf_packet+0x2ac8/0x39c0 net/nfc/nci/ntf.c:798
 nci_rf_discover_ntf_packet net/nfc/nci/ntf.c:386 [inline]
 nci_ntf_packet+0x2ac8/0x39c0 net/nfc/nci/ntf.c:798
 nci_rx_work+0x213/0x500 net/nfc/nci/core.c:1522
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
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
 vfs_write+0x561/0x1490 fs/read_write.c:582
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 55 Comm: kworker/u4:3 Not tainted 6.7.0-rc6-syzkaller-00303-g3f82f1c3a036 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: nfc2_nci_rx_wq nci_rx_work
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

