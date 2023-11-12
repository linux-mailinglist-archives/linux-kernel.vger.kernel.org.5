Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2160F7E8FAC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjKLLwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 06:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjKLLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 06:52:08 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21AA2116
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 03:52:04 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-280351c9fa1so3203027a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 03:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699789924; x=1700394724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yq7kjtLnEXgDBkd/9lpck7RpwBJ8eB8dc7re6qNg9o=;
        b=DzOcEyfDv/Q6ILmruJSHi/0mhWIqL7BpEyF/jQqXRvE7DHOQoqAC8kSHt+u72S8ZXn
         TiV8e8UE6injo1lcMm6VombJEgKRB7dOz0xIU5e50eeYWe18fcbuqYgVpGZHAeYiiDSg
         akxElimTlUGWyBSfVeGFLpZHkw3pbMac1MubqtEOAOvUVyybGnyfyvtINBCDPIQIqS3e
         Kc3igtgnY6W8aGqkSf+Urn+HwpECxIAPMXXEKJKzlCfy19znK/kTgEe+s8nYtdUXqinD
         zSviMGU8ZTD/ShlNvtI/kgjpjGpWAKy6XA00+AYzXGfXzbruJTMB0uP3M4SdI3e1BRQO
         8t5A==
X-Gm-Message-State: AOJu0Yz+D+fVeWdNQ3koxT/BeqeXp9vozP5nwFDtusyKMm+Nadg6Qk/s
        fmB123p7lW84WZLuevweX9VHrppRdHI9hIqerb/f/OFOSv6j
X-Google-Smtp-Source: AGHT+IEATttZMeg7BbYrGboUzfLXF1j0YPTHj10mk1+wmA+xFL0I/FG/uuYMmFihdWBmiqdRX4X9VhqRmiaEVxrbqP+J1S4KdKcM
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c28b:b0:27c:f4f8:5ee with SMTP id
 f11-20020a17090ac28b00b0027cf4f805eemr1193072pjt.4.1699789924072; Sun, 12 Nov
 2023 03:52:04 -0800 (PST)
Date:   Sun, 12 Nov 2023 03:52:03 -0800
In-Reply-To: <7f87b3b9-6876-40d7-b159-94f2119851f9@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e04940609f32e7a@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     bragathemanick0908@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: corrupted list in btrfs_ref_tree_mod

list_add corruption. prev->next should be next (ffff888122a51108), but was 0000000000058000. (prev=ffff88810e236d50).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:30!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 45 Comm: kworker/u4:2 Not tainted 6.5.0-rc5-syzkaller-00182-g25aa0bebba72-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
RIP: 0010:__list_add_valid+0x74/0x90 lib/list_debug.c:30
Code: e2 fe 0f 0b 48 89 c1 48 c7 c7 68 ff af 85 e8 a3 d7 e2 fe 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 c0 ff af 85 e8 8c d7 e2 fe <0f> 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 18 00 b0 85 e8 75 d7 e2
RSP: 0018:ffffc900001cf920 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff88810e236d50 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8131cbd0 RDI: 0000000000000001
RBP: ffff888122a51108 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 205d353454202020 R12: 0000000000000000
R13: ffff888122aec700 R14: ffff888122aec750 R15: ffff888122a510c0
FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2648f75e8 CR3: 000000010a57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 btrfs_ref_tree_mod+0x454/0xbb0 fs/btrfs/ref-verify.c:887
 btrfs_free_tree_block+0x116/0x450 fs/btrfs/extent-tree.c:3250
 __btrfs_cow_block+0x6a5/0xa30 fs/btrfs/ctree.c:601
 btrfs_cow_block+0x154/0x2b0 fs/btrfs/ctree.c:712
 btrfs_search_slot+0xa49/0x1770 fs/btrfs/ctree.c:2194
 btrfs_update_root+0x6f/0x500 fs/btrfs/root-tree.c:137
 commit_fs_roots+0x236/0x360 fs/btrfs/transaction.c:1450
 btrfs_commit_transaction+0x93e/0x15c0 fs/btrfs/transaction.c:2393
 btrfs_qgroup_rescan_worker+0x389/0x610 fs/btrfs/qgroup.c:3417
 btrfs_work_helper+0x158/0x540 fs/btrfs/async-thread.c:314
 process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
 worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
 kthread+0x12b/0x170 kernel/kthread.c:389
 ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid+0x74/0x90 lib/list_debug.c:30
Code: e2 fe 0f 0b 48 89 c1 48 c7 c7 68 ff af 85 e8 a3 d7 e2 fe 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 c0 ff af 85 e8 8c d7 e2 fe <0f> 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 18 00 b0 85 e8 75 d7 e2
RSP: 0018:ffffc900001cf920 EFLAGS: 00010246

RAX: 0000000000000075 RBX: ffff88810e236d50 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8131cbd0 RDI: 0000000000000001
RBP: ffff888122a51108 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 205d353454202020 R12: 0000000000000000
R13: ffff888122aec700 R14: ffff888122aec750 R15: ffff888122a510c0
FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2648f75e8 CR3: 000000010a57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         25aa0beb Merge tag 'net-6.5-rc6' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10deb938e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a72ca7680000

