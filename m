Return-Path: <linux-kernel+bounces-149445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B28A9137
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A9D1C20F51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581A53E28;
	Thu, 18 Apr 2024 02:39:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635453371
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713407945; cv=none; b=csnV7KtPk00q0SYrQqmau4Xgd4qc6xdYgq2XTj+v/q7QZ1SJEfT0C8iMenMn8BDZEehZRFrYMcpIRsfFP2rfrhBbRuLx6gQow2alfj3F8pIGz8hDxNP8iOBo0gd8yDgdhRNUhZxL7KMjFbG0YIo7F4pGhCV0eWwNu9jwana/raA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713407945; c=relaxed/simple;
	bh=/dLyDWObIqnB42KBKAKv62CCxMIOsiKRjoLnPcPYRAo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y3JbgFk3bfqdwuBeBEWX5oWpVUwQTaf+okCkD7gyChUUboWnQxrdxwlZFSzfey0g2v9hPtbQ3fdrND1gGKnifTmwJWh8szQQBhWDtYETC9eVwVtqkRDg96g6jzw7zyfmo95tTstymgvjJb/6MhcbcLZIga3l0OPV1NHHRiMVZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a208afb78so5166155ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713407943; x=1714012743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBituP3Wm+uhtEROLQKJYYHbwWhTc1zAjgRPTJ/giA4=;
        b=sk2dKa08eRFT95XJgs1YBQAmOhNE9r+A4kW+t7gfJUOyYIQlFpEzSi/RwACc8icsAq
         NqJnTpReEg8DYOw2rzi9mOO6V6ae3evuT1lbOpukc6Jp2Bj5Lco5gJyW1Ix6h1WjoitU
         jEAaaJBAyisypFQ0u6dKXhIvlRScliceMrzknSP4nGCubbtx24U1jYjG1Nk/OHDf1m3m
         HdhJIi+5alqEWTVGmCzykQOqiIebeOdfCcS0lIWqwmLoBHQgJlTvVtA20eNJ7AE5fyap
         MY45GLNwgPPZWrAquubnJbwzpB1eTGN3He/bNO/VLGVGTPK8nyBQ4DeDF+pkohmdgOyW
         CFHw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHL3WdIvwdqAOM1w/yTXUl6InMNt1dMjYI0un1ujlZOGGuvTOHDS2lbslaGHcbpKl9/qIIfYEFmhEdagxDZLlgFCjGrXRem+ddcfY
X-Gm-Message-State: AOJu0Yy1fqZRRitRlMJP3i2zJmm9uQftDXoYNU4kNvzwuV6izEJ7C8d6
	zKLO7FHqmdLfDtoAlrlXAhQVgWgsCDaM/4iqFvTO4FRQEepM5XUjzcIVMcb46JQHcsNH1gWozid
	OS7T8fHWvkK8n5qxFd1VkqeEdDrSdXFXcHlw5NUdxR2UGykoCixWM0ig=
X-Google-Smtp-Source: AGHT+IGXIAztf2ZFb7ACTC51EaqLxIrmbewurYDyGgAyi4rXlzAawGH0pxwsZRVnn03wpKwGf+GCsar8+C7pQZVR2D8ltxD4otii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:36a:3615:33e4 with SMTP id
 h1-20020a056e0213a100b0036a361533e4mr33935ilo.4.1713407943014; Wed, 17 Apr
 2024 19:39:03 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:39:02 -0700
In-Reply-To: <20240417231300.2556-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc8a8b061655dfa1@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
From: syzbot <syzbot+7fd4b85697bcf2a9daa2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: suspicious RCU usage in __do_softirq

=============================
WARNING: suspicious RCU usage
6.9.0-rc3-next-20240412-syzkaller-dirty #0 Not tainted
-----------------------------
kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ksoftirqd/0/16:
 #0: ffffffff8e334060 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e334060 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
 #0: ffffffff8e334060 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid include/linux/mmzone.h:2019 [inline]
 #0: ffffffff8e334060 (rcu_read_lock_sched){....}-{1:2}, at: __virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65

stack backtrace:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc3-next-20240412-syzkaller-dirty #0
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
RIP: 0010:lock_release+0x51/0x9f0 kernel/locking/lockdep.c:5762
Code: 04 25 28 00 00 00 48 89 84 24 e0 00 00 00 49 bf 00 00 00 00 00 fc ff df 48 c7 44 24 60 b3 8a b5 41 48 c7 44 24 68 5d 09 b4 8d <48> c7 44 24 70 e0 d2 72 81 4c 8d 64 24 60 49 c1 ec 03 48 b8 f1 f1
RSP: 0018:ffffc90000157920 EFLAGS: 00000282
RAX: 1ce013f6d4eb5b00 RBX: 0000000000000001 RCX: ffff888016ec5a00
RDX: 0000000000000000 RSI: ffffffff81423eb3 RDI: ffffffff8e334060
RBP: ffffc90000157a48 R08: ffffffff81424067 R09: 1ffffffff25ee6b4
R10: dffffc0000000000 R11: fffffbfff25ee6b5 R12: 000000002524d378
R13: ffffffff81423eb3 R14: ffffffff81423eb3 R15: dffffc0000000000
 rcu_lock_release include/linux/rcupdate.h:339 [inline]
 rcu_read_unlock_sched include/linux/rcupdate.h:954 [inline]
 pfn_valid include/linux/mmzone.h:2029 [inline]
 __virt_addr_valid+0x41e/0x520 arch/x86/mm/physaddr.c:65
 kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
 __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526
 __call_rcu_common kernel/rcu/tree.c:3102 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3206
 context_switch kernel/sched/core.c:5412 [inline]
 __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	04 25                	add    $0x25,%al
   2:	28 00                	sub    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	48 89 84 24 e0 00 00 	mov    %rax,0xe0(%rsp)
   d:	00
   e:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  15:	fc ff df
  18:	48 c7 44 24 60 b3 8a 	movq   $0x41b58ab3,0x60(%rsp)
  1f:	b5 41
  21:	48 c7 44 24 68 5d 09 	movq   $0xffffffff8db4095d,0x68(%rsp)
  28:	b4 8d
* 2a:	48 c7 44 24 70 e0 d2 	movq   $0xffffffff8172d2e0,0x70(%rsp) <-- trapping instruction
  31:	72 81
  33:	4c 8d 64 24 60       	lea    0x60(%rsp),%r12
  38:	49 c1 ec 03          	shr    $0x3,%r12
  3c:	48                   	rex.W
  3d:	b8                   	.byte 0xb8
  3e:	f1                   	int1
  3f:	f1                   	int1


Tested on:

commit:         9ed46da1 Add linux-next specific files for 20240412
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1260ada3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=7fd4b85697bcf2a9daa2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ccb37d180000


