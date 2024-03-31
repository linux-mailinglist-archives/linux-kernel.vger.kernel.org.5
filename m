Return-Path: <linux-kernel+bounces-125987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C8D892EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD0E280C33
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41F8F51;
	Sun, 31 Mar 2024 08:18:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA4AD4E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711873104; cv=none; b=MZHyK/x9uwE4pXPsGJ+q4J+FNejvWc4klmiPGSDbO/I5IZ8GFMvM8i7L/vZAiXq7kP3J8cKA/73p3FZj2ANtqKdLkCUUycs9Ndlgv2HkYh5dqY8Bik0p7jSJhna3zHzfJfNtrJVh+QcgMZ6kvo1JbI+YFAzWs7SRWVx/69WNWPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711873104; c=relaxed/simple;
	bh=XOVUURoKyIggCQ9rimZ00nvFz0KI8ok2Oq7CdnYCfow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t2pGmC003TocvUDArBpszgq2wFA4H/ZX6N62p6GdjQ/2uY+LHC6fStafSFdu60NdcJk3XMC3RSMYkUd69cVTCF91UQLhpX2H/o2u6eP6+qMeNFmUBbsa45J5Hn1yD3j7uYi41z22gEPbv9LqCybzLHF2+zseiHEcA/pKjX8woIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc0370e9b0so346891939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 01:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711873101; x=1712477901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGJDMEy/rd7OBMXhYiyV5vwAtjiV6vDRjl/qQidUVIU=;
        b=AiHp/j5NOoPVZ68FOjxuqJgK2NU/UcSmYq1jeuPPuormu0Q7Fve3pf9uP/6oIY29ny
         uAONSqQhocgCZrbsbPGtne+8PR9nP/8Ni6zEC7aAE69I6mbOeLP3DS4M4NvkHv/hhTLS
         OkF9S4htsjJ/xJgWH/B5s9S8J1zrYY0aiGLIXR9BX6be1dLYgwZO04CS2rDgC0aRtXWd
         58G3WGlnKMDy1nLOkQZ+L7uzKMY1rsM9yn6kNWOVrHrc5ZTyKeLCYIE1YA7lTkzffyo5
         uio5Eyf2p/ib7CfXpNOjwDBDPEK3Zs51Tl5f5xJEyjsrRURebg613NN/HrjeGlMbluSq
         yw7A==
X-Forwarded-Encrypted: i=1; AJvYcCUR9+m2Cdb7TO/vn/QtvruzNxls2/mKERfgs4t7HBI6uCisGBWc5+LwRCKTVYcQBX6raIzili32eTu6HceCaJmjgFdBwBjJIA9GOgzQ
X-Gm-Message-State: AOJu0Yz4t/6GIBgGktx+Dk+2BsykMxznnYXD5Z2k8HU9smIou8rKo120
	kvLpGFxlnL+oDzPSevKsmpuuBIYzWYAzSTnBJt4dJFFA2nCSMvgK7c9in5LC/gGdve7+g0YO0pu
	xjVceDcOfKIqKYcgxUGRInWGV12B3yWR6BELbOWKu9Qt17VRKC2Vusyg=
X-Google-Smtp-Source: AGHT+IFgg2Las7diznxbtwJCRuOdvM28D/xK8Cqpu3ijaYb7/KbSx53brzSdlfmraHerNDWkmYyjEpqzMI2JvOudEPrzAMlwbDuL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3002:b0:369:6006:e148 with SMTP id
 bd2-20020a056e02300200b003696006e148mr310231ilb.3.1711873101299; Sun, 31 Mar
 2024 01:18:21 -0700 (PDT)
Date: Sun, 31 Mar 2024 01:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a912a0614f08419@google.com>
Subject: [syzbot] [net?] [nfc?] INFO: task hung in nfc_urelease_event_work
From: syzbot <syzbot+e9e054e7ec32ca9f70da@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11aa81f1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=e9e054e7ec32ca9f70da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9e054e7ec32ca9f70da@syzkaller.appspotmail.com

INFO: task kworker/0:0:7 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:24312 pid:7     tgid:7     ppid:2      flags:0x00004000
Workqueue: events nfc_urelease_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task kworker/0:1:8 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:22704 pid:8     tgid:8     ppid:2      flags:0x00004000
Workqueue: events nfc_urelease_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task kworker/u8:1:11 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:1    state:D stack:21840 pid:11    tgid:11    ppid:2      flags:0x00004000
Workqueue: nfc2_nci_rx_wq nci_rx_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:990 [inline]
 nfc_targets_found+0x26f/0x590 net/nfc/core.c:778
 nci_ntf_packet+0x4431/0x4f40
 nci_rx_work+0x14c/0x2b0 net/nfc/nci/core.c:1526
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task kworker/0:2:927 blocked for more than 144 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:22128 pid:927   tgid:927   ppid:2      flags:0x00004000
Workqueue: events nfc_urelease_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task kworker/0:3:5072 blocked for more than 144 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:19728 pid:5072  tgid:5072  ppid:2      flags:0x00004000
Workqueue: events nfc_urelease_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfc_urelease_event_work+0x111/0x300 net/nfc/netlink.c:1849
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task kworker/0:8:5145 blocked for more than 144 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:8     state:D stack:20664 pid:5145  tgid:5145  ppid:2      flags:0x00004000
Workqueue: events nfc_urelease_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task syz-executor.0:7609 blocked for more than 144 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:24632 pid:7609  tgid:7609  ppid:5075   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2548
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x7d6/0x1710 kernel/workqueue.c:3994
 nci_close_device+0x193/0x610 net/nfc/nci/core.c:579
 nci_unregister_device+0x40/0x240 net/nfc/nci/core.c:1301
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:168
 __fput+0x429/0x8a0 fs/file_table.c:422
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1541
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f772b47cc9a
RSP: 002b:00007ffe43eca810 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f772b47cc9a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f772b5ad980 R08: 0000001b30620000 R09: 0000000000000046
R10: 000000008198fad7 R11: 0000000000000293 R12: 0000000000026711
R13: ffffffffffffffff R14: 00007f772b000000 R15: 00000000000263d0
 </TASK>
INFO: task syz-executor.0:7622 blocked for more than 145 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:22864 pid:7622  tgid:7609  ppid:5075   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nci_request net/nfc/nci/core.c:149 [inline]
 nci_start_poll+0xa30/0xf30 net/nfc/nci/core.c:854
 nfc_start_poll+0x190/0x300 net/nfc/core.c:225
 nfc_genl_start_poll+0x1eb/0x350 net/nfc/netlink.c:828
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f772b47dda9
RSP: 002b:00007f772c0fe0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f772b5ac050 RCX: 00007f772b47dda9
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 0000000000000005
RBP: 00007f772b4ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f772b5ac050 R15: 00007ffe43eca748
 </TASK>
INFO: task syz-executor.2:7628 blocked for more than 145 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:23504 pid:7628  tgid:7627  ppid:5087   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:33 [inline]
 genl_op_lock net/netlink/genetlink.c:58 [inline]
 genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f756ea7fa9c
RSP: 002b:00007f756f79df60 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f756f79e050 RCX: 00007f756ea7fa9c
RDX: 0000000000000020 RSI: 00007f756f79e0a0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 00007f756f79dfb4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000006
R13: 00007f756f79e008 R14: 00007f756f79e0a0 R15: 0000000000000000
 </TASK>
INFO: task syz-executor.2:7631 blocked for more than 146 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:26136 pid:7631  tgid:7627  ppid:5087   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:33 [inline]
 genl_op_lock net/netlink/genetlink.c:58 [inline]
 genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f756ea7fa9c
RSP: 002b:00007f756f77cf60 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f756f77d050 RCX: 00007f756ea7fa9c
RDX: 0000000000000020 RSI: 00007f756f77d0a0 RDI: 0000000000000009
RBP: 0000000000000000 R08: 00007f756f77cfb4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000009
R13: 00007f756f77d008 R14: 00007f756f77d0a0 R15: 0000000000000000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
3 locks held by kworker/0:0/7:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900000c7d00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900000c7d00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f698c08 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
3 locks held by kworker/0:1/8:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900000d7d00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900000d7d00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f698c08 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
3 locks held by kworker/u8:1/11:
 #0: ffff888052d01948 ((wq_completion)nfc2_nci_rx_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888052d01948 ((wq_completion)nfc2_nci_rx_wq){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90000107d00 ((work_completion)(&ndev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90000107d00 ((work_completion)(&ndev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffff88806240e100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #2: ffff88806240e100 (&dev->mutex){....}-{3:3}, at: nfc_targets_found+0x26f/0x590 net/nfc/core.c:778
1 lock held by khungtaskd/29:
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
4 locks held by kworker/u8:3/50:
7 locks held by kworker/u8:4/65:
3 locks held by kworker/0:2/927:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90003fcfd00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90003fcfd00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f698c08 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
2 locks held by getty/4814:
 #0: ffff88802a5fd0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
4 locks held by kworker/0:3/5072:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900043ffd00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900043ffd00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f698c08 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
 #3: ffff88806240e508 (&genl_data->genl_data_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0x111/0x300 net/nfc/netlink.c:1849
3 locks held by kworker/0:4/5088:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900044efd00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900044efd00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f698c08 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
3 locks held by kworker/0:8/5145:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900047d7d00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900047d7d00 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f698c08 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x300 net/nfc/netlink.c:1843
1 lock held by syz-executor.0/7609:
 #0: ffff888062408350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_close_device+0x10a/0x610 net/nfc/nci/core.c:561
5 locks held by syz-executor.0/7622:
 #0: ffffffff8f3e0130 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1216
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:58 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
 #2: ffff88806240e508 (&genl_data->genl_data_mutex){+.+.}-{3:3}, at: nfc_genl_start_poll+0x1de/0x350 net/nfc/netlink.c:826
 #3: ffff88806240e100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #3: ffff88806240e100 (&dev->mutex){....}-{3:3}, at: nfc_start_poll+0x5a/0x300 net/nfc/core.c:208
 #4: ffff888062408350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_request net/nfc/nci/core.c:149 [inline]
 #4: ffff888062408350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_start_poll+0xa30/0xf30 net/nfc/nci/core.c:854
2 locks held by syz-executor.2/7628:
 #0: ffffffff8f3e0130 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1216
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:58 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
2 locks held by syz-executor.2/7631:
 #0: ffffffff8f3e0130 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1216
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:58 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
2 locks held by syz-executor.3/7667:
 #0: ffffffff8f3e0130 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1216
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:58 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
2 locks held by syz-executor.4/7690:
 #0: ffffffff8f3e0130 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1216
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:58 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
2 locks held by syz-executor.0/7709:
 #0: ffffffff8f3e0130 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1216
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:58 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
1 lock held by syz-executor.2/7714:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
2 locks held by syz-executor.1/7727:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
 #1: ffffffff8f698c08 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_register_device+0x3c/0x320 net/nfc/core.c:1116
2 locks held by syz-executor.1/7732:
 #0: ffffffff8f3e0130 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1216
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:58 [inline]
 #1: ffffffff8f3dffe8 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
1 lock held by syz-executor.3/7738:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.4/7742:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.1/7744:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.0/7754:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.2/7756:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.3/7758:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.4/7761:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.1/7763:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.0/7768:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.2/7769:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
1 lock held by syz-executor.3/7771:
 #0: ffffffff8e8f39c8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfb0/0xff0 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 50 Comm: kworker/u8:3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__local_bh_enable_ip+0x32/0x200 kernel/softirq.c:360
Code: 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec 80 00 00 00 41 89 f7 48 89 7c 24 18 65 48 8b 04 25 28 00 00 00 48 89 44 24 60 <49> bc 00 00 00 00 00 fc ff df 48 c7 44 24 20 b3 8a b5 41 48 c7 44
RSP: 0018:ffffc90000ba7a00 EFLAGS: 00000286
RAX: fc790264794ab100 RBX: ffffffff8b384540 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff8b38434f
RBP: ffffc90000ba7ab0 R08: ffff8880219546c3 R09: 1ffff1100432a8d8
R10: dffffc0000000000 R11: ffffed100432a8d9 R12: ffff888052ddcca0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000201
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0009f3000 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x30f/0x3b0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x365/0x610 net/batman-adv/network-coding.c:722
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


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

