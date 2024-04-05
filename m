Return-Path: <linux-kernel+bounces-132356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB4899383
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467071F23983
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3118E28;
	Fri,  5 Apr 2024 03:00:33 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7117571
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286033; cv=none; b=W5WUiR8EdWV8CojiBLVxXYt6JDKzqEVbbwjsmSfnmIPTN2TI+6uN8hH+xJJiCQxYuX91BK6GSuZFbUT6ieL/wYzw5tcOvWjBxTJhCeJifvET/PGsvahMxazN76L2xiz6MY2jDyFb0my5BBUsxZQz8GXxcIE2SrCLTLMuenxsCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286033; c=relaxed/simple;
	bh=dBC9ABcB8hR7u2fOVE3cZG75xRkZIJlJThpWxc8ApyM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MHrFqwF2u1WpVA3REtMu/ayWgribw6UAM4S6oxj+Yf+RxtOtiUknMNcCC+d1YAg9XqJOYGIORPwuk826m7/vnUAUqQoDiMfk9E+76LTrKh3BPXKvdN41UXIdwMXgtcTvBhylg8/wY23gdZxsyQtMhSIDgcBLgZvlHG670D86OYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36854f4e9b3so16853725ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 20:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712286031; x=1712890831;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Et9RYbyh4ZV/FA+KCXCfJ6QFe4NikVyj9UQ9KZ27q98=;
        b=N0b4J/eTdLWZBviHYqP0mFp9bikY+VgT8T/ycwRsnZ0plS697JbrQspVMXAVGO7tk1
         DbSSxm1orMYYZkdi+ITQUrrRrz6HkwMQf40ixFsQ7sMDHZQ6EA8CUhynRp55YLuAjwy9
         bdV7Vd5qBAivuw1DiUh3FQM+ITUnYu8Pwa8kW6Bsdy16EdEujkGR9VpeSfvOEkJ5h6Yo
         YUvL1VuMUSf/dktM//zLU7s3g3X4ZgL48MWaWio6XsrJ5w0UPG0pcqpMhMhbY7bSJxrQ
         fzhHh6j0OJ4ZxymF4ggxSkdlv+ChIgkXBZA2Lfknf5pk0Hw7sBMC29cxa3caC7ski1td
         gz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOJlzekNlDEfuhKXUfA3jvdgthBOYJlGxhD0Jk7FKNc5SuOvzBNl33WXu48tuzAdbinKIZzMH+MZUBxAD3f3IEUXhRXXpvnR9jnDiD
X-Gm-Message-State: AOJu0Yzhm3uHgXsC3XP5Ta9hcbkJlNqipAeW5snXSF8ROZ+m20fmdS/B
	hZRiJgnlzOiJ+B/r3OIBLdrsoCxTRsPy/8Nmxfw+2QV+xK7hFibi7nrs1Yi8x2QPL4PJObbuBEN
	NSPtLNN0IBG7Gw2pZh1kmYG3Ssrrh5PidsQchmLZkCFJu+ZHyod7Fyig=
X-Google-Smtp-Source: AGHT+IGNlD0PKFvLM7TFVbPPFbmvQG+fupwhhGAVIt6Q7A6gjBzt8mr9vAijqSvguGkjFhwOj4xCMi6EFvmyLlxVY8irSg08MGna
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:368:efa4:be00 with SMTP id
 v6-20020a056e02164600b00368efa4be00mr4334ilu.3.1712286030625; Thu, 04 Apr
 2024 20:00:30 -0700 (PDT)
Date: Thu, 04 Apr 2024 20:00:30 -0700
In-Reply-To: <0000000000002ca935060b5a7682@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c0f98061550a827@google.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
From: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fdccc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9ada62e1dc03fdc41982
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16696223180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5236 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Modules linked in:
CPU: 1 PID: 5236 Comm: kworker/u8:6 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Code: 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 88 e7 9f 06 eb 1a e8 71 d2 b5 fc 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 70 e7 9f 06 90 <0f> 0b 90 48 83 c3 44 48 89 df be 04 00 00 00 e8 db 23 19 fd 48 89
RSP: 0018:ffffc9000905f9e0 EFLAGS: 00010246
RAX: 717a74f119e84f00 RBX: ffff888021ec9e98 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: 0000000000000001
RBP: ffffc9000905fab0 R08: ffffffff92ce55ff R09: 1ffffffff259cabf
R10: dffffc0000000000 R11: fffffbfff259cac0 R12: 1ffff1100df19ef8
R13: dead000000000100 R14: ffff888021ec9ee8 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5c604d35c0 CR3: 0000000029078000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 net_free net/core/net_namespace.c:462 [inline]
 cleanup_net+0xbf3/0xcc0 net/core/net_namespace.c:658
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa02/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

