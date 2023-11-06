Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D27E302B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjKFWwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjKFWwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:52:33 -0500
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B713D73
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:52:29 -0800 (PST)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1ef4782ef93so6191567fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311148; x=1699915948;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVjrZIYw052So8S0TQsLIpyybr5BKhUBF66hcLzozOo=;
        b=S4SE2b68e07nIGOWoC/KhJspZ2tNkizzMFh2jJYyGp05Wy1pc5JCIVG9Ve5XFZbKHR
         Fg6ekxHASFiB3Xj+jQDXBLKHVom0hlskL2XOCnQR7VetWoKhLDHf7+7SWeNXwgEMy02T
         a0xNAVV8HqRXbP4HI3f45B6fBP5UNipGL1It7gW1PVFKjcd7PW0m8mXcoi80Gn7J9jia
         B7QMVYTFRRgHKXICDxz60o0ukoAXEv9sbq/Rx6dh1fGr00Lx5ZKbDE7DynqwGd6geKB6
         njGEXt2xJJTt8OgDfyhVOqzXD8T7so3rxXs/znkgGm0aMfeR8UznURCn0nnjgPIpcJeF
         ZcVA==
X-Gm-Message-State: AOJu0Yzpp9y8cjEtvoBYopJ036giSN6V4zi1VrbNufv9zPv42uebRoAl
        54uvKSL267i6Y+74vxjJBqAmPHZS33mwvejeXUF2KGGSxbmj
X-Google-Smtp-Source: AGHT+IFB7j58wbrZ2aBYzqpaJqnn8TcbxJBmQW57UZjeYHqs+Co2g/njg3yP6/NN5ZjiNKR3Rt7IBifrhZbtUHazgg/BLO34ilyq
MIME-Version: 1.0
X-Received: by 2002:a05:6870:2199:b0:1e9:668b:7ba0 with SMTP id
 l25-20020a056870219900b001e9668b7ba0mr374170oae.4.1699311148403; Mon, 06 Nov
 2023 14:52:28 -0800 (PST)
Date:   Mon, 06 Nov 2023 14:52:28 -0800
In-Reply-To: <0000000000009e122006088a2b8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d11b8060983b5b7@google.com>
Subject: Re: [syzbot] [dccp?] general protection fault in dccp_write_xmit (2)
From:   syzbot <syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com>
To:     bragathemanick0908@gmail.com, davem@davemloft.net,
        dccp@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    d2f51b3516da Merge tag 'rtc-6.7' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16675f40e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd456c5e6582895e
dashboard link: https://syzkaller.appspot.com/bug?extid=c71bc336c5061153b502
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167ac787680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1799f190e80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d2f51b35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d678011e498e/vmlinux-d2f51b35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f6ed772923d/bzImage-d2f51b35.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 PID: 5345 Comm: syz-executor785 Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
RIP: 0010:dccp_write_xmit+0x66/0x1d0 net/dccp/output.c:356
Code: 00 48 85 c0 49 89 c4 0f 84 03 01 00 00 e8 82 5f cd f7 41 80 3e 00 0f 85 45 01 00 00 48 8b 9d f8 08 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 1f 01 00 00 48 8b 1b 48 8d bb b0 00 00 00 48
RSP: 0018:ffffc90003797870 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802a2bd000 RSI: ffffffff89ba330e RDI: ffff88802d7d9540
RBP: ffff88802d7d9540 R08: 0000000000000001 R09: fffffbfff23e11e9
R10: ffffffff91f08f4f R11: ffffffff915e5030 R12: ffff8880186c9cc0
R13: dffffc0000000000 R14: ffffed1005afb3c7 R15: ffff88802d7d9e38
FS:  00007f263ceef6c0(0000) GS:ffff88806b900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002980 CR3: 000000001b2ab000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dccp_sendmsg+0x968/0xcc0 net/dccp/proto.c:801
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:847
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x2ac/0x940 net/socket.c:2588
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2642
 __sys_sendmmsg+0x1a1/0x450 net/socket.c:2728
 __do_sys_sendmmsg net/socket.c:2757 [inline]
 __se_sys_sendmmsg net/socket.c:2754 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2754
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f263cf53559
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f263ceef218 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f263cfdd438 RCX: 00007f263cf53559
RDX: 0400000000000239 RSI: 0000000020002980 RDI: 0000000000000006
RBP: 00007f263cfdd430 R08: 00007fff5b335167 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f263cfdd43c
R13: 00007f263cfaa504 R14: 0400000000000239 R15: 00007fff5b335168
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
RIP: 0010:dccp_write_xmit+0x66/0x1d0 net/dccp/output.c:356
Code: 00 48 85 c0 49 89 c4 0f 84 03 01 00 00 e8 82 5f cd f7 41 80 3e 00 0f 85 45 01 00 00 48 8b 9d f8 08 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 1f 01 00 00 48 8b 1b 48 8d bb b0 00 00 00 48
RSP: 0018:ffffc90003797870 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802a2bd000 RSI: ffffffff89ba330e RDI: ffff88802d7d9540
RBP: ffff88802d7d9540 R08: 0000000000000001 R09: fffffbfff23e11e9
R10: ffffffff91f08f4f R11: ffffffff915e5030 R12: ffff8880186c9cc0
R13: dffffc0000000000 R14: ffffed1005afb3c7 R15: ffff88802d7d9e38
FS:  00007f263ceef6c0(0000) GS:ffff88806b900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002980 CR3: 000000001b2ab000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 85             	add    %cl,-0x7b(%rax)
   3:	c0 49 89 c4          	rorb   $0xc4,-0x77(%rcx)
   7:	0f 84 03 01 00 00    	je     0x110
   d:	e8 82 5f cd f7       	call   0xf7cd5f94
  12:	41 80 3e 00          	cmpb   $0x0,(%r14)
  16:	0f 85 45 01 00 00    	jne    0x161
  1c:	48 8b 9d f8 08 00 00 	mov    0x8f8(%rbp),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	0f 85 1f 01 00 00    	jne    0x154
  35:	48 8b 1b             	mov    (%rbx),%rbx
  38:	48 8d bb b0 00 00 00 	lea    0xb0(%rbx),%rdi
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
