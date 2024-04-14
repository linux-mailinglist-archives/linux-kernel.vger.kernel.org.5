Return-Path: <linux-kernel+bounces-143991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6898A407C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0251C2103D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507BC1C68F;
	Sun, 14 Apr 2024 06:05:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66417BD2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713074735; cv=none; b=KUpH7ibflD8OnYI7cKGqkjLmXywGc/XWyjTdL3pMlyQmqPDN6DMScekWnN5kYXM/v3d4pWlFZXQ2kE1XDz3HH4VeY56xFRhhMMVfM3emEA951wt/Nx8WFKOpZDOINrsQtkIYMVxtwt3L+H0wClheuHcf0RP51S1AG+JG7fiNMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713074735; c=relaxed/simple;
	bh=zo7Og31338CopKh2R/YOYA5f8mF/P11R4kqcSjOlZKo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WRglQ4HWQ9aI4nzOz14JQ1Ml2t/fur6vplE4pYywicvYnWjyDKpaxwuTw6n1OUOiUwGxL/8mbvojRqRXaOZVZJ2SfV5soOZB5u9mLUJFYkKRg9LPWMlvYUtA+0p7aeod8mBGOtHY1hUJOuhgwl7auz8K+QsijA7ltiWjmGg1Jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a3010f66bso22713765ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713074733; x=1713679533;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0DW2Ac97pJORKunSExiiidYU7ECcnw3EE/tmxmQZ2k=;
        b=olhyxDN2UUj1DQ8NLv5gmB5czNL1wAKu4p3Ah7KI0XZkqmkJ/+SAiyxjO5n3fQZz45
         cJLogs7fqL3iBVwVBLruuUiLujrq7yA+4+8IdmWiBE/kjqD9X4M/nH26E89AmpTAM/IT
         TjCijaUz+x51npL5KsXGuoqwkk5rDebHuCPoAndg4W5d/5tqRfvkrimrmJ7B0wdyAtGm
         rOjLUzRIW5KHLxpRgYr2a+Ywi51Ov+8a6wCpwW5/xV1stwmCDLw7JBo07hpP+igX+/dK
         gr0esZ/XB8l8bxd6O1kEyuFIdhCcEL8N0/oqP1b1hjqkrlXSgkGNUn6SGP2+KWzw2wUO
         BPRg==
X-Forwarded-Encrypted: i=1; AJvYcCX6m4FeKzTtspt8rdZVeb0JTZ/1Mhfn9TdPeN/2i4l7Ds9q8RYV9FsJTZZE5HBar4of0Z+I5s8p8ygNmKTU7wzVV83EwyyJMPQ8zh0g
X-Gm-Message-State: AOJu0YwN8IYUpwiT/fzadj5tml8efHclhv2mOLL25HEJsobJul+eJQSz
	+PIx408Qjx3Ju+DHwqAbxNJw0+ixF1FAGSj3RtgY82UMeJCJj4gT1B72hCpMuKzI2NfNmKPAjaZ
	hZW85UB4oTpaVlXvhewSUqodCY8cy93fExkcfoZWijafDex4KnGzcJ7o=
X-Google-Smtp-Source: AGHT+IFWaJNKWuVSQN6nExZrISaoepdsIfxsfgUuIMYsFfw+Y4uckFPsGI2KYFQFsWKUDo/9fSpCUlr3xy6XTQXjokxixu/fvnAS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d98:b0:36b:147c:f7a9 with SMTP id
 h24-20020a056e021d9800b0036b147cf7a9mr103098ila.2.1713074732813; Sat, 13 Apr
 2024 23:05:32 -0700 (PDT)
Date: Sat, 13 Apr 2024 23:05:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec64cd0616084ae9@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_set_handle
From: syzbot <syzbot+d6282a21a27259b5f7e7@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=138825a1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=d6282a21a27259b5f7e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f3e213180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162d4723180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6282a21a27259b5f7e7@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=8192 which is not allocated.
WARNING: CPU: 0 PID: 5073 at lib/idr.c:525 ida_free+0x370/0x420 lib/idr.c:525
Modules linked in:
CPU: 0 PID: 5073 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci0 hci_rx_work
RIP: 0010:ida_free+0x370/0x420 lib/idr.c:525
Code: 10 42 80 3c 28 00 74 05 e8 8d de 90 f6 48 8b 7c 24 40 4c 89 fe e8 c0 93 17 00 90 48 c7 c7 c0 e6 c6 8c 89 de e8 81 63 f0 f5 90 <0f> 0b 90 90 eb 3d e8 45 8f 2d f6 49 bd 00 00 00 00 00 fc ff df 4d
RSP: 0018:ffffc90003a0f780 EFLAGS: 00010246
RAX: d8e6756074d01200 RBX: 0000000000002000 RCX: ffff888022703c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003a0f880 R08: ffffffff8157cc12 R09: 1ffff92000741e90
R10: dffffc0000000000 R11: fffff52000741e91 R12: ffffc90003a0f7c0
R13: dffffc0000000000 R14: ffff88801fce00a0 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78c634e9c3 CR3: 0000000078b22000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_conn_set_handle+0x193/0x270 net/bluetooth/hci_conn.c:1257
 hci_le_create_big_complete_evt+0x345/0xae0 net/bluetooth/hci_event.c:6924
 hci_event_func net/bluetooth/hci_event.c:7514 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

