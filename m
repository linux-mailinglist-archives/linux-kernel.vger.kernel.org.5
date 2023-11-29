Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D07FCD72
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376776AbjK2DXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjK2DXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:23:07 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7341BC2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:23:10 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c203dd04a3so6715227a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228190; x=1701832990;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZyoptvVxCiQzznnPfm+uF6aP+ODFuU4ZDNXr4urBoY=;
        b=kpRi02rOGlYSY03uG/GQnNLT96CVVpOm+dYJlU4vld9HymNvL+Blnd7mZfeJpCnbJr
         h/y95osf0Qm1r0EfI5cQWAgqr4xKdqCDfT9wNrtMVCIWJWjYh63KjAdJ3UkrcVnY0f8T
         6kONWb4Qg4M8cP35aTI51GmdYp8azwh5fMOB7+6fKJlwC+QC1OOSgpK/QEY/EPzljJVk
         ICa6OJ2tQ4m2I0zFKzykZgQDmiesFlK5qrh7800c+mWfXvB5Tw1RtWxgS1XMpantyTOl
         GLdpsDPnka/zxT5yJc5KWRIgctB3kBeqRBRn6Y3srsBWyZ1X/VYA/8gAg4c9ZbT19FgP
         XYtA==
X-Gm-Message-State: AOJu0Yz3eedt2aVlYocqLEQe4xBgL4o9A0rsJ+gxCkhe0HDbxiiGldSh
        Q7FBkejy3Ic/Lq6NBwTVpCLOgva4GtAFc+ow4oouD4YrWi0V
X-Google-Smtp-Source: AGHT+IGJFOfIAM68a8NGIFUwKdmNj6f6N3sI05HIR2F0ufbk83Xu9kgXMgPFkoc0CiB8JpfPDrWnyMiG36wX7SQF0KAR3XEJSOgA
MIME-Version: 1.0
X-Received: by 2002:a63:1921:0:b0:5be:2139:5e72 with SMTP id
 z33-20020a631921000000b005be21395e72mr2902401pgl.3.1701228190222; Tue, 28 Nov
 2023 19:23:10 -0800 (PST)
Date:   Tue, 28 Nov 2023 19:23:10 -0800
In-Reply-To: <tencent_DB6F26C7B37BA362296123A96443F7759705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5d076060b420d1f@google.com>
Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in hwrng_fillfn

INFO: task hwrng:729 blocked for more than 143 seconds.
      Not tainted 6.4.0-syzkaller-01647-g6e2332e0ab53-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:hwrng           state:D stack:29760 pid:729   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xeda/0x5b60 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x990 kernel/locking/mutex.c:747
 hwrng_fillfn+0x145/0x430 drivers/char/hw_random/core.c:505
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c9996f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2c/0xe30 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c9993f0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2c/0xe30 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8c99a300 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6615
1 lock held by hwrng/729:
 #0: ffffffff8d4887a8 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x145/0x430 drivers/char/hw_random/core.c:505
2 locks held by getty/4749:
 #0: ffff8880287f3098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015b02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc5/0x1460 drivers/tty/n_tty.c:2176
1 lock held by syz-executor.0/5449:
2 locks held by syz-executor.0/5450:
1 lock held by syz-executor.0/5744:
1 lock held by syz-executor.0/5762:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.4.0-syzkaller-01647-g6e2332e0ab53-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2ac/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf29/0x11b0 kernel/hung_task.c:379
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5744 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-01647-g6e2332e0ab53-dirty #0


Tested on:

commit:         6e2332e0 Merge tag 'cgroup-for-6.5' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1271b7ece80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=102b18358d5797d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c52ab18308964d248092
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147cc8b4e80000

