Return-Path: <linux-kernel+bounces-143841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B608A3E1C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE9F281ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CF53803;
	Sat, 13 Apr 2024 18:37:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A410F4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713033448; cv=none; b=u1PoSGxFrr0qfbVa6eump08VFRTmoZLjt/cDsBV+EA3uAZvGz9GqtTrjuN93zWSYDs2YJduFT75IsSiU+7TVEk8DRoiUzHf4DCO0FeCA/2phMBRHb2TAuqSz1X++/cGp1NhLIo5MfjT+m3a0rpvC8AdY2DxkMpVOxGjCd2yQp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713033448; c=relaxed/simple;
	bh=g3atkt7V/wmj3LP/jPBwNhkPJYO6JMpOS4nw6luyB7I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iFVTmDh3XzEZAHWNVbAmFA07/ThQGVwD7s4UMq0qwrug6NqishQ0mH/17O61gCN2Zk+GeHFIlGFc8sPhyG3c6bCHP8u1ZfZ3gbJXxRA9r5Gi2+YIRP07fuSgycwurmBnpBRk9AiwknZpcdltVFoJoG4EDvkE+yElfCh2SuK0w+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-369f714fedcso19519135ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 11:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713033446; x=1713638246;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbyrURhKXydDVN1coupbKM7nuRhZQrr8buVDDwxVyGM=;
        b=KI0VqB5PbObFPQ/1qyGMT/SEl8ACHSMbQQdTrTKFBvIYu/ENceDvMDNULY6ucrys/O
         dgrNzJ6YBR7zJTK2urEOAeqD8pdfR7BelaC4xfA37ohTDiiDxhWVZpvM4izY6v4Dbpr1
         9PNohrKATp/vXYY0c4iv0ULv1zG0Fl14YYlE4KCVP72uRt/iGFl38eS3f7IKw1ayOf7E
         l6IgFOKyYBDpe9+fJPQumsJTBGHO+BTVBUsSZWU7rvlGDvlVZ9VhqDMWasrhHQDI6i4l
         fnCsnsRmNtSiQOzamFusZLFbWiIBQ+Ye3ClpH0vk3tSVZDvmOs9OmixZBHtKdND393K+
         Isyw==
X-Forwarded-Encrypted: i=1; AJvYcCXqQcJGgFk0Eefee1Kz51Rh+TWipQiR+8aanj5vtq1EI4EFDQhwUoQbdhy2x4vU/ooD4pVN2bWlBm8KUfkTkkTfRDVPa5BEJ+LITEaW
X-Gm-Message-State: AOJu0YwJMemKrfiDtlAZGTtyuadJ1qIidIXtam5GKbvPAyCNPndZnf8y
	Yvq8AKRCe330FKTlI2j+KsbUmGWaKUxLUyIUBQXr9SAWcuJXGhvM2jrzcWTLLJSwYiXrwprbj/p
	77n3GDd1d00o+Y7/M7k9ZzHo+LSa700JTHHXgvu6EWUd6A8gzdut40EA=
X-Google-Smtp-Source: AGHT+IGFwceL3dCaPzIQbGDY0KYk8x6J9hTOdhixSqmVSYW2zDGHAtAS7HNyuTZVvXQ1CyVCkqLNLUST/Ciqp2ZTjNN4tTzFPt4f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c246:0:b0:36a:fa56:b0fb with SMTP id
 k6-20020a92c246000000b0036afa56b0fbmr409689ilo.6.1713033445930; Sat, 13 Apr
 2024 11:37:25 -0700 (PDT)
Date: Sat, 13 Apr 2024 11:37:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000088d5a0615feae29@google.com>
Subject: [syzbot] [net?] WARNING in prepare_to_wait_event
From: syzbot <syzbot+6104a4c252d72c0f24d0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=116a00cb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=6104a4c252d72c0f24d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6104a4c252d72c0f24d0@syzkaller.appspotmail.com

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 0 PID: 9187 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:

CPU: 0 PID: 9187 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d de 59 01 04 00 74 06 90 c3 cc cc cc cc c6 05 cf 59 01 04 01 90 48 c7 c7 20 ba aa 8b e8 f8 d5 e7 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc9000328f118 EFLAGS: 00010246

RAX: 8a36e2956e99fb00 RBX: 1ffff92000651e30 RCX: ffff8880208fbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000328f268 R08: ffffffff8157cc12 R09: 1ffff110172851a2
R10: dffffc0000000000 R11: ffffed10172851a3 R12: 1ffff92000651e2c
R13: dffffc0000000000 R14: ffffc9000328f180 R15: 0000000000000046
FS:  000055555c6ec480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ed22000 CR3: 0000000069fc0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 lock_acquire+0x3db/0x530 kernel/locking/lockdep.c:5757
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 prepare_to_wait_event+0x2b/0x400 kernel/sched/wait.c:275
 synchronize_rcu_expedited+0x661/0x820 kernel/rcu/tree_exp.h:954
 synchronize_net net/core/dev.c:11004 [inline]
 unregister_netdevice_many_notify+0x920/0x16d0 net/core/dev.c:11080
 unregister_netdevice_many net/core/dev.c:11154 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11033
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 nsim_destroy+0x13a/0x260 drivers/net/netdevsim/netdev.c:456
 __nsim_dev_port_del+0x14b/0x1b0 drivers/net/netdevsim/dev.c:1425
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
 nsim_dev_reload_destroy+0x28a/0x490 drivers/net/netdevsim/dev.c:1658
 nsim_drv_remove+0x58/0x160 drivers/net/netdevsim/dev.c:1673
 device_remove drivers/base/dd.c:567 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x4a9/0x7c0 drivers/base/dd.c:1295
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
 device_del+0x581/0xa30 drivers/base/core.c:3828
 device_unregister+0x20/0xc0 drivers/base/core.c:3869
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
 del_device_store+0x363/0x480 drivers/net/netdevsim/bus.c:226
 kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa84/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fccbbc7cbaf
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 b9 80 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 0c 81 02 00 48
RSP: 002b:00007fff09c304c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fccbbc7cbaf
RDX: 0000000000000001 RSI: 00007fff09c30510 RDI: 0000000000000005
RBP: 00007fccbbcca021 R08: 0000000000000000 R09: 00007fff09c30317
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007fff09c30510 R14: 00007fccbc8d4620 R15: 0000000000000003
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

