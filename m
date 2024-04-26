Return-Path: <linux-kernel+bounces-159496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0AF8B2F64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E7E1F214BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E64A2A1B8;
	Fri, 26 Apr 2024 04:17:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD2824AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714105050; cv=none; b=JoVSQovnvclF3Fx3DNYVCMbrQrs+eLrP59WM6VvXHCYk22TyDYoE9o4eL17l2K3MbEYBch2ezBdZ7O2qpze26kyBOmPAutUlzqQYBV2aJqleYoOXi8pfd8WFhOi+/upkjhjnmr7ZzEfBCdWjeNzVHZtO3EttJsGftvmgVbvfqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714105050; c=relaxed/simple;
	bh=Z4+MYmJC6DG1mFDVMgMjdnn9SEEAO5yhpEWsn/ivNWo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W9WplYZ+DH83V4EU6g7DAppkSxMtG2hrqlCydP4aFF/eV2Byl+1YK1VjVkW5xlfg8sUDgf266rAQ602y2/8Q6hvaVqWMloY/Y0VR1wPIKNrLFU8Lpc3KJRg+k73uAM8jDI5e0YC5jzCqL7fw7DirDyFnwlh1kDgIalGCQ5nos84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b323b64faso16110605ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714105045; x=1714709845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qnf9hAXUw0WG4X92xmj3sgxvwJt1mXTEhzB4iNIPSus=;
        b=LMzCohp1GXLMZnuY5Bfr1fmfMethumMiMf1HDiYzAmuvaGZDiywbTvT6XbKRDIMRkH
         6xv1gqsFehGKLGlmWf2K2a96o0Lb12ED1p2JzpckcOi6Iy+UV6qw6o3LBmkUceEUhi/V
         HzAaFs0YzVPAaGIFicqGlBBhtaZSs7fhXkCrgfDeI9Ad0kdxLJF+WevTIYn7WDrOutJu
         6LMWDxjNgpTikj+EXWI2lXAlbq2FBZf1wtYW26kqmNr2h7O+HxThuF3U82bPofqxuwrL
         5W/iY0QgR4mZt/vb+2BdxViz4lYexS7dpV9y66gbWXYKZKud6nFtcCiT1SunaNR9qVvX
         ITBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgLrwsiNruPX5sArsc2roaZ8X/K1cL01GLf/7UDxXVNbcZbw3jBDV44VY4Mrn0PM+z1OuUqJ7TQtihL6KCZXXJxKq+BTsXlLzXK0dy
X-Gm-Message-State: AOJu0YyIHnCGjtDWTjBFiMBWirTsHkZD6cd5DW+23pexOQN2LeiDMoEh
	ZgQCjblNe3K04EojOkmst4zwWnPPCQ3HQidLd4EwwCKza3RKPaMN+1yFiCnd/8jBPk1qZ9A7mYK
	gWHjzmcJ6VvlFmESuXnjnmuqzw96+jAwcnApeIx8MvB1zk+E3SKdj6uo=
X-Google-Smtp-Source: AGHT+IFQtSOmFou5L4u9Lz6Sy6/enLjkQAW1givlNz5GT/vgyYFLZiLR+VzzGSaCEFyBZpuxd9tb7/ruE/Hc/49YGwcx0W3fcOm/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:36a:fe5f:732c with SMTP id
 s15-20020a056e0218cf00b0036afe5f732cmr59563ilu.5.1714105045823; Thu, 25 Apr
 2024 21:17:25 -0700 (PDT)
Date: Thu, 25 Apr 2024 21:17:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d49250616f82e6f@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_disconnect
From: syzbot <syzbot+9c830a0d0db9045210be@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b9f237180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=9c830a0d0db9045210be
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a58a1f6fe740/disk-e33c4963.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7cc2c92009ca/vmlinux-e33c4963.xz
kernel image: https://storage.googleapis.com/syzbot-assets/309e28d47292/bzImage-e33c4963.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c830a0d0db9045210be@syzkaller.appspotmail.com

Bluetooth: hci3: killing stalled connection 11:aa:aa:aa:aa:aa
==================================================================
BUG: KASAN: slab-use-after-free in hci_disconnect+0x208/0x2d0 net/bluetooth/hci_conn.c:190
Read of size 1 at addr ffff88802a8a4039 by task kworker/u9:3/5104

CPU: 1 PID: 5104 Comm: kworker/u9:3 Not tainted 6.9.0-rc5-syzkaller-00053-ge33c4963bf53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci3 hci_tx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 hci_disconnect+0x208/0x2d0 net/bluetooth/hci_conn.c:190
 hci_link_tx_to net/bluetooth/hci_core.c:3495 [inline]
 __check_timeout+0x3a8/0x560 net/bluetooth/hci_core.c:3642
 hci_sched_le net/bluetooth/hci_core.c:3825 [inline]
 hci_tx_work+0x139b/0x1ef0 net/bluetooth/hci_core.c:3903
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5102:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 hci_conn_add+0xc7/0x13a0 net/bluetooth/hci_conn.c:914
 le_conn_complete_evt+0x303/0x12f0 net/bluetooth/hci_event.c:5771
 hci_le_conn_complete_evt+0x18c/0x420 net/bluetooth/hci_event.c:5923
 hci_event_func net/bluetooth/hci_event.c:7539 [inline]
 hci_event_packet+0xa55/0x1540 net/bluetooth/hci_event.c:7594
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5102:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x153/0x3a0 mm/slub.c:4390
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 hci_conn_cleanup net/bluetooth/hci_conn.c:176 [inline]
 hci_conn_del+0x900/0xc80 net/bluetooth/hci_conn.c:1126
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5567
 hci_cmd_sync_work+0x22d/0x400 net/bluetooth/hci_sync.c:310
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802a8a4000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 57 bytes inside of
 freed 8192-byte region [ffff88802a8a4000, ffff88802a8a6000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a8a0
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015042280 ffffea0000c0c200 dead000000000003
raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015042280 ffffea0000c0c200 dead000000000003
head: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea0000aa2801 ffffea0000aa2848 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid -1057826110 (swapper/0), ts 1, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmalloc_trace+0x269/0x360 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 ipv4_sysctl_init_net+0x1c0/0x270 net/ipv4/sysctl_net_ipv4.c:1540
 ops_init+0x354/0x610 net/core/net_namespace.c:136
 __register_pernet_operations net/core/net_namespace.c:1243 [inline]
 register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1312
 register_pernet_subsys+0x28/0x40 net/core/net_namespace.c:1353
 sysctl_ipv4_init+0x40/0x80 net/ipv4/sysctl_net_ipv4.c:1578
 do_one_initcall+0x24a/0x880 init/main.c:1245
 do_initcall_level+0x157/0x210 init/main.c:1307
 do_initcalls+0x3f/0x80 init/main.c:1323
 kernel_init_freeable+0x435/0x5d0 init/main.c:1555
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802a8a3f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802a8a3f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802a8a4000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88802a8a4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a8a4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

