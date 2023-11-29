Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE77FD55C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjK2LTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2LS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:18:59 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D1DA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:19:04 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab8fso7931820b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701256744; x=1701861544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYVQKySS4UqJldH1cZEScRY+Fw+Njm3hPujMCMj0O8k=;
        b=U1qgZTjv93v4t5D6wMVPZbolIIhWo3V8FODpBuocRijSTQfhigl2bLYvqmaTekNuPR
         QGx690XyqD39YMCTj/VcSdsSnTud6BIKOmCJlzTa6VgQ5eiw8SYeySiqb+gkVslDbM1C
         +k3QyrNjSgznx7pWXl4xc5QS5bwwoNocm+hTvXGSFCFpBLYgddKw1keY9ddSZqgNp5eC
         At/XTFZLWwVX7zLeBrdlC95R8snhWp+N13wqQUVVD1lrdJlmY6rRW9bgBnj9ZcZc4peR
         fSPW8Iz461bF4KcTSa8LJcjJ8YAcOAC1zoipLxc1nRJBY945+Z+pY6d5D9fmi63W0O5o
         O4sQ==
X-Gm-Message-State: AOJu0YzYXB4i1n0F0O++riviD9JCeuMxmGsqlIbmpUAlMHYEvGTd8B3e
        lVxra8P8wio3kWCAtYa+P5HLVQGHhaPxVpHPnPYAeWwUGBE2
X-Google-Smtp-Source: AGHT+IHGCQN4SOujRGQSa2TYZ8KcKc5hAJbeSJVLTQUg08C8VD5xEcuFlleXt+Prt89Kua0mE5ZYKESWGgyht5CcToG0rcUDkdTo
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3a0c:b0:6bd:2247:d2e5 with SMTP id
 fj12-20020a056a003a0c00b006bd2247d2e5mr5080436pfb.4.1701256744531; Wed, 29
 Nov 2023 03:19:04 -0800 (PST)
Date:   Wed, 29 Nov 2023 03:19:04 -0800
In-Reply-To: <tencent_22044BD21BDE25BEBA3ABB5233139EBD1B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee00d1060b48b316@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init (2)
From:   syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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
UBSAN: shift-out-of-bounds in sta_link_apply_parameters

================================================================================
UBSAN: shift-out-of-bounds in net/mac80211/cfg.c:1798:30
shift exponent -1 is negative
CPU: 1 PID: 5418 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-01647-g6e2332e0ab53-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2a6/0x480 lib/ubsan.c:387
 sta_link_apply_parameters.cold+0x1a/0x1f net/mac80211/cfg.c:1798
 sta_apply_parameters+0x87d/0x16b0 net/mac80211/cfg.c:1988
 ieee80211_add_station+0x3ca/0x610 net/mac80211/cfg.c:2070
 rdev_add_station net/wireless/rdev-ops.h:201 [inline]
 nl80211_new_station+0x13e8/0x1af0 net/wireless/nl80211.c:7564
 genl_family_rcv_msg_doit.isra.0+0x1ef/0x2d0 net/netlink/genetlink.c:968
 genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
 genl_rcv_msg+0x559/0x800 net/netlink/genetlink.c:1065
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2546
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x69f/0x950 net/socket.c:2504
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2558
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2587
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f084287cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f084350a0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f084299bf80 RCX: 00007f084287cae9
RDX: 0000000000000000 RSI: 00000000200004c0 RDI: 0000000000000004
RBP: 00007f08428c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f084299bf80 R15: 00007ffe7b058668
 </TASK>
================================================================================


Tested on:

commit:         6e2332e0 Merge tag 'cgroup-for-6.5' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1250b438e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=102b18358d5797d8
dashboard link: https://syzkaller.appspot.com/bug?extid=62d7eef57b09bfebcd84
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b51b78e80000

