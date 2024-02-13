Return-Path: <linux-kernel+bounces-63400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D6852ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C044C2856A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15E335DB;
	Tue, 13 Feb 2024 11:10:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374322081
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822604; cv=none; b=BbpiIy4Z6MFiMLSSO1HkXC6T/0nMnxQ54zT5U3U0ZMhJtyhm71J4Yo1kCBm7PikrKjHkgnIJMR9cPexEJOArNhiMr/5BhzQxLnS7soRXFexAWXkLaKRU3kdt3lZSyZ4Mft5EET0oZc24JtxR9CQMS0U8yLbQ+95CTSCUkjKOlcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822604; c=relaxed/simple;
	bh=PVpICH1OGEAbLtHOkYgs9JYlUhXZwCt8fGNRxFC6vVQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zt1UazTlB5TLtt6P6gA6FI9TSu7IcSkZyK+qktEG+lMe0cc1SoS7SqZRkPrTZCQ5XaAa7A2AqUKaqzbcv91I2xxm42bbLOaqPFh1KJ/Oy+/WEG4Tl7gA8cFHsLAd4yu3zxk057UdU9FOQLczm881Dwu6ffzhsGQtv6lTELex+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36422f71c3fso286755ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707822601; x=1708427401;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrozcmJJNtbX7/O0bh/ijnxJn3U9TBFsshfUqi+A9g4=;
        b=Owpmr/j6Xr60+JUtt/FLVvSmBCyC0OJ1oj2PG9Ev0mR+KF4skDWmjGcNBKt6wi1N9B
         t8uPN5t3QIupfsvYVXPK1E0zxj5xl0GTic4Qo++f/LSl7DT91LUlfjI9/wUD+aogAyww
         ZhxL3JG+RY4do9f0iwAO74vjUjC2//TY904QUacwCQ/5GCebGnYqiglyCWSuilo/qMj9
         WtufwqH5cGqt/XWlsGN2sHOSVpcerXmKostVrv64bdUmU7W5A6M+dK3ZyJI6fHFS42NC
         vR4Ccb8VpATWkffqrlEwq7R1bDr/Kohoi+qegwfFjYU6I47N31V+AKZ4nPMOcCRXGVEL
         xGDA==
X-Gm-Message-State: AOJu0YziqvJIOH/+hlJFaV0HFP9SVtxRV8bvUmFZgO+So5hQGQqhIV31
	umOJ4fXrQSh5Dz/e2ao0DOE1EwudWQ6mYedEMljrh2h3HKT2vpa6VSYVaB86hx/25POGtaOZ4oV
	PbF+f/P4eiSuLMRKOWgnYgcsRXFaAPS6v7q61ss6J6Bpl2uEx0WxYmsM=
X-Google-Smtp-Source: AGHT+IEJXXO/JVLihqwxaCbZmyvMBiTQJyMn/y+SsGz6pRMagyEhdJ9ogYsAIBjpCxOZpcazakrGEh49OBtI8678MUK7daGNMg7i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:363:a059:670b with SMTP id
 q14-20020a056e0220ee00b00363a059670bmr756671ilv.4.1707822601673; Tue, 13 Feb
 2024 03:10:01 -0800 (PST)
Date: Tue, 13 Feb 2024 03:10:01 -0800
In-Reply-To: <tencent_E2FE25978DA612195DF45DCD191D4FAF8D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008325b70611416f20@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ntfs_set_state

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
ntfs3: loop0: ino=5, "/" ntfs_iget5
============================================
WARNING: possible recursive locking detected
6.8.0-rc4-syzkaller-00005-gc664e16bb1ba-dirty #0 Not tainted
--------------------------------------------
syz-executor.0/5514 is trying to acquire lock:
ffff888068bf8100 (&ni->ni_lock#3){+.+.}-{3:3}, at: ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947

but task is already holding lock:
ffff888068bf9e80 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
ffff888068bf9e80 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3264

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ni->ni_lock#3);
  lock(&ni->ni_lock#3);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor.0/5514:
 #0: ffff88802ec00420 (sb_writers#13){.+.+}-{0:0}, at: do_sys_ftruncate+0x25c/0x390 fs/open.c:191
 #1: ffff888068bfa120 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff888068bfa120 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x20c/0x310 fs/open.c:64
 #2: ffff888068bf9e80 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
 #2: ffff888068bf9e80 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3264

stack backtrace:
CPU: 0 PID: 5514 Comm: syz-executor.0 Not tainted 6.8.0-rc4-syzkaller-00005-gc664e16bb1ba-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947
 ntfs_iget5+0x3f0/0x3b70 fs/ntfs3/inode.c:535
 ni_update_parent+0x934/0xdc0 fs/ntfs3/frecord.c:3217
 ni_write_inode+0xde9/0x1010 fs/ntfs3/frecord.c:3323
 ntfs_truncate fs/ntfs3/file.c:410 [inline]
 ntfs3_setattr+0x950/0xb40 fs/ntfs3/file.c:703
 notify_change+0xb9f/0xe70 fs/attr.c:499
 do_truncate+0x220/0x310 fs/open.c:66
 do_sys_ftruncate+0x2f7/0x390 fs/open.c:194
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f8b46a7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b478530c8 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f8b46babf80 RCX: 00007f8b46a7dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f8b46aca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8b46babf80 R15: 00007ffcddaf9d18
 </TASK>
ntfs3: loop0: Mark volume as dirty due to NTFS errors


Tested on:

commit:         c664e16b Merge tag 'docs-6.8-fixes2' of git://git.lwn...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=152c5114180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ff6de0180000


