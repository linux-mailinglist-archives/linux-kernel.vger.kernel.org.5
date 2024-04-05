Return-Path: <linux-kernel+bounces-133452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BF89A3E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0656828926B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675C172782;
	Fri,  5 Apr 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U7Qk3/eF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66F17277A;
	Fri,  5 Apr 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340581; cv=none; b=OhWDG9iFPNf65HesOZMmw1x2lTK3MJdKDKteAOm7dIBawrk0hiBwW5e89kX7t2s3BFAPsERtLpJMW/JcQUMj11oJbbvUsShW3kjr1HlfOs/m9BDmQSKXwOV4hgHZQaF+QbsThNLGAHDfrqJPveEZYkk+1ZLiCkyrvYcb1T9WEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340581; c=relaxed/simple;
	bh=XEHM2bscJ15DcdykoH5CPf8wc/c3cOkcZOvvQc5/ays=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vych5CFis3tUw6rtJig/Ix1kgL3ElbYljrN/JDyQ96tVsTuNOQqToYHQ9T55vMvqQGchzwv/TtOApmq1C2ynIRlDcovQZw/nqDzqJ7sHvq6qfNbMPfjun8n7eJfrMtT7ly9g3aEt+VtLbaqEagTQXq44UEynK3KmVBMKAjsHDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U7Qk3/eF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE36C43394;
	Fri,  5 Apr 2024 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712340581;
	bh=XEHM2bscJ15DcdykoH5CPf8wc/c3cOkcZOvvQc5/ays=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U7Qk3/eF8troLYxOnlAkKqT5spZJXknJ4Kdz0KmA5i3nJCXaiL64ZWV+P7fkSqwCV
	 uhe7F58Wd1bl46TTfl9KmywmUlMhxxsc59/t8RpPqOAwOyO6PI6txR20+3bTq8IjDR
	 ncECEXJGZY2zrDFrPlRY8k3RlDiBFo26mF3TnUvY=
Date: Fri, 5 Apr 2024 11:09:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+4372e026c95b0e36d0ee@syzkaller.appspotmail.com>
Cc: gustavoars@kernel.org, keescook@chromium.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, Aneesh Kumar
 <aneesh.kumar@kernel.org>
Subject: Re: [syzbot] [mm?] [hardening?] BUG: bad usercopy in do_handle_open
Message-Id: <20240405110940.e787791b7d53aff7f216a168@linux-foundation.org>
In-Reply-To: <000000000000b8974d06155cf3a2@google.com>
References: <000000000000b8974d06155cf3a2@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Apr 2024 10:40:30 -0700 syzbot <syzbot+4372e026c95b0e36d0ee@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13a5c3b1180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=4372e026c95b0e36d0ee
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ed9d29180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161ab3c6180000

I'd be suspecting the bounds checking in handle_to_path(), but it looks
solid to me.

> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4372e026c95b0e36d0ee@syzkaller.appspotmail.com
> 
> usercopy: Kernel memory overwrite attempt detected to SLUB object 'kmalloc-16' (offset 8, size 9)!

We tried to copy 9 bytes into the f_handle[] array.

But from my reading of the reproducer, f_handle.handle_bytes was set to 1.

Aneesh, any thoughts on this?


> ------------[ cut here ]------------
> kernel BUG at mm/usercopy.c:102!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 5081 Comm: syz-executor249 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
> Code: 49 89 ce 48 c7 c3 e0 27 d8 8b 48 0f 44 de 48 c7 c7 80 26 d8 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 b1 6f 75 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003dbfd78 EFLAGS: 00010286
> RAX: 0000000000000062 RBX: ffffffff8bd827e0 RCX: 2b2ecef8eabe4800
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 0000000000000008 R08: ffffffff81760b9c R09: 1ffff920007b7f4c
> R10: dffffc0000000000 R11: fffff520007b7f4d R12: ffffea00008fe840
> R13: 0000000000000009 R14: 0000000000000008 R15: 0000000000000009
> FS:  000055556aa78380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000040 CR3: 0000000076e74000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __check_heap_object+0xb1/0x100 mm/slub.c:5461
>  check_heap_object mm/usercopy.c:196 [inline]
>  __check_object_size+0x1e3/0x900 mm/usercopy.c:251
>  check_object_size include/linux/thread_info.h:215 [inline]
>  check_copy_size include/linux/thread_info.h:251 [inline]
>  copy_from_user include/linux/uaccess.h:182 [inline]
>  handle_to_path fs/fhandle.c:203 [inline]
>  do_handle_open+0x1f6/0x660 fs/fhandle.c:226
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> RIP: 0033:0x7f27665352a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe7e4589d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
> RAX: ffffffffffffffda RBX: 00007ffe7e458bb8 RCX: 00007f27665352a9
> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 00000000ffffffff
> RBP: 00007f27665a8610 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffe7e458ba8 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
> Code: 49 89 ce 48 c7 c3 e0 27 d8 8b 48 0f 44 de 48 c7 c7 80 26 d8 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 b1 6f 75 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003dbfd78 EFLAGS: 00010286
> RAX: 0000000000000062 RBX: ffffffff8bd827e0 RCX: 2b2ecef8eabe4800
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 0000000000000008 R08: ffffffff81760b9c R09: 1ffff920007b7f4c
> R10: dffffc0000000000 R11: fffff520007b7f4d R12: ffffea00008fe840
> R13: 0000000000000009 R14: 0000000000000008 R15: 0000000000000009
> FS:  000055556aa78380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000040 CR3: 0000000076e74000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

