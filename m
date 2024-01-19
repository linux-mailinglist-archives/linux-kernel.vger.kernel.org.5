Return-Path: <linux-kernel+bounces-31225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3848832AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C912883A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D05C52F6E;
	Fri, 19 Jan 2024 13:52:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB952F69
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672326; cv=none; b=WzM0zgXSb1eEA1aFz3QOu9xQzW3on0qu+0n0POWmrNzc92YYzS8/pRhYucT8FNX2dhlyb+Vs8T+fI36x4o5I0hY+xvuldCk1LA4l5LUT6DoihT2iCcP+HRi+xazznEUzLwfEzMBB1Zn+dyrNqUF6TOC8G0ZHjgTqP0S4XAj9030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672326; c=relaxed/simple;
	bh=xikusidLJNb7FpSzHvjbnnZmw1X4ind3ULSDEkLqoqk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QChEQUtdufWu0+Nwq321o9Gs0xGzxBqDHS6yRD0aGaNtQRtzaNzvxSTkHiiMkzReSqNZSZ9RQGmBoaR3um3U5Ut4GqJMJTmlVANyDPHNc9ncJs84o7XR0b4lfUnWnbH1ZeHLluhbHsIADBtYO0lyf9um4Y8Vk5NKpWkM9AWTbEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3619253bc80so5438755ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705672324; x=1706277124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4zr6EsijZ2v5lcqJ+hY2On0kHOdDC6DqocBWIzkhbk=;
        b=dlZBUZ1babSIhC07Ylc97iMdiShxKbNs9GOYEkM8LVBKDQZwJLgv7iZFSrnVFPYaQv
         Ksh3JlCURe4IyRAwW460VJlMtqfei4sdSakvhIVGBSE+cTndYp8OzsPyEpPNu0w/X6zu
         Q68mF9/1T8NKYLaC8qcWufzPUEfP8vbmB8LQ1/+FOWyyl9TpTTx0D7m4CdKeYVamYmHW
         bhGBWfWXAH+MWfd2IdzFHGgH2poVQRIz41KGM6IqQf0Pfk9u6+rfHT761AT7go9KAWv5
         mLqHoc7ZXQKqf2vy2JE4uUbJLXDxq0sCJ3QxJp5Ca/k4lJ/UMWsGM2RrrJzpwQOxg52w
         A42Q==
X-Gm-Message-State: AOJu0Ywy8QZCHMqG9KpvbnI8UYTkkj03WlKlX5WghX1/g7SXqNM5nSiG
	gM4xYCWPuUzLk173uexC5xrQv27VdiPyrhVl1uUUy01UcIOdsYxvhUAgFqXD36ojB0h+zDHZLa/
	fLp79wK3Uzfz5aHgG6IseK7+4D1XiZAlqh8FXjBg+v/0xz60PAMNMHYA=
X-Google-Smtp-Source: AGHT+IHbsk6pRjC7trB+9QtdXSTZmdVGjhF58k+Q7DSzE+w8J/e80xDum1mk+xy2BkhbIAPFNDghipu4ZsV0E88mFlUgTzNHrK4P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b89:b0:35f:d99a:7b1 with SMTP id
 h9-20020a056e021b8900b0035fd99a07b1mr306508ili.0.1705672324383; Fri, 19 Jan
 2024 05:52:04 -0800 (PST)
Date: Fri, 19 Jan 2024 05:52:04 -0800
In-Reply-To: <tencent_A4341BF325BBBA35BBFA336B9E701B144B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff8d43060f4cc8c6@google.com>
Subject: Re: [syzbot] [exfat?] kernel BUG in iov_iter_revert
From: syzbot <syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in iov_iter_revert

------------[ cut here ]------------
kernel BUG at lib/iov_iter.c:582!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5472 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-12377-g9d1694dc91ce-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:iov_iter_revert lib/iov_iter.c:582 [inline]
RIP: 0010:iov_iter_revert+0x328/0x360 lib/iov_iter.c:567
Code: ee 64 78 fd e9 8f fd ff ff e8 44 65 78 fd e9 de fe ff ff e8 1a 65 78 fd eb a2 e8 33 65 78 fd e9 12 fe ff ff e8 29 01 21 fd 90 <0f> 0b e8 21 65 78 fd e9 23 fe ff ff e8 17 65 78 fd e9 64 fe ff ff
RSP: 0018:ffffc9000383f9e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000001bca00 RCX: ffffffff846606e7
RDX: ffff8880293ebb80 RSI: ffffffff84660907 RDI: 0000000000000001
RBP: ffffc9000383fb30 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: fffffffffffffdef R14: 0000000000000000 R15: ffff8880696100b8
FS:  00007f2828b046c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c48c0150f8 CR3: 000000001632c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 exfat_direct_IO+0x310/0x4d0 fs/exfat/inode.c:539
 generic_file_read_iter+0x1dd/0x450 mm/filemap.c:2759
 call_read_iter include/linux/fs.h:2079 [inline]
 aio_read+0x318/0x4d0 fs/aio.c:1597
 __io_submit_one fs/aio.c:1998 [inline]
 io_submit_one+0x1480/0x1de0 fs/aio.c:2047
 __do_sys_io_submit fs/aio.c:2106 [inline]
 __se_sys_io_submit fs/aio.c:2076 [inline]
 __x64_sys_io_submit+0x1c3/0x350 fs/aio.c:2076
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2827e7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2828b040c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f2827fabf80 RCX: 00007f2827e7cda9
RDX: 0000000020000540 RSI: 0000000000003f0a RDI: 00007f2828ae3000
RBP: 00007f2827ec947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2827fabf80 R15: 00007ffe01c6a068
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iov_iter_revert lib/iov_iter.c:582 [inline]
RIP: 0010:iov_iter_revert+0x328/0x360 lib/iov_iter.c:567
Code: ee 64 78 fd e9 8f fd ff ff e8 44 65 78 fd e9 de fe ff ff e8 1a 65 78 fd eb a2 e8 33 65 78 fd e9 12 fe ff ff e8 29 01 21 fd 90 <0f> 0b e8 21 65 78 fd e9 23 fe ff ff e8 17 65 78 fd e9 64 fe ff ff
RSP: 0018:ffffc9000383f9e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000001bca00 RCX: ffffffff846606e7
RDX: ffff8880293ebb80 RSI: ffffffff84660907 RDI: 0000000000000001
RBP: ffffc9000383fb30 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: fffffffffffffdef R14: 0000000000000000 R15: ffff8880696100b8
FS:  00007f2828b046c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc103cff58 CR3: 000000001632c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         9d1694dc Merge tag 'for-6.8/block-2024-01-18' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11f6a1b3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf191e33072146e3
dashboard link: https://syzkaller.appspot.com/bug?extid=fd404f6b03a58e8bc403
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ffb3afe80000


