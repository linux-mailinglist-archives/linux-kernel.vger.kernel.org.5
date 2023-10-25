Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAFA7D7389
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJYSsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjJYSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:48:04 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57702133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:48:02 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6ce29652abaso55813a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259681; x=1698864481;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enekH0kmAY2hDmPuxAiuuGFjnISGBg+lcc1EKA1WVr8=;
        b=cgYCYDqvURPerRsQAGIFANIbVtt52f30PyMMBzodcUgXl63FXbAdA6DgtZLwnUan/7
         FP2RuV/gKcjyH6dkgbLYCcNW3B5e6lEgqhH52pnFi+kIfoXyApsAsV+GLW51y0nnRgEk
         DsJLPNXapqS1tOiya/gNAfD35GZYEg3Qw9Gx9sPUWvySXc5KEpI1jQefy5pjeRlBCy3X
         jjQMDgJWi9tV8LBRtmoagdwBjPLwNvZ8N6pKdV5hNuvUUaWkETiJJAElvGL2O/fWbjR8
         BI6pw+DDn5JPzsfI1DbA0MZeIqMFTs7YO8m2RgFg4yfCs3F7iyq5nqPDbS0nSjV4Cifs
         xVSw==
X-Gm-Message-State: AOJu0Yz0QCiQE9S6eCf2FIr2iXCjAbNxztoLROvsBRaZKlQcI3rM92VU
        CAnSAFayOR/GU6XYiOyOgHfGz9wtetesTuBBji/1aaMIYPBq
X-Google-Smtp-Source: AGHT+IHVcSLF8wX+G3zJ0MdiID25mT3cqEIYRiD7J1wepM6gbCS0Gq+9Fyh9RzOLK5wuMyYHnxQaa+RmvHvuls7DZJt723EGkjzp
MIME-Version: 1.0
X-Received: by 2002:a9d:63d9:0:b0:6c8:f9bc:f768 with SMTP id
 e25-20020a9d63d9000000b006c8f9bcf768mr4527702otl.1.1698259681666; Wed, 25 Oct
 2023 11:48:01 -0700 (PDT)
Date:   Wed, 25 Oct 2023 11:48:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fed5606088ee598@google.com>
Subject: [syzbot] [mptcp?] WARNING in subflow_data_ready
From:   syzbot <syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martineau@kernel.org,
        matthieu.baerts@tessares.net, matttbe@kernel.org,
        mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9c5d00cb7b6b Merge tag 'perf-tools-fixes-for-v6.6-2-2023-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123fbacd680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=530f7d8ed0a57417
dashboard link: https://syzkaller.appspot.com/bug?extid=c53d4d3ddb327e80bc51
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8423b244df95/disk-9c5d00cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aaee5e776b7e/vmlinux-9c5d00cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11fb49db00f3/bzImage-9c5d00cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 18534 at net/mptcp/subflow.c:1405 subflow_data_ready+0x39f/0x4e0 net/mptcp/subflow.c:1405
Modules linked in:
CPU: 1 PID: 18534 Comm: syz-executor.2 Not tainted 6.6.0-rc6-syzkaller-00285-g9c5d00cb7b6b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:subflow_data_ready+0x39f/0x4e0 net/mptcp/subflow.c:1405
Code: 18 89 ee e8 a3 80 62 f7 40 84 ed 75 1f e8 69 85 62 f7 44 89 f6 bf 07 00 00 00 e8 cc 80 62 f7 41 83 fe 07 74 07 e8 51 85 62 f7 <0f> 0b e8 4a 85 62 f7 48 89 df e8 02 b2 ff ff 31 ff 89 c5 89 c6 e8
RSP: 0000:ffffc90015aff3a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88807c2e9880 RCX: 0000000000000100
RDX: ffff88801f458000 RSI: ffffffff8a25449f RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
R10: 000000000000000b R11: ffffffff88331ae6 R12: 1ffff92002b5fe75
R13: ffff8880208d0a00 R14: 000000000000000b R15: ffff88802e60af00
FS:  0000555556c8e480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7455279b13 CR3: 000000007899e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tcp_data_ready+0x14c/0x5b0 net/ipv4/tcp_input.c:5034
 tcp_data_queue+0x25fc/0x4f10 net/ipv4/tcp_input.c:5114
 tcp_rcv_state_process+0x1871/0x4d00 net/ipv4/tcp_input.c:6728
 tcp_v4_do_rcv+0x346/0x9e0 net/ipv4/tcp_ipv4.c:1751
 tcp_v4_rcv+0x33a9/0x3b40 net/ipv4/tcp_ipv4.c:2151
 ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x2e4/0x510 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:304 [inline]
 NF_HOOK include/linux/netfilter.h:298 [inline]
 ip_local_deliver+0x1b6/0x550 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:468 [inline]
 ip_rcv_finish+0x1c4/0x2e0 net/ipv4/ip_input.c:449
 NF_HOOK include/linux/netfilter.h:304 [inline]
 NF_HOOK include/linux/netfilter.h:298 [inline]
 ip_rcv+0xc9/0x430 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5552
 __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5666
 process_backlog+0x101/0x6b0 net/core/dev.c:5994
 __napi_poll.constprop.0+0xb4/0x530 net/core/dev.c:6556
 napi_poll net/core/dev.c:6623 [inline]
 net_rx_action+0x956/0xe90 net/core/dev.c:6756
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x47/0xc0 arch/x86/kernel/apic/apic.c:1074
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0033:0x7f50c2238602
Code: 48 39 d1 72 f3 48 83 e8 08 48 39 f2 73 17 66 2e 0f 1f 84 00 00 00 00 00 48 8b 70 f8 48 83 e8 08 48 39 f2 72 f3 48 39 c3 73 3e <48> 89 33 48 83 c3 08 48 8b 70 f8 48 89 08 48 8b 0b 49 8b 14 24 eb
RSP: 002b:00007f50c24bfa00 EFLAGS: 00000287
RAX: 00007f50c1c009a0 RBX: 00007f50c1c00678 RCX: ffffffff813205d6
RDX: ffffffff813205d6 RSI: ffffffff813205d6 RDI: 00007f50c1c00a50
RBP: 00007f50c1c00570 R08: 00007f50c1c007d8 R09: 0000000000000317
R10: 00000000817374e2 R11: 0000000000000246 R12: 00007f50c1c00568
R13: 0000000000000014 R14: 00007f50c2390000 R15: 00007f50c239c018
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
