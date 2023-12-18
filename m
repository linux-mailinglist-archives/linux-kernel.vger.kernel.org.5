Return-Path: <linux-kernel+bounces-2915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53625816429
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8971F21EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D683D64;
	Mon, 18 Dec 2023 01:47:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58863C16
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fb2956a35so2390785ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702864023; x=1703468823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yA9fiHLtjKBEcttMO0suWCiJB53t2Vlc/bTqIB3B3H4=;
        b=e9xSrFSq21qy3SyyTdkBH7KbZezAozAgZtgIaBKYKaJVNHh+3PmJcgRIJw+2SVXqu0
         7/hvzOlmVkd+Ac+Y9ciCwOMQKJ1F0UdkIePBxpPVjB2jCaW/fVu43kfmfG6RvFOCHJBt
         OnMvACExSCI38VZx9rqPo/YJTW0G6gSti2OuEnvt/kRX80gw0PZ9gNPSdnGtaY3Mm2p1
         lE0w8CYQlZvizrUmzIntAq3QfVeOWGLRB66RjQKs9C3sEj2yHrVUapL0sFdfYPE7XWk/
         NMbDvA06KYZ1PKX90dHYVAk9xhM+F+5XXsDuNlZZ7MLroMdLDabsjVH3Har8Z5kD2aT5
         7E5g==
X-Gm-Message-State: AOJu0YyZxBo/ft+XQqgvISM2wNmwg6zJbhT8F9j1mKjIOGbSAxlWt2wL
	cev/DHFpJ1C9gbSMH/P/5IY8jS7E3yTyjW2Wdp+Te/tL1CrH6Pk=
X-Google-Smtp-Source: AGHT+IF9jUaQvuRhxmhsXhOdloVPzs3rTh3QEsW0u6geRS0SajRvzm9j9dCzlwXN2UaQUKvL1M5+9CzxxsQRfvExDD+UGzQa4lNN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d147:0:b0:35d:6c12:a6e4 with SMTP id
 t7-20020a92d147000000b0035d6c12a6e4mr640391ilg.1.1702864022928; Sun, 17 Dec
 2023 17:47:02 -0800 (PST)
Date: Sun, 17 Dec 2023 17:47:02 -0800
In-Reply-To: <20231218011343.1782210-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003004b4060cbeed18@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
From: syzbot <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in mac80211_hwsim_netlink_notify

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5405 Comm: udevd Not tainted 6.7.0-rc5-syzkaller-00042-g88035e5694a8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:remove_user_radios drivers/net/wireless/virtual/mac80211_hwsim.c:6195 [inline]
RIP: 0010:mac80211_hwsim_netlink_notify+0x1fb/0x8e0 drivers/net/wireless/virtual/mac80211_hwsim.c:6221
Code: 8b ab 94 2c 00 00 8b 3c 24 44 89 ee e8 3e 65 2e fb 44 39 2c 24 0f 84 a2 03 00 00 e8 3f 6a 2e fb 48 89 e8 49 89 ef 48 c1 e8 03 <42> 80 3c 20 00 0f 85 5b 05 00 00 48 81 fd 00 43 0f 8e 48 8b 45 00
RSP: 0018:ffffc90004d8f850 EFLAGS: 00010256
RAX: 0000000000000000 RBX: ffff888073793040 RCX: ffffffff8659238e
RDX: ffff888021b38000 RSI: ffffffff865923e1 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90004d8f898 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000cd77000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 blocking_notifier_call_chain kernel/notifier.c:388 [inline]
 blocking_notifier_call_chain+0x69/0x90 kernel/notifier.c:376
 netlink_release+0x1835/0x1ff0 net/netlink/af_netlink.c:795
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2ae0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 get_signal+0x23be/0x2790 kernel/signal.c:2904
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0965ebe3cd
Code: Unable to access opcode bytes at 0x7f0965ebe3a3.
RSP: 002b:00007ffd49acfb40 EFLAGS: 00000246 ORIG_RAX: 00000000000000ea
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f0965ebe3cd
RDX: 0000000000000006 RSI: 000000000000151d RDI: 000000000000151d
RBP: 000000000000151d R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000006
R13: 00007ffd49acfd50 R14: 0000000000001000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:remove_user_radios drivers/net/wireless/virtual/mac80211_hwsim.c:6195 [inline]
RIP: 0010:mac80211_hwsim_netlink_notify+0x1fb/0x8e0 drivers/net/wireless/virtual/mac80211_hwsim.c:6221
Code: 8b ab 94 2c 00 00 8b 3c 24 44 89 ee e8 3e 65 2e fb 44 39 2c 24 0f 84 a2 03 00 00 e8 3f 6a 2e fb 48 89 e8 49 89 ef 48 c1 e8 03 <42> 80 3c 20 00 0f 85 5b 05 00 00 48 81 fd 00 43 0f 8e 48 8b 45 00
RSP: 0018:ffffc90004d8f850 EFLAGS: 00010256

RAX: 0000000000000000 RBX: ffff888073793040 RCX: ffffffff8659238e
RDX: ffff888021b38000 RSI: ffffffff865923e1 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90004d8f898 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000cd77000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	8b ab 94 2c 00 00    	mov    0x2c94(%rbx),%ebp
   6:	8b 3c 24             	mov    (%rsp),%edi
   9:	44 89 ee             	mov    %r13d,%esi
   c:	e8 3e 65 2e fb       	call   0xfb2e654f
  11:	44 39 2c 24          	cmp    %r13d,(%rsp)
  15:	0f 84 a2 03 00 00    	je     0x3bd
  1b:	e8 3f 6a 2e fb       	call   0xfb2e6a5f
  20:	48 89 e8             	mov    %rbp,%rax
  23:	49 89 ef             	mov    %rbp,%r15
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 5b 05 00 00    	jne    0x590
  35:	48 81 fd 00 43 0f 8e 	cmp    $0xffffffff8e0f4300,%rbp
  3c:	48 8b 45 00          	mov    0x0(%rbp),%rax


Tested on:

commit:         88035e56 Merge tag 'hid-for-linus-2023121201' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14d3d969e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da
dashboard link: https://syzkaller.appspot.com/bug?extid=a3981d3c93cde53224be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a9b876e80000


