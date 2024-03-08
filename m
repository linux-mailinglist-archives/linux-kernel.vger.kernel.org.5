Return-Path: <linux-kernel+bounces-97014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6C87646A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C5D1C214AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D4717551;
	Fri,  8 Mar 2024 12:40:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BC84C84
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901605; cv=none; b=NEMAuQaFcyrvdorTd29PlwBSPVn9s+J9m96/qD+ggOANTNebwP+p+basTVex8vQ81SB8/ecj8iuVDr5gjmwzEZWjw2KXv+y1sEiHWBCg2as+XWJUqJASoX6WPWKF4XjH5lndvCeF2Q8RwYKX3sKZ20bcnbSPWCVD/p8XY1lU9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901605; c=relaxed/simple;
	bh=G6GhT8m5+RlAZ+ozZsQdTGycHfmiPolEyPuq/4H1bFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MNBlqTOm5vIubvYqSo762ioq11FrqSCN6x5DL5FotK0aIaMTiBnQz0pio1w2oNExUD2glx97sxA8dVy5emvx91ChGrS66miG2bpeCKQTpOwgk7Sy0aeLkrKJQcpTfOcTjfrvnMLuWugUHwkFgR7W4E6BQtrC1qTXM9PoyhljTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c882931b36so75073139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709901603; x=1710506403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYmx5uXWXOZOUP07zVZTbE5oqYsof65REjbRGDJW2zM=;
        b=bEos76LESz6jNnduXJZCngPL9/jiLz4Bf1Og9x/VeUyTf2cYU78rBbHlIIh2RgdDrH
         RfmjN8dD6xsgcBJULvhXmmMCbyxGsmzv/bkHiC5ddHSTwSYVicQ2iB7iG40fRl484gnm
         jGkeimMTbRl2dASa4UGaxKtDlw3kYanFDWxwbjv1Y/XWlGUkFiRHKU5WH8so2wPah4FC
         /NH1BiibF6ikb5yU6RBW77pyb1dxwtRf3ErZH+jaXN4NMzRxiRk7/SLFtyIbX5CLMq05
         gzaGSeq/rgi5K7IIzw99biiUc9sxu80fAMi3T3Wwfl4kVKLxjBEMa/UwabZD8MRjN4WU
         AS5w==
X-Forwarded-Encrypted: i=1; AJvYcCXl72TfPkXcoqXPGvpzVfiogI4d0+rBfmyEaMPhps0gUgv1MaEBoovemGminxZKAAPQxR6FRH0/zadwBDstN5FSm6AcMtJdQnctwvvn
X-Gm-Message-State: AOJu0YySiJM+ThapIxImpGlN+KWTGzNdOQ+3yLzSYcrOtvklaebGpuZS
	WAKjC/bLREXp6mqkUhBaYBYEZnl3zM7oHDmcqE+R/vqOcdKiT8z6K1lEeInvLm5MCe/AZDsCzhl
	hPE7BoRh07QMKFXoM86U2suApYoxuw6bFb7opKnqL8Tyza+nhUKoV3Rk=
X-Google-Smtp-Source: AGHT+IEVguIczZvEUZjENzotlTEtRFzXHUN9CcNEGd2xm2q8SNl8mqYpuP27LpRmkWmtz3pIKFxmOt/Um/C90QEpPgHhBVaXb7d4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b16:b0:475:402:bf4b with SMTP id
 fm22-20020a0566382b1600b004750402bf4bmr290687jab.2.1709901603216; Fri, 08 Mar
 2024 04:40:03 -0800 (PST)
Date: Fri, 08 Mar 2024 04:40:03 -0800
In-Reply-To: <20240308120930.1718-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a92e6c0613257d54@google.com>
Subject: Re: [syzbot] [usb] INFO: rcu detected stall in syscall_exit_to_user_mode
 (2)
From: syzbot <syzbot+a68ef3b1f46bc3aced5c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=11269, q=931 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10503 (4294959483-4294948980), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10504 jiffies! g11269 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26256 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_timeout+0x1bd/0x310 kernel/time/timer.c:2183
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 5641 Comm: syz-executor.3 Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 da 5c ff f5 48 89 df e8 92 9c 00 f6 e8 5d bc 28 f6 fb bf 01 00 00 00 <e8> 62 6d f2 f5 65 8b 05 e3 dd 91 74 85 c0 74 06 5b e9 71 40 00 00
RSP: 0018:ffffc9000b807c70 EFLAGS: 00000282
RAX: 6aefe969317ba800 RBX: ffff88802a6f9280 RCX: ffffffff94485303
RDX: dffffc0000000000 RSI: ffffffff8baab660 RDI: 0000000000000001
RBP: ffffc9000b807db0 R08: ffffffff8f856c2f R09: 1ffffffff1f0ad85
R10: dffffc0000000000 R11: fffffbfff1f0ad86 R12: 1ffff110054df2e3
R13: 000000001c000004 R14: 0000000000000021 R15: ffff88802a6f9718
FS:  00007f01503ec6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01503ebf00 CR3: 000000001b390000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 get_signal+0x156d/0x1850 kernel/signal.c:2896
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc8/0x360 kernel/entry/common.c:212
 do_syscall_64+0x108/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f014f62eae0
Code: 31 c0 e8 63 86 ff ff 48 8b 04 24 8b b0 80 00 00 00 85 f6 7e 0e 48 8d 3d 83 af 09 00 31 c0 e8 47 86 ff ff 48 8d 3d 9a ea 0b 00 <31> c0 e8 39 86 ff ff 48 83 c4 68 5b 5d 41 5c 41 5e c3 66 0f 1f 44
RSP: 002b:00007f01503ec0f0 EFLAGS: 00000246
RAX: 00007f014f7abf80 RBX: 0000000000000000 RCX: 00007f014f6d9aa6
RDX: 0000000000002da0 RSI: 0000000000000000 RDI: 00007f014f6ed57a
RBP: 00007f014f6d9aa6 R08: 0000000000000000 R09: 00007fffc81730b0
R10: 00007fffc8173080 R11: 0000000000005448 R12: 0000000000000000
R13: 000000000000000b R14: 00007f014f7abf80 R15: 00007fffc8124068
 </TASK>
sched: RT throttling activated


Tested on:

commit:         3aaa8ce7 Merge tag 'mm-hotfixes-stable-2024-03-07-16-1..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15293fde180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=165e1d0fff4d3c47
dashboard link: https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11892e86180000


