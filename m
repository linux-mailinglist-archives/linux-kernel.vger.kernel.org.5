Return-Path: <linux-kernel+bounces-126916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB69789446E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6277FB2184D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2464EB24;
	Mon,  1 Apr 2024 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="pv12/5Hs"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE83FE55;
	Mon,  1 Apr 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993388; cv=none; b=Qf/25BBGCiNZOKE+ISYx2Lz1Sy81+q1JSlP1SMptCRxzkwpkC9dInQPuY1so6D8Ppfokya/Bi+zy+j4ne1BNY9QKMYvDuHf5dEr/b9b7REiBQ4ufzVpa18zHKZQbOh9Th8y1ZFLNr2U2r3MiU4XPpqOAPrLZXpG7+u6gyonl1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993388; c=relaxed/simple;
	bh=JgU8DwGeS6UdB0ISiaIplMMPCy9sdLqL6ijz1fpUNqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9HqYuXMS9d4FSODIYOUhni0nmE5qo7ZjftpwTTOj0AoXrIhfeZGit6HMJB48Zj0qCQg0/nPZ+DVn+x9lcGoPV1J2OQHao43+XCdSa9ndDaCgVdrAhY/klGaL3+kOJEYBe4ezcW5RbVZ/o7N3sgmTziQNmjhbXY3sHtwhZ2m9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=pv12/5Hs; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Date: Mon, 1 Apr 2024 20:36:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1711993018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HV1qp1NUlPyvoGDoA7alKszkCgDl8gSbryMc5j01V3w=;
	b=pv12/5HsDAD0zZShi3p6j4DD+fYgUUCNL0ULdWiHMD7c2HpDZQ1MyjmL+zK/q34wzeGIoP
	Ve4oGM3aY/bMsC0AwfykPos0qCIe3Gdwu/Bpg5A5FVZuEbpilkIwah9Dfe/wcUlF+HbofV
	nDKEsGmyoSHXuJS4M6KVhieirpwBUdA=
From: Andrey Kalachev <kalachev@swemel.ru>
To: syzbot <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com>
Cc: andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, jmorris@namei.org, john.fastabend@gmail.com,
	kafai@fb.com, kpsingh@chromium.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	serge@hallyn.com, songliubraving@fb.com,
	syzkaller-bugs@googlegroups.com, yhs@fb.com, miklos@szeredi.hu,
	linux-unionfs@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: general protection fault in security_inode_getattr
Message-ID: <ZgrwugCEDH2fLJXK@ural>
References: <0000000000008caae305ab9a5318@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0000000000008caae305ab9a5318@google.com>

On Wed, Jul 29, 2020 at 01:23:18PM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    92ed3019 Linux 5.8-rc7
>git tree:       upstream
>console output: https://syzkaller.appspot.com/x/log.txt?x=140003ac900000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
>dashboard link: https://syzkaller.appspot.com/bug?extid=f07cc9be8d1d226947ed
>compiler:       gcc (GCC) 10.1.0-syz 20200507
>
>Unfortunately, I don't have any reproducer for this issue yet.
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com
>
>general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN
>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>CPU: 0 PID: 9214 Comm: syz-executor.3 Not tainted 5.8.0-rc7-syzkaller #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>RIP: 0010:d_backing_inode include/linux/dcache.h:549 [inline]
>RIP: 0010:security_inode_getattr+0x46/0x140 security/security.c:1276
>Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 04 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5d 08 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
>RSP: 0018:ffffc9000d41f638 EFLAGS: 00010206
>RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000f539000
>RDX: 000000000000000c RSI: ffffffff8354f8ee RDI: 0000000000000060
>RBP: ffffc9000d41f810 R08: 0000000000000001 R09: ffff88804edc2dc8
>R10: 0000000000000000 R11: 00000000000ebc58 R12: ffff888089f10170
>R13: ffffc9000d41f810 R14: 00000000000007ff R15: 0000000000000000
>FS:  00007f3599717700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 0000001b2c12c000 CR3: 0000000099919000 CR4: 00000000001406f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> vfs_getattr+0x22/0x60 fs/stat.c:121
> ovl_copy_up_one+0x13b/0x1870 fs/overlayfs/copy_up.c:850
> ovl_copy_up_flags+0x14b/0x1d0 fs/overlayfs/copy_up.c:931
> ovl_maybe_copy_up+0x140/0x190 fs/overlayfs/copy_up.c:963
> ovl_open+0xba/0x270 fs/overlayfs/file.c:147
> do_dentry_open+0x501/0x1290 fs/open.c:828
> do_open fs/namei.c:3243 [inline]
> path_openat+0x1bb9/0x2750 fs/namei.c:3360
> do_filp_open+0x17e/0x3c0 fs/namei.c:3387
> file_open_name+0x290/0x400 fs/open.c:1124
> acct_on+0x78/0x770 kernel/acct.c:207
> __do_sys_acct kernel/acct.c:286 [inline]
> __se_sys_acct kernel/acct.c:273 [inline]
> __x64_sys_acct+0xab/0x1f0 kernel/acct.c:273
> do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>RIP: 0033:0x45c369
>Code: 8d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>RSP: 002b:00007f3599716c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
>RAX: ffffffffffffffda RBX: 0000000000000700 RCX: 000000000045c369
>RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000440
>RBP: 000000000078bf30 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
>R13: 00007ffda41ffbef R14: 00007f35997179c0 R15: 000000000078bf0c
>Modules linked in:
>---[ end trace d1398a63985d3915 ]---
>RIP: 0010:d_backing_inode include/linux/dcache.h:549 [inline]
>RIP: 0010:security_inode_getattr+0x46/0x140 security/security.c:1276
>Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 04 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5d 08 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
>RSP: 0018:ffffc9000d41f638 EFLAGS: 00010206
>RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000f539000
>RDX: 000000000000000c RSI: ffffffff8354f8ee RDI: 0000000000000060
>RBP: ffffc9000d41f810 R08: 0000000000000001 R09: ffff88804edc2dc8
>R10: 0000000000000000 R11: 00000000000ebc58 R12: ffff888089f10170
>R13: ffffc9000d41f810 R14: 00000000000007ff R15: 0000000000000000
>FS:  00007f3599717700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 0000000020000440 CR3: 0000000099919000 CR4: 00000000001406f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
>---
>This report is generated by a bot. It may contain errors.
>See https://goo.gl/tpsmEJ for more information about syzbot.
>syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>syzbot will keep track of this issue. See:
>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Hello,

I've found that the bug fixed by commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0af950f57fefabab628f1963af881e6b9bfe7f38
merged with mainline here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=be3c213150dc4370ef211a78d78457ff166eba4e

Kernel release 6.5 include the fixed code.

Hence, the stable kernels up to 6.5 still affected.
I've got early version (4.19.139) from syzbot report, here is the first time when been reported.
Maybe previous versions are also affected, I haven't checked it.

I've only deal with stable 5.10 and 6.1, here I can confirm the issue.

The tracing results showed that GPF caused by the dentry shared between two processes.
Suppose we have a regular file `A` onto lower overlayfs layer, metacopy=on.
P1 execute link syscall ( `A` link to `B`), P2 do open `B`.

   P1          P2

   sys_link
               sys_open
                 ovl_lookup B -- lookup non existent `B`, alloc `B` dentry
                   ovl_alloc_entry -- non existent file, zero filled ovl_entry

     ovl_link -- link A to B, use same dentry `B`, dentry associated with
     `A`, lower layer file now.

   sys_link -- return to userspace, zero filled ovl_entry `B` untouched

                     ovl_open B, reuse the same dentry `B`
                       ovl_copy_up_one
                         ovl_path_lower
                           ovl_numlower(oe) -- return 0, numlower in zero filled ovl_entry `oe`
                         ovl_path_lower -- return zero filled `struct path`
                         vfs_getattr(struct path, ..)
                           security_inode_getattr(struct path, ...)
                             d_backing_inode(path->dentry) -- NULL dereference, GPF

Stable kernel v6.1 can be easy fixed by 4 mainline commits transfer:

0af950f57fef ovl: move ovl_entry into ovl_inode
163db0da3515 ovl: factor out ovl_free_entry() and ovl_stack_*() helpers
5522c9c7cbd2 ovl: use ovl_numlower() and ovl_lowerstack() accessors
a6ff2bc0be17 ovl: use OVL_E() and OVL_E_FLAGS() accessors

Just commit 5522c9c7cbd2 has conflict caused by
4609e1f18e19c ("fs: port ->permission() to pass mnt_idmap").
It is enough to change mnt_idmap() call to mnt_user_ns(),
in the rejected hunk.

--
Andrey Kalachev
Software Engineer,
Swemel


