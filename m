Return-Path: <linux-kernel+bounces-146247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C78A62B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA741C2169C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB938FA3;
	Tue, 16 Apr 2024 05:02:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00747381C4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243724; cv=none; b=tMOMrNp06WsIpYhth5qdeXDED4YsM9FZxqHFBeXn0P3gM2PJOWJ0kUF+CmDcp/wEujlsMA8PTvxuA7cfuxdpVbchlsPHMcYA2aB+2JJDGhqoVbpCoqTh94ZS+sKkMz3rjf2SdOgEvog0vG1ULZavKz54PrSglXm/pN4FTTO7wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243724; c=relaxed/simple;
	bh=6nXu3aOrzW2uYbvEpaskErs1E0cE+an6SfFwfj+x66A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HY4csSy1CNf/TdRAwUnU5JcF8vtWsJsgmhgC6Ozs4IstFqkTwqPiBHr6ThSP1PaIzJTDSc4x4oG46tjVGMSaX0EmmM7F54YxbK9rShXIERK94bT2cn9MkwqJyvTDQjiGFeTNiD0dC1v2hQVX03L5y9QTkBthqhwe6u71UKCTUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5e487d194so293093839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713243722; x=1713848522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9y30aEvxJE0diCeWdI/3oXWsV75oRNkMfQ8L8q0NDzM=;
        b=PP0Kch0HzXvO/CugYoVvzrJ2MqgT6nDjJJhIX4OkMNC73GOFLd0xz+hBWdDAbonzQt
         eStGfPNvp83ctoZ8J9TJ3K4SpGJ0/aY0ugmjMmM/yRc0zu4rLYWzvkkp8wOvwgSmS0yq
         HhOtQWRRirVibR8UMr50zKkarhwv1NEdylnAQMxEcT8p9OOGsc1fM4Ru955GyLEtXKIO
         7Y0ihhC571ftHRcL+xNwNMVKfkRaXkq4yZLlc0h5zxXQR7Oa5umnPb11TKstvjLL1sev
         BdJaVqa7720BsQ0eJvNTS7IR+R8j9rGq33SFDgiRuHqbhQbBVFmIgnm9lyyqYVDPReYY
         9PzQ==
X-Gm-Message-State: AOJu0YxTyY3ptk+ZYoD81Qf5PeKphzNMf7RPzLuv54EJ9Zl+j/ZwKW9P
	qemXtkMSxATwKxxyYndS7fFY23na7FxRu+kvrVY9lMDDZvhcYTbwM4yZwkGlF+TjN5mCQPtfYfm
	PcX9pxa7iqBGx9YYJ8EN15eh5WQd2FcV6jeMuZnzc/4prfWtBBfvb6NQ=
X-Google-Smtp-Source: AGHT+IGp7U/5H4DmtqMWQQwot6cb3Dzjsd+Z+auUmmmwifgb5yyZqQXFJV+jv8P01f4QdbB4wkR0ArYYcqEheX+x390z84ZFjXIq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:891e:b0:482:ead5:4f5d with SMTP id
 jc30-20020a056638891e00b00482ead54f5dmr130959jab.1.1713243722138; Mon, 15 Apr
 2024 22:02:02 -0700 (PDT)
Date: Mon, 15 Apr 2024 22:02:02 -0700
In-Reply-To: <CA+LQOUdW5Sp0i1ez3LKYVyUVTaM13rmPkGd0LiWDbey+9L7NAg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078d84e06162fa3fb@google.com>
Subject: Re: [syzbot] [input?] WARNING in bcm5974_start_traffic/usb_submit_urb (2)
From: syzbot <syzbot+b064b5599f18f7ebb1e1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mukattreyee@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in bcm5974_start_traffic/usb_submit_urb

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 6593 at drivers/usb/core/urb.c:504 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 1 PID: 6593 Comm: udevd Not tainted 6.9.0-rc4-syzkaller-g96fca68c4fbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
lr : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
sp : ffff8000a0a473b0
x29: ffff8000a0a473f0 x28: ffff0000c247f000 x27: 0000000000000001
x26: ffff80008c6a23a8 x25: ffff0000c522f0a0 x24: ffff0000cbee4f50
x23: ffff80008c6a8ec0 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000cc0 x19: ffff0000cbee4f00 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008ae75488 x15: 0000000000000001
x14: 1fffe000367bda02 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 399e84fd1d74f400
x8 : 399e84fd1d74f400 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a0a46b18 x4 : ffff80008ef75060 x3 : ffff8000805e616c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
 bcm5974_start_traffic+0xe0/0x154 drivers/input/mouse/bcm5974.c:799
 bcm5974_open+0x98/0x134 drivers/input/mouse/bcm5974.c:839
 input_open_device+0x170/0x29c drivers/input/input.c:654
 evdev_open_device drivers/input/evdev.c:400 [inline]
 evdev_open+0x308/0x4b4 drivers/input/evdev.c:487
 chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
 do_dentry_open+0x778/0x12b4 fs/open.c:955
 vfs_open+0x7c/0x90 fs/open.c:1089
 do_open fs/namei.c:3642 [inline]
 path_openat+0x1f6c/0x2830 fs/namei.c:3799
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 6980
hardirqs last  enabled at (6979): [<ffff8000803749b4>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (6979): [<ffff8000803749b4>] __console_unlock kernel/printk/printk.c:2731 [inline]
hardirqs last  enabled at (6979): [<ffff8000803749b4>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3050
hardirqs last disabled at (6980): [<ffff80008ae708d4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (6580): [<ffff800080031848>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (6578): [<ffff800080031814>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
bcm5974 1-1:1.0: could not read from device
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 6593 at drivers/usb/core/urb.c:504 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 PID: 6593 Comm: udevd Tainted: G        W          6.9.0-rc4-syzkaller-g96fca68c4fbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
lr : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
sp : ffff8000a0a473b0
x29: ffff8000a0a473f0 x28: ffff0000d006f000 x27: 0000000000000001
x26: ffff80008c6a23a8 x25: ffff0000d3d5ac80 x24: ffff0000cfbc1350
x23: ffff80008c6a8ec0 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000cc0 x19: ffff0000cfbc1300 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008ae75488 x15: 0000000000000001
x14: 1fffe000367b9202 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 399e84fd1d74f400
x8 : 399e84fd1d74f400 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a0a46b18 x4 : ffff80008ef75060 x3 : ffff8000805e616c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
 bcm5974_start_traffic+0xe0/0x154 drivers/input/mouse/bcm5974.c:799
 bcm5974_open+0x98/0x134 drivers/input/mouse/bcm5974.c:839
 input_open_device+0x170/0x29c drivers/input/input.c:654
 evdev_open_device drivers/input/evdev.c:400 [inline]
 evdev_open+0x308/0x4b4 drivers/input/evdev.c:487
 chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
 do_dentry_open+0x778/0x12b4 fs/open.c:955
 vfs_open+0x7c/0x90 fs/open.c:1089
 do_open fs/namei.c:3642 [inline]
 path_openat+0x1f6c/0x2830 fs/namei.c:3799
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 13636
hardirqs last  enabled at (13635): [<ffff8000803749b4>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (13635): [<ffff8000803749b4>] __console_unlock kernel/printk/printk.c:2731 [inline]
hardirqs last  enabled at (13635): [<ffff8000803749b4>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3050
hardirqs last disabled at (13636): [<ffff80008ae708d4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (13242): [<ffff800080031848>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (13240): [<ffff800080031814>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
bcm5974 1-1:1.0: could not read from device
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 6593 at drivers/usb/core/urb.c:504 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 PID: 6593 Comm: udevd Tainted: G        W          6.9.0-rc4-syzkaller-g96fca68c4fbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
lr : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
sp : ffff8000a0a473b0
x29: ffff8000a0a473f0 x28: ffff0000d791f000 x27: 0000000000000001
x26: ffff80008c6a23a8 x25: ffff0000c2527c60 x24: ffff0000c9c89550
x23: ffff80008c6a8ec0 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000cc0 x19: ffff0000c9c89500 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008ae75488 x15: 0000000000000001
x14: 1fffe000367b9202 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 399e84fd1d74f400
x8 : 399e84fd1d74f400 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a0a46b18 x4 : ffff80008ef75060 x3 : ffff8000805e616c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
 bcm5974_start_traffic+0xe0/0x154 drivers/input/mouse/bcm5974.c:799
 bcm5974_open+0x98/0x134 drivers/input/mouse/bcm5974.c:839
 input_open_device+0x170/0x29c drivers/input/input.c:654
 evdev_open_device drivers/input/evdev.c:400 [inline]
 evdev_open+0x308/0x4b4 drivers/input/evdev.c:487
 chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
 do_dentry_open+0x778/0x12b4 fs/open.c:955
 vfs_open+0x7c/0x90 fs/open.c:1089
 do_open fs/namei.c:3642 [inline]
 path_openat+0x1f6c/0x2830 fs/namei.c:3799
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 19686
hardirqs last  enabled at (19685): [<ffff8000803749b4>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (19685): [<ffff8000803749b4>] __console_unlock kernel/printk/printk.c:2731 [inline]
hardirqs last  enabled at (19685): [<ffff8000803749b4>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3050
hardirqs last disabled at (19686): [<ffff80008ae708d4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (19436): [<ffff800080031848>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (19434): [<ffff800080031814>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
bcm5974 1-1:1.0: could not read from device
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 6593 at drivers/usb/core/urb.c:504 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 PID: 6593 Comm: udevd Tainted: G        W          6.9.0-rc4-syzkaller-g96fca68c4fbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
lr : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
sp : ffff8000a0a473b0
x29: ffff8000a0a473f0 x28: ffff0000d791e000 x27: 0000000000000001
x26: ffff80008c6a23a8 x25: ffff0000d4041580 x24: ffff0000cfdc4050
x23: ffff80008c6a8ec0 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000cc0 x19: ffff0000cfdc4000 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008ae75488 x15: 0000000000000001
x14: 1fffe000367b9202 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 399e84fd1d74f400
x8 : 399e84fd1d74f400 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a0a46b18 x4 : ffff80008ef75060 x3 : ffff8000805e616c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
 bcm5974_start_traffic+0xe0/0x154 drivers/input/mouse/bcm5974.c:799
 bcm5974_open+0x98/0x134 drivers/input/mouse/bcm5974.c:839
 input_open_device+0x170/0x29c drivers/input/input.c:654
 evdev_open_device drivers/input/evdev.c:400 [inline]
 evdev_open+0x308/0x4b4 drivers/input/evdev.c:487
 chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
 do_dentry_open+0x778/0x12b4 fs/open.c:955
 vfs_open+0x7c/0x90 fs/open.c:1089
 do_open fs/namei.c:3642 [inline]
 path_openat+0x1f6c/0x2830 fs/namei.c:3799
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 25512
hardirqs last  enabled at (25511): [<ffff8000803749b4>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (25511): [<ffff8000803749b4>] __console_unlock kernel/printk/printk.c:2731 [inline]
hardirqs last  enabled at (25511): [<ffff8000803749b4>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3050
hardirqs last disabled at (25512): [<ffff80008ae708d4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (23142): [<ffff800080031848>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (23140): [<ffff800080031814>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
bcm5974 1-1:1.0: could not read from device
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 6593 at drivers/usb/core/urb.c:504 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 PID: 6593 Comm: udevd Tainted: G        W          6.9.0-rc4-syzkaller-g96fca68c4fbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
lr : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
sp : ffff8000a0a473b0
x29: ffff8000a0a473f0 x28: ffff0000e4099000 x27: 0000000000000001
x26: ffff80008c6a23a8 x25: ffff0000c23b2de0 x24: ffff0000d1773650
x23: ffff80008c6a8ec0 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000cc0 x19: ffff0000d1773600 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008ae75488 x15: 0000000000000001
x14: 1fffe000367b9202 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 399e84fd1d74f400
x8 : 399e84fd1d74f400 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a0a46b18 x4 : ffff80008ef75060 x3 : ffff8000805e616c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
 bcm5974_start_traffic+0xe0/0x154 drivers/input/mouse/bcm5974.c:799
 bcm5974_open+0x98/0x134 drivers/input/mouse/bcm5974.c:839
 input_open_device+0x170/0x29c drivers/input/input.c:654
 evdev_open_device drivers/input/evdev.c:400 [inline]
 evdev_open+0x308/0x4b4 drivers/input/evdev.c:487
 chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
 do_dentry_open+0x778/0x12b4 fs/open.c:955
 vfs_open+0x7c/0x90 fs/open.c:1089
 do_open fs/namei.c:3642 [inline]
 path_openat+0x1f6c/0x2830 fs/namei.c:3799
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 31378
hardirqs last  enabled at (31377): [<ffff8000803749b4>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (31377): [<ffff8000803749b4>] __console_unlock kernel/printk/printk.c:2731 [inline]
hardirqs last  enabled at (31377): [<ffff8000803749b4>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3050
hardirqs last disabled at (31378): [<ffff80008ae708d4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (28966): [<ffff800080031848>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (28964): [<ffff800080031814>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
bcm5974 1-1:1.0: could not read from device


Tested on:

commit:         96fca68c Merge tag 'nfsd-6.9-3' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=152b3957180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
dashboard link: https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.

