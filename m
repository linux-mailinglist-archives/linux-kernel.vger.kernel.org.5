Return-Path: <linux-kernel+bounces-50887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA7847FDF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6555E1F26439
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DD882A;
	Sat,  3 Feb 2024 03:17:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7779F6
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706930226; cv=none; b=o0JhyUfCU+jrk+70Cg2IA2C/l4AkU5bmE6WJI2SPEsTiVaW/dMgMmxnfmchijwVlNO0GWD2dezCA5Xy1jisXGOc2qdkStp+dzTGAoBqbT8j5CE4NczpPS4QfVy5geWXeQpW40B/XMKWHEh2o5nBfCzCDnKv17asMIFvqP9x+SJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706930226; c=relaxed/simple;
	bh=jwJmHO8AF1L55Qt/KwDLQiADwV2RI1A8ndQZbR3qzLg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aQ0wlXcS8j2+rqj141YKDOFjO3fzVd+xXlQnAx0bC6WLm8I4vuN3kr3YgiYzXCOvu5DZivYxxZzrr9HmByHbz7AlrbRFuPY22C1RDEk6ydwYsW2mAKHNIfuawG3eWfNBIEqe5YcGMVXNHh0lINGQDpOSwNJulMLhuMvmYwtcyKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so283993539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 19:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706930224; x=1707535024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ/tUjPnpY1zBbNk3QzesCWC9N7UAYa4BV/oO7wNT5M=;
        b=H4yQHg5B1vXgPh0Lf+v1ENyte2i3ay9p1tW/Wf2hBrCwLtI7FKr6thfcKe2VcrhrvR
         pWe5E6GXlCPL+toPeW7dYFBoF36gQXCqspSyxXb+hjyoGMDc7LScQHlC9pjJvrnTOsdR
         mJsWaym02KYOo9sehSCabdI3EpIfVYSw+U/iebqkEztW9QdrTwp7h30QlDtYQdXewcCb
         uU0XTEPId4Mj52isEpvJVS9stFnaRQ3FaTmqfub94kuYSmyNnK2I0jkDYkN9tqN4bM79
         HLubXtZiMPBQwH2jv9EhdZ0V3fQlAbkieu/66uZH34Lw/6xQbyLKhI0M4AdHZ6ngaW6t
         EHYg==
X-Gm-Message-State: AOJu0YwTeUe7L+hi2tKdYD5+2zQKgG7zdT2gd6Mf0+Ua2FR2f0QcAljL
	ckPpGF+1RMdZA2Qa3leEc76Ia+3sAB3tdZ0QS4C7Raq1moyIWuyLXleNjmeZque6ss8GmSUBlzt
	EsV+U6kFxTDpJ+hTw07+ug8H1u3L7f00i1KbNgHBvjKjgC6YO/dixQeg=
X-Google-Smtp-Source: AGHT+IHzj5OCJZNbiQWYvWDMH3I5msmMGkwpzsyl6A3wZV9HzxIK60DoV1RlNmykg2xi5mGzIPuKkp2yOJygxWnlNAeq0jm8Te0t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:b8e:b0:470:aae7:5dda with SMTP id
 b14-20020a0566380b8e00b00470aae75ddamr118567jad.6.1706930224031; Fri, 02 Feb
 2024 19:17:04 -0800 (PST)
Date: Fri, 02 Feb 2024 19:17:04 -0800
In-Reply-To: <20240203004122.1625-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8eeb4061071a9f6@google.com>
Subject: Re: [syzbot] [net?] WARNING in __unix_gc
From: syzbot <syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __unix_gc

------------[ cut here ]------------
WARNING: CPU: 1 PID: 11 at net/unix/garbage.c:350 __unix_gc+0xe90/0xec0 net/unix/garbage.c:350
Modules linked in:
CPU: 1 PID: 11 Comm: kworker/u4:0 Not tainted 6.8.0-rc2-syzkaller-g73c59d6fe109-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound __unix_gc
RIP: 0010:__unix_gc+0xe90/0xec0 net/unix/garbage.c:350
Code: 8b 04 25 28 00 00 00 48 3b 84 24 20 01 00 00 75 40 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 31 9a 8b f7 90 <0f> 0b 90 eb 8e 48 8b 4c 24 08 80 e1 07 80 c1 03 38 c1 0f 8c e4 fb
RSP: 0018:ffffc90000107a80 EFLAGS: 00010293
RAX: ffffffff8a07bc2f RBX: 0000000000000000 RCX: ffff8880172ebb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000107bf0 R08: ffffffff8a07bbb3 R09: fffff52000020f40
R10: dffffc0000000000 R11: fffff52000020f40 R12: 1ffff92000020f5e
R13: ffffc90000107ae0 R14: ffffc90000107ae0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f83579e65e8 CR3: 000000000df34000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x973/0x14b0 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         73c59d6f Merge branch 'net-sched-load-modules-via-alias'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14fdf6ffe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2ad00c8608f36a5
dashboard link: https://syzkaller.appspot.com/bug?extid=fa3ef895554bdbfd1183
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1384e09fe80000


