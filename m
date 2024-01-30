Return-Path: <linux-kernel+bounces-44236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE21841F33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FDC1F2167E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EF55647A;
	Tue, 30 Jan 2024 09:18:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A05914F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606290; cv=none; b=cbLFApWj4XlgRwoNxprNhZzEJO+hl+hLSmfBb9ioBfnYSa5rCTatSnInO8/WnuhsGrKsPb1i/fS4OPf4UXctLfsRjmZFcT2xAxwStuoK7GQm7SZmKKgS3k00+YpbAe9g3mDb2Y+El6ybwcRJlc7ELtfDjq4x8hrLScfRa4c5+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606290; c=relaxed/simple;
	bh=yksdEApdWHwtbFYRYAw3fm4KDprbo5WN9QSNvsY7rBA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SsVU4xcTsrvppaNEW6SWea2/vsMOF83LsR1JhDyBoYL4SSRbz0xY3eDXrR0UojeVhr0y9sXtNWqVkAKSI5ySZwIo190A2rHp7xbHiAR501Pgul4hhMo1I6mNt8tIcb91KzLaplR6/QCJCwcwwTvy1SA6hu/MwwUxjve3uF6yHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3629478945bso18738905ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606285; x=1707211085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlwKWW0i2CNZL08aW/K+gSS6XNfArMYOsRVptZ0INSc=;
        b=M1IJSGXg/K4wlkZgcilym71KM3+DDYYbhZaXLxVW0w1U+pujX/md6V2Kmxxdskd5Lh
         dssK3NqUDIXskjLByGt749ArsT+qIdQyBMZDGHIKBPDCTChyv3XsxJXDvEP2oa782rCK
         BOC3kdh58Pb5jpUyU96ZG3gQXUlrWNvBqawETPB+icEVenOjAKxy6KC7jzkn8xL14yKy
         W845f+4s4ixk0ymn/EYVHFwdrW+yKbg7ZOGXQamji9AGjr759cSlnTe1cATaRqwx6PLY
         CX3EvzkphGCDkpNX7D0NqWRYG6QvOfFDMXzUE6b9lhD90S0rUdsdQ2/dJBc+oNzMA+th
         h2Rw==
X-Gm-Message-State: AOJu0YyOmPdSk7trt7iSnkekegyB7jeYT494xNygWlR75OhDHYZ9Pl9+
	bqy+3Qh+tKyXLT79/6hTSS7xQ3gbVSPJPnUtaxRQ5IZNAmG7QU7pjrbVmygXUaaUwLotOjDUfJP
	IdWGVWDjEvs5PhV0zyfRMq0xwtfgXx9PT/Is2cg1myELMx1kd9ikvqtM=
X-Google-Smtp-Source: AGHT+IHRGToUJwe/OMLiem8vB+l3Zlk1s5MQZhUj+R9/57Dh4cU/IubDlscNqI8lSWQ/HTNXWqZWa1RYeC/z+9CCbUxR4He0OZE8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3207:b0:35f:d260:57b3 with SMTP id
 cd7-20020a056e02320700b0035fd26057b3mr812469ilb.3.1706606285783; Tue, 30 Jan
 2024 01:18:05 -0800 (PST)
Date: Tue, 30 Jan 2024 01:18:05 -0800
In-Reply-To: <tencent_C16C982E616C44951CE80EEF46CD707B820A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f88590610263d14@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
inconsistent lock state in simple_pin_fs

================================
WARNING: inconsistent lock state
6.8.0-rc2-syzkaller-g861c0981648f-dirty #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
kworker/u4:1/12 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffffff8d38c8d8 (pin_fs_lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8d38c8d8 (pin_fs_lock){+.?.}-{2:2}, at: simple_pin_fs+0x26/0x190 fs/libfs.c:978
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  simple_pin_fs+0x26/0x190 fs/libfs.c:978
  securityfs_create_dentry+0x74/0x4c0 security/inode.c:121
  securityfs_create_file security/inode.c:204 [inline]
  securityfs_init+0x9d/0x100 security/inode.c:345
  do_one_initcall+0x11c/0x650 init/main.c:1236
  do_initcall_level init/main.c:1298 [inline]
  do_initcalls init/main.c:1314 [inline]
  do_basic_setup init/main.c:1333 [inline]
  kernel_init_freeable+0x687/0xc10 init/main.c:1551
  kernel_init+0x1c/0x2a0 init/main.c:1441
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
irq event stamp: 4567394
hardirqs last  enabled at (4567394): [<ffffffff8a91ffae>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (4567394): [<ffffffff8a91ffae>] _raw_spin_unlock_irqrestore+0x4e/0x70 kernel/locking/spinlock.c:194
hardirqs last disabled at (4567393): [<ffffffff8a91fd5e>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (4567393): [<ffffffff8a91fd5e>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (4567282): [<ffffffff89e2f8fc>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (4567282): [<ffffffff89e2f8fc>] cfg80211_inform_single_bss_frame_data+0x96c/0x12c0 net/wireless/scan.c:3039
softirqs last disabled at (4567283): [<ffffffff814ff74a>] do_softirq kernel/softirq.c:454 [inline]
softirqs last disabled at (4567283): [<ffffffff814ff74a>] do_softirq+0xaa/0xe0 kernel/softirq.c:441

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(pin_fs_lock);
  <Interrupt>
    lock(pin_fs_lock);

 *** DEADLOCK ***

4 locks held by kworker/u4:1/12:
 #0: ffff888013089938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90000117d80 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff88809d6f0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5928 [inline]
 #2: ffff88809d6f0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_wiphy_work+0x2b/0x330 net/wireless/core.c:424
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2184 [inline]
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_core+0x7bd/0x1680 kernel/rcu/tree.c:2465

stack backtrace:
CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3971 [inline]
 valid_state kernel/locking/lockdep.c:4013 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
 mark_lock+0x91a/0xc50 kernel/locking/lockdep.c:4678
 mark_usage kernel/locking/lockdep.c:4567 [inline]
 __lock_acquire+0x13f6/0x3b30 kernel/locking/lockdep.c:5091
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 simple_pin_fs+0x26/0x190 fs/libfs.c:978
 debugfs_remove+0x4e/0x80 fs/debugfs/inode.c:811
 blk_trace_free_rcu kernel/trace/blktrace.c:343 [inline]
 blk_trace_rcu_free+0x57/0x150 kernel/trace/blktrace.c:403
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 do_softirq kernel/softirq.c:454 [inline]
 do_softirq+0xaa/0xe0 kernel/softirq.c:441
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xfc/0x120 kernel/softirq.c:381
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 cfg80211_inform_single_bss_frame_data+0x96c/0x12c0 net/wireless/scan.c:3039
 cfg80211_inform_bss_frame_data+0x14c/0x350 net/wireless/scan.c:3068
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1098 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1577 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1973/0x30e0 net/mac80211/ibss.c:1604
 ieee80211_iface_process_skb net/mac80211/iface.c:1589 [inline]
 ieee80211_iface_work+0xa67/0xda0 net/mac80211/iface.c:1643
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:437
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1578
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/u4:1
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10176
 down_write+0x19/0x50 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:802 [inline]
 simple_recursive_removal+0x171/0x850 fs/libfs.c:528
 debugfs_remove+0x5d/0x80 fs/debugfs/inode.c:812
 blk_trace_free_rcu kernel/trace/blktrace.c:343 [inline]
 blk_trace_rcu_free+0x57/0x150 kernel/trace/blktrace.c:403
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 do_softirq kernel/softirq.c:454 [inline]
 do_softirq+0xaa/0xe0 kernel/softirq.c:441
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xfc/0x120 kernel/softirq.c:381
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 cfg80211_inform_single_bss_frame_data+0x96c/0x12c0 net/wireless/scan.c:3039
 cfg80211_inform_bss_frame_data+0x14c/0x350 net/wireless/scan.c:3068
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1098 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1577 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1973/0x30e0 net/mac80211/ibss.c:1604
 ieee80211_iface_process_skb net/mac80211/iface.c:1589 [inline]
 ieee80211_iface_work+0xa67/0xda0 net/mac80211/iface.c:1643
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:437
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
BUG: scheduling while atomic: kworker/u4:1/12/0x00000102
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


Tested on:

commit:         861c0981 Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13751c2fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15288adfe80000


