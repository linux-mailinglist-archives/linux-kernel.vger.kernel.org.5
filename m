Return-Path: <linux-kernel+bounces-151006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299058AA7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E70284E57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969F1B676;
	Fri, 19 Apr 2024 05:06:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98729A2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713503168; cv=none; b=M9jTIegPS5bqfa+9tGJMUzjjOExYme+Ymzh1yn2u8lMR1iWSXQvqkhnzl90oB3pCy7sKvwkFSrXyEckzg1rVt7l2u6Ppdf7xIJzdJSNFffL/Nv7Hy+FCX8htYv0cCsIBg7qPeFF3U/8iSflZZe+3aXxyCWbCTQIsku1mtJi/UwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713503168; c=relaxed/simple;
	bh=pVtnrlHFYLhkjjNwsjfi+LPe4VoWZsXGoSRzI576SL0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aLHsr0XqHQKEgqV1DebM+Ld8eCMoigpn+CdOYZrRDHJKpH8kwEShhjApdE2PeldTFoHBYFF+Fwh+La8Vbq5DFt4iJRgBWN0pqarnUdMkVH0n4L0ST7F7kKFh+0DIwru8NIsrE1tYsBOlH7sds94KdUWOVBP1Zu1SRCOwel4Epks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da4211c691so67035739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713503165; x=1714107965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckZrFnGviII5VQl8HOyjRGK+WvpUvhusO85nB51nl00=;
        b=gcatsdEmnflCt8pEe+E1T+CPoHwu1Hwh92PPulPbAybg0ON3QsSCwDyguY3l3iuBl2
         Wc3w3V6u+AnCfpDDFa/4/d6lZHwylXh3LTuXRuDuu7dW9Yv1o57GRDgHPNHRg6ltersj
         FX3HlMfJer/9wPqKoHayasTt/l+5+pcuxUTfz09TCPqS3P8rP9+9Boslmr0TRTmkPxE4
         ZwhfRex/Ci3UTOeca1qM5kUZlzuVY6uxXm46jofPbftafYAhSJRl2HSR1ks6mUYBZogL
         097NK4D9jHwlVsKmp95KebdsMPcGm7lyXUAE/z1JS/G8e+FNO+ccFiekx+P0p98Z82c6
         5Z3A==
X-Forwarded-Encrypted: i=1; AJvYcCWiK9ulmFuJPP62p1YDME7GS9T7LY+EKSi6VSrDeSrKvDBdkcakXY4JTAY8uW3v+qsvTCuqQfmz4sUX6MeYVELFAGOpRRkMe5Ve/kVO
X-Gm-Message-State: AOJu0YxVT4BneX1N1lANnPqJTq2i3HgnB26vNBUF+INNekjl7YOmygCx
	vP20jbsB72Bb1B3bLIfPlVNFi8cwr3NhaE8LEyfQvSNOmjq+tu4nw7Hni+wgM2TBaUgFqPuiCT7
	Xx4M28hRcPquNyroMLGLneRdSvr1zAJI6zYapLDrXSCM0BZqxQJYMKP0=
X-Google-Smtp-Source: AGHT+IHsUQ+6XaeCvgyy7v40kzkP2qo8HDWuyLZLStjhbSEASIBfiIhZ/J0R8fCsJ5hdkVH3PK7Je2OlHsPGUhlCoZ9ooSE/92L3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:990d:0:b0:7d6:3ef7:a80c with SMTP id
 t13-20020a5e990d000000b007d63ef7a80cmr50560ioj.1.1713503165716; Thu, 18 Apr
 2024 22:06:05 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:06:05 -0700
In-Reply-To: <20240418230932.2689-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083ac2306166c0b7e@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __stack_map_get
From: syzbot <syzbot+dddd99ae26c656485d89@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __stack_map_get

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05271-gf99c5f563c17-dirty #0 Not tainted
--------------------------------------------
syz-executor.3/6102 is trying to acquire lock:
ffff88806da7b1d8 (&qs->lock){-.-.}-{2:2}, at: __stack_map_get+0x286/0x6f0 kernel/bpf/queue_stack_maps.c:148

but task is already holding lock:
ffff88807eace1d8 (&qs->lock){-.-.}-{2:2}, at: __stack_map_get+0x286/0x6f0 kernel/bpf/queue_stack_maps.c:148

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&qs->lock);
  lock(&qs->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor.3/6102:
 #0: ffffffff8e17cf88 (tracepoints_mutex){+.+.}-{3:3}, at: tracepoint_probe_unregister+0x32/0x990 kernel/tracepoint.c:548
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
 #2: ffff88807eace1d8 (&qs->lock){-.-.}-{2:2}, at: __stack_map_get+0x286/0x6f0 kernel/bpf/queue_stack_maps.c:148
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 0 PID: 6102 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __stack_map_get+0x286/0x6f0 kernel/bpf/queue_stack_maps.c:148
 bpf_prog_7a16b54e5ee857f9+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
 __stack_map_get+0x286/0x6f0 kernel/bpf/queue_stack_maps.c:148
 bpf_prog_7a16b54e5ee857f9+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
 __mutex_lock_common kernel/locking/mutex.c:617 [inline]
 __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
 tracepoint_probe_unregister+0x32/0x990 kernel/tracepoint.c:548
 bpf_raw_tp_link_release+0x63/0x90 kernel/bpf/syscall.c:3482
 bpf_link_free kernel/bpf/syscall.c:3033 [inline]
 bpf_link_put_direct+0x123/0x1b0 kernel/bpf/syscall.c:3064
 bpf_link_release+0x3b/0x50 kernel/bpf/syscall.c:3071
 __fput+0x429/0x8a0 fs/file_table.c:423
 __do_sys_close fs/open.c:1557 [inline]
 __se_sys_close fs/open.c:1542 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1542
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f7e74c7cd5a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffc624e2df0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f7e74c7cd5a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000226 R08: 0000001b2f460000 R09: 00007f7e74dabf8c
R10: 00007ffc624e2f40 R11: 0000000000000293 R12: 00007f7e74801260
R13: ffffffffffffffff R14: 00007f7e74800000 R15: 0000000000019ae9
 </TASK>


Tested on:

commit:         f99c5f56 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=124f9ae7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10257bb3180000


