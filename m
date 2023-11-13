Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94697E9D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjKMNVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjKMNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:21:13 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9F7D7E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:21:09 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b79f5923b2so5441240a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881668; x=1700486468;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6F1WJvQUEU4zclPuJELxcIdtogjdaAQqBFzk3UxhQA=;
        b=YmOVcpp7DT1QhBywsFboYm/VRAD8HI9YNrjCglKqDK3WUWrYn4CNoIE/B4oDadNOFv
         xLo0QNtK+2W6tfS0aCo9rql1aTxQpBLdJ8KuokZyFwm/0b4jzyaBNGHmKKPKCBnyZhVo
         go2Y4Ikl+F6QxhcLt40bBs6dzYK9aTBep/Hj8rnNVNcVlOV9IwO763f+FH6PPrjUdkwW
         nGY5fPfqFqIl/yKVIG5NSpgxF7PDcNXbEHyTVr6KAuji5Rv69WYt6Azv1te4QthQ6AqQ
         ZdLOOfClwQu4Lvap0TcIA4o0f+unAYLrxe/lzIiLc3mp8+jCkUyqrSsLYfmsPeOFHJsk
         iY+A==
X-Gm-Message-State: AOJu0YyZwXwc4WDNjGK7xD3A1OT/bZ/QIAsWYhY2KbyPEf454y17cxKu
        HJgcXvLNUJ9z7lg/ITsUzhX7s8xrcIrVISMDIBXCw8i9ColMdX8=
X-Google-Smtp-Source: AGHT+IE4tCwkNMF0gF2lW9qmsGkWq7DbHOu36oT+ASc6Vjg7jdFtzEB8aJLA/iVuQqIrYxkbDefCkKvNZi8mGh3D0s2qEL7Y3Bhc
MIME-Version: 1.0
X-Received: by 2002:a63:e304:0:b0:5bd:d918:12ed with SMTP id
 f4-20020a63e304000000b005bdd91812edmr1695879pgh.9.1699881667998; Mon, 13 Nov
 2023 05:21:07 -0800 (PST)
Date:   Mon, 13 Nov 2023 05:21:07 -0800
In-Reply-To: <CA+LQOUezthX-RMbEiNUX7KnVZsHEYQOLpSYE6JyNddUvpMA-OQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb3b68060a088a68@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in sk_psock_verdict_data_ready
From:   syzbot <syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mukattreyee@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in sk_psock_verdict_data_ready

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 1c0b3067 P4D 1c0b3067 PUD 698e0067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8102 Comm: syz-executor.5 Not tainted 6.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000ae77868 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88801e9e6000 RCX: ffffffff88538a6f
RDX: 1ffff11003ba825c RSI: ffffffff88538a79 RDI: ffff88801e9e6000
RBP: 0000000000000004 R08: 0000000000000007 R09: 0000000000000000
R10: ffff88801dd41000 R11: 0000000000000000 R12: ffff88801dd41000
R13: 0000000000000000 R14: ffff88801e9e6000 R15: ffff88801e9e6000
FS:  00007f15c3c206c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000019717000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sk_psock_verdict_data_ready net/core/skmsg.c:1228 [inline]
 sk_psock_verdict_data_ready+0x207/0x3d0 net/core/skmsg.c:1208
 unix_dgram_sendmsg+0x11b3/0x1ca0 net/unix/af_unix.c:2116
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x2ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmmsg+0x1a1/0x450 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f15c2e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f15c3c200c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f15c2f9bf80 RCX: 00007f15c2e7cae9
RDX: 0000000000000002 RSI: 0000000020001680 RDI: 0000000000000003
RBP: 00007f15c2ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f15c2f9bf80 R15: 00007ffe1c491ce8
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000ae77868 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88801e9e6000 RCX: ffffffff88538a6f
RDX: 1ffff11003ba825c RSI: ffffffff88538a79 RDI: ffff88801e9e6000
RBP: 0000000000000004 R08: 0000000000000007 R09: 0000000000000000
R10: ffff88801dd41000 R11: 0000000000000000 R12: ffff88801dd41000
R13: 0000000000000000 R14: ffff88801e9e6000 R15: ffff88801e9e6000
FS:  00007f15c3c206c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000019717000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         b85ea95d Linux 6.7-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1573bc8f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e0ea92caaa75735
dashboard link: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
