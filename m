Return-Path: <linux-kernel+bounces-106355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607287ECF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DA11F21495
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253553394;
	Mon, 18 Mar 2024 16:03:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA752F8D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777803; cv=none; b=AD/q2SepuqMxVb2i/y1fhxzu7VQVqR6BRaEWY36RtmvDIehXmgNEhYSUNuW1sTJ1fXVkknnrCyjWx19n3+/998qatb5v0MienW5Xjn3rItz41yTQcHrYtOzwDP6b9a9XmwSLGirsT+dP8xsLkgvdIBWB5H4klD9p6LYWKEzulp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777803; c=relaxed/simple;
	bh=LgBEE954d8HVX+jPEO5HwArTJ/CRNUYZQnnIo5eukSA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FBCF5CIWwQhK2HkS9/Wmpybe4aWcwoWZLhsADuqXl3DzON6i10AEy2ixLR2/6U7YiQJkFg2hJqmH0tomhkiOFZFtozVRccv4OnB7d4Q35wXoWw5nf1Xd4UFL+s9OjPozCQcWw6KUQ1JRkR37pjgPF8YBmcxlosOCvCP8qWREJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-366c3152af9so11353385ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777801; x=1711382601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHtJnWtd6RoBK4zDgnmMUaefunHW0MPhVgb1LJRs0Ho=;
        b=DrGZaLcKfdenPxP3ICjwER3tA/SCTQ0QmYM5snAoeTP9ThsMweNzqbg5I+LGt7T3aS
         7cIcMci4WtlO9FzXsYjN3X1YWOwrA/czXRhC4NGIpk/MgGSaXKqfJNSW+YhPMusejlCV
         rBCzKSVPWIjnOI03/JibbAG0HZk3KLAvxOAGbxReXjYyckinafokyUGGUp63BbEjcdrS
         /B2de2z28KSfS6nOChunJ0bhsBJrKeqBvcBwOXMRTWWg/Iv7bkF/1QqpvrCXXcMWJzUD
         VPXCr90BWDFmE35LvuZXxHB/rTW+TDgoc0EQZ/DS12X0fmaqg2vUruvS9DL4Nd82/s1J
         z+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUkFW0ojhhMNnKW2rURRE9MUynEf/b+UXwYuOza5ZP3l71pLr9pKbjl0jcVptt11hOtODkk5WvADCdunDWlAPBySu3eqVEAPaaxbd+/
X-Gm-Message-State: AOJu0Yw3n6c2H4GkqZpSiziGrj+1vo2gzR4qHVL8N8KvGS0U4rwVJbRg
	whyLWlCOLiVKBakSx4bAv4E9HrCvJGgg2I0FTLideE9saz9raO0aeea3rQxgPQM09MwY9uz5Qrg
	9OsZX2EAijMvcKzjZX0gq4waYuq8iXdYGNcwoO0dEUGYZnqU3qfIt1kU=
X-Google-Smtp-Source: AGHT+IGSXI/yUv0rjc6ACiv2rSTuMOE8k/ioRKFxv2MbmD/8bBqwkbvYJyL/xasU2ihb3RJQXuVzjhsYCfkwkJB4udCrn+FAazXS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:366:94e2:f17b with SMTP id
 z7-20020a056e0217c700b0036694e2f17bmr802591ilu.0.1710777801319; Mon, 18 Mar
 2024 09:03:21 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:03:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000233ab00613f17f99@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in sock_map_delete_elem
From: syzbot <syzbot+4ac2fe2b496abca8fa4b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aae08491b943 MAINTAINERS: Update email address for Quentin..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1638d769180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95cdb255229a/disk-aae08491.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc336e48f648/vmlinux-aae08491.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1abbb4a4ac37/bzImage-aae08491.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ac2fe2b496abca8fa4b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05221-gaae08491b943 #0 Not tainted
------------------------------------------------------
syz-executor.4/12756 is trying to acquire lock:
ffff888054905a00 (&stab->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888054905a00 (&stab->lock){+.-.}-{2:2}, at: __sock_map_delete net/core/sock_map.c:414 [inline]
ffff888054905a00 (&stab->lock){+.-.}-{2:2}, at: sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446

but task is already holding lock:
ffff888045774290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888045774290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
ffff888045774290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xcc/0x5e0 net/core/sock_map.c:180

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&psock->link_lock){+...}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_map_add_link net/core/sock_map.c:134 [inline]
       sock_map_update_common+0x31c/0x5b0 net/core/sock_map.c:500
       sock_map_update_elem_sys+0x55f/0x910 net/core/sock_map.c:579
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
       __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&stab->lock){+.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       __sock_map_delete net/core/sock_map.c:414 [inline]
       sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
       bpf_prog_174084c74af853ee+0x42/0x67
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_kfree include/trace/events/kmem.h:94 [inline]
       kfree+0x291/0x380 mm/slub.c:4396
       sk_psock_free_link include/linux/skmsg.h:421 [inline]
       sock_map_del_link net/core/sock_map.c:158 [inline]
       sock_map_unref+0x3ac/0x5e0 net/core/sock_map.c:180
       sock_hash_delete_elem+0x27e/0x300 net/core/sock_map.c:943
       map_delete_elem+0x464/0x5e0 kernel/bpf/syscall.c:1696
       __sys_bpf+0x598/0x810 kernel/bpf/syscall.c:5622
       __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&psock->link_lock);
                               lock(&stab->lock);
                               lock(&psock->link_lock);
  lock(&stab->lock);

 *** DEADLOCK ***

4 locks held by syz-executor.4/12756:
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: map_delete_elem+0x388/0x5e0 kernel/bpf/syscall.c:1695
 #1: ffff88802b169b68 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff88802b169b68 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
 #2: ffff888045774290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff888045774290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
 #2: ffff888045774290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xcc/0x5e0 net/core/sock_map.c:180
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 1 PID: 12756 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-05221-gaae08491b943 #0
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
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __sock_map_delete net/core/sock_map.c:414 [inline]
 sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
 bpf_prog_174084c74af853ee+0x42/0x67
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x291/0x380 mm/slub.c:4396
 sk_psock_free_link include/linux/skmsg.h:421 [inline]
 sock_map_del_link net/core/sock_map.c:158 [inline]
 sock_map_unref+0x3ac/0x5e0 net/core/sock_map.c:180
 sock_hash_delete_elem+0x27e/0x300 net/core/sock_map.c:943
 map_delete_elem+0x464/0x5e0 kernel/bpf/syscall.c:1696
 __sys_bpf+0x598/0x810 kernel/bpf/syscall.c:5622
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f94ec87dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f94ed5410c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f94ec9abf80 RCX: 00007f94ec87dda9
RDX: 0000000000000020 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f94ec8ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f94ec9abf80 R15: 00007ffd0775a478
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

