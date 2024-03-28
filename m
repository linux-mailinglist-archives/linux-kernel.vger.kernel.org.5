Return-Path: <linux-kernel+bounces-122579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7469D88F9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EC11C212B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C958231;
	Thu, 28 Mar 2024 08:21:21 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CB5491D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614080; cv=none; b=RkUUMcF8n6S4q0bR7JW36LzGdDk/fGXBg/exrxQtacLl+JjpjPjjeV1czwRnV/0aW+6+d7Ql5zesVUwLVa+V7TB4YVS06mx1D6M82/Sj4HYDIwPE9S9c+s1l/zQ4tZ41tjuejAaMjlgnbIH+u7630DbcVQPNpLBJFWlXPTevE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614080; c=relaxed/simple;
	bh=MCSX0q4aQg77SlGr7mQ/0pTXUJibSXe6v6TlY3D1lsI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jluTaant1sqb3RGvVrbSn/5FUAxvy6awiCT+QNkazOqgJgzdvYBnQKycWm1CFCdd1ZAkpqMUjSPH7hFo1mxg9QkBgVAqAtGh3sW+elSaQv/WhDSaHSylUSqG2FoWrDEnN2Mu6JUVvhj0BKHq4uIfy/82+g6t2QV5EMBt3/vKFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3689a0abf52so5759265ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711614078; x=1712218878;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECf+rGZmG7JONk5+/pz8pSXo4jpd0Dy8/WSqTB1ROs8=;
        b=qKieUjFlkDEVc+8AKKJbkax/Y4D+VtjnNYiGLbWgRHf4Mu4sZW5wIRwJlX+LEC/cLS
         0/5f8JkXmbLHXPlvJziB+mlOi5DXm2/C6YyJAxqauJzsDpP1R1nN/v3rJqXoIghgPxyy
         grh7W5qZXETUA/ydzpESDPatoL39chdtIV/uMdv0KzIuS7p4XbPT6vBTRGk4FSGjjUBX
         vphIvfjaoedKlvAzy1nHWcAXVFuYnXPSpsz3G/gvMYAKGyA955ofBK50LTQ6h1qIwBkb
         F+Kd682DSEqiaZQ5hpt3mr1+yPUgWURVZ5G44Dp4LrPbxNhPsrx9e6xXqm0YGWThA3XM
         Xe0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6zHYWwuKhUzytKNoND6yfGxyaYiI63I8hqaCkrTNnfUUbp3rlrdDl7ZDiIbyUMdlClL9oqJxpitc1xn053BFxTgGm41zUfBxH71jT
X-Gm-Message-State: AOJu0YxlI31EMLiOD35+DHVUqAaZ+uMwt/VojwmCo2L+NHqPgWAm2GR/
	tyiTAjYchupeKTTfvysfTuOzGRbB2kAx4GxLJ1bYgxb0ZhKgHNwJGdLzyY3Pp0imKwQ5p9o3Zuc
	YTV5nTg64HmSUAn+aMyemNN244OR0TEJpjhHJ2Or8hNixkw+9F2gak4o=
X-Google-Smtp-Source: AGHT+IEaQi8QXGwYOjcERuu8VCNAnteICHXcLop1+RZucD2smqNyPXvGWD6JvQLQXoPOIqipJ4Dc8fze2hMsYzKKBlDqJkmAu9B6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:368:9839:d21a with SMTP id
 bs11-20020a056e02240b00b003689839d21amr133635ilb.5.1711614078045; Thu, 28 Mar
 2024 01:21:18 -0700 (PDT)
Date: Thu, 28 Mar 2024 01:21:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d626c0614b4352f@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_pending_foreach
From: syzbot <syzbot+a878cdc1d5451bfaa51c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14166479180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=a878cdc1d5451bfaa51c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a878cdc1d5451bfaa51c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_pending_foreach+0x7d/0x130
Read of size 8 at addr ffff88808c1adb00 by task syz-executor.0/31083

CPU: 1 PID: 31083 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 mgmt_pending_foreach+0x7d/0x130
 __mgmt_power_off+0x187/0x420 net/bluetooth/mgmt.c:9433
 hci_dev_close_sync+0x5d2/0x1050 net/bluetooth/hci_sync.c:5149
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:579
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f0d3407dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0d34e3d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0d341abf80 RCX: 00007f0d3407dda9
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000005
RBP: 00007f0d340ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0d341abf80 R15: 00007ffc97b42758
 </TASK>

Allocated by task 20735:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d9/0x360 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 user_pairing_resp+0x30c/0x580 net/bluetooth/mgmt.c:3632
 hci_mgmt_cmd+0xc45/0x11d0 net/bluetooth/hci_sock.c:1715
 hci_sock_sendmsg+0x7a5/0x11c0 net/bluetooth/hci_sock.c:1835
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa84/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff88808c1adb00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 freed 96-byte region [ffff88808c1adb00, ffff88808c1adb60)

The buggy address belongs to the physical page:
page:ffffea0002306b40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8c1ad
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41780 ffffea000275af00 dead000000000005
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 5149, tgid 5149 (kworker/1:4), ts 186720315546, free_ts 186591746837
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd1b/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmalloc_trace+0x267/0x360 mm/slub.c:4007
 kmalloc include/linux/slab.h:590 [inline]
 dst_cow_metrics_generic+0x56/0x1c0 net/core/dst.c:178
 dst_metrics_write_ptr include/net/dst.h:133 [inline]
 dst_metric_set include/net/dst.h:194 [inline]
 icmp6_dst_alloc+0x270/0x420 net/ipv6/route.c:3286
 mld_sendpack+0x69b/0xda0 net/ipv6/mcast.c:1807
 mld_send_cr net/ipv6/mcast.c:2119 [inline]
 mld_ifc_work+0x7d6/0xd90 net/ipv6/mcast.c:2650
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
page last free pid 7393 tgid 7390 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 discard_slab mm/slub.c:2453 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2922
 put_cpu_partial+0x17c/0x250 mm/slub.c:2997
 __slab_free+0x302/0x410 mm/slub.c:4166
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x1e0/0x4a0 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x23a/0x880 security/tomoyo/file.c:723
 security_file_ioctl+0x75/0xb0 security/security.c:2726
 __do_sys_ioctl fs/ioctl.c:898 [inline]
 __se_sys_ioctl+0x47/0x170 fs/ioctl.c:890
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Memory state around the buggy address:
 ffff88808c1ada00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88808c1ada80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88808c1adb00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                   ^
 ffff88808c1adb80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88808c1adc00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
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

