Return-Path: <linux-kernel+bounces-13853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E7821389
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 11:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE121C20DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45220E8;
	Mon,  1 Jan 2024 10:44:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2046A2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fd87e7a04so106243955ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 02:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704105858; x=1704710658;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewnDTV1LOwNpnc7vIBEVefJx70mwTgZPcLpGjs0H0Ik=;
        b=sX1mH7LNv6pSJVrlWnCmRXeCzoVUKghLuL6lcgSIPg2iY4jt5wfpaUObDIaSEtRX3O
         N+aBkQNmSpRY19fqRkDEaMNRY3BEVR422UrNZixAX7xXxzRo9h12WHtQL5X7aY4uTY18
         yEVN9NVU1rnbzQkANpqSxFWULiNvjwwhz6gPne5JjXM3NofiYov/POMMliqOoieKBh4d
         nH5lGqdT1Dj4JWwTr+WJL/RAkDd2slgjQdaUORAqqe56S83kn1N4pNiFY3q44ck1E3H+
         y3oJwvolYTSRkpdNtNmyVE5iibu9pbpRUB/7231Th8zMuEFBWylr/fPZNx52E0whO4Qi
         OcBw==
X-Gm-Message-State: AOJu0YwlcZ9wg4jw6Pm9HVfmgopIkkACeVjNUuUxY+ERWQSUfBsUKXGb
	QoJNJjeEvroYaMaqQP9naFNx4tOTh0pk2aIk25vb+U1ibeQ1
X-Google-Smtp-Source: AGHT+IEaL9Ga2y5QBuKhMeZ3BqnKFxwtyqFQMCxid1IpoCpdkF4+3FncGX6KSQ2i2qudlPL6imUhsWp9DwT6v4lfwKAdHo59PBrM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:d4dc:1b1e with SMTP id
 i12-20020a056e021d0c00b0035fd4dc1b1emr2892753ila.5.1704105858448; Mon, 01 Jan
 2024 02:44:18 -0800 (PST)
Date: Mon, 01 Jan 2024 02:44:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a4548060de01081@google.com>
Subject: [syzbot] [bluetooth?] KMSAN: uninit-value in eir_get_service_data
From: syzbot <syzbot+5e132fbe94a9ede456ad@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16867338e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fdfc68946ad7a215
dashboard link: https://syzkaller.appspot.com/bug?extid=5e132fbe94a9ede456ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f3388e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13341388e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c25bb76d765/disk-c42d9eee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80d9450a6b6a/vmlinux-c42d9eee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b1a54cf685f/bzImage-c42d9eee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e132fbe94a9ede456ad@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in eir_get_data net/bluetooth/eir.h:73 [inline]
BUG: KMSAN: uninit-value in eir_get_service_data+0x25c/0x570 net/bluetooth/eir.c:384
 eir_get_data net/bluetooth/eir.h:73 [inline]
 eir_get_service_data+0x25c/0x570 net/bluetooth/eir.c:384
 iso_connect_ind+0x2004/0x2330 net/bluetooth/iso.c:1794
 hci_proto_connect_ind include/net/bluetooth/hci_core.h:1922 [inline]
 hci_le_per_adv_report_evt+0xc0/0x1e0 net/bluetooth/hci_event.c:6645
 hci_le_meta_evt+0x608/0x860 net/bluetooth/hci_event.c:7344
 hci_event_func net/bluetooth/hci_event.c:7674 [inline]
 hci_event_packet+0x1183/0x1be0 net/bluetooth/hci_event.c:7729
 hci_rx_work+0x687/0x1120 net/bluetooth/hci_core.c:4105
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
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
 bt_skb_alloc include/net/bluetooth/bluetooth.h:487 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:495 [inline]
 vhci_write+0x126/0x8f0 drivers/bluetooth/hci_vhci.c:615
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 4386 Comm: kworker/u5:1 Not tainted 6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: hci0 hci_rx_work
=====================================================


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

