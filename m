Return-Path: <linux-kernel+bounces-41461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798483F232
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAE81C20CA3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20120306;
	Sat, 27 Jan 2024 23:34:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDF1F93F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398476; cv=none; b=LPQs9o5Gx5zbshdRGxGtFTbPeCSizxJrkT+tYEuOo8iUTYvUQ2JfbKL7XaJyvi/WZEHuPCn+daSg8NsMp+/P84410/TnTv4LxocCN6bd6B3t5ho3RCn017Vtq9gdWQDM4L/jyUqAenyYZumPiPFb2rvuX83HqNWWMfqHfEQIRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398476; c=relaxed/simple;
	bh=7sbqOsOdDpvvuOUNSdaA2ehO6PkPRuvkoWBBpTUVmfk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QumCdRbSRSSCLIavpQt0TtvdcgSp5hm3Pv/3lu3vCXGkrw20Q7suKIqlaCJIBMKkd/ydG7cDuIFgoiUYrgrhv80TF27GNWUtth4saLvXf3CqWAh6g0lc4fsxzaCcGypoUAqW23LK+JWH4PTC8ZVJJzmOM++/5HkRQzJ+J6lXZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36279aecbb2so8073465ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706398471; x=1707003271;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQCNOmrykklYyLumEVVjuqrDyVUK+crEJnf7k0UZNBU=;
        b=jdSdq+v1dUFwlUmBulJK3R7jrEWeg3f7HaXIppUxQF9ye0yZvji2ENIqFdp089XBEo
         gGnyMh+AKK/j3CDUNjnDCmvXcfUi2lODzmG2BIdYMNYVamaXYhRlUm0pSmq39hDb6I5B
         NtMVvotJAUgbtp3806wjobnNjl1lY7/4En24eQqeNLKGJ5cAwjB5cGJKFFZ2Vmgkv9sW
         S9vyKcRMsQtHdgSuRWlftMAzYJ/rNk1Kx7MkbeRVCCiYrosdbZo4oYY4+/LmH89sgO2+
         YiAMw4LPdM2qSaLyGGEhtztkT91EW5nz8+AtPi999OMaabwN/hPocRJ6lrFCs0CQw0e/
         5krg==
X-Gm-Message-State: AOJu0Yy6izkR4PGtFxvPu/bWK+gchDQSFLuKUA4yP1jatNL5cyi+ZX+j
	KMzYevfpXqRCtjpJzEI0muMEJs0N9twrnmfY2P0mB5idKi40hufoLJ5KS+GVp7SGt95vFV+Jma7
	bGMGljEtPb3k2BvRspbb+bEZ/GvnahKLfcuKzU/NIJkFFBewcZOWCu04=
X-Google-Smtp-Source: AGHT+IEuXs/csxgZUDT681sW9abDqPR3ywzZlABcObc40mbfOZv7T5ELbHx3Mf3yluxM6GEx33qrCt2YOAoEjgSnMJNYW0NnDlp3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2c:b0:361:8d02:f37d with SMTP id
 e12-20020a056e020b2c00b003618d02f37dmr336098ilu.4.1706398471317; Sat, 27 Jan
 2024 15:34:31 -0800 (PST)
Date: Sat, 27 Jan 2024 15:34:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba736b060ff5da23@google.com>
Subject: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
From: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7ed2632ec7d7 drm/ttm: fix ttm pool initialization for no-d..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10768b3be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=a984066a63e9c1e62662
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b8c217e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116e5bbfe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86560603f270/disk-7ed2632e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/364bc921d8bf/vmlinux-7ed2632e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d78f4f3ec9b/bzImage-7ed2632e.xz

The issue was bisected to:

commit 5af1f84ed13a416297ab9ced7537f4d5ae7f329a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Aug 3 18:04:51 2023 +0000

    Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11218f6be80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13218f6be80000
console output: https://syzkaller.appspot.com/x/log.txt?x=15218f6be80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")

INFO: task kworker/u5:3:5119 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc1-syzkaller-00026-g7ed2632ec7d7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u5:3    state:D stack:27264 pid:5119  tgid:5119  ppid:2      flags:0x00004000
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x758/0xb50 net/bluetooth/hci_sync.c:5356
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2988
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task kworker/u5:5:5122 blocked for more than 146 seconds.
      Not tainted 6.8.0-rc1-syzkaller-00026-g7ed2632ec7d7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u5:5    state:D stack:27536 pid:5122  tgid:5122  ppid:2      flags:0x00004000
Workqueue: hci1 hci_cmd_sync_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x758/0xb50 net/bluetooth/hci_sync.c:5356
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2988
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task kworker/u5:8:5131 blocked for more than 148 seconds.
      Not tainted 6.8.0-rc1-syzkaller-00026-g7ed2632ec7d7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u5:8    state:D stack:27808 pid:5131  tgid:5131  ppid:2      flags:0x00004000
Workqueue: hci4 hci_cmd_sync_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x758/0xb50 net/bluetooth/hci_sync.c:5356
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2988
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:1/9:
3 locks held by kworker/1:0/23:
1 lock held by khungtaskd/29:
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by kswapd0/87:
2 locks held by kswapd1/88:
3 locks held by kworker/1:2/925:
2 locks held by syslogd/4496:
 #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffff8880b9928a08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
2 locks held by getty/4812:
 #0: ffff88802908b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031232f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
2 locks held by kworker/0:0/5077:
1 lock held by sshd/5100:
2 locks held by kworker/1:1/5116:
5 locks held by kworker/u5:3/5119:
 #0: ffff88801d8b3938 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900046efd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888021019060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888021018078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef22548 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef22548 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

