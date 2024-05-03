Return-Path: <linux-kernel+bounces-167134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E18BA4D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E250A281F13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E4DDC0;
	Fri,  3 May 2024 01:13:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA957C91
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698809; cv=none; b=jr/1dNOBx3YSM/Rmg2LCTWKDlfCC6y+b0mMpBXx/XaaMY6mo644zMoYGU7VdJ8KuldJMB3dLDfSo//f/h9kJQOwcSmXErd9585MQJh9YYQySdPLFWU2Dluj4580WbaZL6hFuI7/l/TpyKf5oXuV/waKf+Lnk6gyzC/It/uJ+VEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698809; c=relaxed/simple;
	bh=C5bSRaeRDhdqUn8Eyq97XaM94mB0BRh2hZG55oEnB1c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BFMWhDdWCMFFYvWFncvv2Kaf+BsFVypMNhfJxbLc+OVS5Q438mAGogL78Bd1cPVljuaXeqm2AFZp2QP62ieQBbvDr/00fUfDphNcP/0qw5mVXqQN4Xkvqy0DVuY8jfnx69GAQC5hGBsQ7PlZL07xS2ieJlpPdO8WaXzK6cw+CNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b28210f43so86239435ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 18:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714698807; x=1715303607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BI+N+YTIPKWBJA/+tz2ysyW5Rmp7atv30zsEUaJ9g84=;
        b=rQD2oNSd8M2qXI7D2r64cQWH/DJYPzwjPKkRQjjG6Lw5KAMQxofVCKvyI2VyUqYQzl
         V4O9kejK8sLXck3liq5oQM0q4Q3kz45L8NOJ+YPplt58+r6f7YkKeEWe39IDaE1R26ZH
         /u7LQb+vN0FVz3pDAriTDRtIQVCuS5yl6U/TlID1QF5KD1zu6uNsX8zdRuwMH+O9mbRz
         UyvKHYlkqYbpEIvQJoOm6IagXMfrpOduF/xJGYkaBNK2IAC/RHMpKg4tvjxOkIJ3A4oj
         okPCv7lbSptSno+EaUgc1R+oq9Z9xmiZr5twlExJPkGqozM4BdujNDO4wibbJqwwtrTN
         ctoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/xldT3azsqPtlCs/Q96jFL2B54LvmzrefW+49C8EKYKuJ2l2zACHE4tS/dIDThwh6OpVGYAcvRdTodOVZ6Y2QJbxmiLeBbXYut4rE
X-Gm-Message-State: AOJu0Yw503XLj1eWCAv10eqmODSdbWrKM81P0ibavrXmrLc+AERSx8Im
	cG5YjuyWAT4PGeXP9/+jn84hw7Urx3KbQChLYrmf6Q0XHDqUr19iMepN2CAa77QMVHlz7hxxhyD
	aLDgID+7l4iitKImi+zwB6PhcZcdYTvdGDXds30steiues7hmNXFHoG0=
X-Google-Smtp-Source: AGHT+IES9A1UdTW+vYOe1Fl+a15fG3/lmyS+0i3SjzHTVRmE3Od40m+9ycqSwx0HdNgXwL4D5Cn4pVdB28bl85uaJ0RUW94BQgb0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:368:efa4:be00 with SMTP id
 s10-20020a056e02216a00b00368efa4be00mr46945ilv.3.1714698807390; Thu, 02 May
 2024 18:13:27 -0700 (PDT)
Date: Thu, 02 May 2024 18:13:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fc49a0617826da3@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in mgmt_remove_adv_monitor_complete
From: syzbot <syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    245c8e81741b Merge tag 'sched-urgent-2024-04-28' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13442937180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6116da4b97be0ef9
dashboard link: https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-245c8e81.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d0aae04fb14/vmlinux-245c8e81.xz
kernel image: https://storage.googleapis.com/syzbot-assets/352fcab192b7/bzImage-245c8e81.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com

read_mapping_page failed!
diRead: read_metapage failed
jfs_lookup: iget failed on inum 32
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00370-g245c8e81741b #0 Not tainted
------------------------------------------------------
syz-executor.1/7334 is trying to acquire lock:
ffff888065ad4078 (&hdev->lock){+.+.}-{3:3}, at: mgmt_remove_adv_monitor_complete+0x9e/0x2e0 net/bluetooth/mgmt.c:5438

but task is already holding lock:
ffff888065ad4970 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}, at: hci_cmd_sync_clear+0x4a/0x100 net/bluetooth/hci_sync.c:591

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       hci_cmd_sync_lookup_entry net/bluetooth/hci_sync.c:733 [inline]
       hci_cmd_sync_queue_once net/bluetooth/hci_sync.c:715 [inline]
       hci_update_passive_scan+0x206/0x380 net/bluetooth/hci_sync.c:3085
       le_conn_complete_evt+0x1d2/0x1de0 net/bluetooth/hci_event.c:5911
       hci_le_conn_complete_evt+0x23c/0x370 net/bluetooth/hci_event.c:5922
       hci_le_meta_evt+0x2e2/0x5d0 net/bluetooth/hci_event.c:7231
       hci_event_func net/bluetooth/hci_event.c:7542 [inline]
       hci_event_packet+0x664/0x1190 net/bluetooth/hci_event.c:7597
       hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4171
       process_one_work+0x902/0x1a30 kernel/workqueue.c:3254
       process_scheduled_works kernel/workqueue.c:3335 [inline]
       worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&hdev->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       mgmt_remove_adv_monitor_complete+0x9e/0x2e0 net/bluetooth/mgmt.c:5438
       _hci_cmd_sync_cancel_entry.constprop.0+0x6c/0x1d0 net/bluetooth/hci_sync.c:578
       hci_cmd_sync_clear+0xac/0x100 net/bluetooth/hci_sync.c:593
       hci_unregister_dev+0x188/0x600 net/bluetooth/hci_core.c:2767
       vhci_release+0x7f/0x100 drivers/bluetooth/hci_vhci.c:674
       __fput+0x270/0xb80 fs/file_table.c:422
       task_work_run+0x14e/0x250 kernel/task_work.c:180
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xa7d/0x2c10 kernel/exit.c:878
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
       __do_sys_exit_group kernel/exit.c:1038 [inline]
       __se_sys_exit_group kernel/exit.c:1036 [inline]
       __ia32_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->cmd_sync_work_lock);
                               lock(&hdev->lock);
                               lock(&hdev->cmd_sync_work_lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

1 lock held by syz-executor.1/7334:
 #0: ffff888065ad4970 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}, at: hci_cmd_sync_clear+0x4a/0x100 net/bluetooth/hci_sync.c:591

stack backtrace:
CPU: 2 PID: 7334 Comm: syz-executor.1 Not tainted 6.9.0-rc5-syzkaller-00370-g245c8e81741b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 mgmt_remove_adv_monitor_complete+0x9e/0x2e0 net/bluetooth/mgmt.c:5438
 _hci_cmd_sync_cancel_entry.constprop.0+0x6c/0x1d0 net/bluetooth/hci_sync.c:578
 hci_cmd_sync_clear+0xac/0x100 net/bluetooth/hci_sync.c:593
 hci_unregister_dev+0x188/0x600 net/bluetooth/hci_core.c:2767
 vhci_release+0x7f/0x100 drivers/bluetooth/hci_vhci.c:674
 __fput+0x270/0xb80 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa7d/0x2c10 kernel/exit.c:878
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __ia32_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72e7579
Code: Unable to access opcode bytes at 0xf72e754f.
RSP: 002b:00000000ffa973cc EFLAGS: 00000282 ORIG_RAX: 00000000000000fc
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000ffa974d0
RDX: 00000000f73130c7 RSI: 0000000000000000 RDI: 00000000f738e1b5
RBP: 00000000ffa97428 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
metapage_write_end_io: I/O error
metapage_write_end_io: I/O error
metapage_write_end_io: I/O error
metapage_write_end_io: I/O error
metapage_write_end_io: I/O error
lbmIODone: I/O error in JFS log
lbmIODone: I/O error in JFS log
lbmIODone: I/O error in JFS log
lmLogShutdown: exit(-5)
jfs_umount failed with return code -5


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

