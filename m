Return-Path: <linux-kernel+bounces-153364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB88ACD28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C57285417
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166214EC69;
	Mon, 22 Apr 2024 12:45:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BF147C82
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789923; cv=none; b=EW414pRk2VSfX7/sSNr3Kiidb66p0fLwdwr8SPt2HVghYQWzD/Aj33x5y+SB7rhMPS+9Cxt9s4Je4NGKw2+esExBg/hv+IdXVDpOhIbcJMkb+MFQtrDVbnv9CiYzg2HK+KUyZRtfFvsQtrJVm5VI1+ZgJiJMdlUK2YGr6C4yH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789923; c=relaxed/simple;
	bh=28tsV9yK+rJVV2f4/tt4XKo2L2mQDul5ibAHe5ClVqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q7waTZRHiqk/imKaRSWBp1sCj8Td1UYglUdE2MP8QlUYQraAjeo2rMTpCrxJ5mA8MtwDNchUlMnphUycil/dYSdR3ahd28FXINrX3BGMxgl/gQpIvDdTlTljGyQZ1EyfadWGFybo79+9kp5OUIJ3igqOTXLelhoul7xp+7z3ePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso621305639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789921; x=1714394721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXCEoZO/gbntGb+lYVcV7jprHWP+gposqiw1cE9Ugg0=;
        b=NjuMrBGPhiYYTKTj9atlfnvQNWO8JI/luwGEddmwcUE7Q0jreUmhYEWbF4oEv1vZid
         QzfcK0Ci9zME1GYvE3YOUCF010fmK17QNKI1Xt/L/lCO2IfV10hZ8TJydkZk5bIwVgLr
         d7jAgRogEkYKcVShs2ljaT31XUXra/hE6li8M598XJnIQyrxWk8kKUrZ2B2H+wnRgaFY
         u8WtIugTkkaGgjDPjRr6AlqSm48tc8NOlR7A/0hKNO68BJcrPOUTU3XuU/Fs/Wat9O4r
         STRB3SHyVdRrw4oh05kuhkvedOt0qYbjLn6UiD0H30u6y8OeJnCfSXoI9H0TZD7dmlch
         EmLw==
X-Forwarded-Encrypted: i=1; AJvYcCW+5lSL5+dVGTls+3IjHi8hpLEFNUhYU1j/gOteiYEVddDFcwvMYLdqDdc4f6lPsZcQgQ2d35MHS04C1Iedeu9ysUAK4WtYIDNk/Wb1
X-Gm-Message-State: AOJu0Yz1LNYyU8ciSj0Q08YtGTMGZUdehd8WgCNDCIATrD7510mjYZVP
	ezarn9QQ2/nHtJkX4gFq3wXglgjU7jic7UkjUPOUsIouKdWZZ6a0KGuzsXOCGdP4uH0lu4x5IWM
	WBs8imYdXkdU8pMrl/qGoFsGU5/IG9sW748sB/KDWjDlkoMzgo2m3jyU=
X-Google-Smtp-Source: AGHT+IEd6ydCVlgwvNsCSNXitHad/0D6z+alp68HaQM7eQz8Gz8i827PZAeMM28UOuXCTQZDdvWODsGoBiFU2aA7OPF/bRGlJX6z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8791:b0:485:654b:2857 with SMTP id
 ix17-20020a056638879100b00485654b2857mr47413jab.4.1713789920967; Mon, 22 Apr
 2024 05:45:20 -0700 (PDT)
Date: Mon, 22 Apr 2024 05:45:20 -0700
In-Reply-To: <000000000000bafb9f06160bc800@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000758c1c0616aecf58@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in __sock_map_delete
From: syzbot <syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ed30a4a51bb1 Linux 6.9-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15124c3b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=a4ed4041b9bea8177ac3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102d66bf180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10107f67180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-ed30a4a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c62dd6fbdae1/vmlinux-ed30a4a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ee0879390c1/bzImage-ed30a4a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.9.0-rc5-syzkaller #0 Not tainted
--------------------------------------------
syz-executor381/5177 is trying to acquire lock:
ffff888027aca200 (&stab->lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888027aca200 (&stab->lock){+...}-{2:2}, at: __sock_map_delete+0x43/0xe0 net/core/sock_map.c:417

but task is already holding lock:
ffff888027acaa00 (&stab->lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888027acaa00 (&stab->lock){+...}-{2:2}, at: sock_map_update_common+0x197/0x870 net/core/sock_map.c:493

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&stab->lock);
  lock(&stab->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor381/5177:
 #0: ffff88802f6ad258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1671 [inline]
 #0: ffff88802f6ad258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_sk_acquire net/core/sock_map.c:117 [inline]
 #0: ffff88802f6ad258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_update_elem_sys+0x1b6/0x570 net/core/sock_map.c:578
 #1: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: sock_map_sk_acquire net/core/sock_map.c:118 [inline]
 #1: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: sock_map_update_elem_sys+0x1d8/0x570 net/core/sock_map.c:578
 #2: ffff888027acaa00 (&stab->lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff888027acaa00 (&stab->lock){+...}-{2:2}, at: sock_map_update_common+0x197/0x870 net/core/sock_map.c:493
 #3: ffff88801a940290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #3: ffff88801a940290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
 #3: ffff88801a940290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xbf/0x6e0 net/core/sock_map.c:180
 #4: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #4: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #4: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #4: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0xe4/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 3 PID: 5177 Comm: syz-executor381 Not tainted 6.9.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __sock_map_delete+0x43/0xe0 net/core/sock_map.c:417
 sock_map_delete_elem+0xb5/0x100 net/core/sock_map.c:449
 ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x225/0x390 mm/slub.c:4377
 sk_psock_free_link include/linux/skmsg.h:421 [inline]
 sock_map_del_link net/core/sock_map.c:158 [inline]
 sock_map_unref+0x392/0x6e0 net/core/sock_map.c:180
 sock_map_update_common+0x4f3/0x870 net/core/sock_map.c:506
 sock_map_update_elem_sys+0x3bb/0x570 net/core/sock_map.c:582
 bpf_map_update_value+0x36c/0x6c0 kernel/bpf/syscall.c:172
 map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
 __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6bcc5b7729
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff751f0718 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fff751f08e8 RCX: 00007f6bcc5b7729
RDX: 0000000000000020 RSI: 0000000020000680 RDI: 0000000000000002
RBP: 00007f6bcc62a610 R08: 00007fff751f08e8 R09: 00007fff751f08e8
R10: 00007fff751f08e8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff751f08d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

