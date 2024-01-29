Return-Path: <linux-kernel+bounces-42163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7C83FD4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ED01F24BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C63C68E;
	Mon, 29 Jan 2024 04:48:43 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B213C481
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706503723; cv=none; b=dBzU6Fvk1NIBeiUEI80DY/2W/mGzaLefeASGIIiMnqNa9GvY5gwwva8p6kT3OaABhMTzN9EhWwxpvA4Hgz8Ww2Yi73FU3sdh93vbG0XSPVbKNkkLg7+MWbJq/bS2OmWw76+RKmuLgwqsKrcVbMWoSF/9YFeZxM6mqC/suJ4CMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706503723; c=relaxed/simple;
	bh=HIBtGv4Miu5XdmHF/ZzwPC6oGGZ1r7oevZa+DA6OqNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqoNxkunrvG1OhEzPR/OTDNgZMdIqgewtHogKLJVUQV8fUToWI+i6rImHV+7A5jfTBwMCsJ09hmx7+ffblWsv7Fjz3UfGfSFIWB7tZ77kTleZ25Fw61Aut+mwTtLZHC0x47SVSsFtO/wl34Hlxcy/s+C5vBLbY94LARmuSdpskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.153])
	by sina.com (172.16.235.25) with ESMTP
	id 65B72E1E00007DF4; Mon, 29 Jan 2024 12:48:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 78843434210369
X-SMAIL-UIID: 736E54B9EAFC4C309ECFBE2DC1A80295-20240129-124833-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
Cc: eadavis@qq.com,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Date: Mon, 29 Jan 2024 12:48:24 +0800
Message-Id: <20240129044824.1218-1-hdanton@sina.com>
In-Reply-To: <0000000000001529bf060ff852b9@google.com>
References: <tencent_4A66EF6ACD6878526F542C2D6D109794E80A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jan 2024 18:31:03 -0800
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in hci_conn_failed
> 
> INFO: task kworker/u5:2:5062 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc1-syzkaller-g8a696a29c690-dirty #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u5:2    state:D stack:27840 pid:5062  tgid:5062  ppid:2      flags:0x00004000
> Workqueue: hci5 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
>  hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
>  hci_abort_conn_sync+0x7f8/0xb70 net/bluetooth/hci_sync.c:5356
>  abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2988
>  hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
>  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> 
> Showing all locks held in the system:
> 2 locks held by kworker/0:1/9:
> 2 locks held by kworker/u4:0/11:
>  #0: ffff888013089938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc90000107d80 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
> 3 locks held by kworker/1:1/27:
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
>  #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
>  #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
> 6 locks held by kworker/u5:0/51:
>  #0: ffff88802a730d38 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc90000bc7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff888020989060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
>  #3: ffff888020988078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
>  #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
>  #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
>  #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
> 3 locks held by kworker/1:2/779:
>  #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
>  #1: ffffc900038c7d80 ((work_completion)(&aux->work)#2){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff888052984c80 (&aux->poke_mutex){+.+.}-{3:3}, at: __fd_array_map_delete_elem+0x125/0x2f0 kernel/bpf/arraymap.c:884

Could locking people shed any light on the failure of detecting the
poke_mutex with rq lock held?

> 2 locks held by kworker/u4:7/2797:
> 2 locks held by kworker/u4:9/2812:
>  #0: ffff888013089938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc9000a05fd80 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
> 5 locks held by kworker/u5:1/4456:
>  #0: ffff888021b4a138 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc9000d7dfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff88806a001060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
>  #3: ffff88806a000078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
>  #4: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
>  #4: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
> 3 locks held by udevd/4512:
> 2 locks held by getty/4813:
>  #0: ffff88802e7980a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
>  #1: ffffc9000311b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
> 5 locks held by kworker/u5:2/5062:
>  #0: ffff88802271a938 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc900041cfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff888019ff1060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
>  #3: ffff888019ff0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
>  #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
> 2 locks held by kworker/0:3/5070:
> 2 locks held by kworker/1:4/5071:
>  #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
>  #1: ffff8880b9928a08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
> 3 locks held by kworker/1:5/5493:
> 3 locks held by kworker/1:6/5497:
> 3 locks held by kworker/0:6/5520:
> 2 locks held by kworker/0:8/5525:
>  #0: ffff8880b983ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
>  #1: ffff8880b9828a08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
> 1 lock held by dhcpcd/20169:
>  #0: ffff8880581ba130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
>  #0: ffff8880581ba130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2c/0xf50 net/packet/af_packet.c:3202
> 1 lock held by syz-executor.0/21114:
> 
> =============================================
> 
> 

