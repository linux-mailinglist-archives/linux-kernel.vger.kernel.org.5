Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CAC773CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjHHQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjHHQHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:35 -0400
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC035AE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:10 -0700 (PDT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-583f048985bso75325797b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509542; x=1692114342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJfhj9HHXLyB27WPAbewovTVjklfniI3dZUmR27+dCM=;
        b=i37VUb0mY+orrFfHNbjN0HQ2XSKA3t6ODB/75bw0d/ySc3lbRiybiGusc+yS3rh8bj
         Hij7fNW2pp97o7nYE/TrdaIDw6zsffWSToFE/XTYfVlpjUsDzdDsbV2p1a8SX4bkKx0I
         0vRHmxBk2U5TGU+9GDP4YkaUAAB2S/S6BL78PGuJzVykzGTT3pq+szAj0D6fbOOiiL8R
         mdzmdag+BAoLrLHoxIelpd43/B+dt+1q2r6qt+OXITjHeQZjZg5xHXjDAmNxHI4oRN8W
         5pdgUSrg7JmMG4HsD7DdCzukONNFfA4FAhL+bL1P1lkuIYs0kaaXgudgRdaDJsPLIxxk
         M1uw==
X-Gm-Message-State: AOJu0Yx8GlTbUbuZgaTsRK4EM9A9EJWl8qGhypXqTvUFsEc1+weNFQRR
        ZO0kaSvN2ZypMvEQx1aURfyTm4HUDSJ9QT+yV5BP274S9LeX
X-Google-Smtp-Source: AGHT+IHQjD3vX/mncBoe0qaWjJqw35pUS1ucwStnXRIuXdGd2a7Pcp1aQemE+qy/bSRHw5nrHqivBs3MeRPTnuykC79Da04vOEke
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b7af:b0:1bb:5085:8201 with SMTP id
 ed47-20020a056870b7af00b001bb50858201mr16322025oab.6.1691505028329; Tue, 08
 Aug 2023 07:30:28 -0700 (PDT)
Date:   Tue, 08 Aug 2023 07:30:28 -0700
In-Reply-To: <20230808140807.1967-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059799d06026a3452@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_open_devices
From:   syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: corrupted list in btrfs_close_devices

BTRFS info (device loop2): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop2): force clearing of disk cache
BTRFS info (device loop2): setting nodatasum
BTRFS error (device loop2): unrecognized mount option 'rescan	'
list_del corruption, ffff888065d38c20->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5647 Comm: syz-executor.2 Not tainted 6.5.0-rc5-next-20230807-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__list_del_entry_valid+0xfd/0x1b0 lib/list_debug.c:53
Code: 18 c3 48 c7 c7 80 8f c8 8a e8 9f 70 43 fd 0f 0b 48 c7 c7 e0 8f c8 8a e8 91 70 43 fd 0f 0b 48 c7 c7 40 90 c8 8a e8 83 70 43 fd <0f> 0b 48 89 ca 48 c7 c7 a0 90 c8 8a e8 72 70 43 fd 0f 0b 48 89 c2
RSP: 0018:ffffc90002f7f700 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff888065d38c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816a9732 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888065d38d30
R13: ffffc90002f7f758 R14: ffff888065d38c20 R15: ffff888065d38c28
FS:  00007f38da2476c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbe2639d988 CR3: 0000000064991000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 btrfs_close_devices+0x460/0x790 fs/btrfs/volumes.c:1208
 open_ctree+0x1c1/0x5700 fs/btrfs/disk-io.c:3612
 btrfs_fill_super fs/btrfs/super.c:1158 [inline]
 btrfs_mount_root+0x9af/0xeb0 fs/btrfs/super.c:1521
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1584
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f38d947e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38da246ee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f38da246f80 RCX: 00007f38d947e1ea
RDX: 00000000200051c0 RSI: 0000000020005200 RDI: 00007f38da246f40
RBP: 00000000200051c0 R08: 00007f38da246f80 R09: 0000000001000008
R10: 0000000001000008 R11: 0000000000000246 R12: 0000000020005200
R13: 00007f38da246f40 R14: 00000000000051ab R15: 0000000020000280
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid+0xfd/0x1b0 lib/list_debug.c:53
Code: 18 c3 48 c7 c7 80 8f c8 8a e8 9f 70 43 fd 0f 0b 48 c7 c7 e0 8f c8 8a e8 91 70 43 fd 0f 0b 48 c7 c7 40 90 c8 8a e8 83 70 43 fd <0f> 0b 48 89 ca 48 c7 c7 a0 90 c8 8a e8 72 70 43 fd 0f 0b 48 89 c2
RSP: 0018:ffffc90002f7f700 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff888065d38c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816a9732 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888065d38d30
R13: ffffc90002f7f758 R14: ffff888065d38c20 R15: ffff888065d38c28
FS:  00007f38da2476c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f6962e3b0 CR3: 0000000064991000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         f7dc24b3 Add linux-next specific files for 20230807
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=170b2395a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e4981ba80000

