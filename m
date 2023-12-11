Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB080CA38
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjLKMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKMuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:50:00 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC0BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:50:06 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b9f55676a1so3619857b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702299006; x=1702903806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pJBzSkWbUcLXVfzDIlg5EB3lsYufbL8cCKqE3e2Jvs=;
        b=i3odhl4pqx3zHboWU/tgGWf/q9+OaNkdfd+zse/Ze3XT2MtHicQl6H5lNg+AA8810/
         UX68o+iX0HvbepSj5+in2lU2+K27tao6gf8Fa9J4t25wznYh5jSPQiFbv/ZyQkLps72z
         dxQjy0NNd3pbEQjw5TObLht5QnZ4Q4Gew8V9NjoPQOooNnz50RfdzX1lN11YIb6C/WQP
         NjmqnhrgwHvnxbc8Q6Y22we3SzhRos5DX6aavlmi5J0KW7UkkGOYGcTPZoPNArDnG4mK
         GNao0a6UTXP4TqLdodwir2twIKVLoMSBqLvcj8TA+GX2Z2kWHxgHU+YW3YZh7Fafb5uB
         q6HA==
X-Gm-Message-State: AOJu0YwEGWcuRv/cC/AO/YrBFGuNQcDJeG1RsnUUoanw7m7lQJJ6pJaa
        lFwpv3lntBMNpaAQoRLYEPmh4kU4I/7PNXhltwI5n2a/DT28
X-Google-Smtp-Source: AGHT+IFXEePETXaIbL7kkPfgrp4aukEzq2NVKISU4NBmZGtkVLKlZ0KpVIdp21LTi2T73HOdmIGKpBQuD7YWo8oraDd13OmgZwFo
MIME-Version: 1.0
X-Received: by 2002:a05:6808:21a3:b0:3b9:df03:8c72 with SMTP id
 be35-20020a05680821a300b003b9df038c72mr4617942oib.10.1702299006098; Mon, 11
 Dec 2023 04:50:06 -0800 (PST)
Date:   Mon, 11 Dec 2023 04:50:06 -0800
In-Reply-To: <tencent_996A377566D793682361297D63A5244B3705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f62a9060c3b5f6d@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diNewExt
From:   syzbot <syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in lbmIODone

BUG at fs/jfs/jfs_logmgr.c:2303 assert(bp->l_flag & lbmRELEASE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:2303!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 22 Comm: ksoftirqd/1 Not tainted 6.7.0-rc4-syzkaller-00009-gbee0e7762ad2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:lbmIODone+0x16fa/0x1750 fs/jfs/jfs_logmgr.c:2303
Code: fe 07 90 0f 0b e8 e6 cf 78 fe 48 c7 c7 c0 73 a2 8b 48 c7 c6 c0 6e a2 8b ba ff 08 00 00 48 c7 c1 20 7d a2 8b e8 67 a8 fe 07 90 <0f> 0b e8 bf cf 78 fe 48 c7 c7 c0 73 a2 8b 48 c7 c6 c0 6e a2 8b ba
RSP: 0018:ffffc900001c7ad8 EFLAGS: 00010046
RAX: 000000000000003f RBX: 0000000000000020 RCX: f6d0cfb74fb3eb00
RDX: 0000000080000101 RSI: 0000000080000101 RDI: 0000000000000000
RBP: ffff8880278cb008 R08: ffffffff8171379c R09: 1ffff92000038efc
R10: dffffc0000000000 R11: fffff52000038efd R12: dffffc0000000000
R13: ffff8880278cb000 R14: ffff88807eb3da78 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0013fe000 CR3: 00000000702ba000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 req_bio_endio block/blk-mq.c:788 [inline]
 blk_update_request+0x53f/0x1020 block/blk-mq.c:933
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1056
 blk_complete_reqs block/blk-mq.c:1131 [inline]
 blk_done_softirq+0x103/0x150 block/blk-mq.c:1136
 __do_softirq+0x2b8/0x939 kernel/softirq.c:553
 run_ksoftirqd+0xc5/0x120 kernel/softirq.c:921
 smpboot_thread_fn+0x530/0x9f0 kernel/smpboot.c:164
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lbmIODone+0x16fa/0x1750 fs/jfs/jfs_logmgr.c:2303
Code: fe 07 90 0f 0b e8 e6 cf 78 fe 48 c7 c7 c0 73 a2 8b 48 c7 c6 c0 6e a2 8b ba ff 08 00 00 48 c7 c1 20 7d a2 8b e8 67 a8 fe 07 90 <0f> 0b e8 bf cf 78 fe 48 c7 c7 c0 73 a2 8b 48 c7 c6 c0 6e a2 8b ba
RSP: 0018:ffffc900001c7ad8 EFLAGS: 00010046
RAX: 000000000000003f RBX: 0000000000000020 RCX: f6d0cfb74fb3eb00
RDX: 0000000080000101 RSI: 0000000080000101 RDI: 0000000000000000
RBP: ffff8880278cb008 R08: ffffffff8171379c R09: 1ffff92000038efc
R10: dffffc0000000000 R11: fffff52000038efd R12: dffffc0000000000
R13: ffff8880278cb000 R14: ffff88807eb3da78 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0013fe000 CR3: 00000000702ba000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         bee0e776 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13272966e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=553d90297e6d2f50dbc7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165f472ee80000

