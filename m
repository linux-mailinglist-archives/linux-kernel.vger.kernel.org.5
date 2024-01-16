Return-Path: <linux-kernel+bounces-27112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F8F82EAA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF93FB22277
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF811724;
	Tue, 16 Jan 2024 08:05:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7654125AE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3610073a306so8499685ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 00:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705392322; x=1705997122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRJjfQnPLTBgxpKiiBjqe0Wn3Mav+RvkhMaMKCvAxdc=;
        b=CkQzKn1zvDrTwSKZy+f4Nyn5ntDES8d/BpzPf4boDj4AUg1DEwA0smfIt8RQn5NGPY
         lOlceJ4P6ZxA5YLTjhcNhVuyKduPo5qtCQG07KB4Rn9rYMWnOH3Ml1CfCDozH5jo72dl
         Rbvvm//NSTbL0hUEzrdboLS+xzh4B7oXHebxvMVre/yLcqSNMzJxjQqlRPVSQOUwwnqO
         yQ8rczyiXN4sAt608v8CZB4I0lgCyJpNFYao6LbSYCI+AV/MrlKbpPrAa70O8qlabC3C
         qXjzwnRub136tQw4mSJETQ9MOjaYhQ7UeDgWyRIjOp6yQlKHlpDiCiXWiiClz//x5gUQ
         4MOQ==
X-Gm-Message-State: AOJu0Yz8ngA2+s76FEze8tjgNfdF3u2Z4mAABfdxRwU3mneulh1t+nNc
	jpjrApEkQAi6WELWf5tq/Y6v+L0ZQWusshUq8qGIrdzIhA6M
X-Google-Smtp-Source: AGHT+IF7wz3ASbidj8tbeNxztPcS5M5jMBiWRt+3G8NchKbnGwMLXkuw3hCCLciBPEyEWc1SkDLerJotzSeGStzR2jQ/nv2lkAzl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa6:b0:35f:d9cc:1c9b with SMTP id
 l6-20020a056e021aa600b0035fd9cc1c9bmr1014379ilv.0.1705392322110; Tue, 16 Jan
 2024 00:05:22 -0800 (PST)
Date: Tue, 16 Jan 2024 00:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fef0b060f0b97cf@google.com>
Subject: [syzbot] [wireless?] WARNING in cfg80211_chandef_dfs_required
From: syzbot <syzbot+6939539b3929b3f8d8c3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cc88a5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=878a2a4af11180a7
dashboard link: https://syzkaller.appspot.com/bug?extid=6939539b3929b3f8d8c3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9085b1d0af36/disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dff804edb473/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a5cd81d366a/bzImage-052d5343.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6939539b3929b3f8d8c3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 18619 at net/wireless/chan.c:623 cfg80211_chandef_dfs_required+0x2f4/0x350 net/wireless/chan.c:623
Modules linked in:
CPU: 1 PID: 18619 Comm: kworker/1:1 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_power_efficient reg_check_chans_work
RIP: 0010:cfg80211_chandef_dfs_required+0x2f4/0x350 net/wireless/chan.c:623
Code: ee e8 40 b6 9b f7 83 fd 3f 0f 87 a7 36 9e 00 e8 c2 ba 9b f7 41 bc 01 00 00 00 89 e9 49 d3 e4 e9 86 fd ff ff e8 ad ba 9b f7 90 <0f> 0b 90 41 bc ea ff ff ff e9 72 fd ff ff e8 19 31 f3 f7 e9 84 fe
RSP: 0018:ffffc9000367fb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000367fc58 RCX: ffffffff89ec532f
RDX: ffff888054c70000 RSI: ffffffff89ec55f3 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807d7c8700 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f65d08d56c6 CR3: 000000004bbf4000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 _cfg80211_reg_can_beacon+0xaa/0x660 net/wireless/chan.c:1424
 reg_wdev_chan_valid net/wireless/reg.c:2442 [inline]
 reg_leave_invalid_chans net/wireless/reg.c:2469 [inline]
 reg_check_chans_work+0x602/0x1050 net/wireless/reg.c:2482
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

