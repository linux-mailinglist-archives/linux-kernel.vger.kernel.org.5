Return-Path: <linux-kernel+bounces-126446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB633893830
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8186428193B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986459454;
	Mon,  1 Apr 2024 06:11:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA053BE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711951890; cv=none; b=fWexMcMd/oz52PlaweNg21PjqC77RBKf/2TvzHc85cmxXa/zQWHgusIPHENTBLXktixxPPNQswyoLyEKJa0+hChMIsKFyiJeckAWJl6Kv04pUWB+Jk/dJc1Vddz7vG2vXH5Jojnjj/UvABV7rgMLiLkwzrdJIRuw0ZlJ3f2TTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711951890; c=relaxed/simple;
	bh=5RzfPD80g1MajIdzMSOBq3UGYhnnxMPtHW7ucZlPId8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DsVipc5FLFTx4FDIr5c70z9O8tenSsqJkr+uTgGsr91/xg2XSzeJT0VeRQ1Ut/WsWknqQknx1szMsf8Q93MbtHHvUKQlkel8+vyBhEUOLThSQ1te0yP6MHJ6b4GrfGx96+Bre/n5DMxCuSjLdfNchsYGK1WhkOJNQcVVPE1/CzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so396567639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 23:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711951887; x=1712556687;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QU2ivE4+RjX4u7lvetSsWaIm0V+DKP8bcLz4UjQG+xE=;
        b=xIVVWDxIqBNMSVw8MdmOVtgm5yphVrEDu78H452wzuZtrdZ8w495xAVY7mWLPueBNk
         GVye2U8jbdcGNfOnitZ4pY+hj2UQ1UxraB14O/L3ds4qLUvjHPE8EG0NCNMmO17LF06V
         79oqLKZmuEca1E1ZEZZnsC0R57lrjzoKC6qGh2WlFEVlH+bPWown6vjjbH8RyZiSwaZr
         ohEnNJ2/fESTt/suAS9pm27RVTLljY0tY96EO2YTrftzW+DxpZXhk8j3Z5LqOvlWD9hB
         M81Lp6Sp2sMc/T0LRFzaoAiJY1BT+NWoAeOWNbHIhW6U4+W/uaz4AKDbDqtk46/DcVwN
         qs0w==
X-Forwarded-Encrypted: i=1; AJvYcCVxmxzcQFylvoPuAxiNmhxSDEkOjd/v6N4OQO7Epsob7UKxXpewzyzhtgRvc46EPepnpU6atylwRseSzpYjoi4y898Gy62WsTfp03ed
X-Gm-Message-State: AOJu0YzRj8yu+zILUDh9lZcFh6VQNzVVq7J4f4wX6HVlC4PTx+4lqFZq
	6W+Xgawlpe0YNYbE/mq4bMYpExQd0w0pEyOlFyJnQU02E0te1YXqxVvXV1VIwj1qyIvFFTR239C
	NCuUa0cbG8ClbJtI0phZa0w/rakDmZqUXp09uAH84iKjrO5XpNxh+EwE=
X-Google-Smtp-Source: AGHT+IFFH6jMD6jhXSfTF/8n97fODaGx9BtJ8w+g5dRBic/6Guq06rzc6t84WkYWl8Ho+6ArVPMQ+Qnlo52F0GamU4iwMJBJkhwQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2727:b0:47c:a3e:2f25 with SMTP id
 m39-20020a056638272700b0047c0a3e2f25mr328200jav.6.1711951887643; Sun, 31 Mar
 2024 23:11:27 -0700 (PDT)
Date: Sun, 31 Mar 2024 23:11:27 -0700
In-Reply-To: <000000000000c430800614b93936@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022c6b2061502dcbb@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
From: syzbot <syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166a86e5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10526855180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e0f5c3180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-08073-g480e035fc4c7 #0 Not tainted
--------------------------------------------
ksoftirqd/1/23 is trying to acquire lock:
ffff8880744d6da0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff8880744d6da0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: hsr_dev_xmit+0x13e/0x1d0 net/hsr/hsr_device.c:229

but task is already holding lock:
ffff88802383ada0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802383ada0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: send_hsr_supervision_frame+0x276/0xad0 net/hsr/hsr_device.c:310

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hsr->seqnr_lock);
  lock(&hsr->seqnr_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

7 locks held by ksoftirqd/1/23:
 #0: ffffc900001d7a40 ((&hsr->announce_timer)){+.-.}-{0:0}, at: call_timer_fn+0xc0/0x600 kernel/time/timer.c:1789
 #1: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hsr_announce+0xa3/0x370 net/hsr/hsr_device.c:387
 #2: ffff88802383ada0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff88802383ada0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: send_hsr_supervision_frame+0x276/0xad0 net/hsr/hsr_device.c:310
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hsr_forward_skb+0xae/0x2400 net/hsr/hsr_forward.c:614
 #4: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #4: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
 #4: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4260
 #5: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #5: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #5: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: br_dev_xmit+0x1b9/0x1a10 net/bridge/br_device.c:44
 #6: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #6: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
 #6: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4260

stack backtrace:
CPU: 1 PID: 23 Comm: ksoftirqd/1 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 hsr_dev_xmit+0x13e/0x1d0 net/hsr/hsr_device.c:229
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
 __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 br_dev_queue_push_xmit+0x701/0x8d0 net/bridge/br_forward.c:53
 NF_HOOK+0x3a7/0x460 include/linux/netfilter.h:314
 br_forward_finish+0xe5/0x140 net/bridge/br_forward.c:66
 NF_HOOK+0x3a7/0x460 include/linux/netfilter.h:314
 __br_forward+0x489/0x660 net/bridge/br_forward.c:115
 deliver_clone net/bridge/br_forward.c:131 [inline]
 maybe_deliver+0xb3/0x150 net/bridge/br_forward.c:190
 br_flood+0x2e4/0x660 net/bridge/br_forward.c:236
 br_dev_xmit+0x118c/0x1a10
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
 __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 hsr_xmit net/hsr/hsr_forward.c:380 [inline]
 hsr_forward_do net/hsr/hsr_forward.c:471 [inline]
 hsr_forward_skb+0x183f/0x2400 net/hsr/hsr_forward.c:619
 send_hsr_supervision_frame+0x548/0xad0 net/hsr/hsr_device.c:333
 hsr_announce+0x1a9/0x370 net/hsr/hsr_device.c:389
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2408 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2419
 run_timer_base kernel/time/timer.c:2428 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554
 run_ksoftirqd+0xc5/0x130 kernel/softirq.c:924
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

