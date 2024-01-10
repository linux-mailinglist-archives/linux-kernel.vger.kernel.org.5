Return-Path: <linux-kernel+bounces-22054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AFB82987D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD81D1F215DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC01E47773;
	Wed, 10 Jan 2024 11:13:29 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3BE47762
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.212])
	by sina.com (172.16.235.24) with ESMTP
	id 659E7BC6000065AC; Wed, 10 Jan 2024 19:13:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 24414645089343
X-SMAIL-UIID: 3D2FD0E1EA664BFE8DEFFE8F43FA42A4-20240110-191313-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com>
Cc: Theodore Tso <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_quota_write
Date: Wed, 10 Jan 2024 19:12:59 +0800
Message-Id: <20240110111259.3285-1-hdanton@sina.com>
In-Reply-To: <0000000000007ab6f3060e87524f@google.com>
References: <20240106024807.3011-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Jan 2024 10:17:07 -0800
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> kernel BUG in ext4_quota_write
> 
> EXT4-fs error (device loop0) in ext4_process_orphan:347: Corrupt filesystem
> EXT4-fs (loop0): 1 truncate cleaned up
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
> ext4 filesystem being mounted at /root/syzkaller-testdir1916097639/syzkaller.TbSsym/0/file1 supports timestamps until 2038-01-19 (0x7fffffff)
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/super.c:7251!

Given the BUG_ON in the debug patch tested, could deadlock be the reason
behind the trigger instead of IO in flight? Or is it due to corrupted
filesystem at the first place?

> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5480 Comm: syz-executor.0 Not tainted 6.7.0-rc8-syzkaller-00159-ga4ab2706bb12-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> RIP: 0010:ext4_quota_write+0x6e5/0x6f0 fs/ext4/super.c:7251
> Code: f9 ff ff e8 8d 37 39 ff 48 c7 c7 00 16 af 8d 4c 89 e6 48 89 da e8 7b 2e 68 02 e9 38 fa ff ff e8 21 27 c3 08 e8 6c 37 39 ff 90 <0f> 0b 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 53 48 89 fb e8 53 37
> RSP: 0018:ffffc9000547ee00 EFLAGS: 00010293
> RAX: ffffffff82554284 RBX: ffff8880739ac690 RCX: ffff88801bfd0000
> RDX: 0000000000000000 RSI: ffff8880739ac690 RDI: ffff8880739ac690
> RBP: ffffc9000547eef0 R08: ffffffff82553f4d R09: 0000000000000001
> R10: dffffc0000000000 R11: ffffed100e7358d3 R12: ffff8880739ac690
> R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880739ac690
> FS:  00007f079ddca6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055636d85ffc8 CR3: 0000000028711000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  qtree_write_dquot+0x243/0x530 fs/quota/quota_tree.c:431
>  v2_write_dquot+0x120/0x190 fs/quota/quota_v2.c:358
>  dquot_commit+0x3c4/0x520 fs/quota/dquot.c:512
>  ext4_write_dquot+0x1f2/0x2c0 fs/ext4/super.c:6877
>  mark_dquot_dirty fs/quota/dquot.c:372 [inline]
>  mark_all_dquot_dirty fs/quota/dquot.c:410 [inline]
>  dquot_alloc_inode+0x69f/0xb70 fs/quota/dquot.c:1780
>  ext4_xattr_inode_alloc_quota fs/ext4/xattr.c:932 [inline]
>  ext4_xattr_set_entry+0xaf3/0x3fc0 fs/ext4/xattr.c:1715
>  ext4_xattr_block_set+0x73f/0x3680 fs/ext4/xattr.c:1970
>  ext4_xattr_set_handle+0xcdf/0x1570 fs/ext4/xattr.c:2456
>  ext4_xattr_set+0x241/0x3d0 fs/ext4/xattr.c:2558
>  __vfs_setxattr+0x460/0x4a0 fs/xattr.c:201
>  __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
>  vfs_setxattr+0x221/0x420 fs/xattr.c:322
>  do_setxattr fs/xattr.c:630 [inline]
>  setxattr+0x25d/0x2f0 fs/xattr.c:653
>  path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
>  __do_sys_setxattr fs/xattr.c:688 [inline]
>  __se_sys_setxattr fs/xattr.c:684 [inline]
>  __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
[...]
> 
> Tested on:
> 
> commit:         a4ab2706 Merge tag 'firewire-fixes-6.7-final' of git:/..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f50a09e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
> dashboard link: https://syzkaller.appspot.com/bug?extid=a43d4f48b8397d0e41a9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15123275e80000

