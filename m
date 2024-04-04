Return-Path: <linux-kernel+bounces-131793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9A898BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758211F22617
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277912B163;
	Thu,  4 Apr 2024 16:07:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446A12AAE0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246852; cv=none; b=RrxOT0tfqU6H3OEwXtbAw04fgJ4p01ga86Cd9puNJUYFBbzx/FZgA1mpLlqs6G/NKrTTKSuqQxI6s3mFZY8fAKVH5HaITQHl68ifVulucka3Xmc+IXoOxnuHV6J5FmfFlPwqpJNQcriQWlZGdA147qfpY25IQH262/uvE9nB80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246852; c=relaxed/simple;
	bh=hMsrU0MV/hxENKfm40nvfiZs3kucWCCykL/nLGFJclE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BGKwS36Hb9d63aRrQx7YE2L05SqSnCEVPDk1OoGsG/mtjibuYQIQ5LFXDMVETbS+A1pq/Lk9rYvNCq9Q9eqhTCMlEDQEkvzPNF2982pfc55u6ykAqnqcoAwcPS8EBamyczuICy5Rpr7w+GcF+LAZuBGFrLzyqWW3reFgxXzKD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso105230539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712246850; x=1712851650;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EPABN1JYCI6VYUF2JPssH24ZBTpGfA+zEJyxFNmFfc=;
        b=Q/+TVAUADLzsgiQShvsXw89blqW7L2vp5NlKrf6i/krM6+PLuEbyA7tF2gcqy4dKSG
         Zt+sDh3lEcUzc0BuGAPIDNYJr00iGCuRiSsDy5eLLBToo94iynUvIj3jD0tk3V1WMHWs
         QqhX70gN18zJsWcfXDZ/URCiB8T3RkTEo3RnGWQJBS8oGbrNFWxw8WMQ5uVRVUO5KTcU
         LOYrfvObDSh9hLTK1Aw7i2p+U7KE+DSFH9MKA9z+FhiAUmdJmxsc3pAN5J2WAxQzJwj9
         7mQHnWaQeCMAdPt9jO+0si5pBHv4r4NJCk/+QvgjN67vRxaqVPdnabiwL20aUjePGsn8
         5g2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHbVng3CgYNhyXQ5XJ/aV35B5jqEtHzNu0mE2VR37HR4mXUQf74pi2THlws0kpvSZEYSAFpUFNOoSzrOgcqhti9CVWzOEpuF7pQcke
X-Gm-Message-State: AOJu0Yz+8fWK0MWcL4hm6uoNf2funwAJdor1l0jTvC5BrPi6OPF9+8UN
	2Ga1i0MHfQEBzbkpYfRpcYtngUNC8gfavHFPk2h401RiwOFRc54PeyHXufjsXjg1+x6fvnmS6pj
	LPk8wR/98mkgf9KTBb+L8U3NP0bq1yGteuYuTZxGAxpVaSTS1gnDi7WY=
X-Google-Smtp-Source: AGHT+IGqkUIOTz7hJyga5lIBbhxYt4JBhTR6VSuPLW71bG26l6SpKSaryN5udw2PksoBpJXokXwXWODOPsf9eCVEpqbCbGgKId17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640e:b0:7cc:558:ee68 with SMTP id
 gn14-20020a056602640e00b007cc0558ee68mr4820iob.1.1712246849910; Thu, 04 Apr
 2024 09:07:29 -0700 (PDT)
Date: Thu, 04 Apr 2024 09:07:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041c9d406154789a4@google.com>
Subject: [syzbot] [net?] possible deadlock in unix_del_edges
From: syzbot <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b3d5988ae2c Add linux-next specific files for 20240404
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16c79d29180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c48fd2523cdee5e
dashboard link: https://syzkaller.appspot.com/bug?extid=7f7f201cc2668a8fd169
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

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
kworker/u8:8/2805 is trying to acquire lock:
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

4 locks held by kworker/u8:8/2805:
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3193 [inline]
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3299
 #1: ffffc9000a25fd00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3194 [inline]
 #1: ffffc9000a25fd00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3299
 #2: ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0xc5/0x1830 net/unix/garbage.c:547
 #3: ffff88802317e118 (rlock-AF_UNIX){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff88802317e118 (rlock-AF_UNIX){+.+.}-{2:2}, at: unix_collect_skb+0xb8/0x700 net/unix/garbage.c:343

stack backtrace:
CPU: 0 PID: 2805 Comm: kworker/u8:8 Not tainted 6.9.0-rc2-next-20240404-syzkaller #0
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
 unix_walk_scc_fast net/unix/garbage.c:533 [inline]
 __unix_gc+0x686/0x1830 net/unix/garbage.c:557
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
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

