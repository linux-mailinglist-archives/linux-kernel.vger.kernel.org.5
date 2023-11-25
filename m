Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C957F8B1B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjKYNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:18:16 -0500
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D837C2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:18:23 -0800 (PST)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-28571255ec4so3198717a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700918302; x=1701523102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3woomzQ8vmDo/vvebKLz9E6d9x/Edw/g418bVAMqXbQ=;
        b=rTDXBFwD8GSKo+xG3laZzR+C2Xe24bQbrq8a6hqhMwWFqiL3a8mB4JBt96Eb1AJ+y0
         FbYhR89pON2c9UJtqSZsGSkGlsMPwYFdB6mpH9U4jg8jXVqQg+vLCSpDbc/wDwTRlri8
         ve1BQ0Ie4WVb1sYRH4nlaqy4N6Ho4754Z/jQHf2j0vTF960qdZak71+djqbAMQQQFHP8
         zVjoLWo4SB06XL9dWEEpE1KY8DRWYqvjqY3sq6xdy9tLIqidFkPfUwBBeib8KUMxOFoY
         2m66ACsAuupYnXjOVnT6Wxf62SOO3oFKKby1eksngNSxmJVqyhWOGHqQknLC+/IjUkqX
         ChYQ==
X-Gm-Message-State: AOJu0Yz5481ImsvHN7xdjSAnOO1lkuzjy4GKzx31ljH1r7bEKGl+lNBR
        QqHTLu18F7uVqV6VFekm7cCNsEbAzLkhXdZxOusqJsHv56R0
X-Google-Smtp-Source: AGHT+IG8LZ7k7h+8r2sG0mhVtEMSGx26qqRGimpLrgciIkMVT0yRqeyoHVRYL0fHjfDmYGHgOqgl4c7zJjP9ZuMDMq8646rx92ye
MIME-Version: 1.0
X-Received: by 2002:a17:903:2308:b0:1cf:75b0:42fc with SMTP id
 d8-20020a170903230800b001cf75b042fcmr1356608plh.4.1700918302598; Sat, 25 Nov
 2023 05:18:22 -0800 (PST)
Date:   Sat, 25 Nov 2023 05:18:22 -0800
In-Reply-To: <000000000000a135c0060a2260b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037f0f3060af9e763@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From:   syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1678a3cce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d54c08e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef1a4e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com

Bluetooth: hci0: hardware error 0x00
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in ida_free+0x218/0x2e0 lib/idr.c:511
Read of size 8 at addr 0000000000000078 by task kworker/u5:1/4455

CPU: 1 PID: 4455 Comm: kworker/u5:1 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: hci0 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xd9/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:182 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:188
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 ida_free+0x218/0x2e0 lib/idr.c:511
 hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
 hci_conn_del+0x78c/0xe10 net/bluetooth/hci_conn.c:1183
 hci_conn_hash_flush+0x189/0x260 net/bluetooth/hci_conn.c:2643
 hci_dev_close_sync+0x5a7/0x1160 net/bluetooth/hci_sync.c:5021
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
 hci_error_reset+0xa6/0x190 net/bluetooth/hci_core.c:1059
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
