Return-Path: <linux-kernel+bounces-130806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CCC897D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635C2282A24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD9125B9;
	Thu,  4 Apr 2024 01:08:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F148101DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192884; cv=none; b=hBw9+0mx+77YGCbnDYXybFQaczPeDqMaxor8Wy39ETJcUXuX8+Fz+Oj4zsD4+YMXTrdgIawrDefIOPg4POIqczsEsc9ajzzoAY1pljCWQ/dqC7fX/J82hVFiMqPS2krhlcES2QZ2fiUtkTcnaK12NY/y4K75hY05HJT+A1V/RAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192884; c=relaxed/simple;
	bh=tHqj0imtP77X0GOjslRjoU+2HZ7dAYRxwcPCqKd1rf8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KGLLaV8tfXGqPN3xr6X2sIVwejtcbi9ySjw+lhL4IEMhiUGmAr6HvuVLVFJAdV08VXm22B0LNsjxMINqFiqARctsstrtuMd8EtEwFkinj3W49BDB4Ekbt02Dnf+d8CYo46CVAzkQZicyhrs9IUYVvo+v8weGBkQIlWGaqVEFfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc74ea8606so52236139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 18:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712192882; x=1712797682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2bErP/lP2La0gLtoJoIwk6KRU7s1LtGPBEMCkV/05Y=;
        b=Alqw59F6Q/M+5tJtbopQmasUw77LYzJrpClMc5X5J1Ia54624k9g4gIoZfw1A6npYZ
         03BrLNOM4VlKSN1Q/QHfz2h+iakETGqs7AfFKB60cP7M4arCnZxsLuaUn40ycQor3wQr
         QawFWj90u75ZSWjSAvSti0shgqMuCknIEY48+4uPrsWL5dH/hbiQD4BsUdXX8TXgczQg
         saAMDxN/BdZrc5MxyJNoSHsXdsPOKUzqp4eW4H2dAg88f74zX3KFugyBy8xBSUhpQ+XJ
         y51/Hpxn2Bss+uCZgO7qo60RQ7Z6g1KFvbbEW3/OyMqY42mp2NhwwaAGYjBPqsDVyyqD
         cmrw==
X-Forwarded-Encrypted: i=1; AJvYcCUQyJMP9bh7AqNNIIoUHAB6gz8vaByve+xoevIeSCpvKMNKFfQDnbbLJel5UM4uvGu8SeVVdxLRmMVeGyXp5p/U5oeVFmydCecotwWf
X-Gm-Message-State: AOJu0Yy0RIA8Wlm2G/Dlyd9HxTLyLO4V6phqv1EjfhKf4SuYDZ7h6aSv
	dYVpO+GFCmZHaiXwe2QjUqWw899dSxw48yixnGYP3wgx+/kPWzWTwxLjFyxppK5BU2ojTUaUQ/3
	Ota9dRG+ucIBVpgzwBDN7IbY/0X+psk/yE2BvWzB32lbR08mHMd3TPZg=
X-Google-Smtp-Source: AGHT+IEB9c/4MTmwA/MkyZOIVo07Psc1I9x7T/CZ8GxIwruKXlg685n/W7Dw7rC/na6w2Jk6UAwJJL3Ok6F1uOdn9t+L12Wo2yTi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:148b:b0:47f:1cf3:e571 with SMTP id
 j11-20020a056638148b00b0047f1cf3e571mr31145jak.3.1712192882235; Wed, 03 Apr
 2024 18:08:02 -0700 (PDT)
Date: Wed, 03 Apr 2024 18:08:02 -0700
In-Reply-To: <20240404004257.3933-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008885bc06153af8ef@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
From: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in kernfs_fop_llseek

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/5486 is trying to acquire lock:
ffff88807ec0b888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_llseek+0x7e/0x2a0 fs/kernfs/file.c:867

but task is already holding lock:
ffff888050982238 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock fs/overlayfs/overlayfs.h:649 [inline]
ffff888050982238 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_llseek+0x28a/0x4a0 fs/overlayfs/file.c:215

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ovl_i_lock_key[depth]){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
       ovl_nlink_start+0xdc/0x390 fs/overlayfs/util.c:1162
       ovl_do_remove+0x1fa/0xd90 fs/overlayfs/dir.c:893
       vfs_rmdir+0x367/0x4c0 fs/namei.c:4209
       do_rmdir+0x3b5/0x580 fs/namei.c:4268
       __do_sys_rmdir fs/namei.c:4287 [inline]
       __se_sys_rmdir fs/namei.c:4285 [inline]
       __x64_sys_rmdir+0x49/0x60 fs/namei.c:4285
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:803 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1708
       walk_component+0x2e1/0x410 fs/namei.c:2004
       lookup_last fs/namei.c:2461 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2485
       filename_lookup+0x256/0x610 fs/namei.c:2514
       kern_path+0x35/0x50 fs/namei.c:2622
       lookup_bdev+0xc5/0x290 block/bdev.c:1072
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
       kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&of->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_fop_llseek+0x7e/0x2a0 fs/kernfs/file.c:867
       ovl_llseek+0x335/0x4a0 fs/overlayfs/file.c:219
       vfs_llseek fs/read_write.c:289 [inline]
       ksys_lseek fs/read_write.c:302 [inline]
       __do_sys_lseek fs/read_write.c:313 [inline]
       __se_sys_lseek fs/read_write.c:311 [inline]
       __x64_sys_lseek+0x153/0x1e0 fs/read_write.c:311
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

Chain exists of:
  &of->mutex --> &ovl_i_mutex_dir_key[depth] --> &ovl_i_lock_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_lock_key[depth]);
                               lock(&ovl_i_mutex_dir_key[depth]);
                               lock(&ovl_i_lock_key[depth]);
  lock(&of->mutex);

 *** DEADLOCK ***

3 locks held by syz-executor.0/5486:
 #0: ffff8880707c8ac8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x259/0x320 fs/file.c:1191
 #1: ffff888050981e80 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #1: ffff888050981e80 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}, at: ovl_llseek+0x277/0x4a0 fs/overlayfs/file.c:207
 #2: ffff888050982238 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock fs/overlayfs/overlayfs.h:649 [inline]
 #2: ffff888050982238 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_llseek+0x28a/0x4a0 fs/overlayfs/file.c:215

stack backtrace:
CPU: 0 PID: 5486 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 kernfs_fop_llseek+0x7e/0x2a0 fs/kernfs/file.c:867
 ovl_llseek+0x335/0x4a0 fs/overlayfs/file.c:219
 vfs_llseek fs/read_write.c:289 [inline]
 ksys_lseek fs/read_write.c:302 [inline]
 __do_sys_lseek fs/read_write.c:313 [inline]
 __se_sys_lseek fs/read_write.c:311 [inline]
 __x64_sys_lseek+0x153/0x1e0 fs/read_write.c:311
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fe1f567dde9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe1f64370c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 00007fe1f57abf80 RCX: 00007fe1f567dde9
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fe1f56ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe1f57abf80 R15: 00007ffe353f4cc8
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104e8475180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1799f6ad180000


