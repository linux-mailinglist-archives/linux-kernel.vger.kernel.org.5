Return-Path: <linux-kernel+bounces-116546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2574788A090
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9155E1F3A389
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70B1411CE;
	Mon, 25 Mar 2024 07:57:46 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F81411C0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345343; cv=none; b=U1HOS0UAQ1fvovKxoLMKmVujcvSjTTnJY5/WszFzSp2rIsNNbNn0lmS36whVsYhPCxR05gtAARimSLHbTzwjwr6e5dlIYo0qfBt8uDTov1G9PLLFPaxfotj7LF8Gu0YKOb4gA/8F105wOqjx6eAOO9d8kLTAo5SgbHaxLE8AWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345343; c=relaxed/simple;
	bh=/4nJVh8BXUT9Mnb3+dNlJTs2tN4z51MytdA3tu2m8/o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u6N1Wv5pkMFvJnex3kWL3CHtdkdwrWcjMjChdA2YPsaLxiDvP4DzUyPjdBHPJsVOFFR0tHD3n4tX9kqsIHV01uZcffcpLhGn6PNuUigGewuum31+Vtso/9nimKQxAYkJj2XZfAMQ3qudDSce6VKfZ2vgARP6VVNgud1ux2vbkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36898500240so117845ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 22:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711345341; x=1711950141;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVTmcT/pyeAMn0bO0GFfhiTNJqc4nYZ13HYOPYn3OCg=;
        b=mBNw4L8G7aB7TsuCgK7bj09pxYgj8p1SwcsdetXZKqaD1O0RCdKJUuYYOi1ADtAj8+
         jnPvkQKisAk7dJY35clOg2fnNgGjn85dZIG36+XTfk2RMhkToeKtPbyajRb1pYdEX2N9
         b04Ozt6NIcaU9g1gZQcKHQTtGdsIPNYGUpyNZcPmcRUPbrBXViGVfK0t4w+arLr4tjBM
         FrWtF11mDtulNEIQ5bqQ3gyQ8Mjb9qhqdJRDLIY4+HbWB6al5Wc0lyPDsSK3HVheN6T1
         /kINN/lc9V4+OhOoaUv885mBLud0XQfsNjTbftsgPrjqco1shYmWoCBi68tc3v/a/2ke
         qaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmATX3g22uItSUb0J23lkG+IWcbvP/PpLvDGadMctpr5H3bd8OiWTVAKFLXO2C9NR/v1aB0H7j9/K4/rwUg8768tCgzZOQUME1mdTa
X-Gm-Message-State: AOJu0Yy8mp76L1aey2M+uPLUlI4Uw/uG89jPPnJenxOWuXzFZjFoffGl
	z3L1WB9mqXs5SSGJXUjkAqr22gOm8GEJ2Tp4Eyn9ptlbB+66E8htAwC0wAX4cHB0VWFcu0luJ4r
	2TUsEm49QUxK3+LSJU1K90fvUVY6I/WfGqGELweqHfjwHG0xv31IDwtE=
X-Google-Smtp-Source: AGHT+IES5kBl9KoLp4MFyYYJ2lAbxsyJGFJBiMpDLgBelwFj8Y0dl5qIW1U9rT7yxDslp7jr7ysACY2zqbKG/K1QtlR9UrXOIBq1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152c:b0:368:5dd6:25e3 with SMTP id
 i12-20020a056e02152c00b003685dd625e3mr438727ilu.5.1711345341223; Sun, 24 Mar
 2024 22:42:21 -0700 (PDT)
Date: Sun, 24 Mar 2024 22:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026e662061475a373@google.com>
Subject: [syzbot] [mm?] kernel BUG in PageHuge
From: syzbot <syzbot+adb570fc6161d33edb01@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=155105be180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=adb570fc6161d33edb01
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adb570fc6161d33edb01@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:314!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 12282 Comm: syz-executor.2 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : folio_flags include/linux/page-flags.h:314 [inline]
pc : folio_test_hugetlb include/linux/page-flags.h:849 [inline]
pc : PageHuge+0x1f8/0x1fc mm/hugetlb.c:2173
lr : folio_flags include/linux/page-flags.h:314 [inline]
lr : folio_test_hugetlb include/linux/page-flags.h:849 [inline]
lr : PageHuge+0x1f8/0x1fc mm/hugetlb.c:2173
sp : ffff800097ca6d00
x29: ffff800097ca6d00 x28: dfff800000000000 x27: fffffdffc318ac00
x26: 00000000000000b0 x25: fffffdffc3188000 x24: 05ffc00000000840
x23: 1fffffbff8631580 x22: 1fffffbff8631581 x21: dfff800000000000
x20: 05ffc00000000000 x19: fffffdffc318ac00 x18: 1fffe000367fff96
x17: ffff80008ec9d000 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1ffff00012f94ce4 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff80009a5da000
x8 : 0000000000040000 x7 : ffff800080297c0c x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800082f248d0
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000166
Call trace:
 folio_flags include/linux/page-flags.h:314 [inline]
 folio_test_hugetlb include/linux/page-flags.h:849 [inline]
 PageHuge+0x1f8/0x1fc mm/hugetlb.c:2173
 isolate_migratepages_block+0x7d8/0x2f9c mm/compaction.c:950
 isolate_migratepages mm/compaction.c:2074 [inline]
 compact_zone+0x26a8/0x4120 mm/compaction.c:2530
 compact_node+0x234/0x3c0 mm/compaction.c:2851
 compact_nodes mm/compaction.c:2864 [inline]
 sysctl_compaction_handler+0x110/0x1d4 mm/compaction.c:2910
 proc_sys_call_handler+0x4cc/0x7cc fs/proc/proc_sysctl.c:595
 proc_sys_write+0x2c/0x3c fs/proc/proc_sysctl.c:621
 call_write_iter include/linux/fs.h:2087 [inline]
 iter_file_splice_write+0x894/0xfc0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0xec/0x1d8 fs/splice.c:1164
 splice_direct_to_actor+0x438/0xa0c fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x1e4/0x304 fs/splice.c:1233
 do_sendfile+0x460/0xb3c fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1356 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __arm64_sys_sendfile64+0x23c/0x3b4 fs/read_write.c:1348
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: f0052f01 912c0021 aa1303e0 97fbce80 (d4210000) 
---[ end trace 0000000000000000 ]---


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

