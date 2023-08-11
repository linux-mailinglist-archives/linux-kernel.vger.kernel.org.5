Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1506B77911F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjHKN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjHKN5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:57:08 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0A830C1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:57:07 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-686b997cdeeso3197670b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691762226; x=1692367026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMlVZlWE/dk55GwzPGz9vyZlRIwuGqC03/tu4YFsQjI=;
        b=Zcs3b51zh+VN/ywtFK7WcAKcFXvZpE7sqNd+caGJDA1UvBMHQU0AH2ciFO94OS39dd
         Hb8td46kFizx5PT1ZriqX/XZlT1vZ2ZiorVIsa9b2OQsgvmCAefBOKIsWuzRuNY+N+3n
         Qrq8+zj8KJsdKIV3KuuumK9oSmEqgfWAz2hI9tMflTcBCRzXfn1+YN1ap86L8ROjr9n4
         R8liZSpMfYSWngn8Kv8Gk7ToYZBeNnhmzvNUNMgihZFSLVqiu/w5CmyYtUp0zhXdoS/9
         lQD1EGXc4qG60XIs3zgKrK5ADMyinrPiIHNgfBMj87iGsVEUVdcxbLL5AzhUMpD+EAjk
         Dw4Q==
X-Gm-Message-State: AOJu0YxSXnCWjYah39Qftb4U7svLoZG/NIHrEE5kszPsv/LitP+IZuBi
        zRMRVz1kGlXpZdvErdM+ImEfPJRa98t1lfG+oXBOCdJNrZsV
X-Google-Smtp-Source: AGHT+IG6qvjXDrmLcc0m+c3CgWdtNEHOO0UM8F4u6NBo7zESTPobXBABkVZttBKPsFMCMSP5QGh300ETRxFcWAjPEu3qIci3Umhn
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3a27:b0:687:94c2:106 with SMTP id
 fj39-20020a056a003a2700b0068794c20106mr833132pfb.5.1691762226631; Fri, 11 Aug
 2023 06:57:06 -0700 (PDT)
Date:   Fri, 11 Aug 2023 06:57:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090196d0602a6167d@google.com>
Subject: [syzbot] [net?] WARNING in unregister_vlan_dev
From:   syzbot <syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    048c796beb6e ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=122a53aba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=662f783a5cdf3add2719
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1604a23da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15261ffda80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf6b84b5998f/disk-048c796b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4000dee89ebe/vmlinux-048c796b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b700ee9bd306/bzImage-048c796b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5027 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Modules linked in:
CPU: 0 PID: 5027 Comm: syz-executor906 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Code: b4 1a 00 00 48 c7 c6 e0 18 81 8b 48 c7 c7 20 19 81 8b c6 05 ab 19 6c 06 01 e8 b4 22 23 f9 0f 0b e9 64 f7 ff ff e8 68 60 5c f9 <0f> 0b e9 3b f7 ff ff e8 fc 68 b0 f9 e9 fc ec ff ff 4c 89 e7 e8 4f
RSP: 0018:ffffc900039bfae0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000027f95e01 RCX: 0000000000000000
RDX: ffff88802d241dc0 RSI: ffffffff8829a7b8 RDI: 0000000000000001
RBP: ffff88807c680000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8a40008b R12: ffff888029882e80
R13: 0000000000000000 R14: 0000000000000002 R15: ffff888029882e80
FS:  0000555555f8f380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002800 CR3: 000000007f16b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unregister_netdevice_many net/core/dev.c:10906 [inline]
 unregister_netdevice_queue+0x2e5/0x3c0 net/core/dev.c:10786
 unregister_vlan_dev+0x2a9/0x580 net/8021q/vlan.c:118
 vlan_ioctl_handler+0x387/0xa80 net/8021q/vlan.c:627
 sock_ioctl+0x4b0/0x6e0 net/socket.c:1271
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f29480b4419
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb9d37898 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2948101390 RCX: 00007f29480b4419
RDX: 0000000020002800 RSI: 0000000000008982 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000555500000000 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007ffdb9d378e0
R13: 00007ffdb9d378b0 R14: 0000000000000001 R15: 00007ffdb9d378e0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
