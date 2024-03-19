Return-Path: <linux-kernel+bounces-107613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2F87FF23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE47CB21C98
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62748172E;
	Tue, 19 Mar 2024 13:56:44 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B981216
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856604; cv=none; b=cb3+ILSMjz/bLesc3x7buYBa3I/+H3Hl5yWrtv+4j+jsvWTTIonPBihQowUjcHU58E/3xx5cYpcAiaq8+J+GPgEEb41dnETParsJNJjCJ1OM/1qYvz3Ko/EIzxvATANxEx9KJlQ0IFHxnXTwUVPg7mmsxRU/0ZVyrYjjpETpAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856604; c=relaxed/simple;
	bh=SiSKHuFwh9lLOtDAXnJW9R6P2jVsOoCWB+Gw3+hldUg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FDoLWMsuNHxSjKn5AMgjb2eBUWW4OcpZd7N/QCj1xQZl+EIm0k9E5nVsTu5z7/zEhbp0JkvhQhxpKctIo1H9JR4as8fvzqNtFJL0DjTUsS0UmDWDkW6V4v3a80wqcJyWHddVEoZWxq0lP7kJxxZJUElCbfX1/WKPJvql6KlHlEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbfd4781fcso376756739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710856602; x=1711461402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9TLtr2LXddztPLvauUkkgcrDfwPnuzScqtnLmCwUfs=;
        b=rWs9LSOFGVcKhr3HsUiPBFCTFRtvgfr4R5BMSc41cQD/7BbRkeJnOItN9fJo3NzgiD
         AWYluhjWeFPIJGAkuXuTeLXVOLfMmH+VTsezmcIYjRlXEPwi+oNxPoi+xoJbhUYhzN1d
         w69DJFygcvo2IKfFUcZKeSEU1tmRvKo7E2+LuNV13SV7MJK68s3hQyqTqudUbqNza/RV
         FOLb2sZZwSUqVhmjffgCguDqQaVkVp5XI+iAtSMzKw5ip57tpB+Nz/+EZsVc5R9+V5QD
         BZApEdsdgwYf34czZ0mrVy55CM1Hj8LZ8gZVM240JNF3v0n6TSDse4keGbJyhiJfWFWB
         wAVg==
X-Gm-Message-State: AOJu0YzPeeyUc5ToZu/f65XqfaGsS/bZBNkGA+YRBXZkSCIcdkHv2Ox9
	QTMmTceRC7BL03M4FgcjE/aqONWlurQ15gndfb0KQ6QWBH8bu7+y8S18/h7kCpG++EA8yr8NTmL
	sQ16+dAHv0HCa33I7gb+AXF+wUA9NY40qUrkEAyJ8hk7V6yDUXyDrfcnTpQ==
X-Google-Smtp-Source: AGHT+IGyYV88jGflZZU+zKAPhICTypPZEU4mYkuEDAyUxNRJLQ1fV9oO/ZvKHWpn/zm5ztV6SkU4QOi8qBaqbrnsj6ck3+40nI0Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8923:b0:474:ed8f:ffa8 with SMTP id
 jc35-20020a056638892300b00474ed8fffa8mr69278jab.4.1710856601948; Tue, 19 Mar
 2024 06:56:41 -0700 (PDT)
Date: Tue, 19 Mar 2024 06:56:41 -0700
In-Reply-To: <0000000000002750950613c53e72@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000563d3061403d83d@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
Author: eric.vanhensbergen@linux.dev

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git b4/fix-evict-uninitialized-value

March 16, 2024 at 6:15 AM, "syzbot" <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com> wrote:
> 
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit: 66a27abac311 Merge tag 'powerpc-6.9-1' of git://git.kernel..
> 
> git tree: upstream
> 
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=147b32a5180000
> 
> kernel config: https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
> 
> dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
> 
> compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=12598006180000
> 
> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=105d8aa5180000
> 
> Downloadable assets:
> 
> disk image: https://storage.googleapis.com/syzbot-assets/37968fa0451e/disk-66a27aba.raw.xz
> 
> vmlinux: https://storage.googleapis.com/syzbot-assets/5b288c5c3088/vmlinux-66a27aba.xz
> 
> kernel image: https://storage.googleapis.com/syzbot-assets/792ddbf8146d/bzImage-66a27aba.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> 
> Reported-by: syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com
> 
> =====================================================
> 
> BUG: KMSAN: uninit-value in fscache_relinquish_cookie include/linux/fscache.h:307 [inline]
> 
> BUG: KMSAN: uninit-value in v9fs_evict_inode+0x109/0x130 fs/9p/vfs_inode.c:356
> 
>  fscache_relinquish_cookie include/linux/fscache.h:307 [inline]
> 
>  v9fs_evict_inode+0x109/0x130 fs/9p/vfs_inode.c:356
> 
>  evict+0x3ae/0xa60 fs/inode.c:667
> 
>  iput_final fs/inode.c:1741 [inline]
> 
>  iput+0x9ca/0xe10 fs/inode.c:1767
> 
>  iget_failed+0x15e/0x180 fs/bad_inode.c:248
> 
>  v9fs_fid_iget_dotl+0x375/0x570 fs/9p/vfs_inode_dotl.c:96
> 
>  v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
> 
>  v9fs_mount+0xc02/0x12b0 fs/9p/vfs_super.c:142
> 
>  legacy_get_tree+0x114/0x290 fs/fs_context.c:662
> 
>  vfs_get_tree+0xa7/0x570 fs/super.c:1779
> 
>  do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
> 
>  path_mount+0x742/0x1f20 fs/namespace.c:3679
> 
>  do_mount fs/namespace.c:3692 [inline]
> 
>  __do_sys_mount fs/namespace.c:3898 [inline]
> 
>  __se_sys_mount+0x725/0x810 fs/namespace.c:3875
> 
>  __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
> 
>  do_syscall_64+0xd5/0x1f0
> 
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Uninit was created at:
> 
>  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
> 
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
> 
>  alloc_pages_node include/linux/gfp.h:261 [inline]
> 
>  alloc_slab_page mm/slub.c:2175 [inline]
> 
>  allocate_slab mm/slub.c:2338 [inline]
> 
>  new_slab+0x2de/0x1400 mm/slub.c:2391
> 
>  ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
> 
>  __slab_alloc mm/slub.c:3610 [inline]
> 
>  __slab_alloc_node mm/slub.c:3663 [inline]
> 
>  slab_alloc_node mm/slub.c:3835 [inline]
> 
>  kmem_cache_alloc_lru+0x6d7/0xbe0 mm/slub.c:3864
> 
>  alloc_inode_sb include/linux/fs.h:3089 [inline]
> 
>  v9fs_alloc_inode+0x62/0x130 fs/9p/vfs_inode.c:228
> 
>  alloc_inode+0x86/0x460 fs/inode.c:261
> 
>  iget_locked+0x2bf/0xee0 fs/inode.c:1280
> 
>  v9fs_fid_iget_dotl+0x7f/0x570 fs/9p/vfs_inode_dotl.c:62
> 
>  v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
> 
>  v9fs_mount+0xc02/0x12b0 fs/9p/vfs_super.c:142
> 
>  legacy_get_tree+0x114/0x290 fs/fs_context.c:662
> 
>  vfs_get_tree+0xa7/0x570 fs/super.c:1779
> 
>  do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
> 
>  path_mount+0x742/0x1f20 fs/namespace.c:3679
> 
>  do_mount fs/namespace.c:3692 [inline]
> 
>  __do_sys_mount fs/namespace.c:3898 [inline]
> 
>  __se_sys_mount+0x725/0x810 fs/namespace.c:3875
> 
>  __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
> 
>  do_syscall_64+0xd5/0x1f0
> 
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> CPU: 1 PID: 5014 Comm: syz-executor406 Not tainted 6.8.0-syzkaller-11136-g66a27abac311 #0
> 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> 
> =====================================================
> 
> ---
> 
> This report is generated by a bot. It may contain errors.
> 
> See https://goo.gl/tpsmEJ for more information about syzbot.
> 
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> 
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> 
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> 
> #syz test: git://repo/address.git branch-or-commit-hash
> 
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> 
> #syz set subsystems: new-subsystem
> 
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> 
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> 
> #syz undup
>

