Return-Path: <linux-kernel+bounces-131797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A30898BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC0B282FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317412BEAB;
	Thu,  4 Apr 2024 16:13:29 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB321BC46
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247208; cv=none; b=gyFPSY5kwaY9hDkAftbrt50NrKoJI0yDmdInXNQNeDoui/uopgobEFhkca2ez67NhVJRxN3AVch9N0rNDFPafeot4qlX9jaW7zwFXGBweB5CEAU2OToFGAwBAvHIsV5Z7nujbfRYJnKFCwmyYp0Zs3npgsQOhA52l8/utUMuj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247208; c=relaxed/simple;
	bh=khronWIGqnt89hH/mDXnX4s+vc6fgto2IDyVV9w10mg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HQbnvPNCXaCfjHHwTcwUEswPjueU+vJpCOoEBW3PtJnL1xNpfv+qL70sxcuTx4ETE3JPO/IguRm72UV4yCpLuRYFuDr+CFFqPa7e+2nqLNTzG8o0BmjTmfHPRXuDluYycWXC5xxw6lciGSPXTvtwrMFLMwq4vAcXOGmPeNkKIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d0330ce3d4so131415639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247206; x=1712852006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQzpKLqPZarA1v9xUrm2fiN0Y+mM+rSzkkf+U+esxwE=;
        b=h0zbTAqkXlFolcmREUg0ubDBZEAzu1F+sCwkAOc0ltPY/aT9o06QMxbwVx8HTrHH0X
         /zUrnhbiN+hLgHL69eyYE9f6ogY8TjpksRqytQY0C0OH4zELZKUv7V0REi1M4/v7JcGK
         2IjqdOY/xcDlOrBOgv/k1czNix8KX+/7v+Xp5sTHx0ch9reZ9rH5lJB79sKohgPkVSzP
         Siu8sglniVnTbLBkafKnfxbrn363KpNxmJSj8znCxl8dl2aZD+wFx4RE15jykd/yjlfv
         /j8UJxcltCDNsvX3myU9TEjv61YNHZPQCgmXDcZlk9UIQt/vTUB40eOSHibvPSOAv0G5
         mcUg==
X-Forwarded-Encrypted: i=1; AJvYcCVYCe3JkD3PSxvcK2eeHxislnI3s808hl7IUH4zNrTOlWdNO9Bf55zyw8GcQcnp6ziJ9Tyl/hZXCakscCkE9OjkcveyAzHQ7LSxV5iO
X-Gm-Message-State: AOJu0YwD9nFhf0SxVNpmTl5nfpg4oArkEqnYMyw0JqAYIYny1zbnX2Js
	N92TZt+CCR9VT0hI/S0E2fT4fI/6cbAj/m4xxJalCKT8b8MdSMHu1uC/fxqu4gqrsjwOmQkKtHv
	eOWbBHYuF2dBlEV6quMieLaB5vWLvK50mke8ITe0AbUy4Ed7SZE4gvBY=
X-Google-Smtp-Source: AGHT+IFD2kSNP+O9UsnCugSz0KuXipIgZGnuCwc32EpdxeVdWiJSaQPrUeBE1BedBHAH/7D2BPGinR8GtfiqSWqnxL+H7hUFhNWy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d1b:b0:47e:c495:3a19 with SMTP id
 he27-20020a0566386d1b00b0047ec4953a19mr2342jab.2.1712247206557; Thu, 04 Apr
 2024 09:13:26 -0700 (PDT)
Date: Thu, 04 Apr 2024 09:13:26 -0700
In-Reply-To: <00000000000041c9d406154789a4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083ca480615479e79@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in unix_del_edges
From: syzbot <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2b3d5988ae2c Add linux-next specific files for 20240404
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13114d8d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c48fd2523cdee5e
dashboard link: https://syzkaller.appspot.com/bug?extid=7f7f201cc2668a8fd169
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113c7103180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1133aaa9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/136270ed2c7b/disk-2b3d5988.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/466d2f7c1952/vmlinux-2b3d5988.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7dfaf3959891/bzImage-2b3d5988.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.9.0-rc2-next-20240404-syzkaller #0 Not tainted
--------------------------------------------
kworker/u8:3/51 is trying to acquire lock:
ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: unix_del_edges+0x30/0x590 net/unix/garbage.c:227

but task is already holding lock:
ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0xc5/0x1830 net/unix/garbage.c:547

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(unix_gc_lock);
  lock(unix_gc_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by kworker/u8:3/51:
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3193 [inline]
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3299
 #1: ffffc90000bb7d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3194 [inline]
 #1: ffffc90000bb7d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3299
 #2: ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0xc5/0x1830 net/unix/garbage.c:547
 #3: ffff88802bd76118 (rlock-AF_UNIX){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff88802bd76118 (rlock-AF_UNIX){+.+.}-{2:2}, at: unix_collect_skb+0xb8/0x700 net/unix/garbage.c:343

stack backtrace:
CPU: 0 PID: 51 Comm: kworker/u8:3 Not tainted 6.9.0-rc2-next-20240404-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound __unix_gc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 unix_del_edges+0x30/0x590 net/unix/garbage.c:227
 unix_destroy_fpl+0x59/0x210 net/unix/garbage.c:286
 unix_detach_fds net/unix/af_unix.c:1816 [inline]
 unix_destruct_scm+0x13e/0x210 net/unix/af_unix.c:1873
 skb_release_head_state+0x100/0x250 net/core/skbuff.c:1162
 skb_release_all net/core/skbuff.c:1173 [inline]
 __kfree_skb net/core/skbuff.c:1189 [inline]
 kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1225
 kfree_skb include/linux/skbuff.h:1262 [inline]
 unix_collect_skb+0x5e4/0x700 net/unix/garbage.c:361
 __unix_walk_scc net/unix/garbage.c:481 [inline]
 unix_walk_scc net/unix/garbage.c:506 [inline]
 __unix_gc+0x108c/0x1830 net/unix/garbage.c:559
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

