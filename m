Return-Path: <linux-kernel+bounces-122299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 157AB88F4D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391711C3030A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB439FD4;
	Thu, 28 Mar 2024 01:37:20 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1A39ADD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589839; cv=none; b=ZZZM5ZJCvzPleCShTckBgCFp8OSoGiuSX5+qC7DtOBzVTHxLctA8V0TxggZXkfphF4p3gx+xptqOgmrHKZZgEd3HltPpjYd4t6cqNbxn1uluQVzWWts7nykHrXmC9wvl2oTx9CTB4xROt8Yxrox6Hir0GGqnVxXEcCJi2I4D8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589839; c=relaxed/simple;
	bh=0PXBV+XsQFF1qQr9BQWAxqxWMVqsMgeG34vwDH5X3vs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i+xy0w98i0V3cYyaE2mB6WKGT6wRtNPggdYmjqUQiqwBmjL6LQEzFx9WiKKRz56qYTQq67L9inA3g8hDR8AcdJ4ON7ZoCytxzD6W56jftev8/lhbmfaS/0KRk4gOXS3gcsb9EU0jno9COplz2ro1amYYVfGrzGJLKt2PUpoZawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc78077032so47499639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589837; x=1712194637;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sd6cZws7s3j1CmzuJQzJmY1iOL4n/PGz5SWGIACnpt8=;
        b=VHki4/QIyx7ZSvqxNoQPV2WXn0BNT5wTJcK9HG4k5e0aADGJ41ZIs5gvl3UYl4uNyd
         uhPn4ejjePZXK1oBqSVvZYj1iYcTtZU7lwP2r4+UjC/Qxf9ZFSIhp0QnH8h+AUfWC+gu
         Oo4SeQDP1UoeWMRwh1y5U1CMOh8U3yk+18Rl6sO1aDEX/04CJKKX9ast+AtVsRdDViud
         Hly6MvFLgpY2BIaEHP/w1FUAWHkpzD4BjCSyQSKPM23hB/qm/q/4UhYOBrlTxQH9bdGJ
         +88EQQ9/LfXZ0NH8m8htqmV+UJ1R4IDdwiEYkZvIzXI5EoUWUqyqKuldfApdllgwWcjV
         xl2A==
X-Forwarded-Encrypted: i=1; AJvYcCWnxpllJdMxNEdZfZdE3gBs4gHdYZK8VgoBL23xmfbGweG1fvBpOrNoqo/NM7oM3x+vFtxQp0qS8GZQnGmj1eulL/mcCkase/wdmsob
X-Gm-Message-State: AOJu0YzR43CwCAlJuEOXEtBVDMcZkkEqZskw3zBW5+kPQobOVGXoESG0
	/YYgfI1onQ/si86kvwnvBw7zKdGay6WCKPKu+YypnD3uQZs5brJKVO9fFktisC4IOOj8Y6GRyd6
	Q9mHg4lKgWnlJHn5uF9EqGWdz72UpYL6J+oKxdEq0e9sl+vUGTMUlXs4=
X-Google-Smtp-Source: AGHT+IFlvLB8emNotRqYRLvmA3j46U4XOsfI22YqJ6yR7lHtLTb8gya8KwRVSp1PXLi6yUBBMHXi1h3smdm8xNZ4nMz98CbwXNv5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:368:727e:ec80 with SMTP id
 s3-20020a056e02216300b00368727eec80mr39235ilv.5.1711589837054; Wed, 27 Mar
 2024 18:37:17 -0700 (PDT)
Date: Wed, 27 Mar 2024 18:37:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d360f0614ae902b@google.com>
Subject: [syzbot] [kernel?] BUG: using smp_processor_id() in preemptible code
 in pwq_release_workfn
From: syzbot <syzbot+60f75ab7624f6e44392b@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    61df575632d6 libbpf: Add new sec_def "sk_skb/verdict"
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17683185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=60f75ab7624f6e44392b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0d2d0f91bfad/disk-61df5756.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b0f2fd80260/vmlinux-61df5756.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0450c835a85f/bzImage-61df5756.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60f75ab7624f6e44392b@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: pool_workqueue_/3
caller is pv_init_node kernel/locking/qspinlock_paravirt.h:284 [inline]
caller is __pv_queued_spin_lock_slowpath+0x192/0xc60 kernel/locking/qspinlock.c:439
CPU: 1 PID: 3 Comm: pool_workqueue_ Not tainted 6.8.0-syzkaller-05238-g61df575632d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
 pv_init_node kernel/locking/qspinlock_paravirt.h:284 [inline]
 __pv_queued_spin_lock_slowpath+0x192/0xc60 kernel/locking/qspinlock.c:439
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 lockdep_lock+0x1b0/0x2b0 kernel/locking/lockdep.c:144
 lockdep_unregister_key+0x20d/0x540 kernel/locking/lockdep.c:6456
 wq_unregister_lockdep kernel/workqueue.c:4655 [inline]
 pwq_release_workfn+0x6e0/0x840 kernel/workqueue.c:4958
 kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
BUG: using __this_cpu_add() in preemptible [00000000] code: pool_workqueue_/3
caller is __pv_queued_spin_lock_slowpath+0x945/0xc60 kernel/locking/qspinlock.c:565
CPU: 1 PID: 3 Comm: pool_workqueue_ Not tainted 6.8.0-syzkaller-05238-g61df575632d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
 __pv_queued_spin_lock_slowpath+0x945/0xc60 kernel/locking/qspinlock.c:565
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 lockdep_lock+0x1b0/0x2b0 kernel/locking/lockdep.c:144
 lockdep_unregister_key+0x20d/0x540 kernel/locking/lockdep.c:6456
 wq_unregister_lockdep kernel/workqueue.c:4655 [inline]
 pwq_release_workfn+0x6e0/0x840 kernel/workqueue.c:4958
 kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
BUG: using __this_cpu_add() in preemptible [00000000] code: pool_workqueue_/3
caller is lockdep_unlock+0x16a/0x300 kernel/locking/lockdep.c:157
CPU: 1 PID: 3 Comm: pool_workqueue_ Not tainted 6.8.0-syzkaller-05238-g61df575632d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
 lockdep_unlock+0x16a/0x300 kernel/locking/lockdep.c:157
 lockdep_unregister_key+0x45c/0x540 kernel/locking/lockdep.c:6471
 wq_unregister_lockdep kernel/workqueue.c:4655 [inline]
 pwq_release_workfn+0x6e0/0x840 kernel/workqueue.c:4958
 kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

