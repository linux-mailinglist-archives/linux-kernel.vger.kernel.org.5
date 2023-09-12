Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3067A79D379
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjILOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjILOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:22:55 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FE110
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:22:52 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-5779937c75dso1359189a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694528571; x=1695133371;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSNz2WpYWyCYaNCLR2IUNbrnYI9SS2k2mo7OjDMy6p8=;
        b=tvPJPqvKPQB5g2BWVJ1cRO5L0fx4oaW3QN8TMJI3Ezig7RwJmPhq2sXeAnldseqTPc
         6g3wqCLHF2WEBtE97h0FAIw3tmeER8PHdrivrDObyLn383ZUL0jvRKPmhFfZT9jcXR53
         61xyuHQCVZiQBMmRdugPR/Rkh3c3sQHUOMns/Zk9B1d0vZaiOpyE1wW1VmSpDv8MUoNF
         OOzouvZucf/S2IlU1ymJvfEAdNclbJyUuii8lLPbg+eO2XO36eq/6ZJslwQt3YllOK4e
         3wx/z7Y5OAsPrHnxfpuk64pfIoiACY5KdLSNYgdAWRZIC9P5bpCVqnvaaYhOemXvaLod
         C7gg==
X-Gm-Message-State: AOJu0YyneaPp6m4AG/mD694Byi4WVSrBIi3TPAEuBCJVoFpf/rPQSeBl
        wKeZIfcjrIViw+S0QN5wNdqT8cfdXhsGYEmudvEtXuSS81uZ
X-Google-Smtp-Source: AGHT+IGn9As6xFpKnJYyllc6F8dT08rEXP2JstLYVLsGQHt0PsbXXhRMYA8QnsZ6AwJ8cNnZkTakS69rLj+Brrim5OuTPXzat5jO
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:69d:b0:577:7e13:2353 with SMTP id
 ca29-20020a056a02069d00b005777e132353mr1231413pgb.0.1694528571403; Tue, 12
 Sep 2023 07:22:51 -0700 (PDT)
Date:   Tue, 12 Sep 2023 07:22:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f824606052a2d9b@google.com>
Subject: [syzbot] [kernel?] general protection fault in wpan_phy_register
From:   syzbot <syzbot+b8bf7edf9f83071ea0a9@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    73be7fb14e83 Merge tag 'net-6.6-rc1' of git://git.kernel.o..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1177350c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=b8bf7edf9f83071ea0a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1511afd0680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1603a2bfa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d81dec9a42c/disk-73be7fb1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d7e8b6b64be/vmlinux-73be7fb1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3061017eee2/bzImage-73be7fb1.xz

The issue was bisected to:

commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Aug 17 09:12:21 2023 +0000

    driver core: Return proper error code when dev_set_name() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125eed68680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=115eed68680000
console output: https://syzkaller.appspot.com/x/log.txt?x=165eed68680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8bf7edf9f83071ea0a9@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")

RBP: 00007ff31fd30380 R08: 00007ffc667bdc87 R09: 0000000000000140
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffc667bdf20 R14: 0000000000000003 R15: 000000000000000c
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5040 Comm: syz-executor838 Not tainted 6.5.0-syzkaller-12673-g73be7fb14e83 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 73 ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc900039ef160 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc900039ef1f0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc900039ef1f0
R13: 0000000000000cc0 R14: ffff88801c789600 R15: 0000000000000001
FS:  0000555556bb6380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001227608 CR3: 00000000769fe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 wpan_phy_register+0x33/0x160 net/ieee802154/core.c:146
 ieee802154_register_hw+0x716/0xa90 net/mac802154/main.c:239
 hwsim_add_one+0x683/0x1360 drivers/net/ieee802154/mac802154_hwsim.c:965
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:971
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2541
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2595
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2624
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff31fcb2ef9
Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc667bdee8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff31fcb2ef9
RDX: 0000000000000000 RSI: 0000000020001ac0 RDI: 0000000000000003
RBP: 00007ff31fd30380 R08: 00007ffc667bdc87 R09: 0000000000000140
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffc667bdf20 R14: 0000000000000003 R15: 000000000000000c
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 73 ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc900039ef160 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc900039ef1f0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc900039ef1f0
R13: 0000000000000cc0 R14: ffff88801c789600 R15: 0000000000000001
FS:  0000555556bb6380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001227608 CR3: 00000000769fe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	73 ac                	jae    0xffffffae
   2:	f7 48 8b 74 24 08 48 	testl  $0x48082474,-0x75(%rax)
   9:	8b 14 24             	mov    (%rsp),%edx
   c:	eb 89                	jmp    0xffffff97
   e:	90                   	nop
   f:	f3 0f 1e fa          	endbr64
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 89 fa             	mov    %rdi,%rdx
  20:	55                   	push   %rbp
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	53                   	push   %rbx
  26:	48 83 ec 10          	sub    $0x10,%rsp
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 04                	jg     0x3c
  38:	84 c0                	test   %al,%al
  3a:	75 51                	jne    0x8d
  3c:	0f b6 07             	movzbl (%rdi),%eax
  3f:	89                   	.byte 0x89


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
