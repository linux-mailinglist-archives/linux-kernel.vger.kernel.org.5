Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DF280EDAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbjLLNcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346522AbjLLNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:32:29 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC9B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:32:34 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fafbf42404so10710908fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387954; x=1702992754;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiUMOSfB7TGElnVi94lRD1/E9g74PJg+G3h2QqiiwOI=;
        b=Sw1WRpBBeTdmbshRDot6CeiGS4ytPiwbRHEBgLGvkDUg4irlz9hzb2V1ppAka+zMAN
         NYdTCTp3dxdcZmwGdQ00TM5lP2INfISeEWl5xHkVFSnBoeFke5UtoEbtE5Swp/0XEPHD
         0z3OMdaMZf0pwzpPUW5WTYK49g06wFDQBukiVTIDl2blxw11gXPo2VU4TqfiSlVWMIgv
         2iM3mI5GJ6IprbIUBY/H1TkmzpXGLei1ZhycVKiStAtpZ4rx+wy3VmjLEj7o76z/9MlM
         FbwtZRimCxU5WqZBA2efKyftC/pAw/LcvibgRenkwi+piOZxoyXUOZZ+gBBfa2NP23/I
         ifFg==
X-Gm-Message-State: AOJu0YzugkNkCMVjhUfu1fp9hWmykkanz9Jh+yun/kztdEZa+qC9mytY
        zCrxW4sXzelD/EFb4UP7mBysepEPHPb4eSbg1XaeB3iMolT2
X-Google-Smtp-Source: AGHT+IHrTgmlvePZwnuqOFL24bg77d58BohTmzPYbFFyGvj2SpG4Fmb2pmyqs+tIodgCwKtr5nfGWGbWEwKg3XGAX5uEN64Zk81A
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a44d:b0:1fa:da03:e9ec with SMTP id
 n13-20020a056870a44d00b001fada03e9ecmr7171013oal.10.1702387953700; Tue, 12
 Dec 2023 05:32:33 -0800 (PST)
Date:   Tue, 12 Dec 2023 05:32:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004017b3060c501517@google.com>
Subject: [syzbot] [kernel?] net-next test error: WARNING in rcu_check_gp_start_stall
From:   syzbot <syzbot+caa85c9208da01314296@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    36b0bdb6d330 Merge branch 'net-selftests-unique-namespace'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1317a8b6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8b9f7eef8021c3a
dashboard link: https://syzkaller.appspot.com/bug?extid=caa85c9208da01314296
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2203b492b321/disk-36b0bdb6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94047f2e6d6b/vmlinux-36b0bdb6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a4bb64744b6/bzImage-36b0bdb6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+caa85c9208da01314296@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 48 at kernel/rcu/tree_stall.h:990 rcu_check_gp_start_stall.part.0+0x1c4/0x4b0 kernel/rcu/tree_stall.h:990
Modules linked in:
CPU: 0 PID: 48 Comm: kworker/u4:3 Not tainted 6.7.0-rc4-syzkaller-00835-g36b0bdb6d330 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:rcu_check_gp_start_stall.part.0+0x1c4/0x4b0 kernel/rcu/tree_stall.h:990
Code: 88 5d 01 00 00 be 04 00 00 00 48 c7 c7 c0 6a 80 92 e8 e0 57 6d 00 b8 01 00 00 00 87 05 d5 48 0f 11 85 c0 0f 85 39 01 00 00 90 <0f> 0b 90 48 81 fd c0 6f fb 8c 48 c7 c3 f8 2e 19 8f 74 5a 48 b8 00
RSP: 0018:ffffc90000007df0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000002904 RCX: ffffffff817121e0
RDX: fffffbfff2500d58 RSI: 0000000000000004 RDI: ffffffff92806ac0
RBP: ffffffff8cfb6fc0 R08: 0000000000000001 R09: fffffbfff2500d58
R10: 0000000000000003 R11: 0000000000000005 R12: 1ffffffff1981e40
R13: 0000000000000246 R14: ffffffff8cfb6fc0 R15: ffff8880b983d612
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005625fd4c8000 CR3: 000000000cd77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rcu_check_gp_start_stall kernel/rcu/tree_stall.h:953 [inline]
 rcu_core+0x4e1/0x1680 kernel/rcu/tree.c:2426
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__sanitizer_cov_trace_pc+0x34/0x60 kernel/kcov.c:207
Code: bc 03 00 65 8b 05 f4 26 7c 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74 35 8b 82 fc 15 00 00 85 c0 74 2b 8b 82 d8 15 00 00 <83> f8 02 75 20 48 8b 8a e0 15 00 00 8b 92 dc 15 00 00 48 8b 01 48
RSP: 0018:ffffc90000b8f928 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff8880b9941a60 RCX: ffffffff817bd538
RDX: ffff8880136ebb80 RSI: ffffffff817bd512 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffffed101732834d
R13: 0000000000000001 R14: ffff8880b9941a68 R15: ffff8880b983d8c0
 rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]
 cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]
 csd_lock_wait kernel/smp.c:311 [inline]
 smp_call_function_many_cond+0x4e2/0x1550 kernel/smp.c:855
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2006 [inline]
 text_poke_bp_batch+0x22b/0x750 arch/x86/kernel/alternative.c:2216
 text_poke_flush arch/x86/kernel/alternative.c:2407 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2404 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2414
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate mm/kfence/core.c:830 [inline]
 toggle_allocation_gate+0xf4/0x250 mm/kfence/core.c:822
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
----------------
Code disassembly (best guess):
   0:	bc 03 00 65 8b       	mov    $0x8b650003,%esp
   5:	05 f4 26 7c 7e       	add    $0x7e7c26f4,%eax
   a:	a9 00 01 ff 00       	test   $0xff0100,%eax
   f:	48 8b 34 24          	mov    (%rsp),%rsi
  13:	74 0f                	je     0x24
  15:	f6 c4 01             	test   $0x1,%ah
  18:	74 35                	je     0x4f
  1a:	8b 82 fc 15 00 00    	mov    0x15fc(%rdx),%eax
  20:	85 c0                	test   %eax,%eax
  22:	74 2b                	je     0x4f
  24:	8b 82 d8 15 00 00    	mov    0x15d8(%rdx),%eax
* 2a:	83 f8 02             	cmp    $0x2,%eax <-- trapping instruction
  2d:	75 20                	jne    0x4f
  2f:	48 8b 8a e0 15 00 00 	mov    0x15e0(%rdx),%rcx
  36:	8b 92 dc 15 00 00    	mov    0x15dc(%rdx),%edx
  3c:	48 8b 01             	mov    (%rcx),%rax
  3f:	48                   	rex.W


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
