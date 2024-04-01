Return-Path: <linux-kernel+bounces-127106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6988946BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBE91F21F66
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883AF55792;
	Mon,  1 Apr 2024 21:52:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB554F86
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008351; cv=none; b=tCoUxoa0pHWoOMlHn3OXYRyX30KTz890ivHH169DKy9dtX4ICFaR/eAS7bMJY3sQXH81ypKyplf7s3Qy9BhnihAfw4GXfk7VmTi3FOHmOxqk4y+UhZ/NvXKgxSjtMjqzDQDr6itS9B2eQv9IlWQS30DB07br32anF07MT2BPXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008351; c=relaxed/simple;
	bh=xtYhY6BUwXMkLZQpueJJRtQUlxtILmj53ZBM5qa4QH8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UIo0nSTsRfw+LnBiwJ7McoEnK5Dae7gUfce4evnxBQzJZcGJeSnlPpBIMGKApkBPuR2swuj5bqMkNnTDZWaSwg+OQMKsQOGqk84/WApILKzU4CQUsyu5q0psdzQekNJlEHnDS6cvuzOH1kyJExGWJYwj1RmlgXPOFezdlkfPi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a930922so537613739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 14:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008348; x=1712613148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIp5Xn9VQEO0Vio5ZiAXvasphmfPQLpRkI2nVtDTRhw=;
        b=gDLlAsMQtbPBeQs/0WygaIApFA+K5cS7y2f9VFGMK0WkCPElWUo98Rji4jF2DhXUPy
         AoTui5y4L0K+XLTdL+V9y45CO3kPhfBYGWBtf7gSDkKwUQoopphOabb/UXesW4lNdRgX
         AaA8hnpuNoEE4SQMip5bNHCkBaBTbVjbESjijs/RZv9OfDmqnzdKhqqBKa3v+PPRN0Ho
         9XdnVvAc88blremzcEaO+fJLU1sMje3xNHzKat8Tyo4ONS+qr9nDoDC3rwWbKj1/li/l
         TQP0M24QSRf1PmCoVekPQLHSFdiVSMOP9LLirVg6AqGls31xixkZ2eEPa4RTzC2xeLzT
         Tw+g==
X-Forwarded-Encrypted: i=1; AJvYcCWO9GgSSAx3thBgr9VAAo/YRASlOQBa6FWRz/A6afMZNy8v86Sdzc23gb2FUs9u1iUjhM+gK/ayGlqnWDQMFeuY7LGlVySB8UtTwGl9
X-Gm-Message-State: AOJu0YwO22F5IcQecfxAbbUpbZ0VdPaJudvMdFCBBeD2xhBATEaRgO9Y
	I+C4OwQWn3P+kL2cP+2Ue4c75D/CLotH1Feg/X7AqdqAIchoC0n4FZhdiDsPd3QgPDj63TIviCV
	mjiqdMai35ZCp5YC61wPvEouwUwnp5K3kuwVpFxZt6EZNlgjkRBwMfUE=
X-Google-Smtp-Source: AGHT+IHx3DqEGJH/2qNpD/v9+eFAO9DANdNQdIUC8z82HdCogsPYZmnc3Dhxa36gtK4L2NvXqEXAO+CX4vA2iCnahdwbGO9eUhKo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2725:b0:476:ed02:e2da with SMTP id
 m37-20020a056638272500b00476ed02e2damr467657jav.5.1712008348259; Mon, 01 Apr
 2024 14:52:28 -0700 (PDT)
Date: Mon, 01 Apr 2024 14:52:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000736bd406151001d7@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (4)
From: syzbot <syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1385be41180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ccde1a19e22/disk-8d025e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45420817e7d9/vmlinux-8d025e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354bdafd8c8f/bzImage-8d025e20.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KMSAN: uninit-value in __crc32c_le_base+0x43c/0xd80 lib/crc32.c:201
 crc32_body lib/crc32.c:110 [inline]
 crc32_le_generic lib/crc32.c:179 [inline]
 __crc32c_le_base+0x43c/0xd80 lib/crc32.c:201
 chksum_update+0x5b/0xd0 crypto/crc32c_generic.c:88
 crypto_shash_update+0x79/0xa0 crypto/shash.c:70
 csum_tree_block+0x35f/0x5d0 fs/btrfs/disk-io.c:96
 btree_csum_one_bio+0x4d5/0xeb0 fs/btrfs/disk-io.c:294
 btrfs_bio_csum fs/btrfs/bio.c:538 [inline]
 btrfs_submit_chunk fs/btrfs/bio.c:741 [inline]
 btrfs_submit_bio+0x1eb6/0x2930 fs/btrfs/bio.c:770
 write_one_eb+0x13fa/0x1570 fs/btrfs/extent_io.c:1750
 submit_eb_page fs/btrfs/extent_io.c:1909 [inline]
 btree_write_cache_pages+0x1d2a/0x29a0 fs/btrfs/extent_io.c:1959
 btree_writepages+0x84/0x270 fs/btrfs/disk-io.c:516
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_fdatawrite_range+0xe1/0x110 mm/filemap.c:448
 btrfs_write_marked_extents+0x2e7/0x620 fs/btrfs/transaction.c:1154
 btrfs_sync_log+0x9fd/0x3830 fs/btrfs/tree-log.c:2969
 btrfs_sync_file+0x144c/0x1c60 fs/btrfs/file.c:1968
 vfs_fsync_range+0x20d/0x270 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2793 [inline]
 btrfs_do_write_iter+0x1c5f/0x2270 fs/btrfs/file.c:1695
 btrfs_file_write_iter+0x38/0x50 fs/btrfs/file.c:1705
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_bulk+0x19e/0x21e0 mm/page_alloc.c:4523
 alloc_pages_bulk_array include/linux/gfp.h:202 [inline]
 btrfs_alloc_page_array+0x9e/0x460 fs/btrfs/extent_io.c:689
 alloc_eb_folio_array fs/btrfs/extent_io.c:724 [inline]
 alloc_extent_buffer+0xa68/0x4180 fs/btrfs/extent_io.c:3859
 btrfs_find_create_tree_block+0x46/0x60 fs/btrfs/disk-io.c:610
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:5063 [inline]
 btrfs_alloc_tree_block+0x35c/0x17c0 fs/btrfs/extent-tree.c:5178
 btrfs_alloc_log_tree_node fs/btrfs/disk-io.c:960 [inline]
 btrfs_add_log_tree+0x1b7/0x7a0 fs/btrfs/disk-io.c:1008
 start_log_trans fs/btrfs/tree-log.c:208 [inline]
 btrfs_log_inode_parent+0x9b6/0x1dd0 fs/btrfs/tree-log.c:7066
 btrfs_log_dentry_safe+0x9a/0x100 fs/btrfs/tree-log.c:7171
 btrfs_sync_file+0x126c/0x1c60 fs/btrfs/file.c:1933
 vfs_fsync_range+0x20d/0x270 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2793 [inline]
 btrfs_do_write_iter+0x1c5f/0x2270 fs/btrfs/file.c:1695
 btrfs_file_write_iter+0x38/0x50 fs/btrfs/file.c:1705
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5344 Comm: syz-executor.4 Not tainted 6.9.0-rc1-syzkaller-00061-g8d025e2092e2 #0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

