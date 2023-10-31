Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2C7DCCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbjJaMEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjJaMEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:04:33 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CA55590
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:04:28 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3b2e7a8fbbdso7289081b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698753867; x=1699358667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wpJcbiTL0xJL6GMyqbrLywFGyvMuibD1Wk7yDfqWH8=;
        b=Fncgx3gsPUTKw9GpUgK8narid3awY+ZkUDKWaeIqeal/BFgmSib7T1IxpVQ/q7QqEM
         z1zVHW2OSO/uI94Tnvat/TsDeMxfsMQrBOJAHATdYxLYiR43Fgzv+z6iT1DTRb1cmYw5
         +Xy2egjCpZhqrfsDihd8/yz54CYmMUHs3Lk2OOSc1fOA5V7SMCW6N9/jJ1+nq0qRWSFC
         UIfgQzWNAyNEdV5WCvdWUdCBEenIoG/lo1Mot5oow3Rv34Ke4q9Ac0y7Gr48NURSPDMF
         gSImAeOeVbSXv0ZKtRhiwbLg0+uOKW9nS1HHyCyZOfPl+1CSMeokOf3obxcZFHhZqz5B
         Bcmw==
X-Gm-Message-State: AOJu0Yz3z4F6f8B3VDRKT+lYgiPzrLe7/R7oxnYCZ0Ntki90TaZr+cG6
        5a5nfp9LUGnr8FRUDdjEVMfNca71rz53jroEdpRQBAEd5DhJ
X-Google-Smtp-Source: AGHT+IECTl9BHc7Xo+eIDGD78FhZDF9tZPb8wtlq4b6kUyiccDDr8CFbxc3/vUMUV9xfIkAnk5UK3TkNRRiV4V7dKwW+YsxvLxPi
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23d1:b0:3b2:f33d:f22e with SMTP id
 bq17-20020a05680823d100b003b2f33df22emr4634894oib.0.1698753867758; Tue, 31
 Oct 2023 05:04:27 -0700 (PDT)
Date:   Tue, 31 Oct 2023 05:04:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9483d060901f460@google.com>
Subject: [syzbot] [perf?] general protection fault in inherit_task_group
From:   syzbot <syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com>
To:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c17cda15cc86 Merge tag 'net-6.6-rc8' of git://git.kernel.o..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=151ab177680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1f30869bb78ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=756fe9affda890e892ae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103b572b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143a82c3680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d47cb341912c/disk-c17cda15.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f37f0cf41858/vmlinux-c17cda15.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e256afecf3c3/bzImage-c17cda15.xz

The issue was bisected to:

commit 32671e3799ca2e4590773fd0e63aaa4229e50c06
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Oct 18 11:56:54 2023 +0000

    perf: Disallow mis-matched inherited group reads

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fdf71d680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fdf71d680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fdf71d680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com
Fixes: 32671e3799ca ("perf: Disallow mis-matched inherited group reads")

general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 0 PID: 5052 Comm: syz-executor420 Not tainted 6.6.0-rc7-syzkaller-00089-gc17cda15cc86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:inherit_group kernel/events/core.c:13375 [inline]
RIP: 0010:inherit_task_group.isra.0+0x248/0x5e0 kernel/events/core.c:13422
Code: 38 d0 7c 08 84 d2 0f 85 18 03 00 00 49 8d bf 8c 00 00 00 8b 9b 8c 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 eb
RSP: 0018:ffffc90003b1fa48 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000011 RSI: ffffffff81b0fbc9 RDI: 000000000000008c
RBP: ffff88801ce578a0 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff8a60008b R12: 0000000000000000
R13: ffff88807532bb80 R14: ffffc90003b1fae0 R15: 0000000000000000
FS:  00007f07e8df36c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f07e8df3fe8 CR3: 0000000078a1f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 perf_event_init_context kernel/events/core.c:13487 [inline]
 perf_event_init_task+0x330/0x740 kernel/events/core.c:13538
 copy_process+0x242c/0x73f0 kernel/fork.c:2475
 kernel_clone+0xfd/0x920 kernel/fork.c:2909
 __do_sys_clone+0xba/0x100 kernel/fork.c:3052
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f07e8e324d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f07e8df3228 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f07e8ebc308 RCX: 00007f07e8e324d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f07e8ebc300 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f07e8ebc30c
R13: 0000000000000016 R14: 00007ffca721dd10 R15: 00007ffca721ddf8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:inherit_group kernel/events/core.c:13375 [inline]
RIP: 0010:inherit_task_group.isra.0+0x248/0x5e0 kernel/events/core.c:13422
Code: 38 d0 7c 08 84 d2 0f 85 18 03 00 00 49 8d bf 8c 00 00 00 8b 9b 8c 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 eb
RSP: 0018:ffffc90003b1fa48 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000011 RSI: ffffffff81b0fbc9 RDI: 000000000000008c
RBP: ffff88801ce578a0 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff8a60008b R12: 0000000000000000
R13: ffff88807532bb80 R14: ffffc90003b1fae0 R15: 0000000000000000
FS:  00007f07e8df36c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f07e8e5ef20 CR3: 0000000078a1f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	38 d0                	cmp    %dl,%al
   2:	7c 08                	jl     0xc
   4:	84 d2                	test   %dl,%dl
   6:	0f 85 18 03 00 00    	jne    0x324
   c:	49 8d bf 8c 00 00 00 	lea    0x8c(%r15),%rdi
  13:	8b 9b 8c 00 00 00    	mov    0x8c(%rbx),%ebx
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 eb                	test   %ebp,%ebx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
