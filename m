Return-Path: <linux-kernel+bounces-42418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE34384011B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35975B22BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3FF55762;
	Mon, 29 Jan 2024 09:15:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304454F94
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519734; cv=none; b=QYZlX0T8D7z8cHLZMvHm+qk2a8G4H5+2TxytVfvvRxhyzKldmPtCpYQBvCAg5zlK1NYgNVlHYT8N2qBeBlx0OFpbSuO4414MWU+6deE+A0U8rWY+T6YIzQ4SIh3qYzXZobZlUh89xgOWE0EGKA4MSEhTqDwABxhHZPLA3M3G7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519734; c=relaxed/simple;
	bh=n7Ro5k4D41eeTFxjV8kRtk8Tw9u96xuxYfBmFbbhtsc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BbKPqT9CeuEfSPMlwJXEHw7lHWuL9F51xm2RQNIyvno14eC0Pwx6w5hf1GxFbRRGBKVgN04T/BwD69AGz7ZeBsCGBfEjzEulMyu+/Fq4OqbAThoH05tzf45zI9P4R1USmhuOMP3QvRbibsNHqh4TXVIVE+55aMXGuOLMnhe4kQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363779f3989so8131335ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519732; x=1707124532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1CgmN53Ha8muyWD5yoizAce+SqLZpQJ1VOlNUG1ZJo=;
        b=wWPq3bBLoXFIxHZe+nKTJsPN92Tn/h3j4mt2mGglcJ3aYkSQrrQe4xQRebLiPgLHza
         1neVXGE+AlBDVVTJARP7CP8mnd30jUmzrf3sEIIamdEC9G7qxX5oCPcF1H64n1lTXN/0
         5lXFQW3Ki73Up9IpxTzsnnoKl6MakKFyyV8948wV3/AXosRhwukEC0v1xuugM8z3PATH
         xPjnMj65j/9dlku1C3F+Ny+BlKQYzjoVX3DT4c88RDBvJPiWegG1d5VeTT6AJyYhEkpV
         +nbFOyeIu7xQ6KrrgL+XACg5KY1vfNSDPGoxwp9qVBcrJmpyiRgGan+qcr9D6LzSs2++
         xjfg==
X-Gm-Message-State: AOJu0YzFLjwIn3/f4ESOANQI+fe9exZ9mhj2269JkPQM9hDgpYKlfutB
	gUwahSI5SItLyPn0WxAUk2wAIU6sS1w0v96Zbfey4nPso0G1PwRTpHEbfDQnA6+WpTfKVmMi1YY
	51XU78diMfkfDPjFUQRO5OgfMilRqcfeUQpVnTIy+1mrxGRV2LjWyZHc=
X-Google-Smtp-Source: AGHT+IHGNTNEnWBcHA9v1y9pBI6lXDWy2prvEkvn6kkXysbgTUPGP231HcCZJ8r4y/NvqOeXaISP/fG7jvzbXzII4euT4F39+Q3x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:361:a961:b31a with SMTP id
 h21-20020a056e021d9500b00361a961b31amr535681ila.5.1706519731972; Mon, 29 Jan
 2024 01:15:31 -0800 (PST)
Date: Mon, 29 Jan 2024 01:15:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d31170610121646@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rsp_packet
From: syzbot <syzbot+685805de744584f4d24b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154b0f30180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=685805de744584f4d24b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/79d9f2f4b065/disk-9f8413c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbc68430d9c6/vmlinux-9f8413c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9740ad9fc172/bzImage-9f8413c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+685805de744584f4d24b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nci_core_init_rsp_packet_v2 net/nfc/nci/rsp.c:107 [inline]
BUG: KMSAN: uninit-value in nci_core_init_rsp_packet net/nfc/nci/rsp.c:131 [inline]
BUG: KMSAN: uninit-value in nci_rsp_packet+0x294d/0x29a0 net/nfc/nci/rsp.c:376
 nci_core_init_rsp_packet_v2 net/nfc/nci/rsp.c:107 [inline]
 nci_core_init_rsp_packet net/nfc/nci/rsp.c:131 [inline]
 nci_rsp_packet+0x294d/0x29a0 net/nfc/nci/rsp.c:376
 nci_rx_work+0x1f3/0x500 net/nfc/nci/core.c:1518
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

CPU: 0 PID: 5070 Comm: kworker/u4:3 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
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

