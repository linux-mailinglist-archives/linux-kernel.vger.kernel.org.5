Return-Path: <linux-kernel+bounces-141551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AD8A1FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2044D1F25F15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403217BA2;
	Thu, 11 Apr 2024 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mJHCzK2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC417756
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865314; cv=none; b=dKtgH27tT74VVsS12Udu/bhuyfoHCt4O9XixxaHbxGQzaV2KU2qdRDwOHmkSk5uv9dNYE5hni+forM3KhnRrhgRZuVh+L+ZzQ4LBWFTggaBQ7LHx5PtJ40ZDpGsEQGNfJ7JjSI9OGHIPrZBRqjfdrhl4bnrh+K+xJ6WSKvvQHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865314; c=relaxed/simple;
	bh=nDyyUET79lhvJ2d6vwJw1c9rZYZ1SDMzb3E3qhz+QvA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F1HANkpCZFuYI8Tjesn/zDuZZ1sLRyHKX9QA7NFnwLPhZG16J+UkAThsC2NhcBiGeK5H7gCaoQmH8Rp3Aa4p5WEQuld6bKnKonlFuDOO3046Yg9wiHFCVjrdaxuUnqGrdl+z7xUoBuMXTiJDAwLlfrNmKww1asu1qcVxA7mSM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mJHCzK2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F3BC072AA;
	Thu, 11 Apr 2024 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712865314;
	bh=nDyyUET79lhvJ2d6vwJw1c9rZYZ1SDMzb3E3qhz+QvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mJHCzK2tV7bsMvJbZVU46I2autk19PyIxys/PH5HDUzHmoYyV7KAD8As6v9c82Acj
	 w+7GpgayuopjxkbPjzJ1w4EHOcNeFSslB1+evBg9JNjudrr+7e+TivGYDZ3RQWaI0z
	 ZehO2wKNdHuZf5a+M7hA0Y1HIb2BxT9xCIQ1Tynk=
Date: Thu, 11 Apr 2024 12:55:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Peter Xu <peterx@redhat.com>
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (2)
Message-Id: <20240411125513.b779991117a4dea92ce77269@linux-foundation.org>
In-Reply-To: <000000000000dce0530615c89210@google.com>
References: <0000000000001a87b90613389171@google.com>
	<000000000000dce0530615c89210@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 19:04:21 -0700 syzbot <syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:

Thanks.

> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14db82bd180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
> dashboard link: https://syzkaller.appspot.com/bug?extid=ddf4b4c0005944105a9e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13111a4d180000

Seems to be userfaultfd related.

> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156ae155180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5134 at arch/x86/include/asm/pgtable.h:404 pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
> WARNING: CPU: 0 PID: 5134 at arch/x86/include/asm/pgtable.h:404 try_to_migrate_one+0x18e9/0x3ae0 mm/rmap.c:2256
> Modules linked in:
> CPU: 0 PID: 5134 Comm: syz-executor306 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
> RIP: 0010:try_to_migrate_one+0x18e9/0x3ae0 mm/rmap.c:2256
> Code: ac ff 41 83 e7 42 bf 40 00 00 00 4c 89 fe e8 9e 74 ac ff 49 83 ff 40 0f 84 91 08 00 00 e8 af 6f ac ff eb 09 e8 a8 6f ac ff 90 <0f> 0b 90 49 83 cd 04 48 8b 3c 24 e8 b7 89 ff ff 89 c3 48 b8 00 00
> RSP: 0018:ffffc9000458f1e0 EFLAGS: 00010293
> RAX: ffffffff81e885a8 RBX: d000000000000000 RCX: ffff8880177a3c00
> RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
> RBP: ffffc9000458f550 R08: ffffffff81e88560 R09: 1ffffd40003c10d8
> R10: dffffc0000000000 R11: fffff940003c10d9 R12: 0000000000000001
> R13: d7ffe7fff0fbc802 R14: 0000000000000002 R15: 000000007821bc67
> FS:  00007f2b2a0666c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2b2a06b9f0 CR3: 0000000023ffe000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  rmap_walk_anon+0x36f/0x680 mm/rmap.c:2599
>  try_to_migrate+0x3de/0x4b0
>  migrate_folio_unmap mm/migrate.c:1244 [inline]
>  migrate_pages_batch+0x10b4/0x3570 mm/migrate.c:1675
>  migrate_pages_sync mm/migrate.c:1841 [inline]
>  migrate_pages+0x1eaf/0x3320 mm/migrate.c:1950
>  do_mbind mm/mempolicy.c:1344 [inline]
>  kernel_mbind mm/mempolicy.c:1486 [inline]
>  __do_sys_mbind mm/mempolicy.c:1560 [inline]
>  __se_sys_mbind+0x11f5/0x1a70 mm/mempolicy.c:1556
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f2b2a0af089
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2b2a066228 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007f2b2a138408 RCX: 00007f2b2a0af089
> RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
> RBP: 00007f2b2a138400 R08: 0000000000000000 R09: 0000000000000002
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2b2a1054f4
> R13: 0000000000000011 R14: 00007ffca01beb70 R15: 00007ffca01bec58
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

