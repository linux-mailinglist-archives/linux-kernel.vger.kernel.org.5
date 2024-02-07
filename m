Return-Path: <linux-kernel+bounces-56492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F33B84CACE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77849B26EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8115A788;
	Wed,  7 Feb 2024 12:41:31 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7B76036
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309691; cv=none; b=E3SKX8HQBJOYfp/AbRFW0bQ9PSdusunxzrH3rIzLyooBG1umaLyY3KkcdDACNAGE92tjUaJqLSog4KdchAE+/0gQJF4PbshTLz4RHtOx1WwuWL5nNybvqNb13XmnEfDlX0++PVITMD3wOEb0fFsnyzoEz4u6iiNuReL2HnZOOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309691; c=relaxed/simple;
	bh=9t5zdfAmXj5DFtlbrw5D2xqQzcjpgpc2hWLeT13mkVE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vmfh3RpBj3bJcwTCdHXISHX5ucwYL3E55YJVjIIIlFPNM2SnDp9ASbbfJxffmUbea/jhx9ss6KQAUaIUsdY6C+BdMhbr0ekAkYj2xOZcduzaaWzPOLNJ4+pw0oRvw600JxMxkORg6BWsI7ins+/eoIVkCy3r8bwJI1vcKMxt0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c2febbba58so76364439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707309688; x=1707914488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UtWIwO1Dab5l2X/ISXEn/y8oC4Bvex5DE2Ny/UKRCQ=;
        b=UDSPVs96hGTQtct56PoxIMH9V5rUM3ilxrbEfudNISyLXUzKQ1pDS9j1NpALtbpwz9
         Wlnai3rR2+sR/BJx+xw6C+/qFt0WUCH2F5G5ARp03mWM2SoLNGHk+wDoHZprX4QLgC3H
         RxKA2GvaS7Qaifb1UrzOAVRiuF19G42PlBwd9e/EzyEI0q5fLsz06tKx28oznDLT6cup
         HTqZQa6Vymgl1w/IZ29UfJ62yJRi46OB4IRvwVlFs6MGDErH1Adu9IVG0OLUMgXf6Z9K
         EvuaMu653GfiCtX4NeOJWRKiJd0MtvBB0N/l/aDPbk+dRV+PP3IOd1GLUMBstUdxMuH3
         cM9w==
X-Gm-Message-State: AOJu0Yx8fb0dBv8mFGSaoXex/tsFz0X7kETN4CBrtt+QPF+shuO19lxu
	ad58NXaREe6mKF/vd9N4jonhuVS7WwLUU4brqmFnENtKC5dEiKDHIEFaaQjNtBcZY2hGArvoUQp
	TilEpZ74KkkEPdolsccV4DsGRZIIOdBvG0w6pnztUYoBakgbfN87EhaNpVA==
X-Google-Smtp-Source: AGHT+IE2rSbyDeE6FxG4UCCj0udgZa3wd6/nanCxQHfs8BzJHkQjgHNuQcVofA4BVqg/MfBm0Vy7u3qGS6zuVN0Lz/cfByGNwv8w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:363:df76:4a1f with SMTP id
 k13-20020a92c24d000000b00363df764a1fmr39149ilo.2.1707309688364; Wed, 07 Feb
 2024 04:41:28 -0800 (PST)
Date: Wed, 07 Feb 2024 04:41:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f33050610ca03d9@google.com>
Subject: [syzbot] [kernel?] kernel panic: corrupted stack end in hub_event (2)
From: syzbot <syzbot+bb6c69482c4c8c2f79ad@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6613476e225e Linux 6.8-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=12a1d4ffe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=877e61347079aad5
dashboard link: https://syzkaller.appspot.com/bug?extid=bb6c69482c4c8c2f79ad
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-6613476e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33ea806d02dd/vmlinux-6613476e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33195f72f823/Image-6613476e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb6c69482c4c8c2f79ad@syzkaller.appspotmail.com

usb 2-1: New USB device found, idVendor=0582, idProduct=0014, bcdDevice=bb.9d
usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 3371 Comm: kworker/0:3 Not tainted 6.8.0-rc1-syzkaller #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: usb_hub_wq hub_event
Call Trace:
[<ffffffff80010868>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:121
[<ffffffff858a9b60>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:127
[<ffffffff85904e9c>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff85904e9c>] dump_stack_lvl+0xe8/0x154 lib/dump_stack.c:106
[<ffffffff85904f24>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
[<ffffffff858aa5b2>] panic+0x33c/0x77a kernel/panic.c:344
[<ffffffff85912be8>] schedule_debug kernel/sched/core.c:5954 [inline]
[<ffffffff85912be8>] __schedule+0x313e/0x3196 kernel/sched/core.c:6620
[<ffffffff85913a54>] preempt_schedule_irq+0x7c/0x18e kernel/sched/core.c:7047
[<ffffffff859082fa>] raw_irqentry_exit_cond_resched kernel/entry/common.c:305 [inline]
[<ffffffff859082fa>] raw_irqentry_exit_cond_resched kernel/entry/common.c:297 [inline]
[<ffffffff859082fa>] irqentry_exit+0x138/0x17a kernel/entry/common.c:348
[<ffffffff859070bc>] do_irq+0x34/0x4c arch/riscv/kernel/traps.c:375
[<ffffffff85928618>] ret_from_exception+0x0/0x64 arch/riscv/kernel/entry.S:112
[<ffffffff8080f488>] arch_local_irq_restore arch/riscv/include/asm/irqflags.h:52 [inline]
[<ffffffff8080f488>] __update_cpu_freelist_fast mm/slub.c:3304 [inline]
[<ffffffff8080f488>] __slab_alloc_node mm/slub.c:3696 [inline]
[<ffffffff8080f488>] slab_alloc_node mm/slub.c:3850 [inline]
[<ffffffff8080f488>] kmalloc_trace+0x168/0x2d4 mm/slub.c:4007
[<ffffffff843d7f94>] kmalloc include/linux/slab.h:590 [inline]
[<ffffffff843d7f94>] kzalloc include/linux/slab.h:711 [inline]
[<ffffffff843d7f94>] snd_seq_create_port+0xea/0x858 sound/core/seq/seq_ports.c:135
[<ffffffff843c0932>] snd_seq_ioctl_create_port+0x24a/0x840 sound/core/seq/seq_clientmgr.c:1324
[<ffffffff843c3b06>] snd_seq_kernel_client_ctl+0x10a/0x1a4 sound/core/seq/seq_clientmgr.c:2526
[<ffffffff843ef98c>] snd_seq_midisynth_probe+0x62a/0x13f2 sound/core/seq/seq_midi.c:389
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
[<ffffffff8438aef0>] snd_seq_device_dev_register+0x3e/0xea sound/core/seq_device.c:170
[<ffffffff8432f94c>] __snd_device_register sound/core/device.c:149 [inline]
[<ffffffff8432f94c>] snd_device_register+0x12e/0x1b6 sound/core/device.c:179
[<ffffffff8438d504>] snd_rawmidi_dev_register+0x7a6/0xf68 sound/core/rawmidi.c:2096
[<ffffffff843305fa>] __snd_device_register sound/core/device.c:149 [inline]
[<ffffffff843305fa>] snd_device_register_all+0xee/0x15c sound/core/device.c:197
[<ffffffff8431e2f0>] snd_card_register+0x11c/0x6ee sound/core/init.c:897
[<ffffffff844e1584>] try_to_register_card+0x1c0/0x316 sound/usb/card.c:754
[<ffffffff844e2636>] usb_audio_probe+0xa00/0x3024 sound/usb/card.c:896
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
SMP: stopping secondary CPUs
Rebooting in 86400 seconds..


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

