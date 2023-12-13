Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD68107E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjLMB6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjLMB6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:58:22 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5D4BC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:58:28 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb2b95e667so11925987fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702432707; x=1703037507;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PrtuHHvlJSMCcRmxVI9cTjTpHHaK6QJDP9Ybf63EDQ=;
        b=ho7K7J/BoVBywJLSGCy96JaxuukuVZi7RpdT3P168qCjn2ckaJ0N0qxS12hlWWeYAu
         Zc27XO+Min0y8nX2qJhtfcRr/5dEM0sddBrcdMaodx3Te1wNkfm0tfDyyuI7cofZLqT7
         z82nU7BELWckCLYx4AXHKL1mVl45kuvKWXsgyr/yinxapLb8PN4oNTyfU4LvxsAI/azm
         VZtZ0zgBaQ1wEfBc+c1a2JXYVTcFS7so3jHt0vvYea7x2fyvymfhaXD6Ium9VZN6jpOz
         hWIpw9snVrcKcfb0M+y5cZigTs6fqzMO5BkGBXkGHIrH9pRUauL2FgEp23QriZNMOKs4
         8Efg==
X-Gm-Message-State: AOJu0Yyp8FG13CJbZvfRTp7Pxrm8QTVV6FOhP3aNSn2MLGdV8krsWrlI
        24t8eoxh3pVZAieN05eCWullEZz/JmaBk5CXKaa1albhkHR0
X-Google-Smtp-Source: AGHT+IHQJk1gbg4Wx6lUKmYs13gpjy4Av/Pw1eg8OFwM0J4J7KWB/N8rxnbR3QT94q1YH4IaXCN015JSQi8xSf+ab5+ygeGaf56P
MIME-Version: 1.0
X-Received: by 2002:a05:6871:798c:b0:1fa:de51:f90b with SMTP id
 pb12-20020a056871798c00b001fade51f90bmr8315757oac.11.1702432707268; Tue, 12
 Dec 2023 17:58:27 -0800 (PST)
Date:   Tue, 12 Dec 2023 17:58:27 -0800
In-Reply-To: <000000000000169326060971d07a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5542e060c5a80fc@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io
From:   syzbot <syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    eaadbbaaff74 Merge tag 'fuse-fixes-6.7-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f9a15ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=06006fc4a90bff8e8f17
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc9deae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a3a26b045d0/disk-eaadbbaa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ca3ec5e1332/vmlinux-eaadbbaa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c8cfd867e4c2/bzImage-eaadbbaa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fafd72a5cce8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com

assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1356
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:1356!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.7.0-rc5-syzkaller-00030-geaadbbaaff74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: writeback wb_workfn (flush-btrfs-137)
RIP: 0010:__extent_writepage_io+0xcd5/0xd00 fs/btrfs/extent_io.c:1356
Code: 77 07 90 0f 0b e8 fb 23 f1 fd 48 c7 c7 80 c5 ab 8b 48 c7 c6 80 d2 ab 8b 48 c7 c2 20 c5 ab 8b b9 4c 05 00 00 e8 7c 49 77 07 90 <0f> 0b e8 d4 23 f1 fd 48 8b 3c 24 e8 db 22 01 00 48 89 c7 48 c7 c6
RSP: 0018:ffffc90000116f40 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000000000 RCX: 759e2408fa89b300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: fffffffffffffffd R08: ffffffff81713a3c R09: 1ffff92000022d3c
R10: dffffc0000000000 R11: fffff52000022d3d R12: 0000000000007000
R13: 0000000000007000 R14: ffffea00019cd168 R15: ffff888027a0b680
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f54a22c2723 CR3: 000000001d013000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __extent_writepage fs/btrfs/extent_io.c:1446 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2108 [inline]
 extent_writepages+0x1260/0x26a0 fs/btrfs/extent_io.c:2230
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2553
 __writeback_single_inode+0x155/0xfc0 fs/fs-writeback.c:1625
 writeback_sb_inodes+0x8e3/0x1220 fs/fs-writeback.c:1916
 wb_writeback+0x44d/0xc70 fs/fs-writeback.c:2092
 wb_do_writeback fs/fs-writeback.c:2239 [inline]
 wb_workfn+0x400/0xfb0 fs/fs-writeback.c:2279
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__extent_writepage_io+0xcd5/0xd00 fs/btrfs/extent_io.c:1356
Code: 77 07 90 0f 0b e8 fb 23 f1 fd 48 c7 c7 80 c5 ab 8b 48 c7 c6 80 d2 ab 8b 48 c7 c2 20 c5 ab 8b b9 4c 05 00 00 e8 7c 49 77 07 90 <0f> 0b e8 d4 23 f1 fd 48 8b 3c 24 e8 db 22 01 00 48 89 c7 48 c7 c6
RSP: 0018:ffffc90000116f40 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000000000 RCX: 759e2408fa89b300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: fffffffffffffffd R08: ffffffff81713a3c R09: 1ffff92000022d3c
R10: dffffc0000000000 R11: fffff52000022d3d R12: 0000000000007000
R13: 0000000000007000 R14: ffffea00019cd168 R15: ffff888027a0b680
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fac72b5f000 CR3: 000000001d013000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
