Return-Path: <linux-kernel+bounces-14445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20D821D28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775991F22C5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEC4FC1C;
	Tue,  2 Jan 2024 13:55:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CF10A0D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7fac89006so1204471739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704203718; x=1704808518;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olo0b/zVW4WxDws/AUxXP78jNeI3Up++qS04lhSS2JU=;
        b=EgvLQ9QA+XnTuLCxjuJlQ2xCQt3RFTnZQ3cTAqfhST3FX4rMFluQjWz7cH+2HsgBfV
         YSJ5ajZZB8GV3MXDeMvS7O2CNSqVyaN+t+ZI6hE6KMFuISPBRg/Nt9bg38huj4QwnPRT
         NDGUIXhLkvkV/sHcbc53/kP1lTGJrLbIFLuyh6KNBe3N5zeoH9ttF1RlNbIt/9HHSuC9
         3G/Pa+jx6mlawL8fTrzGoMpJi14Rcs6uDzV9a0iQNDb2jMdZ8ay0vFlyLhr0CzDrAglO
         HaZP3oZhj0HOkJD0/tOoNR4+rByUaz4Fr7PVTCCdY8UqpW5PSU+etLWjVWpyWlCgVp4t
         G+Mg==
X-Gm-Message-State: AOJu0YxuCvNvLZAXphBGkSWvxTgnvmBZb+k/sDTDWw2sXXtXRcCqsByZ
	opliaoPMLILI2opNez31FOG6jtB8xkt/QlDv1Qnv9c+BasXT
X-Google-Smtp-Source: AGHT+IGwaiF696/fugUcQ+frCCdcLxPfa+wT4kFsyCxDysUMPWNv6jFB4f7xvJihpTDNrxAzZFtiU2fkZnNwaiNn09Wnj+Pnyibm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:c8aa:b526 with SMTP id
 i12-20020a056e021d0c00b0035fc8aab526mr2639641ila.2.1704203717979; Tue, 02 Jan
 2024 05:55:17 -0800 (PST)
Date: Tue, 02 Jan 2024 05:55:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c3614060df6d965@google.com>
Subject: [syzbot] [serial?] KMSAN: uninit-value in n_tty_lookahead_flow_ctrl
From: syzbot <syzbot+0015c7d1e68e7f61621d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d3fa86b1a7b4 Merge tag 'net-6.7-rc3' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c3bcd8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e32016b84cf917ca
dashboard link: https://syzkaller.appspot.com/bug?extid=0015c7d1e68e7f61621d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12abdea4e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173b1c94e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c785fb3c059b/disk-d3fa86b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/142addbb8256/vmlinux-d3fa86b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e6d7e1c7b24/bzImage-d3fa86b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0015c7d1e68e7f61621d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in n_tty_lookahead_flow_ctrl+0x2cd/0x2f0 drivers/tty/n_tty.c:1516
 n_tty_lookahead_flow_ctrl+0x2cd/0x2f0 drivers/tty/n_tty.c:1516
 tty_port_default_lookahead_buf+0x142/0x200 drivers/tty/tty_port.c:59
 lookahead_bufs drivers/tty/tty_buffer.c:427 [inline]
 flush_to_ldisc+0x906/0xdc0 drivers/tty/tty_buffer.c:497
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:179 [inline]
 __tty_buffer_request_room+0x36e/0x6c0 drivers/tty/tty_buffer.c:272
 __tty_insert_flip_string_flags+0x140/0x560 drivers/tty/tty_buffer.c:308
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x39e/0xa00 drivers/tty/serial/serial_core.c:3494
 serial8250_read_char+0x1a2/0x5d0 drivers/tty/serial/8250/8250_port.c:1760
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1777 [inline]
 serial8250_handle_irq+0x77b/0xb30 drivers/tty/serial/8250/8250_port.c:1937
 serial8250_default_handle_irq+0x11a/0x2a0 drivers/tty/serial/8250/8250_port.c:1962
 serial8250_interrupt+0xc0/0x350 drivers/tty/serial/8250/8250_core.c:127
 __handle_irq_event_percpu+0x113/0xc90 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xef/0x2c0 kernel/irq/handle.c:210
 handle_edge_irq+0x341/0xf90 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq arch/x86/kernel/irq.c:238 [inline]
 __common_interrupt+0x94/0x1f0 arch/x86/kernel/irq.c:257
 common_interrupt+0x89/0xa0 arch/x86/kernel/irq.c:247
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:636

CPU: 0 PID: 1031 Comm: kworker/u4:7 Not tainted 6.7.0-rc2-syzkaller-00095-gd3fa86b1a7b4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_unbound flush_to_ldisc
=====================================================


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

