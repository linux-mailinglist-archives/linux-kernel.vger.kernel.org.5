Return-Path: <linux-kernel+bounces-91668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CCC8714D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3101C2138D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E43945C06;
	Tue,  5 Mar 2024 04:38:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4794D29CE7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613504; cv=none; b=G24vcf9r5nGO7Yqfam3NEsrDUDCkb/9fB6GQqID2k6NZm7+mJCIl/26T78wx+CUsdXTnXbwbmF8h+/CdrIR82gGlpHxqysy1MFkDmcshJtFmfum6y4YgftkHZw5Tt2LAn4Iuk79DaJ+DPVU74ioZimp4wZROB2Y7KIGvK2+mmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613504; c=relaxed/simple;
	bh=ZzgSUxjd+0JMmSh5H3+cRqdQUNC4JgQpQJPxIdfeCqQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kOO1fGtllqY4L2xx8TEUinzF4r+itPuUolM2B5H6+PPM58fNVN4aYOEO07ZwIIFaORnzGwpMCSMMhHcUkcoJTYvHFjiIUgYf2Fw6C9GSsviYXsHqkrz7Uv5lqqOr9+8JeRRVMVKz0IaNOTngIHLGZowMXc6sU6Bo5pUH+W5gp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36520abf45eso58197195ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 20:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613502; x=1710218302;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QaaKwt8+QUYeabpyFqyQn6fckuTKQ7Ng3UILfLmGeCQ=;
        b=fsrVqmxAuzwLN4IA7h8Hmj1gz6ICiINyuJdFhojl/Oc1sjXLNFfA0y4Px+fk9uKUQF
         Ne239nFicwKvoyjTqC0ubPG+qUGPERC+9Vl6y3MB7KpbY44zWXvoylBAzRQZfcCD14Xd
         NtyFJxKUg/GQHR98yOGMi9rZGY2lsTCOZLNxLGeLZc/6KYX89xj+RTDEemLPrRT/dKxq
         f/0jPgcX9y4CP+Ew0FhtqChFo/UXNKoUxJ9hGtqLJTdlen8IzmIpAFwrVh+yC79x5vX2
         icEKge8Z+/b2mFn80Jxhcs02vwLpOjy7tMcl7DNd6DuIl9+ww9sEKSxspOx3IoJ+iB53
         2WpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAgDB5TqVw6oUatyB5Na4qKsIOI2hulJRp0Q+0fJBPnreXReX9MtWNociGjeljUwI34ACIF1ijXyx+NmnIlZ3ULfZLD3aqLWA2sxkG
X-Gm-Message-State: AOJu0YzHhPlWhs/IalOG2Mn8o8i9TUxrTWcKd9Cg1FwGSHORpulI4KYO
	tiDsKyLU0VuwTCMkszL717IuS7iapDmPPOdb3hggwYTnjxVTdVTV4fUxLQaIPTIkfQmVEeE5t4h
	A937sd5Ra+tBXEKuQkGtjQNeDsD53AIedUL/whuufxwTcJHHb95OtgfA=
X-Google-Smtp-Source: AGHT+IHCgoqg0ZRF/rgkn5/xYp7wXeGBsLO9OUot0yuT0Nh5GLAkzlCPk76lxqQkSFs7z5SgUsAX0VXPvsBG6KzxbH+l9G8HPmuk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:363:d7d2:1ddd with SMTP id
 e6-20020a056e020b2600b00363d7d21dddmr475956ilu.0.1709613502328; Mon, 04 Mar
 2024 20:38:22 -0800 (PST)
Date: Mon, 04 Mar 2024 20:38:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000827c710612e269ff@google.com>
Subject: [syzbot] [mm?] WARNING in try_to_unmap_one
From: syzbot <syzbot+28895085dfb33190ed3c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    87adedeba51a Merge tag 'net-6.8-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15359306180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc48776003e506af
dashboard link: https://syzkaller.appspot.com/bug?extid=28895085dfb33190ed3c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-87adedeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/531f9afd8b25/vmlinux-87adedeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/015cfa882009/bzImage-87adedeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28895085dfb33190ed3c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 109 at arch/x86/include/asm/pgtable.h:404 pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
WARNING: CPU: 1 PID: 109 at arch/x86/include/asm/pgtable.h:404 try_to_unmap_one+0x1a84/0x29b0 mm/rmap.c:1891
Modules linked in:
CPU: 1 PID: 109 Comm: kswapd0 Not tainted 6.8.0-rc6-syzkaller-00120-g87adedeba51a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
RIP: 0010:try_to_unmap_one+0x1a84/0x29b0 mm/rmap.c:1891
Code: e9 d4 00 00 00 e8 8c 72 b4 ff 4d 89 ec 31 ff 41 83 e4 02 4c 89 e6 e8 8b 6d b4 ff 4d 85 e4 0f 84 8b 04 00 00 e8 6d 72 b4 ff 90 <0f> 0b 90 e8 64 72 b4 ff 48 83 cd 04 e9 21 f9 ff ff e8 56 72 b4 ff
RSP: 0018:ffffc90000ddf110 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000021240 RCX: ffffffff81d771e5
RDX: ffff88801ac80000 RSI: ffffffff81d771f3 RDI: 0000000000000007
RBP: 07ffffffffa2e20a R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000004 R12: 0000000000000002
R13: 0000000000849c47 R14: dffffc0000000000 R15: ffff8880118c2f80
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000027f48000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rmap_walk_anon+0x228/0x580 mm/rmap.c:2599
 rmap_walk mm/rmap.c:2676 [inline]
 rmap_walk mm/rmap.c:2671 [inline]
 try_to_unmap+0x174/0x1c0 mm/rmap.c:1956
 shrink_folio_list+0x1cc7/0x3ea0 mm/vmscan.c:1253
 evict_folios+0x6e7/0x1b90 mm/vmscan.c:4521
 try_to_shrink_lruvec+0x638/0xa10 mm/vmscan.c:4726
 shrink_one+0x3f8/0x7b0 mm/vmscan.c:4765
 shrink_many mm/vmscan.c:4828 [inline]
 lru_gen_shrink_node mm/vmscan.c:4929 [inline]
 shrink_node+0x21d0/0x3790 mm/vmscan.c:5888
 kswapd_shrink_node mm/vmscan.c:6693 [inline]
 balance_pgdat+0x9d2/0x1a90 mm/vmscan.c:6883
 kswapd+0x5be/0xc00 mm/vmscan.c:7143
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


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

