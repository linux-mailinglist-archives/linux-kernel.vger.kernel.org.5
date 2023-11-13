Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E357E9C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjKMM2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKMM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:28:07 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE851702
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:28:03 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc2ebc3b3eso44284455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699878483; x=1700483283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cOh5o+1RgEVTTi0tcpxqnsEKHJM1dMMZ2xIBxhf8Dc=;
        b=SKeZ92mRM9E10iJGGoCMvJFVc55cHJ8h7RhHgXtrbyaA4nhCQvpuveYEo/VWMTbzBL
         zPQjE65e/BsaUIIrSuf9uqVczZWXsRifF3iyogWgDNHhHvycNfvsi57elEmDrUGa8OaS
         rqSavMG2zW4k1LW6EEa8UT/pLyMfUB4jlJVBJz8Kd6SkBFLqFUFqdlnW8LNXwpfdagTs
         FciDvFSMow3h1GfU8q6iuvLhx2VizuvdTnsOukJ2ix2LR4elD/ePP4feSdheHChpjY0O
         GIhTwdR/aaIjyGoiZxptNTSEQ0f3my3JpXBzxU3PeaRfDsCZINlVIiU7r/CF9eYU7eqJ
         KrHQ==
X-Gm-Message-State: AOJu0YzUHMQtwuuveLaHqYjicZyldBEv7H+c5/RFEnoNpJ0mEt3FRAt7
        iJpJQ45EM5EqIw1HfNZr+CYypjwLpZ08tm7VNsHS5lB4i2qs
X-Google-Smtp-Source: AGHT+IEQwdZKTU4AOjsMDt95OVo52pTsP1x9fIDx2nxzY33qwmvmOmVLr7IMMN4/ZBhWjf3ema+gPi8QYlCWJ2sDdLkVsUrZRw1c
MIME-Version: 1.0
X-Received: by 2002:a17:903:441:b0:1cc:2575:db16 with SMTP id
 iw1-20020a170903044100b001cc2575db16mr1909781plb.2.1699878483285; Mon, 13 Nov
 2023 04:28:03 -0800 (PST)
Date:   Mon, 13 Nov 2023 04:28:03 -0800
In-Reply-To: <739186bcb83d46101812b06d7e9abb80@foxhound.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000285ae8060a07cd78@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
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
memory leak in add_block_entry

BUG: memory leak
unreferenced object 0xffff888122f9fe40 (size 64):
  comm "syz-executor.1", pid 5844, jiffies 4294945528 (age 11.970s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81578015>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff821ae165>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff821ae165>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff821ae165>] add_block_entry+0x35/0x320 fs/btrfs/ref-verify.c:270
    [<ffffffff821ae806>] add_tree_block+0x96/0x240 fs/btrfs/ref-verify.c:332
    [<ffffffff821afdf6>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821afdf6>] process_leaf fs/btrfs/ref-verify.c:524 [inline]
    [<ffffffff821afdf6>] walk_down_tree fs/btrfs/ref-verify.c:576 [inline]
    [<ffffffff821afdf6>] btrfs_build_ref_tree+0x566/0x8c0 fs/btrfs/ref-verify.c:1013
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
unreferenced object 0xffff8881216a7ba0 (size 96):
  comm "syz-executor.1", pid 5844, jiffies 4294945528 (age 11.970s)
  hex dump (first 32 bytes):
    00 10 10 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81578015>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff821ae17e>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff821ae17e>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff821ae17e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff821ae806>] add_tree_block+0x96/0x240 fs/btrfs/ref-verify.c:332
    [<ffffffff821afdf6>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821afdf6>] process_leaf fs/btrfs/ref-verify.c:524 [inline]
    [<ffffffff821afdf6>] walk_down_tree fs/btrfs/ref-verify.c:576 [inline]
    [<ffffffff821afdf6>] btrfs_build_ref_tree+0x566/0x8c0 fs/btrfs/ref-verify.c:1013
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
unreferenced object 0xffff888122f9fec0 (size 64):
  comm "syz-executor.1", pid 5844, jiffies 4294945528 (age 11.970s)
  hex dump (first 32 bytes):
    05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81578015>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff821ae165>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff821ae165>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff821ae165>] add_block_entry+0x35/0x320 fs/btrfs/ref-verify.c:270
    [<ffffffff821ae806>] add_tree_block+0x96/0x240 fs/btrfs/ref-verify.c:332
    [<ffffffff821afdf6>] process_extent_item fs/btrfs/ref-verify.c:474 [inline]
    [<ffffffff821afdf6>] process_leaf fs/btrfs/ref-verify.c:524 [inline]
    [<ffffffff821afdf6>] walk_down_tree fs/btrfs/ref-verify.c:576 [inline]
    [<ffffffff821afdf6>] btrfs_build_ref_tree+0x566/0x8c0 fs/btrfs/ref-verify.c:1013
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12ab8f5b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=492c9379bc08e464
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17406848e80000

