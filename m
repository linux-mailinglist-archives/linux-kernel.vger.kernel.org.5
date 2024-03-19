Return-Path: <linux-kernel+bounces-107313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A487FAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA13282CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E307D081;
	Tue, 19 Mar 2024 09:41:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C287D071
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841286; cv=none; b=qENCe/0KqH9DJ+8vCMvnWQU1CiEsUmjxDJrCapqdbF0DqNH2Mjbve9/DC9iLhBK1YIiyO/jTdiF+f6z7kz+yIvKStxjaB+om6PJIngBUOddI4qEzY+Foj23ywXHUNcUZBbV8DnSlJEQ0N94GE5ACma2CjzjXjkhjNQ6uFYtRP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841286; c=relaxed/simple;
	bh=WSRXdaHyR/St2+sEZoOfX/v5Yu+ffUghmEGJ94qqbdM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NEFBQjRlRC5cmd46iFGL3wxv6rpGw8CtHw2elHDwv1mDdyXmFY3nRItfM0LrbK8MYmiuqpdxeNlmE6h7Mh62zJYOe68CVuhVkwg4qiwdvQH/JTJK2jmN4wspvKinOqo1ni92v1/D2mShGta9ZbbcSDvXNC7zBKAbCdjv7tzSshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3684bee9c40so3650915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841284; x=1711446084;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOWak57WiH13JUfOTtx/gvvxfJdemGXy/XxXWhD0h1Y=;
        b=TEEQwpL9Dhmp8H8qIwPYOMeo7lC6UZC8DfOIqGISIMUbfwWwUtkm+88JH92ySi3Zl6
         6j0wc5THcHaZBLREA5HHf7yq7Q04409E3LjU+CfHsiSfafUUDH8DzKsFq1jRs5iaksEv
         YNRAu+hHbjD0OM8BLifACerH8sH77nK7CjxhdHC/gfnSCKGjJH2+oI3aO5VyVc9poFyB
         cFYTvUHIv4h6mutMltcftMZH7UXIQF2H1ZnCTK3HeS47xvSz/orJQSLFP8qduye9KqXb
         PO/EGzdjX0KbLvVTX3iS++zmY4689hj17L21y0X04dWsFd7XhueKIrlz8eoT0AJm9Sev
         3IAg==
X-Forwarded-Encrypted: i=1; AJvYcCU92dPK/ixzCpvBYbx4O6OpR9vgoYggU/UJhyTpDRMkSRfvouqShJynLlA5lKto9fE2LYD8gjMvnI5L2hR6bc1nGLXjpzPq8y74+IJH
X-Gm-Message-State: AOJu0YwRErzqFFiLx3V/5XseA9OxsQUPXH5SZsfLYmkRWWQZ5+fmk5Jc
	WKsWW+ht6j3ADtp/tkl3tam19fodn+ANXiKVaeCSXe+6FW4FnJQ7yRPRkFzflY6MWPVwGr1k4cd
	NU95JYV9MjXRoePRyJCM2yo8N6Z+9qLrm+Dnt0ZwVvT3sA/JUWVBxzgI=
X-Google-Smtp-Source: AGHT+IHS9PU1oo63iSR4+FyL8Z/4O+lqtHH83DqqKSMZnqDkZX6bQfWJOe6A7Zs1CUxjy2Sx5LkjG3Vtyud+u7j1gI1lggIvW5jf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:366:bbfb:5866 with SMTP id
 j22-20020a056e02219600b00366bbfb5866mr143668ila.3.1710841284084; Tue, 19 Mar
 2024 02:41:24 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:41:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000015b940614004701@google.com>
Subject: [syzbot] [mm?] WARNING: refcount bug in __reset_page_owner
From: syzbot <syzbot+98c1a1753a0731df2dd4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    741e9d668aa5 Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112d3bb9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c6662240382da2
dashboard link: https://syzkaller.appspot.com/bug?extid=98c1a1753a0731df2dd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d6ee31180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1338fc6e180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-741e9d66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d3f3486333c/vmlinux-741e9d66.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41a39292f22a/bzImage-741e9d66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98c1a1753a0731df2dd4@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 0 PID: 42 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Modules linked in:
CPU: 0 PID: 42 Comm: kcompactd0 Not tainted 6.8.0-syzkaller-11339-g741e9d668aa5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Code: 8b e8 17 19 d5 fc 90 0f 0b 90 90 e9 c3 fe ff ff e8 e8 7b 12 fd c6 05 a1 c1 0e 0b 01 90 48 c7 c7 80 75 6e 8b e8 f4 18 d5 fc 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 42 64 6d fd e9 44 fe ff ff
RSP: 0018:ffffc900009a7350 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814fc049
RDX: ffff8880186e2440 RSI: ffffffff814fc056 RDI: 0000000000000001
RBP: ffff8881064ad33c R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881064ad33c
R13: 0000000000000000 R14: 00000000026401ed R15: ffff888016a2c278
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556f261ca8 CR3: 000000000d57a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 dec_stack_record_count mm/page_owner.c:215 [inline]
 __reset_page_owner+0x2ea/0x370 mm/page_owner.c:253
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 __folio_put_small mm/swap.c:119 [inline]
 __folio_put+0x166/0x1f0 mm/swap.c:142
 folio_put include/linux/mm.h:1506 [inline]
 migrate_folio_done+0x27a/0x320 mm/migrate.c:1106
 migrate_folio_move mm/migrate.c:1329 [inline]
 migrate_pages_batch+0x18a4/0x2c60 mm/migrate.c:1778
 migrate_pages_sync mm/migrate.c:1844 [inline]
 migrate_pages+0x1b9f/0x2840 mm/migrate.c:1953
 compact_zone+0x1f68/0x41c0 mm/compaction.c:2659
 compact_node+0x1a2/0x2d0 mm/compaction.c:2923
 kcompactd+0x73c/0xdb0 mm/compaction.c:3221
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

