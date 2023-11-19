Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B497F0637
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjKSMxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:53:08 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D8B9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 04:53:04 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc0e3a2b6eso41667085ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 04:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700398384; x=1701003184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dO803xkdRj9kB06cIVGlaKZxWCXTKF1nFQmCOMJNUZo=;
        b=sPrKDAS2cmqKu9J3a6laWWZzpNSIHRBWsGnrdxPzYbZagxG2iKyqgwt5onoyzmqV7x
         gxArFzIK3of8808khX9boaiOVcd34tPbeefsj2ePyM+ZLfA6PoWrFigu/qM7WhFfo5f8
         PxhAi+uAooCJqndeA2IJA2P1rNa3y4OkR2r6ztNy31TYa1XlxJ6Wns9oBtRGKt1PSvD4
         7vdx69UsjjFOov90lmnWIczVKTVzK7lYBwDEHzfcCl8HN1agSwyQ7D9VPp9gZmxVa0bk
         678Q329yU4FiQnJwIqH34zI+F0YfYRbEtvkuNY4K4DaZVf5IzKfNARl8zZc/BsGXuZ6e
         jv6w==
X-Gm-Message-State: AOJu0Yzb8xXVn/G0N0Fo5N+fNjE7w6OFwizkBPwwhJySnOlKoDyKUmdl
        Z10XJQuVivK/K5UG5I5izWYz18EwQHxCFSXqUA9RptOLOzjlJTk=
X-Google-Smtp-Source: AGHT+IGGHHjOe+T5OHanxql16OLxL7CVngOWf/BDDj2C2iqWP318eebUtAkXYBxmJtJmRQ89vlvJQDalQkcDEVYG3NKzEFpz1AiA
MIME-Version: 1.0
X-Received: by 2002:a17:903:2684:b0:1cc:335b:c923 with SMTP id
 jf4-20020a170903268400b001cc335bc923mr1228444plb.2.1700398384058; Sun, 19 Nov
 2023 04:53:04 -0800 (PST)
Date:   Sun, 19 Nov 2023 04:53:03 -0800
In-Reply-To: <CAJjsb4of73DgmzM+FB_qWPJZ+r4Y+P-t_V+p4fwYAzyfqxe15w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a896e8060a80d978@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in user_get_super (2)
From:   syzbot <syzbot+ba09f4a317431df6cddf@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
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
INFO: task hung in user_get_super

INFO: task syz-executor.0:6844 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc1-syzkaller-00344-g037266a5f723 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:0     pid:6844  tgid:6842  ppid:6827   flags:0x00000005
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1354/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6835
 rwsem_down_read_slowpath+0x57c/0xe58 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xa0/0x2fc kernel/locking/rwsem.c:1528
 __super_lock fs/super.c:58 [inline]
 super_lock+0x160/0x328 fs/super.c:117
 user_get_super+0xe8/0x1a0 fs/super.c:1062
 quotactl_block fs/quota/quota.c:890 [inline]
 __do_sys_quotactl fs/quota/quota.c:955 [inline]
 __se_sys_quotactl fs/quota/quota.c:917 [inline]
 __arm64_sys_quotactl+0x508/0xca0 fs/quota/quota.c:917
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffff80008e6b46c0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:300
2 locks held by getty/5857:
 #0: ffff0000d2bdf0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800094e702f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2201
1 lock held by syz-executor.0/6551:
1 lock held by syz-executor.0/6844:
 #0: ffff0000da0280e0 (&type->s_umount_key#52){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000da0280e0 (&type->s_umount_key#52){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117
1 lock held by syz-executor.0/6862:
 #0: ffff0000da0280e0 (&type->s_umount_key#52){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000da0280e0 (&type->s_umount_key#52){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117
1 lock held by syz-executor.0/6888:
 #0: ffff0000da0280e0 (&type->s_umount_key#52){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000da0280e0 (&type->s_umount_key#52){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117

=============================================



Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12cbee48e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=696dc362ad4818c4
dashboard link: https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
