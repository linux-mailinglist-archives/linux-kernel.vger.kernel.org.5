Return-Path: <linux-kernel+bounces-125770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B207E892BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A791C2143E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6620B39AD5;
	Sat, 30 Mar 2024 15:46:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68A2D047
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711813569; cv=none; b=cGs66yAKS1LlChaZw+9leKkSWYsU5sl7KA1BswcnLqkdS7HeelNpjrc/D8wPinLpVLWADSottRp4dAABfNc8w9AuGLxPbMasz4uSzDKwboSHDW+qzQKWLu6I+fQ/B9DgC6gHvAI0GBqY0nn2G3lIJ5StdnIgUIJWfWmHLBqegK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711813569; c=relaxed/simple;
	bh=HmJkstWOXvWdanm91KU5WDxCl1wWeACjjlKw9rIN/ko=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B3TSTW0F21RGaV0oqCZt4KPwk3of2jNY+PDbebMr4WIl7Yqk253Mjxt/jyWeGzXtixxxRNUMYk+wJWOaufwd4e1zOZiRtUxWYZYFHfVpWCSzcFym1PmV+4sH2WGUggVIymlqOVlNy0CExkx/ETwVgKm5M9kia3Dleny2QRi8t+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso312272439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 08:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711813567; x=1712418367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU3CbaABGw0fyo0ShZzcN2Pensn8INYJozEbFOv7EgQ=;
        b=LPcBj4kM927qGhch/QfIvn04p0C6qEpIqRUEiqAe0WceE5cOxQEwAfcI9fUwxWfAD8
         zbRyKN37E5N7Y5y6HaH5NDxmdpKvC+78lfB6G75MRPExf/Cp8KaSYJglv12C7xKCnwgB
         N+aB1ERLbZh/u9PTvd0IXyKx35PCb4DSkte+myaciSy4krFoKPoR1D2evq+EGjwX4cl5
         7i8lbLP3ZiPCCN7XVHwpzJ+yBI8rGP5Ap1azHyV1roIAWDrfTWr39x8RL+xvUdLdJgKg
         48ADI29g3gZUZHEbEPaKUZrHOnNwhs4X/Ne7DI8yWiKolsU4BwQDDGulDigoTQc0CLsn
         VmPA==
X-Forwarded-Encrypted: i=1; AJvYcCXx/WREgrIKqzsz02dJATLXEKkZ7DQC6Vjun4t4SVFnjJgR3D6d2TRM9Rmrj7qNmMot08jFAO9lCMyCpOM8Odw7UxJuTruey1/X8f+d
X-Gm-Message-State: AOJu0YykCUJyTQpUe6JAGmabjAuiNNamliggPMQ+04jmUgBvCVpLc/vO
	gl4Ji6J183le1wudiqSq8akmGyq1pz7MGbLOVHA8Qug5qlyL6PEUDPMO7iS2b5J80FyMTpg8n1R
	daC/S2H5wQFgm0y1SCDOdCnNRiZ/zomN5wmLepEK95MJLgB8Jqsc0s+c=
X-Google-Smtp-Source: AGHT+IG3cmUJUXtwzDHM65ve2Yyc13OxunG420VT5tZc3cSrhPhBHk1R5rku2J9wDp8zwiW7SYTwLdb9d1X1hxieYv8rezObYS9Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2601:b0:47b:f666:f7e5 with SMTP id
 m1-20020a056638260100b0047bf666f7e5mr283253jat.6.1711813566362; Sat, 30 Mar
 2024 08:46:06 -0700 (PDT)
Date: Sat, 30 Mar 2024 08:46:06 -0700
In-Reply-To: <20240330004405.3091-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b834b0614e2a7d6@google.com>
Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in
 kauditd_thread (4)
From: syzbot <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in hrtimer_forward

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5464 at kernel/time/hrtimer.c:1053 hrtimer_forward+0x1d3/0x260 kernel/time/hrtimer.c:1053
Modules linked in:
CPU: 1 PID: 5464 Comm: udevd Not tainted 6.9.0-rc1-syzkaller-00274-g486291a0e624-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:hrtimer_forward+0x1d3/0x260 kernel/time/hrtimer.c:1053
Code: 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 49 bc ff ff ff ff ff ff ff 7f eb 85 49 bc ff ff ff ff ff ff ff 7f eb c3 e8 9e d5 12 00 90 <0f> 0b 90 48 c7 04 24 00 00 00 00 eb b9 e8 8b d5 12 00 4c 89 e0 4c
RSP: 0018:ffffc90000a08d30 EFLAGS: 00010046
RAX: 0000000080010001 RBX: ffff88807bc91340 RCX: ffffffff817a9ad4
RDX: ffff888029330000 RSI: ffffffff817a9c12 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 00000000000035cd
R13: 58f2e2407277c48d R14: 58f2e24072778ec0 R15: 0000000000030d40
FS:  00007f983e6dac80(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa573182b10 CR3: 000000001e630000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hrtimer_forward_now include/linux/hrtimer.h:355 [inline]
 advance_sched+0x670/0xc50 net/sched/sch_taprio.c:983
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:59 [inline]
RIP: 0010:stack_access_ok+0x1cd/0x270 arch/x86/kernel/unwind_orc.c:393
Code: 8b 44 24 08 48 01 c5 49 39 ec 0f 83 3e ff ff ff e8 a8 ab 50 00 48 39 eb 41 0f 93 c6 e9 30 ff ff ff e8 97 ab 50 00 4c 8b 3c 24 <4c> 39 fd 0f 83 d3 fe ff ff e8 85 ab 50 00 48 8b 44 24 08 48 01 e8
RSP: 0018:ffffc90003b57870 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffc90003b57990 RCX: ffffffff813cc4e6
RDX: ffff888029330000 RSI: ffffffff813cc619 RDI: 0000000000000005
RBP: ffffc90003b57980 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003b57998
R13: ffffc90003b579a0 R14: ffffc90003b50000 R15: ffffc90003b58000
 deref_stack_reg arch/x86/kernel/unwind_orc.c:403 [inline]
 unwind_next_frame+0xd9b/0x23a0 arch/x86/kernel/unwind_orc.c:585
 __unwind_start+0x5aa/0x880 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xb2/0x170 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x380 mm/slub.c:4344
 putname+0x12e/0x170 fs/namei.c:273
 do_sys_openat2+0x160/0x1e0 fs/open.c:1414
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f983e3169a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff4c215900 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f983e3169a4
RDX: 0000000000080241 RSI: 00007fff4c215e48 RDI: 00000000ffffff9c
RBP: 00007fff4c215e48 R08: 0000000000000004 R09: 0000000000000001
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
R13: 000055d9597f572e R14: 0000000000000001 R15: 000055d959810160
 </TASK>
----------------
Code disassembly (best guess):
   0:	8b 44 24 08          	mov    0x8(%rsp),%eax
   4:	48 01 c5             	add    %rax,%rbp
   7:	49 39 ec             	cmp    %rbp,%r12
   a:	0f 83 3e ff ff ff    	jae    0xffffff4e
  10:	e8 a8 ab 50 00       	call   0x50abbd
  15:	48 39 eb             	cmp    %rbp,%rbx
  18:	41 0f 93 c6          	setae  %r14b
  1c:	e9 30 ff ff ff       	jmp    0xffffff51
  21:	e8 97 ab 50 00       	call   0x50abbd
  26:	4c 8b 3c 24          	mov    (%rsp),%r15
* 2a:	4c 39 fd             	cmp    %r15,%rbp <-- trapping instruction
  2d:	0f 83 d3 fe ff ff    	jae    0xffffff06
  33:	e8 85 ab 50 00       	call   0x50abbd
  38:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  3d:	48 01 e8             	add    %rbp,%rax


Tested on:

commit:         486291a0 Merge tag 'drm-fixes-2024-03-30' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=129ac3c6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=81f5ca46b043d4a1b789
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15be4109180000


