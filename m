Return-Path: <linux-kernel+bounces-164226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEF8B7AED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24E6286E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0EC77110;
	Tue, 30 Apr 2024 15:02:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF77710C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489349; cv=none; b=dHAsVL9ZCrisnlynzqElKPUxQQhy69i53bAm6vVSBcBpsucs53JWud6LrUv6oAgms7bGe1ivI9RcLGTD7hFpKGnM3DMuW2Ou+j7/Tz/24Pzu03PvMkjV2Gw7o8Yp4mZmhwSUqor8Fa0d9tZyKQwHxSze3f5WKMSawVI+RPINXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489349; c=relaxed/simple;
	bh=7rmPFQ3DT++fNxZ0G1yoLQAgk3hBR6DMm4fIql/kEjE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bd16+K0kUtto7HBQGq8XqexwljMHLgfOUTCozl3ainB7IHQ75kzkCKfojh++zgOoaJ6MimpqHDtPwCVtxo897gKzFnR9r+hh2tJJLuNAxjM8MDKYQb0N4Je82wscEQtrem5VnklGT24xswdTbzi0TKGNI+5nmuee3v63/BPnRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dab89699a8so641662139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489346; x=1715094146;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ALJp+yxeJq2OA0p5gmt6WimV/9suDz8TH5aPp/0mBQ=;
        b=gUF28QhfRMOgRNZ1VRjQQ2lPzkmJjnfra+NJgW8OHz2BHeJc/M5mmMnBk5o9YKbddi
         E5bLwWK7iMhCGKWbo9BiQqOQktHynC2BEXuASDxTA2I3F2kBWze0O/gkGpDldNLA+AiQ
         3E2r89Rwm4GxG6LG0ffZDAIOtU14ohlPVi2nOGThZo/mCZP1sFqJuFNWvgaXYX2EML69
         jZJWLPk2W85qaAZUMLsyt3HfxUXKmw+Ou00CkI8Aim23ebLZvitoCsv7jkdj6Vg5Hts0
         PALHEx+dAKLeIwX1lVjDg4pNCR9I93pLkI8E4MNAt/ucy1czLFhQGjIEz49yLyqijvAb
         UGrA==
X-Forwarded-Encrypted: i=1; AJvYcCWRXZnDrsmaGiYNrZbKdspImAlmzvIImy/EClOF2pNB/5LJIe5WjkhjKm4jEUGmAHQva5nTX2iWnpjrb26TXZKyyivc7odxM8DGr2YY
X-Gm-Message-State: AOJu0YywFlyUUaO3MJ5OTUsnYTCh72HAEL6nSXg6viP5XTqDwf8HFMFD
	T+36UEdQFXm4psyeA1npKTB+TE++q5oJMAruJpDjv7jqTZPkGS5lUSEEbLRejhSbBHO1otKx55o
	ifT8n0Y36d44d8I/wOoUM4hDG2nsarvFR0yNPF/IFbp+2GkvwLUpv3bk=
X-Google-Smtp-Source: AGHT+IEodTkEwipf14NIaP2rVFtJwuOooYDO+mCGtrYaqcuLYsZ6rxdrtUA0sg1WCkbZS08IdThoiKQoUc6Tfbj+3lUyVNUXfyoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:36c:2976:3012 with SMTP id
 j14-20020a056e02154e00b0036c29763012mr569569ilu.2.1714489345740; Tue, 30 Apr
 2024 08:02:25 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:02:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ca6cc061751a86a@google.com>
Subject: [syzbot] [wireless?] [usb?] INFO: trying to register non-static key
 in skb_dequeue (3)
From: syzbot <syzbot+2660b9135e6144ca41a5@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pkshih@realtek.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f12222a4beb usb: dwc3: core: Fix compile warning on s390 ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12dee6d8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe204286ac73e15
dashboard link: https://syzkaller.appspot.com/bug?extid=2660b9135e6144ca41a5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127fb7bb180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118eeccf180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25a4e2e32205/disk-3f12222a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e02cf02ad7b9/vmlinux-3f12222a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41deb6e53302/bzImage-3f12222a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2660b9135e6144ca41a5@syzkaller.appspotmail.com

usb 1-1: reg 0xfe64, usbctrl_vendorreq TimeOut! status:0xffffffb9 value=0x0 reqtype=0xc0
rtl_usb: rx_max_size 15360, rx_urb_num 8, in_ep 0
rtl8192cu: Loading firmware rtlwifi/rtl8192cufw_TMSC.bin
usb 1-1: USB disconnect, device number 2
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 589 Comm: kworker/0:2 Not tainted 6.9.0-rc5-syzkaller-00105-g3f12222a4beb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 assign_lock_key kernel/locking/lockdep.c:976 [inline]
 register_lock_class+0xc2a/0x1230 kernel/locking/lockdep.c:1289
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 skb_dequeue+0x20/0x180 net/core/skbuff.c:3835
 rtl_usb_cleanup drivers/net/wireless/realtek/rtlwifi/usb.c:706 [inline]
 rtl_usb_deinit drivers/net/wireless/realtek/rtlwifi/usb.c:721 [inline]
 rtl_usb_disconnect+0x49e/0x830 drivers/net/wireless/realtek/rtlwifi/usb.c:1051
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0xa10 drivers/base/core.c:3909
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2305
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: unable to handle page fault for address: ffffffffffffffd8
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 82a2067 P4D 82a2067 PUD 82a4067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 589 Comm: kworker/0:2 Not tainted 6.9.0-rc5-syzkaller-00105-g3f12222a4beb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:arch_atomic_fetch_add arch/x86/include/asm/atomic.h:97 [inline]
RIP: 0010:raw_atomic_fetch_add_relaxed include/linux/atomic/atomic-arch-fallback.h:749 [inline]
RIP: 0010:atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:253 [inline]
RIP: 0010:__refcount_add include/linux/refcount.h:184 [inline]
RIP: 0010:__refcount_inc include/linux/refcount.h:241 [inline]
RIP: 0010:refcount_inc include/linux/refcount.h:258 [inline]
RIP: 0010:kref_get include/linux/kref.h:45 [inline]
RIP: 0010:usb_get_urb.part.0+0x1c/0x90 drivers/usb/core/urb.c:114
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 fd 53 bb 01 00 00 00 e8 81 19 2d fd be 04 00 00 00 48 89 ef e8 d4 02 7f fd <f0> 0f c1 5d 00 31 ff 89 de e8 46 14 2d fd 85 db 74 47 e8 5d 19 2d
RSP: 0018:ffffc900019cf6b0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff8425b71c
RDX: fffffbfffffffffc RSI: 0000000000000004 RDI: ffffffffffffffd8
RBP: ffffffffffffffd8 R08: 0000000000000001 R09: fffffbfffffffffb
R10: ffffffffffffffdb R11: 0000000000000001 R12: ffff888118830228
R13: ffffffffffffffd8 R14: ffff888118830288 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881f6400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd8 CR3: 0000000116906000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_get_urb drivers/usb/core/urb.c:816 [inline]
 usb_kill_anchored_urbs+0xa5/0x380 drivers/usb/core/urb.c:819
 rtl_usb_cleanup drivers/net/wireless/realtek/rtlwifi/usb.c:713 [inline]
 rtl_usb_deinit drivers/net/wireless/realtek/rtlwifi/usb.c:721 [inline]
 rtl_usb_disconnect+0x4d1/0x830 drivers/net/wireless/realtek/rtlwifi/usb.c:1051
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0xa10 drivers/base/core.c:3909
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2305
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: ffffffffffffffd8
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_fetch_add arch/x86/include/asm/atomic.h:97 [inline]
RIP: 0010:raw_atomic_fetch_add_relaxed include/linux/atomic/atomic-arch-fallback.h:749 [inline]
RIP: 0010:atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:253 [inline]
RIP: 0010:__refcount_add include/linux/refcount.h:184 [inline]
RIP: 0010:__refcount_inc include/linux/refcount.h:241 [inline]
RIP: 0010:refcount_inc include/linux/refcount.h:258 [inline]
RIP: 0010:kref_get include/linux/kref.h:45 [inline]
RIP: 0010:usb_get_urb.part.0+0x1c/0x90 drivers/usb/core/urb.c:114
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 fd 53 bb 01 00 00 00 e8 81 19 2d fd be 04 00 00 00 48 89 ef e8 d4 02 7f fd <f0> 0f c1 5d 00 31 ff 89 de e8 46 14 2d fd 85 db 74 47 e8 5d 19 2d
RSP: 0018:ffffc900019cf6b0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff8425b71c
RDX: fffffbfffffffffc RSI: 0000000000000004 RDI: ffffffffffffffd8
RBP: ffffffffffffffd8 R08: 0000000000000001 R09: fffffbfffffffffb
R10: ffffffffffffffdb R11: 0000000000000001 R12: ffff888118830228
R13: ffffffffffffffd8 R14: ffff888118830288 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881f6400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd8 CR3: 0000000116906000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	55                   	push   %rbp
   f:	48 89 fd             	mov    %rdi,%rbp
  12:	53                   	push   %rbx
  13:	bb 01 00 00 00       	mov    $0x1,%ebx
  18:	e8 81 19 2d fd       	call   0xfd2d199e
  1d:	be 04 00 00 00       	mov    $0x4,%esi
  22:	48 89 ef             	mov    %rbp,%rdi
  25:	e8 d4 02 7f fd       	call   0xfd7f02fe
* 2a:	f0 0f c1 5d 00       	lock xadd %ebx,0x0(%rbp) <-- trapping instruction
  2f:	31 ff                	xor    %edi,%edi
  31:	89 de                	mov    %ebx,%esi
  33:	e8 46 14 2d fd       	call   0xfd2d147e
  38:	85 db                	test   %ebx,%ebx
  3a:	74 47                	je     0x83
  3c:	e8                   	.byte 0xe8
  3d:	5d                   	pop    %rbp
  3e:	19                   	.byte 0x19
  3f:	2d                   	.byte 0x2d


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

