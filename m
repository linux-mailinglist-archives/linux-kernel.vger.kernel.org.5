Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494C87AA7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjIVE3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVE2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:28:54 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C7196
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:28:46 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1d6565a7ce9so2391396fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695356925; x=1695961725;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPO2fI1/Ftsfq47e8QVsyKayuI4L6mHkklt+nPn7UwE=;
        b=Y8vPoEQJ+mhg298ffN04yZKd21eBcOzGYnVz+mlqHHZ8KQpcDMNtUNWrz8YI9I/NzL
         yW+N8kPH9LGs485AvzGh+V6qsJySZdJk3e6ZLOqE2CLrUg7y61sUxWzD6qA6PoNSuCY9
         MC1zU3nFI4cdcHfSxOVj78d4jF/fKmUgYW5jzI4EP9r7wOAck2PGovcD6r34DLp994G0
         fsSPMo2zwIHex1Hs3RsgHDnSdAxA+lQtK5z/a1OQqxq/7Fgv6/xn/8wHe8XWORgqhNc6
         TckzxHDy0fFTofzLeyLCsGrZSf60dPhXtYzk7gujLWtdSaYv0g/1geTwpjTfv5edKYhz
         6rUQ==
X-Gm-Message-State: AOJu0Yz5vbjQMuLZVxMFlTM7aV/A1E4o9i+sjEVN0XfSvA3jVt4Wm+4r
        UYUSN1IfYNHMtpk2z3b1E9SKyVhgM/7ldgtAA96KXHxQAeCp
X-Google-Smtp-Source: AGHT+IF/EvjpKtQwwuVYTSk2T7+yx/88EpM047XHyBFXTXk8pgocngMLyvcaMvxKOhUCQ12PNKnokT7wuDuVIMoiF/WTkeRuGjuO
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c7af:b0:1bf:51f7:b5b4 with SMTP id
 dy47-20020a056870c7af00b001bf51f7b5b4mr2919232oab.7.1695356925779; Thu, 21
 Sep 2023 21:28:45 -0700 (PDT)
Date:   Thu, 21 Sep 2023 21:28:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005426680605eb0b9f@google.com>
Subject: [syzbot] [net?] WARNING in skb_warn_bad_offload (4)
From:   syzbot <syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com>
To:     andrew@daynix.com, davem@davemloft.net, edumazet@google.com,
        jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    25041a4c02c7 Merge tag 'net-6.4-rc6' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=120a16dd280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=c99d835ff081ca30f986
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15808795280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17de0463280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e8d60d638d1/disk-25041a4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4a1a9057ac2/vmlinux-25041a4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66efccc5227d/bzImage-25041a4c.xz

The issue was bisected to:

commit 860b7f27b8f78564ca5a2f607e0820b2d352a562
Author: Andrew Melnychenko <andrew@daynix.com>
Date:   Wed Dec 7 11:35:57 2022 +0000

    linux/virtio_net.h: Support USO offload in vnet header.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12544729a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11544729a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16544729a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet header.")

skb linear:   000000f0: 00 00 00 00 00 00 65 72 73 70 61 6e 30 00 00 00
skb linear:   00000100: 00 00 00 00 00 00 05 00 00 00 00 00 00 00 00 00
skb linear:   00000110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
------------[ cut here ]------------
erspan0: caps=(0x0000000000006869, 0x0000000000000000)
WARNING: CPU: 0 PID: 5002 at net/core/dev.c:3228 skb_warn_bad_offload+0x119/0x230 net/core/dev.c:3228
Modules linked in:
CPU: 0 PID: 5002 Comm: syz-executor416 Not tainted 6.4.0-rc5-syzkaller-00133-g25041a4c02c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:skb_warn_bad_offload+0x119/0x230 net/core/dev.c:3228
Code: 70 03 00 00 e8 18 96 76 f9 4c 8d a5 f0 00 00 00 e8 0c 96 76 f9 4c 89 e9 4c 89 e2 4c 89 f6 48 c7 c7 00 36 5e 8b e8 d7 51 3e f9 <0f> 0b 5b 5d 41 5c 41 5d 41 5e e9 e8 95 76 f9 e8 e3 95 76 f9 48 89
RSP: 0018:ffffc90003a5f6b0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88807b7ac000 RCX: 0000000000000000
RDX: ffff88802176bb80 RSI: ffffffff814c03b7 RDI: 0000000000000001
RBP: ffff88802c452000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88802c4520f0
R13: ffff88807b7ac370 R14: ffff88802c452000 R15: 000000000000000e
FS:  0000555557281300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 00000000758bf000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __skb_gso_segment+0x3eb/0x6e0 net/core/dev.c:3404
 skb_gso_segment include/linux/netdevice.h:4862 [inline]
 validate_xmit_skb+0x69c/0xef0 net/core/dev.c:3659
 validate_xmit_skb_list+0xc0/0x130 net/core/dev.c:3709
 sch_direct_xmit+0x3d5/0xc30 net/sched/sch_generic.c:327
 __dev_xmit_skb net/core/dev.c:3805 [inline]
 __dev_queue_xmit+0x14d6/0x3b10 net/core/dev.c:4210
 dev_queue_xmit include/linux/netdevice.h:3088 [inline]
 packet_xmit+0x260/0x390 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0x347f/0x5030 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 __sys_sendto+0x23a/0x340 net/socket.c:2144
 __do_sys_sendto net/socket.c:2156 [inline]
 __se_sys_sendto net/socket.c:2152 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2152
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0c72415529
Code: 28 c3 e8 4a 15 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe61bb6468 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007ffe61bb6488 RCX: 00007f0c72415529
RDX: 0000000000002378 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000000002ff
R10: 0000000004000002 R11: 0000000000000246 R12: 00007ffe61bb6490
R13: 00007ffe61bb64b0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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
