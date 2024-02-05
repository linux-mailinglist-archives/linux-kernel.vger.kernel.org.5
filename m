Return-Path: <linux-kernel+bounces-54099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C0084AAB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EE01C23207
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8B4BA8D;
	Mon,  5 Feb 2024 23:40:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66D4F5E6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176431; cv=none; b=e8sI0VxMWw8i5B31CzMHJbxH5MXK6E/ffTHDt/0sLVH1nxis+HlX5JACO/xwphQv7bJ+QW4iqd08PBSfKxHr/ZisbCHZjZINtLGjUvQTHmtaiTn+NU8YFxcA/znUrcOxvaPXpNH+dkuDCPe5lhQAy64qZnyPHYy3Lbb7Ceb+Ovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176431; c=relaxed/simple;
	bh=/l/BbcOUP7bWr5jYI8yoNu18RrCE0pxiWCQZSl+HmC8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rLGDKdl5J81Egx1PbknZKHfzNq9zM+GwV/m9BG1iZ/dxvEaZ6yBYI3HDH4TaNCcep6+SIzJnzE3219H9v+n+qLXFD+7R7rzeHZWQ79j2ttQUqzGO1JmfSQAHpSOl2hQWnmWcA8wRB4G4y9TU/boS533WqwdCaaHNV8UAIDrVPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc6976630so44648515ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 15:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707176428; x=1707781228;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ngrkC+Ev5kse1bjFQ2pRxP1v852GqG+2VMvhIKcpOs=;
        b=tE3HMNb34p8ft1mjNPCvv4S8+c8rima/OM6WqFbDfuBSFhnrKtJtimhnm1xSN2dAtU
         HM0TK3M2TGPAXDj3/+fF2t7MTLWiYir1punNDRykgeE39MYY78Y9ThQ19kpyUb/KrdRO
         sX00HDfTB5nrQu1Qi0/LswjyN9lPb9UjGfx3UtVhJ6Sf/f49n8l5rmpcd2qKEm/WuTcV
         tqlt1A/2/FICuHzdCNkY9WmmHcDWp7kchFZLTMjG/AEHhNZIEa/8i4uAKQ85/orY0b9f
         muvfT+cqvrH0du7RUymYV8lSHT4N+eg24E57otiSdZaIGmsRNqJ7W7rlxM3y8hHsWITa
         mx0A==
X-Gm-Message-State: AOJu0Ywz65MafeD0++Mj1B7n+MpA8e7oqkgdYOrT5Mqb6s5RJgLveZvk
	HYfKioC5WecYpqo1arrFgibv3hNjs4bPRts/pldYVUVyAp7wsZ5uIBLA5a+fuiPc7Z2KDaP+BRy
	13bhYTb4ALjujSM/S3g+QILQ/rwH9DZ4pyBYmIXSauXMrp/Q+8T14RDA=
X-Google-Smtp-Source: AGHT+IFEPa59otgEiS/TUoOMi9OMKmjSD0/Jbb+a85mDrxwfB6enbNsW0h2YRNaVdnPOxr/obL1YCHDE2GtJ77CNHM3Iol/0TImu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221d:b0:363:819c:926d with SMTP id
 j29-20020a056e02221d00b00363819c926dmr80890ilf.1.1707176428457; Mon, 05 Feb
 2024 15:40:28 -0800 (PST)
Date: Mon, 05 Feb 2024 15:40:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009655270610aafce1@google.com>
Subject: [syzbot] [netfilter?] WARNING: suspicious RCU usage in hash_netportnet6_destroy
From: syzbot <syzbot+bcd44ebc3cd2db18f26c@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    021533194476 Kconfig: Disable -Wstringop-overflow for GCC ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=144caa38180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f204e0b6490f4419
dashboard link: https://syzkaller.appspot.com/bug?extid=bcd44ebc3cd2db18f26c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16329057e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b8fe7be80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0fcac44f7d25/disk-02153319.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec3e3d0e222c/vmlinux-02153319.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11bfd95eb918/bzImage-02153319.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bcd44ebc3cd2db18f26c@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.8.0-rc2-syzkaller-00199-g021533194476 #0 Not tainted
-----------------------------
net/netfilter/ipset/ip_set_hash_gen.h:455 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by swapper/0/0:
 #0: ffffffff8e130ba0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130ba0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2184 [inline]
 #0: ffffffff8e130ba0 (rcu_callback){....}-{0:0}, at: rcu_core+0xcfc/0x1810 kernel/rcu/tree.c:2465

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-syzkaller-00199-g021533194476 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x220/0x340 kernel/locking/lockdep.c:6712
 hash_netportnet6_destroy+0xf0/0x2c0 net/netfilter/ipset/ip_set_hash_gen.h:455
 ip_set_destroy_set net/netfilter/ipset/ip_set_core.c:1180 [inline]
 ip_set_destroy_set_rcu+0x6a/0xe0 net/netfilter/ipset/ip_set_core.c:1190
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0xd76/0x1810 kernel/rcu/tree.c:2465
 __do_softirq+0x2bb/0x942 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x97/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x20/0x30 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 90 65 48 8b 05 58 ea a5 74 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d c6 5c a9 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffffff8de07ca8 EFLAGS: 00000246
RAX: ffffffff8de94680 RBX: ffff88801628e864 RCX: 00000000000148c9
RDX: 0000000000000001 RSI: ffff88801628e800 RDI: ffff88801628e864
RBP: 0000000000038f78 R08: ffff8880b9436d8b R09: 1ffff11017286db1
R10: dffffc0000000000 R11: ffffffff8b5dd030 R12: ffff888015b47000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8e885a20
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x118/0x490 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:134 [inline]
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x374/0x5d0 kernel/sched/idle.c:312
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	65 48 8b 05 58 ea a5 	mov    %gs:0x74a5ea58(%rip),%rax        # 0x74a5ea6a
  11:	74
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d c6 5c a9 00 	verw   0xa95cc6(%rip)        # 0xa95cea
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  37:	00 00 00
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

