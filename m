Return-Path: <linux-kernel+bounces-86250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A186C2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD251C212CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9047768;
	Thu, 29 Feb 2024 07:51:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA73BBFB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193065; cv=none; b=OpcYKoXiXP4z39H2gNjBFFcmwow4uajBYsjhGsLxGvx1gdF1iPsVuZKfzuszWlX/WHHxOd7J9MsXkwAmJeJX4kQ3ZAo9xhzOG2OLzLByyxkm7VeoJsWd/RP+t7Mpilp7ruFvVDkLs7OPVVDSDbF5EKAAM3Kpnas2suNKj37dsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193065; c=relaxed/simple;
	bh=UTzIZHh312FQNv3tRh7qf5GzLXbBMBW+MciNmJj0JrQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Joy6meHNllibB0FlYp8gC8VgnH7+1oY8NkVhevJTioDU93+S4OKQvzhjDMxFYNX4qwC7FKocvFJYrTFWJrbEYTWvDZv2jI4YiFQxIvMsJRmiz3LrKX5wZBdBahyGHSQulCPoExgPvpdwwoopiIhzm76tRMvFqucZ2L35Bsc9IFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c78505a39eso77903039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709193062; x=1709797862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8U5P0GXuc+YHZ9MbzKcsIkuCHeeUzRRswz+LIBm/r4=;
        b=kUEEpUa2yCT/bUQMK5CyufoC5OE9sCr8XA8vIIuss6UTaUgVI+4YiHtgdcI5XL6L8w
         kVYw+qNMpd79o4NEsXt5gK4xFXdPZLBpz78zLAMxeqRQajyvr3+CAvqkA7nObODUuX3W
         OifGtRgie0zFcoyjSkvPKrnlvNYPjh8V+Bii0FKc3Z0qpCRGN/lYUM8IK3A1BoeDO0iV
         2xWQSRNTK8bVFzCasocgcS1a+f69XmW6iP+iKtLKtwvosyuCWgW0XDqdc/7pLabLI34X
         as3Vrjyy8PP4cNJOwWcHjmJlM19NvQ/1yoO1nMZb1HguiqJnxQln+H0VcWxNd3EjaHcg
         j1tQ==
X-Gm-Message-State: AOJu0YyHON2cha06CpEsm+uXa6SHZqi0yd7tdbVMaSHTzewjcocYOyCB
	rxwvcCgbT5o/9kh/yuaKfCe8nfYP6ytGoTWC+e7FKLjfOnu+1rmcO/91RuZl1gYkYIP2RvOy4ac
	fQaj57lCOn6Wa3rloVaEkcByKkt/LtDeTvCt9RMG3A8etjQap4VlGUcBj7g==
X-Google-Smtp-Source: AGHT+IGZxVsOU/D5iC1fida8wWele+lavnBb7G4muhKPLrv4qzTwuiGzIzwM7/qRigSMZj2TrEc7YLcZqTfzdDqmwYlOHC7kJFpL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c564:0:b0:365:bcee:5dc0 with SMTP id
 b4-20020a92c564000000b00365bcee5dc0mr109849ilj.3.1709193062649; Wed, 28 Feb
 2024 23:51:02 -0800 (PST)
Date: Wed, 28 Feb 2024 23:51:02 -0800
In-Reply-To: <20240229072016.186240-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a1ac1061280857e@google.com>
Subject: Re: [syzbot] [media?] [usb?] INFO: task hung in vb2_video_unregister_device
From: syzbot <syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in vb2_video_unregister_device

usb 1-1: config 0 descriptor??
usbtv 1-1:0.0: Fushicai USBTV007 Audio-Video Grabber
usb 1-1: USB disconnect, device number 2
============================================
WARNING: possible recursive locking detected
6.8.0-rc6-syzkaller-g805d849d7c3c-dirty #0 Not tainted
--------------------------------------------
kworker/0:4/6186 is trying to acquire lock:
ffff0000cd544b90 (&usbtv->vb2q_lock){+.+.}-{3:3}, at: vb2_video_unregister_device+0xe8/0x1ac drivers/media/common/videobuf2/videobuf2-v4l2.c:1268

but task is already holding lock:
ffff0000cd544b90 (&usbtv->vb2q_lock){+.+.}-{3:3}, at: usbtv_video_free+0x2c/0x84 drivers/media/usb/usbtv/usbtv-video.c:966

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&usbtv->vb2q_lock);
  lock(&usbtv->vb2q_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

7 locks held by kworker/0:4/6186:
 #0: ffff0000c252f138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x560/0x1204 kernel/workqueue.c:2606
 #1: ffff800097b77c20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x5a0/0x1204 kernel/workqueue.c:2608
 #2: ffff0000ccf38190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #2: ffff0000ccf38190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1b4/0x435c drivers/usb/core/hub.c:5811
 #3: ffff0000c73fb190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #3: ffff0000c73fb190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0xec/0x808 drivers/usb/core/hub.c:2258
 #4: ffff0000d811b160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #4: ffff0000d811b160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff0000d811b160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xbc/0x6a0 drivers/base/dd.c:1292
 #5: ffff0000cd544b90 (&usbtv->vb2q_lock){+.+.}-{3:3}, at: usbtv_video_free+0x2c/0x84 drivers/media/usb/usbtv/usbtv-video.c:966
 #6: ffff0000cd544b00 (&usbtv->v4l2_lock){+.+.}-{3:3}, at: usbtv_video_free+0x3c/0x84 drivers/media/usb/usbtv/usbtv-video.c:967

stack backtrace:
CPU: 0 PID: 6186 Comm: kworker/0:4 Not tainted 6.8.0-rc6-syzkaller-g805d849d7c3c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: usb_hub_wq hub_event
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_deadlock_bug+0x4e4/0x660 kernel/locking/lockdep.c:3012
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x5fe4/0x763c kernel/locking/lockdep.c:5137
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
 __mutex_lock kernel/locking/mutex.c:752 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
 vb2_video_unregister_device+0xe8/0x1ac drivers/media/common/videobuf2/videobuf2-v4l2.c:1268
 usbtv_video_free+0x4c/0x84 drivers/media/usb/usbtv/usbtv-video.c:970
 usbtv_disconnect+0x6c/0xc4 drivers/media/usb/usbtv/usbtv-core.c:138
 usb_unbind_interface+0x1a4/0x758 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x440/0x6a0 drivers/base/dd.c:1295
 device_release_driver+0x28/0x38 drivers/base/dd.c:1318
 bus_remove_device+0x314/0x3b4 drivers/base/bus.c:574
 device_del+0x480/0x87c drivers/base/core.c:3828
 usb_disable_device+0x354/0x760 drivers/usb/core/message.c:1416
 usb_disconnect+0x290/0x808 drivers/usb/core/hub.c:2267
 hub_port_connect drivers/usb/core/hub.c:5323 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
 port_event drivers/usb/core/hub.c:5783 [inline]
 hub_event+0x18ec/0x435c drivers/usb/core/hub.c:5865
 process_one_work+0x694/0x1204 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x970/0xef4 kernel/workqueue.c:2787
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


Tested on:

commit:         805d849d Merge tag 'acpi-6.8-rc7' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12b53522180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e412105d06db24c2
dashboard link: https://syzkaller.appspot.com/bug?extid=2622b51b35f91a00ea18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17181132180000


