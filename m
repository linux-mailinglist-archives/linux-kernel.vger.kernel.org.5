Return-Path: <linux-kernel+bounces-104002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17C87C7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF41C1F213E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7428D524;
	Fri, 15 Mar 2024 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuopCgMd"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03730D50F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471232; cv=none; b=WU+t7nPzmhL2HLnOZFpTGephO331d35rWnTYe9f8LO5dGeguz1+0DGceZHw14KfYqNsxVtqVISIMg3nePeyeCnq262BjYVeAiAXfNUa9m7WL63CbqfhyrBPrCV+Zdy2iygr1ETAOtlW/FzKxQhCA3fQz6bVSTdNLgdputTCXOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471232; c=relaxed/simple;
	bh=Z4B37locrblXOGaTTfu5JN0atKGr2vGlFGt6s71jK44=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=si+MnNxpKQ5jEsDw/2L3kL+mxycX+Zg9EF31v9oQAptNlT14UkIm+oYb2v/HK4oX8SFxs/EFKLoIC37bGnWB7pY8RXhErnNdkE9sCIsyVpwX6v6nUITT3zofzc692asy1DCk5S+U5PzND9tHfmd2I1fCVCE/2qUNhMU8bUMjZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuopCgMd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513c847c24dso2218388e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710471229; x=1711076029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2B5C3bjcWCzrbMc4wOYHEFSGEz/q/MtVif6i7LgiUWY=;
        b=HuopCgMdRpWxq82iNTUs9ZMi+il0fOxjB+p8k+sJHY8aCv7M3zmIzG92C6TexdPs6q
         +zhfdF0t+A/XcnlFvYKGcjVkQn4jOn2W7m+96l6ggLcfznIQKEqI7ypu+k2eyjJjDT53
         HTGCM5qi61oLLjORSKUC3MIkHAgFTO2DEcvC6PyE/eK5DCyOtuYBMxYVAXEw7k2wBG3Z
         2Zg3+OkwaiSXEx6eaqNqvtfZ4k2pSYHtpkHzLyKRxpOUcmsyBgUdVvVA3UmmunH2O61d
         UsK2P5yrFBCrbWNY89ncWPWkmu++b0HOwlam9wg5bi6ZTgaZdNzSqJwuwCcZyToosb4c
         uK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710471229; x=1711076029;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2B5C3bjcWCzrbMc4wOYHEFSGEz/q/MtVif6i7LgiUWY=;
        b=cqQ7QSiX86mKAbs943oqqjJycz8FH4K70l41qsnbxwvirmGymBe2gravfYfbnbX0Df
         WXn9giUy63YPUVs6msbKYlcWhPky1VoLGFqhviFylPL3DW3cnZl6jHW2rY9UVMNWeYmB
         B3zXrReExDhYlMuZmjOyDUOZ803A+OK5++Oq4AD7Zcq77LH1apXRo9HI9tFOm7TtsKmN
         vdgZ3nxY3A1y90Xe+vpThceBADf+8dDZiFUVJksnHtgILYYveAa8x0mmAorQIj5k1w9b
         HrJGIW/7CMH7CIE9M1rcCvvIGFyvPOUaFFDhn5Hg2+iN3bwOJaie0s3FASl8EKvW1byy
         Ev3A==
X-Forwarded-Encrypted: i=1; AJvYcCUtRM/WDlisEnDHa5Jdt9OOAlWFCJnKcZ10V5tN6bfw2CtlW9UKS3OenM59vBDaAkEajwC0ffir2+EaIt0KdkZDK0RiT2SlbTBYNfBl
X-Gm-Message-State: AOJu0Yx66LYuLKhmRzN3/trtBSl0RuxaAspiOb907aYRsCvHHxM70JvO
	tAY7oIlg9aKvND74IDPEdUQ0XlZEHXEzuQna+7OWEmm3iTlsiUPZVTIhCixqC9CPiqOdO/TdyEn
	WJSf/P/oePjedigfkxKtp1Oy8nVs=
X-Google-Smtp-Source: AGHT+IHiw6Fvb6EPJ8aXUpbB+PP0hs6Ue9NsJI/qlr1EeJljKc7Ht/fegalEJE3c22PqRuw5ljXRQykHp4pvV0TBA4w=
X-Received: by 2002:a19:5e16:0:b0:513:60f5:b488 with SMTP id
 s22-20020a195e16000000b0051360f5b488mr2143174lfb.24.1710471228784; Thu, 14
 Mar 2024 19:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 15 Mar 2024 10:53:37 +0800
Message-ID: <CAKHoSAtX10w7YUbMq3uTUK=27kBc16v08Ugs0NRA2_W6WT4dNQ@mail.gmail.com>
Subject: INFO: rcu detected stall in do_vmi_munmap
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,


when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)

git tree: upstream

console output: https://pastebin.com/raw/aVdC6E9i

kernel config: https://pastebin.com/raw/Ta59KYzh

C reproducer: https://pastebin.com/raw/wnY4TDPU

Syzlang reproducer: https://pastebin.com/raw/AZVZSGGe


If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 3-....: (135 ticks this GP) idle=31a4/1/0x4000000000000000
softirq=28352/28352 fqs=4760
rcu: (detected by 4, t=21003 jiffies, g=41045, q=989 ncpus=7)
Sending NMI from CPU 4 to CPUs 3:
NMI backtrace for cpu 3
CPU: 3 PID: 33337 Comm: modprobe Not tainted 6.7.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:select_task_rq_fair+0x3d/0x3370 kernel/sched/fair.c:8080
Code: 48 81 ec e8 00 00 00 48 8d 84 24 88 00 00 00 89 54 24 20 48 ba
00 00 00 00 00 fc ff df 48 c1 e8 03 89 74 24 08 48 89 44 24 30 <48> 01
d0 48 c7 84 24 88 00 00 00 b3 8a b5 41 48 c7 84 24 90 00 00
RSP: 0018:ffff8881c01895a8 EFLAGS: 00000806
RAX: 1ffff110380312c6 RBX: 1ffff110380312e1 RCX: 0000000000000008
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff88812e78c740
RBP: ffffffff9d7e01b0 R08: ffffed10380312cd R09: ffffed10380312ce
R10: ffffed10380312cd R11: 0000000000000003 R12: ffff88812e78c774
R13: ffff88812e78c754 R14: ffff88812750fc30 R15: ffff88812e78c740
FS:  0000000000000000(0000) GS:ffff8881c0180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa9bb6fd8e0 CR3: 000000010350c003 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 select_task_rq kernel/sched/core.c:3614 [inline]
 try_to_wake_up+0x37e/0x1870 kernel/sched/core.c:4327
 swake_up_locked.part.0+0x5f/0x170 kernel/sched/swait.c:29
 swake_up_locked kernel/sched/swait.c:25 [inline]
 complete_with_flags+0x75/0xa0 kernel/sched/completion.c:24
 csd_do_func kernel/smp.c:133 [inline]
 __flush_smp_call_function_queue+0x2d5/0xa10 kernel/smp.c:542
 __sysvec_call_function_single+0x22/0x1d0 arch/x86/kernel/smp.c:267
 sysvec_call_function_single+0x4b/0xa0 arch/x86/kernel/smp.c:262
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:656
RIP: 0010:get_stack_info+0x0/0x100 arch/x86/kernel/dumpstack_64.c:193
Code: 00 b2 e4 9c e8 61 57 39 00 4c 89 e0 5b 41 5c c3 cc cc cc cc 66
0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <66> 0f
1f 00 41 57 41 56 41 55 49 89 d5 41 54 49 89 fc 55 48 89 cd
RSP: 0018:ffff8881c0189928 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff8881c0189aa0 RCX: ffff8881c0189ac0
RDX: ffff8881c0189aa0 RSI: ffff88812387df00 RDI: ffff888118e6e770
RBP: ffff888118e6e770 R08: 0000000000000001 R09: 0000000000000000
R10: ffff8881c0189aa0 R11: ffffffff9e217a17 R12: 0000000000000008
R13: ffff8881c0182000 R14: ffff888118e6e770 R15: 0000000000000002
 stack_access_ok+0xa7/0x230 arch/x86/kernel/unwind_orc.c:396
 deref_stack_reg+0x26/0x80 arch/x86/kernel/unwind_orc.c:403
 unwind_next_frame+0xdd8/0x1e40 arch/x86/kernel/unwind_orc.c:585
 arch_stack_walk+0xaf/0x140 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x90/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free mm/kasan/common.c:200 [inline]
 __kasan_slab_free+0x10e/0x190 mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0xa5/0x380 mm/slub.c:3831
 rcu_do_batch kernel/rcu/tree.c:2158 [inline]
 rcu_core+0x632/0x1960 kernel/rcu/tree.c:2431
 __do_softirq+0x164/0x529 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0x7e/0xb0 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x75/0x80 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:get_current arch/x86/include/asm/current.h:41 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:206
Code: 48 8b 80 50 0a 00 00 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 0c 24 <65> 48
8b 04 25 40 6f 03 00 65 8b 15 80 b0 e5 65 f7 c2 00 01 ff 00
RSP: 0018:ffff888118e6e828 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888118e6e938 RCX: ffffffff99edebfa
RDX: 1ffff110231cdd27 RSI: ffff888118e6f770 RDI: ffff888118e6f770
RBP: 1ffff110231cdd10 R08: 0000000000000001 R09: 0000000000000000
R10: ffff888118e6e938 R11: ffffffff9e217a17 R12: ffffffff9e94273a
R13: ffff888118e6e988 R14: ffff888118e6f798 R15: 0000000000000001
 unwind_next_frame+0x5ea/0x1e40 arch/x86/kernel/unwind_orc.c:665
 arch_stack_walk+0xaf/0x140 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x90/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x8e/0xa0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x6b/0x8b0 kernel/rcu/tree.c:2681
 mas_topiary_node lib/maple_tree.c:2556 [inline]
 mas_topiary_replace+0x1e02/0x2ec0 lib/maple_tree.c:2662
 mas_wmb_replace lib/maple_tree.c:2678 [inline]
 mas_split+0x2e7e/0x4720 lib/maple_tree.c:3429
 mas_commit_b_node+0x539/0x11f0 lib/maple_tree.c:3482
 mas_wr_bnode+0x11d/0x2a0 lib/maple_tree.c:4198
 mas_wr_modify+0x207/0x28e0 lib/maple_tree.c:4236
 mas_wr_store_entry+0x40a/0x1480 lib/maple_tree.c:4269
 mas_store_prealloc+0xab/0x210 lib/maple_tree.c:5460
 vma_iter_store mm/internal.h:1198 [inline]
 vma_complete mm/mmap.c:532 [inline]
 __split_vma+0x118b/0x1790 mm/mmap.c:2414
 do_vmi_align_munmap.constprop.0+0x377/0xcd0 mm/mmap.c:2582
 do_vmi_munmap+0x18b/0x300 mm/mmap.c:2728
 mmap_region+0x166/0x1e40 mm/mmap.c:2779
 do_mmap+0x677/0xc10 mm/mmap.c:1379
 vm_mmap_pgoff+0x1a0/0x2e0 mm/util.c:556
 ksys_mmap_pgoff+0x342/0x490 mm/mmap.c:1425
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __x64_sys_mmap+0x116/0x180 arch/x86/kernel/sys_x86_64.c:86
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x43/0xf0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fa9bba01e82
Code: eb aa 66 0f 1f 44 00 00 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd
53 89 cb 48 85 ff 74 33 41 89 da 48 89 ef b8 09 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 56 5b 5d c3 0f 1f 00 c7 05 ae 02 01 00 16 00
RSP: 002b:00007ffd15fa42f8 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000812 RCX: 00007fa9bba01e82
RDX: 0000000000000005 RSI: 0000000000159000 RDI: 00007fa9bb512000
RBP: 00007fa9bb512000 R08: 0000000000000000 R09: 0000000000022000
R10: 0000000000000812 R11: 0000000000000206 R12: 00007fa9bb9e0a20
R13: 00007ffd15fa4310 R14: 00007ffd15fa4340 R15: 00007ffd15fa4730
 </TASK>
modprobe (34972) used greatest stack depth: 23912 bytes left

