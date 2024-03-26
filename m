Return-Path: <linux-kernel+bounces-119738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B72588CC92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296E13420DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8C213CA9F;
	Tue, 26 Mar 2024 19:00:45 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688BB1CAA6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479644; cv=none; b=m9fkX6bFATGEBWce7UteuvBm0vqxmQ2GDjxpVTKuNuNYuivvDWYt6y/0YuLkI4uqsjtWyg18838BvFWL1L/75wsJYKi1k3EVbfkWntW1ku9iU1tzrdPOqU+LiFksoHx82/rYgVpuKBMekj40T77jP/tkra1cU7YIOS7BbZwZhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479644; c=relaxed/simple;
	bh=UxodHAc2Q0YMvk9hnxmLqATQNH3AP0kpy/ZDYoiwVx8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rjWLEeF/4rInkzG7/IaZNuzgROWUTWMMrUNQKtG8Bd06y57sPKy6bw8jM1+33rqSEfGtLgt1j+DAJbxjM7Z9IIcPEfZOitbcrSSbbNJqQCVGY61/5PofUE/RmREPe35xWI+Q0MIvSOkOKMbhuyf/vEi0jHSOcYySg9rYrF2srWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf092a502so645654239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479622; x=1712084422;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zh9AoJ3VjIEQxaTVlE60MJ0B18WO2d4RcQKlFIUA598=;
        b=Nh4K08canDO7IkgptemB0Oy9QNwzgj7BOmH5fUCpOBKS3L3N1/lxfdYuT1/2qQTynL
         nA0G6q4S4OsYQ1QpNWsCJWo1cHjIS9X/jjOm8hsx+DvWz6bZLw4/s5hSX/fPqWr51okC
         UHK2aKb8H33scOqnAc/iwQFr6SovvmlEy6hoce7UkHmXQFLjExjN8K7rFUiftI57i03X
         zk6adzO0d8AtkGOM6gYG+W8iUy7WW3pWsm4pAqLm0bfEcve9g9RmlEDrtCdvrrWGamiK
         oySLPqqjv17I0WtSl5hhE4uisHPyq6ci2PmtFfKyfKg0cHDP5rf7LXtDLq7+WlMU7uXl
         PzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9iMCfey9Isu2rX6ep0crFMZFFfww+5r66nodIF1Gt9B/y7zjjwtq2JngpnxeT78s2MVvZ1MpBsFUPEPwATLyQ8OI32g0GhA5zSjKy
X-Gm-Message-State: AOJu0YzvToRTPR8r3r0Ln2yINOFKUIAdFSNmi4y3OxtmtI9YhlAbSrGb
	vD9NOubnpZFJZca7g1eff27K2JOiBzJkgrJVx9BTnxyGmmCsMDUxoKq9+Wb6xQ9C0XxmoCI083F
	fEkZb15NftR8vgLXuXRoYXkT+3yyiFn9m7jBLxarTe6v3ORvBBUn975s=
X-Google-Smtp-Source: AGHT+IF4fN1sZMIozYI+TXiMYCQp1Z5/tfPycHxfUVVuaz6y73FkQ7p3GYXYrNuPOEA+R6jx/Nz5+SDo+GBNiNCUlcxF3x7ssfua
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341e:b0:7cf:1f32:e6f2 with SMTP id
 n30-20020a056602341e00b007cf1f32e6f2mr520853ioz.3.1711479622654; Tue, 26 Mar
 2024 12:00:22 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:00:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2f0c0061494e610@google.com>
Subject: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
From: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11547a65180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.3/6590 is trying to acquire lock:
ffff8880b9529470 (krc.lock){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
ffff8880b9529470 (krc.lock){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
ffff8880b9529470 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444

but task is already holding lock:
ffff888021a271f8 (&trie->lock){..-.}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&trie->lock){..-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451
       bpf_prog_510c7248c5f60c92+0x2e/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_timer_start include/trace/events/timer.h:52 [inline]
       enqueue_timer+0x396/0x550 kernel/time/timer.c:663
       internal_add_timer kernel/time/timer.c:688 [inline]
       __mod_timer+0xa0e/0xeb0 kernel/time/timer.c:1183
       call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
       expire_timers kernel/time/timer.c:1843 [inline]
       __run_timers kernel/time/timer.c:2408 [inline]
       __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2419
       run_timer_base kernel/time/timer.c:2428 [inline]
       run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
       __do_softirq+0x2bc/0x943 kernel/softirq.c:554
       invoke_softirq kernel/softirq.c:428 [inline]
       __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
       irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
       instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
       sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       memory_is_poisoned_n mm/kasan/generic.c:130 [inline]
       memory_is_poisoned mm/kasan/generic.c:161 [inline]
       check_region_inline mm/kasan/generic.c:180 [inline]
       kasan_check_range+0x4f/0x290 mm/kasan/generic.c:189
       instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
       atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
       queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
       do_raw_spin_lock+0x14f/0x370 kernel/locking/spinlock_debug.c:116
       spin_lock include/linux/spinlock.h:351 [inline]
       lockref_get+0x15/0x60 lib/lockref.c:50
       dget include/linux/dcache.h:333 [inline]
       __traverse_mounts+0x3b4/0x580 fs/namei.c:1401
       traverse_mounts fs/namei.c:1442 [inline]
       handle_mounts fs/namei.c:1545 [inline]
       step_into+0x5e5/0x1080 fs/namei.c:1842
       walk_component fs/namei.c:2010 [inline]
       link_path_walk+0x748/0xea0 fs/namei.c:2331
       path_lookupat+0xa9/0x450 fs/namei.c:2484
       filename_lookup+0x256/0x610 fs/namei.c:2514
       user_path_at_empty+0x42/0x60 fs/namei.c:2921
       do_readlinkat+0x118/0x3b0 fs/stat.c:499
       __do_sys_readlink fs/stat.c:532 [inline]
       __se_sys_readlink fs/stat.c:529 [inline]
       __x64_sys_readlink+0x7f/0x90 fs/stat.c:529
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&base->lock){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
       __mod_timer+0x1ca/0xeb0 kernel/time/timer.c:1132
       queue_delayed_work_on+0x15a/0x260 kernel/workqueue.c:2595
       kvfree_call_rcu+0x47f/0x790 kernel/rcu/tree.c:3472
       rtnl_register_internal+0x482/0x590 net/core/rtnetlink.c:265
       rtnl_register+0x36/0x80 net/core/rtnetlink.c:315
       ip_rt_init+0x2f5/0x3a0 net/ipv4/route.c:3719
       ip_init+0xe/0x20 net/ipv4/ip_output.c:1664
       inet_init+0x3d8/0x580 net/ipv4/af_inet.c:2022
       do_one_initcall+0x238/0x830 init/main.c:1241
       do_initcall_level+0x157/0x210 init/main.c:1303
       do_initcalls+0x3f/0x80 init/main.c:1319
       kernel_init_freeable+0x435/0x5d0 init/main.c:1550
       kernel_init+0x1d/0x2a0 init/main.c:1439
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #0 (krc.lock){..-.}-{2:2}:
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
  krc.lock --> &base->lock --> &trie->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(&base->lock);
                               lock(&trie->lock);
  lock(krc.lock);

 *** DEADLOCK ***

2 locks held by syz-executor.3/6590:
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff888021a271f8 (&trie->lock){..-.}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

stack backtrace:
CPU: 1 PID: 6590 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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
RIP: 0033:0x7fe5f987dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe5fa6000c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fe5f99abf80 RCX: 00007fe5f987dda9
RDX: 0000000000000038 RSI: 0000000020000240 RDI: 000000000000001a
RBP: 00007fe5f98ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe5f99abf80 R15: 00007ffe908076c8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

