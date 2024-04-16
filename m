Return-Path: <linux-kernel+bounces-146477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694B88A65C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DF31F2429D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC20015689F;
	Tue, 16 Apr 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBC1rV3O"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DDC139589
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255034; cv=none; b=bO1SwXO8R2TtU9vZQlNY7hS+czkOfsP4Pe4bjumFs+QjEVwED5hN+5A+GEF8Z/zD6RGW2t5SYSMB0kGWiZgsD91CdyilJhO17qMc4Nxvj62oedTQtgKDNLZwLCGDA61FQ2u+574ttLVdjkzjAJQ5v7K8OHTAuspaChb4lEInrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255034; c=relaxed/simple;
	bh=EZdq1sI7cHqhJ6BAXENIN05kp0T0XyfRMd3wl9PIo54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeZvjn77JfbVXesczvk06CuDa5i5wljMeB/2N07r3yj+iEiH6bdnqE7u6t1LxAoQbx0H75R+UOwDKvOikz3sGFn1OLJPYPejr0WES1pqyaAMRjt1i086F0OwCMMPiRVe7K/AaySk4y2dl8z5hJwefP/AFRrmorQyt+nZ9YPJTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBC1rV3O; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a6ff4f91cbso2457318a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713255029; x=1713859829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehIzvJf/eC0nXoW5ysn0/pU7zLJm9tYmImRheU2/Vlo=;
        b=PBC1rV3OE7snTcKhx85Nuui92cbPgfhMRkjkOl7Gopubn2t3NWCmULVbuAvMnmWBhN
         fjclcb7kScc3/T2gYDAkBOUpnTuGEuJ2OFR4oeYJ6hOcI8kKHf4nUGletPoE+P9DLKt7
         JeR02PCjnlapXBqL3LLsblGat6KLsmKa8p4hMOCsl97QmYSeDihemq1SA2tQnGfziPTw
         EcQT22HBSHaK61XzweDhN5pymvdo6DLuuj8DMUrS9BEc98VxFBq7MQ+4YQgfrhQ5zS8o
         W/Qi8GylURRkqFcJPcp2mnwJxkAACDsNk0sKbvv0hzVVY/x1TjtiXn7i7SJro7HD0NtB
         S3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255029; x=1713859829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehIzvJf/eC0nXoW5ysn0/pU7zLJm9tYmImRheU2/Vlo=;
        b=Eit8NbTeNUkfkL72bLTHdqydSZ/peFOyXWxN6450iK0J3ci0ZWTXx+3h2wj0daEqh8
         2nT9N6cLBxdAikDnjE68C3Et8nwsHJGpC2NckVfgGcvUyVpqEVstvgN+u9lrJAufQvPF
         ShGEsXT7B4jFKkARmzFttpt6oOKTrTE63wfa5zCYtb+DNJB9sGzI9p/msGdQIICl2C9h
         mCKzFYkB+KnvwD7CNCSKIJaKYfogZFL5I8TZAgoa7Y8VVtgRBI4TuoiyMzl8MAz8v9Q1
         XdsPmyw7zIDspcY3aqXdJJpXwNhDepKmEXwfYQjB2HIDt7yfej6v7JQyAtCJ1BrKijDp
         inaw==
X-Gm-Message-State: AOJu0Yw29QmSrnBdOvO5UpCzRsTHRbTWDAzrm4rwsBN6RFBwOpr5rj4T
	HT8Jsz5TfGL3H5WBI88D/R9FNizgDEJvWtYIH4hlZrO9vhI2k+s5BOfUfgUKt21Frx9p67AKs8F
	yk+ngoZ+WQr+d5oaGmgoXnxC/36E=
X-Google-Smtp-Source: AGHT+IEamKSE/SXruMQY8L39QgMxzZZkrueEmPvFJ4qb9MSoGMEounQ4n+ty1ShMCHKw2d9qUeCWqDPGPHeLK9A6jkE=
X-Received: by 2002:a17:90b:3a8e:b0:2a5:275c:ed with SMTP id
 om14-20020a17090b3a8e00b002a5275c00edmr10796677pjb.23.1713255029104; Tue, 16
 Apr 2024 01:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b24903061520f3e9@google.com>
In-Reply-To: <000000000000b24903061520f3e9@google.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 16 Apr 2024 16:10:17 +0800
Message-ID: <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
To: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Cc: Paul
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f64776180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=dce04ed6d1438ad69656
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f00471180000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
>
> =============================
> WARNING: suspicious RCU usage
> 6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
> -----------------------------
> kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by ksoftirqd/0/16:
>  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
>  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
>  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid include/linux/mmzone.h:2019 [inline]
>  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: __virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65
>
> stack backtrace:
> CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
>  rcu_softirq_qs+0xd9/0x370 kernel/rcu/tree.c:273
>  __do_softirq+0x5fd/0x980 kernel/softirq.c:568
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:debug_lockdep_rcu_enabled+0xd/0x40 kernel/rcu/update.c:320
> Code: f5 90 0f 0b 90 90 90 eb c6 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d c7 0f 28 04 00 <74> 1e 83 3d 26 42 28 04 00 74 15 65 48 8b 0c 25 c0 d3 03 00 31 c0
> RSP: 0018:ffffc90000157a50 EFLAGS: 00000202
> RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 0000000000000001
> RDX: dffffc0000000000 RSI: ffffffff8bcae740 RDI: ffffffff8c1f7ec0
> RBP: dffffc0000000000 R08: ffffffff92f3a527 R09: 1ffffffff25e74a4
> R10: dffffc0000000000 R11: fffffbfff25e74a5 R12: 0000000029373578
> R13: 1ffff9200002af64 R14: ffffffff814220f3 R15: ffff88813fff90a0
>  rcu_read_lock_sched include/linux/rcupdate.h:934 [inline]
>  pfn_valid include/linux/mmzone.h:2019 [inline]
>  __virt_addr_valid+0x1a9/0x520 arch/x86/mm/physaddr.c:65
>  kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
>  __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526


This should be caused by the following commit:
d818cc76e2b4 ("kasan: Record work creation stack trace with interrupts enabled")

Is it possible to make the rcu_softirq_qs() run only in ksoftirqd task?

Thanks
Zqiang

>  __call_rcu_common kernel/rcu/tree.c:3096 [inline]
>  call_rcu+0x167/0xa70 kernel/rcu/tree.c:3200
>  context_switch kernel/sched/core.c:5412 [inline]
>  __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
>  __schedule_loop kernel/sched/core.c:6823 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6838
>  smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:   f5                      cmc
>    1:   90                      nop
>    2:   0f 0b                   ud2
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   eb c6                   jmp    0xffffffcf
>    9:   0f 1f 40 00             nopl   0x0(%rax)
>    d:   90                      nop
>    e:   90                      nop
>    f:   90                      nop
>   10:   90                      nop
>   11:   90                      nop
>   12:   90                      nop
>   13:   90                      nop
>   14:   90                      nop
>   15:   90                      nop
>   16:   90                      nop
>   17:   90                      nop
>   18:   90                      nop
>   19:   90                      nop
>   1a:   90                      nop
>   1b:   90                      nop
>   1c:   90                      nop
>   1d:   f3 0f 1e fa             endbr64
>   21:   31 c0                   xor    %eax,%eax
>   23:   83 3d c7 0f 28 04 00    cmpl   $0x0,0x4280fc7(%rip)        # 0x4280ff1
> * 2a:   74 1e                   je     0x4a <-- trapping instruction
>   2c:   83 3d 26 42 28 04 00    cmpl   $0x0,0x4284226(%rip)        # 0x4284259
>   33:   74 15                   je     0x4a
>   35:   65 48 8b 0c 25 c0 d3    mov    %gs:0x3d3c0,%rcx
>   3c:   03 00
>   3e:   31 c0                   xor    %eax,%eax
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

