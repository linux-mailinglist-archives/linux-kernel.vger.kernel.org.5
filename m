Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93259805DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbjLESZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjLESZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:25:27 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2E122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:25:33 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb1c742f0bso4110727fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800732; x=1702405532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qt2IPYpVqJcBLk2RvD4/pXQbbdMV2lIC4jrljwh1tcQ=;
        b=K3j8oGKuh76flHU2kmUmapJOcE5RoNiElnXS3l/hlUSWdwpqVFW95itqn/NChc+f4k
         F0AQAqRJln2d7MQcgaG+7MIOhO0KqD8bELbfamT7Jv6lbieanf3Bxynn+62i5k8wiLuR
         zstTyQt4AaqOvveFGDNY7uhgmt1ZgChd3L7s8lN8/Z6Ciw7FZsU63ifEcuhKnYvLBFvq
         IzUfAxNysjdMKv8NNEk3A6Bn43qg2IBpZm+jmkFUThsUmluS0FVTrLHY8Bt/9Rv3cgFi
         XzMpa6kFeIdjwtaiaHrAZewJp2+aPGVyHNxzUrRkHsKpiKpUiC491sQmYtR2NERf8IZj
         9TOQ==
X-Gm-Message-State: AOJu0YwF7pvj1otw1NGkRLQznKgjD3Dt1gPwOQ0vGWDrT/Lg2eVKXs9H
        dcChI7oVO7H4q98oxnFLlaz5oi9vi1Ci0PEp25feq95OwvV3
X-Google-Smtp-Source: AGHT+IFZHDzqNlD/0jbez0iFB7jDTZLKQWBYaRkHCavKQDFJMy29oEdnZomvbogAb4l3Gwi/W180SmdAfMKy1SJ39SDJXY+G2tS8
MIME-Version: 1.0
X-Received: by 2002:a05:6870:160a:b0:1fa:4e4:c49 with SMTP id
 b10-20020a056870160a00b001fa04e40c49mr5853088oae.0.1701800731972; Tue, 05 Dec
 2023 10:25:31 -0800 (PST)
Date:   Tue, 05 Dec 2023 10:25:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b9bed060bc75cbc@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1c41041124bd Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10429eeb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b6a00f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121471ef680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20fd86e677f1/disk-1c410411.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ccd39cb0b7b6/vmlinux-1c410411.xz
kernel image: https://storage.googleapis.com/syzbot-assets/156fc60f97bc/bzImage-1c410411.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com

syz-executor994 uses obsolete (PF_INET,SOCK_PACKET)
=====================================================
BUG: KMSAN: uninit-value in __llc_lookup_established+0xe9d/0xf90
 __llc_lookup_established+0xe9d/0xf90
 __llc_lookup net/llc/llc_conn.c:611 [inline]
 llc_conn_handler+0x4bd/0x1360 net/llc/llc_conn.c:791
 llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206
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
 llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206

CPU: 1 PID: 5004 Comm: syz-executor994 Not tainted 6.6.0-syzkaller-14500-g1c41041124bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
