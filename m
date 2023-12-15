Return-Path: <linux-kernel+bounces-412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235788140B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560451C22235
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473B153BA;
	Fri, 15 Dec 2023 03:40:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148F5382
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b705896cb2so31145939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702611606; x=1703216406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSaIQIqd/QORZpsZ+d2cPowFJAK+J3HlcmHirpV0cAU=;
        b=qhyv3RIk86nmoKaJn+F861pkJjw0adNEF0JSc7rkHVs5nEb80TQ8RgAqfzgme79izC
         u6mO6RIeI7ZktqupGkOxL1IE/uGG+BZkp1GiaUFVzfqxScgUMl0rMpqjGvQBslr4kNDI
         U7LXnM+Mu909w0xaX7bijyF2VGqIWLWiLuJdQmGj7RUCB+1tTdwTDAgIXrEdD0c0MGa8
         Og/KUJwECWYieXZRMMUIrIpfSZX9l/T3WEUlM4kKsHLseAw9p75xUJlPAsPteiWsTxvH
         oIF/Fgo7I91cHDk/D77nqRZVJvYyYT/Msm6A+RTv7HXh/yUCpEgeHwbD3zNAD+H8h2wT
         8zBw==
X-Gm-Message-State: AOJu0Yy78aZbZcqjqbUksfGzq7fsUIfIaHyQ3htXhfa0PHIukhKYvAgY
	BJ1XyTLSBB4wUev+t9s2upT7cNCMrVch1Pw3FDtQHd/ZTgUx
X-Google-Smtp-Source: AGHT+IH4JwyJhFFiUsemXh4HaSS/lredyHFtd6Y/oj5kEemJocz6qJ5lvyQ0kkn35x/pfNvf/i/6IqtJkifIm6TehfR0ZYVYqDUK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1445:b0:463:faca:4c48 with SMTP id
 l5-20020a056638144500b00463faca4c48mr219497jad.4.1702611606795; Thu, 14 Dec
 2023 19:40:06 -0800 (PST)
Date: Thu, 14 Dec 2023 19:40:06 -0800
In-Reply-To: <tencent_B483AC64585766776E66C9B36FA36A496905@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000037b48060c8428ff@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_do_writepages

------------[ cut here ]------------
kernel BUG at fs/ext4/inode.c:2587!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10 Comm: kworker/u4:0 Not tainted 6.4.0-rc3-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:ext4_do_writepages+0x27a1/0x34a0 fs/ext4/inode.c:2587
Code: fc ff df 44 89 64 24 18 48 c1 ea 03 80 3c 02 00 0f 84 bc ed ff ff 48 8b 7c 24 08 e8 19 aa a8 ff e9 ad ed ff ff e8 bf 2f 55 ff <0f> 0b e8 b8 2f 55 ff 48 8b 84 24 b0 00 00 00 48 8d 78 40 48 b8 00
RSP: 0018:ffffc900000f73e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880684f6e50 RCX: 0000000000000000
RDX: ffff888016649dc0 RSI: ffffffff82306c91 RDI: 0000000000000007
RBP: ffffc900000f75f0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807e006678 R14: ffff8880684f70b0 R15: 7fffffffffffffff
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f07671c7650 CR3: 000000002a381000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ext4_writepages+0x30b/0x780 fs/ext4/inode.c:2792
 do_writepages+0x1b4/0x690 mm/page-writeback.c:2551
 __writeback_single_inode+0x158/0xe70 fs/fs-writeback.c:1603
 writeback_sb_inodes+0x599/0x1010 fs/fs-writeback.c:1894
 wb_writeback+0x2ca/0xa90 fs/fs-writeback.c:2068
 wb_do_writeback fs/fs-writeback.c:2211 [inline]
 wb_workfn+0x29c/0xfd0 fs/fs-writeback.c:2251
 process_one_work+0x9f9/0x15f0 kernel/workqueue.c:2405
 worker_thread+0x687/0x1110 kernel/workqueue.c:2552
 kthread+0x33a/0x430 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_do_writepages+0x27a1/0x34a0 fs/ext4/inode.c:2587
Code: fc ff df 44 89 64 24 18 48 c1 ea 03 80 3c 02 00 0f 84 bc ed ff ff 48 8b 7c 24 08 e8 19 aa a8 ff e9 ad ed ff ff e8 bf 2f 55 ff <0f> 0b e8 b8 2f 55 ff 48 8b 84 24 b0 00 00 00 48 8d 78 40 48 b8 00
RSP: 0018:ffffc900000f73e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880684f6e50 RCX: 0000000000000000
RDX: ffff888016649dc0 RSI: ffffffff82306c91 RDI: 0000000000000007
RBP: ffffc900000f75f0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807e006678 R14: ffff8880684f70b0 R15: 7fffffffffffffff
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f07671c7650 CR3: 0000000029b19000 CR4: 0000000000350ee0


Tested on:

commit:         44c026a7 Linux 6.4-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135a5e3ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2045748b9f1055b
dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100bda1ee80000


