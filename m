Return-Path: <linux-kernel+bounces-125962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2376D892EB1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D0B216BD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C6F6FD5;
	Sun, 31 Mar 2024 05:43:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A66ABA
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863784; cv=none; b=YQQ1c4RMUB+0Ir0Vo/v+c0m114SX51cRxAPkHDnHyfz2rotH2sFJ3wwJ7g0RaHQvk87/uKMoNwe72q7GHIj8myickzw6jNtCSx7wmPk4X13VNbAi2fSOyyzB7DQf1U0jUdub3MwXcRFKiMyVqQc9/QeoteCROoYmBXxc8u5W9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863784; c=relaxed/simple;
	bh=GIOJZooBe3Z48JkB/RRQuSErBIIwRhSUD/ni9Qxk/EA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kNB6C2BI/hf2+thJ0p8cSU8tP1/byCmwowk7heVmVfM80NPL/klgDVhYlBIbqTbH9R0C3BbPNkYUno8JHPlaeeJ2renrEJaKFP5bL9rlM3+4phw+mbOJCqEiGIaK27iINhXy8Zgw0tgyVF08Ac6v3wdqMq7IeOnw5w0UR3nfAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36848678a9fso31330945ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 22:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711863782; x=1712468582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+a8LlCzsPQisLcF7Auz9ATb5BxT44leGZw9M1YSzJA=;
        b=ltRdBWr5/MuFABIUh/9D7ySGaCRndiyDOuirh2jYjnDV9tgqHAMWp+qmk9GZR59jM2
         dmDSZvAYSWgpQiVltJFhwkLOtDqPIVGYzPRNbBqlNePRrM6DpjeyYFmFuqQgJ6xo7VO6
         spqEHZForHrVouRqWfl1cGp/eBEC9VsHhVRA4WoMQ0LkePnqanvp5zkJ7jmRmDdx8haw
         Cicpn2v/CwCONXipI39mIF7lnHIj2Ax8B48iy+k4LEtpSrIA5YCJXFar52yZJdvESbrG
         0wU/HNJM9koZGF1d0Z9j/3mrjUvkSXUFFkMMjlAQcyv9ZnQUbg+zIyCQbiT+KzHX9NIH
         CmuA==
X-Forwarded-Encrypted: i=1; AJvYcCVhjcsU+rE+Sv/llkU9H6mIgCeDOb/W/vKASX04GX7EoUdC2DQpHUwZHQCd/lwDIjwQFZ4+HkbPddeT6jHwkwIdyFb9WiLt5UBjpCZ9
X-Gm-Message-State: AOJu0Yzy2xB6Fy4tqjvsvXSMvkNLfddFADj1sSZ98JGoUD0Xmm+ZDYvW
	z+OzHg87cKe76zgUTQh/56N9ck7N+zuDgEkEB7tfRl40Oh7NNvA+dBdIrojuyjQViUaXmCxypvO
	EKCkzi0XO8aR7SkM4oqS6i6uH8zSNmORCntYQvH2elaUxaqGEweSVe3w=
X-Google-Smtp-Source: AGHT+IGdY8qu+rK3j8r7IqxtPD8q7JOp9wYf+H/Ux/ls3AQ8Ad+qItYYYGIWyEaMuoGeRX+IDvIkzA0OqqdlDzkK7eqVT2BphxdD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:369:3f5:30bb with SMTP id
 e7-20020a056e020b2700b0036903f530bbmr243469ilu.1.1711863782299; Sat, 30 Mar
 2024 22:43:02 -0700 (PDT)
Date: Sat, 30 Mar 2024 22:43:02 -0700
In-Reply-To: <20240330234217.3169-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5ee4e0614ee586e@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
From: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hrtimer_start_range_ns

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/5489 is trying to acquire lock:
ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_start_range_ns+0xdf/0xc60 kernel/time/hrtimer.c:1303

but task is already holding lock:
ffff88802195e9f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&trie->lock){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451
       0xffffffffa00060ce
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

-> #0 (hrtimer_bases.lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
       hrtimer_start_range_ns+0xdf/0xc60 kernel/time/hrtimer.c:1303
       hrtimer_start include/linux/hrtimer.h:275 [inline]
       run_page_cache_worker kernel/rcu/tree.c:3342 [inline]
       kvfree_call_rcu+0x60e/0x7c0 kernel/rcu/tree.c:3447
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

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(hrtimer_bases.lock);
                               lock(&trie->lock);
  lock(hrtimer_bases.lock);

 *** DEADLOCK ***

3 locks held by syz-executor.0/5489:
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff88802195e9f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324
 #2: ffff8880b9529470 (krc.lock){....}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
 #2: ffff8880b9529470 (krc.lock){....}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3360 [inline]
 #2: ffff8880b9529470 (krc.lock){....}-{2:2}, at: kvfree_call_rcu+0x192/0x7c0 kernel/rcu/tree.c:3445

stack backtrace:
CPU: 1 PID: 5489 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
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
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
 hrtimer_start_range_ns+0xdf/0xc60 kernel/time/hrtimer.c:1303
 hrtimer_start include/linux/hrtimer.h:275 [inline]
 run_page_cache_worker kernel/rcu/tree.c:3342 [inline]
 kvfree_call_rcu+0x60e/0x7c0 kernel/rcu/tree.c:3447
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
RIP: 0033:0x7f44a5a7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f44a686a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f44a5babf80 RCX: 00007f44a5a7dda9
RDX: 0000000000000038 RSI: 0000000020000000 RDI: 000000000000001a
RBP: 00007f44a5aca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f44a5babf80 R15: 00007ffc1ffeb058
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=148dffe6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a5ffe6180000


