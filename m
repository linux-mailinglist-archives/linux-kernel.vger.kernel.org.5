Return-Path: <linux-kernel+bounces-144741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABF8A4A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C181C221F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E5376E7;
	Mon, 15 Apr 2024 08:14:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C862E652
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168865; cv=none; b=I5GSrliMm8j1uNDUu6ud7bEHd6inVi3+ZusxXEQXy8ZYdM35Sv/SCEkificvbxI+NzKvfgB9ZSyo6xh38+g6wfrEp6CL9qNXF7C0vAQN54UqnJRrow+GxIYA6+OLDu3Cyyh2c9Yv8Q2p6yS+42d+Ruf2DGnLnBtLfhtWllMbdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168865; c=relaxed/simple;
	bh=EXu1YamII0jBrmX1jolH50irNc885vfZZELz9VpEyBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KpPbXdfzA50pms4HiEAJXtGRORcolzBbHehrDGWbK+R5yIQm5GR0JvznTwgKxODwIl2ZXM99qVKGgahFBYb7/yjvcet5/R023IHseki9Gn847rbmxfguqnhQ3utZYgOvsD6bi01JnspupAUJLCgLeDouBBuO10LpiH0Mc8g/sF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-369f714fedcso30393075ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168862; x=1713773662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unBRzWypSrJQ8YW71ur/h2ey7MzVUScJD83UCwpFu3U=;
        b=d4T4sOSrG5sEUpAy9pbiisaOYGcUP/+lnpXRFokiAQF0PnYaGiuS2ryBRTzJQ4RGls
         c+xtxCXqD4fd46gNAvl7E8KrXplpuifmYa3XGsMHubdjmxIFd69AHpvksjRT9+1uONac
         TO0kSzbvxhC2tPId1msP+xzSlbLpYGq1/c+VyvSBsB0zevI0jZ1EsV7mhYX9n1CU0E+a
         zyYzAFaDMLhp3IgboK2vTBWhQ1LEYbcddN//6ZEjuqL3CYAnxgjRMKCPzYpAEz6fIp/v
         D23vIMEhjJaNEwbHAQqfIrrJ5gnB+ir2Ex9i+gA28V4cqhGuhDmmp46xorHVx0xgaFHi
         pZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCVeZsvych7PRq+Ee7Jrzo2GMu3ma/q4OGkdXd0YJ8WQQeXnmbUiYDrXbVVrf+5o2unHFsWFgVyIo3zJ0QwjxV3nWyhPnmwa2Ox6WdJJ
X-Gm-Message-State: AOJu0Yy4bO8jTqIv6A5C7n4XG2O2WVD5rXNRHQfoAGaWgTEnfZs6ihrr
	ouQzuNgJiyVXK0JcuDvewv+LdIqRV4sL4EbjuRiCQ/qgly+k3IDivOrpyg7bCQq0o+1/9Yoc0aG
	BEbBMRIvo4qDaPibNJuVjvE852ZZrcV9RHZpIUiOdVfBT7oGT3geIKZA=
X-Google-Smtp-Source: AGHT+IEt3SFuLEiRKDlVYQ8lLq+THHzy+aJwZ3u9HCjYjg3DmzNFxh+OUklfjwvf4wh66nqlMGaGqBhqRJ4fnfghxa4APKwLygcH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8c:b0:368:c21e:3898 with SMTP id
 h12-20020a056e021d8c00b00368c21e3898mr581433ila.3.1713168862732; Mon, 15 Apr
 2024 01:14:22 -0700 (PDT)
Date: Mon, 15 Apr 2024 01:14:22 -0700
In-Reply-To: <000000000000f94ee2061458a2e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080f98606161e35c8@google.com>
Subject: Re: [syzbot] [usb?] WARNING: ODEBUG bug in netdev_freemem (3)
From: syzbot <syzbot+83845bb93916bb30c048@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    72374d71c315 Merge tag 'pull-sysfs-annotation-fix' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1391f7cb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2881987c7d7b722d
dashboard link: https://syzkaller.appspot.com/bug?extid=83845bb93916bb30c048
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147d8f6d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fb0bf3180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-72374d71.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/664d9f3a4812/vmlinux-72374d71.xz
kernel image: https://storage.googleapis.com/syzbot-assets/767ecc5e77ad/zImage-72374d71.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83845bb93916bb30c048@syzkaller.appspotmail.com

cdc_ncm 1-1:1.0 usb0: register 'cdc_ncm' at usb-dummy_hcd.0-1, CDC NCM (NO ZLP), 42:42:42:42:42:42
usb 1-1: USB disconnect, device number 10
cdc_ncm 1-1:1.0 usb0: unregister 'cdc_ncm' usb-dummy_hcd.0-1, CDC NCM (NO ZLP)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 45 at lib/debugobjects.c:514 debug_print_object+0xc4/0xd8 lib/debugobjects.c:514
ODEBUG: free active (active state 0) object: 841377ac object type: work_struct hint: usbnet_deferred_kevent+0x0/0x388 drivers/net/usb/usbnet.c:630
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 45 Comm: kworker/0:2 Not tainted 6.9.0-rc3-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: usb_hub_wq hub_event
Call trace: 
[<818a18bc>] (dump_backtrace) from [<818a19b8>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:82622e44 r5:00000000 r4:81fcea10
[<818a19a0>] (show_stack) from [<818bf0e0>] (__dump_stack lib/dump_stack.c:88 [inline])
[<818a19a0>] (show_stack) from [<818bf0e0>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:114)
[<818bf08c>] (dump_stack_lvl) from [<818bf120>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:8285ad18
[<818bf108>] (dump_stack) from [<818a2460>] (panic+0x120/0x358 kernel/panic.c:348)
[<818a2340>] (panic) from [<8024390c>] (check_panic_on_warn kernel/panic.c:241 [inline])
[<818a2340>] (panic) from [<8024390c>] (print_tainted+0x0/0xa0 kernel/panic.c:236)
 r3:8260c584 r2:00000001 r1:81fb773c r0:81fbf2e0
 r7:8080a0d0
[<80243898>] (check_panic_on_warn) from [<80243b00>] (__warn+0x7c/0x180 kernel/panic.c:694)
[<80243a84>] (__warn) from [<80243dec>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:727)
 r8:00000009 r7:8201b320 r6:df919a7c r5:82fd3c00 r4:00000000
[<80243c08>] (warn_slowpath_fmt) from [<8080a0d0>] (debug_print_object+0xc4/0xd8 lib/debugobjects.c:514)
 r10:00000005 r9:84137000 r8:81a02b44 r7:82043274 r6:828be454 r5:df919b24
 r4:8260ce18
[<8080a00c>] (debug_print_object) from [<8080b968>] (__debug_check_no_obj_freed lib/debugobjects.c:989 [inline])
[<8080a00c>] (debug_print_object) from [<8080b968>] (debug_check_no_obj_freed+0x254/0x2a0 lib/debugobjects.c:1019)
 r8:84137800 r7:841377ac r6:00000100 r5:00000003 r4:00000000
[<8080b714>] (debug_check_no_obj_freed) from [<804b2820>] (slab_free_hook mm/slub.c:2078 [inline])
[<8080b714>] (debug_check_no_obj_freed) from [<804b2820>] (slab_free mm/slub.c:4280 [inline])
[<8080b714>] (debug_check_no_obj_freed) from [<804b2820>] (kfree+0x1a0/0x334 mm/slub.c:4390)
 r10:82775a28 r9:84534880 r8:84137000 r7:8045a920 r6:82c023c0 r5:dde8bac0
 r4:84137000
[<804b2680>] (kfree) from [<8045a920>] (kvfree+0x2c/0x30 mm/util.c:680)
 r10:82775a28 r9:84534880 r8:84137000 r7:00000000 r6:844b9480 r5:84652200
 r4:84137000
[<8045a8f4>] (kvfree) from [<813dbb0c>] (netdev_freemem+0x1c/0x20 net/core/dev.c:10797)
 r5:84652200 r4:84137000
[<813dbaf0>] (netdev_freemem) from [<81416b74>] (netdev_release+0x2c/0x34 net/core/net-sysfs.c:2031)
[<81416b48>] (netdev_release) from [<80a404e0>] (device_release+0x38/0xa8 drivers/base/core.c:2580)
 r5:84652200 r4:841373b8
[<80a404a8>] (device_release) from [<8187b820>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80a404a8>] (device_release) from [<8187b820>] (kobject_release lib/kobject.c:720 [inline])
[<80a404a8>] (device_release) from [<8187b820>] (kref_put include/linux/kref.h:65 [inline])
[<80a404a8>] (device_release) from [<8187b820>] (kobject_put+0xc8/0x1f8 lib/kobject.c:737)
 r5:81b489c4 r4:841373b8
[<8187b758>] (kobject_put) from [<80a40768>] (put_device+0x18/0x1c drivers/base/core.c:3828)
 r7:84536800 r6:8413710c r5:84137000 r4:00000000
[<80a40750>] (put_device) from [<813cce58>] (free_netdev+0x108/0x188 net/core/dev.c:10993)
[<813ccd50>] (free_netdev) from [<80d10be0>] (usbnet_disconnect+0xac/0xf0 drivers/net/usb/usbnet.c:1636)
 r6:84137774 r5:84137660 r4:00000000
[<80d10b34>] (usbnet_disconnect) from [<80d6bcc4>] (usb_unbind_interface+0x84/0x2c4 drivers/usb/core/driver.c:461)
 r8:00000044 r7:84536830 r6:82775a28 r5:00000000 r4:84536800
[<80d6bc40>] (usb_unbind_interface) from [<80a485bc>] (device_remove drivers/base/dd.c:568 [inline])
[<80d6bc40>] (usb_unbind_interface) from [<80a485bc>] (device_remove+0x64/0x6c drivers/base/dd.c:560)
 r10:84534880 r9:828eed04 r8:00000044 r7:84536874 r6:82775a28 r5:00000000
 r4:84536830
[<80a48558>] (device_remove) from [<80a49ad4>] (__device_release_driver drivers/base/dd.c:1270 [inline])
[<80a48558>] (device_remove) from [<80a49ad4>] (device_release_driver_internal+0x18c/0x200 drivers/base/dd.c:1293)
 r5:00000000 r4:84536830
[<80a49948>] (device_release_driver_internal) from [<80a49b60>] (device_release_driver+0x18/0x1c drivers/base/dd.c:1316)
 r9:828eed04 r8:82f51a40 r7:82f51a38 r6:82f51a0c r5:84536830 r4:82f51a30
[<80a49b48>] (device_release_driver) from [<80a47c60>] (bus_remove_device+0xcc/0x120 drivers/base/bus.c:574)
[<80a47b94>] (bus_remove_device) from [<80a41ce4>] (device_del+0x15c/0x3bc drivers/base/core.c:3909)
 r9:828eed04 r8:84536800 r7:82fd3c00 r6:843cc208 r5:04208060 r4:84536830
[<80a41b88>] (device_del) from [<80d69720>] (usb_disable_device+0xdc/0x1f0 drivers/usb/core/message.c:1418)
 r10:00000000 r9:00000000 r8:84536800 r7:84534800 r6:843cc208 r5:00000001
 r4:00000038
[<80d69644>] (usb_disable_device) from [<80d5e58c>] (usb_disconnect+0xec/0x29c drivers/usb/core/hub.c:2305)
 r10:00000001 r9:8464e800 r8:845348c4 r7:83e1a400 r6:84534880 r5:84534800
 r4:60000013
[<80d5e4a0>] (usb_disconnect) from [<80d6113c>] (hub_port_connect drivers/usb/core/hub.c:5361 [inline])
[<80d5e4a0>] (usb_disconnect) from [<80d6113c>] (hub_port_connect_change drivers/usb/core/hub.c:5661 [inline])
[<80d5e4a0>] (usb_disconnect) from [<80d6113c>] (port_event drivers/usb/core/hub.c:5821 [inline])
[<80d5e4a0>] (usb_disconnect) from [<80d6113c>] (hub_event+0xd78/0x194c drivers/usb/core/hub.c:5903)
 r10:00000001 r9:00000101 r8:83c48b00 r7:84534800 r6:83e19c00 r5:83e1a610
 r4:00000001
[<80d603c4>] (hub_event) from [<8026660c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r10:82e65805 r9:82fd3c00 r8:00000080 r7:dddd00c0 r6:82e65800 r5:83c48b00
 r4:82f57a80
[<80266454>] (process_one_work) from [<80267330>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<80266454>] (process_one_work) from [<80267330>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:82fd3c00 r9:82f57aac r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:82f57a80
[<80267144>] (worker_thread) from [<80270044>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df839e90 r8:82f59740 r7:82f57a80 r6:80267144 r5:82fd3c00
 r4:82f59540
[<8026ff40>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf919fb0 to 0xdf919ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026ff40 r4:82f59540
Rebooting in 86400 seconds..


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

