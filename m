Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC3C7E9C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjKMMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:47:11 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5BD79
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:47:07 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6c334d2fd40so5825417b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699879627; x=1700484427;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YhNtK4hSUkgQRF+Wp7nwvqD4QStVbTqJ2Vq4CWalls=;
        b=jOwLpWXnDljHAkP6pZOyDBJWFElAh2nTFIxajEx2qRwn/E8+WmIjc6dkc1jnu7RvdD
         ovhXElJgCYVaTie9J3SWhlzB1P+Y0ME9MB8wowOQmOEZRrT+rPVwUtQ0EI89lOWcRWjy
         lxkkh8Lvxlf/fDTbgXf3TwWecVdmu4UxqSoK/7wqrgKgajpL/Phwwgtqh0yd8bFDkicd
         n7Syid0VQ2rFlb0hmdyo+efNygyg11HvBe61jcvxPXDNLG8Lnupk4DHox0mCYznYy5Aq
         52OtC0fEA9x/pDqfWKHXg0shnC4GelE5WiP83Fp4/4Tuyuo19LIH4489lkaeSZ7PLkkT
         u0Og==
X-Gm-Message-State: AOJu0YwT0hpdxuv6kuwP1haok5J1Wbd2xddnEvB8aQLF9mUS7j9R1H9Z
        A2OreJ14kJLCd3zuDzEfWD5M90OmL0Me1y/jaeqKo5LlRy7w
X-Google-Smtp-Source: AGHT+IFn5yKFuYVKCCQBfL5SwOoQ3Ms+yXx/weJ8ebkrpmUlNl9SZX6/SO7ftS4BkoXodndc7bAP2MYpEsdhwLSsxTR8MhtDY7GA
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2809:b0:68f:f868:a4fb with SMTP id
 bl9-20020a056a00280900b0068ff868a4fbmr1602088pfb.5.1699879627221; Mon, 13 Nov
 2023 04:47:07 -0800 (PST)
Date:   Mon, 13 Nov 2023 04:47:07 -0800
In-Reply-To: <fa2828889412ffe9321478f4c5deb0f7@foxhound.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005770ed060a081130@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in add_tree_block
From:   syzbot <syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com>
To:     jose.pekkarinen@foxhound.fi, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in add_tree_block

BUG: memory leak
unreferenced object 0xffff88811b83f780 (size 64):
  comm "syz-executor.0", pid 5490, jiffies 4294945002 (age 8.100s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81578015>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff821ae7a9>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff821ae7a9>] add_tree_block+0x39/0x240 fs/btrfs/ref-verify.c:319
    [<ffffffff821afdb6>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821afdb6>] process_leaf fs/btrfs/ref-verify.c:524 [inline]
    [<ffffffff821afdb6>] walk_down_tree fs/btrfs/ref-verify.c:576 [inline]
    [<ffffffff821afdb6>] btrfs_build_ref_tree+0x566/0x8c0 fs/btrfs/ref-verify.c:1009
    [<ffffffff82095365>] open_ctree+0x18c5/0x2370 fs/btrfs/disk-io.c:3523
    [<ffffffff8205ab21>] btrfs_fill_super fs/btrfs/super.c:1117 [inline]
    [<ffffffff8205ab21>] btrfs_mount_root+0x5a1/0x750 fs/btrfs/super.c:1478
    [<ffffffff816fd5a9>] legacy_get_tree+0x29/0x80 fs/fs_context.c:662
    [<ffffffff81692d2a>] vfs_get_tree+0x2a/0x130 fs/super.c:1768
    [<ffffffff816d06db>] fc_mount fs/namespace.c:1114 [inline]
    [<ffffffff816d06db>] vfs_kern_mount.part.0+0xcb/0x110 fs/namespace.c:1144
    [<ffffffff816d075f>] vfs_kern_mount+0x3f/0x60 fs/namespace.c:1131
    [<ffffffff8205eb82>] btrfs_mount+0x1e2/0x660 fs/btrfs/super.c:1538
    [<ffffffff816fd5a9>] legacy_get_tree+0x29/0x80 fs/fs_context.c:662
    [<ffffffff81692d2a>] vfs_get_tree+0x2a/0x130 fs/super.c:1768
    [<ffffffff816d882f>] do_new_mount fs/namespace.c:3337 [inline]
    [<ffffffff816d882f>] path_mount+0xc8f/0x10d0 fs/namespace.c:3664
    [<ffffffff816d9421>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816d9421>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816d9421>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816d9421>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b4945f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b4945f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88811b83fe40 (size 64):
  comm "syz-executor.0", pid 5490, jiffies 4294945002 (age 8.100s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81578015>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff821ae165>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff821ae165>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff821ae165>] add_block_entry+0x35/0x320 fs/btrfs/ref-verify.c:270
    [<ffffffff821ae806>] add_tree_block+0x96/0x240 fs/btrfs/ref-verify.c:332
    [<ffffffff821afdb6>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821afdb6>] process_leaf fs/btrfs/ref-verify.c:524 [inline]
    [<ffffffff821afdb6>] walk_down_tree fs/btrfs/ref-verify.c:576 [inline]
    [<ffffffff821afdb6>] btrfs_build_ref_tree+0x566/0x8c0 fs/btrfs/ref-verify.c:1009
    [<ffffffff82095365>] open_ctree+0x18c5/0x2370 fs/btrfs/disk-io.c:3523
    [<ffffffff8205ab21>] btrfs_fill_super fs/btrfs/super.c:1117 [inline]
    [<ffffffff8205ab21>] btrfs_mount_root+0x5a1/0x750 fs/btrfs/super.c:1478
    [<ffffffff816fd5a9>] legacy_get_tree+0x29/0x80 fs/fs_context.c:662
    [<ffffffff81692d2a>] vfs_get_tree+0x2a/0x130 fs/super.c:1768
    [<ffffffff816d06db>] fc_mount fs/namespace.c:1114 [inline]
    [<ffffffff816d06db>] vfs_kern_mount.part.0+0xcb/0x110 fs/namespace.c:1144
    [<ffffffff816d075f>] vfs_kern_mount+0x3f/0x60 fs/namespace.c:1131
    [<ffffffff8205eb82>] btrfs_mount+0x1e2/0x660 fs/btrfs/super.c:1538
    [<ffffffff816fd5a9>] legacy_get_tree+0x29/0x80 fs/fs_context.c:662
    [<ffffffff81692d2a>] vfs_get_tree+0x2a/0x130 fs/super.c:1768
    [<ffffffff816d882f>] do_new_mount fs/namespace.c:3337 [inline]
    [<ffffffff816d882f>] path_mount+0xc8f/0x10d0 fs/namespace.c:3664
    [<ffffffff816d9421>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816d9421>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816d9421>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816d9421>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b4945f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b4945f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82

BUG: memory leak
unreferenced object 0xffff88811acefb40 (size 96):
  comm "syz-executor.0", pid 5490, jiffies 4294945002 (age 8.100s)
  hex dump (first 32 bytes):
    00 10 10 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81578015>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff821ae17e>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff821ae17e>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff821ae17e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff821ae806>] add_tree_block+0x96/0x240 fs/btrfs/ref-verify.c:332
    [<ffffffff821afdb6>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821afdb6>] process_leaf fs/btrfs/ref-verify.c:524 [inline]
    [<ffffffff821afdb6>] walk_down_tree fs/btrfs/ref-verify.c:576 [inline]
    [<ffffffff821afdb6>] btrfs_build_ref_tree+0x566/0x8c0 fs/btrfs/ref-verify.c:1009
    [<ffffffff82095365>] open_ctree+0x18c5/0x2370 fs/btrfs/disk-io.c:3523
    [<ffffffff8205ab21>] btrfs_fill_super fs/btrfs/super.c:1117 [inline]
    [<ffffffff8205ab21>] btrfs_mount_root+0x5a1/0x750 fs/btrfs/super.c:1478
    [<ffffffff816fd5a9>] legacy_get_tree+0x29/0x80 fs/fs_context.c:662
    [<ffffffff81692d2a>] vfs_get_tree+0x2a/0x130 fs/super.c:1768
    [<ffffffff816d06db>] fc_mount fs/namespace.c:1114 [inline]
    [<ffffffff816d06db>] vfs_kern_mount.part.0+0xcb/0x110 fs/namespace.c:1144
    [<ffffffff816d075f>] vfs_kern_mount+0x3f/0x60 fs/namespace.c:1131
    [<ffffffff8205eb82>] btrfs_mount+0x1e2/0x660 fs/btrfs/super.c:1538
    [<ffffffff816fd5a9>] legacy_get_tree+0x29/0x80 fs/fs_context.c:662
    [<ffffffff81692d2a>] vfs_get_tree+0x2a/0x130 fs/super.c:1768
    [<ffffffff816d882f>] do_new_mount fs/namespace.c:3337 [inline]
    [<ffffffff816d882f>] path_mount+0xc8f/0x10d0 fs/namespace.c:3664
    [<ffffffff816d9421>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816d9421>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816d9421>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816d9421>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b4945f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b4945f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82



Tested on:

commit:         5a6a09e9 Merge tag 'cgroup-for-6.7' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=161484b8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=492c9379bc08e464
dashboard link: https://syzkaller.appspot.com/bug?extid=be14ed7728594dc8bd42
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
