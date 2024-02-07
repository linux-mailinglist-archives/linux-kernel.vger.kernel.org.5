Return-Path: <linux-kernel+bounces-56993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2284D274
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEFB287586
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD01272A8;
	Wed,  7 Feb 2024 19:54:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8486AF9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335675; cv=none; b=EZnQ486lPvOepWgUeG2NFYdsORUZIccbK9rPk9BTcZNKWEZ3Ra6cg7c/iWLnLOdIZxI7auEoOkctoDlZZWNFywix4czwBtk52p0Y07dwpfp9vooI2QOjhrEYjfPuWQoTMgjKyx0jo9PcahSVrB28IwGOaj6y3fVNNo9kwPGu+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335675; c=relaxed/simple;
	bh=hYThMK1Xf4I8228RVeu4sPoLLzyiRmJ6EGR1xxc8cw8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QnRkObLo0eD6eHL4ahi191iiozHrFatSy9f/bQpfOozAVBiHJ5aBouT2Bt14uqxZhWNN/c+lm//uW6ND1gWh5UGp/hDr+KmozFGrz6+d5idcy292eEqA6T9TbCh1YzowNYWV79OV3kWnVBfCcF6nModKOjAeBHV06Tzf9aPP+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363ca646a1dso8274095ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 11:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335672; x=1707940472;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXijhnJSqfNwRwrMz0wxJxUultHKEFeKw9S9BLLYx9E=;
        b=QXzXL54a7TXNe45Faxa7WAEa/+JuFvHBlX1Z1aVsx8NHfPKyHEbFkvNMZAIYkHJOAm
         WJvYZXSzBzn+N4jRh9eq9PCtItXhyEynH12pLsrqJRM05k0vzC+Uc6tPaiWbcNeBEYoY
         i4rK4Vw0cPqPpZNuZTCrmQEIPf0vX52nJ5xvwoo4EC0ZZMMfWAnOjicK1X+I2W4p60Gs
         BgKrk7hDl9w0RiLSvJMLKh6ks0eVC9y6qIlRkpWsKbDqL9rTegKDMydokhwBB/b2EL7X
         6Xi0rZLE/CddNIqt6nFP+IOTF+Xw0AzwFwH6HCTiBOCIV12d0RJI8d3gGCJBKVpqNIVd
         52Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdSRnNso91CODMns3R0YxVENTbLEaVxzLADvwB+8PLAMAImVIGTMS1tVwJZ0SwsRN/rasZitvip/DWesCjkmepVcaUOEvzQB8ZR8Z
X-Gm-Message-State: AOJu0Yx2Fn631N8YRH6yAmFOsLUOucgDUiWmZaiHHZjr3QK4n4pW9ZIb
	hhJ8lDd2UdK9CXkOULhWeFzLlNUba4OGtrtQwocXh+mGER6fE+l2lTZjeaDZrE/+VQdl8fV43fR
	vXzMbRBy2OkVnDOkegr4QdOX76qvLsq+mmYv3wGywJ2gPVoVn/odnV5w=
X-Google-Smtp-Source: AGHT+IH/XqaXynFOhnl6JjLdwgwpGFSyoyWSeUneNpuf0CWOlEs7ALO3CLjyu77yoB49oO++8shLP8/OkYyfLkMxHAQMBT2LYHVY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc4:b0:363:cc27:74c with SMTP id
 x4-20020a056e021bc400b00363cc27074cmr540192ilv.4.1707335672617; Wed, 07 Feb
 2024 11:54:32 -0800 (PST)
Date: Wed, 07 Feb 2024 11:54:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047631d0610d010c1@google.com>
Subject: [syzbot] [input?] [usb?] WARNING in input_register_device (2)
From: syzbot <syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6613476e225e Linux 6.8-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=15ca9224180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=877e61347079aad5
dashboard link: https://syzkaller.appspot.com/bug?extid=8e41bb0c055b209ebbf4
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b32118180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17dab048180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-6613476e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33ea806d02dd/vmlinux-6613476e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33195f72f823/Image-6613476e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 8 at lib/kobject_uevent.c:671 add_uevent_var+0x282/0x296 lib/kobject_uevent.c:671
Modules linked in:
CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.8.0-rc1-syzkaller #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: usb_hub_wq hub_event
epc : add_uevent_var+0x282/0x296 lib/kobject_uevent.c:671
 ra : add_uevent_var+0x282/0x296 lib/kobject_uevent.c:671
epc : ffffffff858325ec ra : ffffffff858325ec sp : ff20000000049b20
 gp : ffffffff8863e320 tp : ff6000000c29ce00 t0 : ccb0ea972aeb292d
 t1 : ffe3ffff000092d8 t2 : ff6000000c29d8f8 s0 : ff20000000049c00
 s1 : ff60000016d76000 a0 : 0000000000000001 a1 : 0000000000000000
 a2 : 0000000000000002 a3 : ffffffff800b66fa a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : ff200000000496c7
 s2 : 0000000000000004 s3 : 1fe4000000009368 s4 : 1fec000002daec43
 s5 : ff60000016d76218 s6 : 0000000000000006 s7 : 00000000000007fc
 s8 : ff60000016d76a1c s9 : 1fec000002daed43 s10: ffffffff885377c0
 s11: ffffffff86b9c560 t3 : 0000000000000004 t4 : ffe3ffff000092d8
 t5 : ffe3ffff000092d9 t6 : ff200000000496d8
status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[<ffffffff858325ec>] add_uevent_var+0x282/0x296 lib/kobject_uevent.c:671
[<ffffffff85833cdc>] kobject_uevent_env+0xb0c/0x1378 lib/kobject_uevent.c:602
[<ffffffff8583456a>] kobject_uevent+0x22/0x2e lib/kobject_uevent.c:642
[<ffffffff82542b12>] device_add+0x10d2/0x186e drivers/base/core.c:3606
[<ffffffff837032c4>] input_register_device+0x606/0xe9a drivers/input/input.c:2379
[<ffffffff83faba00>] hidinput_connect+0x4c72/0x88a4 drivers/hid/hid-input.c:2355
[<ffffffff83f9d330>] hid_connect+0x11e0/0x15e0 drivers/hid/hid-core.c:2194
[<ffffffff83f9d7e6>] hid_hw_start drivers/hid/hid-core.c:2309 [inline]
[<ffffffff83f9d7e6>] hid_hw_start+0xb6/0x13c drivers/hid/hid-core.c:2300
[<ffffffff840255a0>] ms_probe+0x15e/0x4f0 drivers/hid/hid-microsoft.c:391
[<ffffffff83f9de94>] __hid_device_probe drivers/hid/hid-core.c:2633 [inline]
[<ffffffff83f9de94>] hid_device_probe+0x2a4/0x3f2 drivers/hid/hid-core.c:2670
[<ffffffff8254cd2e>] call_driver_probe drivers/base/dd.c:579 [inline]
[<ffffffff8254cd2e>] really_probe+0x234/0xbbc drivers/base/dd.c:658
[<ffffffff8254d88a>] __driver_probe_device+0x1d4/0x458 drivers/base/dd.c:800
[<ffffffff8254db6e>] driver_probe_device+0x60/0x1ce drivers/base/dd.c:830
[<ffffffff8254dec0>] __device_attach_driver+0x1e4/0x2fe drivers/base/dd.c:958
[<ffffffff82547562>] bus_for_each_drv+0x142/0x1da drivers/base/bus.c:457
[<ffffffff8254eae2>] __device_attach+0x1c4/0x462 drivers/base/dd.c:1030
[<ffffffff8254f108>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
[<ffffffff82549fe4>] bus_probe_device+0x15c/0x192 drivers/base/bus.c:532
[<ffffffff82542b6c>] device_add+0x112c/0x186e drivers/base/core.c:3625
[<ffffffff83f96c5c>] hid_add_device+0x374/0x9b2 drivers/hid/hid-core.c:2816
[<ffffffff840dc3f2>] usbhid_probe+0xa50/0xf84 drivers/hid/usbhid/hid-core.c:1429
[<ffffffff830a18c0>] usb_probe_interface+0x2d4/0x8a2 drivers/usb/core/driver.c:399
[<ffffffff8254cd2e>] call_driver_probe drivers/base/dd.c:579 [inline]
[<ffffffff8254cd2e>] really_probe+0x234/0xbbc drivers/base/dd.c:658
[<ffffffff8254d88a>] __driver_probe_device+0x1d4/0x458 drivers/base/dd.c:800
[<ffffffff8254db6e>] driver_probe_device+0x60/0x1ce drivers/base/dd.c:830
[<ffffffff8254dec0>] __device_attach_driver+0x1e4/0x2fe drivers/base/dd.c:958
[<ffffffff82547562>] bus_for_each_drv+0x142/0x1da drivers/base/bus.c:457
[<ffffffff8254eae2>] __device_attach+0x1c4/0x462 drivers/base/dd.c:1030
[<ffffffff8254f108>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
[<ffffffff82549fe4>] bus_probe_device+0x15c/0x192 drivers/base/bus.c:532
[<ffffffff82542b6c>] device_add+0x112c/0x186e drivers/base/core.c:3625
[<ffffffff8309b2b4>] usb_set_configuration+0xfe0/0x1b10 drivers/usb/core/message.c:2207
[<ffffffff830c3d56>] usb_generic_driver_probe+0xae/0x128 drivers/usb/core/generic.c:254
[<ffffffff830a0606>] usb_probe_device+0xd6/0x340 drivers/usb/core/driver.c:294
[<ffffffff8254cd2e>] call_driver_probe drivers/base/dd.c:579 [inline]
[<ffffffff8254cd2e>] really_probe+0x234/0xbbc drivers/base/dd.c:658
[<ffffffff8254d88a>] __driver_probe_device+0x1d4/0x458 drivers/base/dd.c:800
[<ffffffff8254db6e>] driver_probe_device+0x60/0x1ce drivers/base/dd.c:830
[<ffffffff8254dec0>] __device_attach_driver+0x1e4/0x2fe drivers/base/dd.c:958
[<ffffffff82547562>] bus_for_each_drv+0x142/0x1da drivers/base/bus.c:457
[<ffffffff8254eae2>] __device_attach+0x1c4/0x462 drivers/base/dd.c:1030
[<ffffffff8254f108>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
[<ffffffff82549fe4>] bus_probe_device+0x15c/0x192 drivers/base/bus.c:532
[<ffffffff82542b6c>] device_add+0x112c/0x186e drivers/base/core.c:3625
[<ffffffff830777fe>] usb_new_device+0x960/0x1648 drivers/usb/core/hub.c:2596
[<ffffffff8307dc48>] hub_port_connect drivers/usb/core/hub.c:5465 [inline]
[<ffffffff8307dc48>] hub_port_connect_change drivers/usb/core/hub.c:5605 [inline]
[<ffffffff8307dc48>] port_event drivers/usb/core/hub.c:5765 [inline]
[<ffffffff8307dc48>] hub_event+0x2954/0x4756 drivers/usb/core/hub.c:5847
[<ffffffff801231ea>] process_one_work+0x7ce/0x179c kernel/workqueue.c:2633
[<ffffffff80124c94>] process_scheduled_works kernel/workqueue.c:2706 [inline]
[<ffffffff80124c94>] worker_thread+0xadc/0x10f8 kernel/workqueue.c:2787
[<ffffffff80144154>] kthread+0x28c/0x3a6 kernel/kthread.c:388
[<ffffffff85928722>] ret_from_fork+0xe/0x1c arch/riscv/kernel/entry.S:229


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

