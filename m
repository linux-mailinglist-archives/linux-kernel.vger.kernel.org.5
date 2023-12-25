Return-Path: <linux-kernel+bounces-10888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7681DE14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F07B1F21467
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1510EE;
	Mon, 25 Dec 2023 04:16:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686FEA4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35e6f4e17b6so37627925ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 20:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703477766; x=1704082566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFZYMuGXSX9qyUsYwn7NILHRxHw6duRXIuRRuwEKAEo=;
        b=XEyAtDJvhb3gPWYn42X0MdS7VeRRb9DRz6YXrRP3jVhSh5RUgwhCzZJprTY2MxcVai
         q8+/Sfu1bKAQUBzcAoaFVUa5H7VT/v2BVtKiJAjrQYEd1CqGuWMi6O6esQouu56CUsG3
         B7et2h3RwsZPBSgjqC/7sQXzHcVfsPU40769BoXerOZm1WMAdXbg0rQPmKkxEosZHnDM
         VyCKu+fciBQA4lNo5XxWD6zGVeLEcigW0gcPBXs7rnCpMag9q9ULque7DVZsiDPqXjRi
         fGXi9M7qYRh1NXplEcm+rnw4B/y9YBBMSfqHe7Li/v+rmX82oo/t7r6iBr53KvighbZh
         7GVA==
X-Gm-Message-State: AOJu0Yw5IBs362CwYUoN9IiPFKGTslU7xrga8t4z82hoTtvQCruCUaLl
	IRLpav0AKWNXAoNgIIsEYrVUu68xQ17r5ZMkiq0brL2uLlh2+eA=
X-Google-Smtp-Source: AGHT+IHYajdH6LL9JUWeAptu8DIywpOuIMOvdbTnw6iWrlNtN4Z3lbTghyDdxrCNkub1pFDfT1M4EJTquhuEmVPwxbpptaHNap5n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d13:b0:35f:f01e:bb25 with SMTP id
 i19-20020a056e021d1300b0035ff01ebb25mr366017ila.6.1703477765887; Sun, 24 Dec
 2023 20:16:05 -0800 (PST)
Date: Sun, 24 Dec 2023 20:16:05 -0800
In-Reply-To: <20231225035534.3699433-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e620e060d4dd33d@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
From: syzbot <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: corrupted stack end in reiserfs_file_release

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 5487 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00042-g88035e5694a8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 panic+0x6dc/0x790 kernel/panic.c:344
 schedule_debug kernel/sched/core.c:5930 [inline]
 __schedule+0x56be/0x5af0 kernel/sched/core.c:6581
 preempt_schedule_irq+0x52/0x90 kernel/sched/core.c:7008
 irqentry_exit+0x36/0x80 kernel/entry/common.c:432
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:memmove+0x54/0x1b0 arch/x86/lib/memmove_64.S:73
Code: 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 <4c> 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48
RSP: 0018:ffffc9000569ecf0 EFLAGS: 00000282
RAX: ffff88806b84e0c0 RBX: 0000000000000006 RCX: 0000000000000000
RDX: fffffffff8d30c58 RSI: ffff888072b1e2a0 RDI: ffff888072b1d340
RBP: 00000000000000c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000f18
R13: ffff8880719df028 R14: 0000000000000000 R15: ffff88806b84e0a8
 leaf_insert_into_buf+0x303/0xa30 fs/reiserfs/lbalance.c:933
 balance_leaf_new_nodes_insert fs/reiserfs/do_balan.c:1001 [inline]
 balance_leaf_new_nodes fs/reiserfs/do_balan.c:1243 [inline]
 balance_leaf+0x2ff4/0xcda0 fs/reiserfs/do_balan.c:1450
 do_balance+0x337/0x840 fs/reiserfs/do_balan.c:1888
 reiserfs_insert_item+0xadd/0xe20 fs/reiserfs/stree.c:2260
 indirect2direct+0x6d8/0xa20 fs/reiserfs/tail_conversion.c:283
 maybe_indirect_to_direct fs/reiserfs/stree.c:1585 [inline]
 reiserfs_cut_from_item+0xa82/0x1a10 fs/reiserfs/stree.c:1692
 reiserfs_do_truncate+0x672/0x10b0 fs/reiserfs/stree.c:1971
 reiserfs_truncate_file+0x1bf/0x940 fs/reiserfs/inode.c:2302
 reiserfs_file_release+0xae3/0xc40 fs/reiserfs/file.c:109
 __fput+0x270/0xbb0 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close fs/open.c:1575 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7eff5aa7ba9a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007fff479d5a90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007eff5aa7ba9a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000032 R08: 0000001b2e860000 R09: 00007eff5ab9bf8c
R10: 00007fff479d5be0 R11: 0000000000000293 R12: 00007eff5a6015a8
R13: ffffffffffffffff R14: 00007eff5a600000 R15: 0000000000014283
 </TASK>
Kernel Offset: disabled
----------------
Code disassembly (best guess):
   0:	00 48 81             	add    %cl,-0x7f(%rax)
   3:	fa                   	cli
   4:	a8 02                	test   $0x2,%al
   6:	00 00                	add    %al,(%rax)
   8:	72 05                	jb     0xf
   a:	40 38 fe             	cmp    %dil,%sil
   d:	74 47                	je     0x56
   f:	48 83 ea 20          	sub    $0x20,%rdx
  13:	48 83 ea 20          	sub    $0x20,%rdx
  17:	4c 8b 1e             	mov    (%rsi),%r11
  1a:	4c 8b 56 08          	mov    0x8(%rsi),%r10
  1e:	4c 8b 4e 10          	mov    0x10(%rsi),%r9
  22:	4c 8b 46 18          	mov    0x18(%rsi),%r8
  26:	48 8d 76 20          	lea    0x20(%rsi),%rsi
* 2a:	4c 89 1f             	mov    %r11,(%rdi) <-- trapping instruction
  2d:	4c 89 57 08          	mov    %r10,0x8(%rdi)
  31:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
  35:	4c 89 47 18          	mov    %r8,0x18(%rdi)
  39:	48 8d 7f 20          	lea    0x20(%rdi),%rdi
  3d:	73 d4                	jae    0x13
  3f:	48                   	rex.W


Tested on:

commit:         88035e56 Merge tag 'hid-for-linus-2023121201' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17b6fdc9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da
dashboard link: https://syzkaller.appspot.com/bug?extid=a3981d3c93cde53224be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178337a5e80000


