Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240547E8E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 04:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjKLDoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 22:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLDoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 22:44:07 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E12D77
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:44:04 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc323b2aa3so31911625ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699760643; x=1700365443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5eyDymmPSBIoocqDH/r855Nw0YmDsgrKRXE1NpZeDY=;
        b=LI0QQWbWfM1uB2+zLy+tcI6UQIiA5RL3ofQ6Vfgvh2/+3hZnUgj4B/QPLsecmh/bYO
         syjpsaNWt6C90mGRa4macNnphiW4kchWno6mKQEjWgMtqjUdf/zBecrnXBgR38Cd5xDp
         IqtzjjX2FtFoPqdZ/ZUuGZfJAwasEyvEMJzuOin3Eti2kOdnzTOuKVgV+tYwkWBv6CRM
         2jeKMudY5ZGBg6Iw4ObAHSTWJ5YS/6CLs+nFqxyyY+xiDSLNQaph5xAhywdj4AeXsWMi
         Ov7zs5QOjVVbWEwEA4u8oRkZ6nKuWEpO5JpLCyfwMHLPVbTDaXlM0P8vu6j/FCIEPlg2
         9Jig==
X-Gm-Message-State: AOJu0YxNCGVMECV0z9dqr3as3UXeTbse6GqD1sJbKd0SUDurGyI0gKjH
        3FUn3YsgXa02XbyrMpDrXabGGeCoNXqgBiD+ZA2JOejYPcCL
X-Google-Smtp-Source: AGHT+IGH1dkGSEhrMs7ncvEoA19BT0LipzOntqvdSEOMiWXDy4OuZIuMF+If0YzVOFXdJXOKyL0AaeZ+6HK1OWjTrf9I0xjeZaq1
MIME-Version: 1.0
X-Received: by 2002:a17:903:441:b0:1cc:2575:db16 with SMTP id
 iw1-20020a170903044100b001cc2575db16mr982294plb.2.1699760643620; Sat, 11 Nov
 2023 19:44:03 -0800 (PST)
Date:   Sat, 11 Nov 2023 19:44:03 -0800
In-Reply-To: <tencent_0B5D9E994CCF920DF0A5CC8DA19200DDDD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005dc73c0609ec5d0c@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in create_pending_snapshot

BTRFS info (device loop0): checking UUID tree
------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 0 PID: 5480 at fs/btrfs/transaction.c:1778 create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
Modules linked in:
CPU: 0 PID: 5480 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15365-g305230142ae0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
Code: f8 fd 48 c7 c7 00 43 ab 8b 89 de e8 76 4b be fd 0f 0b e9 30 f3 ff ff e8 7a 8d f8 fd 48 c7 c7 00 43 ab 8b 89 de e8 5c 4b be fd <0f> 0b e9 f8 f6 ff ff e8 60 8d f8 fd 48 c7 c7 00 43 ab 8b 89 de e8
RSP: 0018:ffffc900094cf580 EFLAGS: 00010246
RAX: ca9849a0d3eb4500 RBX: 00000000ffffffef RCX: ffff88807ac39dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900094cf870 R08: ffffffff81547c82 R09: 1ffff92001299e04
R10: dffffc0000000000 R11: fffff52001299e05 R12: ffff88807ca30500
R13: 00000000ffffffef R14: 0000000000000000 R15: ffff88807ca304a0
FS:  00007f9af6b8a6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f15547ad018 CR3: 0000000028d0c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1967
 btrfs_commit_transaction+0xf1c/0x3730 fs/btrfs/transaction.c:2440
 create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
 __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
 btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
 btrfs_ioctl+0xbbf/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f9af5e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9af6b8a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9af5f9bf80 RCX: 00007f9af5e7cae9
RDX: 0000000020000a80 RSI: 0000000050009401 RDI: 0000000000000004
RBP: 00007f9af5ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9af5f9bf80 R15: 00007ffcf277e6d8
 </TASK>


Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=112cafc4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c3dc70e80000

