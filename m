Return-Path: <linux-kernel+bounces-146379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4078A647D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E03F1C21226
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABA82864;
	Tue, 16 Apr 2024 07:05:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013F7318A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251132; cv=none; b=ZejL0lYl8Y8maDjZlnJzw1Hf95dO3f7yp+BIf2u9+835oxuWV/E7DmOYn/NPqB1Tj554BR7v2+gt2UaaGrGdDoKomidURpVHOa+il1+8/yM8oIZaALd9j0kPRMFlfbVPzBwD6bORQSEt5kszfhk660b3wlZEK+YI3wPh19ZotVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251132; c=relaxed/simple;
	bh=uJ5ZUnk7pfsb6UR46LKGzjdr6dLAEIqQ64wVK9gBB1M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tob3SWNlcsXe3j57gPPOqhYe9AJCMg5Y0vU1rm3nyyONBy8qEnXaYuzrwlo5yF8WbTlvfQlAIALe2R04VGZ9vmvLCs8r61a/RCUIXYuqra1jxztOc3TNbsc5X1yu9wg9BCyG8AGyyPIPIaqDwkkNuP970gieKZ8k1YClKGGeCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a293aaeb8so40520325ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713251126; x=1713855926;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5Ey7SxrivxDtrUFeSh/ovV2uYSaTIWLe8Gfag26aJM=;
        b=X47oOCWglF47rxBBmF7ckW2aPHHd+30gBHkEKLxf1aRX9BuNSVOCdmsbXsGhISz8t8
         04CGh9esSZGYy8Z0XmiU1svfHDlFYgky5WVyQZavyUZVd3CJ2z5H3Oq19hhP2I6aDbMl
         pUTyAs8qthkOkQFich+5xSYnlm0p2dht48gu4U59JfDxA1sa2mwLpB/it6FvLZecJCuF
         blYk6miDr4H6ZZ/fQdpeNEZNi0Q0ANfJXAkfXOaa9txzH/I8MPIn0md9uELu4ijiJAuP
         qilWjOxQjNw0jQUCm2q7NUhTpKlkPbrHuPfd0ZPCN9HySrE64Xe+xD5kZN1bnZaKazcs
         F8eQ==
X-Gm-Message-State: AOJu0Yy1NFy+hHCVQ7NDAZTG/6CKRZxPC7WDycDSQ9NW01dJ9Xuso/cA
	77NyY1q5iVS3i0s7l8jjzAPGy3z4qccTowSj0roGQZSQ+Pe/JcpCl2KTkEfZDAZ1NQlGdJl/BwG
	PtyM6JPqpJTQJyY1ItbnkQNxh+dF4FjAy2DPPveHDMfHNC+dOVhJGY+U=
X-Google-Smtp-Source: AGHT+IEaoQ+i4ET9he2l8MC4teCYVg+Uc0J5EsKJOBqmnmnkwkHZ48AcBdKh0Fvntmv5xpLbzVPG0fV8J4FRXGFCNYDOASZDXI1w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a22:b0:36a:3c40:3e29 with SMTP id
 g2-20020a056e021a2200b0036a3c403e29mr103135ile.3.1713251126512; Tue, 16 Apr
 2024 00:05:26 -0700 (PDT)
Date: Tue, 16 Apr 2024 00:05:26 -0700
In-Reply-To: <000000000000b24903061520f3e9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce9d000616315c11@google.com>
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
From: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6bd343537461 Add linux-next specific files for 20240415
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=132b923b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c247afaa437e6409
dashboard link: https://syzkaller.appspot.com/bug?extid=dce04ed6d1438ad69656
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e7ff77180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125e7767180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aaf63ca280e5/disk-6bd34353.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/353fdc5b9ee6/vmlinux-6bd34353.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25a7a362b023/bzImage-6bd34353.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.9.0-rc4-next-20240415-syzkaller #0 Not tainted
-----------------------------
kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ksoftirqd/0/16:
 #0: ffffffff8e334160
 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid include/linux/mmzone.h:2019 [inline]
 (rcu_read_lock_sched){....}-{1:2}, at: __virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65

stack backtrace:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc4-next-20240415-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 rcu_softirq_qs+0xd9/0x370 kernel/rcu/tree.c:273
 __do_softirq+0x5fd/0x980 kernel/softirq.c:568
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
Code: 2b 00 74 08 4c 89 f7 e8 8a fd 88 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90000157820 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200002af10 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcac4e0 RDI: ffffffff8c1f8ee0
RBP: ffffc90000157980 R08: ffffffff92f765a7 R09: 1ffffffff25eecb4
R10: dffffc0000000000 R11: fffffbfff25eecb5 R12: 1ffff9200002af0c
R13: dffffc0000000000 R14: ffffc90000157880 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
 pfn_valid include/linux/mmzone.h:2019 [inline]
 __virt_addr_valid+0x1a0/0x520 arch/x86/mm/physaddr.c:65
 kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
 __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526
 __call_rcu_common kernel/rcu/tree.c:3102 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3206
 context_switch kernel/sched/core.c:5412 [inline]
 __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6925
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6949
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 smpboot_thread_fn+0x65b/0xa30 kernel/smpboot.c:163
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 8a fd 88 00       	call   0x88fd96
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

