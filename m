Return-Path: <linux-kernel+bounces-135043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236D89BA56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079B1288E25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B9C3BB2A;
	Mon,  8 Apr 2024 08:31:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9808A38DE0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565085; cv=none; b=Q50wJ0+Pzn3eeezbFX4oYgrN8oO+adl/ZF+1gOYevbyDiSLOXRBHDyoNn/b602bAVMtH5q1/12WkZxw2+yGgEn54bhHgyw4+UR3dqRpPIE3L6XW1xecTDM9Q2LYQSqAcqRnSyiu2NHLHwvgzrvtjTJwawVE1ksKkCFUMzaMPCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565085; c=relaxed/simple;
	bh=SvWrYKKF7tFCzrd01GY6b+TJR7TXTnF6RQx0uR9ei8o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G728BOn5q5D2aBlKvt4U8rXsqBSf+V+Lq5+gltT+pJDhtmBoYD60+LIEUDsRGjfiFuVinqGH2Udgy40BZqU0hhmMUjRgxBDhUEbrDwsDywMLyM2KlpjnKYtwPIzPfx/0THrTVl1nd1XDOGVuce2OpIqwFm/osDmHxsaUMNuBPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d022d0c76aso422191439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565082; x=1713169882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iozYkUc2qvNqy70fx2rka/MS22ZH8JtD6mcNL0+butg=;
        b=gfbMudjAJGjHOjvlb/WjjXCg9Xt6OViv0dw8dDf/yb7MkzUqDCG4WWF5f+hg9XJPFn
         jrk64M2Xjslxi2lzVYPv7pMS+FnPyBqcbmtWMK4mWO7oPFuwXeO0q3XMzz7DzIuXsIBn
         LIKR+/+4CYuCSLG5k8hkA88nWY++jAr31qIhPp6DKOQuhRevRc169to0OBPCnW+H8Adr
         sylvx/j5wadZg+43qk64KGfaY9hw1QDYdzm4y9mINxb9ejuTD6pkRrzY9ncvdqTLkb8z
         dbCFuK0X+Hh0caRzMJ5yePZqlqL1A4jWoPfUnRe5SmqAbQKfZbVG49HUvb3shn0IH6SY
         6OXA==
X-Forwarded-Encrypted: i=1; AJvYcCVLsIeKPqQ+zhI7MQgHX7wv/mBaq6jKWON91pLM9YpnVsbdtOU6rEeHCaqdvq2xcSy2IZQY4tu1xuDjqgxUFXPsM7V38mKyH5xbKRjK
X-Gm-Message-State: AOJu0YzSpZMWoFFUyllHswcGwOeQoe1L/QUNxnk6YsdaQn/CDzykLYG5
	nB7ON2wVtvorZqxhP1bhiZNuq9J8RGLN0S9iH9VKwp7RjWoI8GEQKCA7orcYd+3+cDZDRZsT85K
	peok1SqVEilzamEpsEn2Vg5MvsEZO+L+svR7/G0dExSJnuNQ0EdKEXY0=
X-Google-Smtp-Source: AGHT+IH9rbGx0qFELfZIoyo/enSFmaj0Zh9IHtxzaUh92qkUIkzwUcUpaPT4lAlOLtETqqit7vEO2d3bQ/gJUz5ZjqcJ3k12YbFr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c7:b0:47f:20b3:925b with SMTP id
 j7-20020a05663822c700b0047f20b3925bmr412692jat.0.1712565082795; Mon, 08 Apr
 2024 01:31:22 -0700 (PDT)
Date: Mon, 08 Apr 2024 01:31:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a3d3e061591a19b@google.com>
Subject: [syzbot] [bluetooth?] KASAN: global-out-of-bounds Read in __timer_delete
From: syzbot <syzbot+0a63bf51a80298491d8e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17c5cc26180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=0a63bf51a80298491d8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a63bf51a80298491d8e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in timer_is_static_object+0x5f/0x80 kernel/time/timer.c:735
Read of size 8 at addr ffffffff94884578 by task syz-executor.2/7343

CPU: 1 PID: 7343 Comm: syz-executor.2 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 timer_is_static_object+0x5f/0x80 kernel/time/timer.c:735
 lookup_object_or_alloc lib/debugobjects.c:581 [inline]
 debug_object_assert_init+0x228/0x440 lib/debugobjects.c:898
 debug_timer_assert_init kernel/time/timer.c:846 [inline]
 debug_assert_init kernel/time/timer.c:891 [inline]
 __timer_delete+0xad/0x380 kernel/time/timer.c:1413
 del_timer include/linux/timer.h:194 [inline]
 try_to_grab_pending+0x159/0xab0 kernel/workqueue.c:2089
 __cancel_work+0xb8/0x390 kernel/workqueue.c:4278
 sco_sock_clear_timer net/bluetooth/sco.c:119 [inline]
 sco_conn_del+0x161/0x310 net/bluetooth/sco.c:200
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2022 [inline]
 hci_conn_hash_flush+0xff/0x240 net/bluetooth/hci_conn.c:2566
 hci_dev_close_sync+0x9ab/0x1050 net/bluetooth/hci_sync.c:5153
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_unregister_dev+0x1e3/0x4e0 net/bluetooth/hci_core.c:2773
 vhci_release+0x83/0xd0 drivers/bluetooth/hci_vhci.c:674
 __fput+0x429/0x8a0 fs/file_table.c:423
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 get_signal+0x176e/0x1850 kernel/signal.c:2907
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:212
 do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fb920c7cc9a
Code: Unable to access opcode bytes at 0x7fb920c7cc70.
RSP: 002b:00007fff790ac930 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fb920c7cc9a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fff790ac9ac R08: 00007fff790ac28c R09: 00007fff790ac697
R10: 00007fff790ac310 R11: 0000000000000293 R12: 0000000000000032
R13: 000000000002aad7 R14: 000000000002aac1 R15: 0000000000000003
 </TASK>

The buggy address belongs to the variable:
 xa_init_flags.__key+0x18/0x20

The buggy address belongs to the physical page:
page:ffffea0000522100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14884
flags: 0xfff00000004000(reserved|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000004000 ffffea0000522108 ffffea0000522108 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff94884400: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
 ffffffff94884480: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
>ffffffff94884500: 00 00 f9 f9 00 00 f9 f9 04 f9 f9 f9 00 00 f9 f9
                                                                ^
 ffffffff94884580: 00 f9 f9 f9 01 f9 f9 f9 00 f9 f9 f9 04 f9 f9 f9
 ffffffff94884600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

