Return-Path: <linux-kernel+bounces-69831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A45858F3B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484E51F22931
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF856A032;
	Sat, 17 Feb 2024 12:01:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF86A013
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708171287; cv=none; b=KiRU0Nt6WIsEuJ34ueSdhSt/7Rjm4m6oS0YFljh5VYJolcAHiDQ3UQA9RNvf4NUmHxZhnuJpttS/XFkhXXthDdrZ4ij6Ou3Z6EN2UBQHKz9XQmC+psHpwZuH9nxG61mKa81rCFS2qPXcUNTMNQT8271QuBsOFVjbFEaP3XkvrgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708171287; c=relaxed/simple;
	bh=TKNDTk6cDfx4Tfo2sfcKfBCYJUV1fslPCCnc6uKRgHw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dToT522EXxiiz7dU7tzn2AXEKfVUJtbCr+b8bWsi3brZMpb1+02xSHCA/G/KdP2ym+QSXjQzF/PXOgt5fFr/6tZi8SaeeElScQ0nLrGUu3D+HdcmsmM0xI3jYKk4/wmxe5mUBJVN4Zdiqeyr/02DZkjxld/QHmcdlwC13ecy2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bff2d672a5so188606239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708171284; x=1708776084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCUkGWydL6iOVrCaNdXAVKDKwK1uPVYLhmNtgDugTwk=;
        b=AbjV3djiE3vr9U8rUgoxO2ZoDH5ZQGzcUAZkGLfGF3ic1hOiXIktY+YFmaFTQbO0rr
         rPml/7qjj1fMHdQU5FKbHCdXe9xk/SNyJb9kHUn7bqO47D7+DGGP/SXPip0EVYkfYDuZ
         47skYALUhffysEkW3gwsGlHm6FyZRr/v7ae1RhUnr6m8JsFPQNR32eSKkQb+oVbmmoa1
         LcfAcpM+8BsixHmGTmWwE/1f4chewAKPLcqzfXPhp/DD1sy3ZxvoKS4Stkts1JN1RQ4k
         ysMegv6fhEbh9QYs1eQF4aCyOvVDp0tRBWFF7JC8M/aVM4N7o5YIxnwfl0aoKOIZu4Rb
         fT/g==
X-Forwarded-Encrypted: i=1; AJvYcCXB02+0KXN1qUHEeAmGghADy2iMpwCOEk1ivhhIqMWTwbdTB5hFrmLPyqlEAgoCSrBY5whsThFT/H4GaNFzV1KNycZsy6xCQxj2sTw0
X-Gm-Message-State: AOJu0YzH6eDhceNpHH6ReJdYAOdRbfO/EKjNWm1uZq9FVABL3Zn7kJ9p
	ZnOZ1Z245hD4eXzPR9dTSeJqwxw5MXj7HUj+WNjDmXge9WL+uq5t7Gb87DfVZ6ZKG+mYRE8Yk0t
	CN97zIr1+KHmXRlg/8Gu9wMzaHzwpLAtyqsLVRyLbxsf4gdgeoXpYWF8=
X-Google-Smtp-Source: AGHT+IEEJceRsj6HUwp0xXY4QnLafQ5Y621FM+VV+kmu6aMGtzzhbyI7k5DgbRVnzgL6w5PhvJGwC5yDN/zc90oT+Z7jVYf2sJXa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6a:b0:363:8396:a068 with SMTP id
 w10-20020a056e021a6a00b003638396a068mr460601ilv.5.1708171283081; Sat, 17 Feb
 2024 04:01:23 -0800 (PST)
Date: Sat, 17 Feb 2024 04:01:23 -0800
In-Reply-To: <0000000000004b841a060e876595@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b34440611929e64@google.com>
Subject: Re: [syzbot] [usb?] [input?] WARNING in input_unregister_device (2)
From: syzbot <syzbot+617f4ccb03b9869f6494@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c1ca10ceffbb Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15159df0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=617f4ccb03b9869f6494
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f415fc180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ecf362180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/842b77f831b0/disk-c1ca10ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/057da06d8a4b/vmlinux-c1ca10ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4382274a169/bzImage-c1ca10ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+617f4ccb03b9869f6494@syzkaller.appspotmail.com

input: HID 045e:07da as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.0/0003:045E:07DA.0060/input/input100
microsoft 0003:045E:07DA.0060: input,hidraw0: USB HID v0.00 Device [HID 045e:07da] on usb-dummy_hcd.0-1/input0
usb 1-1: USB disconnect, device number 97
------------[ cut here ]------------
add_uevent_var: buffer size too small
WARNING: CPU: 0 PID: 782 at lib/kobject_uevent.c:671 add_uevent_var+0x2d5/0x450 lib/kobject_uevent.c:671
Modules linked in:
CPU: 0 PID: 782 Comm: kworker/0:2 Not tainted 6.8.0-rc4-syzkaller-00331-gc1ca10ceffbb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:add_uevent_var+0x2d5/0x450 lib/kobject_uevent.c:671
Code: 0f b6 04 27 84 c0 0f 85 28 01 00 00 48 8b 44 24 18 01 18 31 c0 eb 2b e8 09 07 39 f6 90 48 c7 c7 60 e3 c5 8c e8 0c 12 fd f5 90 <0f> 0b 90 90 b8 f4 ff ff ff 49 bc 00 00 00 00 00 fc ff df 4c 8b 6c
RSP: 0018:ffffc90003d3ef20 EFLAGS: 00010246
RAX: 7e434c7b33a2b100 RBX: 00000000000007f5 RCX: ffff88801fd91dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003d3f050 R08: ffffffff81577992 R09: 1ffff920007a7d84
R10: dffffc0000000000 R11: fffff520007a7d85 R12: 000000000000000b
R13: 000000000000000b R14: 1ffff1100fc77443 R15: 1ffff1100fc77543
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc10ead20f0 CR3: 000000002db96000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kobject_uevent_env+0x520/0x8f0 lib/kobject_uevent.c:588
 device_del+0x812/0xa30 drivers/base/core.c:3832
 input_unregister_device+0xa3/0x100 drivers/input/input.c:2440
 hidinput_disconnect+0x26c/0x300 drivers/hid/hid-input.c:2388
 hid_disconnect drivers/hid/hid-core.c:2280 [inline]
 hid_hw_stop+0x75/0x1e0 drivers/hid/hid-core.c:2329
 ms_remove+0x23/0xa0 drivers/hid/hid-microsoft.c:409
 hid_device_remove+0x225/0x370
 device_remove drivers/base/dd.c:567 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x4a9/0x7c0 drivers/base/dd.c:1295
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
 device_del+0x580/0xa30 drivers/base/core.c:3814
 hid_remove_device drivers/hid/hid-core.c:2867 [inline]
 hid_destroy_device+0x68/0x100 drivers/hid/hid-core.c:2887
 usbhid_disconnect+0x9e/0xc0 drivers/hid/usbhid/hid-core.c:1456
 usb_unbind_interface+0x1d4/0x850 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1295
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
 device_del+0x580/0xa30 drivers/base/core.c:3814
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1416
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2267
 hub_port_connect drivers/usb/core/hub.c:5323 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
 port_event drivers/usb/core/hub.c:5783 [inline]
 hub_event+0x1e62/0x50f0 drivers/usb/core/hub.c:5865
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

