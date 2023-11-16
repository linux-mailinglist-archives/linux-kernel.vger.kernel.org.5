Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B164B7EDE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjKPKWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjKPKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:22:09 -0500
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E519E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:22:05 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c334d2fd4cso775960b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130125; x=1700734925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKsco8Z2/A+IeZqsn85TvB1vB1q4DzD7UChREXpP29M=;
        b=kJy0UFjwh/+d1LBmekTqES3dX3zNTfZ8diKbtP3s2KsdHsRrc4x6S0QJhd1jBTm5xk
         DejCpvFz2vwmzMGCUpYNeyrA15bzn2xYk/p4UzFB5l/lz0Ld89Kn5mNDiE18TjpBgjh1
         +6WnP3qh8Kg/MCFQYvn/FXowa2dUEwhCoosaFvxQlk+jBBGmpEOdEmw4Sd6bI85UewEj
         YQVafEXyNigUeO22Pw01IApWqv7sADF4cSn2Zl63imgCNDYvN8XTdDZ6UXXW6zz8zpw+
         UkmkP9ImY+kENR9u3Qwmr/SN6ZGA8wRo2zW+3RH2l2NbJ7Q/IrRYQrF9Dym09YZhVt2u
         f22w==
X-Gm-Message-State: AOJu0YxhHiEkiieJ+C85bcgQ4f/dea5P97wJ+3TGDERVYe5icd0UzgN6
        LUxz/F4VpHuSxkAKog6fE0NE4Vzcfe9IwoFo2tF0H5+851+a
X-Google-Smtp-Source: AGHT+IH6bYZLQh20TcXEywrOfK8UMbINU3BVMN+Wli1ochiJd1PBxFYQz+5cfwOtmU7X9Kr3gIab8KVBHpyOv8SnrAnPnquK0Uri
MIME-Version: 1.0
X-Received: by 2002:aa7:8f8b:0:b0:6c3:38e5:e59 with SMTP id
 t11-20020aa78f8b000000b006c338e50e59mr3678017pfs.6.1700130125266; Thu, 16 Nov
 2023 02:22:05 -0800 (PST)
Date:   Thu, 16 Nov 2023 02:22:05 -0800
In-Reply-To: <ceaf0f0d-d943-4c1a-a531-5193ea64dd29@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003048a9060a42649f@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     bragathemanick0908@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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
memory leak in add_tree_block

BUG: memory leak
unreferenced object 0xffff88812611f380 (size 64):
  comm "syz-executor.5", pid 7474, jiffies 4294960257 (age 171.960s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815545e5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1076
    [<ffffffff82172d99>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff82172d99>] add_tree_block+0x39/0x240 fs/btrfs/ref-verify.c:319
    [<ffffffff821743f9>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821743f9>] process_leaf fs/btrfs/ref-verify.c:521 [inline]
    [<ffffffff821743f9>] walk_down_tree fs/btrfs/ref-verify.c:573 [inline]
    [<ffffffff821743f9>] btrfs_build_ref_tree+0x589/0x850 fs/btrfs/ref-verify.c:1008
    [<ffffffff8205ec90>] open_ctree+0x1890/0x2270 fs/btrfs/disk-io.c:3471
    [<ffffffff8202582f>] btrfs_fill_super fs/btrfs/super.c:1154 [inline]
    [<ffffffff8202582f>] btrfs_mount_root+0x5af/0x750 fs/btrfs/super.c:1519
    [<ffffffff816d3e39>] legacy_get_tree+0x29/0x80 fs/fs_context.c:611
    [<ffffffff8166b7ea>] vfs_get_tree+0x2a/0x110 fs/super.c:1519
    [<ffffffff816a776b>] fc_mount fs/namespace.c:1112 [inline]
    [<ffffffff816a776b>] vfs_kern_mount.part.0+0xcb/0x110 fs/namespace.c:1142
    [<ffffffff816a77ef>] vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
    [<ffffffff820298b2>] btrfs_mount+0x1e2/0x660 fs/btrfs/super.c:1579
    [<ffffffff816d3e39>] legacy_get_tree+0x29/0x80 fs/fs_context.c:611
    [<ffffffff8166b7ea>] vfs_get_tree+0x2a/0x110 fs/super.c:1519
    [<ffffffff816afcff>] do_new_mount fs/namespace.c:3335 [inline]
    [<ffffffff816afcff>] path_mount+0xc8f/0x10d0 fs/namespace.c:3662
    [<ffffffff816b08f1>] do_mount fs/namespace.c:3675 [inline]
    [<ffffffff816b08f1>] __do_sys_mount fs/namespace.c:3884 [inline]
    [<ffffffff816b08f1>] __se_sys_mount fs/namespace.c:3861 [inline]
    [<ffffffff816b08f1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3861
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88812611f500 (size 64):
  comm "syz-executor.5", pid 7474, jiffies 4294960257 (age 171.960s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815545e5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1076
    [<ffffffff82172755>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff82172755>] kzalloc include/linux/slab.h:703 [inline]
    [<ffffffff82172755>] add_block_entry+0x35/0x320 fs/btrfs/ref-verify.c:270
    [<ffffffff82172df6>] add_tree_block+0x96/0x240 fs/btrfs/ref-verify.c:332
    [<ffffffff821743f9>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821743f9>] process_leaf fs/btrfs/ref-verify.c:521 [inline]
    [<ffffffff821743f9>] walk_down_tree fs/btrfs/ref-verify.c:573 [inline]
    [<ffffffff821743f9>] btrfs_build_ref_tree+0x589/0x850 fs/btrfs/ref-verify.c:1008
    [<ffffffff8205ec90>] open_ctree+0x1890/0x2270 fs/btrfs/disk-io.c:3471
    [<ffffffff8202582f>] btrfs_fill_super fs/btrfs/super.c:1154 [inline]
    [<ffffffff8202582f>] btrfs_mount_root+0x5af/0x750 fs/btrfs/super.c:1519
    [<ffffffff816d3e39>] legacy_get_tree+0x29/0x80 fs/fs_context.c:611
    [<ffffffff8166b7ea>] vfs_get_tree+0x2a/0x110 fs/super.c:1519
    [<ffffffff816a776b>] fc_mount fs/namespace.c:1112 [inline]
    [<ffffffff816a776b>] vfs_kern_mount.part.0+0xcb/0x110 fs/namespace.c:1142
    [<ffffffff816a77ef>] vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
    [<ffffffff820298b2>] btrfs_mount+0x1e2/0x660 fs/btrfs/super.c:1579
    [<ffffffff816d3e39>] legacy_get_tree+0x29/0x80 fs/fs_context.c:611
    [<ffffffff8166b7ea>] vfs_get_tree+0x2a/0x110 fs/super.c:1519
    [<ffffffff816afcff>] do_new_mount fs/namespace.c:3335 [inline]
    [<ffffffff816afcff>] path_mount+0xc8f/0x10d0 fs/namespace.c:3662
    [<ffffffff816b08f1>] do_mount fs/namespace.c:3675 [inline]
    [<ffffffff816b08f1>] __do_sys_mount fs/namespace.c:3884 [inline]
    [<ffffffff816b08f1>] __se_sys_mount fs/namespace.c:3861 [inline]
    [<ffffffff816b08f1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3861
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff8881260d4300 (size 96):
  comm "syz-executor.5", pid 7474, jiffies 4294960257 (age 171.960s)
  hex dump (first 32 bytes):
    00 10 10 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff815545e5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1076
    [<ffffffff8217276e>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff8217276e>] kzalloc include/linux/slab.h:703 [inline]
    [<ffffffff8217276e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff82172df6>] add_tree_block+0x96/0x240 fs/btrfs/ref-verify.c:332
    [<ffffffff821743f9>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821743f9>] process_leaf fs/btrfs/ref-verify.c:521 [inline]
    [<ffffffff821743f9>] walk_down_tree fs/btrfs/ref-verify.c:573 [inline]
    [<ffffffff821743f9>] btrfs_build_ref_tree+0x589/0x850 fs/btrfs/ref-verify.c:1008
    [<ffffffff8205ec90>] open_ctree+0x1890/0x2270 fs/btrfs/disk-io.c:3471
    [<ffffffff8202582f>] btrfs_fill_super fs/btrfs/super.c:1154 [inline]
    [<ffffffff8202582f>] btrfs_mount_root+0x5af/0x750 fs/btrfs/super.c:1519
    [<ffffffff816d3e39>] legacy_get_tree+0x29/0x80 fs/fs_context.c:611
    [<ffffffff8166b7ea>] vfs_get_tree+0x2a/0x110 fs/super.c:1519
    [<ffffffff816a776b>] fc_mount fs/namespace.c:1112 [inline]
    [<ffffffff816a776b>] vfs_kern_mount.part.0+0xcb/0x110 fs/namespace.c:1142
    [<ffffffff816a77ef>] vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
    [<ffffffff820298b2>] btrfs_mount+0x1e2/0x660 fs/btrfs/super.c:1579
    [<ffffffff816d3e39>] legacy_get_tree+0x29/0x80 fs/fs_context.c:611
    [<ffffffff8166b7ea>] vfs_get_tree+0x2a/0x110 fs/super.c:1519
    [<ffffffff816afcff>] do_new_mount fs/namespace.c:3335 [inline]
    [<ffffffff816afcff>] path_mount+0xc8f/0x10d0 fs/namespace.c:3662
    [<ffffffff816b08f1>] do_mount fs/namespace.c:3675 [inline]
    [<ffffffff816b08f1>] __do_sys_mount fs/namespace.c:3884 [inline]
    [<ffffffff816b08f1>] __se_sys_mount fs/namespace.c:3861 [inline]
    [<ffffffff816b08f1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3861
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80



Tested on:

commit:         25aa0beb Merge tag 'net-6.5-rc6' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11a0c5b7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1799b938e80000

