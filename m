Return-Path: <linux-kernel+bounces-144308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6988A446A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7312824EA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F60135A49;
	Sun, 14 Apr 2024 17:38:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7F1E534
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713116286; cv=none; b=povnXGcPeQFXttRBjmAmqbImYS6UXXyRzIa5h0GUg4e+mSq/3Lwnayko6FaYD2xTdSxnWE4C8cRvlJDFsS4OhGQjrro5ZJgCJ1QyhSwSlEoJ9rYgdx0/NvEhOO7uSycyLL1Ze8fUzVOB5giLDB/bG4v3uWvbwB+gmOFjCDbLFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713116286; c=relaxed/simple;
	bh=uidr0Ddh6k6IXNaT2mGWFi9tNi0K/wpCj/XjlY0jXF0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MewZ+PXwNCbkp5tf9w8coeVEkQb0u+kkr3Qf+5T1/v7Ztbg2zoYY542c/Bzdhpz911wjVxB/8BhtAhfkwFwLqFvpa1JkVQJtukVIZaxBI78g+E65Q9ocxuzndNT2Dyq4M2oZ9byVD5UNvBrVJoqogu8YIXYdC/RyfC2EqcKllBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a1149d7d5so29132505ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 10:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713116284; x=1713721084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBIO3XDXi4ggfPw+M/6u4pNUuoaraJSFo9S0jlwTc2w=;
        b=ewF9HLAz/WeWbOnyfQWQ5AOCYDI3wkXgx7ma/pr2R3QrmSup+f3Bjmyo/NHArj6S/u
         A+hDqFh07zcwuytnTJ9lOZ5fhLASxq2l/mqZ7nhM995dxnHUpn6CWPZDU6qSXbAuYJ90
         fPcIh6yVe3jXOd6jqcXfco2CXimlhMb+jY1OPexZMloRmZfZJ5SjsPnfvDECinJLRpPF
         bskydh6MJClL3ZsBsiHTncxvKZFjPIKwVzFDAwtFI13y5gJt/Y7dMSfgO+ewfw2W+ZBS
         lvL1w6cwmRB1as791mps0B06ojboj/V+gujtaWWIqB6ohhAPloLqCPcFxOcpXlJI/zZ/
         TPUg==
X-Gm-Message-State: AOJu0YxeOpU2bj8oTVk0CossyVuSdBNI2GqDH+OcXG9ymG/2weGkT8Kk
	R5V0FwDPtBUMvpFLY306cS3Ug47qzAC6mV+0CgebnW3vKvKxck4w9EsyEkeLLBsonclKkUYhTg1
	Bv1xW3QxMpgwv6lYf/jzKry+SNkP794vAKqwR2Aj1yb1rJFMimxzhBIc=
X-Google-Smtp-Source: AGHT+IGoZLJe3wzZ6QNxIF90brlarMgNhhXSKYDwvJ0EJ6GJDjLXobrNnK5YJ0SU6f8dtPvTeC03pwH5QdnwO3Oxk9WHGXGoZFLa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:36a:92dc:a398 with SMTP id
 j10-20020a056e02218a00b0036a92dca398mr419730ila.1.1713116283969; Sun, 14 Apr
 2024 10:38:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 10:38:03 -0700
In-Reply-To: <CAE8VWiJFOtDVnSgMUmr0OsgUr6E+c9m5p_n-Dg_qn2LCdu2jcA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090b32f061611f7ff@google.com>
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

CPU: 0 PID: 5496 Comm: syz-executor.0 Not tainted 6.9.0-rc3-syzkaller-00365-g399f4dae683a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


Tested on:

commit:         399f4dae Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1322ffdd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=807e31f7fd7666b5
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157ba243180000


