Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176BE753B11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbjGNMdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjGNMdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:33:44 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29335173B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:33:43 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-39ec7630322so2935189b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689338022; x=1691930022;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/PtvzxIas2zR1ya8bd5qiSh+Ju/22GKnM05TIFi9sA=;
        b=UgLEzMpWwHhOSf9ermwmH1hXsfZ1RlvaoYrN66p2rViRrojq+oJyluwT9TQ5HrkLhC
         S5fW9Fi/1zkI0gjMAcbs7u7l4KPRmqG1u+pW9+Sg4RyRAIJ+2ZufgVpnsdd5rM+SVUqz
         MR4c7FxAue1wzufdJs6b1zW43oI4rmgvx4X82ooabWgNGL4VSwz0GT2Qship85TCiAqc
         z5oD4HRoV2hx8hnfPVlR+ORtVspXlsm1aybpUmfLrj8M2LBoImracBSP89+IgXSLvz5F
         bh1tjhfPlzk91Lq5AA2mzjZu41/+HaQ+PstCSKf3drt9Vb9dyoF2VJJPz4He5CMOWMKa
         71PQ==
X-Gm-Message-State: ABy/qLYU2LklJ33us86yz03sSzbOSL8hp6ZK2EmgDhUuD7s2xxndvrOY
        e0mZ0C1dxm1r8GH3vUahQKlu7Nn8XSO2Bi+tWPuqRbWOIygC
X-Google-Smtp-Source: APBJJlHLvOcL6iCTX34qlHFrOnRO9iN4WebS97Ae10RYVI9fSHmlaDKYPARf+F/In8VOIyTdLvssnN3HESdSnB4MQK77WeWf+/Ij
MIME-Version: 1.0
X-Received: by 2002:a05:6808:e82:b0:3a4:1e93:8988 with SMTP id
 k2-20020a0568080e8200b003a41e938988mr6542129oil.10.1689338022584; Fri, 14 Jul
 2023 05:33:42 -0700 (PDT)
Date:   Fri, 14 Jul 2023 05:33:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bde775060071a8d7@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in af_alg_free_resources
From:   syzbot <syzbot+cba21d50095623218389@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14bac16aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1542573e31cfbec5
dashboard link: https://syzkaller.appspot.com/bug?extid=cba21d50095623218389
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dd215aa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14530318a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4f212a7e36fe/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/de6b12daf908/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c1992ff2aaa/bzImage-3f01e9fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cba21d50095623218389@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in af_alg_free_sg crypto/af_alg.c:545 [inline]
BUG: KMSAN: uninit-value in af_alg_free_areq_sgls crypto/af_alg.c:778 [inline]
BUG: KMSAN: uninit-value in af_alg_free_resources+0x3d1/0xf60 crypto/af_alg.c:1117
 af_alg_free_sg crypto/af_alg.c:545 [inline]
 af_alg_free_areq_sgls crypto/af_alg.c:778 [inline]
 af_alg_free_resources+0x3d1/0xf60 crypto/af_alg.c:1117
 _skcipher_recvmsg crypto/algif_skcipher.c:144 [inline]
 skcipher_recvmsg+0x6a0/0x1a20 crypto/algif_skcipher.c:157
 sock_recvmsg_nosec net/socket.c:1020 [inline]
 sock_recvmsg net/socket.c:1041 [inline]
 __sys_recvfrom+0x505/0x810 net/socket.c:2186
 __do_sys_recvfrom net/socket.c:2204 [inline]
 __se_sys_recvfrom net/socket.c:2200 [inline]
 __x64_sys_recvfrom+0x126/0x1d0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3470 [inline]
 __kmem_cache_alloc_node+0x536/0x8d0 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 sock_kmalloc+0x128/0x1c0 net/core/sock.c:2683
 af_alg_alloc_areq+0x41/0x2a0 crypto/af_alg.c:1188
 _skcipher_recvmsg crypto/algif_skcipher.c:71 [inline]
 skcipher_recvmsg+0x514/0x1a20 crypto/algif_skcipher.c:157
 sock_recvmsg_nosec net/socket.c:1020 [inline]
 sock_recvmsg net/socket.c:1041 [inline]
 __sys_recvfrom+0x505/0x810 net/socket.c:2186
 __do_sys_recvfrom net/socket.c:2204 [inline]
 __se_sys_recvfrom net/socket.c:2200 [inline]
 __x64_sys_recvfrom+0x126/0x1d0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 0 PID: 5031 Comm: syz-executor370 Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
=====================================================


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
