Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3BA7ABD59
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 05:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjIWDC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 23:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIWDC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 23:02:26 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8AAF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:02:20 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1d5f4d5d848so5475719fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695438139; x=1696042939;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uu32FH5I0aOOlscucTgtn1W8kPW6Yu+PCrBGTKgAmec=;
        b=aYNvNJcqVIinJ1FAy9JwXf6vursHRGG2BoIAJ62BViAurpeGbZRTjzPa9oLIbk/n/8
         QcND3YDX/4BmFzXP4I7va8Khc/svCRjHlsb1HubXgPTHyENehbSon2PPwbGXxaMUkcW2
         2qTNMBTDOClQjCc4UTqidRKjlREUbwmCsK+MPPFA6VdYXWOwPGvoTtEUBWsbEJMTmWd8
         HFaEGnRL3NVt5gm8kGnwK6iaBQoOZwOqz5QzoegqOs/z/1cBDptJGC21X/mHiHY+Aqfq
         tnG7igjCfeaX9RiR1oSM4WuWxIPO3jfboiC3IL2fwegC1Aq2/N2MtNV6Vs0VGX5eqyaF
         YfKw==
X-Gm-Message-State: AOJu0YxXL2S3r74il5djDSzBcLKewga7E1+BBFMpE6gI485cl7sDbsJ7
        AfGSfxxGrxfEOZyqcKfly0IN3SJ8ayuCiDOhfLY4NCleRmV6
X-Google-Smtp-Source: AGHT+IGWiALkUFQq8JtvACP5ysE7sqt0G9y7yszInXqu6JETAgZ7QLXpc5GHOYiA9PsNtXf19ufkwa8Mefg9682vGDjZV6oQ+wEy
MIME-Version: 1.0
X-Received: by 2002:a05:6870:706:b0:1d6:c007:ff90 with SMTP id
 ea6-20020a056870070600b001d6c007ff90mr524165oab.6.1695438139447; Fri, 22 Sep
 2023 20:02:19 -0700 (PDT)
Date:   Fri, 22 Sep 2023 20:02:19 -0700
In-Reply-To: <20230923024635.1249-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a63170605fdf4cc@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in dquot_disable

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5401 at fs/quota/dquot.c:2217 dquot_disable+0xff1/0x1710 fs/quota/dquot.c:2217
Modules linked in:
CPU: 0 PID: 5401 Comm: syz-executor.0 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:dquot_disable+0xff1/0x1710 fs/quota/dquot.c:2217
Code: d2 0f 85 fd 04 00 00 8b 15 48 34 c1 0c 48 c7 c6 ff ff ff ff 48 c7 c7 a0 f4 34 92 e8 19 41 46 02 e9 6f f7 ff ff e8 4f 43 7a ff <0f> 0b 48 89 ef e8 25 95 59 ff e9 a6 f0 ff ff e8 3b 43 7a ff 4c 8d
RSP: 0018:ffffc9000382fb60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880287c0140 RSI: ffffffff820c8201 RDI: 0000000000000005
RBP: ffff888077efc070 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888077efc000 R14: ffffffff8aa27800 R15: 1ffff92000705f79
FS:  0000555555e27480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb752142378 CR3: 00000000212c7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_quota_off+0x11f/0x160 fs/reiserfs/super.c:2480
 reiserfs_quota_off_umount fs/reiserfs/super.c:581 [inline]
 reiserfs_put_super+0x8f/0x5c0 fs/reiserfs/super.c:594
 generic_shutdown_super+0x2ab/0x400 fs/super.c:727
 kill_block_super+0x3b/0x70 fs/super.c:1650
 deactivate_locked_super+0x9a/0x170 fs/super.c:481
 deactivate_super+0xde/0x100 fs/super.c:514
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7effb087de17
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc59c8ec28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007effb087de17
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc59c8ece0
RBP: 00007ffc59c8ece0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffc59c8fda0
R13: 00007effb08c73b9 R14: 000000000001d8a7 R15: 0000000000000005
 </TASK>


Tested on:

commit:         2cf0f715 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d0480a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11959f5c680000

