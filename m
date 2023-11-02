Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1A7DF9A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbjKBSMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjKBSMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:12:02 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149E10FA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:11:36 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6ce279b7033so1553010a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948696; x=1699553496;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RbtI8xpa03CyJhsKvMnr93wyie1HRbEaEXonJG5DH8=;
        b=OGnELeEUv+5PFKJNuZ7wTDZTclGnuu5i4SwSkdSH0wxnA9CP8GZgtIq8QxSr5vcEbl
         jyiRarpL630Tus/0ImhejImud0A4pSkcxID2+Cg5F0L4MRlP1RMt0Xzo1GZogwDgyoOm
         IcbXp8mE2pDgTeZw2gE7xbLniEHQgos7A1CaBag/p+3EIPLaKwSD9De3g7gbf4fG/Mf4
         t1+vb7u5w3jDu+weAZbM99S3Jp1R6Nom0PZtoCtofIZw9pPPah4cBD0mj5D5T9kN2hsf
         tvTUXO5c/ZrK4yuRwBGYL2kj/lTAK1i/HOoOykg4De+k2vIryoAcUrG8cgQf5Ye3X2aq
         RqBQ==
X-Gm-Message-State: AOJu0YyTX5cvUKmQepapegR6fnsKEvEnmnjG9VsMVwjaqketQNpETGw0
        AsJXbLROfzoErQGmXsVuBxa6pJD31/Icb1bPz1GssIxMmkFH
X-Google-Smtp-Source: AGHT+IGNMO1VffYnQF9u0dfpNAJh16AvZmj0/iWFfFMNS6Y2wK7AAt4WaTDoeYEL91q6bsBkQsuWE1+rDzH1BduMr/yzbWDLWKQ9
MIME-Version: 1.0
X-Received: by 2002:a9d:6b1a:0:b0:6bc:fb26:499e with SMTP id
 g26-20020a9d6b1a000000b006bcfb26499emr5585697otp.2.1698948695863; Thu, 02 Nov
 2023 11:11:35 -0700 (PDT)
Date:   Thu, 02 Nov 2023 11:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082378906092f51aa@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in xfrm_state_find (2)
From:   syzbot <syzbot+23bbb17a7878e2b3d1d4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3669558bdf35 Merge tag 'for-6.6-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16656930680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=754d6383bae8bc99
dashboard link: https://syzkaller.appspot.com/bug?extid=23bbb17a7878e2b3d1d4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f2e55d5455c8/disk-3669558b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a0b7323ae76/vmlinux-3669558b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3430d935a839/bzImage-3669558b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23bbb17a7878e2b3d1d4@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in xfrm_state_find+0x17bc/0x8ce0 net/xfrm/xfrm_state.c:1160
 xfrm_state_find+0x17bc/0x8ce0 net/xfrm/xfrm_state.c:1160
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2469 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2514 [inline]
 xfrm_resolve_and_create_bundle+0x80c/0x4e30 net/xfrm/xfrm_policy.c:2807
 xfrm_lookup_with_ifid+0x3f7/0x3590 net/xfrm/xfrm_policy.c:3141
 xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
 xfrm_lookup_route+0x63/0x2b0 net/xfrm/xfrm_policy.c:3281
 ip6_dst_lookup_flow net/ipv6/ip6_output.c:1246 [inline]
 ip6_sk_dst_lookup_flow+0x1044/0x1260 net/ipv6/ip6_output.c:1278
 udpv6_sendmsg+0x3448/0x4000 net/ipv6/udp.c:1552
 inet6_sendmsg+0x105/0x190 net/ipv6/af_inet6.c:655
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmmsg+0x3c4/0x950 net/socket.c:2681
 __do_sys_sendmmsg net/socket.c:2710 [inline]
 __se_sys_sendmmsg net/socket.c:2707 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2707
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Local variable tmp.i.i created at:
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2447 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2514 [inline]
 xfrm_resolve_and_create_bundle+0x370/0x4e30 net/xfrm/xfrm_policy.c:2807
 xfrm_lookup_with_ifid+0x3f7/0x3590 net/xfrm/xfrm_policy.c:3141

CPU: 0 PID: 26289 Comm: syz-executor.3 Not tainted 6.6.0-rc1-syzkaller-00033-g3669558bdf35 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
=====================================================


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
