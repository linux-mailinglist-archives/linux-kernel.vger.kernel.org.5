Return-Path: <linux-kernel+bounces-125681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5939892AA0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0BB1F22005
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C32C68A;
	Sat, 30 Mar 2024 11:02:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F0241E2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711796548; cv=none; b=jIbFljjIBdb7idmQO4JnXSCyHOHAcnj3baitDJRJAGbIT7ahB59+3HelqHPIAnLw5YMS4XoNCSVuIsnoaV/DdKeRpn4Qf9xT6O2O0CHbHTNk/UJJwtVHgz8UV9y1Ktd9Ljco2VB0zzNM1Fyyu+aDRhh5wHbM7v7VWK7ji/+EFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711796548; c=relaxed/simple;
	bh=yPcfTvipI2/+vcDGEXJhfS40amnwmytukAZNlZ00LQs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qExrOcNVU+859vmsVDqF7BLLwYxKZvZLmhoT5Y0laDAa2J2Qoqzq78Zfk4THLzVX2U/bVN3peeWOLWmacwbOfwVSJnao0hUTzj7M5P6/PMHiPae567nKqCCXvLko87onfk5ZXpnPV4Ij1btQLoTlM8k6FKrOu+nho0M+nol+jVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso296386039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711796545; x=1712401345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53tpjewSWu0Vresc93uaKcyJznO8Iz9abIky6N2xuK8=;
        b=B0iRNyx9LQnQYLTPVM7DTEdwUa7EF260hWE9Y6pIMM2Bc4/LHyol5uHTtRUyVIm2fX
         TbVaF9hU3vl/NcPllU7b/97A5/QNmJzJK/UBarQen8qYgWIVTnjv8GW/Th3Kur58WraM
         WiUXyF+1Z1i2T/nGwo+ZKzx6QfBDI2YTlg+UQbVS+XUvunOLZgsU5rSrkPMc7x1AyhBH
         Z6OzFO7EZaDfcQmNANMiQqVWT5LqkTtHEwN+vaEwxuqjLhs9eBONzjLp+fKyPoD3rE+O
         eu4eMJpDsscrAs9bDW0P4/QcvRIs/yMuOCdYK18b0YPNl7R2Z2CEhAdfIFywyWPY5Hcs
         TGZg==
X-Forwarded-Encrypted: i=1; AJvYcCVVlsUidQ+G7DkdFwndLfO3Cb6iqbV8MMUgo/Vq7RJwq787Mw2AvjRFAI0VZYuxyGT2+6fnNHH6GIZc31uBZx3z4vZrsRNKQ+eJTVpz
X-Gm-Message-State: AOJu0Yxm4pGjZU9cODYKM8yQ16cDZyYcj7DxdPrlZMgZxRQU0TbtO2kH
	zMFrjH58Fi9Yw/5Po10qE0NMWXuq5JaaTF1Zn39LN2mxRrUe4GbeDMZW/DPKOYP4LmCMtoXyCpb
	pLqxuKvHwBLH80gyJ8DnvTGsO5AhC8d1f64GMRDMUS7PDy2t5WnoaGi8=
X-Google-Smtp-Source: AGHT+IHv69JzOfvTT29TShFoM/iodtSW6dmhPzDpDQg2zztHr8hSEYTmewIQpE/qHaWyeJ9BmGXrYmPL7FCNH6qlTCEmh8lPzblN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:368:8135:4559 with SMTP id
 g5-20020a056e02198500b0036881354559mr352355ilf.6.1711796545698; Sat, 30 Mar
 2024 04:02:25 -0700 (PDT)
Date: Sat, 30 Mar 2024 04:02:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008cd6e0614deb1db@google.com>
Subject: [syzbot] [nfc?] [net?] WARNING: locking bug in nci_close_device (2)
From: syzbot <syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12ae3185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=e29c204bd2e3906fe69c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 10856 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 0 PID: 10856 at kernel/locking/lockdep.c:232 __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 0 PID: 10856 Comm: syz-executor.1 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4773 [inline]
pc : __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4773 [inline]
lr : __lock_acquire+0x780/0x763c kernel/locking/lockdep.c:5087
sp : ffff800099ba7240
x29: ffff800099ba7500 x28: ffff0000d7f65a00 x27: ffff0000d7f664f0
x26: 1fffe0001afecc9e x25: ffff0000d7f66458 x24: 0000000000000001
x23: 0000000000000003 x22: 0000000000000c17 x21: ffff8000922364c0
x20: 0000000000000000 x19: ffff0000d7f664f4 x18: 1fffe000367fff96
x17: 0000000000000000 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: dfff800000000000
x11: 0000000000040000 x10: 0000000000022c3d x9 : afcfeb2b6d9f9a00
x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800099ba6b38 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 __flush_workqueue+0x14c/0x11c4 kernel/workqueue.c:3146
 nci_close_device+0x140/0x5b8 net/nfc/nci/core.c:567
 nci_dev_down+0x40/0x54 net/nfc/nci/core.c:639
 nfc_dev_down net/nfc/core.c:161 [inline]
 nfc_rfkill_set_block+0x14c/0x2d0 net/nfc/core.c:179
 rfkill_set_block+0x18c/0x37c net/rfkill/core.c:346
 rfkill_fop_write+0x578/0x734 net/rfkill/core.c:1305
 vfs_write+0x3c0/0xc3c fs/read_write.c:588
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 2283
hardirqs last  enabled at (2283): [<ffff800080297cac>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1397 [inline]
hardirqs last  enabled at (2283): [<ffff800080297cac>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5154
hardirqs last disabled at (2282): [<ffff80008ae46784>] __schedule+0x2bc/0x24b4 kernel/sched/core.c:6625
softirqs last  enabled at (546): [<ffff80008003165c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (544): [<ffff800080031628>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address dfff800000000018
KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000018] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 10856 Comm: syz-executor.1 Tainted: G        W          6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4773 [inline]
pc : __lock_acquire+0x568/0x763c kernel/locking/lockdep.c:5087
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4773 [inline]
lr : __lock_acquire+0x780/0x763c kernel/locking/lockdep.c:5087
sp : ffff800099ba7240
x29: ffff800099ba7500 x28: ffff0000d7f65a00 x27: ffff0000d7f664f0
x26: 1fffe0001afecc9e x25: ffff0000d7f66458 x24: 0000000000000001
x23: 0000000000000003 x22: 0000000000000c17 x21: ffff8000922364c0
x20: 0000000000000000 x19: 00000000000000c4 x18: 1fffe000367fff96
x17: 0000000000000000 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: dfff800000000000
x11: 0000000000040000 x10: 0000000000022c3d x9 : afcfeb2b6d9f9a00
x8 : 0000000000000018 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800099ba6b38 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x568/0x763c kernel/locking/lockdep.c:5087
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 __flush_workqueue+0x14c/0x11c4 kernel/workqueue.c:3146
 nci_close_device+0x140/0x5b8 net/nfc/nci/core.c:567
 nci_dev_down+0x40/0x54 net/nfc/nci/core.c:639
 nfc_dev_down net/nfc/core.c:161 [inline]
 nfc_rfkill_set_block+0x14c/0x2d0 net/nfc/core.c:179
 rfkill_set_block+0x18c/0x37c net/rfkill/core.c:346
 rfkill_fop_write+0x578/0x734 net/rfkill/core.c:1305
 vfs_write+0x3c0/0xc3c fs/read_write.c:588
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 34000ee8 aa1f03e8 91031113 d343fe68 (38ec6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	34000ee8 	cbz	w8, 0x1dc
   4:	aa1f03e8 	mov	x8, xzr
   8:	91031113 	add	x19, x8, #0xc4
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	38ec6908 	ldrsb	w8, [x8, x12] <-- trapping instruction


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

