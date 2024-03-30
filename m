Return-Path: <linux-kernel+bounces-125768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230F892BDD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F721C211E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F3139870;
	Sat, 30 Mar 2024 15:34:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF92C6B2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711812846; cv=none; b=CGVr2vuiOVL+Yv31vBwINW0ShcKIWourl8JvVO0laTho6RQYT8Vbm6cQs9kNy1sBukVH2VMWH33QUFKI58hgpQb8GAAN7XfrVmVrvbuFnCg7eS4aPeVQ/fou7IaMQ3QVEeTQ4rei9iAKdA9it4/f/m+HG0tzpop5oFWsjzh8O7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711812846; c=relaxed/simple;
	bh=Nfk80mxwph6lAhn1WqVReWLfmVTeNRzfx0OMuO+k+a8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JYrmXMfHdCyXwmBd4eaKmsMBDuEu6wrpa0Nb4nG/A2FGjGw2DVequXNqGGFrXHteXkU/RxlxCGCith6SifAGqk15Z4fXGEa/CGF00/kjLSy39cTObENrEe4TCgf3OukO1aWRMs/1C3rWcAkO/Nm2D0ZkpIPqfvmFM73jcG6hiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso234741739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 08:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711812844; x=1712417644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+o6ktVIfOBbf8PsbKWFdH7PErP2lell0dY1hjaSUyE=;
        b=eSJcFdRe/ZLHaTLtMil/dfTZTaCgJ6le4kZ4WQazKBX2liaT3iuFCIXv1vvTgEUTEH
         wYg2FI5pSsML3VdGKJs9dy13QeKEj2yGYUhF2l7Y+ct3//SUe6ER1gxXqNLfpAtx1bMT
         5Y7n6+isjVzQ0gopQN/2va0wESNc2yub0Q7ECmZXNsyTghKXC50TUGb5pe/0pboAr5xe
         lCl/cyv5jhoApGVFLV0mV53gYypbo1TkDwgAGArel16GNDzO/OD/MXueVo4lCIlH4wHU
         UJIRvfogTDeY5g17NWOUz8FCNgV2gNpt3kqNpbnkQbty8NL7j33sckd7rbvamJWoY+VM
         zCug==
X-Forwarded-Encrypted: i=1; AJvYcCX63NaS4R2VgI4NNL+pGn2Y91Aud8FUYmmS/msIKfA65R8nImTKjph2mGnlUZfiuEJbZ3zF6RTLq7WRA19RpdHb5/J/Ua3B+FHL00br
X-Gm-Message-State: AOJu0YxbDx3aIuxgzLo9UPiKNLOnFV86iln0bbCCR3A/ybtOmfqCRS2B
	D9268ACzew+JQRkTrn/CL+P8SIasVuDmNjz98a1W+Oe9ORKk+gBMGNkqs9iiFZzsInOwxMREpRi
	YXAzGSV8sq6uF/cfzCIKyw/5zQhrlvNjC8LRSM9VFeo4hNTXY681Xksk=
X-Google-Smtp-Source: AGHT+IEGmKiKpTnzmzMZxX4laGhtV9rDujpR+dupn7zXqvtWT9BgsxSWikh4Y4NQuoG7TlVejeOON1FLih/Rs0vj6pPfjPDp7d6U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4122:b0:47e:ec40:1430 with SMTP id
 ay34-20020a056638412200b0047eec401430mr60474jab.2.1711812843810; Sat, 30 Mar
 2024 08:34:03 -0700 (PDT)
Date: Sat, 30 Mar 2024 08:34:03 -0700
In-Reply-To: <20240330002732.3029-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a44120614e27cb7@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
From: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in kvfree_call_rcu

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/5491 is trying to acquire lock:
ffff8880b9529470 (#2){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
ffff8880b9529470 (#2){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
ffff8880b9529470 (#2){..-.}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444

but task is already holding lock:
ffff88806aa8d9f8 (&trie->lock){....}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&trie->lock){....}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451
       bpf_prog_2c29ac5cdc6b1842+0x42/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_hrtimer_start include/trace/events/timer.h:222 [inline]
       debug_activate kernel/time/hrtimer.c:479 [inline]
       enqueue_hrtimer+0x335/0x3a0 kernel/time/hrtimer.c:1090
       __hrtimer_start_range_ns kernel/time/hrtimer.c:1265 [inline]
       hrtimer_start_range_ns+0xaa0/0xc60 kernel/time/hrtimer.c:1305
       futex_wait_queue+0xb0/0x1d0 kernel/futex/waitwake.c:357
       __futex_wait+0x17f/0x320 kernel/futex/waitwake.c:669
       futex_wait+0x101/0x360 kernel/futex/waitwake.c:697
       do_futex+0x33b/0x560 kernel/futex/syscalls.c:102
       __do_sys_futex kernel/futex/syscalls.c:179 [inline]
       __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (hrtimer_bases.lock){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
       hrtimer_start_range_ns+0xdf/0xc60 kernel/time/hrtimer.c:1303
       hrtimer_start include/linux/hrtimer.h:275 [inline]
       run_page_cache_worker kernel/rcu/tree.c:3341 [inline]
       kvfree_call_rcu+0x5e6/0x790 kernel/rcu/tree.c:3446
       net_assign_generic net/core/net_namespace.c:115 [inline]
       ops_init+0x2c6/0x610 net/core/net_namespace.c:130
       __register_pernet_operations net/core/net_namespace.c:1243 [inline]
       register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1312
       register_pernet_device+0x33/0x80 net/core/net_namespace.c:1399
       init_mac80211_hwsim+0x12f/0xa90 drivers/net/wireless/virtual/mac80211_hwsim.c:6705
       do_one_initcall+0x238/0x830 init/main.c:1241
       do_initcall_level+0x157/0x210 init/main.c:1303
       do_initcalls+0x3f/0x80 init/main.c:1319
       kernel_init_freeable+0x435/0x5d0 init/main.c:1550
       kernel_init+0x1d/0x2a0 init/main.c:1439
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #0 (#2){..-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
       add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
       kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444
       trie_update_elem+0x819/0xc10 kernel/bpf/lpm_trie.c:385
       bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
       generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1876
       bpf_map_do_batch+0x3e0/0x690 kernel/bpf/syscall.c:5145
       __sys_bpf+0x377/0x810
       __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

Chain exists of:
  #2 --> hrtimer_bases.lock --> &trie->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(hrtimer_bases.lock);
                               lock(&trie->lock);
  lock(#2);

 *** DEADLOCK ***

2 locks held by syz-executor.0/5491:
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff88806aa8d9f8 (&trie->lock){....}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

stack backtrace:
CPU: 1 PID: 5491 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
 add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
 kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444
 trie_update_elem+0x819/0xc10 kernel/bpf/lpm_trie.c:385
 bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
 generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1876
 bpf_map_do_batch+0x3e0/0x690 kernel/bpf/syscall.c:5145
 __sys_bpf+0x377/0x810
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4922e7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4923b110c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f4922fabf80 RCX: 00007f4922e7dda9
RDX: 0000000000000038 RSI: 0000000020000000 RDI: 000000000000001a
RBP: 00007f4922eca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4922fabf80 R15: 00007ffdff5b6398
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=106b0795180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a8bd41180000


