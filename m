Return-Path: <linux-kernel+bounces-107397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A0387FBED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA4DB21265
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B154FAB;
	Tue, 19 Mar 2024 10:43:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA441A84
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845002; cv=none; b=EQ8uguJ8ztYkXNrUw7ftg+mCXQ7Apj5XlzJvf9a4YwKHYNuxku+kdnIfE3j8qDONwHwi3OuoECWohLyNsgh14djcB0TEC/tIIZT9TelXomoNNG8qTE2LtbBHTyRIZqRkRbsVx7f5Ma7WENVDsO1aynzcrmyzNfJn9bOTQy4M8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845002; c=relaxed/simple;
	bh=KEvwK3FZ75m8ViZqhvcuO9hNN5olmcN1JO+qykOdRF0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VsQrdyqkE3otCH9efbQcY5+bEpKV42ebBb4NEgUWbMQUhqW6Xq5IZVBtVZrFUF2q1wfAT9B55m0ZAtTLEH1BMP0PT18VDRC1+HB6XgvVkz1A+Q7dipSsvHDtHnsc7HXL2SGqwbY1kbUk2s2Q3InDlmiUJTKZ2Fl3GtDYIs8YRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366ada2afc6so24960235ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845000; x=1711449800;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OeVsPuv+CZE/bTdlMOnlT0/1/ZQ1LjWfe1SAd129Jw=;
        b=e7Q+16IWrZMG41r6cMArk17DEbtQ7cffZllaKh4Kwu2dX6o614akGL//cyHd9gEmsL
         H5BAKbirZUPtPBOB/8YmoELq2n0mTVtF1NzY5FSKDvtfj1Q4Y+enuZT24Yd6dnaXwB3p
         mMQZRD0+4znk5cwF9jiCKG2H+pvXfPkFmZx020UXqaHgFfmuVwBudKmdtBzyZc2JxMg9
         lHUI7SeMt3G0DvkaX0jyuGy+qpXDcePc6xFlRETVkpCz4HUfp0OpOB3BFXfewtRxcwpY
         sZKRprKDGbfouu0TJ9QoHRHgBs6Xku7sR0DMRU63CcYfkZwnZt9VGtd18VXvzguE2Y7y
         ytxg==
X-Forwarded-Encrypted: i=1; AJvYcCU58bzQik/2Ex3g5kh1pTJkCGChmgZ1h8bQv3M7TzllBDBpxtU9REvsEkuJ008xQP6U5ZR5ElXg3SKM+/kL5xF1pbWS/ORN/5BN+uFU
X-Gm-Message-State: AOJu0Yze/ApjKp7qO6zvHg82QirWcJCLJ8A3ZdMGA7eqgqKhC7t/BQrj
	ngqI8ZRYSCYtrxS2mnlfbKmEb/yXsOMpP0mQwS+smD0TrIYOX1W4+sCBwONedIlHYS1pYxFNTOx
	kf7rpbZ+K5aJ/j+eu7Mlhid6iAZz5Ko2FIEEP+3OLYwYAKur+U+t2iFA=
X-Google-Smtp-Source: AGHT+IFieZWoSWqDXStP49Kfvzjp2M5RFxMREJJu5yAAKHNb/02dbn/k4FPWfYCyZFRM//t06gvrnMdW+ABdCPFmVUSOrPXe7RKk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c561:0:b0:363:de50:f7b5 with SMTP id
 b1-20020a92c561000000b00363de50f7b5mr483100ilj.2.1710845000010; Tue, 19 Mar
 2024 03:43:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:43:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007de0cf06140124c0@google.com>
Subject: [syzbot] [mm?] WARNING in unmap_page_range (3)
From: syzbot <syzbot+e145145f0c83d4deb8fa@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lstoakes@gmail.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1383c6c9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ffb854606e658d
dashboard link: https://syzkaller.appspot.com/bug?extid=e145145f0c83d4deb8fa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14583abe180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14298231180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e5eb28f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5c7ad05d6b2/vmlinux-e5eb28f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/531cb1917612/bzImage-e5eb28f6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e145145f0c83d4deb8fa@syzkaller.appspotmail.com

WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_present_ptes mm/memory.c:1539 [inline]
WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_pte_range mm/memory.c:1603 [inline]
WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_pmd_range mm/memory.c:1720 [inline]
WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_pud_range mm/memory.c:1749 [inline]
WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_p4d_range mm/memory.c:1770 [inline]
WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 unmap_page_range+0x2a54/0x3bf0 mm/memory.c:1791
Modules linked in:
CPU: 2 PID: 5169 Comm: syz-executor144 Not tainted 6.8.0-syzkaller-09791-ge5eb28f6d1af #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:zap_present_ptes mm/memory.c:1539 [inline]
RIP: 0010:zap_pte_range mm/memory.c:1603 [inline]
RIP: 0010:zap_pmd_range mm/memory.c:1720 [inline]
RIP: 0010:zap_pud_range mm/memory.c:1749 [inline]
RIP: 0010:zap_p4d_range mm/memory.c:1770 [inline]
RIP: 0010:unmap_page_range+0x2a54/0x3bf0 mm/memory.c:1791
Code: e8 a1 c3 16 00 e9 23 e4 ff ff e8 b7 d8 bb ff 48 8b bc 24 c0 00 00 00 4c 89 ee e8 c7 db 21 00 e9 77 fb ff ff e8 9d d8 bb ff 90 <0f> 0b 90 e9 93 f6 ff ff e8 8f d8 bb ff 48 8b bc 24 c0 00 00 00 48
RSP: 0018:ffffc900033578c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888024b5f200 RCX: ffffffff81d11e76
RDX: ffff888024178000 RSI: ffffffff81d127e3 RDI: 0000000000000007
RBP: 0000000000001000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000003 R12: 0000000020123000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88802525a910
FS:  0000000000000000(0000) GS:ffff88806b400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557eb0678 CR3: 0000000025dae000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unmap_single_vma+0x194/0x2b0 mm/memory.c:1837
 unmap_vmas+0x22f/0x490 mm/memory.c:1881
 exit_mmap+0x1c1/0xb60 mm/mmap.c:3267
 __mmput+0x12a/0x4d0 kernel/fork.c:1345
 mmput+0x62/0x70 kernel/fork.c:1367
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x999/0x2be0 kernel/exit.c:865
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f61f6f6ad39
Code: Unable to access opcode bytes at 0x7f61f6f6ad0f.
RSP: 002b:00007fffa3593cd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f61f6f6ad39
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f61f6fe5270 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f61f6fe5270
R13: 0000000000000000 R14: 00007f61f6fe5cc0 R15: 00007f61f6f3cb10
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

