Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792C277F309
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349448AbjHQJPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349518AbjHQJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:15:27 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09C2D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:15:07 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-5659b9ae3ebso5173214a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263707; x=1692868507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJTqPyt33YHCdZmnyY+B0zFc5RAHxXXxfwM+1DfiJ8I=;
        b=E1jvOCilZRjRwTBwkW0iHpRPAx8BCQsvl7P7ih/IioqNWpbJNmsxDB74yyToAiFF6+
         w7dbfqcrqR7IMCKNgow1sIqSmk1JkeZETC9aWXQ7oc7/iFmhrL5M+9rdQMIP/HR2W6dj
         7Etc7VUngg5LToc7V5p04aR5NZFTX67Ap3wPqyPX42mtaWFP0Gnf5X5nRCP+8p1Q/z5y
         dz7EmxX2TGmhUuSEci12zG/URk7j19enIRDJFarv3Ow0Arp+Nss8cvU/UKDq0edNR5WA
         4YpZPfrxpBo0DhRiF3e4LnEKCEz8y4xU/zK2uzWehARU3zs0OAsgPs6Gm77oELu5HfwN
         oMrQ==
X-Gm-Message-State: AOJu0Yx3nPfEXFoF2BpiU7bCXk8VFfcGtaCG1MOGeQjkdNDxqHZn3Uy8
        YgeejoaDec0FuKwx8Mt3MFXX00JLxGVfBRTbm/Rb5yDJeqmm
X-Google-Smtp-Source: AGHT+IG5SfPB6AqV0l0rIQDdt/eZEnUvKDtlCt/SixOdnbEiXNIVo5KHqkUwwKsWppFfJjuOvEfYGvOICNfMXCelQCiE5xt//1Hf
MIME-Version: 1.0
X-Received: by 2002:a63:3307:0:b0:565:f8d4:bb4f with SMTP id
 z7-20020a633307000000b00565f8d4bb4fmr827736pgz.11.1692263707169; Thu, 17 Aug
 2023 02:15:07 -0700 (PDT)
Date:   Thu, 17 Aug 2023 02:15:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021dc2806031ad901@google.com>
Subject: [syzbot] [wireguard?] INFO: rcu detected stall in wg_ratelimiter_gc_entries
 (2)
From:   syzbot <syzbot+c1cc0083f159b67cb192@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com,
        jiri@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ace0ab3a4b54 Revert "vlan: Fix VLAN 0 memory leak"
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16153769a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=c1cc0083f159b67cb192
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1227599ba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17414927a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e03bf2f0ff9c/disk-ace0ab3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad6e79c01723/vmlinux-ace0ab3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/617319e5afb7/bzImage-ace0ab3a.xz

The issue was bisected to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17901617a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14501617a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10501617a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1cc0083f159b67cb192@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (10499 ticks this GP) idle=2d5c/1/0x4000000000000000 softirq=8994/8995 fqs=4737
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        0          0            0
rcu: 	cputime:    32198      20291           25   ==> 52490(ms)
rcu: 	(t=10500 jiffies g=7889 q=546 ncpus=2)
CPU: 1 PID: 5075 Comm: kworker/1:6 Not tainted 6.5.0-rc5-syzkaller-00194-gace0ab3a4b54 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events_power_efficient wg_ratelimiter_gc_entries
RIP: 0010:taprio_next_tc_txq net/sched/sch_taprio.c:771 [inline]
RIP: 0010:taprio_dequeue_tc_priority+0x2fb/0x4b0 net/sched/sch_taprio.c:801
Code: 01 00 00 48 be 00 00 00 00 00 fc ff df 48 8b 4c 24 28 48 89 c8 48 c1 e8 03 0f b6 14 30 48 89 c8 83 e0 07 83 c0 01 38 d0 7c 08 <84> d2 0f 85 da 00 00 00 48 8b 04 24 45 0f b7 75 fe 0f b6 00 38 44
RSP: 0000:ffffc900001e0d60 EFLAGS: 00000202
RAX: 0000000000000007 RBX: ffff88806f6f6394 RCX: ffff88807b860b5e
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: dffffc0000000000
RBP: 000000000000000b R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000004e R12: 0000000000000008
R13: ffff88807b860b60 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ace99f5c0 CR3: 000000006f75b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 taprio_dequeue+0x12e/0x5f0 net/sched/sch_taprio.c:868
 dequeue_skb net/sched/sch_generic.c:292 [inline]
 qdisc_restart net/sched/sch_generic.c:397 [inline]
 __qdisc_run+0x1c4/0x19d0 net/sched/sch_generic.c:415
 qdisc_run include/net/pkt_sched.h:125 [inline]
 qdisc_run include/net/pkt_sched.h:122 [inline]
 net_tx_action+0x71e/0xc80 net/core/dev.c:5049
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5729
Code: c1 05 d5 6e 9b 7e 83 f8 01 0f 85 b0 02 00 00 9c 58 f6 c4 02 0f 85 9b 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0000:ffffc90003e1fb98 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff920007c3f75 RCX: 0000000000000001
RDX: 1ffff11003f03c80 RSI: ffffffff8a6c83a0 RDI: ffffffff8ac811a0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff2309dea
R10: ffffffff9184ef57 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffffffff8d89afb8 R15: 0000000000000000
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 wg_ratelimiter_gc_entries+0xc6/0x520 drivers/net/wireguard/ratelimiter.c:63
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
