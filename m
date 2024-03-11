Return-Path: <linux-kernel+bounces-98959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0620987819D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D5728A429
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE52A2C68A;
	Mon, 11 Mar 2024 14:28:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF23FE28
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167313; cv=none; b=cv1T7zm1M9VdhNLTrE7kU7OFf5SV5NHJ65tqmz8M5CScdQzKcJIf4VDpSav5mhd945FxEu09W9Kafsc/ckEnetPgRV1IOtnYmggwG0u5Xav/lN9mBXBDHSScAEfeWm+fIoohSl5rk1z2TvOnTDRxxY9I24YkyZLpZHO8bNOGHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167313; c=relaxed/simple;
	bh=u3xgcg5vMS+GWQF8joWVSVPj0ArKx3mNng2pMz4X5/o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dvcSncjigBufCoxW21Jb1slnty2cASaBB8OgNy/TzNYemZ7hca/2BhOI9yX6gTcFZMTVau0oI2wjM6enhv/xHN5HD1l5d6+GbZr2WqIHw8IDnY1kIEF5pHJen00+fW3DhVAsAu1kEjGh8zKaOjQY3ovQdsuUtIab6tamwPX3DsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bc32b2226aso475794239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167311; x=1710772111;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otpyQD2PGNyjaN7oKV6ZdeT7sdo7A7EKKdn/KmDT/ew=;
        b=PlcjpkuSTHEDBD+DVcwYULam3FR1IZHomFUuNFf1uIz1OJ9ovcdEF8s9YoVWhytFlW
         eiRLs5YWnbf95hrDGOrCIiyuX9KPRvw3yxKVthjNkuTj05e8B0zfyiB+IoZ0kSqj4D1w
         eymwMnzV/bsqlNSWfDE919AVTGCQnQd5A4zzsGdhIyqLrt3yd97iff26Vv6/1dKu+nQo
         yQcSKV3+RDgdeUVmhp4PZr+e+9xQh1GQnVH7D86+Jd/QLMCYVtACIQvLU1nkTeYpbaB4
         zNT2Vh/VvwL+YSsmsCBMuN1wCoi7ws/Sef8lqYC/XbqIPhswSCxZUO8h4SI7K7c6vXtP
         LWIg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Cj/AThs9R1dlkH9zRsdrZlfPxPKxf1TTUGSIMrDBFcYben0Ix2H+YEc/5Fz3YT1OXYW/OovJUa7eItxchoftdXnAHn/PxyEtC1Kr
X-Gm-Message-State: AOJu0YxJUO9TEfp+7XVJcwJauxRk7Gjq6x/ANFLpbIz05wyCgg8cSeBA
	ESZ3Sty3zV5VyYz7Sycun0cktJ+QXwFfd2vXjtffukx3NlMcr8ECa3RFd+BxY6OYkfrMmR2cXk8
	p0GLied/x2W9jOmMUnr3q2Lp9ryUxfdrNyB6jlalneRYpUlVMgM4m5co=
X-Google-Smtp-Source: AGHT+IG4n8tj0f9lXUWqJS/Bk8nsI2GC+Gk3aT7ssMTZUtLlZWSnSvWqx1w4/tnFuxqwnXkLo5mVQMUQOwbdaKz3dAZpUFgLFlIt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f81:b0:7c8:4874:5eec with SMTP id
 fb1-20020a0566023f8100b007c848745eecmr168320iob.0.1710167311172; Mon, 11 Mar
 2024 07:28:31 -0700 (PDT)
Date: Mon, 11 Mar 2024 07:28:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016d7240613635b86@google.com>
Subject: [syzbot] [wireless?] BUG: soft lockup in mac80211_hwsim_beacon (2)
From: syzbot <syzbot+7e51ea277ea81fe6935d@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    afe0cbf23373 mm: Introduce vmap_page_range() to map pages ..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1014c63e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92e06b597766606e
dashboard link: https://syzkaller.appspot.com/bug?extid=7e51ea277ea81fe6935d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03e310611053/disk-afe0cbf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebf9a3ff28a5/vmlinux-afe0cbf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4747941c346/bzImage-afe0cbf2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e51ea277ea81fe6935d@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 143s! [syz-executor.0:27055]
Modules linked in:
irq event stamp: 19856771
hardirqs last  enabled at (19856770): [<ffffffff8b6bbe43>] irqentry_exit+0x63/0x90 kernel/entry/common.c:351
hardirqs last disabled at (19856771): [<ffffffff8b6b9ade>] sysvec_apic_timer_interrupt+0xe/0xb0 arch/x86/kernel/apic/apic.c:1076
softirqs last  enabled at (19856234): [<ffffffff81592661>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last  enabled at (19856234): [<ffffffff81592661>] __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
softirqs last disabled at (19856237): [<ffffffff81592661>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last disabled at (19856237): [<ffffffff81592661>] __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
CPU: 0 PID: 27055 Comm: syz-executor.0 Not tainted 6.8.0-rc6-syzkaller-gafe0cbf23373 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:unwind_next_frame+0x78c/0x29e0 arch/x86/kernel/unwind_orc.c:512
Code: 0f b6 04 28 84 c0 0f 85 2b 1a 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 4d 89 f7 0f 85 38 1a 00 00 0f b7 5d 00 c1 eb 0b <80> e3 01 48 8b 44 24 78 42 0f b6 04 28 84 c0 4c 8b 74 24 48 0f 85
RSP: 0018:ffffc90000007268 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888022cf9dc0
RDX: ffffc90000007375 RSI: ffffffff8dfa0160 RDI: 0000000000000002
RBP: ffffffff90827e78 R08: 0000000000000003 R09: ffffffff81405417
R10: 0000000000000002 R11: ffff888022cf9dc0 R12: ffffffff8fe836bc
R13: dffffc0000000000 R14: 1ffff92000000e68 R15: 1ffff92000000e68
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f295c0d56c6 CR3: 0000000041be4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 arch_stack_walk+0x150/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x117/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_node+0x18f/0x380 mm/slub.c:3903
 kmalloc_reserve+0x8a/0x260 net/core/skbuff.c:578
 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:669
 skb_copy+0xef/0x770 net/core/skbuff.c:2131
 mac80211_hwsim_tx_frame_no_nl+0x1068/0x18d0 drivers/net/wireless/virtual/mac80211_hwsim.c:1854
 mac80211_hwsim_tx_frame+0x1cc/0x220 drivers/net/wireless/virtual/mac80211_hwsim.c:2200
 mac80211_hwsim_beacon_tx+0x3be/0x7e0 drivers/net/wireless/virtual/mac80211_hwsim.c:2300
 __iterate_interfaces+0x223/0x4c0 net/mac80211/util.c:772
 ieee80211_iterate_active_interfaces_atomic+0xd8/0x170 net/mac80211/util.c:808
 mac80211_hwsim_beacon+0xd4/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2326
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x594/0xd00 kernel/time/hrtimer.c:1753
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1770
 __do_softirq+0x2bb/0x942 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
 sysvec_irq_work+0x94/0xb0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:preempt_schedule_irq+0xf6/0x1c0 kernel/sched/core.c:7047
Code: 89 f5 49 c1 ed 03 eb 0d 48 f7 03 08 00 00 00 0f 84 8a 00 00 00 bf 01 00 00 00 e8 45 68 ef f5 e8 20 b8 25 f6 fb bf 01 00 00 00 <e8> 85 ae ff ff 43 80 7c 3d 00 00 74 08 4c 89 f7 e8 e5 87 81 f6 48
RSP: 0018:ffffc900132674c0 EFLAGS: 00000282
RAX: aac9d4750a501f00 RBX: 1ffff9200264cea0 RCX: ffffffff8171895a
RDX: dffffc0000000000 RSI: ffffffff8baab660 RDI: 0000000000000001
RBP: ffffc90013267570 R08: ffffffff92ca8457 R09: 1ffffffff259508a
R10: dffffc0000000000 R11: fffffbfff259508b R12: 1ffff9200264ce98
R13: 1ffff9200264ce9c R14: ffffc900132674e0 R15: dffffc0000000000
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:348
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:unmap_single_vma+0x0/0x2b0 mm/memory.c:1678
Code: 8b 3c 24 e8 a2 23 18 00 e9 77 fc ff ff e8 98 66 8d 09 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <55> 41 57 41 56 41 55 41 54 53 48 83 ec 30 44 89 4c 24 0c 4c 89 04
RSP: 0018:ffffc90013267638 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000000000000000 RSI: ffff88807cd27600 RDI: ffffc90013267840
RBP: ffffc900132677c8 R08: ffffc90013267710 R09: 0000000000000000
R10: 0000000000000002 R11: ffff888022cf9dc0 R12: 1ffff1100f9a4ec4
R13: ffff88807cd27600 R14: 0000000000000000 R15: ffff88807cd27620
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1758
 exit_mmap+0x2c6/0xd40 mm/mmap.c:3279
 __mmput+0x115/0x3c0 kernel/fork.c:1343
 exit_mm+0x21f/0x310 kernel/exit.c:569
 do_exit+0x9af/0x2740 kernel/exit.c:858
 do_group_exit+0x206/0x2c0 kernel/exit.c:1020
 get_signal+0x176d/0x1850 kernel/signal.c:2893
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc8/0x360 kernel/entry/common.c:212
 do_syscall_64+0x108/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f3ca5e7dda9
Code: Unable to access opcode bytes at 0x7f3ca5e7dd7f.
RSP: 002b:00007f3ca6bdb0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffed RBX: 00007f3ca5fabf80 RCX: 00007f3ca5e7dda9
RDX: 0000000020000040 RSI: 0000000000008923 RDI: 0000000000000004
RBP: 00007f3ca5eca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3ca5fabf80 R15: 00007fffb9292628
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 27047 Comm: syz-executor.1 Not tainted 6.8.0-rc6-syzkaller-gafe0cbf23373 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
RIP: 0010:arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
RIP: 0010:kvm_wait+0x250/0x2c0 arch/x86/kernel/kvm.c:1059
Code: 3b 45 0f b6 f6 44 89 ff 44 89 f6 e8 0a c6 53 00 e8 f5 f3 5a 00 45 38 f7 75 15 66 90 e8 79 c5 53 00 0f 00 2d a2 7b 68 0a fb f4 <e9> 50 fe ff ff e8 66 c5 53 00 fb e9 45 fe ff ff 89 d9 80 e1 07 38
RSP: 0018:ffffc900001f0660 EFLAGS: 00000246
RAX: ffffffff813fa7f7 RBX: ffffffff8ec7e200 RCX: ffff88807d793b80
RDX: 0000000000000103 RSI: ffffffff8baab660 RDI: ffffffff8bfe81a0
RBP: ffffc900001f0730 R08: ffffffff92ca848f R09: 1ffffffff2595091
R10: dffffc0000000000 R11: fffffbfff2595092 R12: 1ffff9200003e0d0
R13: dffffc0000000000 R14: 0000000000000003 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32223000 CR3: 000000007f3e6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 pv_wait arch/x86/include/asm/paravirt.h:596 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x6ff/0xc60 kernel/locking/qspinlock.c:511
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x271/0x370 kernel/locking/spinlock_debug.c:116
 spin_lock include/linux/spinlock.h:351 [inline]
 mac80211_hwsim_tx_frame_no_nl+0x97f/0x18d0 drivers/net/wireless/virtual/mac80211_hwsim.c:1805
 mac80211_hwsim_tx_frame+0x1cc/0x220 drivers/net/wireless/virtual/mac80211_hwsim.c:2200
 mac80211_hwsim_beacon_tx+0x3be/0x7e0 drivers/net/wireless/virtual/mac80211_hwsim.c:2300
 __iterate_interfaces+0x223/0x4c0 net/mac80211/util.c:772
 ieee80211_iterate_active_interfaces_atomic+0xd8/0x170 net/mac80211/util.c:808
 mac80211_hwsim_beacon+0xd4/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2326
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x594/0xd00 kernel/time/hrtimer.c:1753
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1770
 __do_softirq+0x2bb/0x942 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
 sysvec_irq_work+0x94/0xb0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:rcu_read_unlock_special+0x88/0x550 kernel/rcu/tree_plugin.h:682
Code: f1 f1 f1 00 f2 f2 f2 49 89 04 17 66 41 c7 44 17 09 f3 f3 41 c6 44 17 0b f3 65 44 8b 25 f9 19 88 7e 41 f7 c4 00 00 f0 00 74 49 <48> c7 44 24 20 0e 36 e0 45 4a c7 04 3a 00 00 00 00 66 42 c7 44 3a
RSP: 0018:ffffc900132b77e0 EFLAGS: 00000206
RAX: c8b0ea340731d000 RBX: 1ffff92002656f04 RCX: ffffffff8171895a
RDX: dffffc0000000000 RSI: ffffffff8baab660 RDI: ffffffff8bfe81a0
RBP: ffffc900132b78b0 R08: ffffffff92ca845f R09: 1ffffffff259508b
R10: dffffc0000000000 R11: fffffbfff259508c R12: 0000000000000000
R13: ffff88807d793fd8 R14: ffffc900132b7820 R15: 1ffff92002656f00
 __rcu_read_unlock+0xa0/0x110 kernel/rcu/tree_plugin.h:426
 rcu_read_unlock+0x85/0xa0 include/linux/rcupdate.h:782
 dput+0x197/0x2b0 fs/dcache.c:844
 __fput+0x678/0x8a0 fs/file_table.c:384
 task_work_run+0x24e/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa2c/0x2740 kernel/exit.c:871
 do_group_exit+0x206/0x2c0 kernel/exit.c:1020
 get_signal+0x176d/0x1850 kernel/signal.c:2893
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc8/0x360 kernel/entry/common.c:212
 do_syscall_64+0x108/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f0ffb87dda9
Code: Unable to access opcode bytes at 0x7f0ffb87dd7f.
RSP: 002b:00007f0ffc6af0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f0ffb9ac050 RCX: 00007f0ffb87dda9
RDX: 0000000020000000 RSI: 0000000000008914 RDI: 0000000000000006
RBP: 00007f0ffb8ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0ffb9ac050 R15: 00007ffdcaf26e88
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

