Return-Path: <linux-kernel+bounces-56135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D921F84C67F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC64E1C21A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C720DC3;
	Wed,  7 Feb 2024 08:44:25 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5B208A9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295464; cv=none; b=VJyuHAl3q9ZvQZPZXhRn7gluGU8GVxYVdV6eUhBVMickPPknmOkCvsqskHEmi1dDBIChmGCTOZ0ixZSZeMdgZmUDRxHA2kEffwOSJa1VuH7BQVpVnczbFBzqsLRJmRlypvXIkAhHJ5RTBIcVfNibx7pEsZnY4Xt717G8dQVoFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295464; c=relaxed/simple;
	bh=eIlROG4B7EcDoLKh81C4IKrc0N6l4onNNKJepMb4FYg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dAiR8bQwYk37nUPHLpat82G5OT6fsrz/SwVKpkjU+wjLkAymb2sUck41XzJDmjS0BbQb1pKaBIU+RDVvYMgqoNU5yxvjMzz6EOlAZFonPsBYFg3wTLLhDgMeN8+8PLHf/NT0XHcduo9Bo+YSzZ/noD5AXvCncASD1de6U2lrg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so32220439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295462; x=1707900262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTU86qj7si/4Pn1nPUigCFSYaL0c1/3ps+DVLuqddlA=;
        b=DAW+1U75+0W3raGtxyFi5p1zV8wSd7AGGq/QBO+ZPk1q4i88kNxH/Z13YSqyrXo/2G
         ZdM14WO1mTyYZjLn6dO7UdkY8I/1t7rpZiIfZs2xLDIZPFPtcKoCAyRQVsj2qmqOtUeR
         lGovXb1uWoOIz+nw3FcmQtxDlhuZeBXUTqsikLiPyTiIcQCm4iiaJq1P87T3/04LFmLV
         tkjkh7xbadjGjSHyyA2lQr6C4JBtM1zWDmuXfoW5TUjurOz8Fdk5094Z7BSa1Ua+j8k0
         0DQERAtfFhYjxtAXkW0FKuKrdQ3Cu+rtDCrAS/Vdrxq4xKgiltubOGU2TBvAmOrrrT7D
         19fw==
X-Gm-Message-State: AOJu0YygKXa/lvSpjWbA9e2QSJQAbBeCFVwWoW/ojdQjmLq2xVAAZyge
	UgP7pbpGI8s4N0X6srPMVXO8jtOKe1b48BYCOQedAYqkcbKdhk0snpV8QplTvCOyLEfX9KtFUdT
	n327P7kmx/czabqxSYAm/NzmdlZqRP7Tp89/iFNYXeetBryo9shI2Lbuf9g==
X-Google-Smtp-Source: AGHT+IHnhhpmRjLY4XytKwgZN/toC6Zm16q/YGvCONoGoYwuTNbQo15GrTcFly/ahghkj6dNG2hLmkQaOG9Tw9gXJau9ScLBQnrU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dcc:b0:7c3:e384:d8a8 with SMTP id
 l12-20020a0566022dcc00b007c3e384d8a8mr178309iow.2.1707295462099; Wed, 07 Feb
 2024 00:44:22 -0800 (PST)
Date: Wed, 07 Feb 2024 00:44:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b96230610c6b3fe@google.com>
Subject: [syzbot] [usb?] [media?] possible deadlock in vb2_video_unregister_device
From: syzbot <syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, m.szyprowski@samsung.com, mchehab@kernel.org, 
	syzkaller-bugs@googlegroups.com, tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ed5551279c91 Merge 6.8-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16940d7be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28a3704ea90ef255
dashboard link: https://syzkaller.appspot.com/bug?extid=3b1d4b3d5f7a358bf9a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14450a38180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1603629fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10b543a7171a/disk-ed555127.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc10f27643e8/vmlinux-ed555127.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb6389e754b9/bzImage-ed555127.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com

usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
usbtv 1-1:0.0: Fushicai USBTV007 Audio-Video Grabber
usb 1-1: USB disconnect, device number 2
============================================
WARNING: possible recursive locking detected
6.8.0-rc3-syzkaller-00047-ged5551279c91 #0 Not tainted
--------------------------------------------
kworker/0:2/694 is trying to acquire lock:
ffff888109f20b70 (&usbtv->vb2q_lock){+.+.}-{3:3}, at: vb2_video_unregister_device drivers/media/common/videobuf2/videobuf2-v4l2.c:1269 [inline]
ffff888109f20b70 (&usbtv->vb2q_lock){+.+.}-{3:3}, at: vb2_video_unregister_device+0x12b/0x2d0 drivers/media/common/videobuf2/videobuf2-v4l2.c:1245

but task is already holding lock:
ffff888109f20b70 (&usbtv->vb2q_lock){+.+.}-{3:3}, at: usbtv_video_free+0x28/0x70 drivers/media/usb/usbtv/usbtv-video.c:966

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&usbtv->vb2q_lock);
  lock(&usbtv->vb2q_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

7 locks held by kworker/0:2/694:
 #0: ffff888106ad2138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90001c0fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff88810af2f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #2: ffff88810af2f190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5840
 #3: ffff888107799190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #3: ffff888107799190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x910 drivers/usb/core/hub.c:2287
 #4: ffff88810779a160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #4: ffff88810779a160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88810779a160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffff888109f20b70 (&usbtv->vb2q_lock){+.+.}-{3:3}, at: usbtv_video_free+0x28/0x70 drivers/media/usb/usbtv/usbtv-video.c:966
 #6: ffff888109f20ae0 (&usbtv->v4l2_lock){+.+.}-{3:3}, at: usbtv_video_free+0x32/0x70 drivers/media/usb/usbtv/usbtv-video.c:967

stack backtrace:
CPU: 0 PID: 694 Comm: kworker/0:2 Not tainted 6.8.0-rc3-syzkaller-00047-ged5551279c91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x210a/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9d0 kernel/locking/mutex.c:752
 vb2_video_unregister_device drivers/media/common/videobuf2/videobuf2-v4l2.c:1269 [inline]
 vb2_video_unregister_device+0x12b/0x2d0 drivers/media/common/videobuf2/videobuf2-v4l2.c:1245
 usbtv_video_free+0x4a/0x70 drivers/media/usb/usbtv/usbtv-video.c:970
 usbtv_disconnect+0x5c/0xd0 drivers/media/usb/usbtv/usbtv-core.c:138
 usb_unbind_interface+0x1e5/0x960 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3814
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x910 drivers/usb/core/hub.c:2296
 hub_port_connect drivers/usb/core/hub.c:5352 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 port_event drivers/usb/core/hub.c:5812 [inline]
 hub_event+0x1be0/0x4f40 drivers/usb/core/hub.c:5894
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

