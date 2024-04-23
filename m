Return-Path: <linux-kernel+bounces-154440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E94A8ADC19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58754282F17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51191946B;
	Tue, 23 Apr 2024 03:12:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119F17C66
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841928; cv=none; b=YvhrKi7gxqV9rQLmfAuAcpjQVpR4Bdr6+NR/2tPGIjWqxbRiYrQQKCo0wVlKuCdA8mmDaswfQuK2J6zhuc6HvfwLjzo9nj5xda0FgT+rMaiFnu0dDB2U0pCPO8jgqAdKU8TCKb8E6dtmFrctvlkzC5Y3iv9lVOb1pwXrcHfSkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841928; c=relaxed/simple;
	bh=GWW51GVVwSLgUVGLvsw8rxCGl7sizkMmGhk3+hBuLhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ULV+Q62Ag3SaaeDJSYO8HkETFvWPguDm5U1ZvX0aBn7O7lZ4JvWBL3WiKuJ+7tDBosa8euL8NR7zqKMIdpt7vkNWpHfYpIQU7EJo2PK2Vg9xXUG9+3DHVty5PikN1cdrFbXP4gm6AnG9BkCejIzMZuXiERXD6sylG06wJStLOSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c0f8200ffso19978015ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713841926; x=1714446726;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lq5EIudatIUnUuPkCcE3HI/FjNPx7iAarBCgGCEWQ2I=;
        b=mdAT/jre79vEgmibPs7uCab2DOxLhfpT0IfCfS5Zbja/fSeBXdFnysKVmxZIAqXGU4
         hIKg8Q3hkJ73TI67NDm6EkwsfGuc2v5Ui0XD0D55j2VAeyo4xYKPl5un4s2fGMWppHVs
         3OGSTjLSWjshsKCdVYKRLbr0yQQXMdWDfNYNwYPeRxfOANCMwpAZ0fr79ewx6ShO0kUy
         8neik5dCV3IANKQCRdj2XC/gMuFGM6YNRn9PG87hjxfDGi2N+lDwXiP6oW2w341gJALM
         uBjrk3cyAwcEaa/ocbGLhjp7geHbLRE/g1X9Gx2V3F6RxnUzOXo7o4bzb+qLkvorB+QL
         SQHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUx51ivSwp0waZIk6Q2t/wsBvmZGGoNQMqSmW43M/lE+wqd+Syblbhvdd687HIG5458hXjr7or7DccuDmjditY8+eUnzr6CBX0Gs0Y
X-Gm-Message-State: AOJu0YxK4xwWnlRP4Bc9+rBTeuK+3m6f05t/gLA23Oitt+Y2gVd8GlgB
	GIo/SOJitKQiJUoeK3V3yoIAEpPJChUSy5/GyXm0CK3a83jPCecDNBMaTTM4tMOyRWVsnriuOyn
	pvYtmYjZ6Yl1OLGIhCu2VtCdfeAH5IoC9I7mZ5dWw1tm53Yk7HsWev6Y=
X-Google-Smtp-Source: AGHT+IG0T6rUXJMGS82aTSlmekyR6zHOZdcxSSoeIiDM/mvm4Dh0sa1EIRSZcS+vjFN/ZmxjpKKxoem0Bh+uEwnO0cbEPRQLw9tW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4126:b0:485:6cb9:9a78 with SMTP id
 ay38-20020a056638412600b004856cb99a78mr82697jab.0.1713841925143; Mon, 22 Apr
 2024 20:12:05 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:12:05 -0700
In-Reply-To: <20240422231617.2916-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000264c380616baebdc@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in netdev_unregister_kobject

==================================================================
BUG: KASAN: use-after-free in device_for_each_child+0xa7/0x170 drivers/base/core.c:4044
Read of size 8 at addr ffff8880293555f8 by task kbnepd bnep0/5664

CPU: 0 PID: 5664 Comm: kbnepd bnep0 Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619-dirty #0
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
 bnep_session+0x2e09/0x3000 net/bluetooth/bnep/core.c:525
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29355
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000000 ffffea0000a4d588 ffffea0000a4d508 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x140dc0(GFP_USER|__GFP_COMP|__GFP_ZERO), pid 5470, tgid 1627921193 (syz-executor.4), ts 5470, free_ts 128431373442
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
page last free pid 5470 tgid 5470 stack trace:
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
 ffff888029355480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888029355500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888029355580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                                ^
 ffff888029355600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888029355680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         3cdb4559 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10c3d0d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105d6b20980000


