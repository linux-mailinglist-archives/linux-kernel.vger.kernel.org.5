Return-Path: <linux-kernel+bounces-164301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C6A8B7C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC061F217AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4C9172BC6;
	Tue, 30 Apr 2024 15:47:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9C143732
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492026; cv=none; b=LkauvdIvLPwnCyTFCnj2zg9tXU1QRMLUo+apJHC6ZiQki9pP1R9b+AUOe5/pO/CgkFV1i8BWknMOZ5c5XynZ0DUuJ5MngPFNHSaKr6i/49TNCI1JjSqiK21DYwKAcMjs+IA3jl5ST1tXvGOYr4APsjjOxuMNo1bMZr7yipcAZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492026; c=relaxed/simple;
	bh=XuAyWCNzrWVUDBQb5JyFaNuIBZZyBDeiZryQ7ye9dK8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FczyPwqdSWwyYk1479O69+fXq0lrF5hrk45yj5XBeAJj03Rm+b/FmteRojFsCsK1EWfYpsCoom0/cKfs3yN6vRP1YTXh/43nHPW6mH7RWZOOVAvqolYgap9JuTwfGtbal4OLssUDycu3r4Q4Q6HyfkVDTW5MUTa8JRJ1fikkJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so653483439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714492024; x=1715096824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrJDsfrq50JhaPKYGnvODYo1QU/9tw4Decq2Ql4XEQ8=;
        b=vmC232ou7ArS2sXOqYPZzP/FgA9jvl9QxIcYC9fnep7jlwOCyy43WxPYrFrmwMUjzw
         MyyqvHoI5O3f3xs4/UqS3vnefXtpI6g4POzbGHoA3U0mnwDn6oIdL1BfQ3EMNZPwcjjS
         jjJRBNoUizdmLTrC7MQIDiw/2FSMuM3Wd3wGdCJQIpLeljkCBee7qvX9HJNNbGLIDffV
         IUa1U1BArUWoa8sm+RiOPQUmQnW7L+BMT1IFKfQCiJrE56JqYCPeo5g3h979bflAY2t6
         Lml9p97622UJXa4/CuZSdLjNhIhEhwiG/8eRVLWNOxJTwsTMtvMFExuApMb9V8X8+tqa
         zD6w==
X-Forwarded-Encrypted: i=1; AJvYcCUljiY8KKDVXnvk+jtKhGvcYTtCycezwG8kjJy2C8GrQuTQyt8vcS0DEhl7FBeaH5bfx8RpE++sWCqwXgXt9LdRtjyreraeN8qgoBm7
X-Gm-Message-State: AOJu0YwH/lyIOng4Y+EV5UBKROr1b+iK+2K643AEeUJgUrzttT2EvqoG
	qXiR/j+wYhWZGyEdSTsOlvvCDO9rsjv0j45L87UXFMF5Q2OFYOy1UU8+HsS+IIzc0DgmRG6bRVW
	9w1bHsZobAeF31grK2cNj7e+GN9AiQV/wu/WNb0zEC8feNPFI5SXJQM0=
X-Google-Smtp-Source: AGHT+IECTU7BFHq1SUMR2hYlIFqmZUxsh2FJBKIZ/twDy/2/DrJX71ydj/YTB01ac3f+/HiCJjJhyUMJKjawhw5VBRGIxEJqJh1F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1614:b0:7de:e16b:4b81 with SMTP id
 x20-20020a056602161400b007dee16b4b81mr5450iow.2.1714492024542; Tue, 30 Apr
 2024 08:47:04 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:47:04 -0700
In-Reply-To: <20240430110209.4310-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017ed1c0617524835@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: suspicious RCU usage in __do_softirq

=============================
WARNING: suspicious RCU usage
6.9.0-rc5-next-20240426-syzkaller-dirty #0 Not tainted
-----------------------------
kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ksoftirqd/0/16:
 #0: ffffffff8e333b20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333b20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
 #0: ffffffff8e333b20 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid include/linux/mmzone.h:2022 [inline]
 #0: ffffffff8e333b20 (rcu_read_lock_sched){....}-{1:2}, at: __virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65

stack backtrace:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc5-next-20240426-syzkaller-dirty #0
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
Code: 2b 00 74 08 4c 89 f7 e8 aa 61 89 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc900001578e0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200002af28 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcac4c0 RDI: ffffffff8c1fc4e0
RBP: ffffc90000157a40 R08: ffffffff92f96587 R09: 1ffffffff25f2cb0
R10: dffffc0000000000 R11: fffffbfff25f2cb1 R12: 1ffff9200002af24
R13: dffffc0000000000 R14: ffffc90000157940 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
 pfn_valid include/linux/mmzone.h:2022 [inline]
 __virt_addr_valid+0x1a0/0x520 arch/x86/mm/physaddr.c:65
 kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
 __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526
 __call_rcu_common kernel/rcu/tree.c:3103 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3207
 context_switch kernel/sched/core.c:5411 [inline]
 __schedule+0x17f0/0x4a50 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 aa 61 89 00       	call   0x8961b6
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


Tested on:

commit:         bb7a2467 Add linux-next specific files for 20240426
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11b1a228980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d4837f180000


