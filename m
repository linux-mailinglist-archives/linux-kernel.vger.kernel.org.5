Return-Path: <linux-kernel+bounces-147819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3848A7A14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A325AB220BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AB184D;
	Wed, 17 Apr 2024 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CefCFH7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7328EBB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713316412; cv=none; b=Oc6unHDvlMYgHqvQbmHoq6V/gVOzh+Ye5oqJGNbcOWhSn96UTifA7kEh4LuQ34EckVvMdRyUYvU5eQob3yfS6rrYnNYiMA1nC2Af0LkAAHpjgavoAww19o17iukHp84adyKy9p2m412vhqE+cPcq+9qSrw5j5TuUc915UD8gBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713316412; c=relaxed/simple;
	bh=yZ0Xits+tcOOmmk5hybTZS9q0LlAgjqW6rrbkBSlLBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUMeC2DSwbWLAkzhuBPbyXTKRwDOnfRmffTwC77i/0hjzgD19jRATM8P1PwMykSrIUTg3X/vDNtp5dt+oFfYDDyUlU5ALIglPOwJ1cSRKqWq/P3qxf1k5NK760HOm2rdbFgiu86N/HbirfkDRE02T1n7spv+oqfyQoNS+CZ/6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CefCFH7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B632C113CE;
	Wed, 17 Apr 2024 01:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713316410;
	bh=yZ0Xits+tcOOmmk5hybTZS9q0LlAgjqW6rrbkBSlLBI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CefCFH7/hstaQ1oSoSjz25ihlaj4Io/lexagwmuKQDN3yUSOX2y1y0q2i0xf1G5Hm
	 zpTI2ggYAnDvWjelgybfR/g6fAYr57OYmMXCp9u2Qa4P0YkM2jyUQir5o/aCPs3dcH
	 xMBaO1CCBan5volC8lwtTgjWvmrhrCNr0SScBeaajZwhUuGkoM4DnFkg5FbNpK3mae
	 KbdKgkhjPVLg8gvFt749CbQFDoWA6CNfhbQGzgMo450nAUEeOxPhVcpAO6TOZ/hXDr
	 teZWjX6qUAFNDBGGthkuWAuXmc2IO+UaxntA/ckSnJSlyJL9jBUg6/yw8w0Dk4tmcq
	 m+vcwiAhIxumg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7946DCE0C37; Tue, 16 Apr 2024 18:13:26 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:13:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
Message-ID: <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <000000000000b24903061520f3e9@google.com>
 <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>

On Tue, Apr 16, 2024 at 04:44:54PM +0800, Z qiang wrote:
> On Tue, Apr 16, 2024 at 4:10 PM Z qiang <qiang.zhang1211@gmail.com> wrote:
> >
> > Cc: Paul
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15f64776180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=dce04ed6d1438ad69656
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f00471180000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
> > >
> > > =============================
> > > WARNING: suspicious RCU usage
> > > 6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
> > > -----------------------------
> > > kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side critical section!
> > >
> > > other info that might help us debug this:
> > >
> > >
> > > rcu_scheduler_active = 2, debug_locks = 1
> > > 1 lock held by ksoftirqd/0/16:
> > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
> > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
> > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid include/linux/mmzone.h:2019 [inline]
> > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: __virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65
> > >
> > > stack backtrace:
> > > CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > > Call Trace:
> > >  <IRQ>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > >  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
> > >  rcu_softirq_qs+0xd9/0x370 kernel/rcu/tree.c:273
> > >  __do_softirq+0x5fd/0x980 kernel/softirq.c:568

Huh.  This statement is supposed to prevent this call to __do_softirq()
from interrupt exit::

	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
	    __this_cpu_read(ksoftirqd) == current)

So was the ksoftirqd kthread interrupted at a point where it happens to
have softirq enabled?

							Thanx, Paul

> > >  invoke_softirq kernel/softirq.c:428 [inline]
> > >  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
> > >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
> > >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
> > >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
> > >  </IRQ>
> > >  <TASK>
> > >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> > > RIP: 0010:debug_lockdep_rcu_enabled+0xd/0x40 kernel/rcu/update.c:320
> > > Code: f5 90 0f 0b 90 90 90 eb c6 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d c7 0f 28 04 00 <74> 1e 83 3d 26 42 28 04 00 74 15 65 48 8b 0c 25 c0 d3 03 00 31 c0
> > > RSP: 0018:ffffc90000157a50 EFLAGS: 00000202
> > > RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 0000000000000001
> > > RDX: dffffc0000000000 RSI: ffffffff8bcae740 RDI: ffffffff8c1f7ec0
> > > RBP: dffffc0000000000 R08: ffffffff92f3a527 R09: 1ffffffff25e74a4
> > > R10: dffffc0000000000 R11: fffffbfff25e74a5 R12: 0000000029373578
> > > R13: 1ffff9200002af64 R14: ffffffff814220f3 R15: ffff88813fff90a0
> > >  rcu_read_lock_sched include/linux/rcupdate.h:934 [inline]
> > >  pfn_valid include/linux/mmzone.h:2019 [inline]
> > >  __virt_addr_valid+0x1a9/0x520 arch/x86/mm/physaddr.c:65
> > >  kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
> > >  __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526
> >
> >
> > This should be caused by the following commit:
> > d818cc76e2b4 ("kasan: Record work creation stack trace with interrupts enabled")
> >
> > Is it possible to make the rcu_softirq_qs() run only in ksoftirqd task?
> 
> use rcu_softirq_qs_periodic() in run_ksoftirqd().
> 
> >
> > Thanks
> > Zqiang
> >
> > >  __call_rcu_common kernel/rcu/tree.c:3096 [inline]
> > >  call_rcu+0x167/0xa70 kernel/rcu/tree.c:3200
> > >  context_switch kernel/sched/core.c:5412 [inline]
> > >  __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
> > >  __schedule_loop kernel/sched/core.c:6823 [inline]
> > >  schedule+0x14b/0x320 kernel/sched/core.c:6838
> > >  smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
> > >  kthread+0x2f0/0x390 kernel/kthread.c:388
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > >  </TASK>
> > > ----------------
> > > Code disassembly (best guess):
> > >    0:   f5                      cmc
> > >    1:   90                      nop
> > >    2:   0f 0b                   ud2
> > >    4:   90                      nop
> > >    5:   90                      nop
> > >    6:   90                      nop
> > >    7:   eb c6                   jmp    0xffffffcf
> > >    9:   0f 1f 40 00             nopl   0x0(%rax)
> > >    d:   90                      nop
> > >    e:   90                      nop
> > >    f:   90                      nop
> > >   10:   90                      nop
> > >   11:   90                      nop
> > >   12:   90                      nop
> > >   13:   90                      nop
> > >   14:   90                      nop
> > >   15:   90                      nop
> > >   16:   90                      nop
> > >   17:   90                      nop
> > >   18:   90                      nop
> > >   19:   90                      nop
> > >   1a:   90                      nop
> > >   1b:   90                      nop
> > >   1c:   90                      nop
> > >   1d:   f3 0f 1e fa             endbr64
> > >   21:   31 c0                   xor    %eax,%eax
> > >   23:   83 3d c7 0f 28 04 00    cmpl   $0x0,0x4280fc7(%rip)        # 0x4280ff1
> > > * 2a:   74 1e                   je     0x4a <-- trapping instruction
> > >   2c:   83 3d 26 42 28 04 00    cmpl   $0x0,0x4284226(%rip)        # 0x4284259
> > >   33:   74 15                   je     0x4a
> > >   35:   65 48 8b 0c 25 c0 d3    mov    %gs:0x3d3c0,%rcx
> > >   3c:   03 00
> > >   3e:   31 c0                   xor    %eax,%eax
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testing.
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > >

