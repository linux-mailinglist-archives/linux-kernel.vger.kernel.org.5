Return-Path: <linux-kernel+bounces-143941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907288A3FF0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9A2B21A88
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723814AA0;
	Sun, 14 Apr 2024 02:35:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED753FF4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713062105; cv=none; b=XvD7LKzKiE9j1V6CtreZtTgXvc7w+873zVAuRwAB47QW8obfydQO4x6wyaQdOJ/8LIU6sL2CGXDNMIEcVwn6ibeGiXUtSQ571kYU/qjEGAEbSyEwo3ZiE8Pwj/tJI3+Zo2D+lYpkVyCDfZC8/JAihfbgCLWJIMfQuUeR/DtLgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713062105; c=relaxed/simple;
	bh=UNgW4+BWFdcreAxVIML+YD7GqdOKV4RFBfeV88ZQFQc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GNFliX6XQ7W5XFWpJLzQp9vJeL9+8E7SYEWfNNX+RAhg9jruLDK81SwEerdRvM47u5IyeBJh5S4Dg6jgAyo+ybB8oZDBXRciqDQAcXn6W++tahSD7I/Ef590+hvNyXEyL+bVY+0JPKfZ/PrxPz1GXZCRFSNXDBIaLez+XqmgGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so241946139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713062104; x=1713666904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shDnrpFWJRRlmzyiLbFfDXmT/ImMCXFjVsJzq9rI5Ww=;
        b=sFEkHMf0974zVNw4uW8T/2Jwosk9LeMX0/kPKQxz9GhcRjxqm5V/2uy8Q64wIy0xpY
         6iCfLtpyznWov1oD/PtZcTD/6cRN8bY1oetsjwwalSqpy0/+etD7BSGcsbtQ185sV5pD
         Y08sqBAK/PYUICXL2S1Mr2CLrgIM+s37UU60D1X17fPBfjEoTjatlgl4HVJAf+v5ENKc
         WHHQ6nnlA9ZbYP2Tgp2SRZR7F0lBV7CHygjxsROW+S/fG6QuEcMDoYxsRFyxEuUks17v
         LqHJ/bwkdaGKExk5ncRtyxHTxzAuwJoaKsqhgBW+ljV9R/dBCc6QBrCB+tz/qgzDxBQE
         hM7A==
X-Gm-Message-State: AOJu0YxKXjHh0tJoxxWtq7m43UoGfVhiKb19JUV+r3k24g4dgpYz9lsA
	LXVubwM4C/UJNEOb1c1LDUC4Yj9o3WUQmWprGxdfbkWKyJRLNOOFYRLXTctmMgrquT2tYzFhP4O
	I+k32pUWd+IJ4fB6iZhJ3NVNL1x9Z+sTNbp0m2OjGhBXN3F3PnS9EG4s=
X-Google-Smtp-Source: AGHT+IEY45y1+iYgkhBv/VerptCPUCxIbxAwK0h+PBRrNw8qW1r1XSrcaqYSi91wi5GThM8P2AVyoPQwZqCoqzfAUdLFKuh6cUAR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410a:b0:482:fa6e:648c with SMTP id
 ay10-20020a056638410a00b00482fa6e648cmr52461jab.3.1713062103795; Sat, 13 Apr
 2024 19:35:03 -0700 (PDT)
Date: Sat, 13 Apr 2024 19:35:03 -0700
In-Reply-To: <CAE8VWiKc3tWxyyDFBYCn81rpTcgc4nAB=KgQCno4j0C96gTkaA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cd9be0616055ada@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_revalidate_dentry
From: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, shresthprasad7@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hfs_revalidate_dentry

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in hfs_revalidate_dentry+0x30b/0x3f0 fs/hfs/sysdep.c:30
 hfs_revalidate_dentry+0x30b/0x3f0 fs/hfs/sysdep.c:30
 lookup_fast+0x418/0x8e0
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x817/0x1490 fs/namei.c:2331
 path_lookupat+0xd9/0x6f0 fs/namei.c:2484
 filename_lookup+0x22f/0x750 fs/namei.c:2514
 user_path_at_empty+0x8b/0x3a0 fs/namei.c:2921
 user_path_at include/linux/namei.h:57 [inline]
 do_mount fs/namespace.c:3689 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x66b/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 x64_sys_call+0x2bf4/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_lru+0x6d7/0xbe0 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 hfs_alloc_inode+0x5a/0xd0 fs/hfs/super.c:165
 alloc_inode+0x86/0x460 fs/inode.c:261
 iget_locked+0x2bf/0xee0 fs/inode.c:1280
 hfs_btree_open+0x16c/0x1aa0 fs/hfs/btree.c:38
 hfs_mdb_get+0x1fe2/0x28b0 fs/hfs/mdb.c:199
 hfs_fill_super+0x1cf6/0x23c0 fs/hfs/super.c:406
 mount_bdev+0x397/0x520 fs/super.c:1658
 hfs_mount+0x4d/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 x64_sys_call+0x2bf4/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5493 Comm: syz-executor.0 Not tainted 6.9.0-rc3-syzkaller-00355-g7efd0a74039f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


Tested on:

commit:         7efd0a74 Merge tag 'ata-6.9-rc4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1602674d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=807e31f7fd7666b5
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

