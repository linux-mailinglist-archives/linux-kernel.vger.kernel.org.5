Return-Path: <linux-kernel+bounces-11565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54381E83E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE231283104
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399884F605;
	Tue, 26 Dec 2023 15:59:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737664EB5E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fcbbd1dbaso59298035ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 07:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703606358; x=1704211158;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XAHfzCY2l4/t5LyLZa95F6bjsF+rh1JT6QeBJ4CZyQ=;
        b=Krd8CdS+KYjojHIlQAkVgx0J6kvyGQv0+59x+r2iVjhY6CEoRKSPWyWP8nNTMBfefQ
         HT8hFepDokWeudUbh2Ge2imnXvyajObOO2nXqL4YfdY02eEvYuJCqsxB2gAFzTyV4vOZ
         hjthM5MFLNRhsXS+QiDZgApUXBs5BoiFeMg/x+GovQovPHyIx3FatP/+AYKy5SLapgQs
         V9PVkGSKmT7JOUdkKjvWzXY0rbW+qSFjpVCRhaYiuxOullyaYXBFUefa/yua8DnJtrVU
         nXU6VIEnieyuEaROQxpP5aNvs5QEDUaC2wUOWpuEL8i3z8tkQT/JdKEfLhGLYFzot7IY
         ASNQ==
X-Gm-Message-State: AOJu0YzXwFZfy5YstvVKqkc+JLatP4SH9fMwKGT4CW6EZ94LxNJqux0O
	WpZz/MXfAkqB+URK7B1Ocuz4uEpnPRGRZgc0PbIqQ9q/D8HP
X-Google-Smtp-Source: AGHT+IEtumes5QgYFtPVtRktd3AiKw9U4mnm5yC+ORzoy9/rTFylOSEDWtwqYC6KJ9GiAYGjc2kFZVfEGZieciISIxGojetOWLiU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b48:b0:360:ba:613d with SMTP id
 f8-20020a056e020b4800b0036000ba613dmr527989ilu.3.1703606358551; Tue, 26 Dec
 2023 07:59:18 -0800 (PST)
Date: Tue, 26 Dec 2023 07:59:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6b55e060d6bc390@google.com>
Subject: [syzbot] [kernel?] KMSAN: uninit-value in profile_hits (3)
From: syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, ebiederm@xmission.com, glider@google.com, 
	linux-kernel@vger.kernel.org, paskripkin@gmail.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1978a14f70af x86: kmsan: enable KMSAN builds for x86
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13b7a95b700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d830111cc3be873
dashboard link: https://syzkaller.appspot.com/bug?extid=b1a83ab2a9eb9321fbdd
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b5476b700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142c9237700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in do_profile_hits kernel/profile.c:236 [inline]
BUG: KMSAN: uninit-value in profile_hits+0xaf2/0x1260 kernel/profile.c:326
 do_profile_hits kernel/profile.c:236 [inline]
 profile_hits+0xaf2/0x1260 kernel/profile.c:326
 profile_hit include/linux/profile.h:58 [inline]
 profile_tick+0x241/0x250 kernel/profile.c:336
 tick_sched_handle kernel/time/tick-sched.c:227 [inline]
 tick_sched_timer+0x4bd/0x610 kernel/time/tick-sched.c:1428
 __run_hrtimer+0x49f/0xc50 kernel/time/hrtimer.c:1685
 __hrtimer_run_queues kernel/time/hrtimer.c:1749 [inline]
 hrtimer_interrupt+0x7f7/0x2100 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x178/0x5e0 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x9d/0xc0 arch/x86/kernel/apic/apic.c:1097
 asm_sysvec_apic_timer_interrupt+0x12/0x20
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irq+0x36/0x60 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:399 [inline]
 __set_current_blocked+0xb0c/0xb90 kernel/signal.c:3051
 sigprocmask kernel/signal.c:3085 [inline]
 __do_sys_rt_sigprocmask kernel/signal.c:3162 [inline]
 __se_sys_rt_sigprocmask+0x438/0x5b0 kernel/signal.c:3145
 __x64_sys_rt_sigprocmask+0x11e/0x170 kernel/signal.c:3145
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Local variable iter.i created at:
 new_sync_read fs/read_write.c:393 [inline]
 vfs_read+0xb8a/0x1980 fs/read_write.c:481
 ksys_read+0x28b/0x510 fs/read_write.c:619

CPU: 1 PID: 3474 Comm: sshd Not tainted 5.17.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

