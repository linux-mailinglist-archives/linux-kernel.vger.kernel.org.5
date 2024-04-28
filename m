Return-Path: <linux-kernel+bounces-161373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5178B4B42
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30CEB215C0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0F3EA68;
	Sun, 28 Apr 2024 10:32:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150528F4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714300346; cv=none; b=HXLxEw/VtfYa+1kg4pYM8drmA6c4fYBkMmcjfwQexkSVucLmq/qfbH6NxCTdASnfhgJm0MEGrH4f3EaX3U2o/t0wQhgmEseXRauTbvr/gcM46C8j+zqyUuTUKXwqOyJlRF7lDIORuWcL2PmtaY8GmmqNytniCIhYJXTCcP0QRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714300346; c=relaxed/simple;
	bh=opVxBr2wFDfqgsK8V+RoidezO/Oi2DFxD0ve799PqoU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fQqkZRqdbATkSXSZFrpndYiMkPp0lHB81D0oDGTSf1sWlraSQGTi3yrBkdZTGglw/axEvAeSaHUrTr618xbfEmCrAffnXWB/pgYowwE8ckLmFXKDpHpMClPpneJf67DRnIk3bi5B+LRA8jD/5TeqPwV7LO+Hs3eDV3CMIz/tfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so371119539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 03:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714300344; x=1714905144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkas7Bht5s1OZ3fGOEt3xe3g+0PCxh4/M4jdC0Ak61w=;
        b=lAf8Heq/Dz5jolNHB9XU/UYDN7AgUuXsQdUyHI3JL8QNveRKaJjJvXrJ8fW+j8O3Yo
         1oFaexVp8s4AOooYCJLaD5mYCFjbs2zhsuQZ2kUOTX2WlnxJK0rsC3JM/ehexOvBRLh3
         H6vcG7muah6Xa0Kh2jb4D13lLLadvmgkNHDofCnV+OrOdh5rt7YBHNG6E3mEhabeVjqd
         6teYkGbWLoHLuQgQ4P+P7HLKvoUy1fKhU+cK7uG9d+82uqBuvE+t/kcYW2+zTDa3gK3N
         AS3dra3HQc6LxvUpBE/p/T58DtiyKFctxanDhcGF10yWTTFu17X4ZY5X7TvFkBqvpWSF
         E5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVDUkXB6TBgjCv68CI3eUXjPkkpTChWvbwkMU49IPU47hWc//gQPwjoygKUKpQ1T5LzqDuYOHR0fEjPrKzlCweSiuFggc2fHmYwv9ll
X-Gm-Message-State: AOJu0YxvJ/RbnHvJj5dnmRTpT/jh9bE274LjzntXtJsWqXQmnwH/exzH
	f/KcsMEzqz+BTBX2yh8XRrFNWsbLdBcqjGiL36F9Kvl5VrZATK6WVArSq9fB/RmzOPka/tl/5/B
	m7WqhwEEH95ievl614Ij/SYWYLDdJ3pswb7H8VpuvJu6HO98OFy4DW2c=
X-Google-Smtp-Source: AGHT+IFV14aGv6V6oPWfZkx6hEtcG3ySBplmaxt0A1m/FBImkP8QkLxBKmPoyXmPFaqYxHgPbhsL2zuYv9j21/96yAb5C90J4M+V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4c03:b0:487:de0:b631 with SMTP id
 dm3-20020a0566384c0300b004870de0b631mr251049jab.6.1714300344324; Sun, 28 Apr
 2024 03:32:24 -0700 (PDT)
Date: Sun, 28 Apr 2024 03:32:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fe556061725a7be@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in aes_encrypt (5)
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5d12ed4bea43 Merge tag 'i2c-for-6.9-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16491b80980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c4a1df36b3414a8
dashboard link: https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bb5148c91210/disk-5d12ed4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49a9a8f075f4/vmlinux-5d12ed4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1309b451ab44/bzImage-5d12ed4b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in subshift lib/crypto/aes.c:149 [inline]
BUG: KMSAN: uninit-value in aes_encrypt+0x15cc/0x1db0 lib/crypto/aes.c:282
 subshift lib/crypto/aes.c:149 [inline]
 aes_encrypt+0x15cc/0x1db0 lib/crypto/aes.c:282
 aesti_encrypt+0x7d/0xf0 crypto/aes_ti.c:31
 crypto_ecb_crypt crypto/ecb.c:23 [inline]
 crypto_ecb_encrypt2+0x18a/0x300 crypto/ecb.c:40
 crypto_lskcipher_crypt_sg+0x36b/0x7f0 crypto/lskcipher.c:228
 crypto_lskcipher_encrypt_sg+0x8a/0xc0 crypto/lskcipher.c:247
 crypto_skcipher_encrypt+0x119/0x1e0 crypto/skcipher.c:669
 xts_encrypt+0x3c4/0x550 crypto/xts.c:269
 crypto_skcipher_encrypt+0x1a0/0x1e0 crypto/skcipher.c:671
 fscrypt_crypt_data_unit+0x4ee/0x8f0 fs/crypto/crypto.c:144
 fscrypt_encrypt_pagecache_blocks+0x422/0x900 fs/crypto/crypto.c:207
 ext4_bio_write_folio+0x13db/0x2e40 fs/ext4/page-io.c:526
 mpage_submit_folio+0x351/0x4a0 fs/ext4/inode.c:1869
 mpage_process_page_bufs+0xb92/0xe30 fs/ext4/inode.c:1982
 mpage_process_folio fs/ext4/inode.c:2036 [inline]
 mpage_map_and_submit_buffers fs/ext4/inode.c:2105 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2254 [inline]
 ext4_do_writepages+0x353e/0x62e0 fs/ext4/inode.c:2679
 ext4_writepages+0x312/0x830 fs/ext4/inode.c:2768
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 __writeback_single_inode+0x10d/0x12c0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0xb48/0x1be0 fs/fs-writeback.c:1941
 wb_writeback+0x4a1/0xdf0 fs/fs-writeback.c:2117
 wb_do_writeback fs/fs-writeback.c:2264 [inline]
 wb_workfn+0x40b/0x1940 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 le128_xor include/crypto/b128ops.h:69 [inline]
 xts_xor_tweak+0x4ae/0xbf0 crypto/xts.c:123
 xts_xor_tweak_pre crypto/xts.c:135 [inline]
 xts_encrypt+0x296/0x550 crypto/xts.c:268
 crypto_skcipher_encrypt+0x1a0/0x1e0 crypto/skcipher.c:671
 fscrypt_crypt_data_unit+0x4ee/0x8f0 fs/crypto/crypto.c:144
 fscrypt_encrypt_pagecache_blocks+0x422/0x900 fs/crypto/crypto.c:207
 ext4_bio_write_folio+0x13db/0x2e40 fs/ext4/page-io.c:526
 mpage_submit_folio+0x351/0x4a0 fs/ext4/inode.c:1869
 mpage_process_page_bufs+0xb92/0xe30 fs/ext4/inode.c:1982
 mpage_process_folio fs/ext4/inode.c:2036 [inline]
 mpage_map_and_submit_buffers fs/ext4/inode.c:2105 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2254 [inline]
 ext4_do_writepages+0x353e/0x62e0 fs/ext4/inode.c:2679
 ext4_writepages+0x312/0x830 fs/ext4/inode.c:2768
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 __writeback_single_inode+0x10d/0x12c0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0xb48/0x1be0 fs/fs-writeback.c:1941
 wb_writeback+0x4a1/0xdf0 fs/fs-writeback.c:2117
 wb_do_writeback fs/fs-writeback.c:2264 [inline]
 wb_workfn+0x40b/0x1940 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages mm/mempolicy.c:2335 [inline]
 folio_alloc+0x1d0/0x230 mm/mempolicy.c:2342
 filemap_alloc_folio+0xa6/0x440 mm/filemap.c:984
 __filemap_get_folio+0xa10/0x14b0 mm/filemap.c:1926
 ext4_write_begin+0x3e5/0x2230 fs/ext4/inode.c:1159
 ext4_da_write_begin+0x4cd/0xec0 fs/ext4/inode.c:2869
 generic_perform_write+0x400/0xc60 mm/filemap.c:3974
 ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
 ext4_file_write_iter+0x208/0x3450
 __kernel_write_iter+0x68b/0xc40 fs/read_write.c:523
 __kernel_write+0xca/0x100 fs/read_write.c:543
 __dump_emit fs/coredump.c:813 [inline]
 dump_emit+0x3aa/0x5d0 fs/coredump.c:850
 writenote+0x2ad/0x480 fs/binfmt_elf.c:1422
 write_note_info fs/binfmt_elf.c:1912 [inline]
 elf_core_dump+0x4f77/0x59c0 fs/binfmt_elf.c:2064
 do_coredump+0x32d5/0x4920 fs/coredump.c:764
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0xa6/0x160 kernel/entry/common.c:231
 irqentry_exit+0x16/0x60 kernel/entry/common.c:334
 exc_general_protection+0x2e6/0x4b0 arch/x86/kernel/traps.c:644
 asm_exc_general_protection+0x2b/0x30 arch/x86/include/asm/idtentry.h:617

CPU: 0 PID: 57 Comm: kworker/u8:3 Not tainted 6.9.0-rc5-syzkaller-00329-g5d12ed4bea43 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-7:1)
=====================================================


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

