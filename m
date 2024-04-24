Return-Path: <linux-kernel+bounces-156273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A668B0098
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318141F24F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B53A15442F;
	Wed, 24 Apr 2024 04:32:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CA7152DE6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933147; cv=none; b=jJTm6z2VZqnXb6ZXqpiC20EqmY3++Ymkf4z1B4mNVMGj53uUYiToAAGojCdrv+2Pix7FO51HS6q7Cu37KbM+hLbAdGRfeXnQMaRqlwpoyP2TcyeFSq66C1p0CFpRBkF+cXU1CHZiuJmOjP49xEonecdZjBLZKTimPate5jjTxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933147; c=relaxed/simple;
	bh=E6MgHNwV4DnymNBLfVuOgFqvsGvcFGMGES9APtuPuuE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gIEZ+QYncHWCtkprsU0usnN35i52TLo+ERpEqjIFvD3HgEBi76adesO/2wozBQDNy4aXfmXO1SHbcan2L/Qw4ru1xYZT7glS//K8Fvvd4Xac9rxxYWNSYX0I/oScUq8/iNbtTh3Kk8JCnoQxX3IjHkyosV2va1ObaHlmW0fMDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a38d56655so78335245ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713933145; x=1714537945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BX6FBtRkiTssDymK0ex6hQc8uF3Rea2zcAOcrSHz7Os=;
        b=A2dN+VWR/tONbkVuisyoFWgMn2N5m3JAY4cOveOAjrMLxi04EtsuIPiH0hRi0t9PpD
         XNg3NqFVZyq69BAfLAoLxi0u2rErT5sT9+SGK/W0kWCtL8HW8/wz5KqYuVUtuThmQHUO
         LU0FARxhAMgqVhsfG4gpE4NmeElivDxWXnL468iNnTYySa0nbtvqZFILNtdOFBdp5Mp4
         6oGDwwC+Ec8JrnXWm3LvmhiTX0JK/52KrQx7reVwpkPfJnizxZfNdh38C8PllRc6+PZH
         pAgFKDha8NBNojXDe63ZR/UzfuWrGm+7UY6956jMh+L4DK8BKUlOaPgK6s7dTTYBYTyk
         GdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbkLf+n7HIp+0JW61KVMrrF8yYBZI5nKb2bjh/VrcCJYtmtqdsDzP+OKi2WovKMLSsatgHQVNrqxBynA9AtSH4DIrR2VFa81/akIT/
X-Gm-Message-State: AOJu0YwRPYO0swcNWPBoq4RZgkwlIJ6TPUWzpErozZd98Sk9gSoW/TNc
	gnPlrX4tSEcenXliuVnLP7zjMh+2qX3UWGIpuDAoWU4XOXux1B1hcooENZDp4bGUjeoxagvnPfU
	adnhtNnsSjyfE0LX7urtZIcU6iC9MHnWqwOMBIQhqmt8f/WmbFXZvI8s=
X-Google-Smtp-Source: AGHT+IEW5ByicXicC6bpNxEkF2MW5qN5E3IsqNZiHhcrcHa33EpbV4gPjTB9HygJIROK0X2Xxgn2aGCz47CCFy1i0mkkSKe45qo/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188f:b0:36a:276e:4fe with SMTP id
 o15-20020a056e02188f00b0036a276e04femr212250ilu.4.1713933145432; Tue, 23 Apr
 2024 21:32:25 -0700 (PDT)
Date: Tue, 23 Apr 2024 21:32:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d70290616d028d9@google.com>
Subject: [syzbot] [wireguard?] WARNING in __kthread_bind_mask (2)
From: syzbot <syzbot+36466e0ea21862240631@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c9866f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=36466e0ea21862240631
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04e2e4bee9fb/disk-3cdb4559.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65456769dc43/vmlinux-3cdb4559.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09504bbdec9e/bzImage-3cdb4559.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36466e0ea21862240631@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 54 at kernel/kthread.c:524 __kthread_bind_mask+0x35/0xc0 kernel/kthread.c:524
Modules linked in:
CPU: 1 PID: 54 Comm: kworker/u8:4 Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: netns cleanup_net
RIP: 0010:__kthread_bind_mask+0x35/0xc0 kernel/kthread.c:524
Code: 48 89 fb e8 8d 52 33 00 89 ee 48 89 df e8 d3 94 04 00 31 ff 48 89 c5 48 89 c6 e8 86 4d 33 00 48 85 ed 75 14 e8 6c 52 33 00 90 <0f> 0b 90 5b 5d 41 5c 41 5d e9 5d 52 33 00 e8 58 52 33 00 4c 8d ab
RSP: 0018:ffffc90000bf7870 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888060bfbc00 RCX: ffffffff815a6fda
RDX: ffff88801c690000 RSI: ffffffff815a6fe4 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000005 R12: ffffffff8b0b2f08
R13: 0000000000000001 R14: ffff88805e2c0ca0 R15: ffff88801fde54c0
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0039d0000 CR3: 000000002eb24000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __kthread_bind kernel/kthread.c:537 [inline]
 kthread_unpark+0x147/0x1a0 kernel/kthread.c:630
 kthread_stop+0x177/0x670 kernel/kthread.c:706
 destroy_workqueue+0x154/0xaa0 kernel/workqueue.c:5685
 wg_destruct+0x24d/0x3d0 drivers/net/wireguard/device.c:257
 netdev_run_todo+0x775/0x1260 net/core/dev.c:10593
 default_device_exit_batch+0x860/0xae0 net/core/dev.c:11641
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:175
 cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:637
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

