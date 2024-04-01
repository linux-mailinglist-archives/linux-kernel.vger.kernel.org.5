Return-Path: <linux-kernel+bounces-126690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742FE893B81
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4EC2821FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831A53F9D3;
	Mon,  1 Apr 2024 13:36:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9D1EB5B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978564; cv=none; b=r5+LMOVpO686/UuoLYFuobBGYkJIR0xBnDjeGyP6hFJy4hCa5n93z9XKJ3mD6pJ9yk1GuUEhZ18gPbhBTAFodDxkiCDVXDD3PisHAca04Q6eBiMPw810pwf/FtIveQ4HWYmmbNbeqHIGOV0yyC80V05ezEponVnlMP4ReTpvMNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978564; c=relaxed/simple;
	bh=b1af6V8mYFmaKKL3zLG78Ilzn0OYkrzKj+DPvWk0xGU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mg6hJmiISlQBAQn1ixfKbZcI6ZluK5E5PzpMJ/Y6rvzfsXpPU/8ZSblpBVSaVXUqp5bqXdybl1fu3iCiLJXGtLlvtLn3epOPjGGA3obA/mltFwx+54+bGWGERVU90SVPxfrXAwbc6t3OWkR4pXcoLqq0a0myu5hTLuxlpGTkIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d0d7a903ceso17809639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 06:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711978562; x=1712583362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxkSii7fWNsuw6yvY2EXOJco50zj3BVeP7ArIZox5Ws=;
        b=XRnX3LAIw9NjMJnQqt2X5ptZvQcL7h5iydk/9oGJNRAA03KqSFxLG7x4PVZ+B7uA54
         G6+AachUAcGVNFOYTL9wG3Wj3xy6hYM71IOImD/2vDG+IW2lT1+AUJr1llRoD+IopC9v
         YwKm4V0WKZzD7R8VW5h1A86c3u7crOJ6H1M1oSigRQDFJjxAA+sKE9DZXCqqxyhUGEvL
         Yv39x4gbRkYRv3OsLAoKXBa8J49U4SXpch9woPMpQuxJbLInXQG8089gqrIbYvwBaHVW
         +CSmfG6JpidTyvG6ce5aIewqdNtGmuvqs4/Q54YLvp3/0Sz7GVDG9igkhqlzxGtXI2JP
         GhTw==
X-Forwarded-Encrypted: i=1; AJvYcCWV8wyBnZKDzie0qSZ+uIfrRLdTAECFL3kewqbBGM8uxP9FPJGyJt2ytth7OS0uxHhoKWjVAA6zs4LIwInQ58FSf3FWYp1p5Tkqaggu
X-Gm-Message-State: AOJu0Yz2kYai+bkbe69gzkisY/YJ2TyvP/waO9Cwy39Vm6fBmh5CE+zZ
	28hbOzOMp7es2V3YQSv+NgsMCE0bNQzBIch3Tn1QQ70FblS0IaENQxUYQuh8rfGyGZuOSCowGNL
	x3gAKJ7m4xwuKxa2OnIGhR3bbBe3ms5HieAUW1Jhn1G5Zcw1gJu/XU+Y=
X-Google-Smtp-Source: AGHT+IGwbTJ1TP6+L6QhgRdkjuKFtVrrx1U4wmtLo/hn1E0DvraKBoaCLrY7l5K3idUYqD9YcMcWJw3R7MLlbcFZRwtFX3UYypfl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2114:b0:47c:14bd:3f33 with SMTP id
 n20-20020a056638211400b0047c14bd3f33mr417836jaj.0.1711978562606; Mon, 01 Apr
 2024 06:36:02 -0700 (PDT)
Date: Mon, 01 Apr 2024 06:36:02 -0700
In-Reply-To: <20240401130328.3529-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000166f3306150912be@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
From: syzbot <syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hsr_dev_xmit

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-08073-g480e035fc4c7-dirty #0 Not tainted
--------------------------------------------
kworker/0:1/8 is trying to acquire lock:
ffff88806df74da0 (&hsr->seqnr_lock/1){+.-.}-{2:2}, at: hsr_dev_xmit+0x157/0x200 net/hsr/hsr_device.c:230

but task is already holding lock:
ffff888069ca6da0 (&hsr->seqnr_lock/1){+.-.}-{2:2}, at: hsr_dev_xmit+0x157/0x200 net/hsr/hsr_device.c:230

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hsr->seqnr_lock/1);
  lock(&hsr->seqnr_lock/1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

11 locks held by kworker/0:1/8:
 #0: ffff888029984d48 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888029984d48 ((wq_completion)mld){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900000d7d00 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900000d7d00 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffff88806a227538 (&idev->mc_lock){+.+.}-{3:3}, at: mld_ifc_work+0x2d/0xd90 net/ipv6/mcast.c:2649
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: mld_sendpack+0x1de/0xda0 net/ipv6/mcast.c:1790
 #4: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #4: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #4: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: ip6_finish_output2+0x712/0x1670 net/ipv6/ip6_output.c:122
 #5: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #5: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
 #5: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4260
 #6: ffff888069ca6da0 (&hsr->seqnr_lock/1){+.-.}-{2:2}, at: hsr_dev_xmit+0x157/0x200 net/hsr/hsr_device.c:230
 #7: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #7: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #7: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hsr_forward_skb+0xae/0x2400 net/hsr/hsr_forward.c:614
 #8: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #8: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
 #8: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4260
 #9: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #9: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #9: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: br_dev_xmit+0x1b9/0x1a10 net/bridge/br_device.c:44
 #10: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #10: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
 #10: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4260

stack backtrace:
CPU: 0 PID: 8 Comm: kworker/0:1 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: mld mld_ifc_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 hsr_dev_xmit+0x157/0x200 net/hsr/hsr_device.c:230
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
 hsr_dev_xmit+0x162/0x200 net/hsr/hsr_device.c:231
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
 __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0xff8/0x1670 net/ipv6/ip6_output.c:137
 ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
 NF_HOOK+0x9e/0x430 include/linux/netfilter.h:314
 mld_sendpack+0x838/0xda0 net/ipv6/mcast.c:1818
 mld_send_cr net/ipv6/mcast.c:2119 [inline]
 mld_ifc_work+0x7d6/0xd90 net/ipv6/mcast.c:2650
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


Tested on:

commit:         480e035f Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1702f003180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109cd855180000


