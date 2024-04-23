Return-Path: <linux-kernel+bounces-155278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF558AE807
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC30286DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99F135A58;
	Tue, 23 Apr 2024 13:25:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982745BFD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878706; cv=none; b=aL3b7cl0D4X6K1FMXLQkcd6nEVyhqMgWv8j/7E61ZkezxQ836qVc4dNloXU3w9OfnIyDfuWo/eWcg/vmMxHz8wXYxzx0M+xNrquf6XhabizZQAnVkMYKaMsA4sHyv1xfUzrTVN0jQahxlpkIarK6S47D9RDdNsvEe19NvlWUdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878706; c=relaxed/simple;
	bh=li5mPiRj/gWmCGU+dPs9WvPaNs2HhPtfOhXnj0OAJUQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IYyORrvJAWnwEROluLqxuNUc52v3zoJRRrQKa0OnVZBQWIrbN6QYX0NnRmuuA+jMFXpk0psAvmi/dODVeL5p03oCWu6y6UfakhVZJZ1INACyyQVPt6ylXwVWP7NllIpzzJ6Yr8zYq/j6YvRZF2d9yvDvdT5GS5mXRxq9cusE2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c10cac5f9so14622305ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713878704; x=1714483504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIgUwNpg2r3U9WpGtUr7XNajEkHCf3791Lm5SVmDy0w=;
        b=sXlCFDCKrCiJmu1/UbuaOU2Qd8+5XR1LkRpHV7l0+duCzQLsPnM8A5E4BuNg+MS6L2
         WfnlEtTH1tW1NkGNCm2wU9YzUYaP2FckhL+IFLp+Yko8u+IggnEHD33I4uFeGBSppKZ8
         hDkqT+WF9beiVPfuGoI5YoIKdic1oQ1zoSF77PQZcXEABEQFPkrkKFiidw4VKMaylhZS
         9oektDDeBoMw/Os1t2pG5lUcheH3NPmEzYA+tfNLkXEbklp3tEE4sQPU/AE2KbSIvjfU
         2Iedf49t7csSFSIqvD8LPNuGbL/3czYP4Lc76enROWYZMQKeixsYr354XIshYN+U42aI
         WBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVE/9xQZTAcruv0mq/1F2pLbGpUIEeLKWUm3v/1cH79IZTiLXEZ/JbEeMM9ZAXNo+s7Iu5l66Y1A616GUIUcWmjbrPZwi4REFyK5o/
X-Gm-Message-State: AOJu0Yyf1JMEtAoU/1qhj3xje+xv5YAct5DkZrw7F5AfsGS+9XOB8IBE
	9vF+PX8ApWtxei+uN/Ok4jRl1In/XEuXKnAe4FrEpEY9QF4Z7e37CTHlB926P5lpDFxwhFK+x/F
	ypJUOxVelUxX8+upgKoTsmHbekx70v7w/TxQCw4pI2c1wUl06YS0yNNo=
X-Google-Smtp-Source: AGHT+IHWP/pCi1dsrQVCWo9u4j9a1XGvO0uxf4kPOnJ+nMKc6k4Kf6Os0SmkmeGL54kwM0poDlwWQwYFmeRusnPjWXNEkJO0t5c8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152a:b0:36c:1220:b571 with SMTP id
 i10-20020a056e02152a00b0036c1220b571mr292584ilu.5.1713878703921; Tue, 23 Apr
 2024 06:25:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 06:25:03 -0700
In-Reply-To: <20240423104232.2984-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055e94d0616c37bc6@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: out-of-bounds Read in netdev_unregister_kobject

==================================================================
BUG: KASAN: out-of-bounds in device_for_each_child+0xa7/0x170 drivers/base/core.c:4044
Read of size 8 at addr ffff88806e92d5f8 by task kbnepd bnep0/5637

CPU: 0 PID: 5637 Comm: kbnepd bnep0 Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 device_for_each_child+0xa7/0x170 drivers/base/core.c:4044
 pm_runtime_set_memalloc_noio+0x114/0x260 drivers/base/power/runtime.c:248
 netdev_unregister_kobject+0x178/0x250 net/core/net-sysfs.c:2106
 unregister_netdevice_many_notify+0x11dd/0x16e0 net/core/dev.c:11135
 unregister_netdevice_many net/core/dev.c:11163 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11042
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11181
 bnep_session+0x2e09/0x3030 net/bluetooth/bnep/core.c:525
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6e92c
head: order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000040(head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
head: 00fff80000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
head: 00fff80000000002 ffffea0001ba4b01 dead000000000122 00000000ffffffff
head: 0000000400000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x140dc0(GFP_USER|__GFP_COMP|__GFP_ZERO), pid 5732, tgid -1102947349 (syz-executor.3), ts 5732, free_ts 127654865274
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x91/0x1f0 mm/slub.c:3911
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc+0x320/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 hci_alloc_dev_priv+0x27/0x2030 net/bluetooth/hci_core.c:2500
 hci_alloc_dev include/net/bluetooth/hci_core.h:1672 [inline]
 __vhci_create_device drivers/bluetooth/hci_vhci.c:406 [inline]
 vhci_create_device+0x12e/0x720 drivers/bluetooth/hci_vhci.c:480
 vhci_get_user drivers/bluetooth/hci_vhci.c:537 [inline]
 vhci_write+0x3cb/0x480 drivers/bluetooth/hci_vhci.c:617
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa86/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5462 tgid 5462 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x986/0xab0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __folio_put_large+0x13f/0x190 mm/swap.c:132
 __folio_put+0x299/0x390 mm/swap.c:140
 folio_put include/linux/mm.h:1506 [inline]
 free_large_kmalloc+0x105/0x1c0 mm/slub.c:4361
 kfree+0x1ca/0x3a0 mm/slub.c:4384
 hci_release_dev+0x1516/0x16a0 net/bluetooth/hci_core.c:2833
 bt_host_release+0x83/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 vhci_release+0x8b/0xd0 drivers/bluetooth/hci_vhci.c:675
 __fput+0x42b/0x8a0 fs/file_table.c:422
 task_work_run+0x251/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036

Memory state around the buggy address:
 ffff88806e92d500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806e92d580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88806e92d600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffff88806e92d680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806e92d700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         3cdb4559 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12f4cd9f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124cca53180000


