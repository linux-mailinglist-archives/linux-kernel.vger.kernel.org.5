Return-Path: <linux-kernel+bounces-81059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E33866F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1CC1C2597C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBAA59158;
	Mon, 26 Feb 2024 09:33:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9574C58ACD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940007; cv=none; b=BFyiS1XmPnjA0nsN5iziekxoHcMDp5Fll7W/F66B27sKJxVuQA4FZHnUqdkEmtdpL+XBPFZhnoM3T3DDnzknlgZcEYPmC/iIhuA4SB5RcIp1M4bSoy664Og9slRKz12LZE4nH4Dy94qiJNSAzpYxKItjJS2BhulH7EpdvoVIsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940007; c=relaxed/simple;
	bh=5YdTayytURRNb3nmoFcGTkmUVJWQkhcNbghI1z+5VFk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FlG2yrBksq6xsENx1TNgdZ+Sb5OPWuCuI3W9jsYJhvpgvZ/8FK7QdLMO3ys3Bxacn7pPaazP2JrlwRrtQu35kGBxDEpOiJqSyxELMcjxBPLWPTFHPKp+Gt+JbHLSlo8rRlcrXrRVwOIQxQP6x9+aqCGDycQNYZHxGqXW7qTOssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7857e6cb8so327422139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940005; x=1709544805;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muirGsqHYjo3yDKRvqQrPETkFxCo1OE0PsiaAs/1c1U=;
        b=wTIGovJ4l2nb/6Titl1Lp0iJCug70Bo4qzSH0IqXMABep+dZjA+U5wZsKhQLpDYg0Q
         6BCaGy2sIdUcjlB3vt3dHIkeOr5dGi70DfA94Ne1TwK/SZ2jGav5hrzzL6PHBGTf4Fh1
         E17lTBxjxqcAf9Yhcm6/+OVv4d+sEjUJnHFpQnoT9xrZQWSnhhpyDCf3bU94nhZg0Bq/
         F4+nD+GcdPiHCGlMSTUnryk4flTp5fGGTXLwnTj3CrmNF3Uc3RzVm1RMqNQ5hyMIL0Hp
         R8qpM75dwUKPY3W2cCq4v+W4ZC9nk74zV6r/rVxht0JBtY+zTHu7eCgbbjG/+UfI5QW0
         1R5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFJAyAps5PiR6YodPqtj3DLGWFtWMtq+2ymcGj3E0vnlJFHlg38nc8Ea7kJBU096swkSBeGQqFnDoL/9TnvuIFQopYWk76JS2HQ09+
X-Gm-Message-State: AOJu0Ywl5H1v9sAIbRQr9058mAR0I2SL6AJ37EFhMWleMN6BAl3D7lfw
	jqWshLgYuucLV2wZAFihrraSs0hluDIxgHmUDZgNtVjI86Jkby8mDSowtiDvKGLg9InKubb51il
	kznAU77E+6+mYYlA0zRtz96UfXH1tZU+QvCSuljhY281psHgckJ25Ang=
X-Google-Smtp-Source: AGHT+IG5b7GlIQswO3Js1M1TSXL5XGEVy+fowHmUPy94CtsXC+NqFOP+f3LBdsidi8uUI0AkFDNDT+eYn3g/p6iMk2L7Za/l9nUH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e10:b0:474:77ea:9007 with SMTP id
 co16-20020a0566383e1000b0047477ea9007mr224965jab.1.1708940004861; Mon, 26 Feb
 2024 01:33:24 -0800 (PST)
Date: Mon, 26 Feb 2024 01:33:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eeb04c061245992e@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in ser_release (3)
From: syzbot <syzbot+637cef91acecefb3632e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e6ac7c55d3ec Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=114dffc8180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=637cef91acecefb3632e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0db64bae65c4/disk-e6ac7c55.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bad65c0a1f3/vmlinux-e6ac7c55.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354955244df4/Image-e6ac7c55.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+637cef91acecefb3632e@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/0:7:6267]
Modules linked in:
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffff8000801b57f4>] copy_process+0x1318/0x3478 kernel/fork.c:2441
softirqs last  enabled at (0): [<ffff8000801b581c>] copy_process+0x1340/0x3478 kernel/fork.c:2442
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 PID: 6267 Comm: kworker/0:7 Tainted: G    B              6.8.0-rc5-syzkaller-ge6ac7c55d3ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events ser_release
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
lr : queued_spin_lock_slowpath+0x168/0xcf8 kernel/locking/qspinlock.c:383
sp : ffff8000983b7560
x29: ffff8000983b7600 x28: 1fffe0002211e598 x27: 1ffff00013076eb8
x26: dfff800000000000 x25: 1fffe0002211e59a x24: ffff8000983b7580
x23: ffff8000983b75c0 x22: ffff700013076eb0 x21: 0000000000000001
x20: 0000000000000001 x19: ffff0001108f2cc0 x18: 0000000000000000
x17: 0000000000000000 x16: ffff8000809fcc44 x15: 0000000000000001
x14: 1fffe0002211e598 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60002211e599 x10: 1fffe0002211e598 x9 : 0000000000000000
x8 : 0000000000000001 x7 : 0000000000000000 x6 : ffff8000890b7f7c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008ae4e204
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 __cmpwait_case_8 arch/arm64/include/asm/cmpxchg.h:229 [inline]
 __cmpwait arch/arm64/include/asm/cmpxchg.h:257 [inline]
 queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x320/0x348 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x50/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __netif_tx_lock include/linux/netdevice.h:4452 [inline]
 netif_freeze_queues net/sched/sch_generic.c:459 [inline]
 netif_tx_lock+0x9c/0x1d8 net/sched/sch_generic.c:468
 netif_tx_lock_bh include/linux/netdevice.h:4536 [inline]
 dev_watchdog_down net/sched/sch_generic.c:564 [inline]
 dev_deactivate_many+0x274/0xa8c net/sched/sch_generic.c:1352
 __dev_close_many+0x270/0x3c8 net/core/dev.c:1517
 dev_close_many+0x1e0/0x474 net/core/dev.c:1555
 dev_close+0x174/0x250 net/core/dev.c:1581
 ser_release+0x188/0x238 drivers/net/caif/caif_serial.c:309
 process_one_work+0x694/0x1204 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2787
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2248 Comm: aoe_tx0 Tainted: G    B              6.8.0-rc5-syzkaller-ge6ac7c55d3ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
pc : _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:194
lr : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
lr : _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
sp : ffff80009cbc77f0
x29: ffff80009cbc77f0 x28: ffff0000d2205930 x27: ffff0000d22058c0
x26: ffff0000c9840c30 x25: ffff000115c16020 x24: dfff800000000000
x23: ffff0000c9840fd0 x22: 0000000000000000 x21: ffff00012a8273b0
x20: ffff8000937525c0 x19: 0000000000000000 x18: 1fffe00036804796
x17: ffff800085c2d7d4 x16: ffff80008ad5a610 x15: 0000000000000001
x14: 1ffff000126ea4b8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff80009cbbffff x10: 0000000000ff0100 x9 : 0000000000000007
x8 : 00000000000000c0 x7 : 0000000000000000 x6 : ffff800083c51b04
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000cde60000 x1 : 0000000000000000 x0 : ffff80008ae4d4dc
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:196 [inline]
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 uart_port_unlock_irqrestore include/linux/serial_core.h:667 [inline]
 uart_write+0x33c/0x594 drivers/tty/serial/serial_core.c:598
 handle_tx+0x200/0x604 drivers/net/caif/caif_serial.c:236
 caif_xmit+0x108/0x150 drivers/net/caif/caif_serial.c:282
 __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
 netdev_start_xmit include/linux/netdevice.h:5003 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x240/0x8ac net/core/dev.c:3563
 __dev_queue_xmit+0x15b0/0x329c net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 tx+0x90/0x138 drivers/block/aoe/aoenet.c:62
 kthread+0x1ac/0x374 drivers/block/aoe/aoecmd.c:1229
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


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

