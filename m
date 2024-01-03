Return-Path: <linux-kernel+bounces-15424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92BD822BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABAD1C21899
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678618E35;
	Wed,  3 Jan 2024 11:04:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8E18E00
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7fdde8b2dso1416312839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 03:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704279876; x=1704884676;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8KfXmtbwMJMKrl1dAJ+3T+XeGVJU5tYwWqQe05u00k=;
        b=mgf1R4MsbREBrtbtGxWURXjCH/jarJq9Gt9iD02v+4tJMF3wXtkz+TgG6WXL6cA28d
         3lQWLY0gq7dZVwonEoKAOhARhvu8rw0uiA2+F9EslRQNtRrOIgPmzQyKDtONqJsqgh8o
         6+2GKwksNSFfmE6Wp5jhnQDqBEkRPomf2Dw4wdk1XkLWrbGLwNAAY45HioKUi8bFATM1
         ntvOS+wLPZF9jbJ/QWG7+YMg8ypah2f4vM7btGLJdrUi9rRWIohU6tu02Daf4scSdKGF
         0NOIgYcBXW5FyTwgItyrux6muAGjOJMjZDJCT+OiL1tBrPU0LAY5Eguv8jBdvFXI1l3A
         hBaw==
X-Gm-Message-State: AOJu0YyR3cn6QLFCKUWVNz0S4eBNuDLUxPwx2ZMMIn9ZPoPkc+xnyR9X
	AIhuQCZHP7rS5sJ14hUWiil49nYIcMmxTF6APCqxyXgtUvLM
X-Google-Smtp-Source: AGHT+IHlATu/d3FvAhv+dHu8yoftsb2wcqgtUVNfCH1GkqmOkEVQAREBnssNuGCDmzykc2peSnPvOXe8ezDdtnpksyZ0c7XusCRA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:35f:9ada:73a8 with SMTP id
 m8-20020a056e021c2800b0035f9ada73a8mr3068749ilh.2.1704279876280; Wed, 03 Jan
 2024 03:04:36 -0800 (PST)
Date: Wed, 03 Jan 2024 03:04:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fa770060e089409@google.com>
Subject: [syzbot] [wireless?] WARNING: suspicious RCU usage in __cfg80211_bss_update
From: syzbot <syzbot+864a269c27ee06b58374@syzkaller.appspotmail.com>
To: benjamin.berg@intel.com, davem@davemloft.net, edumazet@google.com, 
	johannes.berg@intel.com, johannes@sipsolutions.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	miriam.rachel.korenblit@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    954fb2d2d49f Merge branch 'remove-retired-tc-uapi'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16774b7ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=864a269c27ee06b58374
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15890ef9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1764956ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4bca0ab1d263/disk-954fb2d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2766905a2c7/vmlinux-954fb2d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d12ee4a13afb/bzImage-954fb2d2.xz

The issue was bisected to:

commit 32af9a9e1069e55bc02741fb00ac9d0ca1a2eaef
Author: Benjamin Berg <benjamin.berg@intel.com>
Date:   Wed Dec 20 11:41:41 2023 +0000

    wifi: cfg80211: free beacon_ies when overridden from hidden BSS

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1496b32de80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1696b32de80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1296b32de80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+864a269c27ee06b58374@syzkaller.appspotmail.com
Fixes: 32af9a9e1069 ("wifi: cfg80211: free beacon_ies when overridden from hidden BSS")

wlan0: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
=============================
WARNING: suspicious RCU usage
6.7.0-rc6-syzkaller-01863-g954fb2d2d49f #0 Not tainted
-----------------------------
net/wireless/scan.c:1867 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
4 locks held by kworker/u4:2/35:
 #0: ffff888013071938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2602
 #1: ffffc90000abfd80 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2603
 #2: ffff88807b0f8768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5928 [inline]
 #2: ffff88807b0f8768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_wiphy_work+0x2b/0x330 net/wireless/core.c:424
 #3: ffff88807b0f8168 (&rdev->bss_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #3: ffff88807b0f8168 (&rdev->bss_lock){+...}-{2:2}, at: cfg80211_inform_single_bss_frame_data+0x8e4/0x12c0 net/wireless/scan.c:3014

stack backtrace:
CPU: 0 PID: 35 Comm: kworker/u4:2 Not tainted 6.7.0-rc6-syzkaller-01863-g954fb2d2d49f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6712
 __cfg80211_bss_update+0x17fb/0x25f0 net/wireless/scan.c:1867
 cfg80211_inform_single_bss_frame_data+0x91e/0x12c0 net/wireless/scan.c:3015
 cfg80211_inform_bss_frame_data+0x14c/0x340 net/wireless/scan.c:3050
 __ieee80211_sta_join_ibss+0xcf3/0x1880 net/mac80211/ibss.c:376
 ieee80211_sta_create_ibss+0x206/0x470 net/mac80211/ibss.c:1320
 ieee80211_sta_find_ibss net/mac80211/ibss.c:1449 [inline]
 ieee80211_ibss_work+0xbbb/0x14c0 net/mac80211/ibss.c:1666
 ieee80211_iface_work+0xbeb/0xda0 net/mac80211/iface.c:1665
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:437
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
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
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

