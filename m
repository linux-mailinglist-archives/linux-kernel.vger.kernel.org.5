Return-Path: <linux-kernel+bounces-122183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5DC88F32D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C12A7926
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FCC1552F0;
	Wed, 27 Mar 2024 23:27:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAA12A157
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582041; cv=none; b=AU49hrRG54Pkv7fRNnrzPZjolMv9DmCWVncZ+/M2Ydykxyg5s1Ey5h+g1OjuXW2OlDexkskjviAXmGgTRjlEi+P2VsAR7D4EBvrqEwiN3022eVqkJqfFWHoO5JMuQT2kJEJXL5GuAyei1xp/o/U0DhXESpn33ayioDuacmkZDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582041; c=relaxed/simple;
	bh=9iqRHXiosXnDRM27eD9CCRzZXsl0KVBbmd3Fx6Tf4PI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C6Wfk4hUe7RU7PoKaybLo3FK3q1yNz401CdU3ERVLKdba+LDHJ4xiMjAAdBTTuY/YYACR7TcVmk7VTA8VKFLgY3gXcJi+zC8EmgxFs5muSyDv2HHCvYbotg/h80jtqqxeYLPQQRTFQbPBv76eIKgCldAg7EsFC1IJBgeSiGln+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbef888187so29996539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711582039; x=1712186839;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn+nNCI3Y9vT/+kIQMpjFCCQ/Pi1LaMfpKeNn5LCWpQ=;
        b=vZrktIv9fMNCT3DkEFWIyvVUlui/9lfXEZOE5OcWrhnPuE1RUzsBaehCQ86gBk3Doq
         jIthj71/S9StyxOm/OLN5sUdLwzRyz5mkbrr6X7NLuvdIP3dqlQg5Y1f/P0+7i1acfWy
         lGYTEPiq/gkq9JAcNRj+ZQwobcLxjgO0ShkQ0cCFEMdtMY5+voVFRogMoI1HbO/MtnmV
         b/HJE/opliVY2+MGXnWjn0m5dsubn4RoTj/kYWojvWkCTlClJEkhyJFSAe5pLd6avhHB
         lln51bLLUBmbcDtYjbw8i2Kfm2NNQoVjZUUVnLhJ1eANZuhxFfgwBP1mvQ9Nki/BoVIA
         q0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbJvpXb87ir+kPA4gE0swQ8jhj7kPcQFTxP3HjEQpVM3cHtlh+G5f/Ycn1BVKsoSiAf8ZsYgYqYs09yuGTmIeh4tU2hrCNiuBpAE7I
X-Gm-Message-State: AOJu0YyzQchuFg69Z8qUDo1/5T/Rnr8GAg3Q3C7HWhEp9EOdzjWbx8XX
	hawibyQFbUeOxzHTOQJA/Hmk8PEIy8Y4XF0G1JpR3PYpFRMjlxXbt6vXFZ11o5eBdRpD8Ty7FUI
	E58BDhznOIFU+0VZL8GyIRSHSnWyCPg4SZHB1d7SHPTrmvHf0yaJkA2Y=
X-Google-Smtp-Source: AGHT+IERbwZ4BLxARkUTyCkw4tqyzqdnMHsmqp2Zl+5+j/uvscpy2nMCHuAzBLQg7xTuCLPTapCsdk40HAFIfHGwvHNnMs9rZ7oO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2415:b0:47c:12e6:7d13 with SMTP id
 z21-20020a056638241500b0047c12e67d13mr38284jat.5.1711582039071; Wed, 27 Mar
 2024 16:27:19 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:27:19 -0700
In-Reply-To: <000000000000f2f0c0061494e610@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000716bb60614acbf37@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
From: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, paulmck@kernel.org, rcu@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	urezki@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146398f9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12055cc6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ca53c9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05236-g443574b03387 #0 Not tainted
------------------------------------------------------
syz-executor271/5074 is trying to acquire lock:
ffff8880b9529470 (krc.lock){....}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
ffff8880b9529470 (krc.lock){....}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
ffff8880b9529470 (krc.lock){....}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444

but task is already holding lock:
ffff888029e171f8 (&trie->lock){-...}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&trie->lock){-...}-{2:2}:
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
       hrtimer_start_expires include/linux/hrtimer.h:289 [inline]
       hrtimer_sleeper_start_expires kernel/time/hrtimer.c:1972 [inline]
       schedule_hrtimeout_range_clock+0x277/0x480 kernel/time/hrtimer.c:2309
       poll_schedule_timeout fs/select.c:244 [inline]
       do_poll fs/select.c:965 [inline]
       do_sys_poll+0xe40/0x1330 fs/select.c:1016
       __do_sys_ppoll fs/select.c:1122 [inline]
       __se_sys_ppoll+0x2a0/0x330 fs/select.c:1102
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
       rtnl_register_internal+0x482/0x590 net/core/rtnetlink.c:265
       rtnl_register+0x36/0x80 net/core/rtnetlink.c:315
       ip_rt_init+0x2f5/0x3a0 net/ipv4/route.c:3719
       ip_init+0xe/0x20 net/ipv4/ip_output.c:1664
       inet_init+0x3d8/0x580 net/ipv4/af_inet.c:2022
       do_one_initcall+0x238/0x830 init/main.c:1241
       do_initcall_level+0x157/0x210 init/main.c:1303
       do_initcalls+0x3f/0x80 init/main.c:1319
       kernel_init_freeable+0x435/0x5d0 init/main.c:1557
       kernel_init+0x1d/0x2a0 init/main.c:1446
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #0 (krc.lock){....}-{2:2}:
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
  krc.lock --> hrtimer_bases.lock --> &trie->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(hrtimer_bases.lock);
                               lock(&trie->lock);
  lock(krc.lock);

 *** DEADLOCK ***

2 locks held by syz-executor271/5074:
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff888029e171f8 (&trie->lock){-...}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

stack backtrace:
CPU: 1 PID: 5074 Comm: syz-executor271 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
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
RIP: 0033:0x7f485af3c8e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5f419378 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffc5f419548 RCX: 00007f485af3c8e9
RDX: 0000000000000038 RSI: 0000000020000000 RDI: 000000000000001a
RBP: 00007f485afaf610 R08: 00007ffc5f419548 R09: 00007ffc5f419548
R10: 00007ffc5f419548 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc5f419538 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

