Return-Path: <linux-kernel+bounces-110554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7A886080
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC65283257
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A413341C;
	Thu, 21 Mar 2024 18:26:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90917482E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045585; cv=none; b=seFADQC8bsGzIlYnaHpuo/MRqmtkEex8TLi9iuhKXcU6gZ9CSkhlOCjEjAAGPUa9ydZZxFelw0tsL5eF3Mzj/7zXE6HcfTBTLBTTPzhXi2IdBfTeiYzIxbh+tNohkJqgNm2wdFPQDNd0MrO8T4LssStiUFpoJt7qQjlRUMXOqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045585; c=relaxed/simple;
	bh=SZgluvydT/EGvnA/dZrr4njmDWq5+XZCplcvNunBWIU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mdUDxTzwK2pI1tIa3V3yvoutIi/xzm9PzguI4O01A1+5AyytmU0FwS6N1MDVtXivYTbwiph4xXLN4ShWe9eLqfD2x0V5Fywie3g2QPIew4xjEPaJSGMISW7ttxCXJS+IJ46BLzhPs2jhYeU9NhbM4s72JebyDqEIIwLD8RoRKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf1d5d35bso140750539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711045583; x=1711650383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGGGJ6hS+NX1gIEP6zG3HfxGpBxruXr4DhrSeWnJUq0=;
        b=KXSlgfLz6JscYLwG6ex7EAvMmGPfambTUidSCtfdq8yb4njOS/JKG1Vy3OdFOZbVXn
         7axYFUe7fsKij+ZpbSYbBR1W0UIFzDUcA0x0CggXolBsdmmj/H6s1yC4KwFbUfeDZbvh
         egF0tMiwitaT1Lwln06rkwSQ9lwF4kVsjSr9HSLu91WH8MTCYhYWX85JSPjujTfqFe+f
         bT/1xjKm3Rt5xb2huNRdum56U8GBY2Cape6RxD5j7rjCKZQ1RFcNNI/3M6xBS2QdUFc3
         VT/gKo6ivCVk2Teq6oPIObEKcdUoLle0PHrvpuXCnxp15tzzWS5UFCodwuHsbf2CQoYg
         f8uA==
X-Forwarded-Encrypted: i=1; AJvYcCV8R67QKgGZUdBUDELDGA4d1gykwVYcEluELLltf/mUMuHl8dOSd43R4x0rOc3HlCOIrx0AV1ASfCnop1r6qMEUlgoX8GVTZBh8vwVA
X-Gm-Message-State: AOJu0YwQKNgpT3uRBF8kp5eH++/XzZ+BxE/UHam55zsma0TKtHAc/bOT
	1L1R3EaXjav1NwzntpMObFUoVGVbIOocMzqTdX/i8jSmelSwyfFzmubUS/rVjzqT/XiPNtLWYGI
	g41AGfxt3WV4w2bO+em9cqI39px3MMJwScL5fW41IWZJ3ta97ObQSjO0=
X-Google-Smtp-Source: AGHT+IEzP9RQul65NSXzneKuudOdALyA2dyeNUf+LKuf/Nf3oynssdZsGa0i02ku//6FChBjtl5SnfQsZDXJK5VBLP6v7KRISl4N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270b:b0:474:c3b5:a8b7 with SMTP id
 m11-20020a056638270b00b00474c3b5a8b7mr238jav.6.1711045582799; Thu, 21 Mar
 2024 11:26:22 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:26:22 -0700
In-Reply-To: <000000000000ae28ce06112cb52e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002854eb06142fd863@google.com>
Subject: Re: [syzbot] [tipc?] [batman?] BUG: soft lockup in sys_sendmsg
From: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, jmaloy@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, 
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=134d4fa5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=a6a4b5bb3da165594cff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139a4c81180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108b0ac9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [syz-executor227:7772]
Modules linked in:
irq event stamp: 5373
hardirqs last  enabled at (5372): [<ffff80008ad68de8>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (5372): [<ffff80008ad68de8>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (5373): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (5373): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (542): [<ffff800088e9a56c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (542): [<ffff800088e9a56c>] release_sock+0x154/0x1b8 net/core/sock.c:3547
softirqs last disabled at (548): [<ffff800088eaf8bc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (548): [<ffff800088eaf8bc>] lock_sock_nested+0x74/0x11c net/core/sock.c:3526
CPU: 0 PID: 7772 Comm: syz-executor227 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
lr : queued_spin_lock_slowpath+0x168/0xcf8 kernel/locking/qspinlock.c:383
sp : ffff800097ca76c0
x29: ffff800097ca7760 x28: 1fffe00018e1be6b x27: 1ffff00012f94ee4
x26: dfff800000000000 x25: 1fffe00018e1be6d x24: ffff800097ca76e0
x23: ffff800097ca7720 x22: ffff700012f94edc x21: 0000000000000001
x20: 0000000000000001 x19: ffff0000c70df358 x18: 0000000000000000
x17: 0000000000000000 x16: ffff8000809fd934 x15: 0000000000000001
x14: 1fffe00018e1be6b x13: 0000000000000000 x12: 0000000000000000
x11: ffff600018e1be6c x10: 1fffe00018e1be6b x9 : 0000000000000000
x8 : 0000000000000001 x7 : ffff800088eaf8bc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008ae5db50
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 __cmpwait_case_8 arch/arm64/include/asm/cmpxchg.h:229 [inline]
 __cmpwait arch/arm64/include/asm/cmpxchg.h:257 [inline]
 queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x320/0x348 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:127 [inline]
 _raw_spin_lock_bh+0x50/0x60 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 lock_sock_nested+0x74/0x11c net/core/sock.c:3526
 lock_sock include/net/sock.h:1691 [inline]
 tipc_sendstream+0x50/0x84 net/tipc/socket.c:1550
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

