Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5E7FD4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjK2LG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjK2LGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:06:24 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FBD95
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:06:30 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6cbe14087c7so9233307b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701255990; x=1701860790;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNcMZRfK5zgSkYRxKm3IWkMVA602J70U7t3gF/kWgv4=;
        b=CmRSUNa9RUYE0zYH8FDo+znVSNFaOki6TDMGSHhrX8GRPe/BnbBxmb+fCLaXG3sWht
         /hzq6EjsMdSTfsRYiM+SzSYp9Sq3zG8dGv2rYfCpUQN3TqQR9lvq12QrOykDQdZ8+V4D
         NOqlsoSJcjeSWVdpQiDRN/zlaSfToy2fAM7SqUEN2gf3zfxbPYIdSUKIhIxhrTzvR4Y7
         tyBqmpzkrslDoMvJKcNIynFNyQrsa7Jw0BCFRmtH8yt/pNO3tCfpFk01lLQQu9xED11M
         08vSzc2GXjURs+bcpDIfXMy7yEdRP7uYu0WF83TbIp52Ui0O6LHk6qnxZ31xQFUKLvNY
         izxQ==
X-Gm-Message-State: AOJu0Yz2HoZr8T+F2z1wrbApJo7+z1WLZunhUkU1soanV13rEUsgqQBb
        7Sx2QclQU52PYt6UlP2j0thhHgwNNrrOmKy6ec4bJUWPT3u8
X-Google-Smtp-Source: AGHT+IHLfffse4jQx6iaFyv9C9sBzR07d1OYb6/VHpbXbAfl3ZqbHaYlCF1JQUmbinqk2/Pj5vL7v1xqWzSgyXkJlzUltP9FsDHe
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3929:b0:6c6:aaa4:5da8 with SMTP id
 fh41-20020a056a00392900b006c6aaa45da8mr5057045pfb.3.1701255989866; Wed, 29
 Nov 2023 03:06:29 -0800 (PST)
Date:   Wed, 29 Nov 2023 03:06:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2b6b0060b488674@google.com>
Subject: [syzbot] [net?] general protection fault in page_pool_unlist
From:   syzbot <syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com>
To:     almasrymina@google.com, davem@davemloft.net, edumazet@google.com,
        hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a379972973a8 Merge branch 'net-page_pool-add-netlink-based..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1421b7ece80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abf6d5a82dab01fe
dashboard link: https://syzkaller.appspot.com/bug?extid=f9f8efb58a4db2ca98d0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117d9e64e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16826ec4e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc5f22d6faa1/disk-a3799729.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e535e5c28162/vmlinux-a3799729.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32eefbbcadbb/bzImage-a3799729.xz

The issue was bisected to:

commit 083772c9f972dcc248913b52a0dec1025baa1e16
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Sun Nov 26 23:07:30 2023 +0000

    net: page_pool: record pools per netdev

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c72162e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12c72162e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c72162e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
Fixes: 083772c9f972 ("net: page_pool: record pools per netdev")

Illegal XDP return value 4294946546 on prog  (id 2) dev N/A, expect packet loss!
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5064 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkaller-00533-ga379972973a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 f0 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
FS:  000055555717a380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002555398 CR3: 0000000025044000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __page_pool_destroy net/core/page_pool.c:851 [inline]
 page_pool_release+0x507/0x6b0 net/core/page_pool.c:891
 page_pool_destroy+0x1ac/0x4c0 net/core/page_pool.c:956
 xdp_test_run_teardown net/bpf/test_run.c:216 [inline]
 bpf_test_run_xdp_live+0x1578/0x1af0 net/bpf/test_run.c:388
 bpf_prog_test_run_xdp+0x827/0x1530 net/bpf/test_run.c:1254
 bpf_prog_test_run kernel/bpf/syscall.c:4041 [inline]
 __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5402
 __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f616195a4a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe858ce5c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffe858ce798 RCX: 00007f616195a4a9
RDX: 0000000000000048 RSI: 0000000020000340 RDI: 000000000000000a
RBP: 00007f61619cd610 R08: 0000000000000000 R09: 00007ffe858ce798
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe858ce788 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 f0 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
FS:  000055555717a380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2640df1b10 CR3: 0000000025044000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 90 00 00 00    	jne    0xa2
  12:	4c 8b a3 f0 06 00 00 	mov    0x6f0(%rbx),%r12
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 68                	jne    0x98
  30:	48 85 ed             	test   %rbp,%rbp
  33:	49 89 2c 24          	mov    %rbp,(%r12)
  37:	74 24                	je     0x5d
  39:	e8 1b ca 07 f9       	call   0xf907ca59
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
