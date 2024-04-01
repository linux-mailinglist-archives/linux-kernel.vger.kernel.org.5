Return-Path: <linux-kernel+bounces-126706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993A893BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2612813A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4241A89;
	Mon,  1 Apr 2024 14:08:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E540BFD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980511; cv=none; b=qSLgQ39O0NEs0VlS/353haFqftEq6pNiqmCO/YMF3gbfd5ICDCudZ7rXpFDOjhARwCHe5Whuoy2E2+9MwJO72atTPDAnOdtq2H2njMhnUFQOx3b7ivdU1PBdvVr1AsqLWWPtq0zaAIRZ/EN+0Q0V3UssXUUUnZEAnKV/9xBakgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980511; c=relaxed/simple;
	bh=QE/azOG+sdCDa9i/ChxB7j8lmmuGKSYJpyCvCgdezGk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l5C0DbHkLlPGmhjtRxomjOZTfbRYoBO8dhMHpbOIgRJyw6Wm9kjtbAK+AuVE0ibUrv5cEmJS3MtQ7lhAoy/B22E+19kXvLD1hzQb3YcDh+ryWPKALzPdrrH01urmcKW1Rz4eiQPJZVo74+PZnemcH6yDzvdcOaSmIs3KAKWeJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so455047239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 07:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711980509; x=1712585309;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+RN2kaba+YcpqIdLIA1URl8bnDzjP/nh4Z/qLlrurY=;
        b=jSEzDY54tsgHodaMmryZ5OdNN0ePFm1FSX7WngIu0jckQoBKzvuqlp0l3oJh6XegkH
         sCKE347wEl1FMy4rX2V79ty4Qk4HJXagWJfINBZl61k1EblK27rFlW2tZkMNgCzq39Hq
         fynH4fmSRVH8v4VgOPrbJyd8rDyLkbofGoBi7vbr7ybCoTfNxt01qytvg5MzvpnBqxHS
         bKzUdZWxCFXoGuYjuD76ZE9LiD1Df6inLp9zjylFagSv+reaefrlAEWWIx5DjHg0BlXO
         y84xq3iPzz+5mQV0UyeoSVw7jRl4tzCiTJirihIysHkU8qz61njVqwrbAbHK3/ol7eLi
         Z6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDIdcxjFmEExqzjdQ3WnpFYtfwmntjswAXKPy6K03sZlPDjqgB08quhwSuackd4jgzWjQ3QAkaFD2X9OTNTqcXDmg4Gr1r7Uz8HtAB
X-Gm-Message-State: AOJu0YxHlUYWQIYF/Y5DE61kj3VQyOredHSt37yKmMerwiu4KJZwpRj4
	ORBK+Mq3D1lQGc9H4Q4Oa7KXrtQTBkybRs4MLhf8IKVSSSz+mTNmS3rAIUANIiRcvhFdEYp0oFe
	tMpjtnap2MkhgtRvxpXQYu7ahpbJTvJuo6MpdthHr94TAnaJpsXLcBs4=
X-Google-Smtp-Source: AGHT+IEXEW2XEdKYxr7Es5tMPmApuZiyWDb9KBttBC3s2fwSfroDnexKvV853rHkZaWFIRtnHjdLhk8H7bOQH77vwbfYXwPK7jXa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3412:b0:7cc:1357:1d1d with SMTP id
 n18-20020a056602341200b007cc13571d1dmr108199ioz.0.1711980508958; Mon, 01 Apr
 2024 07:08:28 -0700 (PDT)
Date: Mon, 01 Apr 2024 07:08:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001963d306150986f9@google.com>
Subject: [syzbot] [crypto?] inconsistent lock state in padata_do_parallel (2)
From: syzbot <syzbot+0cb5bb0f4bf9e79db3b3@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    18737353cca0 Merge tag 'edac_urgent_for_v6.9_rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d605e5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=0cb5bb0f4bf9e79db3b3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-18737353.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9d064c31921/vmlinux-18737353.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d950d42963e/bzImage-18737353.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0cb5bb0f4bf9e79db3b3@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.9.0-rc1-syzkaller-00379-g18737353cca0 #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
syz-executor.3/9760 [HC0[0]:SC1[3]:HE1:SE0] takes:
ffffffff8dcbca58 (padata_works_lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8dcbca58 (padata_works_lock){+.?.}-{2:2}, at: padata_do_parallel+0x3af/0x9e0 kernel/padata.c:213
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  padata_work_alloc_mt kernel/padata.c:109 [inline]
  padata_do_multithreaded+0x213/0xad0 kernel/padata.c:507
  gather_bootmem_prealloc mm/hugetlb.c:3478 [inline]
  hugetlb_init+0x38b/0x1150 mm/hugetlb.c:4634
  do_one_initcall+0x128/0x700 init/main.c:1238
  do_initcall_level init/main.c:1300 [inline]
  do_initcalls init/main.c:1316 [inline]
  do_basic_setup init/main.c:1335 [inline]
  kernel_init_freeable+0x69d/0xca0 init/main.c:1548
  kernel_init+0x1c/0x2b0 init/main.c:1437
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
irq event stamp: 2347422
hardirqs last  enabled at (2347422): [<ffffffff8ae18812>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (2347422): [<ffffffff8ae18812>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
hardirqs last disabled at (2347421): [<ffffffff8ae18522>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (2347421): [<ffffffff8ae18522>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (2342856): [<ffffffff8ae1b6ba>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (2342856): [<ffffffff8ae1b6ba>] __do_softirq+0x5da/0x922 kernel/softirq.c:583
softirqs last disabled at (2347407): [<ffffffff8151d6f9>] invoke_softirq kernel/softirq.c:428 [inline]
softirqs last disabled at (2347407): [<ffffffff8151d6f9>] __irq_exit_rcu kernel/softirq.c:633 [inline]
softirqs last disabled at (2347407): [<ffffffff8151d6f9>] irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(padata_works_lock);
  <Interrupt>
    lock(padata_works_lock);

 *** DEADLOCK ***

4 locks held by syz-executor.3/9760:
 #0: ffff8880234280e0 (&type->s_umount_key#110){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880234280e0 (&type->s_umount_key#110){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880234280e0 (&type->s_umount_key#110){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:504
 #1: ffffc900008f8cb0 ((&d->timer)){+.-.}-{0:0}, at: call_timer_fn+0x11a/0x610 kernel/time/timer.c:1790
 #2: ffffffff8dbb1560 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8dbb1560 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8dbb1560 (rcu_read_lock){....}-{1:2}, at: tipc_bearer_xmit_skb+0xb8/0x430 net/tipc/bearer.c:564
 #3: ffffffff8dbb1500 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #3: ffffffff8dbb1500 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:833 [inline]
 #3: ffffffff8dbb1500 (rcu_read_lock_bh){....}-{1:2}, at: padata_do_parallel+0x42/0x9e0 kernel/padata.c:183

stack backtrace:
CPU: 3 PID: 9760 Comm: syz-executor.3 Not tainted 6.9.0-rc1-syzkaller-00379-g18737353cca0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_usage_bug kernel/locking/lockdep.c:3971 [inline]
 valid_state kernel/locking/lockdep.c:4013 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
 mark_lock+0x923/0xc60 kernel/locking/lockdep.c:4678
 mark_usage kernel/locking/lockdep.c:4567 [inline]
 __lock_acquire+0x13d4/0x3b30 kernel/locking/lockdep.c:5091
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 padata_do_parallel+0x3af/0x9e0 kernel/padata.c:213
 pcrypt_aead_encrypt+0x3a3/0x4f0 crypto/pcrypt.c:117
 crypto_aead_encrypt+0xbe/0x100 crypto/aead.c:121
 tipc_aead_encrypt net/tipc/crypto.c:821 [inline]
 tipc_crypto_xmit+0xe3d/0x23e0 net/tipc/crypto.c:1756
 tipc_bearer_xmit_skb+0x160/0x430 net/tipc/bearer.c:568
 tipc_disc_timeout+0x5b3/0x850 net/tipc/discover.c:338
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1844 [inline]
 __run_timers+0x74b/0xaf0 kernel/time/timer.c:2418
 __run_timer_base kernel/time/timer.c:2429 [inline]
 __run_timer_base kernel/time/timer.c:2422 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2438
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2448
 __do_softirq+0x218/0x922 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_pc+0x33/0x60 kernel/kcov.c:207
Code: 65 76 7e 65 8b 05 25 65 76 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74 35 8b 82 14 16 00 00 85 c0 74 2b 8b 82 f0 15 00 00 <83> f8 02 75 20 48 8b 8a f8 15 00 00 8b 92 f4 15 00 00 48 8b 01 48
RSP: 0018:ffffc90003b9f5a0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff8134284f
RDX: ffff888027030000 RSI: ffffffff813427f9 RDI: 0000000000000005
RBP: ffffc90003b9f640 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffc90003b9f5b0
R13: ffffffff81793df0 R14: ffffc90003b9f670 R15: ffff888027030000
 arch_stack_walk+0xb9/0x170 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x129/0x390 mm/slub.c:4390
 kvfree+0x47/0x50 mm/util.c:680
 f2fs_destroy_node_manager+0x85a/0xc60 fs/f2fs/node.c:3408
 f2fs_put_super+0x6c8/0xf60 fs/f2fs/super.c:1658
 generic_shutdown_super+0x159/0x3d0 fs/super.c:641
 kill_block_super+0x3b/0x90 fs/super.c:1693
 kill_f2fs_super+0x2b4/0x440 fs/f2fs/super.c:4857
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x275/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xe2/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7feb5a67f0d7
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff44da0148 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007feb5a67f0d7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff44da0200
RBP: 00007fff44da0200 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff44da12c0
R13: 00007feb5a6c93b9 R14: 00000000000340c5 R15: 000000000000000d
 </TASK>
----------------
Code disassembly (best guess):
   0:	65 76 7e             	gs jbe 0x81
   3:	65 8b 05 25 65 76 7e 	mov    %gs:0x7e766525(%rip),%eax        # 0x7e76652f
   a:	a9 00 01 ff 00       	test   $0xff0100,%eax
   f:	48 8b 34 24          	mov    (%rsp),%rsi
  13:	74 0f                	je     0x24
  15:	f6 c4 01             	test   $0x1,%ah
  18:	74 35                	je     0x4f
  1a:	8b 82 14 16 00 00    	mov    0x1614(%rdx),%eax
  20:	85 c0                	test   %eax,%eax
  22:	74 2b                	je     0x4f
  24:	8b 82 f0 15 00 00    	mov    0x15f0(%rdx),%eax
* 2a:	83 f8 02             	cmp    $0x2,%eax <-- trapping instruction
  2d:	75 20                	jne    0x4f
  2f:	48 8b 8a f8 15 00 00 	mov    0x15f8(%rdx),%rcx
  36:	8b 92 f4 15 00 00    	mov    0x15f4(%rdx),%edx
  3c:	48 8b 01             	mov    (%rcx),%rax
  3f:	48                   	rex.W


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

