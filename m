Return-Path: <linux-kernel+bounces-149494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E18A91C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE27282B09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CCE5467A;
	Thu, 18 Apr 2024 04:08:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C985339A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413306; cv=none; b=a47W3Vsby+eC0wtxJo1e7oFmHmeR0tdpCdFtEznaTO/D7X4IVjAlflhTI8XYakjAWJVgY2QRpbIMTKxl/npgQcFj7EuEmw9KcbLUcNe/2mub0/5sB5Y8DMrmgIFd+rURYEe9Mfq9s0zpS59NqUA86GAF1NMRxSBV7FAL552aykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413306; c=relaxed/simple;
	bh=9EPin60FMQwmiUIVEuZfRjJCOiYzUKIb+YY7pff0TiY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ILT8Sdz4yoLjgeg6At7CGy/GXe5If9wRbQLRgpxj62IQodBVnVGwpn/Do3tMjvJmwrCskSEgw7bp3T45LvLQnuscIKmebhKSNs2X30oGkpI8CxALi2x673D+cIU7nIwBcqSSh54NIv3SRXPKSUT2ayIt9GPjE5OisDzdsnvVZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d9913d3174so58823239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713413303; x=1714018103;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEM+T9nXxPjWZkYEN8IWHVP344j+ho4lS7Ek9uvoVuk=;
        b=xSHqOd8EPV5Jh9quLfeu9OBX7JgLfG2ihY+68CrjxjuoRxjSGEJo183PPIB8TYNxdI
         u5F6sOM/Ro6N7zIvZebkVJwYhDWW0JpH0INOSMxp7JMM4Vbd36SRmaT5hgb9Amoy7XSQ
         Gm1qVy8mvRogU0QBVeDZpTM2jxN4QjbFsJ7K0H2nJnYzcvleJiPJrueZOfSGHF7Wo6qE
         /vXeDV0ttdQNww1zD0jUymNcrgqFDF5ol8ZMPiatuCg0pk1zo7CvYdX8hGNuTt8jItsY
         DMR2KLzHJD1TkGyHwdjkK2ZQjoMGat2P8lqxQDSkxeHIDXwXuqvoW/BP+yQLQMkIMFcm
         N7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLcInfxZRgXXs4pn+w6rMBWqnyEhSDPRHzCC10cCERQyvWHHc1OeXj4U7O5H5D1tSPSgXhYPfe6Kwi4cUyhGh/hQdzIrCMXqzwjwHq
X-Gm-Message-State: AOJu0Yyum63soUde7Et0LnnV818aYwKxHSmMdiiA0bUnoTOFb1yleRGY
	vcne9o9GJrSYnpCirnQ11JCtE90Plcr4TmQe1YVRWBkkjQ0Z/+iM9c6ILOqAXId5GqkYMq76KQE
	81wk91xrpcgrxTxg3J6deXY6LBP5OA48s6jq4iloiwXayb60KPX1K9mY=
X-Google-Smtp-Source: AGHT+IGwAdiCevEF3sEmP4AsPpg0YvxJYhO7El/Z4OL7Y5tMo/4Dz301dpzt2f4nSUgjxumT+r6SwJ7TEng/JzXeCd6iml7jhmbE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:850e:b0:482:fa6f:78f1 with SMTP id
 is14-20020a056638850e00b00482fa6f78f1mr90141jab.6.1713413303202; Wed, 17 Apr
 2024 21:08:23 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:08:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a86bf0616571fc7@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0bbac3facb5d Linux 6.9-rc4
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d9a36d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14069fcb180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155da7cb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/93eb2bab28b5/disk-0bbac3fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47a883d2dfaa/vmlinux-0bbac3fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6bc56900ec1d/bzImage-0bbac3fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com

syz_tun: entered promiscuous mode
batadv_slave_0: entered promiscuous mode
=====================================================
BUG: KMSAN: uninit-value in hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
 hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
 fill_frame_info net/hsr/hsr_forward.c:577 [inline]
 hsr_forward_skb+0x330/0x30e0 net/hsr/hsr_forward.c:615
 hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
 __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5432
 __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
 netif_receive_skb_internal net/core/dev.c:5738 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5798
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
 tun_build_skb drivers/net/tun.c:1679 [inline]
 tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5050 Comm: syz-executor387 Not tainted 6.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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

