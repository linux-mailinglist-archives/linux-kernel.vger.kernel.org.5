Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F058E7E827A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbjKJTXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346033AbjKJTXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:23:15 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A93147F8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:20:05 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc9eb5b944so30246685ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699644005; x=1700248805;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7owKO54t8TVhRvZCU1D3o/HtWZw6Mjm2N6ztAvNpWSQ=;
        b=BsWGKBItNDewP55xAEXqH/8J1SOxAZNHoiTIl8VokFaELSyE2M/ytiBEdaHzeerVWv
         RxtioFwyOOnR0H7fjaqKEcVr2cMgomXfMOqHuMWHm/nNqEwWAX06qyocPAaK7TofkdNj
         0NTuIqoXQ6YcTWmxnxUU3vcP76Sy/anwedGHWehcUDaboW61wiXRn4V1WHYU3fs4adP+
         d3FB5s2XBrLWGpS2XbPKN16CvMCm9CkD+Z9LL/9GSw7yUt3eYmmHtUVhlCnJRMDl8/T5
         dY9q0bdJkjqhV+ri89vrEKnZJkOnUa7zVYE+umsUbNhRoOiU+uWUA5BiWXU/CrZ8bQ4I
         4uqg==
X-Gm-Message-State: AOJu0YwzFLxmgdiNoj/uo0bYiffvUi7fs0UVDbwnidC13F5kZTC2EQOv
        5GpCXpAJoLw0YnoqC8PhuRESwoELD+2Dg0PT/aCI1c7KgwARo5E=
X-Google-Smtp-Source: AGHT+IEes58+JS89oVMXVu2kmDT7N2vdWplD+mAjX7+J/vjJpQlkT0BSJvG6HNxoN5Pgvwbnq6i9yiKtCTinTbqOZc4dPEChEv2O
MIME-Version: 1.0
X-Received: by 2002:a17:903:26cd:b0:1cc:19e8:da32 with SMTP id
 jg13-20020a17090326cd00b001cc19e8da32mr12344plb.0.1699644005450; Fri, 10 Nov
 2023 11:20:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 11:20:05 -0800
In-Reply-To: <GV1PR10MB6563B11E4E004F66BD31E37DE8AEA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000308aa10609d13593@google.com>
Subject: Re: [syzbot] general protection fault in blk_mq_free_rqs
From:   syzbot <syzbot+7295389ef2000630244b@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
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
WARNING in kernfs_remove_by_name_ns

------------[ cut here ]------------
kernfs: can not remove 'nr_tags', no directory
WARNING: CPU: 0 PID: 5711 at fs/kernfs/dir.c:1662 kernfs_remove_by_name_ns+0x102/0x120 fs/kernfs/dir.c:1662
Modules linked in:
CPU: 0 PID: 5711 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15957-g826c484166f0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:kernfs_remove_by_name_ns+0x102/0x120 fs/kernfs/dir.c:1662
Code: 05 54 ff e8 d0 bc 74 ff bb fe ff ff ff 89 d8 5b 5d 41 5c 41 5d c3 e8 bd bc 74 ff 4c 89 e6 48 c7 c7 a0 b0 20 8a e8 9e 1f 3b ff <0f> 0b eb d5 e8 05 1e c8 ff e9 60 ff ff ff e8 fb 1d c8 ff e9 27 ff
RSP: 0018:ffffc90003577a48 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8149ce16
RDX: ffff888019661dc0 RSI: ffffffff8149ce23 RDI: 0000000000000001
RBP: ffffffff8cd13840 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8a6a1200
R13: 0000000000000000 R14: ffffffff8a6a1120 R15: 0000000000000002
FS:  00007ff8f2c4e6c0(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff8f1b9d0b0 CR3: 0000000074800000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_remove_by_name include/linux/kernfs.h:623 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:292
 sysfs_remove_groups fs/sysfs/group.c:316 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:308
 __kobject_del+0x83/0x1e0 lib/kobject.c:592
 kobject_del lib/kobject.c:624 [inline]
 kobject_del+0x3b/0x60 lib/kobject.c:616
 blk_mq_unregister_hctx block/blk-mq-sysfs.c:155 [inline]
 blk_mq_unregister_hctx block/blk-mq-sysfs.c:144 [inline]
 blk_mq_sysfs_unregister_hctxs+0x24a/0x2d0 block/blk-mq-sysfs.c:283
 __blk_mq_update_nr_hw_queues block/blk-mq.c:4727 [inline]
 blk_mq_update_nr_hw_queues+0x8a3/0x1350 block/blk-mq.c:4773
 nbd_start_device+0x157/0xd70 drivers/block/nbd.c:1362
 nbd_start_device_ioctl drivers/block/nbd.c:1412 [inline]
 __nbd_ioctl drivers/block/nbd.c:1487 [inline]
 nbd_ioctl+0x553/0xcc0 drivers/block/nbd.c:1527
 blkdev_ioctl+0x2f2/0x750 block/ioctl.c:633
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3b/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7ff8f1a7ad39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff8f2c4e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff8f1b9bf80 RCX: 00007ff8f1a7ad39
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000007
RBP: 00007ff8f2c4e120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007ff8f1b9bf80 R15: 00007fffa28dad08
 </TASK>


Tested on:

commit:         826c4841 Merge tag '6.7-rc-smb3-server-part2' of git:/..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=129ef91f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58c022b9cf7593c8
dashboard link: https://syzkaller.appspot.com/bug?extid=7295389ef2000630244b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
