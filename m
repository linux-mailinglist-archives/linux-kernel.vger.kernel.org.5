Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B405978B35B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjH1Ok3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjH1OkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:40:20 -0400
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DB8125
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:40:03 -0700 (PDT)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-68beecae979so3140846b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233603; x=1693838403;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXm95atR3/kTaW7ZQT6rFBULl00iH/6dVcnDXDrfk9A=;
        b=Rl0i2ftTlWfyVymWabeCIdFdDksfYjAJy67ukfE/zpEZ9htRUBgyo6FSAqNIsVnLt1
         C8m2HyB8weYEXGfN/EuO+U52QWxyN/UnDeig2NM09bO4StZN7YfCNEp9d+pRvOo203YW
         usWGLWl25idrK9imcmee3jMVcWtVgb9pU9GzCKtAMv22KVDl/bq3K5Tc1nQhirpj5OmM
         c79zO3TQ/Le9Q/WdXK/OOWXJkM0YynBiy6PN3l1j2C0SdrH9q5hmgxu+XOhgFpcl9w4G
         TFvKojnzG8hS/WIwqz6CF4H0NgIpm6hM1XLIfetPMPfpPhjNCzFxVDYu/KLLAFqeHBUe
         4xxA==
X-Gm-Message-State: AOJu0YwhZudhLbYSzoqNC5/c9+KEjNit0xe5MPXCtc/bSUx8IUpJuZI1
        ubYqOqmxdVnm3OL6cHrReazULcJpkBPVE05cFiDwzTxsVhTC
X-Google-Smtp-Source: AGHT+IHk5716Ca10XTl59GGFCRhNTZ++7d+1/qS6le4ntpw38yoiawKpbVdirHbxDUVwiYODTWuEPcXT99H90Y2zkTjpezKUVune
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d27:b0:68a:4d66:cb4 with SMTP id
 fa39-20020a056a002d2700b0068a4d660cb4mr8029052pfb.4.1693233602960; Mon, 28
 Aug 2023 07:40:02 -0700 (PDT)
Date:   Mon, 28 Aug 2023 07:40:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d22850603fcabc3@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_socket_send_skb_to_peer
 / wg_socket_send_skb_to_peer
From:   syzbot <syzbot+b1c5c1efac7273c587fe@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4f9e7fabf864 Merge tag 'trace-v6.5-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f1991fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f12c32a009b80107
dashboard link: https://syzkaller.appspot.com/bug?extid=b1c5c1efac7273c587fe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/586c18cf5685/disk-4f9e7fab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/26437f4b2bc8/vmlinux-4f9e7fab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6be368a4b854/bzImage-4f9e7fab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1c5c1efac7273c587fe@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_socket_send_skb_to_peer / wg_socket_send_skb_to_peer

read-write to 0xffff88813587e3d8 of 8 bytes by task 31333 on cpu 1:
 wg_socket_send_skb_to_peer+0xe4/0x130 drivers/net/wireguard/socket.c:183
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x128/0x320 drivers/net/wireguard/send.c:276
 process_one_work+0x434/0x860 kernel/workqueue.c:2600
 worker_thread+0x5f2/0xa10 kernel/workqueue.c:2751
 kthread+0x1d7/0x210 kernel/kthread.c:389
 ret_from_fork+0x2e/0x40 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

read-write to 0xffff88813587e3d8 of 8 bytes by task 8119 on cpu 0:
 wg_socket_send_skb_to_peer+0xe4/0x130 drivers/net/wireguard/socket.c:183
 wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
 process_one_work+0x434/0x860 kernel/workqueue.c:2600
 worker_thread+0x5f2/0xa10 kernel/workqueue.c:2751
 kthread+0x1d7/0x210 kernel/kthread.c:389
 ret_from_fork+0x2e/0x40 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x000000000000b4fc -> 0x000000000000b51c

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 8119 Comm: kworker/u4:63 Not tainted 6.5.0-rc7-syzkaller-00104-g4f9e7fabf864 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
==================================================================


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
