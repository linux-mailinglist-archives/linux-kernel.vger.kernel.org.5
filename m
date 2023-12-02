Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E58019B7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 02:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjLBBrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 20:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBBrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 20:47:01 -0500
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3918DF1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 17:47:07 -0800 (PST)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-58dc5e3cd7bso2679948eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 17:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701481626; x=1702086426;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLhzqGaovRDvDL77BzF0/54MAKaKUR3SGuvOXUj05zE=;
        b=tUMSru6zSaC2k5qvOr1MlX/MFuJrsf9GdsbmyXiEdCqZztnfKO4Hy34IJt5ssAD49S
         XytGixcw9XMPkZ0bEYEMUk+hfZvNr2dYSYKPPqoo/sizjS1hosz2GsfIugsORj4miPs2
         91vY6mGc6iuP6f1O/L7GjZqZ86Gc/bWUbVz1jgyUsTLWPCxRw9aV9gzT59dPJbU1Bbt3
         a1ieGYuRoD+Zb0HcgGoOLgKFCrPbiErKYU7Ib7jAYH4zsnuzvOF9xfLkBlyqPcTUQ/MF
         CsXNfrRAOOAmJlfekUITnEU+9rhnZkaXYk3JTdkScrzePtmIqB7q6bPKDt3uSiZmLJwY
         /1Bw==
X-Gm-Message-State: AOJu0YxQCOY155I4dsMib717CmGgki46kuBekeeLhWlHYa71L6p6AIXl
        n7QS03cXmnA+h7sGoUxkEqoWd9jp2tseX/1ky4Arjl8hdy+D
X-Google-Smtp-Source: AGHT+IH1xnhOtPQh8tz+W52dJU8zeCq49S7XtEOucZAl+LOR4cPKyrwvSwCRVEOjTqQUcTAn3A0RQU/KkZSxuP+OmKtFraj8/OG7
MIME-Version: 1.0
X-Received: by 2002:a54:4784:0:b0:3b8:3fdb:ccae with SMTP id
 o4-20020a544784000000b003b83fdbccaemr231163oic.2.1701481626616; Fri, 01 Dec
 2023 17:47:06 -0800 (PST)
Date:   Fri, 01 Dec 2023 17:47:06 -0800
In-Reply-To: <tencent_2C6C333F9ED41B104B521B6E25D8BA6BBB08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2489f060b7d0f5a@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
From:   syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in relay_open

INFO: task syz-executor.0:6090 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28464 pid:6090  tgid:6089  ppid:6031   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 relay_open+0x38f/0xab0 kernel/relay.c:515
 do_blk_trace_setup+0x4c1/0xaf0 kernel/trace/blktrace.c:592
 __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:633
 blk_trace_ioctl+0x163/0x290 kernel/trace/blktrace.c:743
 blkdev_ioctl+0x111/0x770 block/ioctl.c:622
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7efdb9e7cae9
RSP: 002b:00007efdbac5e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007efdb9f9bf80 RCX: 00007efdb9e7cae9
RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 00007efdb9ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efdb9f9bf80 R15: 00007fff425d3c28
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
 #0: ffff888013074d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc900000d7d80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
 #2: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:277
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
3 locks held by kworker/u4:3/48:
 #0: ffff8880b983c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
 #1: ffff8880b9828888 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
 #2: ffff88802eb58768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5870 [inline]
 #2: ffff88802eb58768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_wiphy_work+0x2b/0x330 net/wireless/core.c:422
3 locks held by kworker/1:2/55:
 #0: ffff888013074d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffff8880b9928888 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
 #2: ffffffff8da73fd8 (pool_rwlock){----}-{2:2}, at: stack_depot_save_flags+0x169/0x740 lib/stackdepot.c:508
3 locks held by kworker/u4:4/59:
2 locks held by kworker/1:3/924:
 #0: ffff888013076938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc900052b7d80 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
2 locks held by getty/4816:
 #0: ffff88802b3f20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015d02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
3 locks held by kworker/0:4/5077:
 #0: ffff88814c053938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc9000488fd80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
 #2: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4137
2 locks held by kworker/0:5/5078:
1 lock held by syz-executor.0/5959:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: do_blk_trace_setup+0x4eb/0xaf0 kernel/trace/blktrace.c:594
1 lock held by syz-executor.1/5971:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: do_blk_trace_setup+0x4eb/0xaf0 kernel/trace/blktrace.c:594
1 lock held by syz-executor.4/5991:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: do_blk_trace_setup+0x4eb/0xaf0 kernel/trace/blktrace.c:594
1 lock held by syz-executor.2/6004:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: do_blk_trace_setup+0x4eb/0xaf0 kernel/trace/blktrace.c:594
1 lock held by syz-executor.3/6038:
1 lock held by syz-executor.0/6090:
 #0: ffffffff8d01c1e8 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x38f/0xab0 kernel/relay.c:515
1 lock held by syz-executor.1/6094:
 #0: ffffffff8d01c1e8 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x38f/0xab0 kernel/relay.c:515
1 lock held by syz-executor.4/6123:
 #0: ffffffff8d01c1e8 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x38f/0xab0 kernel/relay.c:515
1 lock held by syz-executor.2/6126:
 #0: ffffffff8d01c1e8 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x38f/0xab0 kernel/relay.c:515
1 lock held by syz-executor.5/6129:
 #0: ffffffff8d01c1e8 (relay_channels_mutex){+.+.}-{3:3}, at: relay_open+0x38f/0xab0 kernel/relay.c:515
2 locks held by syz-executor.3/6151:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
 #1: ffffffff8d01c1e8 (relay_channels_mutex){+.+.}-{3:3}, at: relay_close kernel/relay.c:760 [inline]
 #1: ffffffff8d01c1e8 (relay_channels_mutex){+.+.}-{3:3}, at: relay_close+0x36/0x5d0 kernel/relay.c:752
1 lock held by syz-executor.0/6174:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.0/6175:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.1/6184:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.1/6185:
 #0: ffff888143343340
 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.4/6225:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.4/6226:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.2/6241:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.2/6243:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.5/6245:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.5/6246:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.3/6268:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.3/6269:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.0/6299:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.0/6300:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.1/6307:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.1/6308:
 #0: ffff888143343340 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:738
1 lock held by syz-executor.4/6310:
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6555
8 locks held by syz-executor.2/6323:
 #0: ffff88807d52c420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12f/0x250 fs/read_write.c:637
 #1: ffff8881bf4f1c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27d/0x500 fs/kernfs/file.c:325
 #2: ffff888144379e88 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a0/0x500 fs/kernfs/file.c:326
 #3: ffffffff8e145528 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
 #4: ffff88806460a0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
 #4: ffff88806460a0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88806460a0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffff88806460b250 (&devlink->lock_key#24){+.+.}-{3:3}, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x39/0x190 drivers/net/netdevsim/netdev.c:411
 #7: ffffffff8cfb8938 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:293 [inline]
 #7: ffffffff8cfb8938 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x6b1/0x800 kernel/rcu/tree_exp.h:996
1 lock held by syz-executor.5/6341:
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6555

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf86/0x1210 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 59 Comm: kworker/u4:4 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:validate_chain kernel/locking/lockdep.c:3835 [inline]
RIP: 0010:__lock_acquire+0xcf1/0x3b10 kernel/locking/lockdep.c:5136
Code: 31 d1 89 ca 29 ce 01 c8 c1 c2 04 89 c0 31 f2 48 c1 e2 20 48 09 c2 48 b8 00 00 00 00 00 fc ff df 48 89 54 24 08 48 8b 54 24 40 <48> c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e dc 29 00 00 41 8b
RSP: 0018:ffffc900015a7968 EFLAGS: 00000082
RAX: dffffc0000000000 RBX: 0000000066e96c45 RCX: 000000001a14bb59
RDX: ffff888018e86470 RSI: 000000004cd4b0ec RDI: ffffffff91f26720
RBP: ffffffff91f7bf20 R08: 0000000000000000 R09: fffffbfff23e49e8
R10: ffffffff91f24f47 R11: 0000000000000002 R12: 0000000000004018
R13: 0000000000000018 R14: ffff888018e86450 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffa7f3c6866 CR3: 000000008768f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 rcu_read_lock include/linux/rcupdate.h:747 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x16e/0x10e0 net/batman-adv/network-coding.c:719
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         8c9660f6 Add linux-next specific files for 20231124
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156484e2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6eff11e3e3c25a4f
dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ca43aae80000

