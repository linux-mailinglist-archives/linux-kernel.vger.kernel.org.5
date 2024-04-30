Return-Path: <linux-kernel+bounces-163823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CD8B7285
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A1F1C22946
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356812D1F1;
	Tue, 30 Apr 2024 11:09:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF212C46E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475346; cv=none; b=f2HYMpvov410SgPWuy/j7Ko18P8K5foUBehAdw94zsROSH2qzthjJmOJ8NWkENV9QZg+EivvcR6W0dRVyRQp2/5lNCMoDWh4BWcvpWQ3yWbKwwa6ifsmSHFizhEWztEOgHe3Wv8ThHI9/4G9P9uWvKecioFudmJJZqKGkdPbexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475346; c=relaxed/simple;
	bh=J3HSyMZgBTBNhnYA8D3MACpcnpdJVO3AzTFTRn/e0JY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jhiVeryeNYJnM70+zG3pJs76JPQy2cHwtIL4ttHY8uMpWCoefUo0Y/aMEdMy0vnWWNmtGsuVKuRy024efgiXK7plzYH74KU75xdtJQ700zSe43YxKCIGKJu3NQxrgK+s6konfZ7PJDGXwwcC4Z/Z5MZfPFkI/jPxBijeulBorwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7decf9533a3so163926339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475344; x=1715080144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FYCjUTFJT81BSHxKr2nloSrK7JUlCSMCCvpI0tPKPU=;
        b=F53QXPpuie1aqhHsHxHhbh+Udgi7zm9vtqn7ZeJZklYAS6mK+C1OEIUK1+9GHTA+RS
         68OChzfX8sPeRC2U0iXJqdPg4u9OlJkJMWNFRzAw9D/o7IctzSSDHAJCJhUlsDwgMBpd
         XGWX6ZHek/yj6rsAWXaxHS1EOVLnsUBqz2ZO1qoeWPZArafPQKpfYiwZCddVXrNPb0DM
         jdKiseAaTUt2GI7ex3Ymm9elgCfyOpjO46+oZNTrYIfIbcDMO1/B0L0gnWlyMRtp5j7S
         V71jZxlYjSddu5ftCiUcyJWLSuREIQZZ/E2KKxyny+lhGRSS8/maLKND0P9HGAsC3lnb
         qKXg==
X-Forwarded-Encrypted: i=1; AJvYcCXyPoD8qI5r+O1+Sv4yD6EtemRnoVThjeSf+1aPqYqy777LXt9qa9LamQTJeP4Y7UazkdJsGvl4X+5QbUgmOXagRQ06iv2ZOZF77Y5q
X-Gm-Message-State: AOJu0YyMlx9KtxSWNnwRLKbVGPJLf127u94Qkb1Sb/Gelf7OtKD2OHQz
	tW2nAU6MR1RRLcXeDbOW1DwGq2HHTEHrwmgV7cknXMugSN8WLKB2HV5LzXSNdLLuFi0L8ZVejE6
	DySjTWVtP6L6DS5Duyu6+pzWdiZ7fNi9Lv0tDf2tN8fohIC/8A/4cp6E=
X-Google-Smtp-Source: AGHT+IGOw8tzs5uMSTRmGV29u8Fod+aiPgyQqZZV0urAACR8BuQNVOvu3kDomCHg7QQ2ninI9m5AWVezE/2tHhCJp1rhe8hDayS3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4a4:b0:36c:2b2d:7d0b with SMTP id
 e4-20020a056e0204a400b0036c2b2d7d0bmr50693ils.0.1714475344111; Tue, 30 Apr
 2024 04:09:04 -0700 (PDT)
Date: Tue, 30 Apr 2024 04:09:04 -0700
In-Reply-To: <tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcc0ca06174e65d4@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
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
RIP: 0010:check_preemption_disabled+0x2/0x120 lib/smp_processor_id.c:13
Code: c4 1f 8c 48 c7 c6 c0 c4 1f 8c eb 1c 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 <41> 56 41 54 53 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24
RSP: 0018:ffffc900001578f0 EFLAGS: 00000287
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff8172cd10
RDX: 0000000000000000 RSI: ffffffff8c1fc4c0 RDI: ffffffff8c1fc480
RBP: ffffc90000157a48 R08: ffffffff8fac7fef R09: 1ffffffff1f58ffd
R10: dffffc0000000000 R11: fffffbfff1f58ffe R12: 1ffff9200002af30
R13: ffffffff81423f93 R14: ffffffff81423f93 R15: dffffc0000000000
 rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
 rcu_is_watching+0x15/0xb0 kernel/rcu/tree.c:725
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0xbf/0x9f0 kernel/locking/lockdep.c:5765
 rcu_lock_release include/linux/rcupdate.h:339 [inline]
 rcu_read_unlock_sched include/linux/rcupdate.h:954 [inline]
 pfn_valid include/linux/mmzone.h:2032 [inline]
 __virt_addr_valid+0x41e/0x520 arch/x86/mm/physaddr.c:65
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
Code disassembly (best guess), 3 bytes skipped:
   0:	48 c7 c6 c0 c4 1f 8c 	mov    $0xffffffff8c1fc4c0,%rsi
   7:	eb 1c                	jmp    0x25
   9:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10:	00 00 00
  13:	66 90                	xchg   %ax,%ax
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	41 57                	push   %r15
* 27:	41 56                	push   %r14 <-- trapping instruction
  29:	41 54                	push   %r12
  2b:	53                   	push   %rbx
  2c:	48 83 ec 10          	sub    $0x10,%rsp
  30:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
  37:	00 00
  39:	48                   	rex.W
  3a:	89                   	.byte 0x89
  3b:	44                   	rex.R
  3c:	24                   	.byte 0x24


Tested on:

commit:         bb7a2467 Add linux-next specific files for 20240426
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12a94f0f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16df8838980000


