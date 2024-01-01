Return-Path: <linux-kernel+bounces-13871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 509188213DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACDA1F213DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F785683;
	Mon,  1 Jan 2024 13:38:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792673C35
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ba97338185so1061980139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 05:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704116304; x=1704721104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYigNoNiYcJW8lpNM8A0iW7CoCGomXRo8vhk3B0bsJw=;
        b=Lcmj0FdyKHYGYYPlgVaAGOgzXWqBYR7WfXc1BWMMfHqe+VOtxMCnFw49v1K3LN5ZMp
         sJWIr5ma8/QZp1V/X3UgltfMI68h0cAcm6lQpJ34dnb0kCJAZbcC6uHolkL2h6fC0RkM
         ZfjkQUmSQKhJJJiJbWCr33VzXveKMqTlnr+fL2e9KvGXdf6AJyvhrnCMWh0gMoK23Tfg
         xhyvS5wDO9nM8GiYhgOvmz5NXB7BgnNEgyatSFJsMe/iy3FsZV7zOOZStaQLKS8vPO7v
         GQX3Wap95c4uXlZ/KyCNfihJN5aQl6Fts6b/4Ya+buHdWsf/kVhiz34CrFz7xc+DpWzi
         RZsA==
X-Gm-Message-State: AOJu0YyBOaawg/q1gfRZiphsy5Z96PaOwVtzALr8Iq7RPw3RORwyzTve
	aU8Whe+UN12sM5P1HLh8DDop++lTE2JidBBX1j7Nlv2KCki3
X-Google-Smtp-Source: AGHT+IHoEOB1jBgykoDzepXcDtry3JNwUTq524emldkzi5oSyqgMts0LeftvvC6OyEZ6lrMWiK41Faf332fAUULVnTBH/+Se+S/k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3202:b0:360:134:54b1 with SMTP id
 cd2-20020a056e02320200b00360013454b1mr1255226ilb.0.1704116304778; Mon, 01 Jan
 2024 05:38:24 -0800 (PST)
Date: Mon, 01 Jan 2024 05:38:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000009d27060de27f0a@google.com>
Subject: [syzbot] [serial?] KMSAN: uninit-value in n_tty_receive_buf_standard
From: syzbot <syzbot+559c7fe4b8bac56d38c2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    994d5c58e50e Merge tag 'hardening-v6.7-rc4' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15042a8ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f711bc2a7eb1db25
dashboard link: https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1168e128e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14eebdaae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca8936129fcd/disk-994d5c58.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce1c8de0e20b/vmlinux-994d5c58.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89ceb1dd4d79/bzImage-994d5c58.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+559c7fe4b8bac56d38c2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in variable_test_bit arch/x86/include/asm/bitops.h:227 [inline]
BUG: KMSAN: uninit-value in arch_test_bit arch/x86/include/asm/bitops.h:239 [inline]
BUG: KMSAN: uninit-value in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
BUG: KMSAN: uninit-value in n_tty_receive_buf_standard+0xc58/0x9230 drivers/tty/n_tty.c:1603
 variable_test_bit arch/x86/include/asm/bitops.h:227 [inline]
 arch_test_bit arch/x86/include/asm/bitops.h:239 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
 n_tty_receive_buf_standard+0xc58/0x9230 drivers/tty/n_tty.c:1603
 __receive_buf drivers/tty/n_tty.c:1630 [inline]
 n_tty_receive_buf_common+0x178e/0x2310 drivers/tty/n_tty.c:1729
 n_tty_receive_buf2+0x4c/0x60 drivers/tty/n_tty.c:1775
 tty_ldisc_receive_buf+0xce/0x270 drivers/tty/tty_buffer.c:386
 tty_port_default_receive_buf+0xdf/0x190 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:444 [inline]
 flush_to_ldisc+0x4b7/0xdc0 drivers/tty/tty_buffer.c:494
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

CPU: 0 PID: 3894 Comm: kworker/u4:23 Not tainted 6.7.0-rc3-syzkaller-00134-g994d5c58e50e #0
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

