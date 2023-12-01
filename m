Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50147800F98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379434AbjLAPbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379398AbjLAPbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:31:20 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93632198
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:31:24 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d01c45ff34so9331995ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444684; x=1702049484;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oJz4ABqI6dQYHTyvK+VaenbIcleK/g5CtSQLh80SqY=;
        b=Rjt/rkHywCzrgTnF5eCDy8pMFQrsqSFDoQ1oJzFbyu5WiDgPjIk5XAAjFsAi1tbnWn
         1ywNm2VddFCCbmJRkXLoLLm2YJoAami+xkohoVDJ2zM/OO76j2DkCVo9fWKnfBxVFO+7
         liRJbKFKyYcPbuvL7IczgH/kfS3S1L+7zc8ofhn/6DtxlBjx+lHPsuHhrEwyhwwU6PPq
         PepsyIByoSXkc6eIj6g/OTIw95WnDOtFXeCl5ROt1z8UGSuCxF9SllCFS7yKnpFOvkFZ
         UlKL7gm5CL++PHqxqI/yFdNa61nHIaS0rs1HySbUdumeKwaKakl91etUz2Zu18h4wJWM
         IY1A==
X-Gm-Message-State: AOJu0YzQ96cEScrEzUIgjbNgbkMIGH3XJjAcsME6FXaOKgpjhfztDS8m
        TV7KvjyflXZ00PAlaXD66LET+lkZixEJxxYUY6lIzWVwwugW
X-Google-Smtp-Source: AGHT+IEpfkl2TVrJUq3upLcd96cDovCb5c1uhiWIvTt2OW0A5SrXccNr+K53jgdEjnBTjCOmmHJuSjF/KEqeMS5ZdULuHsQxD8zE
MIME-Version: 1.0
X-Received: by 2002:a17:903:2308:b0:1cc:274d:ba5a with SMTP id
 d8-20020a170903230800b001cc274dba5amr5686495plh.0.1701444684119; Fri, 01 Dec
 2023 07:31:24 -0800 (PST)
Date:   Fri, 01 Dec 2023 07:31:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000843f060b747650@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_packet_handshake_receive_worker
 / wg_packet_rx_poll (6)
From:   syzbot <syzbot+57cb9d16a1b17521eb76@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
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

HEAD commit:    d2da77f431ac Merge tag 'parisc-for-6.7-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11294880e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1151391aefc0c3
dashboard link: https://syzkaller.appspot.com/bug?extid=57cb9d16a1b17521eb76
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ebc29947781/disk-d2da77f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a82ec858fbee/vmlinux-d2da77f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d45f2fa85085/bzImage-d2da77f4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57cb9d16a1b17521eb76@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_packet_handshake_receive_worker / wg_packet_rx_poll

read-write to 0xffff8881392abfa0 of 8 bytes by interrupt on cpu 1:
 update_rx_stats drivers/net/wireguard/receive.c:23 [inline]
 wg_packet_consume_data_done drivers/net/wireguard/receive.c:358 [inline]
 wg_packet_rx_poll+0xd35/0xf00 drivers/net/wireguard/receive.c:474
 __napi_poll+0x60/0x3b0 net/core/dev.c:6533
 napi_poll net/core/dev.c:6602 [inline]
 net_rx_action+0x32b/0x750 net/core/dev.c:6735
 __do_softirq+0xc4/0x279 kernel/softirq.c:553
 do_softirq+0x5e/0x90 kernel/softirq.c:454
 __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
 wg_packet_handshake_receive_worker+0x184/0x5e0 drivers/net/wireguard/receive.c:212
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
 worker_thread+0x525/0x730 kernel/workqueue.c:2784
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

read-write to 0xffff8881392abfa0 of 8 bytes by task 22808 on cpu 0:
 update_rx_stats drivers/net/wireguard/receive.c:23 [inline]
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:198 [inline]
 wg_packet_handshake_receive_worker+0x4b9/0x5e0 drivers/net/wireguard/receive.c:213
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
 worker_thread+0x525/0x730 kernel/workqueue.c:2784
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

value changed: 0x00000000000070b0 -> 0x00000000000070d0

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 22808 Comm: kworker/0:4 Not tainted 6.7.0-rc2-syzkaller-00265-gd2da77f431ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: wg-kex-wg2 wg_packet_handshake_receive_worker
==================================================================


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
