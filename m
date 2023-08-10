Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D867775B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjHJKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjHJKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:24:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291BE0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:24:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe58faa5cfso1055626e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691663093; x=1692267893;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ggOPVu3cwbBwwO+jCtsaTpVRAQuvwFeIFOgaVTopJpQ=;
        b=L0rsbbzO7Oqc6V89aaAziRYL/tLiU0oWV0iLW5hAW9D6MQCqShP/K74WI+kKWFklgn
         TFK9q5B0a9MSPvlhZ+IDFrRuebBrXtd4LJQ+EFfkSbtItg5WSmD+1JcxMtYPDW1M1dPs
         sP55Vlg2FsjkXCHqQPi2uYX7JqEMpRef9u+N/RhQ5mLanZk/jo0I+MXXG4YQX55AhTcB
         9nx1WNMaJrbFUfHbw5BbeTIJI5gs4krObr/GlTe/pgRbPiOUEIFOUBDoBJudvPhi64/Y
         3gwr2RCpI49keby09vnwawbJG/RahoQM+l73Smr5L0r1kHEo0ogsugfRGTMqc8shuOxk
         TNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663093; x=1692267893;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggOPVu3cwbBwwO+jCtsaTpVRAQuvwFeIFOgaVTopJpQ=;
        b=kyQAYgpBonu0AdRuhoI+/vmhx6ZPINOxqguxhN7JYZdXhjHSj+yx3AR4w9zTONu5QJ
         YZti4inWCalx1q3mdcXcUs3svWScie9gbSm7vXvGSuszyWYJH64NFS7NdgoE32HthDkn
         Gqb8uTjkrFv9uY6l9SDmGewtbJVOeghiP7WL9bzzzNkHfecB20D8P/41SV8Ur+GW5/9Z
         4PFijRZQdCXhDg6kl6KCZiXh6HwlFNywFeL5TTlWbyfCt99911g4JFGYY0FWDDCvTfov
         pMawG899TFyicektS3D7S3YjmOxAweZNcqITi2cFb2u2QS5xL2kl0XPlNWzXaxb0Kmms
         9B5A==
X-Gm-Message-State: AOJu0Yy5MrRCI/sG9NXdJnOZhLThBBNENwE+ehV3OOlO40O8fnRJig2I
        KpP0rYj/0pdXnXyk0WD5v3XOXQL1QoL9xWoV/extnaLxymswwil1
X-Google-Smtp-Source: AGHT+IElEvaQ85ptEcQVvctIe1QuCrzqOJ+BMAeVFiT5Fn5R34cWQk7tC6Es4oYX+MJZUhcXvPS0bUad6NIbOZPch68=
X-Received: by 2002:a05:6512:3e1e:b0:4f8:770f:1b08 with SMTP id
 i30-20020a0565123e1e00b004f8770f1b08mr1994798lfv.13.1691663092078; Thu, 10
 Aug 2023 03:24:52 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Thu, 10 Aug 2023 18:24:40 +0800
Message-ID: <CALcu4rbGcFBH8a6FCEF1WHrsQ1w02SDMipjWc0AoQiEjZ-iu9w@mail.gmail.com>
Subject: possible deadlock in bcm_notifier
To:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the Linux-6.5-rc3,  the following crash
was triggered.

HEAD commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef (tag: v6.5-rc3)
git tree: upstream
console output:
https://drive.google.com/file/d/1tEaBx6RNObuI8QgDCDx5ixh3kG33MkFA/view?usp=drive_link
kernel config: https://drive.google.com/file/d/1KtZg-Q0uigCETjOZh5YsEkrpJgX7-Gl3/view?usp=drive_link
C reproducer: https://drive.google.com/file/d/134QMoCqi02D5LHxlgs9lgbGLLDt4IRw_/view?usp=drive_link
Syzlang reproducer:
https://drive.google.com/file/d/1AWrQvsyPd_Q0iOcuf9vd02txHDmZgQ-p/view?usp=drive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

WARNING: possible circular locking dependency detected
6.5.0-rc3 #1 Not tainted
------------------------------------------------------
syz-executor/8956 is trying to acquire lock:
ffff88811082a130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: lock_sock
home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708 [in
ffff88811082a130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: bcm_notify
home/smyl/linux-image/linux-6.5-rc3/net/can/bcm.c:1422 [inline]
ffff88811082a130 (sk_lock-AF_CAN){+.+.}-{0:0}, at:
bcm_notifier+0x1d7/0x620
home/smyl/linux-image/linux-6.5-rc3/net/can/bcm.c:

but task is already holding lock:
ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:78 [inline]
ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x339/0xb10
home/smyl/linux-image/linux-6.5-rc3/net/core/rtne

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock_common
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/mutex.c:603
[inline]
       __mutex_lock+0x14f/0x1440
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/mutex.c:747
       raw_release+0x1bd/0x940
home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:391
       __sock_release+0xcd/0x290
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:654
       sock_close+0x18/0x20
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:1386
       __fput+0x391/0x9d0
home/smyl/linux-image/linux-6.5-rc3/fs/file_table.c:384
       task_work_run+0x153/0x230
home/smyl/linux-image/linux-6.5-rc3/kernel/task_work.c:179
       resume_user_mode_work
home/smyl/linux-image/linux-6.5-rc3/./include/linux/resume_user_mode.h:49
[inline]
       exit_to_user_mode_loop
home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:171 [inline]
       exit_to_user_mode_prepare+0x210/0x240
home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work
home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:286 [inline]
       syscall_exit_to_user_mode+0x19/0x50
home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:297
       do_syscall_64+0x42/0xb0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sk_lock-AF_CAN){+.+.}-{0:0}:
       check_prev_add
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3142
[inline]
       check_prevs_add
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3261
[inline]
       validate_chain
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3876
[inline]
       __lock_acquire+0x2ecd/0x5b90
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5144
       lock_acquire
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5761
[inline]
       lock_acquire+0x1ad/0x520
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5726
       lock_sock_nested+0x34/0xe0
home/smyl/linux-image/linux-6.5-rc3/net/core/sock.c:3492
       lock_sock
home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708 [inline]
       bcm_notify
home/smyl/linux-image/linux-6.5-rc3/net/can/bcm.c:1422 [inline]
       bcm_notifier+0x1d7/0x620
home/smyl/linux-image/linux-6.5-rc3/net/can/bcm.c:1469
       notifier_call_chain+0xaa/0x350
home/smyl/linux-image/linux-6.5-rc3/kernel/notifier.c:93
       call_netdevice_notifiers_info+0x97/0x100
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:1962
       call_netdevice_notifiers_extack
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:2000 [inline]
       call_netdevice_notifiers
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:2014 [inline]
       unregister_netdevice_many_notify+0x745/0x16e0
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:10850
       unregister_netdevice_many
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:10906 [inline]
       unregister_netdevice_queue+0x2a5/0x370
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:10786
       unregister_netdevice
home/smyl/linux-image/linux-6.5-rc3/./include/linux/netdevice.h:3112
[inline]
       vxcan_newlink+0x46f/0x5b0
home/smyl/linux-image/linux-6.5-rc3/drivers/net/can/vxcan.c:265
       rtnl_newlink_create
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:3472 [inline]
       __rtnl_newlink+0xf6f/0x1680
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:3689
       rtnl_newlink+0x64/0xa0
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:3702
       rtnetlink_rcv_msg+0x38e/0xb10
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:6424
       netlink_rcv_skb+0x139/0x3c0
home/smyl/linux-image/linux-6.5-rc3/net/netlink/af_netlink.c:2549
       netlink_unicast_kernel
home/smyl/linux-image/linux-6.5-rc3/net/netlink/af_netlink.c:1339
[inline]
       netlink_unicast+0x4a4/0x740
home/smyl/linux-image/linux-6.5-rc3/net/netlink/af_netlink.c:1365
       netlink_sendmsg+0x82e/0xcf0
home/smyl/linux-image/linux-6.5-rc3/net/netlink/af_netlink.c:1914
       sock_sendmsg_nosec
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:725 [inline]
       sock_sendmsg+0xcf/0x170
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:748
       ____sys_sendmsg+0x676/0x860
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2494
       ___sys_sendmsg+0x109/0x1a0
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2548
       __sys_sendmsg+0xe4/0x1b0
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2577
       do_syscall_x64
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
[inline]
       do_syscall_64+0x35/0xb0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(sk_lock-AF_CAN);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_CAN);

 *** DEADLOCK ***

1 lock held by syz-executor/8956:
 #0: ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:78 [inl
 #0: ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x339/0xb10
home/smyl/linux-image/linux-6.5-rc3/net/core

stack backtrace:
CPU: 1 PID: 8956 Comm: syz-executor Not tainted 6.5.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack home/smyl/linux-image/linux-6.5-rc3/lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x92/0xf0
home/smyl/linux-image/linux-6.5-rc3/lib/dump_stack.c:106
 check_noncircular+0x2ef/0x3d0
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:2195
 check_prev_add
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3142
[inline]
 check_prevs_add
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3261
[inline]
 validate_chain
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3876
[inline]
 __lock_acquire+0x2ecd/0x5b90
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5144
 lock_acquire home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5761
[inline]
 lock_acquire+0x1ad/0x520
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5726
 lock_sock_nested+0x34/0xe0
home/smyl/linux-image/linux-6.5-rc3/net/core/sock.c:3492
 lock_sock home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708
[inline]
 bcm_notify home/smyl/linux-image/linux-6.5-rc3/net/can/bcm.c:1422 [inline]
 bcm_notifier+0x1d7/0x620 home/smyl/linux-image/linux-6.5-rc3/net/can/bcm.c:1469
 notifier_call_chain+0xaa/0x350
home/smyl/linux-image/linux-6.5-rc3/kernel/notifier.c:93
 call_netdevice_notifiers_info+0x97/0x100
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:1962
 call_netdevice_notifiers_extack
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:2000 [inline]
 call_netdevice_notifiers
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:2014 [inline]
 unregister_netdevice_many_notify+0x745/0x16e0
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:10850
 unregister_netdevice_many
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:10906 [inline]
 unregister_netdevice_queue+0x2a5/0x370
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:10786
 unregister_netdevice
home/smyl/linux-image/linux-6.5-rc3/./include/linux/netdevice.h:3112
[inline]
 vxcan_newlink+0x46f/0x5b0
home/smyl/linux-image/linux-6.5-rc3/drivers/net/can/vxcan.c:265
 rtnl_newlink_create
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:3472 [inline]
 __rtnl_newlink+0xf6f/0x1680
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:3689
 rtnl_newlink+0x64/0xa0
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:3702
 rtnetlink_rcv_msg+0x38e/0xb10
home/smyl/linux-image/linux-6.5-rc3/net/core/rtnetlink.c:6424
 netlink_rcv_skb+0x139/0x3c0
home/smyl/linux-image/linux-6.5-rc3/net/netlink/af_netlink.c:2549
 netlink_unicast_kernel
home/smyl/linux-image/linux-6.5-rc3/net/netlink/af_netlink.c:1339
[inline]
 netlink_unicast+0x4a4/0x740
home/smyl/linux-image/linux-6.5-rc3/net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x82e/0xcf0
home/smyl/linux-image/linux-6.5-rc3/net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:725 [inline]
 sock_sendmsg+0xcf/0x170 home/smyl/linux-image/linux-6.5-rc3/net/socket.c:748
 ____sys_sendmsg+0x676/0x860
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2494
 ___sys_sendmsg+0x109/0x1a0
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2548
 __sys_sendmsg+0xe4/0x1b0 home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2577
 do_syscall_x64
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
[inline]
 do_syscall_64+0x35/0xb0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
RSP: 002b:00007f025946d068 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000000 RSI: 0000000020002540 RDI: 0000000000000007
RBP: 000000000059c0a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f025944d000
 </TASK>

usb 1-1: USB disconnect, device number 2
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
1-.... } 2679 jiffies s: 1401 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 9057 Comm: syz-executor Not tainted 6.5.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:arch_static_branch
home/smyl/linux-image/linux-6.5-rc3/./arch/x86/include/asm/jump_label.h:27
[inline]
RIP: 0010:static_key_false
home/smyl/linux-image/linux-6.5-rc3/./include/linux/jump_label.h:207
[inline]
RIP: 0010:native_write_msr
home/smyl/linux-image/linux-6.5-rc3/./arch/x86/include/asm/msr.h:147
[inline]
RIP: 0010:wrmsrl
home/smyl/linux-image/linux-6.5-rc3/./arch/x86/include/asm/msr.h:262
[inline]
RIP: 0010:lapic_next_deadline+0x21/0x40
home/smyl/linux-image/linux-6.5-rc3/arch/x86/kernel/apic/apic.c:494
Code: ff ff 0f 1f 80 00 00 00 00 0f ae f0 0f ae e8 0f 31 48 c1 e2 20
b9 e0 06 00 00 48 09 c2 48 8d 04 fa 48 89 c2 48 c1 ea 20
RSP: 0018:ffffc900001d8350 EFLAGS: 00000003
RAX: 0000002c8c829cf6 RBX: 0000000000000000 RCX: 00000000000006e0
RDX: 000000000000002c RSI: ffff888135c27240 RDI: 00000000000003a7
RBP: ffff888135c27240 R08: 000000164d9af712 R09: fffffbfff1a8a6e2
R10: ffffffff8d453717 R11: 0000000000000000 R12: 00000000000003a7
R13: 000000000000001a R14: ffff888135c2aaa8 R15: ffff888135c2a840
FS:  00007f025946d640(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bd8e04d420 CR3: 000000001c563000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 clockevents_program_event+0x208/0x310
home/smyl/linux-image/linux-6.5-rc3/kernel/time/clockevents.c:334
 tick_program_event+0x7b/0x100
home/smyl/linux-image/linux-6.5-rc3/kernel/time/tick-oneshot.c:44
 hrtimer_interrupt+0x34f/0x740
home/smyl/linux-image/linux-6.5-rc3/kernel/time/hrtimer.c:1827
 local_apic_timer_interrupt
home/smyl/linux-image/linux-6.5-rc3/arch/x86/kernel/apic/apic.c:1098
[inline]
 __sysvec_apic_timer_interrupt+0x146/0x430
home/smyl/linux-image/linux-6.5-rc3/arch/x86/kernel/apic/apic.c:1115
 sysvec_apic_timer_interrupt+0x40/0xc0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/kernel/apic/apic.c:1109
 asm_sysvec_apic_timer_interrupt+0x16/0x20
home/smyl/linux-image/linux-6.5-rc3/./arch/x86/include/asm/idtentry.h:645
RIP: 0010:veth_xmit+0x76f/0x950
home/smyl/linux-image/linux-6.5-rc3/drivers/net/veth.c:375
Code: 02 85 c0 0f 85 62 fe ff ff e8 8d 17 9c fc 48 8d bb 88 06 00 00
48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c
RSP: 0018:ffffc900001d8520 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff88810e15a000 RCX: 0000000000000100
RDX: 1ffff11021c2b4d1 RSI: ffffffff84dd00b3 RDI: ffff88810e15a688
RBP: ffff888135a68000 R08: 0000000000000000 R09: fffffbfff1a8a6e2
R10: ffffffff8d453717 R11: 0000000000084001 R12: ffff888106deb000
R13: ffff88810e15c000 R14: 0000000000000046 R15: 0000000000000000
 __netdev_start_xmit
home/smyl/linux-image/linux-6.5-rc3/./include/linux/netdevice.h:4910
[inline]
 netdev_start_xmit
home/smyl/linux-image/linux-6.5-rc3/./include/linux/netdevice.h:4924
[inline]
 xmit_one home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:3537 [inline]
 dev_hard_start_xmit+0x172/0x660
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:3553
 __dev_queue_xmit+0x25fb/0x33c0
home/smyl/linux-image/linux-6.5-rc3/net/core/dev.c:4203
 dev_queue_xmit
home/smyl/linux-image/linux-6.5-rc3/./include/linux/netdevice.h:3088
[inline]
 neigh_hh_output
home/smyl/linux-image/linux-6.5-rc3/./include/net/neighbour.h:528
[inline]
 neigh_output home/smyl/linux-image/linux-6.5-rc3/./include/net/neighbour.h:542
[inline]
 ip6_finish_output2+0xdfc/0x15e0
home/smyl/linux-image/linux-6.5-rc3/net/ipv6/ip6_output.c:135
 __ip6_finish_output
home/smyl/linux-image/linux-6.5-rc3/net/ipv6/ip6_output.c:196 [inline]
 ip6_finish_output+0x595/0xf80
home/smyl/linux-image/linux-6.5-rc3/net/ipv6/ip6_output.c:207
 NF_HOOK_COND home/smyl/linux-image/linux-6.5-rc3/./include/linux/netfilter.h:292
[inline]
 ip6_output+0x21e/0x770
home/smyl/linux-image/linux-6.5-rc3/net/ipv6/ip6_output.c:228
 dst_output home/smyl/linux-image/linux-6.5-rc3/./include/net/dst.h:458 [inline]
 NF_HOOK.constprop.0+0xe6/0x440
home/smyl/linux-image/linux-6.5-rc3/./include/linux/netfilter.h:303
 ndisc_send_skb+0x955/0x12d0
home/smyl/linux-image/linux-6.5-rc3/net/ipv6/ndisc.c:508
 ndisc_send_rs+0x123/0x650
home/smyl/linux-image/linux-6.5-rc3/net/ipv6/ndisc.c:718
 addrconf_rs_timer+0x350/0x740
home/smyl/linux-image/linux-6.5-rc3/net/ipv6/addrconf.c:3935
 call_timer_fn+0x17e/0x4c0
home/smyl/linux-image/linux-6.5-rc3/kernel/time/timer.c:1700
 expire_timers home/smyl/linux-image/linux-6.5-rc3/kernel/time/timer.c:1751
[inline]
 __run_timers.part.0+0x5d4/0x940
home/smyl/linux-image/linux-6.5-rc3/kernel/time/timer.c:2022
 __run_timers home/smyl/linux-image/linux-6.5-rc3/kernel/time/timer.c:2000
[inline]
 run_timer_softirq+0xa6/0x1b0
home/smyl/linux-image/linux-6.5-rc3/kernel/time/timer.c:2035
 __do_softirq+0x1d0/0x8eb
home/smyl/linux-image/linux-6.5-rc3/kernel/softirq.c:553
 invoke_softirq
home/smyl/linux-image/linux-6.5-rc3/kernel/softirq.c:427 [inline]
 __irq_exit_rcu
home/smyl/linux-image/linux-6.5-rc3/kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb3/0x120
home/smyl/linux-image/linux-6.5-rc3/kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20
home/smyl/linux-image/linux-6.5-rc3/./arch/x86/include/asm/idtentry.h:645
RIP: 0010:finish_task_switch.isra.0+0x2c8/0xc80
home/smyl/linux-image/linux-6.5-rc3/kernel/sched/core.c:5253
Code: 8b 3a 4c 89 e7 48 c7 02 00 00 00 00 ff d1 4d 85 ff 75 bf 4c 89
e7 e8 57 f8 ff ff e8 e2 13 2f 00 fb 65 48 8b 1c 25 00 a9
RSP: 0018:ffffc900038d7998 EFLAGS: 00000246
RAX: 0000000000000003 RBX: ffff88801b088000 RCX: 1ffffffff1a8ad82
RDX: 0000000000000000 RSI: ffffffff89a61020 RDI: ffffffff8150215e
RBP: ffffc900038d79e0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8d453717 R11: 0000000000000001 R12: ffff888135c3b340
R13: ffff888102418000 R14: ffff8881079e3780 R15: ffff888135c3bd80
 context_switch
home/smyl/linux-image/linux-6.5-rc3/kernel/sched/core.c:5384 [inline]
 __schedule+0xcc5/0x5870
home/smyl/linux-image/linux-6.5-rc3/kernel/sched/core.c:6710
 schedule+0xe3/0x1b0
home/smyl/linux-image/linux-6.5-rc3/kernel/sched/core.c:6786
 futex_wait_queue+0xf5/0x1e0
home/smyl/linux-image/linux-6.5-rc3/kernel/futex/waitwake.c:355
 futex_wait+0x271/0x640
home/smyl/linux-image/linux-6.5-rc3/kernel/futex/waitwake.c:656
 do_futex+0x15f/0x2b0
home/smyl/linux-image/linux-6.5-rc3/kernel/futex/syscalls.c:106
 __do_sys_futex
home/smyl/linux-image/linux-6.5-rc3/kernel/futex/syscalls.c:183
[inline]
 __se_sys_futex
home/smyl/linux-image/linux-6.5-rc3/kernel/futex/syscalls.c:164
[inline]
 __x64_sys_futex+0x19c/0x400
home/smyl/linux-image/linux-6.5-rc3/kernel/futex/syscalls.c:164
 do_syscall_x64
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
[inline]
 do_syscall_64+0x35/0xb0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
RSP: 002b:00007f025946d0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 000000000059c0a8 RCX: 000000000047959d
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000059c0a8
RBP: 000000000059c0a0 R08: 00007f025946d640 R09: 00007f025946d640
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f025944d000
 </TASK>
