Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2674806BEB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377417AbjLFK27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377325AbjLFK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:28:58 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6884112B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:29:04 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb36840642so6052447fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858543; x=1702463343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9Y7+TXaBsP3Hgd3/gwu8p6ZrI+EBLCOyy3VD3SsoLQ=;
        b=TQZPqJa07bopJ/kbXxEuX5CiSs012bmgoUlhZXTOz3G/oa0tWHnAD8nL8UNbsSoXTe
         WZ7kJWJ2GL++SQVnQmqWPsCFUXb1VbqLCDDZdDpt9mLEh/Z7cZ8wGjyR6sgPCV1neE7V
         qvcQesS2G6HFZm5b66he1b2VfMR5LiUZpzT4VPI8S3XSuPRA9WSOGyXBWNeMswtOJ3Kh
         fopPKliLrI9/AsQnszfPVbA2GG7GdDKOzBY2kLjTWwy36VPHxYcGpGvMx4x3nm06acZH
         V2epGzhADj78XfQQstdl2oKuE8zl4RnLt6Eg34qyRLna1cpEuo0I03CLvhER94RtntMs
         yjEA==
X-Gm-Message-State: AOJu0YxxnpNIDPHDuH3Uwn92sMcdNXHnnrz7wMWjLKL84gRW/bKkGI3+
        TyDBt+1LQXZpu+2RpLnlqPQJKWF9gtOAEpIkhGowlU03ntSr
X-Google-Smtp-Source: AGHT+IF8WOQUPBa8F0OTeC5s8sgGhwiE/W1E9WHHTh2TYGcGEWmwY8R0/7cgn0n5usE/d8A2L1e6FmUCQKamkK6/vGIIEi76QfBu
MIME-Version: 1.0
X-Received: by 2002:a05:6870:ac08:b0:1fb:3bfc:a07e with SMTP id
 kw8-20020a056870ac0800b001fb3bfca07emr774468oab.6.1701858543753; Wed, 06 Dec
 2023 02:29:03 -0800 (PST)
Date:   Wed, 06 Dec 2023 02:29:03 -0800
In-Reply-To: <tencent_832FC96FC0960CE862ED52CF3079966C4C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f56247060bd4d11c@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in llc_rcv

syz-executor.0 uses obsolete (PF_INET,SOCK_PACKET)
=====================================================
BUG: KMSAN: uninit-value in pskb_may_pull_reason include/linux/skbuff.h:2667 [inline]
BUG: KMSAN: uninit-value in pskb_may_pull include/linux/skbuff.h:2681 [inline]
BUG: KMSAN: uninit-value in llc_fixup_skb net/llc/llc_input.c:135 [inline]
BUG: KMSAN: uninit-value in llc_rcv+0x10b9/0x1480 net/llc/llc_input.c:178
 pskb_may_pull_reason include/linux/skbuff.h:2667 [inline]
 pskb_may_pull include/linux/skbuff.h:2681 [inline]
 llc_fixup_skb net/llc/llc_input.c:135 [inline]
 llc_rcv+0x10b9/0x1480 net/llc/llc_input.c:178
 __netif_receive_skb_one_core net/core/dev.c:5527 [inline]
 __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5641
 netif_receive_skb_internal net/core/dev.c:5727 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5786
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
 tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6331
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
 tun_alloc_skb drivers/net/tun.c:1531 [inline]
 tun_get_user+0x1e8a/0x66d0 drivers/net/tun.c:1846
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5454 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-14500-g1c41041124bd-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
=====================================================


Tested on:

commit:         1c410411 Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=111c2586e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140e7c4ce80000

