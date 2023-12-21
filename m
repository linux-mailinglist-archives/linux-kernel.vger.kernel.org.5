Return-Path: <linux-kernel+bounces-8521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCE81B8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7C81C25DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE239634F2;
	Thu, 21 Dec 2023 13:47:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6F62815
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc70bd879so7808045ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703166445; x=1703771245;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYmbYzVzn7HByDk5oMybWEBz22Fnu+k+OJxHPDIIIyU=;
        b=MEIWU5zEzrdqLvfusCT17tzmm1lHqi98m9M0M6EC6U2c48RRvp0N90CFIkKQkVmTxV
         QYnGsG+vIkmuWexlawhmX1UDe6xOzW+c47rxQnDoqJaGLAfL7rL6qGJEd5JhwmXxjTV9
         lw0FFKB6wfJaZFPSlEuOXNn4H15nSOaNycmgIwBAZSge+lGblehaeOExtAwG/0G5QV++
         u8h9h+a1KfHmLOMu3pfrihUTTyyAZJGjmBbBrYbUgCjeLzrL1BWd4NYLo6ENGqQpzcxN
         KvQILObhDC2FWryAWFJs1WRxradimb22gca01HyrCnFoBUutaZWaJo3wAIrTWPZHABqz
         V4Rw==
X-Gm-Message-State: AOJu0YxlQJ16Ewip8NS2nCiwRPpU5IEhEOPq8+vzdI3JNR4VORIQ0pZa
	Jgf51LQ1BgjvwZfJEi2VDdtCrvNGPOeCviPKTbOnP2xY++IT
X-Google-Smtp-Source: AGHT+IF/2vojpFnrGrDoAXLRTBQ6gFgJPpEqk8mYaOExY+rl9+QrhqlBdnRDT91vV1uwKyDAWVF8pBNoSuKNg5NIiMN0cUSv2S1j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3885:b0:35f:d8db:338e with SMTP id
 cn5-20020a056e02388500b0035fd8db338emr59508ilb.4.1703166445079; Thu, 21 Dec
 2023 05:47:25 -0800 (PST)
Date: Thu, 21 Dec 2023 05:47:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3d57d060d0556a1@google.com>
Subject: [syzbot] [net?] WARNING: ODEBUG bug in advance_sched
From: syzbot <syzbot+ec9b5cce58002d184fb6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1a44b0073b92 Merge tag 'ovl-fixes-6.7-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ecdd9ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9b5cce58002d184fb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d5bc6ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1465cbd6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/56ceeac02b60/disk-1a44b007.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74fea7b7a52f/vmlinux-1a44b007.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3757dfd10a24/bzImage-1a44b007.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec9b5cce58002d184fb6@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff88801f9b1d00 object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 6703 at lib/debugobjects.c:514 debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 6703 Comm: syz-executor263 Not tainted 6.7.0-rc6-syzkaller-00044-g1a44b0073b92 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 4c 48 8b 14 dd a0 0c 2f 8b 41 56 4c 89 e6 48 c7 c7 00 00 2f 8b e8 b1 66 e5 fc 90 <0f> 0b 90 90 58 83 05 38 1c b1 0a 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc900001f0bd8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff814db519
RDX: ffff888022be3b80 RSI: ffffffff814db526 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8b2f06a0
R13: ffffffff8ace3260 R14: 0000000000000000 R15: ffff88801cc40ad0
FS:  0000555556866380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe6293cf2d0 CR3: 0000000028c3c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 debug_object_activate+0x327/0x490 lib/debugobjects.c:733
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common.constprop.0+0x2c/0x7a0 kernel/rcu/tree.c:2666
 switch_schedules net/sched/sch_taprio.c:210 [inline]
 advance_sched+0x59e/0xc60 net/sched/sch_taprio.c:984
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x203/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__sanitizer_cov_trace_switch+0x3b/0x90 kernel/kcov.c:341
Code: 53 48 8b 46 08 48 83 f8 20 74 63 77 44 48 83 f8 08 74 53 48 83 f8 10 75 2f 41 bd 03 00 00 00 4c 8b 75 00 31 db 4d 85 f6 74 1e <48> 8b 74 dd 10 4c 89 e2 4c 89 ef 48 83 c3 01 48 8b 4c 24 28 e8 2c
RSP: 0018:ffffc9000b956da0 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000000000006 RCX: ffffffff8139fcf5
RDX: ffff888022be3b80 RSI: 0000000000000007 RDI: 0000000000000001
RBP: ffffffff8ac9d140 R08: 0000000000000001 R09: 0000000000000007
R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000004
R13: 0000000000000001 R14: 0000000000000008 R15: ffffc9000b956e85
 unwind_next_frame+0x6b5/0x2390 arch/x86/kernel/unwind_orc.c:515
 arch_stack_walk+0xfa/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0xf8/0x350 mm/slub.c:3831
 kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:1015
 __kfree_skb net/core/skbuff.c:1073 [inline]
 consume_skb net/core/skbuff.c:1288 [inline]
 consume_skb+0xdf/0x170 net/core/skbuff.c:1282
 netlink_broadcast_filtered+0x3e3/0xf20 net/netlink/af_netlink.c:1554
 netlink_broadcast net/netlink/af_netlink.c:1576 [inline]
 nlmsg_multicast include/net/netlink.h:1090 [inline]
 nlmsg_notify+0x9e/0x220 net/netlink/af_netlink.c:2588
 qdisc_notify.isra.0+0x1cd/0x330 net/sched/sch_api.c:1030
 tc_modify_qdisc+0x914/0x1c40 net/sched/sch_api.c:1719
 rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6558
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe62934e759
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc987f8528 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007fe62934e759
RDX: 0000000004008000 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000100000000 R11: 0000000000000246 R12: 00007ffc987f8580
R13: 00000000000454f4 R14: 00007ffc987f854c R15: 0000000000000003
 </TASK>
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	48 8b 46 08          	mov    0x8(%rsi),%rax
   5:	48 83 f8 20          	cmp    $0x20,%rax
   9:	74 63                	je     0x6e
   b:	77 44                	ja     0x51
   d:	48 83 f8 08          	cmp    $0x8,%rax
  11:	74 53                	je     0x66
  13:	48 83 f8 10          	cmp    $0x10,%rax
  17:	75 2f                	jne    0x48
  19:	41 bd 03 00 00 00    	mov    $0x3,%r13d
  1f:	4c 8b 75 00          	mov    0x0(%rbp),%r14
  23:	31 db                	xor    %ebx,%ebx
  25:	4d 85 f6             	test   %r14,%r14
  28:	74 1e                	je     0x48
* 2a:	48 8b 74 dd 10       	mov    0x10(%rbp,%rbx,8),%rsi <-- trapping instruction
  2f:	4c 89 e2             	mov    %r12,%rdx
  32:	4c 89 ef             	mov    %r13,%rdi
  35:	48 83 c3 01          	add    $0x1,%rbx
  39:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  3e:	e8                   	.byte 0xe8
  3f:	2c                   	.byte 0x2c


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

