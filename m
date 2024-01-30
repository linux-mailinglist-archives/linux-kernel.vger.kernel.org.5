Return-Path: <linux-kernel+bounces-44376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1083C842118
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDA9283EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F006664C1;
	Tue, 30 Jan 2024 10:21:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759E65BC9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610065; cv=none; b=mZVSV/mwxS91mU28Az/PRYBfwhdaGCpNCYNavrpJHgFyAGm275lpqoUk7RU/sf7pdbfQkB8xaQngYgNwjWtRQ7uWkaAaRX7D4Aj5sZQEwpL5TwA74GPo64qMkTHKqLs43qn7O864h5EAI14S/1ksXJ/mq/NQ4eF+Si+QtF2UPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610065; c=relaxed/simple;
	bh=jlMithfBQN2il3NmDRMtmTVMqafgBvkA/hDL4DDaPOo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GpvXXMWP0cnzvcL2ZF2j1bdRDA+hynYDrVZsctfLOx08gXn13UpbuGpTKPJmrzpDu7kL9hLXqZnw8MfxBqiupGD2dezEhEmvh7Wq8SzBkHMV0yZoeSXEC18Ujk6Y7eZB61XBSbdQPlFcREQ+3Z0s7dcihT7rPdlasDvUsg8YzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3637bd89021so13923915ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610063; x=1707214863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vfDa5JQ/AdHkO4ZL51SEZ9o+lBjrfJ+IPVxYzinO1Y=;
        b=kv/OL/TM+dH0986VTIIPuhX0CvbWIomABQo7aOT8ElyYhcX24T12VXCMIH3mwlU/fY
         XxtKVA2+/QlLW/0uQts+eySKEC2qDY5GqvbXQJsR51ZRejztJ5itNcKC67QVQIf7Ar5T
         LbC4a6aUsxRnajpQYyALKoQqQemr87gDUBjpEqJKCfGG0/5+SYjZA2jwKWpKnNEPz6U/
         KhaG4qXFV0H5xqkR2ac4MRz7vioKWsg/o0Mz/6mArT6CeQnwK0VTzmyFFDE08A7WMG5k
         FmwC9j4NFDJt/wR0bspUS4RK4ZneG63dApoZDHxYhRMNs8YtJO1ChjDNKr8u8/mqlDmd
         oSRw==
X-Gm-Message-State: AOJu0YxCaVLI0TxlANuAZffoku6n87WLw2KPpLf9/A0RqlWD/y8JJ+eR
	CogLPb5CpFetIIEALFNzeA+p27RePuywk/swejfNFiD4bE3kEZ3F4AYxGekb/7+32Y2PQNfWCQB
	kWTLN+Ka2v5rDxVoeaivC6QRS3ElLNSfMqC7sUutUqsW7/6pIPc2htlU=
X-Google-Smtp-Source: AGHT+IENZWVgoKVJ4kzJao7he1rHHIUhU3JOsvifcrH2L8ZLwOaIBU3y9Xy1AThTyf9i25nqHWOATlhYRwje/ukEDZZIc/EzqAdw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:363:9252:ed47 with SMTP id
 j5-20020a056e02154500b003639252ed47mr21521ilu.1.1706610063546; Tue, 30 Jan
 2024 02:21:03 -0800 (PST)
Date: Tue, 30 Jan 2024 02:21:03 -0800
In-Reply-To: <tencent_26AF244CD76BD77646CD337D636D49720305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ba03b0610271e68@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in put_probe_ref

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by ksoftirqd/0/16:
 #0: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2184 [inline]
 #0: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_core+0x7bd/0x1680 kernel/rcu/tree.c:2465
Preemption disabled at:
[<ffffffff8a922753>] softirq_handle_begin kernel/softirq.c:394 [inline]
[<ffffffff8a922753>] __do_softirq+0x123/0x8de kernel/softirq.c:529
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10176
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0xe2/0x9d0 kernel/locking/mutex.c:752
 put_probe_ref+0x14/0x1b0 kernel/trace/blktrace.c:350
 blk_trace_rcu_free+0x71/0x90 kernel/trace/blktrace.c:394
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x660/0xa10 kernel/smpboot.c:164
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.8.0-rc2-syzkaller-g861c0981648f-dirty #0 Tainted: G        W         
-----------------------------
ksoftirqd/0/16 is trying to lock:
ffffffff8d22fa28 (blk_probe_mutex){+.+.}-{3:3}, at: put_probe_ref+0x14/0x1b0 kernel/trace/blktrace.c:350
other info that might help us debug this:
context-{2:2}
1 lock held by ksoftirqd/0/16:
 #0: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2184 [inline]
 #0: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_core+0x7bd/0x1680 kernel/rcu/tree.c:2465
stack backtrace:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G        W          6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4751 [inline]
 check_wait_context kernel/locking/lockdep.c:4821 [inline]
 __lock_acquire+0x821/0x3b30 kernel/locking/lockdep.c:5087
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9d0 kernel/locking/mutex.c:752
 put_probe_ref+0x14/0x1b0 kernel/trace/blktrace.c:350
 blk_trace_rcu_free+0x71/0x90 kernel/trace/blktrace.c:394
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x660/0xa10 kernel/smpboot.c:164
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
BUG: scheduling while atomic: ksoftirqd/0/16/0x00000101
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<ffffffff8a922753>] softirq_handle_begin kernel/softirq.c:394 [inline]
[<ffffffff8a922753>] __do_softirq+0x123/0x8de kernel/softirq.c:529


Tested on:

commit:         861c0981 Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=121ea1fde80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13151c40180000


