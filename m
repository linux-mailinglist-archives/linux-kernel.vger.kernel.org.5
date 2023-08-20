Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25DB781C43
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 05:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHTDXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 23:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjHTDXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 23:23:07 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFC5B9E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 20:15:37 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-689345528a6so2850747b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 20:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692501337; x=1693106137;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ex98CWvf2qdprPrHIAZu18Lg9IeQtU+ny54LLUgRlqk=;
        b=EgGtdgzhvnE/KRIYaMUazt4ynArukKgXN1TaX1kbSyZ1L9YeCBYIAwk/4wBB0Hagw6
         NiyKeeFCwWW1W3SNHlDLpMgizL6YJdEC/iQYdt285pqpVvh06XLW2sGA5s/OReNtrArF
         7OQgSBqPbTUakzzl2msS587QBQ0zPDOrGvEvJPcuAv7rL3ERnc7HfktsJFSnrbpveqbk
         KkkyK433CniRc/57owFb1NPTPPA4/L7KJulB/XM9h3VKga3Xenhy6CiYgt4nOgxi/uAs
         2UKftE8DotKSce+kIf9SvxkdKugHDwYEBolTszbT84QyOU9cgxmBKxrHiogGwOBkAGyK
         FG/A==
X-Gm-Message-State: AOJu0Yzs8Cc3DvMTm4AX6/bDmLE0aHFIGIqdUugVevULJC4EI58LGm5d
        PAIZ01HEYQUqUL9kBjF6zQcvvgU8ZmRZ3oXNGnP/uFbHdvYX
X-Google-Smtp-Source: AGHT+IFOsPaXHoQMGVbNKFQTZB8xAGcxOO922vr3iaMZ1vpu0YmQu8A5tNlUcDY/egXqvnGI/MigVB36NwlIo/dkJ3/VggAQL021
MIME-Version: 1.0
X-Received: by 2002:a17:903:41d0:b0:1bb:c7c6:3462 with SMTP id
 u16-20020a17090341d000b001bbc7c63462mr1675710ple.8.1692501337246; Sat, 19 Aug
 2023 20:15:37 -0700 (PDT)
Date:   Sat, 19 Aug 2023 20:15:37 -0700
In-Reply-To: <20230820014135.2475-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd12c10603522cc4@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
From:   syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in iterate_supers

INFO: task syz-executor.2:5688 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:24584 pid:5688  ppid:5393   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 iterate_supers+0xb0/0x1e0 fs/super.c:742
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb3b1a7cae9
RSP: 002b:00007fb3b28b80c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 00007fb3b1b9bf80 RCX: 00007fb3b1a7cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 00007fb3b1ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb3b1b9bf80 R15: 00007fff6eac0208
 </TASK>
INFO: task syz-executor.4:5709 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:25840 pid:5709  ppid:5390   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_write_slowpath+0xedd/0x13a0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1aa/0x200 kernel/locking/rwsem.c:1306
 do_remount fs/namespace.c:2879 [inline]
 path_mount+0xbdd/0xfa0 fs/namespace.c:3654
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efee2a7e1ea
RSP: 002b:00007efee3842ee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007efee3842f80 RCX: 00007efee2a7e1ea
RDX: 0000000020000180 RSI: 0000000020000100 RDI: 0000000000000000
RBP: 0000000020000180 R08: 00007efee3842f80 R09: 0000000001a404ac
R10: 0000000001a404ac R11: 0000000000000246 R12: 0000000020000100
R13: 00007efee3842f40 R14: 0000000000000000 R15: 0000000020003600
 </TASK>
INFO: task syz-executor.0:5687 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:24584 pid:5687  ppid:5386   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 jfs_flush_journal+0x733/0xec0 fs/jfs/jfs_logmgr.c:1564
 jfs_sync_fs+0x80/0xa0 fs/jfs/super.c:684
 dquot_quota_sync+0xdb/0x490 fs/quota/dquot.c:704
 iterate_supers+0x12b/0x1e0 fs/super.c:744
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd84a27cae9
RSP: 002b:00007fd84afa50c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 00007fd84a39bf80 RCX: 00007fd84a27cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 00007fd84a2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd84a39bf80 R15: 00007ffd56f86288
 </TASK>
INFO: task syz-executor.5:5689 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc6-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:24584 pid:5689  ppid:5387   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 iterate_supers+0xb0/0x1e0 fs/super.c:742
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f05ae27cae9
RSP: 002b:00007f05aef3a0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 00007f05ae39bf80 RCX: 00007f05ae27cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 00007f05ae2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f05ae39bf80 R15: 00007ffed97249c8
 </TASK>
INFO: task syz-executor.1:5702 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc6-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:24584 pid:5702  ppid:5378   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 iterate_supers+0xb0/0x1e0 fs/super.c:742
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f862b87cae9
RSP: 002b:00007f862c6030c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 00007f862b99bf80 RCX: 00007f862b87cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 00007f862b8c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f862b99bf80 R15: 00007ffe1c3a7d68
 </TASK>
INFO: task syz-executor.3:5710 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc6-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:24584 pid:5710  ppid:5382   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 iterate_supers+0xb0/0x1e0 fs/super.c:742
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f626d07cae9
RSP: 002b:00007f626de8d0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 00007f626d19bf80 RCX: 00007f626d07cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 00007f626d0c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f626d19bf80 R15: 00007ffe891110e8
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d3295b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d329970 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8d3293e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by kworker/u4:2/41:
2 locks held by getty/4770:
 #0: ffff88814bd10098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015c02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
1 lock held by syz-executor.2/5688:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.4/5709:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: do_remount fs/namespace.c:2879 [inline]
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: path_mount+0xbdd/0xfa0 fs/namespace.c:3654
1 lock held by syz-executor.0/5687:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.5/5689:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.1/5702:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.3/5710:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.0/5982:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.2/6002:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.5/6005:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.1/6010:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.4/6012:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.3/6014:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.0/6048:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.2/6104:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.5/6108:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.3/6129:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.1/6131:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor.4/6135:
 #0: ffff8880694560e0 (&type->s_umount_key#64){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc6-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x187/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xec2/0xf00 kernel/hung_task.c:379
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5445 Comm: kworker/1:5 Not tainted 6.5.0-rc6-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:56 [inline]
RIP: 0010:unwind_next_frame+0x1932/0x2390 arch/x86/kernel/unwind_orc.c:665
Code: 89 f8 48 c1 e8 03 80 3c 18 00 74 05 e8 17 e6 a7 00 4c 8b 75 08 48 8d 5d 10 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 f0 e5 a7 00 4d 39 fe 0f 87 ba 00 00
RSP: 0018:ffffc90005ae7610 EFLAGS: 00000a06
RAX: 1ffff92000b5cede RBX: ffffc90005ae76f0 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: ffffc90005ae0000 RDI: ffffc90005ae76e8
RBP: ffffc90005ae76e0 R08: ffffc90005ae7850 R09: 0000000000000000
R10: ffffc90005ae7730 R11: fffff52000b5cee8 R12: 1ffffffff1e31b57
R13: 1ffff92000b5cedd R14: ffffc90005ae0000 R15: ffffc90005ae7860
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555d7f21b030 CR3: 000000002c0f7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x111/0x140 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x117/0x1c0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 kmem_cache_free+0x292/0x500 mm/slub.c:3823
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x761/0xa90 drivers/net/netdevsim/dev.c:850
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


Tested on:

commit:         2ccdd1b1 Linux 6.5-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10ba0ebba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16856a4ba80000

