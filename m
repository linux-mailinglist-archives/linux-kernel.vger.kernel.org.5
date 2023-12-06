Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D959806910
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjLFIBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376792AbjLFIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:01:00 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AA11BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:01:04 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b8b91c5638so5619574b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849664; x=1702454464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXvEmhbf0vqv+QYVlyHT/O3ASNpZFVKaAYpg1d6nP7A=;
        b=X19SVGwzMSMeefLDiTguLa6kK4G3ufu2Xvq19XBISqE9fUrrQ3+mc8/pQSOm6oSaU/
         ujWJLMEUytH+V22HyuxLEQgtnMly8PynDYKlP3cnkUnZ6Zo7tnexEF3dmz45FPNAsANs
         i8cKz1Vr5/SQ6i/JPppRdJPnAe52k7v647hLEUkQ1deK33wIKCcrGxAjgosq/f6fwSfv
         LXuDShFDlO3oPWzKmoI4aC+S56C3JxSUxk+AkRxWeWgr+bXBdVSOrEJAyQyNuLoy5AIa
         dwW9+oi/Uuxs/23GO9fYn3DuDweXlveGfcRiTP9ZdD3BJPTGPPeOEm536us0HTjo5y0p
         ZgWQ==
X-Gm-Message-State: AOJu0YxdPrAPnv98yGYuLczbRM3+mdg/FfKKIL0AXiqEt/hKYDofh/AZ
        63q6DE2ZZj3pzp3LdKCCOQ9iHQVKQJxRAD+nCMFwhi9DPfit
X-Google-Smtp-Source: AGHT+IF0M8qgi6xXjSJ5/aa7U+hrg7otZ1MIO8sWYVAt1bbCxSIL6PaL4ONLYZslysJQQ1eZjOqZ8KqdE/s1INfD/Jb7oxXLQC3b
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3084:b0:3b8:b447:2620 with SMTP id
 bl4-20020a056808308400b003b8b4472620mr416777oib.11.1701849664032; Wed, 06 Dec
 2023 00:01:04 -0800 (PST)
Date:   Wed, 06 Dec 2023 00:01:03 -0800
In-Reply-To: <tencent_EE98A7D746C352F2464689936ED8AEF14C06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af965b060bd2c08b@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __llc_lookup_established

syz-executor.0 uses obsolete (PF_INET,SOCK_PACKET)
3sp: 4352, 1024, 4352
=====================================================
BUG: KMSAN: uninit-value in __llc_lookup_established+0xe9d/0xf90
 __llc_lookup_established+0xe9d/0xf90
 __llc_lookup net/llc/llc_conn.c:611 [inline]
 llc_conn_handler+0x4bd/0x1360 net/llc/llc_conn.c:791
 llc_rcv+0x105b/0x1520 net/llc/llc_input.c:208
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

Local variable daddr created at:
 llc_conn_handler+0x53/0x1360 net/llc/llc_conn.c:783
 llc_rcv+0x105b/0x1520 net/llc/llc_input.c:208

CPU: 1 PID: 5474 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-14500-g1c41041124bd-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
=====================================================


Tested on:

commit:         1c410411 Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=148a49b4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c0649ce80000

