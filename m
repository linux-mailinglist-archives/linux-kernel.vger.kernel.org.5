Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D7754A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGOQ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGOQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:59:03 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED1226B2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:59:01 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1b743cee7faso4570613fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440340; x=1692032340;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVggWaxW/y//zbxzMj5Up/8PG70H1D3JvD8YAt+BrH8=;
        b=S4PXDKALAqdWdClJC97+3px0rFoC/ILUPiOPtEf0cX8Mvp9CHI1HuiXDJwuiRqPPRz
         ayhQDqM2MNCGq8ieaLf60hulyrSr9f+Z35wExbayzOZZkQSrQN/Ar5+FCXbVcmRTrzVX
         J4WgSNrVGUtZ0IogSdtAFD07a8l06NDpKPuGr2/NJuDcuDSC2IQYmOQ1GU762/OJrh4w
         j/zUOpCnGFruz+mLhC123+cpLvZ+94Q0R0EZHilxmcF7Jg4pU77Z8Aw7F9CV5z5dOAlu
         PUM0uE+iMqx4L8HD0S0i3jAhX1ueZlQI1wL9jGLBlo/M74QT4nJSOUDtg7govVuDv2Qf
         a3kQ==
X-Gm-Message-State: ABy/qLaq0W6aMhj1vbQg1kbzVmumoa8lf2F0IYmdK3nIYrz/Hk9flJdJ
        P68dzlMh8embBtb+dUo9EmdrSk7OAZkw2zDi6kPffQnTGH/K
X-Google-Smtp-Source: APBJJlHiIE+UxfTCFUslPbf6t9y+2TdEnS71GrV0V7tk323+8NpCl1UrA6V7rN5jD9rPYQDzSuqQxp3UUDohHVfgDch0q2r+qg3N
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b35:b0:1b0:3f7f:673e with SMTP id
 ds53-20020a0568705b3500b001b03f7f673emr6699714oab.6.1689440340161; Sat, 15
 Jul 2023 09:59:00 -0700 (PDT)
Date:   Sat, 15 Jul 2023 09:59:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005839700600897be6@google.com>
Subject: [syzbot] [wireless?] WARNING in sta_info_insert_rcu (3)
From:   syzbot <syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ebiederm@xmission.com, edumazet@google.com,
        hbh25y@gmail.com, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11089df2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=2676771ed06a6df166ad
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122f5682a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158dbaeca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47d90db1f2d1/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/266e07b43566/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62efdb874ac7/bzImage-3f01e9fe.xz

The issue was bisected to:

commit c579d60f0d0cd87552f64fdebe68b5d941d20309
Author: Hangyu Hua <hbh25y@gmail.com>
Date:   Fri Jul 15 06:23:01 2022 +0000

    ipc: mqueue: fix possible memory leak in init_mqueue_fs()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a40b58a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a40b58a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a40b58a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com
Fixes: c579d60f0d0c ("ipc: mqueue: fix possible memory leak in init_mqueue_fs()")

wlan1: authenticate with 08:02:11:00:00:01
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1148 at net/mac80211/sta_info.c:728 sta_info_insert_check net/mac80211/sta_info.c:728 [inline]
WARNING: CPU: 1 PID: 1148 at net/mac80211/sta_info.c:728 sta_info_insert_rcu+0x25e/0x1af0 net/mac80211/sta_info.c:940
Modules linked in:
CPU: 1 PID: 1148 Comm: kworker/1:2 Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: events cfg80211_conn_work
RIP: 0010:sta_info_insert_check net/mac80211/sta_info.c:728 [inline]
RIP: 0010:sta_info_insert_rcu+0x25e/0x1af0 net/mac80211/sta_info.c:940
Code: e8 a7 14 ef f7 44 89 e0 31 ff 83 e0 01 89 c6 88 44 24 08 e8 74 10 ef f7 0f b6 44 24 08 84 c0 0f 84 19 01 00 00 e8 82 14 ef f7 <0f> 0b c7 44 24 08 ea ff ff ff e8 73 14 ef f7 48 8b 7c 24 28 4c 89
RSP: 0018:ffffc90005bff1f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888027478c80 RCX: 0000000000000000
RDX: ffff888021f78000 RSI: ffffffff8995cd3e RDI: 0000000000000005
RBP: 0000000000000100 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000000f R12: 0000000000110208
R13: ffff8880768fc048 R14: ffff88807d171730 R15: ffff8880768fc000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8913442270 CR3: 000000000c775000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sta_info_insert+0x17/0xd0 net/mac80211/sta_info.c:953
 ieee80211_prep_connection+0x5fd/0x14a0 net/mac80211/mlme.c:7047
 ieee80211_mgd_auth+0x891/0x1170 net/mac80211/mlme.c:7205
 rdev_auth net/wireless/rdev-ops.h:481 [inline]
 cfg80211_mlme_auth+0x3b3/0x8c0 net/wireless/mlme.c:284
 cfg80211_conn_do_work+0xd3c/0xff0 net/wireless/sme.c:181
 cfg80211_conn_work+0x27f/0x3d0 net/wireless/sme.c:273
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
